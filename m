Return-Path: <linux-kernel+bounces-757014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB14DB1BC5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87451859D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67093594C;
	Tue,  5 Aug 2025 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXFgZYUc"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0C23D2B4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431442; cv=none; b=pAm5gL/Wo/aebnVh1bkJCsZUHyEM9e/JtPXwxsS/8E6U53TWckwIfS120wOqImnmw5tZprfqDpzrAMO2+DLchFeuHLse4rdkvpuUZT6aN7rEWuYIKcf3Izxolt7pYM88hy2FZzzVIPpQpfyDBQjPYWJi0qu0Yzljqa0qoiG+zJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431442; c=relaxed/simple;
	bh=mFFKE10cLDXmbFctA60gWhUeSp6HoOukI3ngqSAozUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq75eZ+/Ts8OblOaxQMk4SNjxO7gM1BU9RNRsy35UZPyuabvQ7/nNcAvGSEAhzKjpdt6SoyzJH0jpm7zKUqCKPclN8B3/KtPia0aGz2+rgxNFFkjqaa3ymRmoj0mv6PvE2816mfzWEk22e+ugHyVJ9F3gFyqzmBDwkP0do2lQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXFgZYUc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b785a69454so3039691f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754431436; x=1755036236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vG/zGpYKV8J6ufNjYuyfX0bBFqMzfGcj4WRvI8t9Tcw=;
        b=fXFgZYUcJRbw+GJcV2FOqdEgZZPy58wSXiD5v29szpONSc/6jINTPWqE3FB8LlHSbw
         gOTXPQ2fAgx1FbcVXyitdeRAmgiiShcbW/JEyAAT88t610HiZR38Al4Fv6fqleNAxxY+
         8zBzl5IYtNWmoRzpyuUvXdR871QyoiQL5fivez/4HcOb9jJDPVG0KkyA6ryQEW6WRXAx
         OHKe9WZK/MRzBFK12FzHX7PLCJ5ajfZi/OC1Bn49rrgicCrS2BElyZ7xPXf7geidhCIM
         6WYgZmPdXfPh3x2nyPMZCuTDNieYUQuwbuBAX1d0DNVEOOoVc7a0pZ7LQKXXZgZ/1rKQ
         DiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754431436; x=1755036236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG/zGpYKV8J6ufNjYuyfX0bBFqMzfGcj4WRvI8t9Tcw=;
        b=vtUm6iQqm8MswlyMTbO+S136wE3aMMqlM9nWCiER8trk81y6cCHGezdZF6djM2L/4z
         6ckhsyZqt2x2p3J3a+nbzMjeu6JwafcqIYI44aal3t/nG0DgXWHSnWTC2btjoZHTV6iw
         gSeEiN/enVD5cH4DjwVMogKwmQBOl3pyiPIKUC+kjgu3+9u0DbmtFRrA37hh6uNCuhLE
         qYTKz811qerDWHVWRnsOXVA7kyjKN6t2QrjjZvqB9WrQHUd4+TmkV+ub8tmL0eo37qsY
         9U30J7RB7fcisLqYdB3D5sRwRjh2g7+6eSIwGoDyLsxCxUzNUjBlh7qfaRVgBfqjAqET
         +F7w==
X-Forwarded-Encrypted: i=1; AJvYcCXXmulF577G62GFNUYre0SHA40oEMuQ5y8gkiSN5kni/bC4yYeFOrvX8vUhV1PMFqgVaXqpXbg94EYHEf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzarcy9U3qid/c3upFwqnfOUZmfFbxmS2akZhge07fbQKXFSyCu
	mVISzg+hVMtaxxjwmLK2SD5wGptuPUhJsET8ZtV7cK4YYn0TJUCkipnl
X-Gm-Gg: ASbGncs9GpkL53a1U1EozoPy242tW/3uzTtAL4N975C2zxl1MPyvkShcAHDrz43PBFc
	cScc8kIpeMTzf1usPpdjGvRimD7zCHVd6H0xqn6hfu4SbdJL2AsmVKYD7jj4JMbTq/bds2WUIgH
	QRe4XasRAdBJGOA3uTTwqd/39ewlJer/6nZ/+7T9xlm7K9U5YEFcGK7PqbWAMRp/Ec++BAjWJr5
	Z4cXNKpBtkrUrWhha9wsvLVDh0wzIWKeT0oLplKJiDUD7HCQVIeVTu9xcarCJ1n/InLiccJjzIv
	Te69Ynf2ranPrLPmQVnLeKZ3dClAcgS1geQoeILqvqOiQvMCuD71ft6z8BraxEzx6P15d+7Qqyu
	LW02Nb1tj5pEzHJ16IQIWkIZDU1yklJjs5C5IyP/0Nt0p
X-Google-Smtp-Source: AGHT+IGDHSxB48AUBPyUKumeUaw4oelI0WVvDLFXUcYmt9BJrBy0NtTacGJ6As/c+cW4gPgeFtyCEg==
X-Received: by 2002:a5d:5d87:0:b0:3a5:39e9:928d with SMTP id ffacd0b85a97d-3b8f4851abfmr131368f8f.0.1754431435450;
        Tue, 05 Aug 2025 15:03:55 -0700 (PDT)
Received: from debian.local ([90.252.123.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453328sm21677902f8f.46.2025.08.05.15.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 15:03:55 -0700 (PDT)
Date: Tue, 5 Aug 2025 23:03:53 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] sched/deadline: Less agressive dl_server
 handling
Message-ID: <aJJ_yaD7R2oLsyKv@debian.local>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.465086194@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702121158.465086194@infradead.org>

On Wed, Jul 02, 2025 at 01:49:26PM +0200, Peter Zijlstra wrote:
> Chris reported that commit 5f6bd380c7bd ("sched/rt: Remove default
> bandwidth control") caused a significant dip in his favourite
> benchmark of the day. Simply disabling dl_server cured things.
> 
> His workload hammers the 0->1, 1->0 transitions, and the
> dl_server_{start,stop}() overhead kills it -- fairly obviously a bad
> idea in hind sight and all that.
> 
> Change things around to only disable the dl_server when there has not
> been a fair task around for a whole period. Since the default period
> is 1 second, this ensures the benchmark never trips this, overhead
> gone.
> 
> Fixes: 557a6bfc662c ("sched/fair: Add trivial fair server")
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250520101727.507378961@infradead.org

This commit causes almost every boot of my laptop (which is booted from
USB flash/SSD drive) to log "sched: DL replenish lagged too much" around
7 seconds in to the boot. Is this expected? Just asking as this is a
change in behaviour - I haven't seen this warning before in several
years of using this laptop.

