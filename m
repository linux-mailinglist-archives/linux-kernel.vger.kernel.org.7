Return-Path: <linux-kernel+bounces-832770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0156BA059B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52CA621FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F152E62D0;
	Thu, 25 Sep 2025 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RAiKRMDD"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AD2E1EF4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813515; cv=none; b=sryRQoyWBuHeMfSO9LjJnc5K0dSoff4p4N96yoVAsHkILb1FgWi6GZe77mSY2bv4D9OleKthxbau3B1XEW5JKLsMHMQH4YMU2jCV+qZyzeHFMD022lHxWB0Zb/9/EzqW+hDMf47vMO43FSEcclAndoB2UhjJOk5sE0aSUWUwOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813515; c=relaxed/simple;
	bh=tQp8C7wGPgq++JIxelAFePt8Uis1yK/nhOg9KL0bUXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXF/dkTmYUT+zCFh9cuBxFP7Z1kxd+AkzgODJa3a4XpNv6PbvEw/ko8+T0UpZUtMneuhkW6bBk86Exf/N/xC5gNMx94nUkIa1we04Pw2we5/rcftRH9WJJv86bdrA9tw0KMvSorbk5YmB9Kk2Y68+OOaz0tWOlBonoQ1lOVdvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RAiKRMDD; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4258ac8f64dso9610435ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758813513; x=1759418313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTV7SOBwRvtCz9nLHK3fWm3pn4TCNp2vMjiqO7XDDco=;
        b=RAiKRMDDzY246oBTI+rAokQQrKvUOSk9wT4F7KaB2nvbrRQbQYCMq8IYy0s0gcn3wq
         Id473Hq2nZAI1yro60IEL4lPHG4JNJBnQ9t4wi5WZvVwUr2ABsugO37GDmBeBpHyMNvR
         /PLx+dMyu2PdyojV3UjTmdV3ahvyW3qDXW58vAwOehfi8hjtz5nUSq6jtuSjsV80trT9
         ErggfreMhfyfSN1xIgzyVYz+wi9x3teC8FHmRKYlCd4fqqtAqQx8mxYp9aMJQBBWnnmE
         0pvHRpN6beW5UCa4LcxF8IBR+UCc8ObRV8sERsSnFxJSuYXk6rqpSvSQ1+64gBJ8F38V
         YPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813513; x=1759418313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTV7SOBwRvtCz9nLHK3fWm3pn4TCNp2vMjiqO7XDDco=;
        b=JZWzGJsF9/251WdZVpY+KX5NaO82E69v841Um9cTXsHcx3Fz+THeE5vJ5UM0I/akWm
         mUSjB9LvX+jujmkqlKiaIXQseFHMogq/6AfPsiBaEqMjCOsyQvd3qzUnAm8xgp+uVYa5
         vcQWiz03pXBtfe2gojRYPsIthIlQkq3FuTUPSpP5uhgLIPGuO4AforfK5b6ICu+ShKOH
         PMVG7yFYKjLBwz3DWIV9R6cEQfSm1Qemm1WOM9JN8iJ14lpHprdZ1Fl+jJdGFjA4yYRj
         a6b7JQ7o2t0p1vdANIF+Ir/uruhr0h5N7ocrgah7zu+slJK/2+hSkmSMuwPiHGwm7BHb
         G/SA==
X-Forwarded-Encrypted: i=1; AJvYcCXOn8kGFVZgU7XdxoJLMZyAl2VDEL9osKNu3dpbrr4sSwXJZGFvNCdWL6f2ZINQqG654I/799ayvaDRSQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz7S+bfibp2uMLvZuwKFLkC8bIq4D1DFNe2imPDwdkJ2Em95yd
	+no2HxCy8YvWHWiuM+3qoc0bICIYHq1kdA1Wu1V2o868pU6ja7LLGg2AilkXS/8CKps=
X-Gm-Gg: ASbGnctSnLFRdYBJh5yLhdz3dUSFkTmU/2zgAtQ2iYdhXFa8i4R3QaVdRaEOK3/JaYt
	fS6/1MQQfByW9BkLF+9KYe0TW6XPuzTGzIXdMFmtW9wIDblJoIO+TH+IEuyqxUdHPXpDj9gfgJ/
	XyL3rBh26g5IePBAllOxqXXkbB34h+if8KT2okDvx4mUEw9aDf5kfc/lp5Avzf9QxwTxMuLtG2W
	rW1YUN7+iTrUol7NhzztJ7PF97/14S2L6i1ZZRtsnMVjLsDv+wJwGQp2ZQQH0eOpB0B/XiEw0Hw
	MBQsKcEnVji9qZj5OXkM3Tpg6UE7ISBIngF2jwonie0ZohD521oicawqJZzLrq5K/AMki3b9D1D
	F+mQkCv3pFf6c+AXZvvjutKlBV0dX8DmJUIaBFkKUsmK9Hlc8QOtC+sUsUXGbrqgwrbpko5ayhC
	Q=
X-Google-Smtp-Source: AGHT+IEE6BSjkeOHtrqgDMGp6UEs/8XlcmOungL2XSRC4po6mROif6Vk6dLzPa16z642TGp7LJtOhg==
X-Received: by 2002:a05:6e02:3789:b0:424:7633:9e72 with SMTP id e9e14a558f8ab-42595653cb6mr54081225ab.30.1758813512638;
        Thu, 25 Sep 2025 08:18:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a647da50fsm909985173.15.2025.09.25.08.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:18:32 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:18:29 -0400
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
Message-ID: <aNVdRdXVzXSm_4SJ@gourry-fedora-PF4VCD3F>
References: <20250910144653.212066-1-bharata@amd.com>
 <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
 <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com>
 <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
 <20250925160058.00002645@huawei.com>
 <aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>

On Thu, Sep 25, 2025 at 11:08:59AM -0400, Gregory Price wrote:
> On Thu, Sep 25, 2025 at 04:00:58PM +0100, Jonathan Cameron wrote:
> > Now, if we can put this into a special pool where it is acceptable to drop the writes
> > and return poison (so the application crashes) then that may be fine.
> > 
> > Or block writes.   Running compressed memory as read only CoW is one way to
> > avoid this problem.
> >
> 
> This is an interesting thought.  If you drop a write and return poison,
> can you instead handle the poison message as a fault and promote on
> fault?  Then you might just be able to turn this whole thing into a
> zswap backend that promotes on write.
>

I just realized this would require some mechanism to re-issue the write.

So yeah, you'd have to do this via some some heroic page table
enforcement.  The key observation here is that zswap hacks off all the
page table entries - rather than leave them present and readable.  In
this design, you want to leave them present and readable, and therefore
need some way to prevent entries from changing out from under you.

> Then you don't particular care about stronger isolation controls
> (except maybe keeping kernel memory out of those regions).
> 
> ~Gregory

