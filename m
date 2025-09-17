Return-Path: <linux-kernel+bounces-820231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC070B7C80C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27221BC0F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4C309DA1;
	Wed, 17 Sep 2025 08:25:48 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50621CA0D;
	Wed, 17 Sep 2025 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097548; cv=none; b=KeNVZSCfsBnjEgXqdNv5uVVPB8QWsF80Z0IJgA/dmGNIKpt7IJ+7A6nbA0d8K2hhos6DFTC6G6297/8X0JPWBjvlspYMu8qAKo8+aendlv0Y8049D7BqEWdXnsgYYK1tzRQUk7TSGwhXpPmhypsqyb6qqvwqqP5zFVqUWiLf7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097548; c=relaxed/simple;
	bh=Wh0c6cnsANVn3Q7Tby8/Zat2Nt4mwlunMzaJrcSfQvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGnFrbcw9N0+BhbCmvp6QvPxqfeIm7qDxs28JSjBMB/k6tRgorSvzLsJbJPnZdyf0NU51DBiz+53Hr3FU7umvIk1FJLrctqDs4rVS9R2SBNlUo/hWY04t6HqnS2EGKqAvot+JIzGI3Mqcm97swc48iEBmiLga4cKtiEbkZEWLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e0f1f170939f11f0b29709d653e92f7d-20250917
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:74a35ace-c176-442b-bed6-2e9c10f5b03f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:19058ad1ff0e6319eff22cbc49470bf1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e0f1f170939f11f0b29709d653e92f7d-20250917
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 499005851; Wed, 17 Sep 2025 16:25:33 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id ED20B160042A4;
	Wed, 17 Sep 2025 16:25:32 +0800 (CST)
X-ns-mid: postfix-68CA707B-5921601002
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id DA285160042A0;
	Wed, 17 Sep 2025 08:25:30 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: westeri@kernel.org
Cc: andreas.noever@gmail.com,
	michael.jamet@intel.com,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiayi_dec@163.com,
	Jiayi Li <lijiayi@kylinos.cn>
Subject: [PATCH RFC] thunderbolt: Re-add DP resources on resume
Date: Wed, 17 Sep 2025 16:24:56 +0800
Message-ID: <20250917082456.1790252-1-lijiayi@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During suspend, DP resources are released through tb_disconnect_and_relea=
se_dp()
but were not being re-added during resume, preventing DP tunnels from bei=
ng
re-established.

This caused DP displays connected via Thunderbolt docks (such as Targus d=
ocks)
to not display after S3 resume. The issue was visible in logs:

[246.397437] tb_cfg_ack_plug:819: thunderbolt 0000:2c:00.0: acking hot pl=
ug event on 3:10
[246.398282] tb_dp_resource_available:2019: thunderbolt 0000:2c:00.0: 3:1=
0: DP OUT resource available
[246.398291] tb_tunnel_dp:1875: thunderbolt 0000:2c:00.0: looking for DP =
IN <-> DP OUT pairs:
[246.398294] tb_tunnel_dp:1899: thunderbolt 0000:2c:00.0: no suitable DP =
IN adapter available, not tunneling

Add call to tb_add_dp_resources() in tb_resume_noirq() to ensure DP resou=
rces
are properly re-added during resume, allowing DP tunnels to be re-establi=
shed.

Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
---
 drivers/thunderbolt/tb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c14ab1fbeeaf..cb652df3fc9f 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -3119,6 +3119,7 @@ static int tb_resume_noirq(struct tb *tb)
 		tb_switch_reset(tb->root_switch);
=20
 	tb_switch_resume(tb->root_switch, false);
+	tb_add_dp_resources(tb->root_switch);
 	tb_free_invalid_tunnels(tb);
 	tb_free_unplugged_children(tb->root_switch);
 	tb_restore_children(tb->root_switch);
--=20
2.47.1


