Return-Path: <linux-kernel+bounces-690620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B2ADD998
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 19:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3FC4A8054
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165EF28507C;
	Tue, 17 Jun 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ashe.io header.i=@ashe.io header.b="Kc0SWpLX"
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7036231A37
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178108; cv=none; b=AfQP2sySuDa1vh/Q2j7d0Md97N5zaq0zrc2mc9iTeEPmpRwUbCUkij2vDvXjnA0RA6tXdzlJKUSdTm1Po2yWpJogb3D7mHePJx8S2xUkO8I0xKcVBSZ9FJcLuEa4jhqTT/6x4Sad/IloJ1/pvUctGc4FRpFrAPMbgMiNwKGHbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178108; c=relaxed/simple;
	bh=aADlZ16iPb4JlaQWfs+94eC38upeNt6R9aA4PtN5LFg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WHLHLedHgxvaDxiebBZd534X2NHnw1M8j+bDt4Up9MT0Om7/K82IBZY4SUhcnHmFpU6iFPWZpQrz36kbJc+tq+I+J/nBjCnDLVBHVfzRduBXVGzCn2EMHRxMMxKCCrugyt8YZkW0+4GDv/AROdzBY8wq965kwA6iNMkGB641/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ashe.io; spf=pass smtp.mailfrom=ashe.io; dkim=pass (2048-bit key) header.d=ashe.io header.i=@ashe.io header.b=Kc0SWpLX; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ashe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ashe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ashe.io;
	s=protonmail2; t=1750178096; x=1750437296;
	bh=aADlZ16iPb4JlaQWfs+94eC38upeNt6R9aA4PtN5LFg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Kc0SWpLXomx7DUg9JOqYbrXAVvl1EP/HF8/UJJ68DEwLefYa0a7L1d/9eWSNfBHcX
	 uMMha4wiLQSSbyMVNPC0iCGsbDseYWoYaanaYknwWBIzA9o3WnSmzVZn5Yk/yY1fKY
	 0gGJYlwDdAiEmyejnz8OpW1qKvIsqVIYwsqnVa7Jdi3G/niZy/dlcsIbLdbrtWdIEG
	 gjH2G8fR9cEpKrRXYCu5/bYXcggm1WY+r/ue3M3rTfxhJsE9hJ1l22TXbeAF0e1TXV
	 TskM77FnUijYI+nCvdQLRwUPUDHlwjyiw8RHp7D0SA6udCOwP/Ta5qlYihUZZyENp/
	 TBsZzXOV6wMhQ==
Date: Tue, 17 Jun 2025 16:34:52 +0000
To: "john.g.garry@oracle.com" <john.g.garry@oracle.com>
From: "Sean A." <sean@ashe.io>
Cc: "James.Bottomley@hansenpartnership.com" <James.Bottomley@HansenPartnership.com>, "atomlin@atomlin.com" <atomlin@atomlin.com>, "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "mpi3mr-linuxdrv.pdl@broadcom.com" <mpi3mr-linuxdrv.pdl@broadcom.com>, "sreekanth.reddy@broadcom.com" <sreekanth.reddy@broadcom.com>, "sumit.saxena@broadcom.com" <sumit.saxena@broadcom.com>
Subject: Re: [RFC PATCH v2 1/1] scsi: mpi3mr: Introduce smp_affinity_enable module parameter
Message-ID: <1xjYfSjJndOlG0Uro2jPuAmIrfqi5AVbfpFeWh7RfLfzqqH9u8ePoqgaP32ElXrGyOB47UvesV_Y2ypmM3cZtWit2EPnV3aj6i9w_DMo1eI=@ashe.io>
Feedback-ID: 119619660:user:proton
X-Pm-Message-ID: 66632c2760772bcd62fe3f5db77cf6364e199897
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Le 17 Jun 2025, John Garry a =C3=A9crit :
> You have given no substantial motivation for this change

From my perspective, workloads exist (defense, telecom, finance, RT etc) th=
at prefer not to be interrupted and developers may opt to utilize CPU isola=
tion and other mechanisms to reduce the likelihood of being pre-empted, evi=
cted, etc. This includes steering interrupts away from an isolated set of c=
ores. Also while this doesn't result from any actual benchmarking, it would=
 seem that forcing your way on to every core in a 192 core system and refus=
ing to move might be needlessly greedy or even detrimental to performance i=
f most of the core set is NUMA-foreign to the storage controller. One shoul=
d be able to make placement decisions to protect app threads from interrupt=
ion and to ensure the interrupt handler has a sleepy, local core to play wi=
th without lighting up a bunch of interconnect paths on the way.

Generically, I believe interfaces like /proc/$pid/smp_affinity[_list] shoul=
d be allowed to work as expected, and things like irqbalance should also be=
 able to do their jobs unless there's a good (documented) reason they shoul=
d not.
SA

