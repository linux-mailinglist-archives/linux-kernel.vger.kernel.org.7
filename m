Return-Path: <linux-kernel+bounces-775071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B292AB2BAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92428189F49D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF23101A5;
	Tue, 19 Aug 2025 07:41:11 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF21FFC6D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589270; cv=none; b=iQTX7YJBJIuyMiE7hFBmdsQEsa89Efn0XX7nT3T9qoZwhF7YfqIJhlTI9hQJEfEVitqszSzm2t936bN5NknbfcMV8Msj+yZlcd9apEYqb/d5WoLvNqEOTm4UXB8kEyn0uyDLd6F4G1jdMYFHh2UCP4gHKncI5VWL+xQTPlKs3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589270; c=relaxed/simple;
	bh=MjZl+88VGU1WgucKeDB+BllNev5o50sTojZRh8zcldA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eJrZae5Kd5F7uu3sndbYsLWhQx1OEhek99d8/xGo7DC9IrW3K1FrNjC7wFNdog+6A0NRLugT9s3COfXDeC8PuqgMn1trLFfWcZoEeYla5rEwFvOCO90g/9QV8A5TGLpolEUs3RyhuQ3uc9vBTNhKb9aef8bnNwQvj106eDa3PPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4c5hMp6HckzYmdRj;
	Tue, 19 Aug 2025 15:40:54 +0800 (CST)
Received: from a008.hihonor.com (10.68.30.56) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 15:41:06 +0800
Received: from a008.hihonor.com (10.68.30.56) by a008.hihonor.com
 (10.68.30.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 15:41:05 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Tue, 19 Aug 2025 15:41:05 +0800
From: liuwenfang <liuwenfang@honor.com>
To: 'Tejun Heo' <tj@kernel.org>
CC: 'David Vernet' <void@manifault.com>, 'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>, 'Ingo Molnar' <mingo@redhat.com>,
	'Peter Zijlstra' <peterz@infradead.org>, 'Juri Lelli'
	<juri.lelli@redhat.com>, 'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>, 'Steven Rostedt'
	<rostedt@goodmis.org>, 'Ben Segall' <bsegall@google.com>, 'Mel Gorman'
	<mgorman@suse.de>, 'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Thread-Topic: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Thread-Index: AQHb+VnBbe5K4qfqzkuJHukI3dznUrRdwDEAgAAHtgCAChnUHIAAdJ8AgADkq2I=
Date: Tue, 19 Aug 2025 07:41:05 +0000
Message-ID: <67ff59e77989445b876f90a2409bc7f8@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>
 <aHlvpRIcymNPPWh9@slm.duckdns.org>
 <46cef95e02d64b35a9d9d51d5debee22@honor.com>
 <6ccd5ef5752d4cc1818e152f6b3458b0@honor.com>
 <aJqExL-CjemhWfqB@slm.duckdns.org> <aJqLPLxpNgKWbFmu@slm.duckdns.org>
 <b1898ea1365d460e89b64989304ea0f7@honor.com>
 <aKNmNmN7YX94CO0n@slm.duckdns.org>
In-Reply-To: <aKNmNmN7YX94CO0n@slm.duckdns.org>
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

Hello,
>=20
> Might as well match the surrounding naming convention and use
> __put_prev_set_next_scx()
It makes sense, and __put_prev_set_next_scx() has been changed to an inline=
 function in [PATCH v4 1/3].
A changelog has been added accordingly.

switch_class() is renamed as scx_maybe_cpu_release() in [PATCH v4 3/3].
Also scx_maybe_cpu_acquire() is added in [PATCH v4 3/3].

However, scx_maybe_cpu_release() called in __put_prev_set_next_scx() is dif=
ficult to convert into an inline function in [PATCH v4 3/3].

look forward for your reply.
--
Regards.

Wenfang

