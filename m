Return-Path: <linux-kernel+bounces-775066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A5FB2BAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC31F1BA4D55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FEAB67A;
	Tue, 19 Aug 2025 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="B/7BNgA/"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F3261B80
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589025; cv=none; b=cnzYOtu2/62FxDBBOqajSbe54wLNHMh8RHf/0jB84XwQO2px4hU5rbXFOfSujb4CdG9yAscSNdqs0be2vSlOZKKsxGJw3EuFMKmzm8vDYfeLen0Q3OFvPxCt6SupaZ33ifQ7+TSl0j4FMD5ZunnhrDQxC3Ly1hXdw2qJkGiQETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589025; c=relaxed/simple;
	bh=yYZSZwcec65gWfwIp+ELzOzWwJe+gGNkYGuUS7q1d4c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u3nxnZ1HHNq8tUdXrEeuBD5/1k7AqJ91SeJeZMqyB34jgqN5B8B6X4QS19o+CNL6igzmoYoTZlcf9J9YRxAgnV6CA/0PqLWO63Wm34oTKxOJDt4MQJTjV1BeeR89atWb6D8ze94YyPuAJNDwCSnOhFGnEP5mbOkiNzFwY7yFVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=B/7BNgA/; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=yYZSZwcec65gWfwIp+ELzOzWwJe+gGNkYGuUS7q1d4c=;
	b=B/7BNgA/lDCUoJDWeiuTbd1ovwwrFCsPzB3F+XIafZS0Tt21O0RFS2xDHn1wPz5ELKqNvPy+o
	nPC+EqXuhRnbXQxf7ld6+C/JQnzXV7s280B9nTC8/yTs1l3MjdCwnSRhP9dDUaptmazJurr+BgJ
	pTs8cGTyLYpruUw1ixAPT7Y=
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c5hH73dBQzYl4L6;
	Tue, 19 Aug 2025 15:36:51 +0800 (CST)
Received: from a004.hihonor.com (10.68.27.131) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 15:36:59 +0800
Received: from a008.hihonor.com (10.68.30.56) by a004.hihonor.com
 (10.68.27.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 15:36:59 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Tue, 19 Aug 2025 15:36:59 +0800
From: liuwenfang <liuwenfang@honor.com>
To: 'Peter Zijlstra' <peterz@infradead.org>
CC: 'Tejun Heo' <tj@kernel.org>, 'David Vernet' <void@manifault.com>, "'Andrea
 Righi'" <arighi@nvidia.com>, 'Changwoo Min' <changwoo@igalia.com>, "'Ingo
 Molnar'" <mingo@redhat.com>, 'Juri Lelli' <juri.lelli@redhat.com>, "'Vincent
 Guittot'" <vincent.guittot@linaro.org>, 'Dietmar Eggemann'
	<dietmar.eggemann@arm.com>, 'Steven Rostedt' <rostedt@goodmis.org>, "'Ben
 Segall'" <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>, "'Valentin
 Schneider'" <vschneid@redhat.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Thread-Topic: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Thread-Index: AQHb+VnBbe5K4qfqzkuJHukI3dznUrRoV6GAgADnpcg=
Date: Tue, 19 Aug 2025 07:36:59 +0000
Message-ID: <1131ae6ff2834b57b71f0e41879bc83c@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
	<aFmwHzO2AKFXO_YS@slm.duckdns.org>
	<7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>
	<aHlvpRIcymNPPWh9@slm.duckdns.org>
	<46cef95e02d64b35a9d9d51d5debee22@honor.com>
	<6ccd5ef5752d4cc1818e152f6b3458b0@honor.com>
 <20250818174753.GA846072@noisy.programming.kicks-ass.net>
In-Reply-To: <20250818174753.GA846072@noisy.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
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

Hello,=20
> This doesn't even begin to be an adequate changelog.
>=20
> And please, don't put an out of line function call in put_prev_set_next_t=
ask(.
A changelog has been added accordingly in [PATCH v4 1/3], and __put_prev_se=
t_next_scx() has been changed to an inline function.

However, switch_class() called in __put_prev_set_next_scx() is difficult to=
 convert into an inline function in [PATCH v4 2/3].

look forward for your reply.
--
Regards.

Wenfang

