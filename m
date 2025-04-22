Return-Path: <linux-kernel+bounces-614719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD326A970D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 17:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C751B643DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20734253F1F;
	Tue, 22 Apr 2025 15:27:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9999E277026
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335650; cv=none; b=rfZKy8OzkTOQ7AS+ZcBRCRx/eKAivMhDcdzaGCYdJazyJp1uvAq91WKLov9BbyHMUsKb4BTPvNUMXMRrgBynbvTEbV+3UhfIJYYESIpKmeKVgIRKZHjBN1UdEtPLp6nWy8OUfbDB3OZcL3uwJjxfgopk5iwaiMbBSpM8+CNVJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335650; c=relaxed/simple;
	bh=baG4D3ZE0Xoqsc/w6NBsI/98tGII9TJJ2KBYfCNbPco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLCqNJ2wDYbJz3Tv5lZtv5trnsMrnYA5qwAi5c5SfwjrzWxZQ0dMbkgQTUrmfZZKDFVIJZseTk4vIH8HfN9Eozt0hNZ9Iqh0lgkgMTk7ZyYKkUoorzQGAh+imiXMfba0FPenqnGRo2aqscGB3tyLMlobXe2CFHuOzkDvTRS79Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 822FF1595;
	Tue, 22 Apr 2025 08:27:23 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F16E3F5A1;
	Tue, 22 Apr 2025 08:27:25 -0700 (PDT)
Message-ID: <9f6c57fb-f360-470e-a1f0-a5e6353439bc@arm.com>
Date: Tue, 22 Apr 2025 17:27:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] sched/util_est: Simply the condition for
 util_est_dequeue/enqueue
To: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, hongyan.xia2@arm.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 kprateek.nayak@amd.com, kuyo.chang@mediatek.com, juju.sung@mediatek.com,
 qyousef@layalina.io
References: <20250417043457.10632-1-xuewen.yan@unisoc.com>
 <20250417043457.10632-2-xuewen.yan@unisoc.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250417043457.10632-2-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2025 06:34, Xuewen Yan wrote:

Nit: Change the subject text to:

"sched/fair: Simplify condition for util_est_dequeue/enqueue"

[...]

