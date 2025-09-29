Return-Path: <linux-kernel+bounces-836657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD63BAA3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9621923754
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4849E33086;
	Mon, 29 Sep 2025 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n4gAIY7B"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40B221F17
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168628; cv=none; b=dzZHesHAv8Ry4vLlNCniy2QrmEgPlH60tqJHLFBFIqMJvrN7kO9kNtNNcP/JChvEVvYRzZ/G3TQvSfphX2BTUrGlRtPe0u+Y6pRT11A8FSfj93DlK0dh1CB133oxSHUw60l927MUNIWc9KhVCC+p6g1q1AnUV8mg3KZRwvJFH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168628; c=relaxed/simple;
	bh=Ej3spbu5J2zc+b/KtZHQNvatQD77mVd1Ebq6G/Cw2xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erTOc4OndYofT/ViddzIbsn8xntHNOQqVVk4G6QUx34Ar+0wqHJ5T/Bg+pNbMzwbIDQoJlMyH2lzuwTTIVDz6MKjQsjxSBk2jq+7v6mkkNNf54hI5DbjDTYj7NI7zEm1uzagSi0TZsRHxgmzJxvgtGVtoMMJKO+oWF6I5z7vFXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n4gAIY7B; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7841da939deso1428142b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759168626; x=1759773426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSEfWA1uLs7j42NbWHoxDuAcJfkgLIbQX7B0j4gXr2A=;
        b=n4gAIY7B8jsesZlN+FKLD1ej3sA5WauGkdqVcsunFs1umteoPa98rMUQIpe7uEC4of
         w/0NfQpJ+JMDf9zb2YEJZtkvhMAqgCaEHtNFoF15QtSuvViNxJFPquhVE/DEPYbz0tKu
         lGEl2VNCrbrSIxKG54fCHDzlX08fJdfYT78zusa2cSX6IB/EGzD2A+KdfZQZ+yRzBW8X
         9N5xStq6aNuuwZZU4PZ0jJz5OXOS59fHPk7UPG8u/trlSinu1TYkU+0ow5q9C3ETmsII
         aE0KMk0ceP+s2a+kKot1rP5MA6bI8Tvh2+CfrNGKclaNJZh96UANYrEqToSLsPzLiQ1h
         Q0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759168626; x=1759773426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSEfWA1uLs7j42NbWHoxDuAcJfkgLIbQX7B0j4gXr2A=;
        b=DNsxwNX1KF34OEcrQgtireG7744CM0Z75qM5eC7ehnxVgQswq/f3VD+5sxRJXbCypd
         pNS3QVrp2kf5aVNRdkHr1RK/9Yjx/XxATIZ+d8WlblsMiq11wPoLrVYbYDThxANry7l0
         TOoa+dl2NHeGO+etQ+eMWgOuzojgZ2n8tpaEcOOtYnAgtWcGga+yy6rlYPYm8ohmvsjR
         VFP9Ksofr6hLAM3Sd+W5D9TqhZUVgyWk7B3s6kbUOaU9p2C3YjjMfueEU3h0q9JW5IsG
         I42oYm2gMVFeeekvbsgIzIz9uKazaHRW6inj9SvICLsXv+t9BmlNvfT2KDcWpYHta9SI
         MutQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC/ZfnZs/z9+0HwoJvjS3eHMtNJkPxxroQIupbwg3akDjl1xzot4ynQ77MBh8SrAhK8gmQJU7FOVHws6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXFUI2HM2gChdFv714fTvRCG05zEX5PXbpkc7yITO+8T7XyaU
	BG8kSVFXSJ3se9z/kJpbPLVg5ElRu9JAQAiy+ruBdrtmatszxTtR3jY/s9H8ISNCqOc=
X-Gm-Gg: ASbGncsogClxkhlv/VZ7iASSIZnK54p4B80i9aB3bpdThd/zyuOIGTD9JOVmH/IBxFb
	cnrD6NO8Wtl+QeP+BTeZE7PBvcafyDKcjg7zA/Ty8PVnZf8xDZE9wj2YVV4OgPU3yy3sRAvzbi2
	/BGPN0G9mj1uXUrkdkWSow8DDOhpnFmuF3e8qNewGRj01Nh5FbLAE7t+nc5X9HTSDhS2aq/34V3
	9YSWq1YGyXwAyjM9XWRBKh4khuyKsQ3r0zckRgNVqFh7UQWF9B6dq7I9LzGwnVs+VeY1Ltpucd1
	tUhTbB58W+0KqHDgUZpmM45lXwEWCJacPvJvjXln7FK2yI07YOOxEjTgb+doPmsuC3Uwj8EB
X-Google-Smtp-Source: AGHT+IEC8oBuuW4/Xw28rIvKPHz1CFCYAk3QHNI8WxtedXpOGhzC8bhDdJWSvjwEZ8vuUpUfIyJQTQ==
X-Received: by 2002:a05:6a20:9712:b0:2fa:e8f4:618b with SMTP id adf61e73a8af0-2fae922592amr10511358637.26.1759168626501;
        Mon, 29 Sep 2025 10:57:06 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c52eee5fsm12037328a12.0.2025.09.29.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:57:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3I7U-0000000CNpB-3RFT;
	Mon, 29 Sep 2025 14:57:04 -0300
Date: Mon, 29 Sep 2025 14:57:04 -0300
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
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
Message-ID: <20250929175704.GK2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> Save the PCI driver name into "struct pci_dev_ser" during the PCI
> prepare callback.
> 
> After kexec, use driver_set_override() to ensure the device is
> bound only to the saved driver.

This doesn't seem like a great idea, driver name should not be made
ABI.

I would drop this patch and punt to the initrd. We need a more
flexible way to manage driver auto binding for CC under initrd control
anyhow, the same should be reused for hypervisors to shift driver
binding policy to userspace.

Jason

