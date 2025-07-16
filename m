Return-Path: <linux-kernel+bounces-733799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6801B07918
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7E33B2AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1363596B;
	Wed, 16 Jul 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKzmbt3B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212AE1DE4E5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678492; cv=none; b=DeUBeYpT294buniAmMBudFtLLDG3SiYQOOLT8CMfXljRuCBQ6qFtqASQcTxq4Cpanede9yDIUZzRLJlffVRIiBlt6AdnPde+OZoA/h+SzxecDuunveccqQ3acFdsMQGWoG6aQj8MbCaV5nBmDWiKp9ebTz2ZyjRUwZF3haBY8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678492; c=relaxed/simple;
	bh=TC22p07Vl0xyih++j4kLSlfF8+PXZTlxlsckTlLryYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iEeoeh5RABZQu/OS7blP+YhFsgbbLuWtXUMgP0ge0NU/mCYyMuvG28WmFet5gGEO5825UBX0yApinqBToWLXLrvbvod+fEBvpgwiiGaMn5iukkKqPxcz9H3VRgQ324oBXPaLPc1peKmUNKyI1u4is03vVmnh4i12nrRZq3CKI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKzmbt3B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752678489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7mfaRPygFzO8iJMLhIMYBr1WydsVgOxlNzFGPKcc+I=;
	b=RKzmbt3B1OCbClDRZD8r51+T5UZz0SQcbFJw6flaT6EeRjahDSBFPFCI8BEDkTW9k9cqzs
	mFs38IXXixBe/3n8sPi5eHj6J4Nq8dltXnR2Se4CYq6kwVeR640clsPyWu5saSLlLq6ISK
	KOXzLnYfXCJOLO60ljJtKeWkTuq+PVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-CgBRiL5BM3qXI1ZsfBU-jA-1; Wed, 16 Jul 2025 11:08:08 -0400
X-MC-Unique: CgBRiL5BM3qXI1ZsfBU-jA-1
X-Mimecast-MFC-AGG-ID: CgBRiL5BM3qXI1ZsfBU-jA_1752678487
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so2588969f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678486; x=1753283286;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7mfaRPygFzO8iJMLhIMYBr1WydsVgOxlNzFGPKcc+I=;
        b=uuQcy++xgcntwz3QrmUs8UEqmCHowyrD6kZI7ejz3RfCXOpv4S1WwHFFcj5aP4lQXe
         v3cLrsJpSWYK6/PNR7h/mVmd/gPFfz9+sGzRES89mEwYzvdNEFBcJ5CJr/T+3mo0Q9zF
         16JD3BN/c4OQGvy35aqKJyvAUKuH+w6Tk6VNNbHYqj/AaUj2DguWiXKGJ4tfemrVwrGE
         8Nr58KdynLR9G92QG3HckPr1MVSWNQqc8WOW9PoGP6xATUeqiYZxpe/XF1aNv2cWLxcG
         lIGIYNm/BHqNRUFpez6sqMzjVdHK9Nq0mzvKYAKJVkV0y8G9E3HjsfXiXYPIQN/qbo7u
         q5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVSyY9SEQpN6sSpEhfoMg8ecJYZOTjD6YLaYg7OBhiDbhPfVrh7PPr92bh46T+Z4JEPcdzw/eat8Q/IiBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5hIlH7pw72zdc2/TY3O2x4qQ5MVNIEw4Y42rO7tQggqfiNik5
	YPo648cI3NZCNy6LPYSPluedZSRydktN2qlmz/p1YgfJXpOcEC2Tasq4yxDqDZxcgvdTkf630oi
	2KJws8/xgZShDHcQflIqcYAG1sbjCRNQ9SVHEs0+FkHUcowkOb9JOYRIKxxIi7ctQP+yvZdyi4N
	5dn6FZQ4LaWPPW1qqWKtGiEfOoPgO0fWjoYPqFFpUyBxhM7ggDog==
X-Gm-Gg: ASbGncvYfSjknldqz4XHr0g9mKLJExOuOT7yHMgBE2avrloKF93NB696XXYBP+xoz4z
	CYHY21QOI4W4fYiXBkCTmjuJ+UfkSw+QysFgIQXBgIizI2vmxsH1o36QEps2SB1EasW6pHNGb4I
	b0uxtAsO9+5hmb/EFQkO4UNdhtFdd0lz7qOYVf2FbkUXbelkT8AYj/0FXXdB5xPKPzQuwQyBreQ
	vqp2/lLv3QupAgWUTzcJZ5ZWTy0IHdIy5hiJfCUerjukTqZ/RGBCqmXO6agvHDLPF0TonU5Khh6
	fEp3v3HyaqMWeqJm1b7twA6nzr+u1xRCx62OWZkfujAinqvn3RAjoT+YyZg9nMb/3YwyzHjfOoz
	nsRbkHqVXJH5UCN6fsOb+RNET
X-Received: by 2002:a05:6000:4b01:b0:3a4:eec5:441c with SMTP id ffacd0b85a97d-3b60e53ececmr2759762f8f.47.1752678486527;
        Wed, 16 Jul 2025 08:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrEFj9lEKqGnfmC9P4Xm/X2lYuBVhYbPj5hk2VJKfIRuBv9OJlZDQMN+FxDVUx385UKS0U1A==
X-Received: by 2002:a05:6000:4b01:b0:3a4:eec5:441c with SMTP id ffacd0b85a97d-3b60e53ececmr2759721f8f.47.1752678486105;
        Wed, 16 Jul 2025 08:08:06 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b60e3ed902sm2166175f8f.91.2025.07.16.08.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:08:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>, Huang Shijie
 <shijie@os.amperecomputing.com>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: do not scan twice in detach_tasks()
In-Reply-To: <d4ed8553-6a57-4b56-bc6e-ecadd2d9d75e@amperemail.onmicrosoft.com>
References: <20250707083636.38380-1-shijie@os.amperecomputing.com>
 <xhsmho6tl1j2d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d4ed8553-6a57-4b56-bc6e-ecadd2d9d75e@amperemail.onmicrosoft.com>
Date: Wed, 16 Jul 2025 17:08:04 +0200
Message-ID: <xhsmhldoo18dn.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16/07/25 10:13, Shijie Huang wrote:
> On 2025/7/16 1:04, Valentin Schneider wrote:
>> On 07/07/25 16:36, Huang Shijie wrote:
>>> When detach_tasks() scans the src_cpu's task list, the task list
>>> may shrink during the scanning. For example, the task list
>>> may have four tasks at the beginning, it may becomes to two
>>> during the scanning in detach_tasks():
>>>      Task list at beginning : "ABCD"
>>>      Task list in scanning  : "CD"
>>>
>>>      (ABCD stands for differnt tasks.)
>>>
>>> In this scenario, the env->loop_max is still four, so
>>> detach_tasks() may scan twice for some tasks:
>>>      the scanning order maybe : "DCDC"
>>>
>>
>> Huh, a quick hacky test suggests this isn't /too/ hard to trigger; I get
>> about one occurrence every two default hackbench run (~200ms) on my dummy
>> QEMU setup.
>>
>> Have you seen this happen on your workloads or did you find this while
>> staring at the code?
>
> I found this issue in my Specjbb2015 test.=C2=A0 It is very easy to trigg=
er.
>

That would be good to include in the changelog.

> I noticed many times in the test.
>
> I even found that:
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 At the beginning: env->loop_m=
ax is 12.
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When the detach_tasks() scans: the =
real task list shrink to 5.
>

That's set using rq->nr_running which includes more than just the CFS
tasks, and looking at the git history it looks like it's almost always been
the case.

Looks like env->loop_max really is only used for detach_tasks(), so perhaps
a "better" fix would be something like the below, so that we can't iterate
more than length(env->src_rq->cfs_tasks). That is, assuming

  rq->cfs.h_nr_queued =3D=3D length(rq->cfs_tasks)

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b9b4bbbf0af6f..32ae24aa377ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11687,7 +11687,7 @@ static int sched_balance_rq(int this_cpu, struct rq=
 *this_rq,
 		 * still unbalanced. ld_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		env.loop_max  =3D min(sysctl_sched_nr_migrate, busiest->nr_running);
+		env.loop_max  =3D min(sysctl_sched_nr_migrate, busiest->cfs.h_nr_queued);
=20
 more_balance:
 		rq_lock_irqsave(busiest, &rf);


