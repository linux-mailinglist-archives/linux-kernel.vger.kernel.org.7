Return-Path: <linux-kernel+bounces-732680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCABB06A90
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EB7568187
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638919E96D;
	Wed, 16 Jul 2025 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="K+H4ziB4"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB24919CD1D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625945; cv=none; b=oLY81Rx+k/tjJ2LAwI31kZ0IBd3zU4v1TytzMGeSVGOi78u0QW/S7pjunvxZmmkMq6VDSKa2QKykbTO8NtLlMkDY644kibRDOkkgrSRn3rNCydGmJ78pby+hR3bRUHp0pW+ARF+ml81YNw6xib2EUvpe5NPEwkzBGQKj4cbQts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625945; c=relaxed/simple;
	bh=9Ceolq8AP3d8rH/OKiM6PhtgJcoQeJ+MKq9cjBGth50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKnKBRY0rI89I9JQVUQtXIqzSsZMlRH11O8+Trv2b1AFtSlRykwwbQSGiZvnamOqVWRiAqDuCq3YOfuEOO6IGMzwXJFER/FiAmaRsSHin6+9GwDOddabXaThxXYZvq+z5FdZ1bO5rvzhsbzlXZlAMy3OIjojkAvkvgwrt8piSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=K+H4ziB4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1752625941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwCugn5u90+WMfoMR0l5YYNJvPYfNo3/q201uj5ReAo=;
	b=K+H4ziB40n6bvov2bO0iVxqrrnil9DqppbuYfLogYQyMvO+UXn7Poe9GeINK/UCzOj+Bix
	N8yJbZKli53ywgXo3TA3xybljEnnj5IUqVP16H8Y3b8UfcxoAVBrURI1A6HtDebGgwzBmT
	Jm/cA+UrJUzT+LQ8Fq19WbDKuPEVKoxAFkd+A0CVVM0erR4vFh0YjPjeIMoCOJTz77EFiZ
	Qo4cX/AlpuJVBPf4sVE23ZPEHBP5OVNklPmWY93I7fjRzWn95uFLwmLR2olcF22X3SOydV
	sjxEsjIHp7uX1EyyBtcLUHG/S4MZwCZWEpmvKC8olhk9vj3vtZ0kcmVK4FRzAg==
From: Val Packett <val@packett.cool>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Val Packett <val@packett.cool>,
	Laurentiu Tudor <laurentiu.tudor1@dell.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] firmware: qcom: scm: Allow QSEECOM on Dell Inspiron 7441 / Latitude 7455
Date: Tue, 15 Jul 2025 21:27:00 -0300
Message-ID: <20250716003139.18543-5-val@packett.cool>
In-Reply-To: <20250716003139.18543-1-val@packett.cool>
References: <20250716003139.18543-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow these machines to access efivars through qseecom/uefisecapp.

Signed-off-by: Val Packett <val@packett.cool>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor1@dell.com>
---
 drivers/firmware/qcom/qcom_scm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index f63b716be5b0..b001208fefe0 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1988,6 +1988,8 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "asus,vivobook-s15" },
 	{ .compatible = "asus,zenbook-a14-ux3407qa" },
 	{ .compatible = "asus,zenbook-a14-ux3407ra" },
+	{ .compatible = "dell,inspiron-14-plus-7441" },
+	{ .compatible = "dell,latitude-7455" },
 	{ .compatible = "dell,xps13-9345" },
 	{ .compatible = "hp,elitebook-ultra-g1q" },
 	{ .compatible = "hp,omnibook-x14" },
-- 
2.49.0


