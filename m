Return-Path: <linux-kernel+bounces-814084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF5B54F02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541E55A04B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31F311944;
	Fri, 12 Sep 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8yFwPgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDBB31158A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682800; cv=none; b=OMOpJC0hFr279WvGH4PNuW+AGyabfHK7lbjuz1eGz4oTAaIvyDqOswH2Q0JnxK97OD9QfUB5JJhGwFliAwDbJAvPEouLnaUclRtAtHJKDdw8RXcHd741kUcFkziItijO1JY/k4/XYxlMmKsRk8GYM9QqrPr0U+eB0TKkWZx6tEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682800; c=relaxed/simple;
	bh=z2okbvpEzQfU4OrKuk32NxS1oROubzvEwtkcZHLDBY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIog8L//MzaY2Rj8OcG/BT0/W4TYbbMu4Guk7MPUONGTgiqWAYiyYVtmPPySvlP/79XfVKSiup8t0V84rod2Dpz/m87j33FXP8TtJ6yDZW0WcBC+Lxv8sObasckTRMCH0RzHeoLbnzbMlbZE2mBO54NPmOEn+92NXP/BN33fr4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8yFwPgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A39CC4CEF1;
	Fri, 12 Sep 2025 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682800;
	bh=z2okbvpEzQfU4OrKuk32NxS1oROubzvEwtkcZHLDBY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l8yFwPgTIanqhAB78A0RJrxHZ/ZDhTwr1HNnckcL16zlVmMeKo0L0p3KFOEuLXlwZ
	 QkZ4EFTamh1qtp/YfbjRexkX35qiqhb9FvrxjXONE+RqzqN8v+vOzbbvJo9yiWdLgZ
	 xMKXm7RuWe5YivvtPXMM3zqDt0pcqt+jj7UV7Hn0jzX8oyZtLqiwcUNcVloe6qWr2h
	 RXG4/q3n0i/6iJL8yJIudq6HDjJqsEt7v8RAQwNCs/atOt5xDvnAELxtR1iHOs0nDv
	 StvDVVlrIimi2XeA9J3PgoGkYownHrCG9gIjsLJGueiS5PJs1kcxwwUhIY7hrz/hxQ
	 Kj8lW1ZL29aFg==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 4/4] misc: fastrpc: add support for gdsp remoteproc
Date: Fri, 12 Sep 2025 14:13:02 +0100
Message-ID: <20250912131302.303199-5-srini@kernel.org>
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

Some platforms (like lemans) feature one or more GPDSPs (General
Purpose DSPs). Similar to other kinds of Hexagon DSPs, they provide
a FastRPC implementation, allowing code execution in both signed and
unsigned protection domains. Extend the checks to allow domain names
starting with "gdsp" (possibly followed by an index).

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 93ec587fcab6..621bce7e101c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -27,6 +27,7 @@
 #define MDSP_DOMAIN_ID (1)
 #define SDSP_DOMAIN_ID (2)
 #define CDSP_DOMAIN_ID (3)
+#define GDSP_DOMAIN_ID (4)
 #define FASTRPC_MAX_SESSIONS	14
 #define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
@@ -2276,6 +2277,8 @@ static int fastrpc_get_domain_id(const char *domain)
 		return MDSP_DOMAIN_ID;
 	else if (!strncmp(domain, "sdsp", 4))
 		return SDSP_DOMAIN_ID;
+	else if (!strncmp(domain, "gdsp", 4))
+		return GDSP_DOMAIN_ID;
 
 	return -EINVAL;
 }
@@ -2345,13 +2348,14 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
 	case SDSP_DOMAIN_ID:
-		/* Unsigned PD offloading is only supported on CDSP */
+		/* Unsigned PD offloading is only supported on CDSP and GDSP */
 		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
 		if (err)
 			goto err_free_data;
 		break;
 	case CDSP_DOMAIN_ID:
+	case GDSP_DOMAIN_ID:
 		data->unsigned_support = true;
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, data, true, domain);
-- 
2.50.0


