Return-Path: <linux-kernel+bounces-827491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731A0B91E48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281372A5443
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831242E2679;
	Mon, 22 Sep 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbvKUlc/"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D072E1C69
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554707; cv=none; b=SL8OMg693Ycnx6tEoS78HpUZmAwK4t9hnXj8orRgeVa/bnD0ittJ8hvXiKS+YQT2qIfwbdP254JPrSm6Is3lRz0mbrlgrltwBKmb1f+/9BZrApKhTWfBjNEmSFJ58k+TTjzpa2u0uIlp4nM88WKJMUWF6bMI0FqcGn0if68iySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554707; c=relaxed/simple;
	bh=QYEbatTFWZqu7IgBlVpu9sOEjAAWwlu9TQXQ9Dk+9Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIa1GBkdPfWp1LRF25JOfSy8x+Eezix3RSMY70ao02xM//CtdxtzeStaiuQhNddRKJqHyURdcRG9lEGAabZx+c4ku5vrIA0yOKZ5mdH2a4UejMd7aufRBi+neJhxcLtoJSs5ci19NsIdC00oDVJO+Qpsit+l0av91HjmRAhxhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbvKUlc/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-79599d65f75so36511846d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758554704; x=1759159504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSkikTZXE02HYkXXjiWnrJ/oVniVcD53sHXP8wi/2es=;
        b=GbvKUlc/JtIR3DWV0VyuNfApCFAPfY7QbNqLoH8dZAPnn2vGY28r76e6+o4rMM0BXz
         Jc7ROfcH+y5vmcHGsaVlb1Yfkt1q11aJVuF9yMXeB8xnGJgBbqUPsXpyQ9bZeNg48xgz
         W2j3WdRcNPNi/NwD1/rvno3xosZd3l42L3rVRcawK5JYdiwR7ar3M52Oiscs4AGAfb4E
         HGypZOs54Wp8KrHu7Ocx8X6hXxh7EFF/wFCf0QTloZ6HWJjWeSk9YOvnqyMeQattKOAi
         /WrDrv6HnbOum3atBBtrSy1Cp5qp9PX/T8/JrOHHFZk3emlh/h5a5HwWsIbSxc0Uy/VH
         0g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758554704; x=1759159504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSkikTZXE02HYkXXjiWnrJ/oVniVcD53sHXP8wi/2es=;
        b=A0GY7HYAQ6/FMbOGCzE9juHVWlMXGF+KwLceVSPY8xg3njpE5K3p8Ab+d4wPgGh6dk
         qLodRyHcLGqG7YZHhXssi4MuUp/ePmC0noGgH2MdZy5pi8KLvOe+akTao0c7+bbMYcqy
         NQzgq7UXNmKILx/CYOFsh8MuHArq8nGpBcBaK3niEqKdyU5Uj07syZtFXDNQ5eMGo5Qw
         ZzHcoVMDi2HNOycXwuHA9gyjw3O/6l4MIkMBfc2mUMY9F6QhE8p7O43uoY5uAL7W+f2c
         TTDM4oL1zJddf4VhHEV8XUybY/0LemoMTyqMLjR65dol/QFDMLyv8D7LSQKaeRRA1Wf6
         C2dA==
X-Forwarded-Encrypted: i=1; AJvYcCUna0qdtGLbF+r2syieAua3BAZp6iouuLBTO7yLCRH1/qLRK2UmKnrJ49BMLmfKxmsaZLlrS3SwNoXP7qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VBzUJo2SzoAmnyfi5ed8ak4JmzuWxjigibwusVO5RMgjw2q1
	xaKRxVeTPXLKQFJdbGxuudRTcvbnrkk7QSvktEGeG3ItkpMXg0BQe+Mt
X-Gm-Gg: ASbGnctMkQHYAx9DkMVkzKx/lYGP/bom5QU7kvY2pRqETCcfa76sPeTv2OP/dL9k+Uk
	zy4p5vFjvf86kXC1nAxolFUBFkx5+S0lukismbWwR5D4aHKVjMdFB7P72nxd8Siyf+4weP/eTiw
	h1XizqAU4XhR/gQ/STtePReDBH14IISnV/scLV4yhiDfsticCdEPGvSdMDOsYU18HgUAtWh5OSg
	BBrh13noCxoOfgqp3z8bdomhmmmtaGYwDOongT+f2iOEi3w/bzxyouW3H95qhgPOWQ3qmzmyv+M
	JREZXMXYox3z1gHMvRRTf5zAJcoj+faCmzG7BJsHK1WMPWFUYF1hYWeMels+XQpXkY9HvoqP5r+
	NwKftJvnZeccJ5qC3rOGSjWBzkaA2cyabrUDO7STpWxLNcZtmW32d3/Z25z5oyRETamPurTtOYp
	5bg90PyaryiGbz
X-Google-Smtp-Source: AGHT+IFLuh7hLmB3OCi2rCYdGej4o3AbyEiGyG+VTXpzKGHWHa/tEgW6eba5+uzwS6ylfJZwL6TVtg==
X-Received: by 2002:a05:6214:2523:b0:74a:c41c:1614 with SMTP id 6a1803df08f44-7991cbb4c5bmr136386876d6.48.1758554704238;
        Mon, 22 Sep 2025 08:25:04 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793548c6e02sm74743246d6.60.2025.09.22.08.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:25:03 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 38708F40066;
	Mon, 22 Sep 2025 11:25:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 22 Sep 2025 11:25:03 -0400
X-ME-Sender: <xms:T2rRaJh3AXIyZRADqZDkJRc9F_XwjvvGgVNn09ufyoy004M33RJ7Wg>
    <xme:T2rRaJCMDl5Lw5LPgoT5jE81B3B6rxyeC4HnFFlqVp6V6wtJIL2a-d-P1H5naEPWj
    _yvz-yckVHuUq6q6wAtOz7xOcnCaPi3QKEuS7t307-cr0l7vycHWA>
X-ME-Received: <xmr:T2rRaPuLA2I4fOIUYCy81l7cMsrcAZGayDDK5CpKVAXkQh57DbVxbpBIzKKvl7G_G6RtAsOzOW4z0-C2Jd1r-IJ0_ARAzNzm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghpohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprhhushhtqd
    hfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughr
    ihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtth
    hopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggtohhurhgsohhtsehn
    vhhiughirgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesph
    hrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:T2rRaL4t858O6616lJKjIOoRtNlD3un5kYPG9N8BQ_y54SQBcVMugA>
    <xmx:T2rRaBdUvNQAMWWUBEHyjzmjX8zh3-cMtAisohU5OXhgnb6cnsLEkw>
    <xmx:T2rRaLWmkpenwAmwnz-Prn2wXG-aTNpGUud4OQdFCUGezJ2cznjPig>
    <xmx:T2rRaGXlXRj_c2jlwOXNraSakXxl_Fs7Qa8MMJY3OSLo_VUTYkbcAg>
    <xmx:T2rRaEQFjF6qobnGRJILdvn2WdI0fvS12vl2HovQJZYF8b4vLZzhPY9c>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 11:25:02 -0400 (EDT)
Date: Mon, 22 Sep 2025 08:25:01 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dakr@kernel.org, acourbot@nvidia.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v2 01/10] gpu: nova-core: Set correct DMA mask
Message-ID: <aNFqTYkkY4qgCyWP@tardis.local>
References: <20250922113026.3083103-1-apopple@nvidia.com>
 <20250922113026.3083103-2-apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922113026.3083103-2-apopple@nvidia.com>

On Mon, Sep 22, 2025 at 09:30:17PM +1000, Alistair Popple wrote:
> Set the correct DMA mask. Without this DMA will fail on some setups.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes for v2:
> 
>  - Update DMA mask to correct value for Ampere/Turing (47 bits)
> ---
>  drivers/gpu/nova-core/driver.rs | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
> index 1380b47617f7..ccc97340206e 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
> +use kernel::{
> +    auxiliary, bindings, c_str, device::Core, dma::Device, dma::DmaMask, pci, prelude::*,
> +    sizes::SZ_16M, sync::Arc,
> +};
>  
>  use crate::gpu::Gpu;
>  
> @@ -34,6 +37,9 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
>          pdev.enable_device_mem()?;
>          pdev.set_master();
>  
> +        // SAFETY: No DMA allocations have been made yet
> +        unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<47>())? };

Any chance you give it this a const name? Otherwise 6 months later it
becomes a magic number ;-)

Otherwise than this,

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +
>          let devres_bar = Arc::pin_init(
>              pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/bar0")),
>              GFP_KERNEL,
> -- 
> 2.50.1
> 

