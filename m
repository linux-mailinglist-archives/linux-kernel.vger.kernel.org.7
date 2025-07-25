Return-Path: <linux-kernel+bounces-746188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCB3B12405
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD35AE4DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1576257AC8;
	Fri, 25 Jul 2025 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="XcBSC0MN"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66A253954
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468470; cv=none; b=cW4oCkHMmXgNYLSnjx30Ptc2gigGqsuvaXpkHAwFW5QfpjmKHhK1KQYUhk7cpFVHGeF+z7yoQYmIqjoUDI2Lcaq1i9bJnJyohYENOzdluol76vfr9l3h2E50Thj796WFjzSHipTI0iOEi/s6YlNyOCPfb1N3nVft+AHSZTqnD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468470; c=relaxed/simple;
	bh=VtJMjwMBfHlnxBICVJgyHpMrt/yAcG3H4zHkyxo9aUI=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=alPu5nLSR3lFE97HngHJhVBBkuBds+cRx+THFjY2z70v8bAwy+O17bJ5323jC+B8CAO5qsHwKptdxAB0VMF9hxU26Yz2enpsbs0gM8HnUpSgAQm175Ig3vki9zDsXS472xsXFRq9HCNSy1ygUHO7xxCMAzJ17CA18dcnekly+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=XcBSC0MN; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:References:In-Reply-To:Cc:To:
	Subject:From:Message-ID:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=weQtTj9EZmxo6xWZiY4sIqlRmWUQ1uVg8ojMMgyjSrE=; b=XcBSC0MNa0sEUBPnn4PKBNqyg9
	smKeQzBi8XYXUkNDFt1UAhtQ3IgtwKEOtYWQ/tbNzk7RdepTmv6g9d0VmkqqACrVZPyZ0Gll7OBpB
	F0GxBwW0qgVuCh/Xr9Ug8rxOb+OA77vUULmgXtZZte3JIZe2iZVXcK3whIJ5eQCNAtWWCRY26hR/B
	BL0DQ2Q2QPCdnolXNtxzEa/NNh3Lf4DN32NxVcVVVkre5fCRs0od9iob4AtdhXkrBkeqcTzBA6TZ6
	n/cedT+bFcGBQMBFmV4NZXjT9ZG1C9VDpV07UiSO9zlBNZz4nATjqhzXOag+tDYlZYf2oRNGw9nIW
	JDj1i88A==;
Received: from [109.54.187.100] (helo=localhost)
	by imap5.colo.codethink.co.uk with utf8esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1ufMmk-00803F-WA; Fri, 25 Jul 2025 19:04:47 +0100
Date: Fri, 25 Jul 2025 20:04:45 +0200
Message-ID: <094f8017f1d9a76ced80e75168de4cd3@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
Subject: Re: [PATCH v2] sched/deadline: Remove fair-servers from real-time
 task's bandwidth accounting
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Matteo Martelli <matteo.martelli@codethink.co.uk>
In-Reply-To: <20250725164412.35912-1-yurand2000@gmail.com>
References: <20250725164412.35912-1-yurand2000@gmail.com>
Sender: matteo.martelli@codethink.co.uk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Yuri,

On Fri, 25 Jul 2025 18:44:12 +0200, Yuri Andriaccio <yurand2000@gmail.com> wrote:
> ...
> @@ -1688,17 +1690,14 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>
>	cpus = dl_bw_cpus(cpu);
>	cap = dl_bw_capacity(cpu);
> +	max_bw = div64_ul(cap_scale(BW_UNIT - dl_b->bw, cap), (unsigned long)cpus);

This line exceeds 80 characters width. Perhaps it needs to be split.

> 
> -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> +	if (new_bw > max_bw)
> 		return -EBUSY;
> ...

Beside that minor note, I retested the v2 of this patch with the same
tests I ran for v1 [1]. I confirm that stress-ng and runtime variations
commands provide the same results. Also no warning is produced anymore
as I also applied Juri's patch as you suggested [2].

Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>

[1]: https://lore.kernel.org/all/86013fcc38e582ab89b9b7e4864cc1bd@codethink.co.uk/
[2]: https://lore.kernel.org/all/20250725152804.14224-1-yurand2000@gmail.com/

