Return-Path: <linux-kernel+bounces-807035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78021B49F26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE70C7A1438
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA22566D3;
	Tue,  9 Sep 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTp3KKAa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E0253B59;
	Tue,  9 Sep 2025 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384564; cv=none; b=srhOXoGFskkaDxnPJ/ShCNCk64aHLkMycf/ExWLx6Gfx3HEGSw3pJOVkmvpDlalXX6J1JMFmBntV5Mg/61bjUdR1R1kNRbrc9WZTlDXmcf3dqJ3F79vt5gUF+PCbsOmbq9q7eaOec9b5bXalptJ6QiGeL/zYt8O27Eq5AZFFWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384564; c=relaxed/simple;
	bh=aE3MoR2tQr9P83NDIFS+on/nd9/NuFxzaUakeTNxCms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wjov2NXieTUWijqkYlQIN3C6CFP3o9L4Dp1qvCa77B/kKFYk4tKc2EEeI42bdNIL29nBdJG843jfif9JwHDVtpUlcBFJiMFT4t0AwNAoeEYM7WSP6EJlSXSFG/SeBfVzF36NTUAFVuEJR+RC8ogCbl1MoOlqRO04KlzW6ZWYgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTp3KKAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9519C4CEF1;
	Tue,  9 Sep 2025 02:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757384564;
	bh=aE3MoR2tQr9P83NDIFS+on/nd9/NuFxzaUakeTNxCms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTp3KKAa1bHkGzU+GjVolsTd6qVyUDIDYpgAmm9g0iKVAi7FC5+vMLcxjCivtCkaJ
	 9JfOBCyKVqFvKa5rdFWxeJGhvb3LYkE2spsimlwJFt/QUzhx7a1hcKMOVzn/9hnkzx
	 IKIbT/Saf2AN6UmhD9hLfgbUp1qxcmsLw1nlIWvtqpy27HzZBtPwGpvEseJWv6HRi/
	 adjJLYJq5JLCdfeaOa5FEDTp3+eEz8Rs0kZKNf+pHuc0SfHaPBv2hEqOfr+ZSxrHWF
	 s78MP+bVJlUUzqq9fOs8hyB3By5oE6nTDsBLTmo6PQRufcYu7D9XQCK48bS/M3JanY
	 oHuuzqJfqubxA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17-rc1" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] samples/damon/prcl: avoid starting DAMON before initialization
Date: Mon,  8 Sep 2025 19:22:37 -0700
Message-Id: <20250909022238.2989-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250909022238.2989-1-sj@kernel.org>
References: <20250909022238.2989-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2780505ec2b4 ("samples/damon/prcl: fix boot time enable crash")
is somehow incompletely applying the origin patch [1].  It is missing
the part that avoids starting DAMON before module initialization.
Probably a mistake during a merge has happened.  Fix it by applying the
missed part again.

[1] https://lore.kernel.org/20250706193207.39810-3-sj@kernel.org

Fixes: 2780505ec2b4 ("samples/damon/prcl: fix boot time enable crash")
Cc: <stable@vger.kernel.org> # 6.17-rc1
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 1b839c06a612..0226652f94d5 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -137,6 +137,9 @@ static int damon_sample_prcl_enable_store(
 	if (enabled == is_enabled)
 		return 0;
 
+	if (!init_called)
+		return 0;
+
 	if (enabled) {
 		err = damon_sample_prcl_start();
 		if (err)
-- 
2.39.5

