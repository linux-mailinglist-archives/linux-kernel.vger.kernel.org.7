Return-Path: <linux-kernel+bounces-828541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4530EB94D78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC9B2E1E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB053164BE;
	Tue, 23 Sep 2025 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PBOpwCeb"
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483973164B7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613507; cv=none; b=hRyWzF7OjBWp3VnaNtVdmN6cvCUlL88p/JtFeHYkGfD3NR/ZVPXI29nWMSaT97rFeoXxmisjT/uLg/i2TDiI1zEMQSkidy0RVkAhdRrhmKx8AvFvlnNw0sie+/14I+wjh0OLZ+ScybgaCRYx08841RYBNc7wtLhrL0iJ8HE4+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613507; c=relaxed/simple;
	bh=OHwitxOi+fghjU6YCMPaX/QifyqAlHRroxkWimqe+Gs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3ciNM32DLLE2la7kgxGLcPCL5yQ8HSTe4qSH2n0vChmDbNJBYQXf5UhGbUBzlq3WtMS1/lR4gk3IJyLNGVukUTq4ntRQfFU+N8QdnYuTB9id93nIGoii98ekMAGrLnM75JFjSSDtN2WC/mytabY//7dHlN8YFFyhffrXbViRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PBOpwCeb; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758613505; x=1790149505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=te8Nz22LzEQWAozvZwZo5W1+tBxYIpU62PWUskhULw0=;
  b=PBOpwCebW7Sl7L1JTSSfPClhDbStnkbjiqIUiqM0rT+ILh3vKui+SMVn
   ytFVsmnNxF9JIpGMk8c8NPAjcdagALieRMtoA8N94L284UaryvoC43R1N
   rJUaOyzAtVUImaFyTu+bdjKS4JIdmDA3pHLiMDY83YGlKzePHG1hFAzPi
   BQ6D00dLZ/ehu6ZG6Yy2OXsX2GjPHEb7O11bOOaEcd0Yr5ItByLg33ytv
   Pv3rlcGAl7tP/9Y17Deq+xreYXfEfeUCjshQSBO7vXENXWImJ6sJ55pzS
   5B6siZScE8FEhfa9cS5rK6/UEM92v/7tQGtHd8uE/Uh0Fk8oa+VuJEKqc
   Q==;
X-CSE-ConnectionGUID: b4Y9CQ77TGmGvD+Jq3lV+Q==
X-CSE-MsgGUID: GNUD3UtqTIGlykOKMxaTuw==
X-IronPort-AV: E=Sophos;i="6.18,287,1751241600"; 
   d="scan'208";a="2420924"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 07:44:55 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:11354]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.230:2525] with esmtp (Farcaster)
 id 27a8ad14-bb77-4ed2-8725-5449fe36e242; Tue, 23 Sep 2025 07:44:55 +0000 (UTC)
X-Farcaster-Flow-ID: 27a8ad14-bb77-4ed2-8725-5449fe36e242
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 23 Sep 2025 07:44:54 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.222) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 23 Sep 2025 07:44:47 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
Subject: Re: [PATCH 2/4] sched/fair: Still look for the idlest cpu with no matching cookie
Date: Tue, 23 Sep 2025 09:44:29 +0200
Message-ID: <20250923074430.1086729-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923073232.1067189-1-sieberf@amazon.com>
References: <cover.1758543008.git.sieberf@amazon.com> <beefbc1474a94868c22b0351dedc0d7398b79c33.1758543008.git.sieberf@amazon.com> <d14c71f4-512c-49f1-a27f-4cd872c14fe6@amd.com> <20250923073232.1067189-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/23/2025 9:32 AM, Fernand Sieber wrote:
> Hey Prateek. Thanks for the catch. I'll fix as follows for next rev:
>
> +/*
> + * sched_balance_find_dst_group_cpu - find the idlest CPU among the CPUs in the group.
> + */
> +static inline int
> +sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
> +{
> +	int cpu = __sched_balance_find_dst_group_cpu(group, p, -1, true);
> +	return cpu >= 0 ? cpu : __sched_balance_find_dst_group_cpu(group, p, this_cpu, false);
> +}

On second thoughts, this doesn't work as it breaks the original fallback path.
A better modification would be this:

@@ -7341,7 +7341,7 @@ __sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct
        unsigned long load, min_load = ULONG_MAX;
        unsigned int min_exit_latency = UINT_MAX;
        u64 latest_idle_timestamp = 0;
-       int least_loaded_cpu = this_cpu;
+       int least_loaded_cpu = -1;
        int shallowest_idle_cpu = -1;
        int i;

@@ -7357,6 +7357,9 @@ __sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct
                if (cookie_match ^ sched_core_cookie_match(rq, p))
                        continue;

+               if (least_loaded_cpu < 0)
+                       least_loaded_cpu = this_cpu;
+
                if (sched_idle_cpu(i))
                        return i;

Thanks,
Fernand



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


