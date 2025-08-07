Return-Path: <linux-kernel+bounces-758773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF27EB1D3B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD4DE4E20BC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3346A23C4F1;
	Thu,  7 Aug 2025 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ddpZ5xXi"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB541DF258
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553154; cv=none; b=LkzVf/KXTXdqM67cH5eRhgCz++ckOdlG92sgPXo/6QJYvfpzPZHOgOTh0fzTrjvWR/PCMV6P5k7eg+/ZNhKAiaHWhpgPVFbqDoM6gKnSHaxSK43YpXf5m7K4byPBnJ4Hy/p+nyZyJAkoCLgpDbGVuwMSEtW3xzSPcJZudGDyNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553154; c=relaxed/simple;
	bh=iU6+k605Pa6dK82vz9U+wSphvD1rr/weBJyGt8qTYck=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMsGPUpGnNFSQqMsGzW3QXIRwioNJ/CO3oiM1HwbnYDyeiD1L5QEuU4b3gno1fMrGlEurwODLltobYdT2EDm5w8YqqZkgxOL0m6o6YGoDoGYmE4asBkLFd7uHXkLcHUYdAzusUNHCyuk5lUaAG/7ZVLUIzRLbBYygXI3aFQ/ows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ddpZ5xXi; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7499c072736311f0b33aeb1e7f16c2b6-20250807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lDPf6gw3HXzny6ECXcfcEcO/+p36JpddaMwOtqXSszA=;
	b=ddpZ5xXinw6yjqAAJBZkOiaPdkxiNGneBOJ5xzf08Odw6xbPk+y68wXnxAvDxQGs2HkizCq+Y81CYANcNUO3P9oSMnnF7QA2Ihcm2ayAcIHqsK/KpOre3UkiIFYz9hWCkvkfcRjxvTX9/dRsPq1XmGDLOq+MpeW7a/fNGJii48c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:5a43bcd2-7f06-406c-9df2-b8511d72d3bf,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:fed62fa1-1800-4e4f-b665-a3d622db32cf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7499c072736311f0b33aeb1e7f16c2b6-20250807
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <kuyo.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 445442348; Thu, 07 Aug 2025 15:52:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 7 Aug 2025 15:52:23 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1258.39 via Frontend
 Transport; Thu, 7 Aug 2025 15:52:23 +0800
Message-ID: <9f91f77e5f39857aa84373fe1ae504de2a881533.camel@mediatek.com>
Subject: Re: [PATCH] sched/deadline: Add DL server activated message
From: Kuyo Chang <kuyo.chang@mediatek.com>
To: Juri Lelli <juri.lelli@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Ben
 Segall" <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Date: Thu, 7 Aug 2025 15:52:23 +0800
In-Reply-To: <aJRSmWCJI-GlApsR@jlelli-thinkpadt14gen4.remote.csb>
References: <20250805155347.1693676-1-kuyo.chang@mediatek.com>
	 <aJRSmWCJI-GlApsR@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-07 at 08:15 +0100, Juri Lelli wrote:
>=20
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
>=20
>=20
> Hi,
>=20
> On 05/08/25 23:53, Kuyo Chang wrote:
> > From: kuyo chang <kuyo.chang@mediatek.com>
> >=20
> > The DL server is introduced as a replacement for realtime
> > throttling.
> > When RT throttling is activated, a message
> > "sched: RT throttling activated" is shown. However, it is currently
> > difficult for users to know when the DL server is activated.
> >=20
> > This patch adds a similar message to indicate when the DL server
> > is activated, which helps users debug RT/CFS contention issues.
> >=20
> > Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> > ---
> > =C2=A0kernel/sched/deadline.c | 3 +++
> > =C2=A01 file changed, 3 insertions(+)
> >=20
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index e2d51f4306b3..8e0de6cdb980 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2042,6 +2042,9 @@ enqueue_dl_entity(struct sched_dl_entity
> > *dl_se, int flags)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __enqueue_dl_entity(dl_se);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (dl_server(dl_se))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 printk_deferred_once("sched: dl_server activated\n");
> > =C2=A0}
>=20
> Not sure if we want/need this, but, if we do, I believe
> fair_server_pick_task() might be a better place to put it, as it's
> really when the dl-server is called to do its job.
>=20

Thanks for your suggestion, maybe the minor patch as below

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e2d51f4306b3..82d1091e56f5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2395,6 +2395,7 @@ static struct task_struct *__pick_task_dl(struct
rq *rq)
 			goto again;
 		}
 		rq->dl_server =3D dl_se;
+		printk_deferred_once("sched: dl_server activated\n");
 	} else {
 		p =3D dl_task_of(dl_se);
 	}
--=20

I believe the debug message could help to verify that the DL server is
actually working.
It will be a great help for users to debug RT/FAIR contention issues
when this clue message occurs.

> Thanks,
> Juri
>=20


