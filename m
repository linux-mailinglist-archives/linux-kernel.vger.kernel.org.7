Return-Path: <linux-kernel+bounces-814082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D630B54EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55082177145
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E58730DEC8;
	Fri, 12 Sep 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDITvuyV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9630E84F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682797; cv=none; b=YcXwx/W4lZXLPGzqwMG1MaXFF0tsclI4Z/5U3DJVK6mmD4JT5OkSD7jJTWinYHR9UVYQJlFT3mVhU7hADkO1O4s9a7RGDX6d16NA9cE2s1hvsjWb4InPmEw5rzj5p4Cw2KPqZ44HrOraggDoDEF8esx5SbBKPxX6aMlKPCffcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682797; c=relaxed/simple;
	bh=Vem+mD7YnvII4WUoWkOsIWojVllp/ghNcYZB9qlvTLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdtiQPx1lZSdR1I+QJm3WJJBACo+/wKH9Q8kFiuBACOhVdUwN/4m+GozgLxWLYvcahO4AVdGquWsj9l/2v9UtZ0kFOtI2i6dA83XGP1IW0ruLuTbxMGRnXeAjD1PDVcwARaoXTEZEk2tLLnCQb2g0JbmjEXat5a9+yX+/ZtfKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDITvuyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C976BC4CEF9;
	Fri, 12 Sep 2025 13:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682797;
	bh=Vem+mD7YnvII4WUoWkOsIWojVllp/ghNcYZB9qlvTLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDITvuyVWmvwzKJFj2L1dg7jOGHOuSn9pJOw2JnP6XLPIHi/Sq28wkzPEZQd4YXyd
	 jgzYdYuJtpabDD0Bzf1gKtlJPgQ+6H8/PnjSqkiy80CMYJp9wG0QvfE0VAKNLiDV4m
	 slnbOdfn+80r2D/Xp1+iun97NacnqCTyTajwxjE3BmYdc3oT3OhMNCv4Pq8i3BBvp1
	 qdMV67joWrzuZhsf3J5RoAcye2kAaIp2CBMHv8LDE7po8sBbSF8S6xQCB9gluTqg9s
	 pouN93YZPbzX+AKUCWTd0kYxbw65MlFa/WsA7TfwMe6fMBW3xQBt+5TG1rXnITw174
	 3PLKy6Zyi6TNA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/4] misc: fastrpc: Remove kernel-side domain checks from capability ioctl
Date: Fri, 12 Sep 2025 14:13:00 +0100
Message-ID: <20250912131302.303199-3-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912131302.303199-1-srini@kernel.org>
References: <20250912131302.303199-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ling Xu <quic_lxu5@quicinc.com>

Domain ID in the uAPI is misleading. Remove checks and log messages
related to 'domain' field in capability structure. Update UAPI to
mark the field as unused.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c      | 14 +-------------
 include/uapi/misc/fastrpc.h |  2 +-
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7eec907ed454..1dc69d234996 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1750,7 +1750,6 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 	uint32_t attribute_id = cap->attribute_id;
 	uint32_t *dsp_attributes;
 	unsigned long flags;
-	uint32_t domain = cap->domain;
 	int err;
 
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -1768,7 +1767,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
 	if (err == DSP_UNSUPPORTED_API) {
 		dev_info(&cctx->rpdev->dev,
-			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
+			 "Warning: DSP capabilities not supported\n");
 		kfree(dsp_attributes);
 		return -EOPNOTSUPP;
 	} else if (err) {
@@ -1796,17 +1795,6 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 		return  -EFAULT;
 
 	cap.capability = 0;
-	if (cap.domain >= FASTRPC_DEV_MAX) {
-		dev_err(&fl->cctx->rpdev->dev, "Error: Invalid domain id:%d, err:%d\n",
-			cap.domain, err);
-		return -ECHRNG;
-	}
-
-	/* Fastrpc Capablities does not support modem domain */
-	if (cap.domain == MDSP_DOMAIN_ID) {
-		dev_err(&fl->cctx->rpdev->dev, "Error: modem not supported %d\n", err);
-		return -ECHRNG;
-	}
 
 	if (cap.attribute_id >= FASTRPC_MAX_DSP_ATTRIBUTES) {
 		dev_err(&fl->cctx->rpdev->dev, "Error: invalid attribute: %d, err: %d\n",
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index f33d914d8f46..c6e2925f47e6 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -134,7 +134,7 @@ struct fastrpc_mem_unmap {
 };
 
 struct fastrpc_ioctl_capability {
-	__u32 domain;
+	__u32 unused; /* deprecated, ignored by the kernel */
 	__u32 attribute_id;
 	__u32 capability;   /* dsp capability */
 	__u32 reserved[4];
-- 
2.50.0


