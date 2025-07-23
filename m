Return-Path: <linux-kernel+bounces-741748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215FBB0E880
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58811C832DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542A1D5170;
	Wed, 23 Jul 2025 02:09:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D51CD15
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753236565; cv=none; b=aLPDbNwycbvV7NqDSJIjVgX9ubspvTNAfGcVcPZX2zvLtXLFitb/DKVZ/PzFSvxvRzfzPgMvd3XcSaCDHNKRHzaLrLHHeHGE1UIChCn9nPe7P/45M1Yjzd9gkQKoCDOFSeqnorNDdiAgHks4DP6Oorek0Ub4Qlkxk6qz5qRZ4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753236565; c=relaxed/simple;
	bh=R/L5mczysXcwXhZUxPMulLr07zivbu9sBvZZFY+ESIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FyWClc4zvI8oD/Zje+zuZCe9VN1NdAYALEBYr6p8GLNX6ALC2mRNAJ0/wDoIVrKMZstdkQ5/OjsaYzPrmzey3j5Q8J3vyLwzQ3YUKN66yff7e4Dh17BhzVDKQ9YPPBdIJGxNOdX3G6NDg6Z6ygT13Erbi1vPhjRpExQdEdMa5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 06dadac6676a11f0b29709d653e92f7d-20250723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:508bbe8b-b8ab-44f5-a05f-78d394b8e0de,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:1e6794a25d96a091028edbdfd983aca7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 06dadac6676a11f0b29709d653e92f7d-20250723
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 672945437; Wed, 23 Jul 2025 10:09:12 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jens.wiklander@linaro.org,
	sumit.garg@kernel.org,
	larper@axis.com,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] tee: fix NULL pointer dereference in tee_shm_put
Date: Wed, 23 Jul 2025 10:09:07 +0800
Message-Id: <fabd3d7560119e52dd83f4a19ad1f8087862993f.1753236468.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tee_shm_put have NULL pointer dereference:

__optee_disable_shm_cache -->
	shm = reg_pair_to_ptr(...);//shm maybe return NULL
        tee_shm_free(shm); -->
		tee_shm_put(shm);//crash

Add check in tee_shm_put to fix it.

panic log:
Unable to handle kernel paging request at virtual address 0000000000100cca
Mem abort info:
ESR = 0x0000000096000004
EC = 0x25: DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
FSC = 0x04: level 0 translation fault
Data abort info:
ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
CM = 0, WnR = 0, TnD = 0, TagAccess = 0
GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000002049d07000
[0000000000100cca] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] SMP
CPU: 2 PID: 14442 Comm: systemd-sleep Tainted: P OE ------- ----
6.6.0-39-generic #38
Source Version: 938b255f6cb8817c95b0dd5c8c2944acfce94b07
Hardware name: greatwall GW-001Y1A-FTH, BIOS Great Wall BIOS V3.0
10/26/2022
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : tee_shm_put+0x24/0x188
lr : tee_shm_free+0x14/0x28
sp : ffff001f98f9faf0
x29: ffff001f98f9faf0 x28: ffff0020df543cc0 x27: 0000000000000000
x26: ffff001f811344a0 x25: ffff8000818dac00 x24: ffff800082d8d048
x23: ffff001f850fcd18 x22: 0000000000000001 x21: ffff001f98f9fb88
x20: ffff001f83e76218 x19: ffff001f83e761e0 x18: 000000000000ffff
x17: 303a30303a303030 x16: 0000000000000000 x15: 0000000000000003
x14: 0000000000000001 x13: 0000000000000000 x12: 0101010101010101
x11: 0000000000000001 x10: 0000000000000001 x9 : ffff800080e08d0c
x8 : ffff001f98f9fb88 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : ffff001f83e761e0 x1 : 00000000ffff001f x0 : 0000000000100cca
Call trace:
tee_shm_put+0x24/0x188
tee_shm_free+0x14/0x28
__optee_disable_shm_cache+0xa8/0x108
optee_shutdown+0x28/0x38
platform_shutdown+0x28/0x40
device_shutdown+0x144/0x2b0
kernel_power_off+0x3c/0x80
hibernate+0x35c/0x388
state_store+0x64/0x80
kobj_attr_store+0x14/0x28
sysfs_kf_write+0x48/0x60
kernfs_fop_write_iter+0x128/0x1c0
vfs_write+0x270/0x370
ksys_write+0x6c/0x100
__arm64_sys_write+0x20/0x30
invoke_syscall+0x4c/0x120
el0_svc_common.constprop.0+0x44/0xf0
do_el0_svc+0x24/0x38
el0_svc+0x24/0x88
el0t_64_sync_handler+0x134/0x150
el0t_64_sync+0x14c/0x15

Fixes: dfd0743f1d9e ("tee: handle lookup of shm with reference count 0")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/tee/tee_shm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..915239b033f5 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -560,9 +560,13 @@ EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
  */
 void tee_shm_put(struct tee_shm *shm)
 {
-	struct tee_device *teedev = shm->ctx->teedev;
+	struct tee_device *teedev;
 	bool do_release = false;
 
+	if (!shm || !shm->ctx || !shm->ctx->teedev)
+		return;
+
+	teedev = shm->ctx->teedev;
 	mutex_lock(&teedev->mutex);
 	if (refcount_dec_and_test(&shm->refcount)) {
 		/*
-- 
2.25.1


