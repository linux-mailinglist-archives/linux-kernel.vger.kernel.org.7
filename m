Return-Path: <linux-kernel+bounces-898274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 528A3C54BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 809404E3F05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D322E3AF1;
	Wed, 12 Nov 2025 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gFuUU9NL"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE92A2E229F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987250; cv=none; b=JVDN27hSd532H6d676zIpKkWhKIe8Tu8UqKZzJkKsHZiMjXsOkym0jnOIEPJaYvzGu952gXzl2Sokd4/pfAuTFHgFlqigv09bouukpuyO64Oy3wxK/7QLiN1sDe9H+g1VDCA9qSCgLlpvXccFiz1PT9iQ9/rLL7u+79zzsIuibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987250; c=relaxed/simple;
	bh=P8wB0FO0yByvcvYYoigc7wENN3w1QKW/CVSgfU3dczk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9Z6T8Vv5E+F0xuc+GCqB6UqPn+zGf0XEV66i18KC07cDLRLRrAHn2r/ryfV63EDRl8H/0yvbY2LYe8U3T/45EOdjnvrWYDdhCCisRZtf4rJBqbtZ8H3q0SYGzhQW1kQWiZ0XFixTFb+KnhYCVGMNg2Ck+VLSBH/1i87LKNFPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gFuUU9NL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b272a4ca78so27671785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762987247; x=1763592047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F17wxxxXjWtCXfhR3CI+FvZY7BooVKr92Re6tDYp9Fw=;
        b=gFuUU9NLnPq0pZltIS7VfSRVBI9hAcVHRRKJ9jUfTXh4j/PYZz0aXktUxkZLvcSfp1
         c/T2qLIVUjVgwvlm/T9qvbQOMG9DQnYApp/n3ZkuNUIngmsF9+V3bR9iZQzYnOGPsaqe
         8FRJXOYxh8yKmxRqa6kJAGmVjutpalAZr+uuKWNkKOEDPM8f701eQ9wLu+EVC3Y9lmXF
         bmJVI78QzSCqkdKZTA9vhq0GA3fdZNIXt6hewOe/8wGY2rFa25WFZME7G4lWynAoU5Jd
         MktZ527Rw80xRWTW6pvVn1FkowIjeo660niVLgj5XfimGTKGzj2YYOpP4ondsd27ydr2
         Y9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762987247; x=1763592047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F17wxxxXjWtCXfhR3CI+FvZY7BooVKr92Re6tDYp9Fw=;
        b=JWi+XgBie6HtynsRpDLj3GZnDV0awXR+/UjEalnTIy4e3r3dOCL6lqNAKZThZBwrPG
         5fsLa+Nz80aShy19NS3tCyq5KAo33CNyL3yLmBTWrYrP/qeiZfdJlpkm6Ht6NLhwYA/r
         /IXKI6xpWMRqyhxhmrYP9ExCJ2UMZwCOKTMhVgO5MHT5dqWZwXx2uPFqOLLV5h3p+bDt
         I4bdzI3JpG4Pnjlyu5kiWBXsrF2zP8B+8L02++mw5JrEefWdEzI2sXPVz/tCD6gtYwKr
         F0Z6BEZnqCButsp2rT7GrsBLUZPFCFydm+Ex/gGlAZymK6/87MH+OVV3oIR5K2gur5oc
         33+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWI3EtBhoyP4DWxW2UKTyRN/7QG+XOsy0HQ5svNnGiuvtuZQHRhTmy9aZRgMN9lmm1Czrn6JuS6avqxNaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBbhv4VAUVBuZveXLVKKmYyCasYxshe2ZS2OseRv7l22ZpgiqJ
	n1zPw/2s5GJLgwwV2R/0hRtqlfABK8zm3HZ8KiBniJfpdDPF/OfQU0Qxw3t3Sy91BC0=
X-Gm-Gg: ASbGncvVvPUtWh06HfFQReOG86vxGKDPeMjQm+xm2SrzmxiahH68mUgiWXDbEqtS/Xh
	4umSVOefEsB0rqMmgmhtCW+Vx7cKY2H1kYqNc1gb9sv0m8dHqO4yxCXT5JXt9oIRgNIv0sgWJn+
	CVQ6H2GtRJyBR8pGDoqsZhSk6JVwadYBPdXa6J905pNZakMGHL5r5kDQL8vl6s3c7Goc1vLmyls
	KwXufkkyAn8Rjrz8rV0/xYs0tp23D5NyZLRKIIzrtzB7STEW5Tnvm67DD4iQ5PRvhkxFw5XNwC0
	WbVBKHaya6dF47yzsofY64tuAzXPIiANC23eSnQz25fIKd9aG73Y7p1rMMKlZR/7aWoHoAaBwnw
	qka3c3zBMEscEvx3obHeDK+6OEwURHJ9bpRIpj44zhXuIoVGQizimnGetj9ClRa4UsFaUSA5myQ
	hK3ZdxTa7H3YsOOrNbOAOtJRsvV7nyA570kwC0D006NSUseExouFTllSKT+mI=
X-Google-Smtp-Source: AGHT+IHsrZxr2i8YDSF/b/oh9D32f8B4GcLii5rT3OW7CqVC+9w6JNHV8qPW/fd6ArMwiMM3EC3jWQ==
X-Received: by 2002:a05:620a:4112:b0:8b2:1f8d:f115 with SMTP id af79cd13be357-8b29b7df2f6mr678375485a.65.1762987247480;
        Wed, 12 Nov 2025 14:40:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aee9eeb1sm12252285a.8.2025.11.12.14.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:40:47 -0800 (PST)
Date: Wed, 12 Nov 2025 17:40:45 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 3/3] cxl/region: Remove local variable @inc in
 cxl_port_setup_targets()
Message-ID: <aRUM7bij1XY6sInV@gourry-fedora-PF4VCD3F>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <20251112205105.1271726-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112205105.1271726-4-rrichter@amd.com>

On Wed, Nov 12, 2025 at 09:51:04PM +0100, Robert Richter wrote:
> Simplify the code by removing local variable @inc. The variable is not
> used elsewhere, remove it and directly increment the target number.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


