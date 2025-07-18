Return-Path: <linux-kernel+bounces-736609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE55B09F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E607BFDC9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1B295D96;
	Fri, 18 Jul 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="ZQUUJFiO"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F61514E4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830586; cv=none; b=lCYAE2thJ7M481Oz1ERajHTmzTslxGMjrO0gT3RDG/spVHG9vrVD48elksQK2cj09P17vQgKKf4fdszhOEwbHIajc4j+ij38NU8kxQ82Xfp0ZAILe4m9oGLyx4bSV4slid/u9cwn8wiXPI9oPAHjIjjqVgFBAMkFUZTH7TQEYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830586; c=relaxed/simple;
	bh=exq4Cz55WdH9zobo66TbWjCSyfgsOiC5SwHIi0FNQgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hdB9D3Geqyd8UeiglHGoZ4Loh04troETmMpfE4vyPHPekjOuCtFm7nPMBsLYfrP88skmeW6UA49xrohL+swtEzxnA5m4sd+v0WX8OElAlFkusDW5VGGbTHNTkKA4YIrVsqB2w/3/IyRwfUkezfNm8emzZ+WYpsYAgH6q+fkP47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=ZQUUJFiO; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=Rv03FtnMvgcLmeSZnAcjq4pXyejuegBu2EMWj96KTuM=;
	b=ZQUUJFiOKVEDqVrW8On8CcllqW7K1BelK6qItzww+iV9fJQL9dPr3cJa3qz+FhoW6sj4Kv5YG
	sXA9pAh6mjsdikFk8oKV8jYEN8LN4XSkLMWKLvbcp6SRJU2wguarqtOAhVFKsfJ89MahhouVBii
	YzpDOWEpD5CUTP+mer+Uz9g=
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4bk3l55FxvzYl0Dm;
	Fri, 18 Jul 2025 17:04:33 +0800 (CST)
Received: from a006.hihonor.com (10.68.23.242) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Jul
 2025 17:06:47 +0800
Received: from a008.hihonor.com (10.68.30.56) by a006.hihonor.com
 (10.68.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Jul
 2025 17:06:47 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Fri, 18 Jul 2025 17:06:46 +0800
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
Subject: RE: [PATCH v2 2/2] sched_ext: Fix cpu_released while changing sched
 policy of the running task
Thread-Topic: [PATCH v2 2/2] sched_ext: Fix cpu_released while changing sched
 policy of the running task
Thread-Index: AQHb5/0yo2t7F5m+gkK5HK/j+nTL07Q2cvCAgAC8lL8=
Date: Fri, 18 Jul 2025 09:06:46 +0000
Message-ID: <46cef95e02d64b35a9d9d51d5debee22@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>
 <aHlvpRIcymNPPWh9@slm.duckdns.org>
In-Reply-To: <aHlvpRIcymNPPWh9@slm.duckdns.org>
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

> Hello,
>=20
> On Sat, Jun 28, 2025 at 07:20:59AM +0000, liuwenfang wrote:
> >  static void switched_from_scx(struct rq *rq, struct task_struct *p)
> > {
> > +	switch_class(rq, p, true);
> > +
> >  	scx_ops_disable_task(p);
> >  }
>=20
> Hmm... but this function can be called when @p is not currently running f=
rom
> setscheduler() path, and it wouldn't make sense to call switch_class() du=
ring
> that.
Yeah, task_current(rq, p) should be checked here.
>=20
> >  static void wakeup_preempt_scx(struct rq *rq, struct task_struct
> > *p,int wake_flags) {} -static void switched_to_scx(struct rq *rq,
> > struct task_struct *p) {}
> > +static void switched_to_scx(struct rq *rq, struct task_struct *p) {
> > +	lockdep_assert_rq_held(rq);
> > +
> > +	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
> > +	    unlikely(rq->scx.cpu_released)) {
> > +		/*
> > +		 * If the previous sched_class for the current CPU was not SCX,
> > +		 * notify the BPF scheduler that it again has control of the
> > +		 * core. This callback complements ->cpu_release(), which is
> > +		 * emitted in switch_class().
> > +		 */
> > +		if (SCX_HAS_OP(cpu_acquire))
> > +			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, rq, cpu_of(rq), NULL);
> > +		rq->scx.cpu_released =3D false;
> > +	}
> > +}
>=20
> Ditto. This should only apply if @p is current, right?
task_current(rq, p) should be added.
>=20
> Thanks.
>=20
> --
> Tejun

Thanks.

--
Wenfang

