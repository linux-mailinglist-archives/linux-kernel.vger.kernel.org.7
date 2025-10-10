Return-Path: <linux-kernel+bounces-847777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B166BCBAE0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F9054E2BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7827726F2AF;
	Fri, 10 Oct 2025 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q/IZXRhD"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098EB846F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072411; cv=none; b=r9oc5TNL/gHNkmJ27hjX//Jeyc2s623VYhVRoPO2d6tY8RVMQmOOPOOEZw3aectP32PEdN3+JE853faImaBmRrI9NDjN36JNOnkFcSfO46Ha6aG3L7vhEBrpEsAF3V8rid7FmbZQDVPIflROegYje4m0Z0kLeFoAfPYBH1rNAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072411; c=relaxed/simple;
	bh=pOKSziQSBdB1gSuXAC8srXai9XO0URECgl6qavHK3k8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qp7TUYLV6qwMkaEZnJlr+/BvN25MSHAxW7ePkEyt+f5V3jPJyKoIFQm9B/Tu7mvqvsaMHGOoHMXU4C7kilIOI2Qh3H3YjhnDd2FpDK9iaSfxAPZnpnm+hUNI1o3p1AssIxh73qW7dpksLpyZfMUzE+20qqp/lRiY6zxxH8+DOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q/IZXRhD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A0j2VF008981;
	Fri, 10 Oct 2025 04:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wUbnzp
	J7e339XXADDgvfgVvoSNDCb8YN5nctspRrVAs=; b=Q/IZXRhDIoV4/RbX4YRGlG
	HDqobDlplAk4jh5HSqCJj+YugZcWnEU7TjiNjGjzrW4txPkRvqzLejNhBDvCDq3l
	TqGXO3WFxUnB9O/6bdH5BOj9hRvyvp4aEnqtHLFTwqr3cKJGP9IKQw93Wu7Fc0IM
	cqQymt/Cz73KtypCK1led5rIUE2CBf5EwtwPrLNHoghwFdKMZs0TzACA9Qm4wsNA
	dYMD7DKXiE06pIZmo5vca0MizKk1rIdiRO09GRQ42sifwXWrHWakkyH3CuNKNJ92
	xryY5ipxbtbRWr0lz9HlyBkRkfjKfW3H1GSg/3Lk1qcRYnH+AyxUcHqBdGKCiJ/g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv828tds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 04:59:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59A4uoYE020559;
	Fri, 10 Oct 2025 04:59:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv828tdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 04:59:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59A3eMG0026006;
	Fri, 10 Oct 2025 04:59:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamr6bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 04:59:54 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59A4xrm527656798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 04:59:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA8AC5805C;
	Fri, 10 Oct 2025 04:59:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF7558059;
	Fri, 10 Oct 2025 04:59:50 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.240.51])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Oct 2025 04:59:50 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] sched/deadline: stop dl_server before CPU goes offline
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20251009184727.673081-1-sshegde@linux.ibm.com>
Date: Fri, 10 Oct 2025 10:29:36 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        mingo@redhat.com, vincent.guittot@linaro.org, m.szyprowski@samsung.com,
        jstultz@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <69CEF830-0076-45C0-967D-32701CE86505@linux.ibm.com>
References: <20251009184727.673081-1-sshegde@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KrpAGGWN c=1 sm=1 tr=0 ts=68e892cc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NEAV23lmAAAA:8 a=JfrnYn6hAAAA:8 a=hD80L64hAAAA:8 a=JqkGBtS0d19cVCI7Qx8A:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: jfBmzQzvXI9g__ikggqHfrjxDzpFGJe7
X-Proofpoint-ORIG-GUID: vQh-a_v3F2LlVx73PfROeaQPuCj4q6q1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4fCdnXBZA6AL
 MTwYlX/nxuRngjA7QrnYwb8guTGbj8s4nTVwg/3hqRaQ/9lo3EF5EJh9lwWKpn2cyrPbH1yD21Q
 y0gYoHhwvJep2Jqj+IQ9X4RxkJYB7K+I4hSAZGaY2+UXyUnfSobnhYXA1ZeSL/BB45893Xnh5F3
 /TuQn8+7dH9qpHDH8ND9ZjctSpWURe7VPmcOC0LEuT9x9bQppEXAH28aN8eSC+erA6byJmV4EXp
 cMuv+ypIcc1VpYAQRnD5KxyvVKIDbXZ6l3B5XY3KwWjUGL/ylUOGaiTqfLTypzg7xm1zU4pmHNd
 vRAh++DddhoBxXMXGGhXuHXr5qwBBlvs7RPvBkMhA1bl8vxFa3qsbbrz5BX4/SR6rWH1cH3tcFx
 31uLSVjK0VgGVRbuUDAOSmcimJG0ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



> On 10 Oct 2025, at 12:17=E2=80=AFAM, Shrikanth Hegde =
<sshegde@linux.ibm.com> wrote:
>=20
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
>=20
> IBM CI tool reported kernel warning[1] when running a CPU removal
> operation through drmgr[2]. i.e "drmgr -c cpu -r -q 1"
>=20
> WARNING: CPU: 0 PID: 0 at kernel/sched/cpudeadline.c:219 =
cpudl_set+0x58/0x170
> NIP [c0000000002b6ed8] cpudl_set+0x58/0x170
> LR [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
> Call Trace:
> [c000000002c2f8c0] init_stack+0x78c0/0x8000 (unreliable)
> [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
> [c00000000034df84] __hrtimer_run_queues+0x1a4/0x390
> [c00000000034f624] hrtimer_interrupt+0x124/0x300
> [c00000000002a230] timer_interrupt+0x140/0x320
>=20
> Git bisects to: commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server =
getting stuck")
>=20
> This happens since:=20
> - dl_server hrtimer gets enqueued close to cpu offline, when=20
>  kthread_park enqueues a fair task.
> - CPU goes offline and drmgr removes it from cpu_present_mask.
> - hrtimer fires and warning is hit.
>=20
> Fix it by stopping the dl_server before CPU is marked dead.
>=20
> [1]: =
https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm=
.com/
> [2]: =
https://github.com/ibm-power-utilities/powerpc-utils/tree/next/src/drmgr
>=20
> [sshegde: wrote the changelog and tested it]
> Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: =
https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm=
.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>

This patch fixes reported issue. Please add below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.
> ---
> kernel/sched/core.c     | 2 ++
> kernel/sched/deadline.c | 3 +++
> 2 files changed, 5 insertions(+)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 198d2dd45f59..f1ebf67b48e2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8571,10 +8571,12 @@ int sched_cpu_dying(unsigned int cpu)
> sched_tick_stop(cpu);
>=20
> rq_lock_irqsave(rq, &rf);
> + update_rq_clock(rq);
> if (rq->nr_running !=3D 1 || rq_has_pinned_tasks(rq)) {
> WARN(true, "Dying CPU not properly vacated!");
> dump_rq_tasks(rq, KERN_WARNING);
> }
> + dl_server_stop(&rq->fair_server);
> rq_unlock_irqrestore(rq, &rf);
>=20
> calc_load_migrate(rq);
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 615411a0a881..7b7671060bf9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1582,6 +1582,9 @@ void dl_server_start(struct sched_dl_entity =
*dl_se)
> if (!dl_server(dl_se) || dl_se->dl_server_active)
> return;
>=20
> + if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
> + return;
> +
> dl_se->dl_server_active =3D 1;
> enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
> if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, =
&rq->curr->dl))
> --=20
> 2.47.3
>=20


