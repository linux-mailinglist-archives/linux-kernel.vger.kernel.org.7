Return-Path: <linux-kernel+bounces-837921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE0BAE117
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0514C0711
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088723C506;
	Tue, 30 Sep 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QXDWdEhq"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2C423D7D1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250256; cv=none; b=bEI5aeoj4Xardb56qsxxXxnPLlYyYcg2FINaQMO2Vmn1mMF6/TDz2Gxeg+PZJMkGtQX/I7bLVcu33M5Ygi/mAy3TjtrXWKn6jgdsvdT9qLRD90qeezDWeBlviPMyyN7KXZ1uVSoFwg0fip2kodbcYoHr6N8H4cOm9sjyompOqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250256; c=relaxed/simple;
	bh=wZlnhLVWjCo/EoZ8rwJ+2WNDjewuk+/wknr5aB3MEkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADDQV9I6eFzZZsY9Jji6aFU6B0mpnujC9tAxHVEVFmeTbiiwS5MO27/jsNd1A5y5MNpcTzZHRd0vK1UR2YsinbKnhADM1VGFBvxRBoIMmA94h6CnJcjqvpiKSGv/ikUY/OGYXVjGB+AiHUOKSqJfKen8RmouydRybNNHIIrLUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QXDWdEhq; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78f15d58576so720076d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759250254; x=1759855054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZlnhLVWjCo/EoZ8rwJ+2WNDjewuk+/wknr5aB3MEkU=;
        b=QXDWdEhq6DrEERhYXLsV8N2u8lhNdFUKfN8/cQK5terzImXnW+c1KYzeNEIrcu6r9a
         TGXDMnJGDgaqn/+1ZZJR6eJtflG+y+ULwaeQMlVMtRknJLEpbJg1lUcm5ynEWvDjJKye
         O4apiuqGYsjUrhwhNeq01OHMy0TC1Xw4xluczD39vGkXSA3BiiVQMtYd6RKtI7Y0geji
         mXkar18DiCFacXLx42+pZU/mZvibP01gvp0tmUfNezH6mSJ5r9fDjHePGhIvcylzJy42
         beBP2C8wWvZZBgxhGV2ytQMyIvnvWJIlry90DAgF9jz3Ab0fGAb4Dvxu2myyCbWCf259
         2I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759250254; x=1759855054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZlnhLVWjCo/EoZ8rwJ+2WNDjewuk+/wknr5aB3MEkU=;
        b=XDhT7fgxGPCGEHKq/X/3H3Y13famxphIC5+bV52Yojg8q5zMX9Lr5g2YBWJLV0JnZZ
         kCrfYU3UwdYb1o0FhRjm5dUA/MBqL12KJoUz46Ge09hTPYB2Vzpyk7bGVi4H2/ma66EV
         3KJbxxPHXr/oOFdqL9fNHbu2+REfhNWE5NnABoALa//sjJYUYE7XOmINLuTUmMR6SpaT
         7wl5W45FPqgyHj+5hbzk71ui+NgDSywloq+EToOmWDIdYjBrJIQ9J0LxhvklWb6OXUjp
         9E/LXqo8IfBRktGi93eB+Pif+jdtQ1vASw0bOlG+G0+7Z2v/7H7kV608wXh+R2o0vqfi
         1TwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs6TB4seWjXt6d1f0f+Gz1Of2+43+0geIErsMdMjaF6USaQJONYsVGg8axLTV3n31NM0HfS74sVCdVKMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ADUJ8tlE4v0neUQufdV/Y2leTR3tzKCs0Aoj9kbatOpbCDOK
	uLXha7v0/9v1M0b9W4BpqgsxY2wZIXE61PfNxqjS5Ni/toPbMyrXBK34VgN3dZgLmFA=
X-Gm-Gg: ASbGncsznkyOHcDphE+4EXqAMG9GMQCIlUIA5kvqIiCkkx6YEgMkwT739PVi5LpPesD
	EBTtGkELUaE9ojdb3F+Q6n1naUAePMq9PCM70TiY7pLxJjfzZchpiY2IXxuQuI0MPQ1qjA0Y46O
	SpSl/0UnRqzs1wz9exF3abvE1aY5O/DiiEfWUTD/lTKayShGSsT70kVFRaP1k0/KWE9OlO0MjEy
	z5Wd5zTjnv0vUNekiUaZKYXgBPQijrXYXJVFyaLylHYucrpG6jdTLzhZAW0+Q+r0OIUtwCG0jYw
	ar11neb6CweRdw3osAdu+UwuSFAQP2+vy44P8YW0LJYS7hRgQOs6bllmJjpKenMwdOABHgoLJ/6
	AKtWBYJWn/tKL74sNS6sNSkm7mSmvCaQ=
X-Google-Smtp-Source: AGHT+IFTUouLZO/CN3csdEu5i5OdgDUNjmGvNmvgmP5gfS05E7lB9xEJ9dOZVQrm6wg7EiUAZUUmJg==
X-Received: by 2002:a05:6214:c83:b0:7a7:b219:635f with SMTP id 6a1803df08f44-8737bbfd4ddmr7502266d6.16.1759250253744;
        Tue, 30 Sep 2025 09:37:33 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-801351c328esm99532066d6.9.2025.09.30.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:37:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3dM4-0000000CbmJ-21fb;
	Tue, 30 Sep 2025 13:37:32 -0300
Date: Tue, 30 Sep 2025 13:37:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
Message-ID: <20250930163732.GP2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>

On Tue, Sep 30, 2025 at 09:02:44AM -0400, Pasha Tatashin wrote:
> The kernel's PCI core would perform an extra check before falling back
> to the standard PCI ID matching.

This still seems very complex just to solve the VFIO case.

As I said, I would punt all of this to the initrd and let the initrd
explicitly bind drivers.

The only behavior we need from the kernel is to not autobind some
drivers so userspace can control it, and in a LUO type environment
userspace should well know what drivers go where - or can get it from
a preceeding kernel from a memfd.

This is broadly the same thing we need for Confidential Compute anyhow.

Jason

