Return-Path: <linux-kernel+bounces-757267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D27B1C015
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E31189739C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3911FCFF8;
	Wed,  6 Aug 2025 05:51:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB8718A6A5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459483; cv=none; b=mk6FIImj4LvluDS9am/pT9V51BfBNWk4Irw6DrDxAeQafDq3/n8o//oto/RbWViis4TRoW5nkD+JoSMMG09JnaM1FKSn3LRNiQXSjtS3WQWM1sNgiAeOInE9wR2/c9xwGXpuedJRp6ThyrNj5yYtwrlpPkmQimqInK9QGDDjfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459483; c=relaxed/simple;
	bh=1hdyWbNt3HhmVhm1mIE8TvoJy+YhklUAssUvmq2XY3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qzjIJgKAqYNAxqe8BPsaAb6p95jCcw5bBdzstAAx+7OmNumZoumK+OyP6ZpOkU2bwjnW0fAjCNLEQp0zrXGeA7DvnTIHS9AnMiBdQ/XPa+RexNOMIaV+8FeoogcEpOD4qszIpId6X8QS7rUlXqVZZwr3c6yGuIYlwwOQSyY1Rkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c90e0a8728911f0b29709d653e92f7d-20250806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7fb56755-3785-4b0e-93ce-823174a2ee0a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:302b5a4f98e223cc71f14d88a51b63d3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5c90e0a8728911f0b29709d653e92f7d-20250806
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1598190382; Wed, 06 Aug 2025 13:51:13 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 898B0E008FA3;
	Wed,  6 Aug 2025 13:51:13 +0800 (CST)
X-ns-mid: postfix-6892ED51-43911259
Received: from localhost.localdomain (unknown [10.42.12.14])
	by mail.kylinos.cn (NSMail) with ESMTPA id D73A6E008FA2;
	Wed,  6 Aug 2025 13:51:11 +0800 (CST)
From: Li Qiang <liqiang01@kylinos.cn>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Subject: Re: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for performance
Date: Wed,  6 Aug 2025 13:51:11 +0800
Message-Id: <20250806055111.1519608-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9d60bae4-a61b-4d4a-a0a8-19058df30b0f@lucifer.local>
References: <9d60bae4-a61b-4d4a-a0a8-19058df30b0f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tue, 5 Aug 2025 14:35:22, Lorenzo Stoakes wrote:
> I'm not sure, actual workloads would be best but presumably you don't h=
ave
> one where you've noticed a demonstrable difference otherwise you'd have
> mentioned...
>=20
> At any rate I've come around on this series, and think this is probably
> reasonable, but I would like to see what increasing max-inline-insns-si=
ngle
> does first?

Thank you for your suggestions. I'll pay closer attention=20
to email formatting in future communications.

Regarding the performance tests on x86_64 architecture:

Parameter Observation:
When setting max-inline-insns-single=3D400 (matching arm64's=20
default value) without applying my patch, the compiler=20
automatically inlines the critical functions.

Benchmark Results:

Configuration			Baseline		With Patch			max-inline-insns-single=3D400
UnixBench Score			1824			1835 (+0.6%)			1840 (+0.9%)
vmlinux Size (bytes)	35,379,608		35,379,786 (+0.005%)	35,529,641 (+0.4%)

Key Findings:

The patch provides significant performance gain (0.6%) with=20
minimal size impact (0.005% increase). While=20
max-inline-insns-single=3D400 yields slightly better=20
performance (0.9%), it incurs a larger size penalty (0.4% increase).

Conclusion:
The patch achieves a better performance/size trade-off=20
compared to globally adjusting the inline threshold. The targeted=20
approach (selective __always_inline) appears more efficient for=20
this specific optimization.

