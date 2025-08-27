Return-Path: <linux-kernel+bounces-788754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98386B389E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E2D366452
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7192E7BDA;
	Wed, 27 Aug 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbmztxSf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C623262FDC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320908; cv=none; b=q5KhLlS4PQn1x/x9SJTXlJxrYfkFqz5vlDY84HJPWsV1k6DU69t+tGKDLaV1cs4KYly9zGZsa5ku3OOc1f8nkA8PBcPN/krdOKLjJFvLbarCn9mAlW1DGkEpmQF44GZMWy4nuJpxeufrT/o0a3WJupF/k9c4GuU5e6kr3XuVjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320908; c=relaxed/simple;
	bh=ne728g33Ic89OdMPAENBxFjSizIUR3CqOaqTHDpBguk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSYVpbznCe/Whn5Iiw0f25gzhp/ZytNrxprWL3p3L6Z5FJqherfuVjrTrwpHuirK4Ocl3kPadNAcghCPQgBoNanZ8v+d6Fdxu2p5KfV8NNfOHgP4IsxUhooo9b/zmW1Nu+8TArjM9I3gaBsRB9iY/UOra0uJzoKSRCxiy5EHYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbmztxSf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756320906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eF3DTjEsZLVirufoG8QRMws1dk+QuLId/jBJE6DkJbg=;
	b=WbmztxSfdZE2yfRqWwNL6gNAqOpnwlvAHZuzXKCx7b94LCZlQJGVb6FSlkYtg8PGKAhoFi
	51lb2xg0vDtR1pVVB0YgwM4YwUginWDdrHAx1th4SXbqCnkLTm5OGBHMH83QCWqSFa5GQg
	Y0GGPnHDiWTehTIAkYaLD6Z8E0gkqFY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-usUuLePXP0W4M-harUTt3A-1; Wed, 27 Aug 2025 14:55:03 -0400
X-MC-Unique: usUuLePXP0W4M-harUTt3A-1
X-Mimecast-MFC-AGG-ID: usUuLePXP0W4M-harUTt3A_1756320902
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ea4d2f503cso393555ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756320902; x=1756925702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF3DTjEsZLVirufoG8QRMws1dk+QuLId/jBJE6DkJbg=;
        b=oMuv/AmMf1o5Deor9LQBbj5Dyx+/0Wd1qMueosaIpMzPdNka0EQb7MkZTXB4LpeLJF
         XKesy03xmcAC3GX3GgWYEsZ7MAIg66Og90ZqHhgxOPOU8mzzAZbkMLAUfD7V4t+OD2lJ
         d9oAjp5NxfV6oDn6ue/DRGEQ4XjITX9IysEGtZrL1d0A1+mhHqJAbtZ2khrxJjuV2vn1
         +q2uYuH5mkA3B1HvD4LTQdW+w66tcx+lsDNM7dXl+SUsjLxFBEoN1hc56ClIQJgQ3DZo
         d7mCdDMrcNV5dk5tjn3AzKhEmBN/IP4eDn5bJR0YB6l6mpDrnEocIvjXhDcdLXOenWGW
         SEQA==
X-Forwarded-Encrypted: i=1; AJvYcCVrf2Ve/YQylZcrHssV5e7tP9AOs5t3w7bybLAnB++eJMvkFQXLVZX5X2FHr8StesZaKANMnNXBxJRbAzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMfdW9MaCkMLgoh+vR+OmMcus52c+Zsz7EQizepatbON7CDYh
	vXyvb5og8v5QxHeSua+4TPQVi1OhJd5E2OHCRxtIUnTo5/kPjiQHpLw8Is1yplpZjKHMY4h0Zpz
	/hIXJcuDRhS5GrUV3BBraBcwlCaVPLuPxlA3GMISCt11oFYUYKjieViZJx1p9O89dfQ==
X-Gm-Gg: ASbGncvf4vCMbmixcmvJNaoF7FCjJoMmv7XS11Zpi+QVh3wvCFZGhW3YEQPEGe1UhzI
	Mosw51ye3kyvf2fNJROdIcEj5/HoT1qoI3J9i0bdW4o2V1Tde5NZuOJ3b8pRBpdMm7cqQaowPOq
	jm9H6UqUeP0Y4nu6Dlots6wNZeBljAxdYJxFHzo1sciFYSjyB0Q/an1L6oq2SD2qwJR280B6E1I
	aXjEGf24nkAfQfCyHyc4bzbjXnGAk7mR/wlRj0CsaVJNKtD8r6wcm9B+imUjnTE58j8gIM5PJBN
	GbgqvmmqxifO2do/umP+SdaNepVeeopQgoYdFBH1FLg=
X-Received: by 2002:a05:6602:140f:b0:87c:469c:bcdf with SMTP id ca18e2360f4ac-886bd26223amr1074676139f.5.1756320902470;
        Wed, 27 Aug 2025 11:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcn4XXONhUn8JvBftE3ZsZrBNhr3WQ7ZVNO9SR8mW/jmt3C0qMFBX2Cm9qP6Uy+O7yYpbTWA==
X-Received: by 2002:a05:6602:140f:b0:87c:469c:bcdf with SMTP id ca18e2360f4ac-886bd26223amr1074674039f.5.1756320902025;
        Wed, 27 Aug 2025 11:55:02 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886cf7a8c45sm722969439f.15.2025.08.27.11.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:55:00 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:54:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alex Mastro <amastro@fb.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, Keith
 Busch <kbusch@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>
Subject: Re: [PATCH v4] vfio/pci: print vfio-device syspath to fdinfo
Message-ID: <20250827125458.6bc70a1d.alex.williamson@redhat.com>
In-Reply-To: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
References: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Aug 2025 12:44:31 -0700
Alex Mastro <amastro@fb.com> wrote:

> Print the PCI device syspath to a vfio device's fdinfo. This enables tools
> to query which device is associated with a given vfio device fd.
> 
> This results in output like below:
> 
> $ cat /proc/"$SOME_PID"/fdinfo/"$VFIO_FD" | grep vfio
> vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
> Changes in v4:
> - Remove changes to vfio.h
> - Link to v3: https://lore.kernel.org/r/20250801-show-fdinfo-v3-1-165dfcab89b9@fb.com

Applied to vfio next branch for v6.18.  Thanks,

Alex


