Return-Path: <linux-kernel+bounces-760007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95474B1E58B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899EF189DC0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2667D26CE3D;
	Fri,  8 Aug 2025 09:21:23 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BFE2690C4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644882; cv=none; b=jImDxq/+SWrIQs0ps+qMCi7XVjTwUJFYKjQdKKy4zcFqxIIH5zDGxUmUISScGWjo7DVi37GkPvxzn8h6juilo6LqTbUXwHwD8aXdbh61m9dgxfr/CWl+k1zd+httfHBzwR7ObrD05JeC+FA1uTrHFAKkjQ3zlM7W3kjch/JJGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644882; c=relaxed/simple;
	bh=734K4+7gLUlxadmxzAnJ6PogmS2p6e8dXJzK8Nnznmc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u7McRYATI/MxCwg9xLhB6/QwV9ljJcAvyWvMWaQu0VV6Oi1XmTUNitSZWeuQS9XNLwx4ynJea6osBeg776hdKp7JdqLbYlUU4kwYv5cBYP9025U3rGDTUPME/5fSnEBVzfEEBx5/1QJO3Yu1WR6Ei4EXfMk8jlkQiH+riLqYQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4byz5Q2bMsztT3B;
	Fri,  8 Aug 2025 17:20:10 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 7580B1402DB;
	Fri,  8 Aug 2025 17:21:11 +0800 (CST)
Received: from kwepemq500005.china.huawei.com (7.202.195.208) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 17:21:11 +0800
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 kwepemq500005.china.huawei.com (7.202.195.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 17:21:10 +0800
Received: from kwepemq100012.china.huawei.com ([7.202.195.195]) by
 kwepemq100012.china.huawei.com ([7.202.195.195]) with mapi id 15.02.1544.011;
 Fri, 8 Aug 2025 17:21:10 +0800
From: quzicheng <quzicheng@huawei.com>
To: Fang Xiang <fangxiang3@xiaomi.com>
CC: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tanghui (C)" <tanghui20@huawei.com>,
	"Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>, "Chenhui (Judy)"
	<judy.chenhui@huawei.com>
Subject: Re: [PATCH] sched/fair: Fix overflow in vruntime_eligible() causing
 NULL return
Thread-Topic: [PATCH] sched/fair: Fix overflow in vruntime_eligible() causing
 NULL return
Thread-Index: AdwIRZw5ZWCy8VKcwE+UPTnSxft2Cw==
Date: Fri, 8 Aug 2025 09:21:10 +0000
Message-ID: <203cd910cbad4f248a6a997cc46ca1fa@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> May I ask which specific version of the 6.6 LTS branch are you using?
Hi, based on 6.6.31

