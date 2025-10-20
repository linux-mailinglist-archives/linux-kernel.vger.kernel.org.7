Return-Path: <linux-kernel+bounces-861832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBE6BF3C23
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472EA482261
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493A730506E;
	Mon, 20 Oct 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdqaA1UZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437461C862E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995794; cv=none; b=GaJrFmhWJF4oJZElB2vyoF7mQi8ttcfo23M94ol9U+oqiovk+9o+3K8c/wYuNkYPA9tRzWoSxLZraDo3UnLaLMknDH28ZGysc6sDByLZyFpiHZcLmsOYkRxEegoiVUn7eh5Dq3cx0KlBLnpvmzydnKoeDi8JGZQdwUCKUadTMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995794; c=relaxed/simple;
	bh=PqlFilZVmSbZKJLHpAkGDW0igOyGGkLNA6FRjPXGD80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFTv9cw4hT3FbDgIM2rBuR7NVlUKEjf4UBJQ/G8TvoD9cciUpeeA4xJ79qdKHqnrAPnJmsfVigLSpBlCtMdC/1t4CVbnUTunIlzONQwy2hvpbOqoTGj8vBpnZnXRUV13cwIuh9Kcn2gq+smoYewepBOgLt6UMrZuSPVntItRA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdqaA1UZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2909448641eso47032745ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760995793; x=1761600593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=26ASe6SsfcfwXN+JG/2GTGw7BHHgM1XlqQIlC1K/NBc=;
        b=jdqaA1UZWsigzRkXK2O8p9ZQRSa+FDJucZvY9vIZ2BoFf1KNt3MbiDs/62NGsrCOg2
         +ji/hFkyfbsmnE0rwdNEtIylVUnKfefBtHhh/6EOYh+9tVd+THKYWhq+fI1ZEbdhro11
         vn2+42low1nO93m0mJkAor0w5myk7GaQ4IXqojE5v1HQQtdFTHB+I8m36E1XFnL4sQyx
         V7/KxdJlCH1CjhJAjvOoNcX7Znw8KNJMeP6CcSL/u8a8C02oO2QqgyH7tjwTNES8KFyU
         irFosAixaTf4Y0zIUR6td7j210oJ3OayDY4HpFL+Ov9ev7xYEHSHa9xxvnRpcw+HhVE2
         hZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995793; x=1761600593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26ASe6SsfcfwXN+JG/2GTGw7BHHgM1XlqQIlC1K/NBc=;
        b=pVPpS22yR71S4qLao54XGQRDH272WmcMZXDLtkd9a8YsdcFgv/zltCNi8kIlN3nOkg
         zo1o+WB1pnwJYz65qDbeft3tLuhn6g3UOk50peYc684I1CvrtU7GOcI117Rs9xp1UdmL
         peOTwTE1P/ByhtvFEDRlC0XFOTs4uRElkUOAFDzYU7al6VH6ZgWAnddkUtaas7k1egMF
         VIIiR6eCY2M3lTiDmP2WlwYH5SMY9/mP/Ad0Aea8oG24l037h55Cwc1z6Tf8ggTR/YpW
         NXJJ0AtKEBcTtli9XqHw6nXw1Vz00CP9/Vs2NkjXeuIfdEs5tqXFE1N7Rn3hKAvSqSw2
         Z82g==
X-Forwarded-Encrypted: i=1; AJvYcCXEbDbtD2f9zkX0jzp8ZKyEfrpwI9hUX18pYaTVmfWezMPQb/slv8h4xfdgpIHvn4vV58JmoyrCma4D+fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2IlQRlOroty9hvvzSrnMzDyQYl3VPHQddJ/FO1/UAGfJGU8z
	cfNWwvsphJSuOgMCA9nIBnK8oqOGFEdKagXR1NDV31p5Z1UQmkunO2Fs0sczwotevg==
X-Gm-Gg: ASbGncs3j8F+t1h4hMZxFqJRUdptZ0umZBxD5k23IyFstdDUDTGw0s64A9SILkjmMf/
	xaeMY/AJxDHwoDwu+RVKs7X9q9SFgYwQfEndYi5e9Kzmk1mgjFrB6aaoOT+pQICXM8T1pExOuNI
	knX3ob9ZimG+NEOex0Jgdh1PRimuf3KQmy9cu89fqQczAd15Ax1/jw20JhB9OUvOK5ezVphjogg
	mC4WnJ9WE0yTNw4uHrkPialaBbZeMuVlSNMmTY5549sp7Hq3ffiWE/8mgVeFjSwbzOf13yfYwsK
	2XA5zJuv6OzvWjAHT05pPk27b3UQQlFE7zJs61kcjqxa6+kDEDFTKPktOFxcxRRdLp4fR5NyC/2
	k8hms8Pb3FqV8HoiGYz6H87f27uZE6/TrA4mb3Ushih4S6hQXd9bxFxOny1zxCdUOTiDSEnJoPX
	H7l0S77Vt0POCbW4b+4DrBphYyzc13u6gffyItyB5I7xXKQw==
X-Google-Smtp-Source: AGHT+IGk4YTNxvDRPlGdzR4t9GlLZJuciLlt+LaOjUUn8d6Qy58ILE26bgum5kvXRpVHjALaky9Cew==
X-Received: by 2002:a17:902:ecc6:b0:249:71f5:4e5a with SMTP id d9443c01a7336-290c76f8182mr169199055ad.26.1760995792362;
        Mon, 20 Oct 2025 14:29:52 -0700 (PDT)
Received: from google.com (96.75.168.34.bc.googleusercontent.com. [34.168.75.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472193dfsm88852855ad.105.2025.10.20.14.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:29:51 -0700 (PDT)
Date: Mon, 20 Oct 2025 21:29:47 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, jgg@ziepe.ca, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 12/21] vfio/pci: Skip clearing bus master on live
 update restored device
Message-ID: <aPapy8nuqO3EETQB@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-13-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-13-vipinsh@google.com>

On 2025-10-17 05:07 PM, Vipin Sharma wrote:

> @@ -167,6 +173,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
>  	 */
>  	filep->f_mapping = device->inode->i_mapping;
>  	*file = filep;
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	guard(mutex)(&device->dev_set->lock);
> +	vdev->liveupdate_restore = ser;

FYI, this causes a build failure for me:

drivers/vfio/pci/vfio_pci_liveupdate.c:381:3: error: cannot jump from this goto statement to its label
  381 |                 goto err_get_registration;
      |                 ^
drivers/vfio/pci/vfio_pci_liveupdate.c:394:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
  394 |         guard(mutex)(&device->dev_set->lock);
      |         ^

It seems you cannot jump past a guard(). Replacing the guard with
lock/unlock fixes it, and so does putting the guard into its own inner
statement.

