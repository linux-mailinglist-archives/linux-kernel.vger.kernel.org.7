Return-Path: <linux-kernel+bounces-799217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF1AB4288A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039041BC3D32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984EA362082;
	Wed,  3 Sep 2025 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT82xsgc"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BE36207A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923186; cv=none; b=SQzJ/KbweMC5N/RNxMQegbQXuZLszkbELbxTjkA+VbXQmmPQuMITzV0scJlXeJ2hKaZmIatqmp9eiJQbNirQv6S38Oa2C/3yzPVlQ9l+Bp5UJ/iYIn2h8dF17HLEKvgc5UMmjW02J3Qp7DxW0jga/PsOqLDdwgFeLAxkbiO3+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923186; c=relaxed/simple;
	bh=cxC1p8FYtlSO+LoFRIzXrRFnuk+2qxP+Qxrw0cPtzss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju4fpwJrAdXRKunnYSPwQ9TSucuR8sozMNG+/Qh7Z0EDDavDIZAhYx2oFL2L5V6In2J47R0ieP8gmYJOQT+cybZ7qZ6dkit9/i0V7gqlHTVJPtJdbdrbdxSPeh07/uQbo2gRFufqNlDZmSp560+nQjtE8JIefpVkrIMR5sTiD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT82xsgc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso70744a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756923185; x=1757527985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+V6XFpApnDR2sDMYgBfaHdUWcEUw96+ntmZdF92GSVU=;
        b=UT82xsgcw58kV+kcxhnX6F7gf88qJ/lDYmTi92FlFY9OexGMFVxB9M3flhuVfo+zqC
         2wuabbMjxUi+uvCvos/e+iJtNAFNFufvhAyTryFDrGOXqE1/pzQjyG2etkdyYSF7kinb
         YJE58daZi188gMjmG+cVL8fPqS3xe3Bfwpd12NvDxl9CUBNVjE8EKWzPYRlrX1Ev8K8n
         ZtxUf1w+/Gb9abzzp+iTTzPpREQpl+OSdYms6u9JLk9vnYxio8G7AtgmjMxTSLu8JQR0
         rIQkfBcjrYHXXVhgUA1JhsWLFum2qMeDb0hYO3B208ngbN/CecTO7Vs1l9pChkV71a/0
         OZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756923185; x=1757527985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V6XFpApnDR2sDMYgBfaHdUWcEUw96+ntmZdF92GSVU=;
        b=asL5XyAeBrK6WJ9ENZU7zBdVlFPRP1JHi5zwXjwrGfYFCp3TBbKtv4hj/nRB3m7LRJ
         zIF8jzOewlPwnv9qwvx3u8aRNnKP5dwU0IEn8nt5IxGhFFVqgpWSA4h48+1LonCpVQzB
         8D3E/K1RArLVhzJG0a3GDEb19mdMwW/YHy7btAOE3tBK8aYIjM0RzhWeMi7sVFVR6BdA
         vO5xHp2GEHTchsJRNmI5TCjWDL9jTq/2HQ7EQVYeBhPmgIGgFSaiPm8RU1XMGorGnchT
         mnZx7GjGnkoyDFHfQXolCe3jwzxTUmd51V9oyIOvxFovT7tCDaMjeSV/QhAt/ThDwaj9
         HWUA==
X-Forwarded-Encrypted: i=1; AJvYcCVAItI+bdMXUDZKZRzjiV4o2YFoGEGOFacpTqwaFstbtmbq9kx0VhE6UTkWJb7p6Vm0BnC1a3UWrjKocg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/yksdLbsjyKmQ9BT53IakFZoXOwO7FGaMBg+KVvibe7EWWEH8
	thTWf9Tixgq0Y0DGsL5SjMOT4DeEGr0hiFmnDlyMWtL4WpUto055Y1r4
X-Gm-Gg: ASbGncvItaFGGAMIanMBUWuZEOfDjLR5PFzlXeMYZG7KJDQhOctH1B+83jlOkkxiAdp
	VuQ1RknLrauvzv6mBkZ+wF6fsoHxATjfFp7GHqF7z4Ybsiw1Mejp11iQMzWntKeVrW82RwHvQod
	A+NtwaQy4KiBJHPlzYY1XpoUMbJPH1gYNm3UlgqNHArMGHyrzpogtsmuhLTfeN+W+YJnPKEvJbv
	gIuH9OTacrtfS4uFdI4slrYZhY1sgJRMM9K/oZuB5bL4z0snkjGrVcYLvdfiQdcP3BAVG3EKkfJ
	mSkTbIc9HGG+T6wSNyFoQ2snuQn+SDIF3MDGvE5Cnwtv4C6pfs6DVrKi5qorrol3PDpYvISWOHO
	SNGMqbrumJIZtui5hXQ9B/BRPU12j5UpHHgXDsXl0IfFajIGL57xqrA7umicDHzVz
X-Google-Smtp-Source: AGHT+IE6mulAKwH9025m2RLHU5y+28A1brzX418uJFTC1AUjoGY+4HwHcSr68SSqgbcMg5wB5MJ6Wg==
X-Received: by 2002:a17:902:f54d:b0:24a:9c83:e19f with SMTP id d9443c01a7336-24a9c83e357mr162442235ad.53.1756923184568;
        Wed, 03 Sep 2025 11:13:04 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ca63c9e71sm18196285ad.95.2025.09.03.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:13:03 -0700 (PDT)
Date: Wed, 3 Sep 2025 11:12:59 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] mm: Fix kernel stack tagging for certain configs
Message-ID: <aLiFK8sIgbfiK-v2@fedora>
References: <20250902175903.1124555-1-vishal.moola@gmail.com>
 <f41383c3-913a-489a-82e6-d2c8d5519eed@redhat.com>
 <aLdOLQLjt-A1DBGi@fedora>
 <b0ed22cd-ebf9-41f7-b5fb-6fb078db593e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ed22cd-ebf9-41f7-b5fb-6fb078db593e@redhat.com>

On Wed, Sep 03, 2025 at 09:46:44AM +0200, David Hildenbrand wrote:
> On 02.09.25 22:06, Vishal Moola (Oracle) wrote:
> > On Tue, Sep 02, 2025 at 08:23:06PM +0200, David Hildenbrand wrote:
> > > On 02.09.25 19:59, Vishal Moola (Oracle) wrote:
> > > > Commit 4ef905bda61f ("mm: tag kernel stack pages") began marking pages
> > > > that were being used for the kernel stack.
> > > > 
> > > > There are 3 cases where kernel pages are allocated for kernel stacks:
> > > > CONFIG_VMAP_STACK, THREAD_SIZE >= PAGE_SIZE, THREAD_SIZE < PAGE_SIZE.
> > > > These cases use vmalloc(), alloc_pages() and kmem_cache_alloc()
> > > > respectively.
> > > > 
> > > > In the first 2 cases, THREAD_SIZE / PAGE_SIZE will always be greater
> > > > than 0, and pages are tagged as expected. In the third case,
> > > > THREAD_SIZE / PAGE_SIZE evaluates to 0 and doesn't tag any pages at all.
> > > > This meant that in those configs, the stack tagging was a no-op, and led
> > > > to smatch build warnings.
> > > > 
> > > > We definitely have at least 1 page we want tagged at this point, so fix
> > > > it by using a do {} while loop instead of a for loop.
> > > > 
> > > > Fixes: 4ef905bda61f ("mm: tag kernel stack pages")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Closes: https://lore.kernel.org/r/202508300929.TrRovUMu-lkp@intel.com/
> > > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > > ---
> > > 
> > > You sent the patch on August 20 and I replied on August 21.
> > > 
> > > I did not receive any reply so far.
> > 
> > Ah sorry, I didn't mean to miss your reply.
> > 
> > I can't find your reply in my inboxes so I definitely missed it somehow.
> > I'll go find it and respond.
> 
> I had a mail server config issue on one day last month (sending @redhat.com
> through kernel.org :) ), let me check if that was on that problematic day
> and it might have went straight into your spam folder due to dkim mismatch.
> 
> So the mailing list did not reject it:
> 
> https://lore.kernel.org/all/96148baf-f008-449b-988b-ea4f07d18528@redhat.com/
> 
> And yes, indeed, it was on that problemtic day, and there is:
> 
> 	Received: from smtp.kernel.org
> 
> So, problem on my side. Willy already replied, but let me resend that mail.
> 
> > 
> > > And now I realize that this patch is not upstream yet and the commit id not
> > > stable. So the Fixes/Closes etc. do not really apply.
> > 
> > Gotcha.
> 
> If there are bigger changes it usually makes sense to send a v2, or a simple
> fixup as reply to the original patch (I prefer as inline reply).

Ok I'll keep that in mind for the future :). My mail client loves
attaching the fixup patches as additional files, but I'll find a workflow
for inlining them.

> Of course, once it's in mm-stable or upstream, things get more tricky :)
> 
> -- 
> Cheers
> 
> David / dhildenb
> 

