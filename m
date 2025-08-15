Return-Path: <linux-kernel+bounces-770768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A0B27EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FA51BC81AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38C22E06D7;
	Fri, 15 Aug 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IQ+QY05c"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4722576C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755255090; cv=none; b=ac5y9cpXpCQ7GU1GlxyaLFK2E1+Kc5Q48dLWtKFoEu0d2zGl1yB4X/LGL+Tbm8XpVsXizW1RkFqqSEDSwoVOiuMyj3Ukd6h4bsmglCfX8ykoBHIhu9oC9GyfVSxWDgG4RFFU8B4Pvw4stETxetcXCBoryb2JXxKL/4OMwUg9hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755255090; c=relaxed/simple;
	bh=5856zXIPk9IgqnEkrq9a7ikopP8h2OIrgLDCAzSSICg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSaW7p9oCipU+dlYrTqdWcdjLAfZ7Ysf0vwMLQkix8N88su/4aSWsHs7DiljqlWOHOOg/SuV98dkdgugSJh6jp0S6w4oKQRp8qo5ezg/4iffEFC3tHQSXXaL2Ryeg/OfrA1Nfoh6IWA4ex0SOW0ni10EjiVQ7HavJ25DMEubK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IQ+QY05c; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2430c5b1b32so20223115ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755255088; x=1755859888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dix/CPpSMGWXSWO0Y4aNEfoYpWHiRGQqO96WVTnVXQ0=;
        b=IQ+QY05cviOzbYXd1UPOuwVpj9LmvcuwLWQ4wyIWQWr4bdyg6jaEjE1gtQ8oaBRfW5
         6noxC8tGbdI2HQ9IMCF18bQmbWCGCs+VdX8FdI/Rgltl6C6rlqyWEiSp1Al9j0Jswdtu
         +0uH7iF1WeH6ar4odHB8p3GWpmILtSVYekjW2VLYkDaJx24dGKipi+pmQGPTOoBrkC+q
         7WlwOffYGHHkyZX2orK+Ay+ZYWhqQX0uUDFUnx1GwCP9AQjh4Sh4+TM/g94b2wq7u7gf
         BiewxbUZw2sQb6a9sDUgs6uAnGsPEt4sHJLynxQPnt20nqCNZ2dARUPJVCW1X6Crlsyv
         UMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755255088; x=1755859888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dix/CPpSMGWXSWO0Y4aNEfoYpWHiRGQqO96WVTnVXQ0=;
        b=BsS1ys30BQRDsAAH4vSGArkIjWf1Tc8rF/SuFnaPe8auph03XyCZK9YZ47Tn3aFPh8
         UZ2gO6yfFwgO/htwCdrnZ59hSDq0au0V2Wzpih/BcvCQleg1XIQ22Nzfsi+fzChhMF+L
         BXVjpQyh8UZUOGnJ/uktfbKyi2F68XVUD6K2xLdiwoVl4VzvK37zaVIqNDlYZGp0gbkQ
         dz/hdyjMZlNtd/atVlsT6IG1FKIvu0Xqvy0fl1bw7mO2unC2DhIRekhBF5ahzCvdgF+F
         gMaa8IOmtrB+P/ATZA/ex0KH2oRU7jLc1gf2LmDN0XFR6vriwK1qn0NUmrqEooV/7sbZ
         SOvw==
X-Forwarded-Encrypted: i=1; AJvYcCXLQ9Z//BipFZt/h83D8mfFOMywgH7ENBCJoVZfL42Rm1hec/WvapNd5JqNAhQ1aIsV/sr9B8NBdJuUqAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvG6hKL9MOqkB9AM6Ht8T97XYwEXk9nfTBsucbY7EQVqDnwow8
	JlTYsMkUQWKb5zKr+BrJuPFT1lyd6QW7q39fCvxfy6nHJ3vso6+fkSliIEcheW0hXmQ=
X-Gm-Gg: ASbGncur328/K2NBBMQHDDh7xkKJfa2jVvA2diPL7InxoglR47PuShyyEhg10logssD
	Yn7S42ZmzDZriVwX/NS3EbMf3o/DJVivs6EDQTgpZ6Z9YxspKkDyqTET7N9Bh13wFQiP2HsWuOs
	TtfH5xIpMnajGNvUEyqyIF7IFeZIzsAoqM4ODIXKGfDHcqLu7HiW5/hLoLtk0GMk4tiYrBwa+Zf
	/SmRDTmQ6Z78AFZ/D7+3HmTrhgPs9XH3jH4T9Tn10n7AG+xNvp1J4IMC8SoxM6an7zdx97a90T/
	Ll4Jc+cWJ5FYea7jScwkv1684HCeEFzH0RiET7bNHEBWGa+bZiPxel5e+yFzgyLda9hGNd2dZXu
	S82TvJWpLjkTzC/sZogBZLvT0P4w=
X-Google-Smtp-Source: AGHT+IEmNprlP3EyYzXw2mJxg75wrJzN+aQ6IJA3e06q3ZiRiLLueRHZsG1qP8n+zVyH+f5AwDAHpw==
X-Received: by 2002:a17:903:1252:b0:240:1ed3:fc28 with SMTP id d9443c01a7336-2446bd2d05fmr30011465ad.12.1755255088359;
        Fri, 15 Aug 2025 03:51:28 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9ee0esm11563455ad.8.2025.08.15.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:51:27 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:21:16 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: XianLiang Huang <huangxianliang@lanxincomputing.com>
Cc: ajones@ventanamicro.com, alex@ghiti.fr, anup@brainfault.org,
	apatel@ventanamicro.com, atishp@rivosinc.com, iommu@lists.linux.dev,
	joro@8bytes.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, rafael@kernel.org,
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org
Subject: Re: [PATCH v5 1/3] ACPI: RISC-V: Add support for RIMT
Message-ID: <aJ8RJCFM8p_GrFXk@sunil-laptop>
References: <20250716104059.3539482-2-sunilvl@ventanamicro.com>
 <20250815075541.29941-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815075541.29941-1-huangxianliang@lanxincomputing.com>

On Fri, Aug 15, 2025 at 03:55:41PM +0800, XianLiang Huang wrote:
> Hi Sunil,
> 
> On Wed, 16 Jul 2025 16:10:57 +0530, Sunil V L wrote:
> > +	parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->dest_offset);
> > +
> > +	if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
> > +	    node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
> > +		*id_out = map->dest_offset;
> > +		return parent;
> > +	}
> 
> Why do we assign dest_offset to id_out? The dest_offset is the iommu offset, not
> a valid deviceid required for platform device in rimt_plat_iommu_map?
> 
Good catch!. Thanks!. It should be dest_id_base. Let me fix it in next
revision.

Thanks!
Sunil

