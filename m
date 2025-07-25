Return-Path: <linux-kernel+bounces-745359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B44B118E0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F281CE0AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B114291C05;
	Fri, 25 Jul 2025 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pyWN5nQl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ie9ng9ns"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521C1F1311
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427288; cv=none; b=ITKppE5bEblFvGGINsbUXOxAzVUO4ykyFApq1RvcURiJ1Z7e64V4NhZc6x+DxbjEeaPjQixTamOc9B3FNe+hvW9ArhAWS2+c+bTl/tw2eI7FgqUL4b2CbIohahFAHkHsOGz35inoW0NNLVpbLWWYvLn36mrImlR2dxbiykPhfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427288; c=relaxed/simple;
	bh=EUCEmS/1UYnaUVDKCEGqLoMC2eBtEy5ChTkh/pubwlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqrOdg+yY9B24YBMwQz/vf6tAz90YN3tizupbfq9s7EhZT5AvZA1N7pba2g1oXvWwB1F+ihSAUw9IElQyhvdtjhOU652v9LF0yqijY0clKWKwOvqZGMhfAEmC+ZZRqfbJq6Q8GLGBc9kVfXJ0sx3T9Cl7wxep1A0oCVhfQfZwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pyWN5nQl; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ie9ng9ns reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753427285; x=1784963285;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uh1MZsai+1QlLMsnGqqtZ6xsZZILDM6L6Dcdbc1nr8M=;
  b=pyWN5nQlh1Uy2gurTjQtUzYqNH0aEIZ/Ji1aQXnLVxmXiF9mPLp0io4+
   bN6MyHgQGXLw7f6p2wQPEoKaivOCp1HtaIvKZC0T9YaxDGDRCkaK3SS4d
   pm9WzifBW8PSY4ma++ttXSkF3nG7LmZFIEu0i6EOlJEluiII1lfdI9X8k
   JWQmVlWEtqBznlnZR7Hp/f29GJu86iLYbeKi150GLuQ7G3BtJHGzEbNqr
   1FqZ7B37Oy+9dw4/hDdna3IcLt8D/Dg/WVF1RHDdMC/uHQF+mNYvujt6H
   K0HQ6ltNcGM+hb9piqU0VUBfxCTMEBTP7rI+mT4TD0wG8LdCiqQz+DAhI
   w==;
X-CSE-ConnectionGUID: pTxjeaYCTjqymR65UahxpQ==
X-CSE-MsgGUID: yGEwm0Q0QTu0I1hikHzCSA==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45414666"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 09:08:00 +0200
X-CheckPoint: {68832D50-7-943DFC15-D71A48EE}
X-MAIL-CPID: 0E5749B5E1E6CD6317F31CC94F75ADF3_5
X-Control-Analysis: str=0001.0A002103.68832D70.003C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D106C164BC2;
	Fri, 25 Jul 2025 09:07:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753427276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uh1MZsai+1QlLMsnGqqtZ6xsZZILDM6L6Dcdbc1nr8M=;
	b=ie9ng9nsm5xHyEGnzo8Ek6IVDFTxaYyS1NHVI2f4YZQEHwwQ7ZEh0NnX6Pye5k/7Zy00Gr
	iI/W0lyjEgiEt1hXqW11CULqiZYCm/G9+szNBzPwj6kha8dMUshtp7pxrnA0YGXc0uGBy4
	5DNSRSifq+cl4ixhjX4+SQnoSWzyg+fD/0Owmm5AlAB3azTcW/yes2mj0DBP4VtvRBqe5p
	8fsG/HvrKdHUrOZL66RRUK0W5TUmmOTtUNV1PQE7QgXl2G65zGcNgbOtiBXczZQaFFVfsy
	Hm+p5luodaRrLh2womSCWm3n8Q4x9dBZg08JJ/fMYKi+28XMslVcRCvScgb5Ww==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mfd: stmpe: Remove IRQ domain upon removal
Date: Fri, 25 Jul 2025 09:07:48 +0200
Message-ID: <20250725070752.338376-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The IRQ domain is (optionally) added during stmpe_probe, but never removed.
Add the call to stmpe_remove.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mfd/stmpe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 819d19dc9b4a9..e1165f63aedae 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1485,6 +1485,9 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 
 void stmpe_remove(struct stmpe *stmpe)
 {
+	if (stmpe->domain)
+		irq_domain_remove(stmpe->domain);
+
 	if (!IS_ERR(stmpe->vio) && regulator_is_enabled(stmpe->vio))
 		regulator_disable(stmpe->vio);
 	if (!IS_ERR(stmpe->vcc) && regulator_is_enabled(stmpe->vcc))
-- 
2.43.0


