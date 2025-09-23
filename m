Return-Path: <linux-kernel+bounces-828525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAEBB94CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE7A84E0665
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8253115B0;
	Tue, 23 Sep 2025 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZbgVM+KW"
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE5BE49
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612792; cv=none; b=iW58VpkflrIrHpRkEzRts+Yp4rjhNlaIROTTUteayCgt0wBFUxvj+jYB9lTZGXwXbJZUMwv5xAQSdjpDdZiA2RfGoBFEYUrLfcAHNa4z3HgmUNsdcb709F8diCrAj0r7Pj9ybu3CvludXTyWTRBxz9NxvxcXRpj2ALsts3uqNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612792; c=relaxed/simple;
	bh=c2iOOz+XjV2pOZP0bpWwSngF4g0ANyEd+GzvXEBB2cE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igxoNuP7v0wFsAeJ3qVVv3hP9yGyGc7lPL4vWxQ6ppSsnM6CbfyhtUOMR4OvaHv0VrEUGXtuZ+mNPwH27EJTytHhhU37PkPVGT+QLrWQCNcROFWV2E2+zyqfuPHMuUVizaHf74dJEgLy7hFQ57QKbHWBqKkf61itvm93Q1Cyddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZbgVM+KW; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758612791; x=1790148791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e8Cb7B4L4ahs/oJ6ymZrnmRyuZODfpvIXxR0GShPgJA=;
  b=ZbgVM+KWs1tuEqCvFi+EyPwzkLIzIqE+Aw05KJiDd8hmzp8owDTmDCZa
   jJFwVTVJGgy9Aya8ejUR43M1deI5ilApJfLsaZHHgT2t9t1Pl8Xzb5Bll
   VTM/GD1nRuYWc/GxykCe105V/wtsfpRFC+ZER49a9DJqOcwJK3EFY0IDx
   NEfeZtTqwx6m31w/OiBPmhnNAw+rBj4SFvLD1Qo1N7ckm6nmfunH5C0JD
   7qS5WPvaNgb9tyloqToJkxwMqM5ySuE0/Dfea2GDo3M+q6xPQNDXyEMmk
   TJARvuxtbmka2P+tZB76nmLa8UPS9HXNyUIOUO9+ru1MNgwXMTByi7CPI
   g==;
X-CSE-ConnectionGUID: O2BHH7A7QSqd6rgWIFmPpw==
X-CSE-MsgGUID: xUZhS8OiQ462u1YK0V3BQA==
X-IronPort-AV: E=Sophos;i="6.18,287,1751241600"; 
   d="scan'208";a="2520493"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 07:33:00 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:7014]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.9.61:2525] with esmtp (Farcaster)
 id 619c64c8-e999-474e-aa4b-7eb09a8b1f06; Tue, 23 Sep 2025 07:32:59 +0000 (UTC)
X-Farcaster-Flow-ID: 619c64c8-e999-474e-aa4b-7eb09a8b1f06
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 23 Sep 2025 07:32:55 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.222) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 23 Sep 2025 07:32:48 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
Subject: Re: [PATCH 2/4] sched/fair: Still look for the idlest cpu with no matching cookie
Date: Tue, 23 Sep 2025 09:32:31 +0200
Message-ID: <20250923073232.1067189-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d14c71f4-512c-49f1-a27f-4cd872c14fe6@amd.com>
References: <cover.1758543008.git.sieberf@amazon.com> <beefbc1474a94868c22b0351dedc0d7398b79c33.1758543008.git.sieberf@amazon.com> <d14c71f4-512c-49f1-a27f-4cd872c14fe6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Prateek,

On 9/23/2025 7:21 AM, K Prateek Nayak wrote:
> Based on the above return in __sched_balance_find_dst_group_cpu(), it
> should always return a valid CPU since "least_loaded_cpu" is initialized
> to "this_cpu".
>
> So, under what circumstance does "cpu" here turns out to be < 0?
> Am I missing something?

Hey Prateek. Thanks for the catch. I'll fix as follows for next rev:

+/*
+ * sched_balance_find_dst_group_cpu - find the idlest CPU among the CPUs in the group.
+ */
+static inline int
+sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
+{
+	int cpu = __sched_balance_find_dst_group_cpu(group, p, -1, true);
+	return cpu >= 0 ? cpu : __sched_balance_find_dst_group_cpu(group, p, this_cpu, false);
+}
+

Thanks,
Fernand



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


