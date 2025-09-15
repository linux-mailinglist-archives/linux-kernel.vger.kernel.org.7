Return-Path: <linux-kernel+bounces-816028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7CAB56E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E332D1784C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8695721885A;
	Mon, 15 Sep 2025 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Eyb8bv1w"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35861D47B4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757903971; cv=none; b=W8dM2ZG6QY6YVekSGSQh3BEHTK5lpKuIyM2GmxFVHqBZ0CB8rCaz9ofgE967HzFQLXHII0/YWVA8zgdAuYYMAUc/BdJIk2wsfVpbYp3w7x6kGP2i8yFRBchlocm+lnjntJ0uLTvDyGng1oZLMY22QW6vr6Ljc20nl5Jqe2Saz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757903971; c=relaxed/simple;
	bh=Lt0kSfrTyRfsC4GraX/vEw0186wdfTtG/5viifsvvpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIgFtIsUVvckPs0ct0Epn7IYrYW2AU5UXWW87+5uXZHDkkITBlr0qcgaILmRJuBPtlDWC/HiT4OkdD6oP1VvVdAMqX5RTo3EiZwC+qoLh9j5R5y5tcu2FvwKx7jv1BMdUtruAtcVr2mKh4LGA24I8FnjBE4/2Hz9gw7Ah+Tq9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Eyb8bv1w; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757903959; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=m4nXMa/ws/fRzMbcI4Y9klkr9xQMmrM9BMlN0jLBR2Y=;
	b=Eyb8bv1w+LpmShayPFa+7Yu7vBsCfW3+fT/DexFXwm86M5XBeVSUO93rg5OErYtv1txszvrxkL8ByZ/Fde0CWkBiK3rvd99lijkZhAlRYjI+vs9Clv/WeJGXIb4hYOG2C2mheB6eilv3LkETeTJ9OnQ3xmvTdVR0hyQAdrwJ6rI=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wnx04wW_1757903955 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Sep 2025 10:39:19 +0800
From: cp0613@linux.alibaba.com
To: krzk@kernel.org
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	cp0613@linux.alibaba.com,
	guoren@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: Re: [RFC PATCH 1/4] dt-bindings: riscv: Add trace components description
Date: Mon, 15 Sep 2025 10:39:15 +0800
Message-ID: <20250915023915.630-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a1749113-0b7e-43e7-a603-d1cf00c6a03f@kernel.org>
References: <a1749113-0b7e-43e7-a603-d1cf00c6a03f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Sep 2025 19:24:39 +0200, krzk@kernel.org wrote:

> > This patch has added property definitions related to the riscv> 

> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94> 

> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.> 

> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.> 

> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.> 

> Please kindly resend and include all necessary To/Cc entries.
> </form letter>> 
> 

> > trace component, providing a foundation for subsequent driver
> > implementations.

Thank you very much for your review.
My next resend will include all necessary To/Cc entries.


>> +    items:
>> +      - const: riscv_trace,funnel-controller>

>You need to start following DTS coding style.>
>
>

>> +  reg:
>> +    description: A memory region containing registers for funnel controller

Indeed, the current dt-bindings are very primitive and may contain some
errors. I should improve and check them before sending them out. I will
pay attention to it next time.

Thank you,
Pei

