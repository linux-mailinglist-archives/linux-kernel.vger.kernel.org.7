Return-Path: <linux-kernel+bounces-812230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48FEB534CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BA5AA1676
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB233A005;
	Thu, 11 Sep 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fv9+vDA3"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B06338F2C;
	Thu, 11 Sep 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599258; cv=none; b=WIDuCuEix2Wj1ONi3DAaYcBarsMr6lN1t2d8jhHxKrnglQFq6bJs/24c4EEV30lCrRIYuj+awZk3Zv+cAv3ukN3kweb0aFV19RQg5KTIuNqwb3W5o7xaNACb8CH0WPyB7rk0lT0rGIdL2f6CvT/V5Ex0vdVjmiCtU+owxq6CDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599258; c=relaxed/simple;
	bh=qVSzDflrSo3BQiinpUPlOgvadbMuKniaMN2/sCUJ7UA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ucFrYvkWbB3odtMt/HBPjHVY7CuyGwSQg0G3aeZdJ/jLLqak6fzZxWsJkcouHEQ5oJucoWZS6FXu0ID66fL4iGpIcOO1jptGkEH2sd298nXyvVOZgPm12ILfPGjf01kDYFSF2AZ48IB3zEsvaKnqjm+/WpMisGLK+NuwtK+3CJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fv9+vDA3; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757599238; x=1758204038; i=markus.elfring@web.de;
	bh=qVSzDflrSo3BQiinpUPlOgvadbMuKniaMN2/sCUJ7UA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fv9+vDA338S//n0LyrAubA0erQAbpqpEF05qkXXPI3+4TRrRx+S31oAfEZIkMAd9
	 WoauINAv+t3l0/5JQJD9wHRvnn/OdRCjfc7G6BMc2Q8cCE+C6Jo16t35FD+83Ht9l
	 8xIw2TwvjkuaOZAsYLQC4zBNVMTdHAkcayA+ecWnjL/wA3tkoJtF1Ayp2Qctl4E5h
	 nl8Y2g9pLVMyKrJ33YEdVMi+1mq3d2QAUoLFA4ksgfhmYKRCohWoYfLdGTiYRpzjm
	 8/cdazobXkA6eWAJyhWTnhovhFIbsCo2Y2RGw//kWt1G1Qxqy7xvzijT8QOF+vLx9
	 fIxYxExT8Ra7Em3pWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.247]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKtb-1uTgdB042F-00bLn4; Thu, 11
 Sep 2025 16:00:38 +0200
Message-ID: <34069a28-89e2-4881-a8a6-bb9d32c97191@web.de>
Date: Thu, 11 Sep 2025 16:00:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yury Norov <yury.norov@gmail.com>, kernel-janitors@vger.kernel.org,
 Ben Segall <bsegall@google.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250911023426.457745-1-yury.norov@gmail.com>
Subject: Re: [PATCH] sched: fair: drop useless cpumask_empty() in
 find_energy_efficient_cpu()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250911023426.457745-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QIAl2ZUhZ7fDO1WgIdNOvscCPPU7zSjbPHRu22TQ59Qq4ti3LVg
 Mq+85PXuArJHqkNgClB8qrCacFP4o9vvlTM/prscoMwMWE87deO2yBD9LNjw53ap5sx77bO
 zTqD3uSOwfID33tptsg6fpObfxaxc+swJ2rauaEeNDS2ICotsgzCNGbfGx3PY0FYD969pr7
 II8lpCeVedpUpAaMYLUlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ETmD8j/S0/8=;yYYvBLsxhfeGPvJ5lIH+vDswsa8
 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
 4PNQ30qplu5i6dauSCLXYatkf9udaCqbJ2KlU

> cpumask_empty() call is O(N) and useless, because the previous
> cpumask_and() returns false for empty 'cpus'.

It seems to be more helpful to reuse a return value from a previous functi=
on call.
How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc5#n94

Regards,
Markus

