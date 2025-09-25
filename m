Return-Path: <linux-kernel+bounces-832840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08355BA08AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A411641A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72F2F2611;
	Thu, 25 Sep 2025 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="arCqkrV8"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3E1CA84
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816394; cv=none; b=eM0jwcwGi/oO/N8t+LO25Qicz53Q5KbyyTB8PsXUwl9IwtfGEMpWh4CuGoroJbTGykeR1Z7bzqvtQxUNSuADc+N6Oi0zEsVb5uLptEt0qmhK0AyaatIZf410wV5+QaynDBtzrtFltGXAeDOGCcckN2C6Jkm7g+8QmY81geLOv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816394; c=relaxed/simple;
	bh=GqXNzIXv2Z3+qYu0yt6xuzG0cjInumz0ftyhQyGX+e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfT2mDYvpS3zItEfQT/NDPZKHbFBD7I+v5WlV8G1P52PIAJQj3LaNI1nzQpLvjniM1CwZGPNJSCDK8DKVmU0gM3AZtI0eC2bKYBUjEdgG5do9w2f3VXJR4oQUIr1jjkWf6S/pOd0zHvkkhT09tTk8g2AkDSlYF8BNbyjjCFaMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=arCqkrV8; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-89365bbc079so45256539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758816391; x=1759421191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+yb6vceRuaH7iX55SPXoLoljlTLWExr/Ac2Cewgac2Y=;
        b=arCqkrV8ubhDHhniBNX9IvzIG4PVsSEXWlllh3kJmovK6vJqxW/zVGVL2jF2U63syY
         xsV0mURG62OtFAKixBAb2U+PKPKLWMaPgK61NdEBUnO0Sqcpt7iItzOhEvyygfYYjUK2
         ilGps60kg/91V6EVK/dX5q6C5Dc9QRVB5uQrV6ZHcBAG3hn56aQaMczkroR78zeSEMY7
         kLqUXmKy0TMErdclJ5CtWnobXj+//qFlEgF4uRpdn7Lfjn7uwDGLN+L8+5V8nT9Kv3DH
         2U5BKDhdCnLfd88B2rJ/Jayt3mLFp8EEM59WMnfQBjnIf247xRpdTtEJGie29LiLp5bp
         LVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816391; x=1759421191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yb6vceRuaH7iX55SPXoLoljlTLWExr/Ac2Cewgac2Y=;
        b=q8eAR71Xx4LVaQiVZIDUPJdsprL0ZSX9nL1ohT2vsZS14ENpLx+rC7MahU4WnHtIfY
         MtirhLpdozLA8RTPBfZjxTwZv1AlN019bWN7AHULVCHKM/MezRIbOl+h4fKICHo3Mj0/
         WWZXu9i9ZNhMNgvKen1rkRkRKyNAVOzHrTzeGDuv9JgX2gam2isXqBPDKzbEQKxNUi/g
         ntCh1F5EehrrVg15Hj1nvNk/AuAQDIkQitAjNBNFt/d3znDEl5pEnEoZ7VVb22tqCyH6
         HNQ2tWfcIRMK5yTRD0IMhaR5EdBSJRuSwrT7awqjcZlMox1o0vznbd19LK0GKKUw8Fli
         /D9w==
X-Forwarded-Encrypted: i=1; AJvYcCWOoyR/J6PJEeYgDPPaKF7zwc+VTUiF9hoR2Y0wWDLTi/gq16S70HeFuegVWV4YozC3xFbENHUsPn4spbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylxf8AYdhnVEScmiWow8U9eRIMDXBcAGZJd3t1jSsCswxV/GyT
	Qpici1yfJyaQPRj0EMWSLSrS4Tfq/Z2VeAVyRfUyj6sDZVRgu4MmiwLj4tFoRnZyY4o=
X-Gm-Gg: ASbGncvvROfk4TqhKRXEHSGs9cz76DP4bF3FsVS6ZZ9exZL2llInUGCEymHVR0Ya8gS
	1SCiwhSo8LvsYvGAi8A5iznUGr6NSj9VajyQ4h6fdLszqv0ooGnmGzIkx/4445Svj/CMFbB4cfH
	uuKvdJlp37Oih1txeCirmwLmAv46Q3TzxB47g0rw/OdvpDJlHqQF6Ee1lveoqZiTVKgA2XVpjJc
	GB3XfcgtN+cdMwWTNoOCtHg4k8HlEwD3fvt9bg2WNPOfkh77yuSpQ2zd5/uyTvz8ELc/L3/UNTf
	H+Ywsv5rjY75yBLexfkPtSJwGiV3ec/5/7h9IMjL/mRrt6nWFSEE+z0LIRejOcbRJU2kjps8Vgk
	TWIcJXcF7TU346d1zp0GctlrggYCqLPn2PS1hxN+nz1+7zhHRP3kHUbn1B6gA0DY5Q4CYXFzP2R
	s=
X-Google-Smtp-Source: AGHT+IHezaCibeMYUx2n4QIwepKBTAEGeWF/wdbRATNTTWqYlSWG7aBiY/OaNiXbiz5X0eqEvxW6Wg==
X-Received: by 2002:a05:6602:14c2:b0:887:5cc8:fc1 with SMTP id ca18e2360f4ac-90168766a6bmr566009339f.13.1758816391165;
        Thu, 25 Sep 2025 09:06:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-903dbb2b459sm88516339f.0.2025.09.25.09.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:06:30 -0700 (PDT)
Date: Thu, 25 Sep 2025 12:06:28 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>,
	Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, dave.hansen@intel.com, hannes@cmpxchg.org,
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org,
	raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
	nifan.cxl@gmail.com, xuezhengchu@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
	balbirs@nvidia.com, alok.rathore@samsung.com, yiannis@zptcorp.com,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
References: <20250910144653.212066-1-bharata@amd.com>
 <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
 <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com>
 <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
 <20250925160058.00002645@huawei.com>
 <aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
 <20250925162426.00007474@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925162426.00007474@huawei.com>

On Thu, Sep 25, 2025 at 04:24:26PM +0100, Jonathan Cameron wrote:
> The CoW thing only works because it's a permissions fault at point of
> asking for permission to write (so way before it goes into the cache).
> Then you can check margins to make sure you can still sink all outstanding
> writes if they become uncompressible and only let the write through if safe
> - if not promote some stuff before letting it proceed.
> Or you just promote on write and rely on the demotion path performing those
> careful checks later.
>

Agreed.  The question is now whether you can actually enforce page table
bits not changing.  I think you'd need your own fault handling
infrastructure / driver for these pages.

This does smell a lot like a kernel-internal dax allocation interface.
There was a bunch of talk about virtualizing zswap backends, so that
might be a nice place to look to insert this kind of hook.

Then the device driver (which it will definitely need) would have to
field page faults accordingly.

It feels much more natural to put this as a zswap/zram backend.

~Gregory

