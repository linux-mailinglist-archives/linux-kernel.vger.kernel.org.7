Return-Path: <linux-kernel+bounces-897171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8EFC52258
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 507B6341AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214743191D8;
	Wed, 12 Nov 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhFEWhTb"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947B3191D2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948931; cv=none; b=f7qGrJtJAJGF3kDXpitGUFywxejuexup2PMZ8udYGPAM9YlOEEQcvW64zf2VZNNN+HIiCsBgDd/wQDDAH1eux6YQDrqNHWzRjVM1WV5PqwLlZVcUKmkBqfPdc3+Z1OhXbRLVcs7Zg3yGnr/utgsoDurk3f2c4lZhzAEJ5bSv0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948931; c=relaxed/simple;
	bh=4sUM7WH1+VY7rTzxu9qxTHMaY+e1s7RNkZKkLmmtrjg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b11+fdTDj4//V6iEHTDzICeWBt6KxWDxT5UZ5fKTJdOZJQsyudAy7/jxJblo8+X/erai63/8kW+z4PufHhnWN9qX+FpOu0LtsS22XITWpPoeYg5bacPfXkyr4jP8BXM8Qsb/peLg3ZHSUFaBzrSIoRwrM3ZOJw1e1Un7BCxBiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhFEWhTb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5943d1d6471so762926e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762948926; x=1763553726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eH+LicKzZZKQtDjwYrqOgwxCOyN5rsbgFwrU7hAVtFg=;
        b=QhFEWhTbAXDEKp36aeO++QErfncDnhgnHRCy39Rkg8/IMKBVjJy5JOD0VEAj3H/XLJ
         ayN/9h4po3JJTKKld1s8PjgGF9Xp8aC5r61Fnq9tCwk32FQM5EEljTRVV+KRCa2x4yX0
         L1g/68nCCWScOZE2yMcKe8SYD/laYAkY0d/V8iaItfZPNrWf7DNiefWYGoqXKatsK5Ks
         dy/g1Rl/9pBfLWGG7qtac5KOYgGVzrjJ5wZxA4LIz69qryrb44NXdXShosDY0nmcaAeT
         +5is5g5mp5MivyuCKisnb0RsGm2ff4SvtR/0tIShDfurDvg3GVAlknlR90gbUuxsXbHC
         4eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948926; x=1763553726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eH+LicKzZZKQtDjwYrqOgwxCOyN5rsbgFwrU7hAVtFg=;
        b=dE9yxTIjMafmEWnI1SyVJNi8zFTE66/oDQqOisPRiy3/xMhC7xN+JLLcNAWyrUFhjN
         7Gxt1/QQyY2L7rO4W9k3UxpAFXGWH+si+2SFaBshIrhxD29sReY8JGrTZrpxCad46nBT
         pcNBBv0Z/x9mOLQlqDUw0llbGJJmA/RRi3yhtlyRFRj5X8iJuFZ573Z3yTEd6WgTIXR7
         nTYJY+4A8fvfCwMaOeK503Z0fxGFqqBKFaeKT+QFF5nbe4X4y6iRIroj/Whl6oV+KA0i
         HnMpU0Fl1tE752qPDdD6EEwvdj1N0/QNvxtlrHDat9AOeOv+RH1OPhJE6XMYelyfqi2e
         dEZA==
X-Forwarded-Encrypted: i=1; AJvYcCWMqSE9cWMKs8Zj1UDiGeVBCIuFRkyhQnDkkDx11TZd0EJJS1cFNufNL9ydgQRyXCoNtMBXlz6/Snh8Emo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYUJYmxNdPLzgnwDonOIvanpbApYR9iobChxcpxbDhAVVmEqC
	LF+YGf2Kce/Zt6+Gp+TLKE0EBWy/FR5eL3QcT4BsFP+MQ44Za/dIa4boJ1qwWH/m
X-Gm-Gg: ASbGncsp3y6sd2R1A4XRVt3qK30wT4Ykc6fMagsfPXl+e4atibCI1X5pC4Rg6+4v9Cl
	/C4nDtK6ucHlbxf7F78qRX+AtZtYRqdeVjdiJTjCna4gqLUmnaCXOmy0/TLimPoPQpsfsq/mT4K
	qNM1DLHDisQHt6vspzu/AWbhVGSDhgyH3W3suj88XRZG2+zu2YsQxFAoxIv9egQLWkmpDexDH9J
	NamSHnpnKJbAIJmdejBOsqML4o+rIyo21G4Leku6IQpSCHha+IOQizP8OhQjAYEqJnyJJwQjmWl
	rHzWcjCWUks3cJKcIfzzep6FlS1j6kMHkPADSYT1vqsIhmxU8UxyQu3D07vKLFFxX7ZoaOjORtF
	E4vEHsw1O9Cd08bfTgyOpW0fun276bg+5DMRMFgHKIy4=
X-Google-Smtp-Source: AGHT+IGeLcgI5bn0B3LCjEKOV3352o8Vh1fI0N1HmS2Z+2cWfmHBHleSetqNFG1K+QPTgI04aqR5aw==
X-Received: by 2002:a05:6512:23a2:b0:591:c898:e82b with SMTP id 2adb3069b0e04-59576dee887mr955091e87.8.1762948925597;
        Wed, 12 Nov 2025 04:02:05 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5957d7db7a5sm129387e87.20.2025.11.12.04.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 04:02:04 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 12 Nov 2025 13:02:03 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	syzbot ci <syzbot+ci9989da8336cb2bc7@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, hch@lst.de, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, vishal.moola@gmail.com, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: make vmalloc gfp flags usage more apparent
Message-ID: <aRR3O7l2Ewx-VRoE@milan>
References: <20251110160457.61791-1-vishal.moola@gmail.com>
 <69123b72.a70a0220.22f260.0105.GAE@google.com>
 <aROasppMPmek9Afh@milan>
 <aRQyMck_MeVvvCdX@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRQyMck_MeVvvCdX@infradead.org>

On Tue, Nov 11, 2025 at 11:07:29PM -0800, Christoph Hellwig wrote:
> On Tue, Nov 11, 2025 at 09:21:06PM +0100, Uladzislau Rezki wrote:
> > > Unexpected gfp: 0x100000 (__GFP_HARDWALL). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
> > >
> > It looks like we need to add __GFP_HARDWALL to the white-list-mask.
> 
> __GFP_HARDWALL is part of GFP_USER.  Doing GFP_USER vmalloc sounds like
> a bit of an odd idea to me, but there are a few users mostly in bpf
> and drm code (why do these always show up for odd API usage patterns?).
> 
> So I guess yes, we'll need to allow it for now, but I'd like to start
> a discussion if it really makes much sense.
> 
<snip>
	/* plain bpf_prog allocation */
	prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
	if (!prog) {
<snip>

I assume that was the place that triggered the splat.

Vishal, will you send the patch adding GFP_USER to address the splat?

--
Uladzislau Rezki

