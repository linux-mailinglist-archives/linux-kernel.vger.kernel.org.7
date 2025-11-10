Return-Path: <linux-kernel+bounces-893313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92AEC4710A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A883AE88D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B53126B8;
	Mon, 10 Nov 2025 13:55:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A420D4FC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782945; cv=none; b=kRdDpQR0yceuZqNPOqKT3uFMFqY3HbNt8tYRe4QrItmKChNSyFDSIVDRxukQ7NbuBQX4KCbox1hCgHsjaTZ/hMoJGJCqDZjrRGGSx4IQW5rca3LdbaV/Nv4Me+s241MhR5sYJZ1RQm7Xtn5pSJeZcVmtxBTUtbbgMw/1HxDnQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782945; c=relaxed/simple;
	bh=Q55XP2cihs0ttF7sccUQCdpYM2FPw+v4l8tiSBLfKss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMJ/dIEhpCYpVXsBy9nUxFGwmQaWvfsKYNboqlIo74Dx5LVXUCAPFjRrlRkbbUKDBZ9qXRQ8nCty19iCdQCM+h9qEnGQieDi4br7PkP/ntXecvnxqfqzIOLJcmvOBpq+myJhbpH0HQU82laLKooo2bPANFyuK7536yowm0DL5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D917FEC;
	Mon, 10 Nov 2025 05:55:35 -0800 (PST)
Received: from [10.57.88.175] (unknown [10.57.88.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E2EB3F66E;
	Mon, 10 Nov 2025 05:55:40 -0800 (PST)
Message-ID: <341aef79-43fd-43a6-b5b7-ad4689ba394e@arm.com>
Date: Mon, 10 Nov 2025 14:55:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/fair: Proportional newidle balance
To: Peter Zijlstra <peterz@infradead.org>, Chris Mason <clm@meta.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>,
 Adam Li <adamli@os.amperecomputing.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, Josh Don <joshdon@google.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20251107160645.929564468@infradead.org>
 <20251107161739.770122091@infradead.org>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20251107161739.770122091@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.11.25 17:06, Peter Zijlstra wrote:
> Add a randomized algorithm that runs newidle balancing proportional to
> its success rate.
> 
> This improves schbench significantly:
> 
>  6.18-rc4:			2.22 Mrps/s
>  6.18-rc4+revert:		2.04 Mrps/s
>  6.18-rc4+revert+random:	2.18 Mrps/S
> 
> Conversely, per Adam Li this affects SpecJBB slightly, reducing it by 1%:
> 
>  6.17:			-6%
>  6.17+revert:		 0%
>  6.17+revert+random:	-1%
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Results with OLTP 'hammerdb - mysqld' on Arm64 VMs

				NOPM		P50 latency

6.18-rc4			baseline	baseline

6.18-rc4+revert-155213a2aed4	+13%		-8.8%

6.18-rc4+patchset		+11%		-8.2%

6.18-rc4+patchset+NO_NI_RANDOM	+13%		-8.6%

Pretty consistent with the results on the previous version. Although I
hadn't tested NI_TARGET+NI_RANDOM back then.

http://lkml.kernel.org/r/f6379aa6-459d-4205-96ea-9848e55d7f9c@arm.com

In case (pure wakeup) schbench configs are the only workloads profiting
from NI_RANDOM, make NO_NI_RANDOM the default?

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]

