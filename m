Return-Path: <linux-kernel+bounces-842513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB1CBBCE7D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 02:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFECD345664
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 00:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA252183CA6;
	Mon,  6 Oct 2025 00:43:02 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C113B280
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759711382; cv=none; b=XkjNVrMy3YZuhvzzZJ4VyhqUMWztAnaxHmUSqvzo1uSw8mOdpjBcUAbbuM1rcClDyDVsMzF46wGB8ZFk7H+QMgIE2DcG9uWfiquD6ITS25mI1BvoqtNwd/WHFQpF57sDhY1gLBhEDBbaN1KsAvx3WDbW4TtEfQbikp0zKk5gMMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759711382; c=relaxed/simple;
	bh=JDMkFOJnfhNC9G8ST/b+HNAEthAIJdPeRzvBp0TfoHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ae7S6Rv34KWRe2lFPKPjmK7OpsgkKcINc5g0u26tQdBFaBbT0JzfXaIS89Wj+PLX0bJl8gSbLQSisGqZAGgAc7epAfKVv5mRsDb1F8VJsa/IOCxmlkoToqmDqii/TucT6FCAJWgwCuq5tbajxu3wn+9LGqUgDzDFD+xadBdCMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <wangfushuai@baidu.com>
CC: <bsegall@google.com>, <dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<vschneid@redhat.com>
Subject: Re: [PATCH] sched: remove unnecessary check in sched_{debug_}start()
Date: Mon, 6 Oct 2025 08:41:21 +0800
Message-ID: <20251006004121.42332-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250807034016.43446-1-wangfushuai@baidu.com>
References: <20250807034016.43446-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc13.internal.baidu.com (172.31.4.11) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

> -1 is a legal argument for cpumask_next(), and cpumask_next(-1, mask) is
> equivalent to cpumask_first(mask). The explicit check and separate branch
> are unnecessary.

Gentle ping. This patch has been reviewed but not merged yet.

Regards,
Wang.

