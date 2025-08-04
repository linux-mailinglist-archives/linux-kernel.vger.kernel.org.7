Return-Path: <linux-kernel+bounces-754804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222C6B19CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152BA175751
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658D123ABB2;
	Mon,  4 Aug 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U1zUGqPk"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E323ABAB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293945; cv=none; b=XLErYFfVAoUgiF94Hzy0wwAX+/LdGJ8Tj+/NcNF5YzlPn3eLeYbsmXukdVIVpRlMBOkXNVBdlOVhXX1Kp2ZFIui+o9D2HE8xh00aRMYf5YFAooYi9gJWDu/JQBi8BhDi7lgAReMWs+SitGO6wMhjfsu/ARJtR7WPM8DYgcOhy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293945; c=relaxed/simple;
	bh=1eIG8X/E9oyNSR7uva+xqzgKObhITSgSrbvhbP6sB8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdNOQc5t6wx5LqiS3a0cnp4wtCod2/yG4tc2u3fmMiFRs4aYYeC9VAlB/q5W3L0a6PfMzqvQat5EvDBUIO0D3AGkJNBh1zaJssxMZm5KT4XFvDRGN2+c9JeGmNO41/y1/s2nDKBCc9MBRG/mtEDLgwMo99lulmVFpmtVBHwmicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U1zUGqPk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31eb744f568so2799090a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754293943; x=1754898743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VlA85X6ooRUor3EsVJhQwjajZUg2+o0W6AFWPlQlIm4=;
        b=U1zUGqPkPtxd+OKwooQYyUmkjHhriHwVAX5C0WV/Bux04Zg7TVL3ud/Obw1vxPVcaP
         36KfWGcGoXdA1aCo0oBfD5XPezjmAI29pMbR90NZFIBY6XKZp2piBpNYyUw9udS/XMSH
         ayzc2WsvpTvBFwWVCu0gBEplQLKKu4MC4sVsS+6qDlQzznnO0NxmZVa/D0ind1BI6kC8
         EyIJZum5iTydS8/zGM6QNNNFYcYAiWQVCDG6BmUxLVxyCyHe2nt3e88RS33fBe7e5F/O
         ZgRL58VelnieNOEK1e8xZ1lTamGJmlPSlQu1CM/cYfFcxXqdaB/vDKzOiZbQKmoG88Hv
         Ep6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754293943; x=1754898743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlA85X6ooRUor3EsVJhQwjajZUg2+o0W6AFWPlQlIm4=;
        b=J/Od+t5gSwpIuVczvAISCQGbdFISoHeLUoMLEKIf0xgl2Ib4pPyL+rFQFqQsvOZL/I
         TAtJLMN3mPsNAbRQwK+6v749VDBoLZTF9ud2KNT6F4G0xRTQx7wZmzsjqR1AWnCLSgaV
         vB4/TTDT0GBmnrrC/QV28BB7SqLIpG82pAWNsnz/qSUwVR0ad/kMrRJtPAqFWoZrx3t7
         I/Xn2H54yFjiw2sP7IHvhassj7vmJE5xNh1g1QZ85fR865QjDbFG3RYwMDffZPMp7laf
         Lyj/Qu3OXls4zTLvctqa3GxYP3ijLI4hVPbJSQS1kfWfK+JkaWfJBWXv0X7hthJRJHJq
         CAyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVrwrw9sVS4JiXBVirtXEQKgjVOeHosf/dD6XTpXlZ+Enqj5YDhmZYdhWLxML1RCWN41kUItq4IY8UHR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiuM8VS9iUHBPmRbUxOa6358bxuf0ZC4GYVPhwZX16To7MUFj
	MBuOCUQ70NJlpFIUxl8gTEcOuLx5NxxEwwXBLQB4DQqFl+fRubgTpops5GAjmyEarA==
X-Gm-Gg: ASbGnct+j/oi8ta5n/L5Jhrqe8PhsJX67rcbwzloRgsHNXsnJDJJsN1dCttaRKO4pJm
	yuL3nODel224iHpLYIZnmUlPB8wy/11KXpgssG3eMIljSF27aiGamvYAvzojJKwGraOb9CKZYHA
	qUR4B7iPX9P8JnlehJ6e9+bewgPd2/9c7z5C0EAETElQmi4p/C7eMhbTFioXpubC6qtumcKlazK
	RgVG/MmcZpfPZ5GlJaBhvhbhjLiBpGRE8BHxLfEL9OT/fjXCl6jIK8xaoUYY9KzFSrKIPQKGNwS
	S6CgYREW1dXV++8b9mIH8LHEe0qOaK71wPgg+Q1rLh4/FNBkyvpx7fzAsCQlfAnMeUlbzXpSdpG
	/v71wsZ/j/3AcKuK1B+itrR4DKKTt5TfmS4iu/wQnWEICuPWsZcpZiQ==
X-Google-Smtp-Source: AGHT+IGVN/pE1P1Dxy08WIOHEHhVvU+/YjYl482uW+2AsvekquqgXiIYF8Cdn2tTFHzWdedYqm4feQ==
X-Received: by 2002:a17:90b:1d02:b0:312:26d9:d5b2 with SMTP id 98e67ed59e1d1-3211611b075mr13277085a91.0.1754293942663;
        Mon, 04 Aug 2025 00:52:22 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f35f90sm13751448a91.35.2025.08.04.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 00:52:22 -0700 (PDT)
Date: Mon, 4 Aug 2025 15:52:04 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Matteo Martelli <matteo.martelli@codethink.co.uk>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 0/5] Defer throttle when task exits to user
Message-ID: <20250804075204.GA496@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <a3b3eefb208f06b0c55f889495376248@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3b3eefb208f06b0c55f889495376248@codethink.co.uk>

Hi Matteo,

On Fri, Aug 01, 2025 at 04:31:25PM +0200, Matteo Martelli wrote:
... ... 
> I encountered this issue on a test image with both PREEMPT_RT and
> CFS_BANDWIDTH kernel options enabled. The test image is based on
> freedesktop-sdk (v24.08.10) [1] with custom system configurations on
> top, and it was being run on qemu x86_64 with 4 virtual CPU cores. One
> notable system configuration is having most of system services running
> on a systemd slice, restricted on a single CPU core (with AllowedCPUs
> systemd option) and using CFS throttling (with CPUQuota systemd option).
> With this configuration I encountered RCU stalls during boots, I think
> because of the increased probability given by multiple processes being
> spawned simultaneously on the same core. After the first RCU stall, the
> system becomes unresponsive and successive RCU stalls are detected
> periodically. This seems to match with the deadlock situation described
> in your cover letter. I could only reproduce RCU stalls with the
> combination of both PREEMPT_RT and CFS_BANDWIDTH enabled.
> 
> I previously already tested this patch set at v2 (RFC) [2] on top of
> kernel v6.14 and v6.15. I've now retested it at v3 on top of kernel
> v6.16-rc7. I could no longer reproduce RCU stalls in all cases with the
> patch set applied. More specifically, in the last test I ran, without
> patch set applied, I could reproduce 32 RCU stalls in 24 hours, about 1
> or 2 every hour. In this test the system was rebooting just after the
> first RCU stall occurrence (through panic_on_rcu_stall=1 and panic=5
> kernel cmdline arguments) or after 100 seconds if no RCU stall occurred.
> This means the system rebooted 854 times in 24 hours (about 3.7%
> reproducibility). You can see below two RCU stall instances. I could not
> reproduce any RCU stall with the same test after applying the patch set.
> I obtained similar results while testing the patch set at v2 (RFC)[1].
> Another possibly interesting note is that the original custom
> configuration was with the slice CPUQuota=150%, then I retested it with
> CPUQuota=80%. The issue was reproducible in both configurations, notably
> even with CPUQuota=150% that to my understanding should correspond to no
> CFS throttling due to the CPU affinity set to 1 core only.

Agree. With cpu affinity set to 1 core, 150% quota should never hit. But
from the test results, it seems quota is hit somehow because if quota is
not hit, this series should make no difference.

Maybe fire a bpftrace script and see if quota is actually hit? A
reference script is here:
https://lore.kernel.org/lkml/20250521115115.GB24746@bytedance/

> 
> I also ran some quick tests with stress-ng and systemd CPUQuota parameter to
> verify that CFS throttling was behaving as expected. See details below after
> RCU stall logs.

Thanks for all these tests. If I read them correctly, in all these
tests, CFS throttling worked as expected. Right?

> 
> I hope this is helpful information and I can provide additional details if
> needed.
> 

Yes it's very helpful.

> Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
> 

Thanks!

> [1]: https://gitlab.com/freedesktop-sdk/freedesktop-sdk/-/releases/freedesktop-sdk-24.08.10
> [2]: https://lore.kernel.org/all/20250409120746.635476-1-ziqianlu@bytedance.com/
> 

I'll rebase this series after merge window for v6.17 is closed and
hopefully it's in good shape and maintainer will pick it up :)

Best regards,
Aaron

