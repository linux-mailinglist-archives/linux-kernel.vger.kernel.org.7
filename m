Return-Path: <linux-kernel+bounces-755065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3FB1A0D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F17C27AB599
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C41F21A440;
	Mon,  4 Aug 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JScuRvZX"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586F1F948
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754308905; cv=none; b=FYSl8RyUKwKtSXFbfrjG2vS/heKzsG/Ck9TyW0p2zM1a0WDhh5SqITSbdMYxbnwW3rRkWFh592rmBNNPQKZA5IVE8U3DqzuQfF/kW0QEDtE5En8+SEz44S2EDKUaJWgdj4gXhvv84D3ZOm5UMdLiqcyaojHcTNsrHFqqt4oOI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754308905; c=relaxed/simple;
	bh=ii9r7Nx6sx3dq/fAMbeGJyAFCO+HacqwPGSXrcMn79I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOMhERAtKz0zpP3ffh3DgRwXuEoXVbVlgFWRcU1dUhe+FZVTrkDOm47FxnfHtZI8bU41d7QvZDAPrcEt0+GDia05SiYbxPJ1WmIjKn7WtMDc2jP/IJ+5nsncgty3O67JesZDvArWRCZzKEJZdEfLTiAH5058xVSM1gSoWUf2ELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JScuRvZX; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so2285875f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754308901; x=1754913701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=di0riGk55zczJ8EKh7rIQmPGFzsVtoO3pRBdq0GJStM=;
        b=JScuRvZX1I8IehNbSrVqAB59ki0IxHByYApD1VnacJuVrfdG8dG2f60oXkWruEKx+O
         zCgk4JNXtUCmz14AgfdUufQzX/I51FYzIQHAMNLvtlxtXQs6ufa61gcMoWb0xKNQsGV2
         PiD743oqj+X6AzIMDPn3kVYQ4Q1h7H/XpNJJ0oJumXT1BqOHLl6Xi8qrdRwK57YtbvgM
         L77g6StVzF9Qr8uMgt1FGZTBaiEJ2+8aB5SNoLG0YSAXjD/l2zG/483Xy6t200YaHgEN
         FsGvOlR+PsYeNG9JXjHLIRAGxwdNwd+upBnWfQPTKObXSml1++nhnfj1X9XDjQt3iyvl
         v3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754308901; x=1754913701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=di0riGk55zczJ8EKh7rIQmPGFzsVtoO3pRBdq0GJStM=;
        b=ZSnF6dDVDvL+iOVDeUebvRuMsUhUWTqgC0hvgmyq5uWbBNpP9l/p0Uvib0G6gkoDQP
         R88LQ2iSLRgozy7o+uGJGkpu8M391NDeRUx1BouOnKoIL2C3K+JqX/hKjmeu5sWtkE58
         v3balw1d2z5seqaiaWhQeXmJLmgjT+F6snc2+v1946n2pxfhCoz9h5fs+bzJEOGRyFki
         mJSnWoR+um4aB1l6IemtbUJ6Qdye7kkfj9D+CVUto5nV8Bna1vLs0EyH+KSxe3khNU9S
         /6Nog/SAMhYxLF4DB0JiyVtibYLSayOChxTS0f+ccK58TUQ3Q/++LXyQPuiyaUQojb8v
         6h0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDf6f8zJLdufgF4Tkva6+nfHBwjlRTDLhn/jfObwaEx2AX3Arr500XUizg1H8KyKNutQkmmeWFVHqqHa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5ptz9+KiHLEjFOHn7lRBIIyewZonDQxNJcv92tYsKLcUy8Vf
	ssXqxook54GFR4hIKEcwnUN1gJqM85s/v83S9Rz9/cd/UB62/dO9eqjJZkUwFScbwl4=
X-Gm-Gg: ASbGncv02errxAU5UU7oHZW/L3JD0zHLWGhLWIdSJ3Oxm+bbONHZnioMZSXc6Sjk/ID
	bTXsftVVZGgZLVwQXvn/Cd92+zjfdmlDMae6uj7NsCj871AP8nneSAhiUIK5o2Z55PTma+wbsgc
	2UhyaAFaAnyov1vqXSlJQK3y1kovXn6uqTVvj4jKEuYI9VUPTXHAJGXuS0ljYvIi6j5dHCa3/eL
	wf1U4I9BbkeUVdoYbePkueUBtVb69JX0X6QG6S3FS7hM54M1uGIC5i4EafRaLwA6vsw/YX32Mvp
	ww4+wlHWxK/H/kvUcW16CIjFmvHQWeRA0677khE06cHwPSJSPs73Tg7LHXlXmxS1szbqXQJIqYO
	tLzwLgkxXoOtBteJM2oQJG0gaXCPXH9o51ABnGXFpwIRdC0GswrmUmzOHkCGh5mWEA4zEnfOjat
	4CKMYY+Shdvg==
X-Google-Smtp-Source: AGHT+IHfc6goQ2eQE1kJNjz643XdqtkTBVPtH0xaI41xMBeazuSFtl5v9S2g96GLz7oEgyca65kjdQ==
X-Received: by 2002:a5d:5c84:0:b0:3b5:dc07:50a4 with SMTP id ffacd0b85a97d-3b8d94680admr7291293f8f.2.1754308900480;
        Mon, 04 Aug 2025 05:01:40 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-8394-58e6-9e1a-64e5-71bf-cbcb.ipv6.o2.cz. [2a00:1028:8394:58e6:9e1a:64e5:71bf:cbcb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b8e054036bsm5498660f8f.31.2025.08.04.05.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:01:40 -0700 (PDT)
Date: Mon, 4 Aug 2025 14:01:39 +0200
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
Message-ID: <aJChI-LMwmuWEwpH@tiehlicka>
References: <aJBKijr1nR1CleBL@tiehlicka>
 <20250804115037.19690-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804115037.19690-1-zhongjinji@honor.com>

On Mon 04-08-25 19:50:37, zhongjinji wrote:
> >On Fri 01-08-25 23:36:49, zhongjinji@honor.com wrote:
> >> From: zhongjinji <zhongjinji@honor.com>
> >> 
> >> After merging the patch
> >> https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u,
> >> the OOM reaper runs less frequently because many processes exit within 2 seconds.
> >> 
> >> However, when a process is killed, timely handling by the OOM reaper allows
> >> its memory to be freed faster.
> >> 
> >> Since relatively few processes use robust futex, delaying the OOM reaper for
> >> all processes is undesirable, as many killed processes cannot release memory
> >> more quickly.
> >
> >Could you elaborate more about why this is really needed? OOM should be
> >a very slow path. Why do you care about this potential improvement in
> >that situation? In other words what is the usecase?
> 
> Well, We are using the cgroup v1 freezer. When a frozen process is
> killed, it cannot exit immediately and is blocked in __refrigerator until
> it is thawed. When the process cannot be thawed in time, it will result in 
> increased system memory pressure.

This is an important information to be part of the changelog! It is also
important to note why don't you care about processes that have robust
mutexes. Is this purely a probabilistic improvement because those are
less common?

TBH I find this to be really hackish and justification based on cgroup
v1 (which is considered legacy) doesn't make it particularly appealing.

-- 
Michal Hocko
SUSE Labs

