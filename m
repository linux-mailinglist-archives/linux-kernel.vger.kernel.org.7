Return-Path: <linux-kernel+bounces-881723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF25FC28CF9
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD26E188F171
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB1A264628;
	Sun,  2 Nov 2025 10:07:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F263217BA1
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078020; cv=none; b=FaBBtH6xyadVybkSmj1deWXrXBBAYD2qhNF6+72k2KSm0Je5N8ds+degRPsTsOIbx3SrPFCp/yirJUQ6erLniBP23f9tTiskKqUjwXGh2XuaYFsx4kphhJXQU6ZRFzCtYQU1XHWtAWJFvqje48Fc3KsyeQOXPod0kxqtk7p/hSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078020; c=relaxed/simple;
	bh=JygHM299GdZ8qikZgduAxGAntWAALv9ic24nITIHhy4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wxjykj8wUnoTbi5TC0zIdzKXd0p9ClsQwUD4iW2hl7Ss93jUaJq60ACc9AwazybrTfUfIw0EL6HdEFp2dhTFn4JqfhD2vRIw9LSTFzkAafAcmKYx01RqJ41Q7JVrgqAkBi7JeBQVL3vphI7dq+QJ682EhDrhsOfrILb931WGBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496381BB0;
	Sun,  2 Nov 2025 02:06:43 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E4473F7D8;
	Sun,  2 Nov 2025 02:06:47 -0800 (PST)
Message-ID: <a27b7500-0d4d-47b2-846d-b382d0c1c16d@arm.com>
Date: Sun, 2 Nov 2025 10:06:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
From: Christian Loehle <christian.loehle@arm.com>
To: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Shubhang Kaushik <sh@gentwo.org>,
 Shijie Huang <Shijie.Huang@amperecomputing.com>,
 Frank Wang <zwang@amperecomputing.com>
Cc: Christopher Lameter <cl@gentwo.org>, Adam Li
 <adam.li@amperecomputing.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
 <394a9798-06e4-4e61-b081-eeecbc67a22d@arm.com>
 <MW6PR01MB8368CC4C901DBAF9BE19579EF5F8A@MW6PR01MB8368.prod.exchangelabs.com>
 <fb34c6d2-291e-4b03-bfd8-372a6cd464ba@arm.com>
Content-Language: en-US
In-Reply-To: <fb34c6d2-291e-4b03-bfd8-372a6cd464ba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 18:11, Christian Loehle wrote:
> On 10/31/25 16:59, Shubhang Kaushik OS wrote:
>> Yes, I agree that EAS approach is not suitable in this case as they require a heterogenous CPU topology.
>> The issue is that the existing checks are for a completely idle CPU, whereas `cpu_overutilized` implies
>> the CPU is busy but not yet overloaded. I ventured into EAS as this `cpu_overutilized` relies on
>> `sched_energy_enabled()` being active. The point I wanted to convey is that - we still need a `cpu_busy?`
>> check to make use of the cache locality - for SMP systems. Would appreciate some pointers on the same lines..
> 
> So the main issue is that with existing code if a CPU is "overloaded" isn't all that well defined.
> For EAS we know if !rd->overloaded => all CPUs are !cpu_overutilized(). We could just pick any where

rd->overutilized is what I meant of course...
Hopefully the point is still clear, with EAS (and CAS given some limitations) we can answer the "is this
CPU _busy_?" question by just looking at that CPU.

