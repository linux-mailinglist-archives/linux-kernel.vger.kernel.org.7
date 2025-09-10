Return-Path: <linux-kernel+bounces-810175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D48B516E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECF217B34E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4609C3191DE;
	Wed, 10 Sep 2025 12:29:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BBF28C5A3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507362; cv=none; b=j0SVtbQq8rhMEoFgREUdLCQ3YhbtTWrEAzTchL8QQPnLmu2H7k/AuQzMPwxWGp/gj1hed+fFv6oqCSdTT3W7M3MxoNbKI7L8HuYZJMP8e4zhhwM8gO4CuNZQ+ZylhX8+seLJLRYV1QjdsA1KuilH2BGko9Ix7NU6oIj4/imZESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507362; c=relaxed/simple;
	bh=VjeS1Oq6pZ2M0Y0kHRCEkN09rm3/MU2O5a5jPzXpsjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DleGcAW8HtpWwJGh1uI9oUwjB5O8o6BTHHP9LecvAyYAgb1IzR137IhFKmy+FMfsPXcQUIrj+CuSseZUeYwiQ9oFibJ45bKS4mrJ33f3xzv77fBDgg7uFOBW0SMHQWyNpC2bnifaLyqyVcBv31E51rp5TioT3TJdzfjCIaqDegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0249C16F8;
	Wed, 10 Sep 2025 05:29:11 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EF183F694;
	Wed, 10 Sep 2025 05:29:18 -0700 (PDT)
Message-ID: <fbd3abce-9e99-4099-86e2-8299edf6d46b@arm.com>
Date: Wed, 10 Sep 2025 14:29:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle
 balance fails
To: Ryan Roberts <ryan.roberts@arm.com>, Chris Mason <clm@fb.com>,
 peterz@infradead.org, vincent.guittot@linaro.org,
 linux-kernel@vger.kernel.org,
 Aishwarya Rambhadran <Aishwarya.Rambhadran@arm.com>
References: <20250626144017.1510594-2-clm@fb.com>
 <e5277634-1d06-456c-bb57-2c0a9e245b4a@arm.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <e5277634-1d06-456c-bb57-2c0a9e245b4a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.09.25 20:21, Ryan Roberts wrote:
> On 26/06/2025 15:39, Chris Mason wrote:

[...]

> I'm seeing a ~25% regression in requests per second for an nginx workload in 
> 6.17-rc4 compared with 6.16, when the number of simulated clients (threads) is 
> high (1000). Bisection led me to this patch. The workload is running on an 
> AmpereOne (arm64) system with 192 CPUs. FWIW, I don't see the regression on an 
> AWS Graviton3 system.

Can you look for any sched domain hierarchy differences between
AmpereOne and Grav3?

I assume Grav3 is bare-metal?

> I'm also seeing a 10% regression on the same system for a MySQL workload; but I 
> haven't yet bisected that one - I'll report back if that turns out to be due to 
> this too.

Is this the hammerdb test in which the SUT hosts the mysqld? Which
params (#Virtual Users, #Warehouses, ...) were you using?

> I saw that there was a regression raised against this patch by kernel test robot 
> for unixbench.throughput back in July, but it didn't look like it got resolved.

Can you run the unixbench shell1 test on AmpereOne to see if the
regression in nginx is related to this unixbench test?

[...]

