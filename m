Return-Path: <linux-kernel+bounces-796375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 224A2B3FF88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40281886A26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6352EBB9D;
	Tue,  2 Sep 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JSzNqk/4"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89484283FF1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814802; cv=none; b=odzRna6n8Sybc1xLS/BfY8lk2pXoCBSOrmSTj6uv0ib9XNVvVAy5xkKKkuxsl/LmZBrGs9MqGro9PeSF7Vr6tG1ASfAexADfZDFK3/NfP6tvdLcsy1/1kI3s4Bsp+lk6ejkitQsyJ11+FKJq8KZW61lRTHYOQ3GbPb0WswyZhcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814802; c=relaxed/simple;
	bh=sE9g5D2PTbD7MwH1etdxQEgOaOD4qLLhrkoy3zGRsSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8/1+d43cbCSl5UA9xSm4fkmO9GS8ivbcE8SWwkTRs1iMnyyCImFrhQSOTmpdapLkaV2pD1oPKyofJ9i63o6Tws6Pzm/2K/MJvaUieqN/oxl8HUBhAyFGewp9XWd34SPTrbrptCAXQ1qFwWGKvFiD22jbvCSK0JEvyCV4iV2w70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JSzNqk/4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b33945989bso28573871cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756814799; x=1757419599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwHlTuko8/bhLBNZDswXiYJz77BS3zzuPZs0VGUvgtI=;
        b=JSzNqk/4wJnV6eXtap+esc1VCfnCmN0GbdqfWrgjq7DB+HIeFARltiACDmgvgZNltG
         naODe0983kOQzwpDZDceNcD7li7SwnwGJdUxEoMzpUyyBVykivr1VlE+anRSvT3zOEhq
         bLzlJZGTXoWd5g+x8tGKb07F3etodxpx1aIHY2Nq4Asgb6P9d8WGHzJ01S5p86hzVdtn
         m1JcvFACYhGcKrBfPHjui8+qzn8T1/Y6Hk6WgASbh8MV67ty7yB2gzpgdi8PmT03ecqi
         wwokO/MqZjo5dc6USDkKukT1CgEu3xZzkKD2OR1zLC3CTvO0OLgz3CsfU/fcJWvj2qSo
         a0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814799; x=1757419599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwHlTuko8/bhLBNZDswXiYJz77BS3zzuPZs0VGUvgtI=;
        b=NSyGplSOImUVawEaY5YN7RxmEwRzZz7nDv/jkqo+4c9u7yLDjHvkBOzpriB0VIK0mI
         D7PsoA3g03WK25D2OZ+xYfmlSKiHft8N6wYxzUUSMtASWUbHNtMqRf7Re88C1bSqbiMs
         ghPOaC/lomfGivByntEXlt9K9MMaG+jiqRPy9EbOCNXfiD2KJKOwelRzWu8ftuemaJm6
         TQz3JdnBA1Inpq/oZQgQdrTo5hrY0amMvjF/1T6fzA0vCvxJ/Yc6JRtOF1fzh6z9AzBh
         lMPXQZdyoF4PKTc+ur/gbbpue4WG8M6juedzVt8gtnSduC0pwrioGw49OwIjybJ47Nuz
         yKRA==
X-Forwarded-Encrypted: i=1; AJvYcCWUT2jah+YgPMV12y9ABqvlUcyHmwL7vh7IrNNVy5uf4vcFs0BbenRzpTO0hZENZflHtutVwaIUVnDH1CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr3PkJWKGVv+ett0Y5ksVe2amxjFwhkQzCaoQ4rKLKKhUSBkV/
	TUawjDzRmAs/BpPP5AzulCL5vOCMG/9phg1O2+wAEKdRBwQGIduCOWDxsZAkN8ftgyo=
X-Gm-Gg: ASbGncvsIzsMokf9v+jXxGO9Yfogs7lhdlo4DASlOTg3C4LlyIKJ1ZbmpMPiooPyET3
	UsqiSX6DQiAok94ErJhekxf/YED6Eq/vNJrQaPiTDjYHSRtj2gyaXJp5jp4YwuKIL7hUmjnl0Ql
	1vgWWD6X6oBMHBzc2QZ8L1iMQ+3F4MPR8LtyCzzZt2cuHljiLy9mkhCJbfkuiTOAX7npNsqDfAA
	GX0+qvBM+VM6PZj7YbPXTwBkmAguI07f4QvJFj6mIHWluf/Wgwf7qQfGL/DWIIWkPmBwXiUDvo3
	Df15FZVAxQvqswr1u5lz7/ISyjB+8/xqNm4Nkh2MMKKNVLj4fvRzdkChKmGfmlug4pqbOp5jJH5
	aXXQZMDFhn3SjX/G3WNQjQbtsGBSaTqFSfZk1lJcAjLsXZBB2owkRFZYbZD4zcDM0o8oQnChLgX
	16ZNbH+BAUoRFOQw==
X-Google-Smtp-Source: AGHT+IGQLTdGvLivSrgS3C3MjhD9R4PvmhmRB9ObwWSZqFcL5LLR25foDK+15fQJoFTFNVOh7BgXng==
X-Received: by 2002:ad4:4eeb:0:b0:70d:961c:bb0e with SMTP id 6a1803df08f44-70fac9202d8mr131625216d6.58.1756814799288;
        Tue, 02 Sep 2025 05:06:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720add66632sm10527126d6.32.2025.09.02.05.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:06:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1utPmY-00000000sb1-0r1P;
	Tue, 02 Sep 2025 09:06:38 -0300
Date: Tue, 2 Sep 2025 09:06:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
	osalvador@suse.de, jhubbard@nvidia.com, peterx@redhat.com,
	linux-kernel@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 2/2] mm/memremap: Remove unused get_dev_pagemap()
 parameter
Message-ID: <20250902120638.GB184112@ziepe.ca>
References: <20250902051421.162498-1-apopple@nvidia.com>
 <20250902051421.162498-2-apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902051421.162498-2-apopple@nvidia.com>

On Tue, Sep 02, 2025 at 03:14:21PM +1000, Alistair Popple wrote:
> GUP no longer uses get_dev_pagemap(). As it was the only user of the
> get_dev_pagemap() pgmap caching feature it can be removed.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/memremap.h |  6 ++----
>  mm/memory_hotplug.c      |  2 +-
>  mm/memremap.c            | 22 ++++------------------
>  3 files changed, 7 insertions(+), 23 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

