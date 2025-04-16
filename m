Return-Path: <linux-kernel+bounces-602838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5ABA87FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 14:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 830797A2F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 12:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812029C33A;
	Mon, 14 Apr 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dXs4W07D"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE727EC83
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632459; cv=none; b=b9AlYJVGDGszsy305gmRCt/1/x5R2LAPiAmZ6lGe95h/ECkKOOKSl0oON3/nxai+kDziITlCJy9cNEzk9EMbnyPJC3xBqP7PG23HYFKGjd6PWGNCnMbkKCPUw2FOT8RWnHHqsUemJxONYEDEfM05asiCQnoHfuH7Ho4XfY9H3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632459; c=relaxed/simple;
	bh=e5MHh1/AgW7GQNGjFGMoYoGhNG0DZ1pIKtgBUEX/v+4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=YEl2H6KV4+c126SrSFYbqGR3ViYLCUAzuQGBLlMIL61QyMIVrFdu9irKBQK+Rxk36fkBFZOPSZ5AcCHkrsm6O+Rf9Uiqe9UNNIDs2dZm6u6EaWRaHWPm8eNWvNkzFiLHtGrDNF8hatZs99/y1DA22nuJThwV5/4x5iU3deDl4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=dXs4W07D; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4769aef457bso44634861cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1744632456; x=1745237256; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNIuHnZH2rf7owPvo9Qy8ukolQT0pKNA9yGt9dCwbmM=;
        b=dXs4W07DWC33IlWSsF6+8cTKtDyNmMn0PxIYHDls8uud28ABKm+PHEuWN5iLugUiyx
         /raWR5hVITVoHU7oa6nimSvyyfWzVIHVMZxnRzXTWkTPyl8BtuMZucAuveAHvTTNtE7s
         oTYHefYY9oX5gQsqxyJSed5z3ncf0TAbrwjeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744632456; x=1745237256;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNIuHnZH2rf7owPvo9Qy8ukolQT0pKNA9yGt9dCwbmM=;
        b=LGDCEOKRBPVFqcj0pjyX0zyAyXf1uwa7Kmm8O7ZvW32j/CEjjpUhzqAgS0T7m/fvNK
         mnDcchHJXOjRryOGg2hrzO3NVTlNxjsNuu+9CmK1dKSqAPBTM1yNGmHLObLmerg9t3kY
         Mix+ZeAaujljxvaUqIB36yCHIgTCDsASkj1g+M1HF10tRFSiMZJr4+Uz0UDP6uBVAlFW
         u+9Vm+Nt97w4R7D1v54pxQBTFc1TZi2PgtwFPcNG0xxXVcNsDqEuGHxHJg89bqTcQYFI
         3kVo4lzlNqnmX+Ap+8oEe5gB+i/83NJOe9uqO45T2DBPdMd60D6jQAXBdE79C76X9UrS
         VB0g==
X-Forwarded-Encrypted: i=1; AJvYcCVIV5zToDSh2Ud/oLpUAlmlDn6qj9wepfNvMsi6fPWJiLXnZyLSJxsRDn6CcbcFJz7ANU2qeLITYvuhltQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcg9jd3enluCOZRew5EmlQ68rGdAS+3ZVNvR7FXe5gSbDcVT/C
	9F6aoq1ayaQlG72fQG4T6zGlIMDhpsVhD1HQZ7CDs9ehKxl/1Q4xbEvaUlhSIu0=
X-Gm-Gg: ASbGnctqgmunfh+sAqWyrlaCIaHIRgRg91XRaHWsqU1aYX8NkHb8RRh14DIIeTA1aPy
	13mxjLL/P9Nl+SDa2l2LzeXrKqxbgXSJ38UEWImRaoQmZiOPwFStjUUJD0VV1B+WXDZwnc46VYn
	AH+/jmDykrzBYbsY2U1GwAOK0RcisZeK9MOyJS+QeNxoPmfEQW+J4njPHZg2/jtkKaHfqIlb+VQ
	nM0ByHzScoOZl7p/64rkYFkvqhCFoRgtX3yRWHQtsbmUVUVXmirdb8kWp39knKNIz8eXHyVpZbm
	5cXgdNgJyNNwHqwrc0n1VPO0cKntvVOfGezJDyXF8zgA8iV04Lwmg+FhgP4=
X-Google-Smtp-Source: AGHT+IExDr+hHns1BQPxdKOycYF08XUqj6KCaMA+mhc1FWURTya/XCRAsu0TlsK0OBMvnR8HOEwSEA==
X-Received: by 2002:a05:622a:306:b0:476:b3f0:a905 with SMTP id d75a77b69052e-47977515330mr154029401cf.8.1744632455844;
        Mon, 14 Apr 2025 05:07:35 -0700 (PDT)
Received: from smtpclient.apple ([71.51.182.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb0b7cdsm74203751cf.3.2025.04.14.05.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 05:07:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [v3,1/2] rcutorture: Perform more frequent testing of ->gpwrap
Date: Mon, 14 Apr 2025 08:07:24 -0400
Message-Id: <BE7C948D-5238-48C4-93E1-1BAE4CBBD391@joelfernandes.org>
References: <71ab408c-a01b-43a9-993c-4a55294e15ef@paulmck-laptop>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, rcu <rcu@vger.kernel.org>
In-Reply-To: <71ab408c-a01b-43a9-993c-4a55294e15ef@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (22E240)



> On Apr 11, 2025, at 3:18=E2=80=AFPM, Paul E. McKenney <paulmck@kernel.org>=
 wrote:
>=20
> =EF=BB=BFOn Fri, Apr 11, 2025 at 05:36:32AM -0000, Joel Fernandes wrote:
>> Hello, Paul,
>>=20
>>> On Fri, 11 Apr 2025 05:33:16 GMT, "Paul E. McKenney" wrote:
>>> On Thu, Apr 10, 2025 at 11:54:13AM -0700, Paul E. McKenney wrote:
>>>> On Thu, Apr 10, 2025 at 11:29:03AM -0700, Paul E. McKenney wrote:
>>>>> On Thu, Apr 10, 2025 at 11:03:27AM -0400, Joel Fernandes wrote: >
>>>>> Currently, the ->gpwrap is not tested (at all per my testing) due to
>>>>> the > requirement of a large delta between a CPU's rdp->gp_seq and its=

>>>>> node's > rnp->gpseq.  > > This results in no testing of ->gpwrap being=

>>>>> set. This patch by default > adds 5 minutes of testing with ->gpwrap
>>>>> forced by lowering the delta > between rdp->gp_seq and rnp->gp_seq to
>>>>> just 8 GPs. All of this is > configurable, including the active time f=
or
>>>>> the setting and a full > testing cycle.  > > By default, the first 25
>>>>> minutes of a test will have the _default_ > behavior there is right no=
w
>>>>> (ULONG_MAX / 4) delta. Then for 5 minutes, > we switch to a smaller de=
lt
>>> a
>>>>> causing 1-2 wraps in 5 minutes. I believe > this is reasonable since w=
e
>>>>> at least add a little bit of testing for > usecases where ->gpwrap is s=
e
>>> t.
>>>>>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>>>=20
>>>>> Much better, thank you!
>>>>>=20
>>>>> One potential nit below.  I will run some tests on this version.
>>>>=20
>>>> And please feel free to apply the following to both:
>>>>=20
>>>> Tested-by: Paul E. McKenney <paulmck@kernel.org>
>>>=20
>>> And this happy situation lasted only until I rebased onto v6.15-rc1 and
>>> on top of this commit:
>>>=20
>>> 1342aec2e442 ("Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for=
-6.1
>>> 6' and 'rcu/torture-for-6.16' into rcu/for-next")
>>>=20
>>> This got me the splat shown below when running rcutorture scenario SRCU-=
N.
>>> I reverted this commit and tests pass normally.
>>>=20
>>> Your other commit (ARM64 images) continues working fine.
>>=20
>> Interesting.. it seems to be crashing during statistics printing.
>>=20
>> I am wondering if the test itself uncovered a bug or the bug is in the te=
st
>> itself.
>=20
> Both are quite possible, also a bug somewhere else entirely.

I may not get to debugging it for this merge window so I am leaning to defer=
 it.

>=20
>> Looking forward to your test with the other patch and we could hold off o=
n this
>> one till we have more data about what is going on.
>=20
> This one got lot of OOMs when tests of RCU priority boosting overlapped
> with testing of RCU callback flooding on TREE03, as in 13 of the 14
> 9-hour runs.  Back on v6.14-rc1, these were quite rare.
>=20
> Ah, and I am carrying this as an experimental patch:
>=20
> 269b9b5be09d ("EXP sched: Disable DL server if sysctl_sched_rt_runtime is -=
1")
>=20
> Just checking to see if this is still something I should be carrying.

I think since it exposing boost issues, we should carry it! However since it=
 is also noisy, maybe for short term we not carry it in any trees since we a=
re getting close to posting the topic branches.

Do you see the same boost issues or frequency of them when carrying it on 6.=
15-rc1 without any of this merge windows changes?

By the way I have to rewrite that EXP patch at some point based on a review o=
f it but functionally that patch is good.

Thanks,

- Joel=20

>=20
>                            Thanx, Paul
>=20
>> thanks,
>>=20
>> - Joel
>>=20
>>=20
>>=20
>>=20
>>>=20
>>>                            Thanx, Paul
>>>=20
>>> ------------------------------------------------------------------------=

>>>=20
>>> [   15.911885] BUG: kernel NULL pointer dereference, address: 0000000000=
0000
>>> 00
>>> [   15.912413] #PF: supervisor instruction fetch in kernel mode
>>> [   15.912826] #PF: error_code(0x0010) - not-present page
>>> [   15.913218] PGD 0 P4D 0
>>> [   15.913420] Oops: Oops: 0010 [#1] SMP PTI
>>> [   15.913715] CPU: 3 UID: 0 PID: 62 Comm: rcu_torture_sta Not tainted 6=
.15.
>>> 0-rc1-00047-g6e14cad86633 #19 PREEMPT(undef)
>>> [   15.914535] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.15
>>> .0-1 04/01/2014
>>> [   15.915147] RIP: 0010:0x0
>>> [   15.915348] Code: Unable to access opcode bytes at 0xffffffffffffffd6=
.
>>> [   15.915856] RSP: 0000:ffffa0380021fdc8 EFLAGS: 00010246
>>> [   15.916256] RAX: 0000000000000000 RBX: ffffffffb6b02cc0 RCX: 00000000=
0000
>>> 000a
>>> [   15.916802] RDX: 0000000000000000 RSI: ffff9f121f418cc0 RDI: 00000000=
0000
>>> 0000
>>> [   15.917305] RBP: 0000000000000000 R08: ffff9f121f418d20 R09: 00000000=
0000
>>> 0000
>>> [   15.917789] R10: 0000000000000000 R11: 0000000000000005 R12: ffffffff=
b6b0
>>> 2d20
>>> [   15.918293] R13: 0000000000000000 R14: ffffa0380021fe50 R15: ffffa038=
0021
>>> fdf8
>>> [   15.918801] FS:  0000000000000000(0000) GS:ffff9f1268a96000(0000) knl=
GS:0
>>> 000000000000000
>>> [   15.919313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   15.919628] CR2: ffffffffffffffd6 CR3: 0000000017c32000 CR4: 00000000=
0000
>>> 06f0
>>> [   15.920004] Call Trace:
>>> [   15.920139]  <TASK>
>>> [   15.920256]  rcu_torture_stats_print+0x16b/0x670
>>> [   15.920514]  ? __switch_to_asm+0x39/0x70
>>> [   15.920719]  ? finish_task_switch.isra.0+0x76/0x250
>>> [   15.920982]  ? __pfx_rcu_torture_stats+0x10/0x10
>>> [   15.921222]  rcu_torture_stats+0x25/0x70
>>> [   15.921435]  kthread+0xf1/0x1e0
>>> [   15.921602]  ? __pfx_kthread+0x10/0x10
>>> [   15.921797]  ? __pfx_kthread+0x10/0x10
>>> [   15.922000]  ret_from_fork+0x2f/0x50
>>> [   15.922193]  ? __pfx_kthread+0x10/0x10
>>> [   15.922395]  ret_from_fork_asm+0x1a/0x30
>>> [   15.922605]  </TASK>
>>> [   15.922723] Modules linked in:
>>> [   15.922890] CR2: 0000000000000000
>>> [   15.923072] ---[ end trace 0000000000000000 ]---

