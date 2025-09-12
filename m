Return-Path: <linux-kernel+bounces-813721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D7B549EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FBEA7B49FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B97E2EBB88;
	Fri, 12 Sep 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="XYJFFpkm"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749262EA16D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673251; cv=none; b=Z6VM6SxRxEl+kzop3XTas1/0f0HaBuGye8o8Crz+D3QQH6+6aVzr42fXjIANgCN6HT7yPFyihsmYfIHzYiTClcJZlr09qRahmBp6JyBOu1FEn4+VCxnvSx4wA8KltVoCExjsX2Nz+4HkMgHZaIo56IV/uWuQglMKyrjqA5Gdnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673251; c=relaxed/simple;
	bh=jGl+MwMWo6epdHwM6byoy8LaqN1pHTitv90iBg1FLhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJfb74nVRZL3HRXf6aejS03OCZqY+Pqcyyb05slTbgJip+xOwTD7LGj2ZizvI8ZJ19mc3oXGBLImqJ/T1rRYOxmoEsbJOvNbGhjrNKXiFKNfYzD7MwiuLufr7piDtuNQiHMJpUxHhH4B4GGjw0D5WsV88lROJ+D79S2sd4M4h7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=XYJFFpkm; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ps+y4c3ioLI54Zkh/5XUrApcTYorbBi6MpMIscwzpg4=; b=XYJFFpkmYLPNaXR/oPuba4Wm78
	jggwOtG9YrLV73Y0QAnyxCkV0DN6GVOlTt+dtnP3Lb2C6mPQ5xTIGSCb5EuQcpQJI7NkzDTgBkltg
	l5njs5FaCTuVc3aEW1LEKyrs6yclk1xzsbj2ispTeRG50WRm2MvmS/C7GVvgQFCydbNHWmxyyfqHY
	cVYXgD3WucFMLLcChrSE/494M0NJbucQQbFq1SDGzavdHDcZoe9uKBuNZfErNHEARKOQbMtkJXjO8
	o+dbwzMKAaI4XB9GKLQbhpAkxkcLd05I9ehAmAo+nKMhPx1BadfrfiutrhjbIRQS9Spf0KCdLP1Xs
	ZX9x529w==;
Received: from [139.28.87.209] (helo=[10.122.115.253])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1ux0cS-00CVhM-3B; Fri, 12 Sep 2025 11:03:05 +0100
Message-ID: <ac735cc59bbdccd3e99f5fa9c779b3904d19f990.camel@codethink.co.uk>
Subject: Re: SCHED_DEADLINE tasks causing WARNING at kernel/sched/sched.h
 message
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Luca Abeni	 <luca.abeni@santannapisa.it>
Date: Fri, 12 Sep 2025 12:03:01 +0200
In-Reply-To: <aLlabksolt1imHXe@jlelli-thinkpadt14gen4.remote.csb>
References: <a90ee087c4dc21bbd548c933256d6b4a877a9fd9.camel@codethink.co.uk>
	 <7481bbd7c6652a963f132191dc622f1003938706.camel@codethink.co.uk>
	 <aLlabksolt1imHXe@jlelli-thinkpadt14gen4.remote.csb>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk

Hi Juri

Thanks for getting back to me and sorry for my late reply.

On Thu, 2025-09-04 at 11:22 +0200, Juri Lelli wrote:
> Hi Marcel,
>=20
> On 02/09/25 18:49, Marcel Ziswiler wrote:
> > Hi
> >=20
> > On Tue, 2025-09-02 at 16:06 +0200, Marcel Ziswiler wrote:
> > > As part of our trustable work [1], we also run a lot of real time sch=
eduler (SCHED_DEADLINE) tests on the
> > > mainline Linux kernel (v6.16.2 in below reported case).
> >=20
> > Looking through more logs from earlier test runs I found similar WARN_O=
Ns dating back as early as v6.15.3.
> > So
> > it does not look like a "new" issue in that sense.
> >=20
> > [snip]
> >=20
> > Any help is much appreciated. Thanks!
>=20
> What's the actual workload composition leading the warning. I noticed
> stress-ng in the report. Could you please share more details?

Yes, sure. It's actually the exact same workload as related to the regressi=
on I reported back in April [1].

We currently use three cores as follows:

#### core x

|sched_deadline =3D sched_period | sched_runtime | CP max run time 90% of s=
ched_runtime | utilisation | reclaim |
| -- | -- | -- | -- | -- |
|  5 ms  | 0.15 ms | 0.135 ms |  3.00% | no |
| 10 ms  | 1.8 ms  | 1.62 ms  | 18.00% | no |
| 10 ms  | 2.1 ms  | 1.89 ms  | 21.00% | no |
| 14 ms  | 2.3 ms  | 2.07 ms  | 16.43% | no |
| 50 ms  | 8.0 ms  | 7.20 ms  | 16:00% | no |
| 10 ms  | 0.5 ms  | **1      |  5.00% | no |

Total utilisation of core x is 79.43% (less than 100%)

**1 - this shall be a rogue process. This process will
 a) run for the maximum allowed workload value=20
 b) do not collect execution data

#### core y

|sched_deadline =3D sched_period | sched_runtime | CP max run time 90% of s=
ched_runtime | utilisation | reclaim |
| -- | -- | -- | -- | -- |
|  5 ms  | 0.5 ms | 0.45 ms | 10.00% | no |
| 10 ms  | 1.9 ms | 1.71 ms | 19.00% | no |
| 12 ms  | 1.8 ms | 1.62 ms | 15.00% | no |
| 50 ms  | 5.5 ms | 4.95 ms | 11.00% | no |
| 50 ms  | 9.0 ms | 8.10 ms | 18.00% | no |

Total utilisation of core y is 73.00% (less than 100%)

#### core z

The third core is special as it will run 50 jobs with the same configuratio=
n as such:

|sched_deadline =3D sched_period | sched_runtime | CP max run time 90% of s=
ched_runtime | utilisation |
| -- | -- | -- | -- |
|  50 ms  | 0.8 ms | 0.72 ms | 1.60% |

jobs 1-50 should run with reclaim OFF

Total utilisation of core y is 1.6 * 50 =3D 80.00% (less than 100%)

In addition to that main workload we also run further stressors like from t=
he stress-ng suite. However, only on
the remaining cores and in a controlled nsjail/apparmor sandbox.

Please let me know if you need any further details which may help figuring =
out what exactly is going on.

> Thanks!
> Juri

Cheers

Marcel

[1] https://lore.kernel.org/all/f532441d8b3cf35e7058305fd9cd3f2cbd3a9fac.ca=
mel@codethink.co.uk

