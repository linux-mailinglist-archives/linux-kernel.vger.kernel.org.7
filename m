Return-Path: <linux-kernel+bounces-806580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E7B498B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D01F340383
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BCF31CA49;
	Mon,  8 Sep 2025 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="bXN/CCZ9"
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290C31AF27
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357306; cv=none; b=dOb9dR3ybVr+E2LJoYdzaLGoFmlOrS/8lYRITxrMACGwmuoLZ3IrNTj5/I+KrbmABadvao7mtuM4DkGy7CrrYotQGCysy1tcZpz5bhFJ3Wz3zos+ggeB7lGBkH1+BHW8Snmjkz1kdCj3G9ZrCVV5Jt1n5KhkH6YPdpD4x74zR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357306; c=relaxed/simple;
	bh=tZxYb0uG1pVYCFAlE2Xx8jInj2yfc8dt9AvIkZMhXeg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gpUtwzuUK/jlKnUOicGjbsrvEhYNMovQKExMJsnlr0w1c5OX/Pp6plWz+XpgUy8O2aTuBiOswpmLE1YcRwouSzedi+keUeonzUkV4QLrucyz4oX+yU92N/lJU4AZTuU1IDaXR5HqgZK5R48Uw81nojmeRqSumON2CdObtcbSANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=bXN/CCZ9; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id XKvqW97nBl2Yag9r; Mon, 08 Sep 2025 14:48:23 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=2mEIfVXrub6Npv/Fr/lvqsQ058qpuI+GzoBKWdxKTCQ=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=bXN/CCZ9ug/1i2Xynx5i
	P+so3tNX06MTAK83yy0HtQW9vYTDK3ERTQZ9qaYkJWhYOjSBVyDILI39U5nG2PRahT12LMcFU6yIe
	xLKKpB+DrdlysR8n3TTkdQ/qnTZbGnNTSFimntGOYKuLvVj6jsyG21kqDg2AdjCj3ucBrs9LTY=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14189115; Mon, 08 Sep 2025 14:48:23 -0400
Message-ID: <88982e77-f758-470b-92ea-6c18ef433e0f@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 8 Sep 2025 14:48:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 02/15] scsi: qla2xxx: fix initiator mode with
 qlini_mode=exclusive
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 02/15] scsi: qla2xxx: fix initiator mode with
 qlini_mode=exclusive
From: Tony Battersby <tonyb@cybernetics.com>
To: Nilesh Javali <njavali@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, target-devel@vger.kernel.org,
 scst-devel@lists.sourceforge.net,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f8977250-638c-4d7d-ac0c-65f742b8d535@cybernetics.com>
In-Reply-To: <f8977250-638c-4d7d-ac0c-65f742b8d535@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1757357303
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1148
X-ASG-Debug-ID: 1757357303-1cf43947df30c290001-xx1T2L

When given the module parameter qlini_mode=exclusive, qla2xxx in
initiator mode is initially unable to successfully send SCSI commands to
devices it finds while scanning, resulting in an escalating series of
resets until an adapter reset clears the issue.  Fix by checking the
active mode instead of the module parameter.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index a52293972e10..f0b77f13628d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3438,13 +3438,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		ha->mqenable = 0;
 
 	if (ha->mqenable) {
-		bool startit = false;
-
-		if (QLA_TGT_MODE_ENABLED())
-			startit = false;
-
-		if (ql2x_ini_mode == QLA2XXX_INI_MODE_ENABLED)
-			startit = true;
+		bool startit = !!(host->active_mode & MODE_INITIATOR);
 
 		/* Create start of day qpairs for Block MQ */
 		for (i = 0; i < ha->max_qpairs; i++)
-- 
2.43.0



