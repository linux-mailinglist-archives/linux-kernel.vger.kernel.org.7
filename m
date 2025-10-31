Return-Path: <linux-kernel+bounces-880067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CC4C24CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CF346275C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F0B345CCA;
	Fri, 31 Oct 2025 11:32:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E23A1CD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910341; cv=none; b=YjDLsyRsJq5OK/2aKeb1ILz/y+JM88zQTuaZ9tXs4rUzj+D1BEAnP7pYmawi266FiXjZculAFrIkHlEF0GaUGZ02uOAMskUGWSQMy3ibGuYN6kpvk/5T1SDv3yed8ul2c04GBDVAoht98p5SXbdTXy5IpCDZ+ahEv1LBd0ccnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910341; c=relaxed/simple;
	bh=FlvaNo2diJDK7tG97oUZUZuXx71KGSMPgDS4fXcHkmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cF55isSrbH758vVw/1C3Z42prbgtULtU08e1DQqtR2ucuzTlcFR6U3fiAHrxQRT/Iv5TdNMnuhog5voCHuxjrXlNchm1OQuzTpr9F6GGGY/ibPalRr6rI9BPN+CBmTreHVsq/Dr9kPu/FU2hSOM54UJIUxL+B+cbR1C7YEyuUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DBE91595;
	Fri, 31 Oct 2025 04:32:10 -0700 (PDT)
Received: from [10.57.86.182] (unknown [10.57.86.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4692F3F66E;
	Fri, 31 Oct 2025 04:32:15 -0700 (PDT)
Message-ID: <b8cb522a-83be-49ec-a4ca-5c084757fb67@arm.com>
Date: Fri, 31 Oct 2025 12:32:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
To: Shubhang <sh@gentwo.org>, shubhang@os.amperecomputing.com,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Shijie Huang <Shijie.Huang@amperecomputing.com>,
 Frank Wang <zwang@amperecomputing.com>
Cc: Christopher Lameter <cl@gentwo.org>, Adam Li
 <adam.li@amperecomputing.com>, linux-kernel@vger.kernel.org
References: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
 <c22de852-f2f6-48d7-831f-ca2a06365783@arm.com>
 <d1cbc53d-d4cf-bc5a-6468-89e9a1d86f33@gentwo.org>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <d1cbc53d-d4cf-bc5a-6468-89e9a1d86f33@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.10.25 17:35, Shubhang wrote:
> The system is an 80 core Ampere Altra with a two-level
> sched domain topology. The MC domain contains all 80 cores.

Ah OK. So I assume the other SD is CLS with 2 CPUs?

Does this mean you guys have recently changed the sched topology on this
thing? I still remember setups with 2 CPUs in MC and 80 CPUs on PKG.

If this is the case, is:

db1e59483dfd - topology: make core_mask include at least
cluster_siblings (2022-04-20 Darren Hart)

still needed in this case?

> I agree that placing the condition earlier in `select_idle_sibling()`>
aligns better with convention. I will move the check (EAS Aware) to the
> top of the function and submit a v2 patch.
I can't imagine that you run EAS on this machine? It needs heterogeneous
CPUs which you shouldn't have. Looks like that Christian L. was asking
you already on your v2.

[...]

