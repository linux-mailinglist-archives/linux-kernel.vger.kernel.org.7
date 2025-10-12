Return-Path: <linux-kernel+bounces-849780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C40BD0DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A1D3B67E2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B18272E41;
	Sun, 12 Oct 2025 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="T7waS6er"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19227EEB3
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760313298; cv=none; b=dstcvuaZcSqdVcoPGZddsgbk0VBfwy9oMBdDWLUVrJE9RMy5uIprgNC77Ac1Tw9YZu3WT/+uJmu6Ydi5yRNNaXNDGnSN9PR0cxeoDJ53OpSZrYCni59LusKs5KlwHghy9FAsm82EQR8R6rC/rfdQxkT5BiLjjLztWHC5VOAJa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760313298; c=relaxed/simple;
	bh=iTyFt5ez1lBly+//wwjoO3grAFk0FSahGRzQMVVcmnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uMiPm9akLs7SqngkHY1aUBJpJZcBZvspKFtevlUXmWjf7S0zOccbi8Mz3CBrSkNTal+O+DCp2g/jgfxt15b0JWCexPwjPNWjQu+khwnaE4mT/XbjIjkd9KTpLalfdgt9LDmYTKBmJzlDrYf0BKXOx4CYJAnqjOtBuRhifAdKRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=T7waS6er; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1760313284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8CxAXJfbAsaYoAMPHJQ53bKHUsu2eren/sXR8daUSJM=;
	b=T7waS6erCcjJDvfRPTw6OjDLCboUisABvyYtd7kQzntiXik1ZN4FmwYgHNFszvMlF7sd+U
	rlgtpsCViyX2wLM/LKf7H9G9gqHt/3GvOU8L3JyWD67+XmriamrvkMk0+ASYDkH5LomUmd
	34H7FP4PaKxyBnmadq0Kqmkw3sdMxqHFAiqLcK1kxipyL5FU16VvUJ8Jtz9q1rFLb1hxnG
	9eD7ZL7FFggMLljWzjSwj7Wnc5qpMcyIAUqusQxQaxwO2exOB3Qa9Mn7Ozx/iTqHNeSE93
	2jDTerGDrcR+9HQRC+zzhGVMZPNdlx0oPpu0Bmiio90jTdLb3UastuTMS8P3WQ==
From: Val Packett <val@packett.cool>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	"Bryan O'Donoghue" <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	Vedang Nagar <quic_vnagar@quicinc.com>
Cc: Val Packett <val@packett.cool>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: iris: set default size when S_FMT is called with zero size
Date: Sun, 12 Oct 2025 20:50:41 -0300
Message-ID: <20251012235330.20897-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

According to 4.5.1.5 of the M2M stateful decoder UAPI documentation,
providing the width and the height is "required only if it cannot be
parsed from the stream", otherwise zero can be passed.

The iris driver would only set the state fields to DEFAULT_WIDTH/HEIGHT
once upon init, but they would get overwritten with zeroes from one S_FMT
call and the next S_FMT call would already see zeroes in place of the
defaults. For clients that used that sequence and did not pass a size,
such as rpi-ffmpeg, this would then result in REQBUFS failing due to
the zero size remembered in the state.

Fix by explicitly falling back to the defaults in S_FMT.

Fixes: b530b95de22c ("media: iris: implement s_fmt, g_fmt and try_fmt ioctls")
Link: https://github.com/jc-kynesim/rpi-ffmpeg/issues/103
Signed-off-by: Val Packett <val@packett.cool>
---
Somehow Venus didn't have this issue and didn't explicitly handle this..

I'm not familiar with this code so if there's a better way to comply
with the UAPI requirements by just not even getting to overwrite the
state with the provided 0 size, I could not figure it out.

Still, let's get this fixed one way or another.

Thanks,
~val
---
 drivers/media/platform/qcom/iris/iris_vdec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
index ae13c3e1b426..6be09d82e24d 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/iris/iris_vdec.c
@@ -196,6 +196,11 @@ int iris_vdec_s_fmt(struct iris_inst *inst, struct v4l2_format *f)
 	if (vb2_is_busy(q))
 		return -EBUSY;
 
+	if (f->fmt.pix_mp.width == 0 && f->fmt.pix_mp.height == 0) {
+		f->fmt.pix_mp.width = DEFAULT_WIDTH;
+		f->fmt.pix_mp.height = DEFAULT_HEIGHT;
+	}
+
 	iris_vdec_try_fmt(inst, f);
 
 	switch (f->type) {
-- 
2.51.0


