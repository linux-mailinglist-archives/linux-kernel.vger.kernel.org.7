Return-Path: <linux-kernel+bounces-800740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA39B43B66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057BD7C393E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682FF2E8E1C;
	Thu,  4 Sep 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZI5Dcwk5"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C932E6CAD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988477; cv=none; b=ApifufXUWcsf8yjp+8caK2kDABAhEDIk9iZKRWAUet8Y0Cd+Wab9Y+tdj9CZjsZjbv0LCpBbM9OCI01+BE3uaOJvlvdEV7afpWyVxy64gw/bDu3be2oUjSj4FvheZrlS7zOveSYe0e2Q5z/oLd2xawOHz70A1zMgNEakd8R/iQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988477; c=relaxed/simple;
	bh=T+XTriF+4WkVCT1ai6M/Uu7xej//QGGMxL3mgx3iHCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra3OLydl8EzeFtsxvCM3LOa9zIoOGwec4EIKxQOutElT0lCwOFdQRPk7bm3OTKJUijHyH9ZpCSQSqJEN0Yy8CUj3hMYV+tXmbCrAJvVUzSUZc5d57FJDCcY0jiT4WzIyVLovsYAKltzh8lmWfG/JK8KpwI8PtBn+3mA09HdKYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZI5Dcwk5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b7d485173so6994915e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 05:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756988474; x=1757593274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KSwu43idPPiYLOiYSWlrLCZRiTpUunvv4fRRNFmcqs=;
        b=ZI5Dcwk5voZn0XC8BeftpSdgVBwby6nBt8yYDXV+8c42p4TNrc38ZGWOiCbXaJkdo2
         SXtN+Z4dsfK4Bx7V5QGi83bIWWnwwQbhNlXJQXAwXGlBtSbyB2WRH4w3rVM1WRhD4PWB
         qM42b1F3HTDRhfi00g3TOQY/dG9PuHgkNPjnF/2vKvOiF1w1yJ7XZ6wTKLT8kAmu+10F
         DtzXoTkoV+BjsvNutHAa1tyOfBNslP1HtWU/8egmhaKPIWICjGAuGCo0KcHB2hAlMYtz
         aIwg84fkisUJCr7UFF+35g/1vnqN4K0PgDN3YWjTAlHBe2qQSe0C6P3cUyChuhWS4rsE
         FZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756988474; x=1757593274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KSwu43idPPiYLOiYSWlrLCZRiTpUunvv4fRRNFmcqs=;
        b=ZkhoseKaFR5ZjROs3bhsm8NhUtRLOe+yBmaWbzzw/VX3yY0Zhj9yVPJE7CzdBbs7kx
         fURFnNpQWZPLqlORZXAmLQZFf330dn/840jRrmTwn63rBGeWgdee00FHqCGwOPIzYyuY
         Y0+8KywEDmtaFG1PVAPvJ2Zhw47R8nD/DP6c3ezo/SZOU6Yfu1ps1iqFE5Dt8awzwtqc
         Sdbr1DlmgiVQWthk9/Wvp175CTarOq72+7MgM07DGl9zcckkpVZN7dhJw05AO8dDP/0I
         BqSPfYzuUzxxoWHnE4NR3BeHW+3Lz+mkQ18SWPAT8QyO7wGmOaHj4zhhU0evQPWvS/aY
         xDrw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ23Sdhkpf/xwHiV9O9xTRKvNnKjMuxa8SvbH/Y9wtrQ8geG6GU33tb2VCD1Ga6E/BIX7meRr0tCMS7og=@vger.kernel.org
X-Gm-Message-State: AOJu0YztfvKCd5lfUcxiOvLLSLpn9fSStQlAqkyA5g+vUj197FG2zC4n
	u44qyDMcV3to2LkkWkf2aNVTM/gonZsOFP2WBPE564e0fb1Nrvz4ONGPwLxuqPy9nLE=
X-Gm-Gg: ASbGncsD1WQMjNNlEP3noCB/OXefveU6xSAQkqdjd0zon5jU4CJD55pYXOMrNjvMg72
	Hfids/eNsG+VPeseBB3vERCa6ynvOXaAYLPpJOg0tM9dd+hCOL5TZ83BEicRvQRq7jX7pSmrku9
	Yj3aggtXUz5LBGmVswTgB/9017lbihJPXCYVJXHi7U2ns24g36ZzY8C8xjVuMUURlihXykVkYTv
	K4hLwFByGTm4R73ILXSrAU6NzwejnBzi60fwpGUiExEHGlcYUZuLB0hC0X2bdja1yVRG4NF5AXf
	HXMBSDKQb0gJtgt+GhCAerYPkpCZFouCC41JMbUaWad/PZAo8paggLHJcog/UIAqQMlexJaodVc
	PV4IYnkf8R6a9gX4pXFA6UJJroo0mIDTsOMRJR92+AVU=
X-Google-Smtp-Source: AGHT+IEYqo4eMGN9vgrqjAEA3arfMvfky3hDi4FW+528nveIve9E3HgvQcvsr+KoLTBqDUriy20sxQ==
X-Received: by 2002:a05:600c:310b:b0:459:e3f8:92ec with SMTP id 5b1f17b1804b1-45b85532b05mr169657365e9.10.1756988474063;
        Thu, 04 Sep 2025 05:21:14 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b81a9e971sm295031615e9.18.2025.09.04.05.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:21:13 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:21:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com,
	shakeel.butt@linux.dev, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, lorenzo.stoakes@oracle.com, surenb@google.com,
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v7 2/2] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
Message-ID: <aLmENFH-g9MUQAsE@tiehlicka>
References: <20250903092729.10611-1-zhongjinji@honor.com>
 <20250903092729.10611-3-zhongjinji@honor.com>
 <aLg7ajpko2j1qV4h@tiehlicka>
 <7rvwvuifkav5oz4ftfuziq23wek2bn6ygvrfotpaweypuy7obv@hjuf3eknscii>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7rvwvuifkav5oz4ftfuziq23wek2bn6ygvrfotpaweypuy7obv@hjuf3eknscii>

On Wed 03-09-25 15:02:34, Liam R. Howlett wrote:
> * Michal Hocko <mhocko@suse.com> [250903 08:58]:
> > On Wed 03-09-25 17:27:29, zhongjinji wrote:
[...]
> mmu_notifier_release(mm) is called early in the exit_mmap() path should
> cause the mmu notifiers to be non-blocking (according to the comment in
> v6.0 source of exit_mmap [1].

I am not sure I follow you here. How does this relate to the actual
direction of the address space freeing?

> > > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > 
> > Anyway, the change on its own makes sense to me
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > Thanks for working on the changelog improvements.
> 
> [1]. https://elixir.bootlin.com/linux/v6.0.19/source/mm/mmap.c#L3089
> 
> ...
> 
> Thanks,
> Liam

-- 
Michal Hocko
SUSE Labs

