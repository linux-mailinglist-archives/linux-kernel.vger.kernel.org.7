Return-Path: <linux-kernel+bounces-836647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20750BAA38F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A69F19237A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0A219A7A;
	Mon, 29 Sep 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RvKAuoui"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0C273F9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167991; cv=none; b=QFbnYqgEf+xve1vIHPBEDc8KhVY1G55OiwTJSVmVZItAspddsvArxN+y6llsNhAWjm+ZTptfxCOj8HhqHs/0PSQ6wAp5Muk1XMfaKAnqOoavOi1vkVcRiMHcy7QpkdVU/GIGRVrFKg/14IBbbxevJ49mnrnk7w7A10C5tHk5kH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167991; c=relaxed/simple;
	bh=H3LBXvT182wT0ex9LDutokYOCnXgq0ndAm+2Ud0WjYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/Pg4Yz+A6J4XHdyDFj51PETs01nxo1ETe6ZLSjUwIbfpA/G8hPcb0iZLwp/grdrolopaVUe7k3fOwJkc6Iqqpe+JC0pAByH9u+GxFbdFtfdXBxgdG4nbLQZhXYC/qAHEJQgPK8YTGqNLVsTMaqh/Uii2FK/i7e8JVt1fGAml10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RvKAuoui; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4df0467b510so31456911cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759167989; x=1759772789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekGW8DgI6WebvQt3SE7n7wwqZhBDCV4b8cIcqpBzX1Y=;
        b=RvKAuouiVKvoTWmTAMSZtSVx9QKL7nNS3k9xg+Nt/I7ZRwsXKgnChnDj0JcnrriSlr
         4WQlkNHQbm6ENBK9ovjtLK9BBgHj46JDfkVThVbTd/+lSb1t0AMQgowhpjncrV3tIFKc
         VJ8v8e6k+gHAcuzDPRlEl03It8IwWeH9YQxnIKxOPY/Zl3FISCC1nV/rl2ZbY8CoBgJG
         T0zuqpUH0LQhztGU2qISPn4mK7S9RDvzhSj7SVX/ILOgrtD+6kbfElI5VQxsD3D2m2Vb
         SUJkW5VX/5MrqzssD/xdDIHvdqTMa4VdqTezM5kQ3qb/XfI8jpSBciUyfJa9kkYakDyz
         ha1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167989; x=1759772789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekGW8DgI6WebvQt3SE7n7wwqZhBDCV4b8cIcqpBzX1Y=;
        b=uOpCbzjjP1Gq951m6jtK2FskaFjrDzgT5tRYEKhQ817kumdLRhh4zx4pmFVuHa0+/L
         MM1ashXGDrOCWouqMmgp+Fw3N8dS+8O6pqzn194Lxzrh3WAvTC7+MDJ5r1ggnGUZ0dXP
         qUjizBoP9jnkbC0GboUpj328/LLY0IDQhLN1PAZahGF6CqA6DGSZ7XjAW4PtzRE960bV
         VvlcPBtuqd+k2X/gTgZ3XsZpKDrAUYo3F3hIhlgC4tAXL4t5SWUA3bJe4rY2xozg3Nb5
         x/9JzEmgpfAW6imGnOZw/TP1wSZmCB+pluXc2fNqrrhUuyVCnoPoMgGi69EQEpfkHWT/
         TTUA==
X-Forwarded-Encrypted: i=1; AJvYcCWpq5uv9hR8KPeLw74Y+uHLJIuItxLevcv+06qhnj/nBV5bUwrFJUpHf3Vqh+BHJZt2F1mLBWmphkLLG10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIv6fpE6s75mHkH6bAtHnXnR5vDzPzCyjOFEbgFSdeDdq7QHt1
	OJ/5mtMI8nYfbV+ItAGQYsTFiTHnFpIOsvvF+lwOQywZbEucMYgeLYONuEidc4FLAWw=
X-Gm-Gg: ASbGncv3D8RRw4GoIM2Hyz3h2tfCceAoFb8qeQtCmoZd+WTBMWOQ11xxzKhgFw5kVaD
	p+QpjR5YiuSWZN8C4aFSqAn410eO/J9Wkcs7bF12fcZnXZDvtEazHdrvOSGlV/YWPyybT3pc8Jp
	eVO/RhQaqpULZyuFgFM8N5Vqr6TPCpmsYEvXuH8oaQIDJX7qhOfdMvAKcIIMUtXC9C14CPyadQU
	wnYLrVPFF9qL66LxBKqGiJAZVqeD6Y5Mrcm4OFg/XZzP0f23dS6CVu95aspM0iAO5ye3L95NN80
	qRp68/rK051nfSKHRun1/2KCXmByeO/NjsPHM2zZkC2wm6gvyVCwF8iRaRKgzR9O3TFLBLxDiow
	IMVD2q+k=
X-Google-Smtp-Source: AGHT+IGV5bd0OxOxeha94oMHGR7r6z2JQMG5YvjTqqBPp/nfSpSoj6eA3rdVJdGjuygNySyB8mMM0w==
X-Received: by 2002:a05:622a:15c8:b0:4de:f1eb:e296 with SMTP id d75a77b69052e-4def1ebe887mr122193321cf.77.1759167989475;
        Mon, 29 Sep 2025 10:46:29 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c306b641asm844443385a.37.2025.09.29.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:46:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3HxD-0000000CNky-1poo;
	Mon, 29 Sep 2025 14:46:27 -0300
Date: Mon, 29 Sep 2025 14:46:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
Message-ID: <20250929174627.GI2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:10AM -0700, Chris Li wrote:
>  static int pci_liveupdate_prepare(void *arg, u64 *data)
>  {
> +	LIST_HEAD(requested_devices);
> +
>  	pr_info("prepare data[%llx]\n", *data);
> +
> +	pci_lock_rescan_remove();
> +	down_write(&pci_bus_sem);
> +
> +	build_liveupdate_devices(&requested_devices);
> +	cleanup_liveupdate_devices(&requested_devices);
> +
> +	up_write(&pci_bus_sem);
> +	pci_unlock_rescan_remove();
>  	return 0;
>  }

This doesn't seem conceptually right, PCI should not be preserving
everything. Only devices and their related hierarchy that are opted
into live update by iommufd should be preserved.

Jason

