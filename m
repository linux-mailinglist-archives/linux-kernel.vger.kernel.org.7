Return-Path: <linux-kernel+bounces-897955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A9C53FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B6204EEFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3829C34B40E;
	Wed, 12 Nov 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1YP64lT"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54D2BEC5E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972717; cv=none; b=J3SU2nu6cgHroxcKi3Ns076kHG442X9xkX4GbeWp2fCXwqDcFZvJ30fkzI0kEbv6KYUVgJpdciTw1HDsioi2wvEeV+GeXxb93fsLnasooNS9cCtCJnfyBePsuaShJrCg+I6LW8Y61db3af0eHrG+tN1ojMIlQt0G06JplKdw+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972717; c=relaxed/simple;
	bh=rjdI/hPxB57OWIfqIRPggSIvkjgsaZxLZ95HFelCcGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8oXYz3g69zOIZZtXBTYpgvJsgUKVSW6Li4TysSRKdSPF38zESR50RZ1ldetrJ3XWURQk7aSfAU8YzMxQ9pEEDtkvS03beaTlEq+wSeMXnShwQGF/kn7WNgN/jLfdjaf4Dgj8xrUjvGplh9G6QepuaDpmQ1dKGgmPu4AnWh4pF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1YP64lT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b4933bc4bbso1034651b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762972715; x=1763577515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+G8+iIuAhEgULEzocPDssGo8BH46zvY9bxVPTxi2Vs=;
        b=C1YP64lTmpPR3rpAi4nXm4pajuWzRnGOvB/NwB50yogSmfuta7NKCFyVQUPL1Apj8V
         mSr7bVW7YBn4Zbn0Zc4cMrEYNbKBouZfhtLRajLqWeSLcNH32SM3z1ccGl2UvNrcNV0H
         xu/WKO56sfn6ZosM2QScFhK3NURNDmW9S000t2z3hfooLzRZ48YC7Q9wtN8cLEJEM20v
         4WmISrgEaSt6FUIgteIWyQy/PBOgrWCikXbwgvIvYPaxXGlEZWhEvjE0EeKuqdx3P5VK
         7xJ25EGDBb6lk7dvv7uQds+Z68578wq3lrroPGnICn/nIh7oLn9/Zdy8srwUJRa87NYg
         lofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762972715; x=1763577515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+G8+iIuAhEgULEzocPDssGo8BH46zvY9bxVPTxi2Vs=;
        b=GLbztXHHt6l1C2FL55Dzk3ueBE+tC+1eNa6380xMCOSpNjrAdYpt0RCGEuNRYRH85T
         xtSYYC1XrR2itVf+dws3IicKl/QAg70BIIzwK1LoiMlghm0FUY8OLrm4e/L2YMKCW2/M
         8JPjUdiPBmPAh5+BcNAQZ7aLh2iQ6OQ9ILyrAE+PcRtsFzAkaNrQKkQnpDxxk5lRYDqT
         OSo2Kkm/0jTQTqPuiLmPALMJ5mZQd0XAZj9biMyop5GnG79gPrhISfzfjnSNp9NjIlL/
         bgE1efwbtNIdASDaUzxherDYeHjlMSf80kfyXzY75XNxY4pVTxIrVbSW3w39hoVtG5xY
         KLcg==
X-Forwarded-Encrypted: i=1; AJvYcCU7QYmmAOELoOSGlDUB1R60zt1z1iBXO1dWh7AWTkBY5MjO9LiGQsmpJZgla+NOq3TNOg7Stzz2hjQ9qPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+qCnhH94/KjqwEvlCgRU4cZVhf/bRaH8kk+jaTfh+QN82cFx
	9zkpgVGAQu0yCOe/iq90P/gYl7885eRINQQGSo/fLRlCKO0QRuaifBrX
X-Gm-Gg: ASbGncueVTrSk+GKDv2ZghGwEC80F8EemQcHqa05thCl1y94SKsFHLWhp2bo5BzgV3W
	6RqIt+9mukzKbWvjsmX1Mm114FuqQs8xIrTDxZ6VrjCDhK6J0qhAA2haxUDbY9GLecZWBG8bsoE
	lqSRFCqGvGijoBdnHHIrz8acdtzaD05+PzrFTple1rj8WkJFRyMkPjvJCy87q3zeZs2EAdQLSPX
	1hUA5HU/KVpK88GJAEX7hqD2WJ3+R6/tfCdCI4Rn8IHHqGaQKEXKHcXAezvKv76cOXR29P2DhY9
	jJ0bAyC/OfEwuKTL2641218KXqdeRiaCEu6bzPkrnRwaUT/xjfPgFtMP9sujfBVW3Br73+1V2En
	lfaPtTtGR1hvLA0sEFpZ+2rXTc+5llf1Vq/nMXeApk3/zfWdbZJKrAswERIFEBr+G+7/ciHHy8U
	8lakE5UCJYBJEu+GyL4UTXtoswzVmUPRaL
X-Google-Smtp-Source: AGHT+IHkCPrM3gjJlcuUw/ai+5zW7z604YwPQxNzYFX5718wDwKJoqe+bSM0awd32yJLRzmocpTJQg==
X-Received: by 2002:aa7:88d6:0:b0:7a2:7f45:5898 with SMTP id d2e1a72fcca58-7b8e01e21a5mr455797b3a.3.1762972715085;
        Wed, 12 Nov 2025 10:38:35 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a956sm19641876b3a.44.2025.11.12.10.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:38:34 -0800 (PST)
Date: Wed, 12 Nov 2025 10:38:32 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: syzbot ci <syzbot+ci9989da8336cb2bc7@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, hch@lst.de, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: make vmalloc gfp flags usage more apparent
Message-ID: <aRTUKDMa8avHdvKp@fedora>
References: <20251110160457.61791-1-vishal.moola@gmail.com>
 <69123b72.a70a0220.22f260.0105.GAE@google.com>
 <aROasppMPmek9Afh@milan>
 <aRQyMck_MeVvvCdX@infradead.org>
 <aRR3O7l2Ewx-VRoE@milan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRR3O7l2Ewx-VRoE@milan>

On Wed, Nov 12, 2025 at 01:02:03PM +0100, Uladzislau Rezki wrote:
> On Tue, Nov 11, 2025 at 11:07:29PM -0800, Christoph Hellwig wrote:
> > On Tue, Nov 11, 2025 at 09:21:06PM +0100, Uladzislau Rezki wrote:
> > > > Unexpected gfp: 0x100000 (__GFP_HARDWALL). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
> > > >
> > > It looks like we need to add __GFP_HARDWALL to the white-list-mask.
> > 
> > __GFP_HARDWALL is part of GFP_USER.  Doing GFP_USER vmalloc sounds like
> > a bit of an odd idea to me, but there are a few users mostly in bpf
> > and drm code (why do these always show up for odd API usage patterns?).
> > 
> > So I guess yes, we'll need to allow it for now, but I'd like to start
> > a discussion if it really makes much sense.
> > 
> <snip>
> 	/* plain bpf_prog allocation */
> 	prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
> 	if (!prog) {
> <snip>
> 
> I assume that was the place that triggered the splat.
> 
> Vishal, will you send the patch adding GFP_USER to address the splat?

Yes, I'll send a new version including __GFP_HARDWALL in the mask and
update the comment accordingly.

