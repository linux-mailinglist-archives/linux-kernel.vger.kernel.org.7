Return-Path: <linux-kernel+bounces-864333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B18BFA897
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CB06343EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB92F7477;
	Wed, 22 Oct 2025 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Urjm/JVr"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930612F6587
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118067; cv=none; b=rHHoV3quaVs+pq+34JznQfOpKJFzKhvwGUowyOwgMZAA80g6PPKS6LIVNki3BZc/x7qGJ9FMGlXOwOXzHuuW5RKuezEYNhw1wZcquP/etxtijARwGX3F0cugRqs09R+bugR905BjRG4R0WN0s3ydtyBaIgzR79N3RIuhCfAz3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118067; c=relaxed/simple;
	bh=VtUMNaw4ruoQ3kFV5+nVhEivrVKvbtHjhwwlZEjSU7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B+EenManJcZm4LiSXXLxMOwTedvkDxdhYzqUQgGuN9fMV21hmPC6Z+dKq8Mu3uNG6EpG2rBzDyR9hGmiDcYRMrUUKt7DGoucn1pEsPKJbN3eRO9H4Apve9aYC9BByRNYNfeHRsX/XJz7jw3UD2Is8sQXuJSBt+b+yvVWph/R5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Urjm/JVr; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 969840d6af1811f0ae1e63ff8927bad3-20251022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=q7yicpS15zPxjlX0KlnUi85k1BzEdOnSdAY4PjiZnyU=;
	b=Urjm/JVrxPwpPsi3+iWkfHgpZ4SmrjSk/86yvpz26twuB8bOLaGL/rsL/NOSIJfmMokb3JA5bjWcj6pPEFnXR/xJl9avlaSwS72DJtk4RomFh8QSZI5qKwcOvNMW85aS4TzS6CZaib2N1plrHCmxXaTP7SSjBRViBVtJIAL9CqQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:cdfded1d-b7f7-44bc-aa35-68cab6571112,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:0f44b43a-b16f-49fc-bb37-560773c432f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 969840d6af1811f0ae1e63ff8927bad3-20251022
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1263301731; Wed, 22 Oct 2025 15:27:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 22 Oct 2025 15:27:37 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 22 Oct 2025 15:27:36 +0800
From: <xion.wang@mediatek.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley
	<stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <huadian.liu@mediatek.com>, Xion Wang
	<xion.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/1] selinux: export current_sid API for use in other kernel modules
Date: Wed, 22 Oct 2025 15:27:17 +0800
Message-ID: <20251022072729.14820-1-xion.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Xion Wang <xion.wang@mediatek.com>

We have a kernel driver designed to monitor the status of the Android
userspace watchdog. The implementation works as follows: we modify the
Android userspace watchdog code to periodically send a "kick" signal to
the kernel driver via ioctl, so that the kernel driver can determine
whether the userspace is still responsive. If the kernel driver does not
receive a kick signal from the userspace watchdog within a certain
period, it infers that the userspace is stuck. In this case, the kernel
driver will dump key process information at the kernel level and trigger
a full system reboot.

To ensure that only the legitimate Android userspace watchdog process can
access the ioctl interface and perform the kick operation, and to prevent
malicious or unauthorized processes from spoofing the kick action (which
could compromise system reliability), we want to identify the calling
task by its security identifier (sid). By checking the sid, we can
effectively prevent unauthorized processes from sending kick signals.

Currently, the current_sid() function in the kernel is defined as
static inline and cannot be directly called from modules or drivers. We
propose to export this function, so that the kernel driver can call
current_sid() to obtain the sid of the current process and decide whether
to allow the kick operation.

This change will help enhance system security and robustness by
preventing the watchdog mechanism from being bypassed or abused.

I would like to ask the maintainers if there are any additional security
concerns regarding exporting current_sid() as a public API, or if there
are any alternative or more recommended approaches to achieve this goal.
Any feedback or suggestions would be greatly appreciated.

Xion Wang (1):
  selinux: export current_sid API for use in other kernel modules

 security/selinux/hooks.c          | 11 +++++++++++
 security/selinux/include/objsec.h | 12 ++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.45.2


