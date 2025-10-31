Return-Path: <linux-kernel+bounces-880278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8FFC254C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CF804F2A98
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DEF22D78A;
	Fri, 31 Oct 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Xi4h1bhi"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F91223DD0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918162; cv=none; b=MimvBlmlXmQjZ9KnKkzP2jTBlNgVqlFWTBGG4aej6Gb96Wo4B5fDCdc1SnBL4sHF9zcYmKnQ4/SscbeRhJfBPXL2BS+6PaEHr8xsJ5u8aFjzPQNVOR3nkhv34Q6GERspNehUljR+IGlUDMyJ+lWRAG8s00JmugnXOeqAQUILye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918162; c=relaxed/simple;
	bh=2EuZPp6iiAor3qSHhoxp+TV6FSvUxVrS44tAjEFif+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmWFAG1aJ5EzMyOCCM1YByud0+VafiDnve+V7lMemdDT8rhT7jNGCeXXAL2JwCgkel/Pzcdx5D08QCSIycao7qHMSKgAWYF5FGzonol9OOIsHzpwdzJypvx/xlpoPHLB3JpxnHXGtRz4ajlJLacVJkwgSmevXusBDWLSCKlRtr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Xi4h1bhi; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-89f07fee490so271391585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761918160; x=1762522960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=njpOP5qLjsmm+goYm8hA16YQgCyFH9JxfoHaSdz75Hs=;
        b=Xi4h1bhi12i0XcniD1+4ZhCWSnwuPBhQV8funvVYqLLKAVBGGO/bsuv3ogUTbZqHUY
         CdFk3GzHrmFwdZx8WuCSPAm8GFi62NU66G9+bhSyHXAJAJd9OtiJjHZgCtpO5RzJD8zG
         7ibCAFRhR6TvrFxU1GkzBVirk3/thsyYaAcyid7H8QdXpNCsaHWBgaZIOlshZnBk1Lu1
         QPVWpl3wpC/MZ1YKj0vD9Bv59wYufKRLkgl/qVBmouzV5dKYDnBJ8K+37f/G2mzdRKHu
         3JT5rB0ErR5h3gWE8uDPYIcOftaOBZyB+sxPdDf0uNk3skioEq58AmxQatN5w1C9nAio
         +7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918160; x=1762522960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njpOP5qLjsmm+goYm8hA16YQgCyFH9JxfoHaSdz75Hs=;
        b=Lnu312tmavQstih+Ceu2Us+al1npPEavNKj/JrtS/+0NP4MVCFbSagFq0c+N7GbVR+
         LSMXS0wpv4Dz/Tu4+b5YGDPSDK80MjAqKLbTgdhFPc2fkcfWBgGJ9RlEgPAEEVjspm5g
         ZOqVqcXWO56ekyZYj6cxWKMdPrdIlKpM5CSO/n38ImWCt1zYo204rf1cdMBsY+Ro9TB5
         OrgoOB+R+3nhGnWbpnQtzD5xnm/zGRW3KiaN1cm7AvpKevycs95GzJIun8BZzeb9P4Yc
         57vUnXKPx2qmvvTAhkLlTidpsidnN2GERY0N8HDym4b2YyIrxiN/rsUD9c1sdk7L5NPv
         rj2A==
X-Forwarded-Encrypted: i=1; AJvYcCXg9H2Yh6zdnViXd+BaCMwozMQaqTbYcmu+Jg+gvoo772sXQKyM+WcND11yC68FFBPe8zQVINaOcfBhBp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeejJ95wfDnrJhZVkBCZ7YpDF11+qYUW8nLD7w685Q6nzd+eG3
	mDBL26nME9XFZuhxsigd05s6ZxDfG5N4tKgrVb8zuLCgL3Oq4PrctN6E+dqi//yjOJU=
X-Gm-Gg: ASbGncuQFNPaC+xoKaDqiIh9LI59uA4R6/+uhpV/s5skU653nOf1pRUxM6u6GI/Rp75
	gPMfoMmpUk6fKWwdFcHc1Usw+E7KL7h2ScyOhthmcBNqmnccSwW0BhLIZ+hPV3aArUTCMSn/FBk
	B2dMzoQDfQGP1pt3/Z8baNhAoXwGqmdS0piz/dY+zIHjJT/wGAy5UI6J13XXAqTkOQG8+yKMzfD
	dO3F0x/DygBAjt0xK6Zf7C9IZaMWPOqUCbcJnpIKCWfrlace1ssc9ljn7iSZ0mVC8o3C+9HA7GJ
	ftgKdy1nuaO0UXN+T8N9OFTY0XBxe9tvMI8uJ3gMCME6Aqck1cAFhyzsfQfmDuPTswbpfNLLH6F
	oDkQuHBSNeJSbcnmcxH1eru3ZEU0XlZx5kRJX6VtKcaqUmNb7QVhXHb8zekMuv6vxPsRSveYVh2
	j+Pfm3i6W2Ne7y6+EKBgQeyisIP6/wVvm4yof2y0rfqbjUGoHKzslCC57j0MI=
X-Google-Smtp-Source: AGHT+IGI8y8YIPM3S6yMnHOJ6VxcbdkbS8NWxjTOpRsE5kmW+ZuRWtwB9gd6TlqHaKBjY4fr8ejo4g==
X-Received: by 2002:a05:620a:28cc:b0:89f:3fa9:d2d4 with SMTP id af79cd13be357-8ab98eba4e2mr437021985a.15.1761918159702;
        Fri, 31 Oct 2025 06:42:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac00a9a851sm111552085a.20.2025.10.31.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:42:39 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:42:36 -0400
From: Gregory Price <gourry@gourry.net>
To: kernel test robot <lkp@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, oe-kbuild-all@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH] cxl/region: Support multi-level interleaving with
 smaller granularities for lower levels
Message-ID: <aQS8zJ4p-r5iSgd1@gourry-fedora-PF4VCD3F>
References: <20251028094754.72816-1-rrichter@amd.com>
 <202510311413.HdTizWHK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510311413.HdTizWHK-lkp@intel.com>

On Fri, Oct 31, 2025 at 03:03:10PM +0800, kernel test robot wrote:
> Hi Robert,
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "__udivdi3" [drivers/cxl/core/cxl_core.ko] undefined!
> 

IIRC this happens when you do 64-bit division because it's annoying and
complicated. Ran into this madness in mempolicy.

~Gregory

