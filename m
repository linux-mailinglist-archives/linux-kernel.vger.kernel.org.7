Return-Path: <linux-kernel+bounces-767888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B53B25A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D9B5C1291
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7718786A;
	Thu, 14 Aug 2025 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FlxAP9rR"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637F2836F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143738; cv=none; b=HAaXA83AtqP1HHXtMz84dpETJZysA6BaLfFwTEA/rdF40NTltixi7ZKA7VjjQjW1vqCUmIuFdHTUKFYNIEWzhkavgcgaPx3qOeUiu7DAyqOGPSgSBadoh8YqE6fv1l3GAx1Bnnxs11ghrWwl5YR7j49DoSZNuiPpVe9bSU/CUNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143738; c=relaxed/simple;
	bh=P0r6EE5TppvnZO59sJ2IINXIbG61ASfSfCOD4Zi30uo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZddrelsMNDuPJvvV9cT3RqDfF0H+WPRV4eo3M8aSw4dru4dQzfOtXdu9DJLZvI+wFPIfm/PM5C0smqDYxfaBZHowkR9Wm6NAO71bhwQk4ewifuQG5YkNSftmXh+0Bh4fflx3zymMdUVKKeE2IXU4llSZBH/2STjMmDPL/0UBbWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FlxAP9rR; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DL98BZ031826;
	Wed, 13 Aug 2025 20:55:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=apbbqv91FA3h7FXFQHnXfhMvw
	syZ1HXos2GmeXwGEU0=; b=FlxAP9rRk93uLRQxTcMSQ7egUm6idpHnO7QkQApHu
	XUPQ7dB20FtsqQ8XG26rDlq1BYORNmeZNaEwtLX51u8mM18wC7anW5cb/r39HX6c
	seY6IipqWUyK2oBfmkrzzpzQPhpuSd+xWJjCqkc8Sk3EAOsi/YeqrohpUOEqEAy2
	54O7sc4EmG57kfX20dWKl/+PNfbNuh31XSF3/yWhsm61abL+9dU/iHpaH8lVKk1V
	n0GPrFaCMN1q6+KbFriAV0+bK7Hm9GwN2EpkQmBwHS/VpR/U0baOSa3UxOhiitCr
	K57D1mskJ0iDgyGMU8mqMuRGZMsbpmrgly3HJYL0ALZng==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48gyb490ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 20:55:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Aug 2025 20:55:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Aug 2025 20:55:07 -0700
Received: from opensource (unknown [10.29.8.22])
	by maili.marvell.com (Postfix) with SMTP id C05723F706D;
	Wed, 13 Aug 2025 20:54:59 -0700 (PDT)
Date: Thu, 14 Aug 2025 03:54:58 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Tejun Heo <tj@kernel.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Query regarding work scheduling
Message-ID: <aJ1eElydTbZfBq5X@opensource>
References: <aJsoMnkoYYpNzBNu@opensource>
 <aJuNcM-BfznsVDWl@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJuNcM-BfznsVDWl@slm.duckdns.org>
X-Proofpoint-ORIG-GUID: CSvy_QKX8skjB4HJ8Xh6NFFhGgtMSSil
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDAyNyBTYWx0ZWRfX2tDBfF7kOdjT 6jTb9xgGYElmj6JP3J1+GXgTYiTlBbeZRg4cSJf7QYwIDr+Y6c8lF07ihbyc8DZTqGfbGg/NbsS oq97afj9o23OI5zCPEx6ZfvLR7k7hzfTSq9nwvT1O6vgJ7PB4yB27+VRVCvQiE6RIdllOlKbc4v
 drVsx1NcI6XrOfKnZoFRlusWzwYMtIBNTdr6E0MQ4px+PQN6WaVD6qEuz+7qH4IzyIfU4q27xuS OQaCzQ7uNyMkvQWrHyCMtikwd8qOdJxD/qxSlGogjOWPPQ7F3g5aUi/DuLu4+MG+J0vbf0dWfpq 976yB1oq1jVk4IBAIYkMRcSXTOwLNYIiwL2YHWLjkHPyHPfe9cQI+e87WJNaogQXABvhX0gyqrv
 6HI8olXHr/oeY0hcMFCY3MDljPdfr1yKmMrZFFikPMlxk2rEOc0tN7WpXbQEA/Ggi1tpDRA6
X-Proofpoint-GUID: CSvy_QKX8skjB4HJ8Xh6NFFhGgtMSSil
X-Authority-Analysis: v=2.4 cv=CqW/cm4D c=1 sm=1 tr=0 ts=689d5e18 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=jNi_2Jb-k-ZJEw492vwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01

Hi Tejun,

On 2025-08-12 at 18:52:32, Tejun Heo (tj@kernel.org) wrote:
> Hello,
> 
> On Tue, Aug 12, 2025 at 11:40:34AM +0000, Subbaraya Sundeep wrote:
> > Hi,
> > 
> > One of our customers reported that when their kernel upgraded from 6.1 to 6.6 then they
> > see more delay in their applications shutdown time.
> > To put in simple terms, dataplane applications are run with SRIOV VFs attached to them and
> > apps send number of mailbox messages to kernel PF driver (PF receives an mbox interrupt).
> > During interrupt handler work is queued and messages are processed in work handler.
> > I calculated the latencies (time between work queued and work execution start) of 6.1
> > and 6.16 and below are the observations
> > 
> > 
> > 6.1 mainline
> > ------------
> > Total samples: 4647
> > Min latency: 0.001 ms
> > Max latency: 0.195 ms
> > Total latency: 7.797 ms
> > 
> > Latency Histogram (bucket size = 0.01 ms):
> > 0.00 - 0.01 ms: 4644
> > 0.01 - 0.02 ms: 1
> > 0.03 - 0.04 ms: 1
> > 0.19 - 0.20 ms: 1
> > 
> > ==================
> > 
> > 6.16 mainline
> > -------------
> > Total samples: 4647
> > Min latency: 0.000 ms
> > Max latency: 4.880 ms
> > Total latency: 158.813 ms
> 
> Difficult to tell where the latencies are coming from. Maybe you can use
> something like https://github.com/josefbacik/systing to look further into
> it? All the scheduling events are tracked by default and you should be able
> to add tracepoints and other events relatively easily. You can also set
Thanks for the reply. I am using simple busybox to avoid overhead of any other apps
or deamons running in background and taking CPU time in between.
I will try building systing and running it. 6.16 histogram shows that it
is not one high latency event causing overall latency but bunch of small
latencies are adding up and causing big latency.
I suspect this has something to do with EEVDF scheduling since this behavior is
seen from 6.6 (please note I may be wrong completly).
Are there any methods or options with which I can bring back CFS scheduling behavior
maybe with the knobs in /sys/kernel/debug/sched/features as a quick check? 

Thanks,
Sundeep
> trigger conditions so that trace around a high latency event can be captured
> reliably.
> 
> Thanks.
> 
> -- 
> tejun

