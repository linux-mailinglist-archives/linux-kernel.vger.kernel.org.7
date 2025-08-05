Return-Path: <linux-kernel+bounces-755959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2578AB1AE13
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2B1620337
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF51F215F5C;
	Tue,  5 Aug 2025 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C0ryCdzV"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02520175A5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374695; cv=none; b=r+KJ23dw4Ng7YFRRCJR4tEytfNqeazy1E1JVDPxRJZIJPvHbKaNJ+PFTt5SvZoedH8kC1U5sKyI9251LII0eBb1PT0E4azyapPCRGP8xu5m9MZcehBEYEMjJ56BDP9Sp2ebLMEpJXO5FjASQqnQJqbY9mzrj62mSw1Ed3w0DrmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374695; c=relaxed/simple;
	bh=ELBa/sGUNc+tJvR9bOcpnHCkJQaz4nnqRJREE/Yqk+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcDfB2u4AMfcDsiT4GCziMYkSc5EunBUWE7u1LUcNel76RVOUdQ4SAlbIXpk06doWx5GP+AwkV+4xtmJd0N4UfLYiDW0vFxHbMwY1lGcdfB3KC4iiRjQxekob8xCTBSn7Gce6tdCqpqhoU+EtBTYw9teksYv6R6PEFx2BkH6CRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C0ryCdzV; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3b7825e2775so4358954f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 23:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754374691; x=1754979491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E98n+UPhL1YKduvH2BiiWo2QZBO1y2l9z08105Lom5U=;
        b=C0ryCdzVjf5T5lNI2j70aDrsXe8DNsa0cn93ZYd/H5yCf7Tp1kkfqtM//NzJ1+ss3R
         A0r3erGJY0YRaeU413HCzyQ8OwlAiKATs4GCn3iliVZYzGaZFQjIKvqBc8X205ckgsjz
         hvttHVPL6xl/gahhWSGrz1NCLeFkxkUH90eW7nWfKOs/WwaHl6USsc2Fj8tI599953S9
         G1BiNgq9BdXJ3lKqFaL3AMq57+uBxm+LDgGPL8Ilim9aeXL3LZdvV3rKrfApviWrpTTq
         PT923qK/74r+UKant1NEhBS8+1nI3K18vPiNTaDjMYRUhagkSAImOiz2gA3io/6+H1sb
         htsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754374691; x=1754979491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E98n+UPhL1YKduvH2BiiWo2QZBO1y2l9z08105Lom5U=;
        b=Y28k0ZNv7wnLLGfucgV+V6lnxW9A4NudI4jTeIicdmKPH4OSZvap06UODawqza+AIp
         UdSNszIcH1VBkK1cBIPYRIASQkHLVt6OBzlelgEzbZaDuMA5145/phZX12iPSaMguSzs
         a88Zr4v66dTsC+R6Kelos/ZSAQcS3OJ+k9HULaOcxLLoOXBP0r7v/CfaqOXQzIo+DuMl
         e08JlOhUaS9dbS1kSybf/P6eI+YGmcrEiMz0ONdM2+PBHY098zLFBKduqEbU8bWdsQUr
         yxtyziZI/lSny6GnpaAQ5vqn9njqS6xyEAMsqnMxL8uyFWFltZuhJmBIT8CoxtaWzPE7
         SBEw==
X-Forwarded-Encrypted: i=1; AJvYcCVqgfuW4vtToQaLxQ7PTGZY7/h3kahxOgvuUdqD483Q5/u0IxemGZe95v01nUD6R7XJoq0tRCeplpXgMxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQqtzro35aEUClK/QUhqm86oO4b5SFl+ySBO3EXJzD5W5Y6ro
	Fm1DYADbNuldxfmiagmKTRP7i+NmIxq8lIzBt6sbK5okvGdMzfmhQQZ5qoJFRkKnV5I=
X-Gm-Gg: ASbGncsApBVdnSWZ0fnG43JcTDl/Fi7/avj5BwitSBl9CX4EfXtyroMg0b2RnXCaPqc
	AhKd+RSWe2/muzKiceBfCCJMDxP4X2gvw5TIR/4gocYkj58lW6Xe2VBTLADqbBtkCVvgpv1Q15+
	L3JvSjj881Y6IWTxhQ6H5/DVvf3rspalZ4eSg6qUDByULLmOJ3GzMod3dw4tSWUTQzD2SJUFv2U
	yo5MArjzo9DQvilvaRsTVDVT3DIAL+Hy65CitIyy5o/uy9DjSXrH7Sz63g2uwGj58K6Q2+5SwTj
	Tg/P8rlxsXt5Hx8LBkDupjXWRONcY7dCJM+3J9/oycnuXBPuBHHTG1Q8gQe9Ta6rfIujyh1G4s8
	yDR0hMgpRb1+VK8alEo8Zcfu3XubdJ66Uf+TK6LoCEYh3pA==
X-Google-Smtp-Source: AGHT+IHMgt+0zW/PIgfBTzkUC4QRR2LPK2PX0oWN+ufDQrYfugv/isEt03oxqHiZLF8dQeUUNB6XLQ==
X-Received: by 2002:a5d:5d0d:0:b0:3b8:d082:41e with SMTP id ffacd0b85a97d-3b8d94cf50fmr8805139f8f.57.1754374691331;
        Mon, 04 Aug 2025 23:18:11 -0700 (PDT)
Received: from localhost (109-81-28-237.rct.o2.cz. [109.81.28.237])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c48de68sm17845841f8f.67.2025.08.04.23.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:18:11 -0700 (PDT)
Date: Tue, 5 Aug 2025 08:18:07 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: akpm@linux-foundation.org, andrealmeid@igalia.com, dave@stgolabs.net,
	dvhart@infradead.org, feng.han@honor.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	liulu.liu@honor.com, mingo@redhat.com, npache@redhat.com,
	peterz@infradead.org, rientjes@google.com, shakeel.butt@linux.dev,
	tglx@linutronix.de
Subject: Re: [[PATCH v2] 2/2] futex: Only delay OOM reaper for processes
 using robust futex
Message-ID: <aJGiHyTXS_BqxoK2@tiehlicka>
References: <aJBKijr1nR1CleBL@tiehlicka>
 <20250804115037.19690-1-zhongjinji@honor.com>
 <aJChI-LMwmuWEwpH@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJChI-LMwmuWEwpH@tiehlicka>

On Mon 04-08-25 14:01:40, Michal Hocko wrote:
> On Mon 04-08-25 19:50:37, zhongjinji wrote:
> > >On Fri 01-08-25 23:36:49, zhongjinji@honor.com wrote:
> > >> From: zhongjinji <zhongjinji@honor.com>
> > >> 
> > >> After merging the patch
> > >> https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u,
> > >> the OOM reaper runs less frequently because many processes exit within 2 seconds.
> > >> 
> > >> However, when a process is killed, timely handling by the OOM reaper allows
> > >> its memory to be freed faster.
> > >> 
> > >> Since relatively few processes use robust futex, delaying the OOM reaper for
> > >> all processes is undesirable, as many killed processes cannot release memory
> > >> more quickly.
> > >
> > >Could you elaborate more about why this is really needed? OOM should be
> > >a very slow path. Why do you care about this potential improvement in
> > >that situation? In other words what is the usecase?
> > 
> > Well, We are using the cgroup v1 freezer. When a frozen process is
> > killed, it cannot exit immediately and is blocked in __refrigerator until
> > it is thawed. When the process cannot be thawed in time, it will result in 
> > increased system memory pressure.
> 
> This is an important information to be part of the changelog! It is also
> important to note why don't you care about processes that have robust
> mutexes. Is this purely a probabilistic improvement because those are
> less common?
> 
> TBH I find this to be really hackish and justification based on cgroup
> v1 (which is considered legacy) doesn't make it particularly appealing.

Btw. have you considered to simply not impose any delay for _all_ frozen
tasks? 
-- 
Michal Hocko
SUSE Labs

