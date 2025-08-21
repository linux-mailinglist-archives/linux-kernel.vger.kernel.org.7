Return-Path: <linux-kernel+bounces-779721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D80CB2F7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DED6029E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAC3074B1;
	Thu, 21 Aug 2025 12:20:04 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506C2E11D7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778803; cv=none; b=hMqYuKs483icXqYEqlvSUkWu0IchspFqtMag/fwgMMvtuCmNN2gjcDou8BgW7HgQbVA+W0r41gO4uuNP0M0+0Yi5OBIbVVAUAYaSqHFugbTuq9szr/bMrcE/bCs93LEN69KZlM+SnZ4QgXFmDionrmeF5pbJwHE6OtvQFRd3RCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778803; c=relaxed/simple;
	bh=xOuw/hPVKNxVGdaXrZKBQlzMxmMU/xFsJYCxsSlgYXg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P0rEREeKdFmzNrpb1xb0H28HLzh3hGCfRootuFrZfWd06zsgQlMennCn5vlk3dSsA3zJBRulm+EHzG2/lT7V7CWma9q58wikwuE1/Hf0N35wb2KQeO/E+EE84SnZqoLegi/qRd43NcPcI0gipe47YDUYtAq627w0EyVk4Univkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Valentin Schneider <vschneid@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH] sched/fair: Optimize CPU iteration using
 for_each_cpu_and[not]
Thread-Topic: Re: [PATCH] sched/fair: Optimize CPU iteration using
 for_each_cpu_and[not]
Thread-Index: AdwSlNjfWk2e9fzLTdKJSWHIaD5DdQ==
Date: Thu, 21 Aug 2025 12:19:04 +0000
Message-ID: <d8da7d88bf91470cb1bc90630d6a7aff@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
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
X-FEAS-Client-IP: 172.31.3.12
X-FE-Policy-ID: 52:10:53:SYSTEM



> On 15/08/25 09:15, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> >
> > Replace open-coded CPU iteration patterns with more efficient
> > for_each_cpu_and() and for_each_cpu_andnot() macros in three locations.
> >
> > This change both simplifies the code and provides minor performance
> > improvements by using the more specialized iteration macros.
> >
>=20
> TBF I'm not sure it does improve anything for the SMT cases considering w=
e
> don't see much more than SMT8.
>=20

I did the blow simple test on 128 cpu, smt 2 machine, and result shows for_=
each_cpu_andnot is better :

for_each_cpu + if()    vs  for_each_cpu_andnot()
5026373            vs   3398283
4034229            vs   2711302



#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/cpumask.h>
#include <linux/sched/clock.h>

static int test_init(void)
{

        int cpu, sibling;
        int i =3D 0;
        int loop =3D 1000;
        u64 now;

        now =3D local_clock();

        while (loop--) {
                for (cpu =3D 0; cpu < 128; cpu++) {
                        for_each_cpu(sibling, cpu_smt_mask(cpu)) {
                                if (cpu =3D=3D sibling)
                                        continue;
                                i++;
                        }
                }
        }
        printk("%lld %d", local_clock() - now);

        i =3D0;
        loop =3D 1000;

        now =3D local_clock();
        while (loop--) {
                for (cpu =3D 0; cpu < 128; cpu++) {
                        for_each_cpu_andnot(sibling, cpu_smt_mask(cpu), cpu=
mask_of(cpu)) {
                                i++;
                        }
                }
        }

        printk("%lld %d", local_clock() - now);


        return -1;
}

module_init(livepatch_init);
MODULE_LICENSE("GPL");
MODULE_INFO(livepatch, "Y");

Thanks

-Li





> The task_numa_find_cpu() one I do agree makes things better.
>=20
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
>=20
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>


