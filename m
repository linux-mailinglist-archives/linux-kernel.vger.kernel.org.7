Return-Path: <linux-kernel+bounces-705764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804F1AEAD7F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 05:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C003BE26E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BFE19DFB4;
	Fri, 27 Jun 2025 03:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="sGrJip5d"
Received: from out0-222.mail.aliyun.com (out0-222.mail.aliyun.com [140.205.0.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD315746E
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995828; cv=none; b=e7wbBPTMmsKaH6jyilg8z/BPInXfXmtT3E+usCgMb1lXoB4o6dg3EcoF60kkzKnbXOva3lG6x8v3Wv2JXckuDcNn4kBWmChfzFkjjeYhwNis5CTEuDWoXfOCm76ODp3CiHTrzaq6MAw0HR9yOiyj5DTAI8jmL3nHO9KEQxiC63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995828; c=relaxed/simple;
	bh=9T1GNen7cBtUFhzbi0SAvdy21/sniPe60n/XQeir4kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRoBsDl+UXDd4e3R6e8TaJNXFCA76ZfJot1rbtoB4UTu3UDfMdfF9ANr7zU4ioWH29gEjUGmssiP3JEEe11d+S2zUrRbs9sRTkSBdZBKRvEpl/aiZDjlCxaG+J/LIkPiFvLQ+YMas5W/rdGIDm+sJ90ww/Zx3cPZUiScTkVRp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=sGrJip5d; arc=none smtp.client-ip=140.205.0.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750995818; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Icc7OsswoGVni4vwpOnCjOvpQDls5UXGNPH6hnaQ3QU=;
	b=sGrJip5dCwYrn2z6I8ScE9gRNKT6pao2o64EL43+eFThbBrtiDKonQI5LZtK9DzT0PC/bRoj+hvCv64x9MAh6NgkXIYKTCdOV5WifO9tD4w9Ut6721oCFAHsrYKx0oQ5WP9wGADaCgZr7w5Q8g/y97VwYbVEPlf51Qex3IGwtkw=
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.dXmhNpj_1750995817 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Jun 2025 11:43:37 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: tj@kernel.org
Cc:  <arighi@nvidia.com>,
   <changwoo@igalia.com>,
  "Henry Huang" <henry.hj@antgroup.com>,
  "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <sched-ext@lists.linux.dev>,
   <void@manifault.com>,
  "=?UTF-8?B?WWFuIFlhbihjYWlsaW5nKQ==?=" <yanyan.yan@antgroup.com>
Subject: Re: [PATCH v3] sched_ext: Implement SCX_OPS_TRACK_MIGRATION
Date: Fri, 27 Jun 2025 11:43:34 +0800
Message-ID: <20250627034334.19345-1-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aFyBGAce73hzbPhQ@slm.duckdns.org>
References: <aFyBGAce73hzbPhQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Jun 2025 13:07:04 -1000, Tejun Heo wrote:
> Even in such cases, wouldn't something like the following work?
>
> void my_running(struct task_struct *p)
> {
>         struct my_task_ctx *taskc;
>
>         if (!(taskc = lookup_task_ctx(p)))
>                 return;
>         if (taskc->cpu != scx_bpf_task_cpu(p)) {
>                 /* update other stuff */
>                 taskc->cpu = scx_bpf_task_cpu(p);
>         }
> }

Thank you for your reply. I will try it again and will reach out via
email if I have any other questions.

-- 
Henry


