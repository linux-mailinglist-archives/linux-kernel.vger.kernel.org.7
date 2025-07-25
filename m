Return-Path: <linux-kernel+bounces-745363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5762CB118EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470C53B501D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED607291C22;
	Fri, 25 Jul 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YX9Zi6HY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GRGUZbp+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F428937A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427528; cv=none; b=GCD0jKNP5KZ/1NYZ9v0bYEZKfPQlqDHNWU/cRekH8dfN7XaLblR4kXQq//+Ep2w9HV+G91v1apM5EqVs9ez3niH/XeCyQHAQXOqRMPfiU7KE+mLMMpO1emZvY2uaVp051oibMaaqzbojN23MALhAujbxuWhG30x59Ve3WPs23pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427528; c=relaxed/simple;
	bh=bfgwlYwhF4fURyXyEtLFP24QwOY4bQ2ieZHH0QdTHPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dN9m92/nNu/WXQspRe8zMdYbjc6g203Oiop5uwvEikAeDFTXMD+UHBpjy6wSrN1gnB21n/+xjc49l+ileVEPGRqDcGtc0Nzny+jcSwwf1FBV8lgkdOO4W31jrIj8C/8TeNQ0IecsYPx/t8LZzKWxwAC5Mx0fQ6W/NkmKvZttIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YX9Zi6HY; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GRGUZbp+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753427526; x=1784963526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xvFMByaEOz99iBJ7NSHYWQOqz3P4t9DDrFX2j8+C6hA=;
  b=YX9Zi6HYCFYMv3ZaBye3p2LwHVBSvf0ff70yDqp0Xsr7qJTmJLPnxhBs
   secsu1OQBE/N6PjzQ5IF8jbvyCq5WaGmH4UidQlXmneaPhToIN+ae+dNp
   DVaF8YAf1wrgXfqBO9nsc7c4E5jiAMJMyJWEVsTgamQaSxLGjhD6yIp7c
   njplzCzPMIRFqv11LOujksdFkTV3d3c9c1d68a6A9i/sC9hU6iSGcwPMU
   072htYnZqsz0bqSpnd819k5y18bpopLPJuX1h2rtTk+cpPIzaKkpBtJGs
   Vi6D0Mb6gCAYFyKs/mu4iTAPwCqza4KELtA+ufG5/6d2lryroUm8hvuql
   Q==;
X-CSE-ConnectionGUID: bv4wrw58TomqhpSLsYv+Rg==
X-CSE-MsgGUID: mi2/nxJnQXO7TUmO26w0Jw==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45414799"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 09:12:00 +0200
X-CheckPoint: {68832E40-2D-8CC3CD70-C1DBF452}
X-MAIL-CPID: EC45E6D563B909B0A7AC09FCAAE3848B_1
X-Control-Analysis: str=0001.0A002116.68832E72.002D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69C25164BC2;
	Fri, 25 Jul 2025 09:11:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753427516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xvFMByaEOz99iBJ7NSHYWQOqz3P4t9DDrFX2j8+C6hA=;
	b=GRGUZbp+a3LTjQwnJbRRa/pseIjyLhgxfEw3blzWJ0HjxzsDf7rFtCvZX+FbWLjjD/dS99
	7PqxlbAcYSGGpi/E/GeCOiqWJAlgLrWPckiBuE15pKScyQEG4rowg2MMmMEMbFwoxP2wVf
	ns4ey/Sx7KaYdueqXmlF1PTKXZASGVyGdU3XChW5LlReB3b7JWoqp7bF519JVOsyU1fNov
	E4kN16bEYYW/9lHaYas17pcOqUYHnfmU/6i5uHLh/DZh4YC6nYm913IZqp5g/ICcLDGNnu
	/nOhRhXkmC46sOPYpb5w3YvgUL5XxBA8lnoHFhGLKU/tVcLRQQMkGyd/83oZ2A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] stmpe module support
Date: Fri, 25 Jul 2025 09:11:48 +0200
Message-ID: <20250725071153.338912-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi there,

this series adds support for building stmpe mfd driver as a module along with
the bus driver for i2c and spi. This depends on the cleanup series [1]
just for avoiding conflicts.
I'm not sure in which order module support should be added, maybe even all at
once. Please advice if necessary.

Best regards,
Alexander

[1] https://lore.kernel.org/all/20250725070752.338376-1-alexander.stein@ew.tq-group.com/

Alexander Stein (3):
  mfd: stmpe-spi: Add missing MODULE_LICENSE
  mfd: stmpe-i2c: Add missing MODULE_LICENSE
  mfd: stmpe: Allow building as module

 drivers/mfd/Kconfig     | 10 +++++-----
 drivers/mfd/stmpe-i2c.c |  1 +
 drivers/mfd/stmpe-spi.c |  1 +
 drivers/mfd/stmpe.c     |  6 ++++++
 4 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.43.0


