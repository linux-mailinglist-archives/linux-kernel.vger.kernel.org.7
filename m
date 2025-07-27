Return-Path: <linux-kernel+bounces-746953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CDEB12D97
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB60617E394
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E615215ECCC;
	Sun, 27 Jul 2025 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpuXvPEc"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4218E20
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583446; cv=none; b=pgwN53kkHLQefvkuTBQIPk7D1BvVcRuP8cFvvwySkpN8gQn67N6rBFSu7epbc5tJT8if0CZFl/1LqWFmX2ZHHmRTq5Q/zazEdlozyQN93UkpjACJN9+JBpsd/ZXO30A6IkPrx3kveWFL0uuD8OrwcwRa8T00OvbenzbGfHdJCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583446; c=relaxed/simple;
	bh=TaTiM4oJc4EkuszPYaFE5DIZ3m1dHAGq7N7OI3OBU/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BW4DOn++Wuas319+KLx/hSaUiPMLQVPcIrvvMgysIfrrFVDkCltIB/gjrer7QPbtQuhT2wrwjXWvEuk7h9yqrMjVqkftu4HxeJ2WS143PLvg7Q6kdFneTdMrXPLqbUQhyrD25P/NkdcXtBGwVfx1mMYLyHmUK9WQfesQXHd5OdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpuXvPEc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-75bd436d970so2093455b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583443; x=1754188243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tu2NCPbH5Tvy0vbFXDnIFjFIIOmPR0+HYZ1fcD534r8=;
        b=kpuXvPEcdqCaUYDE3ykyx9LawIRXZ4v2hlhOtME2ZLrhzThADC1CVxluNdK17XHVj/
         Ebv8WBd/ujnV/8KSdbQCN9dyNDoqTjmyyxLVFIFRlhj1t7etbOLHBkClx02OIC5iqnTw
         7ngcBeMF1VB+bbNB86ocCKMH/KDj76EX0LL02/Z2xF147Pfag2XmdNmHyl1qMFwwV/eT
         4KIH7d3Ywez1oxVGZ+bzanEPmAhXWgaJlBNa+/fyqQiJJq/6QwdmOumlSApORBY8/yT5
         48VtyDHrV9clN0nrXssDA9zd1cjDbYZQf+lNnF9WlyU/asEM9+n7Qt6PLvAKMiJTEn13
         0Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583443; x=1754188243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tu2NCPbH5Tvy0vbFXDnIFjFIIOmPR0+HYZ1fcD534r8=;
        b=fMN8pfraPGFCOm2jNVhYmSNErG+RGk7bcjL6ZOGbyq0qb65cfFcZzpEFrUhgmfj6wk
         hpxrP6OsV4oV3/x3lTUO5lpY8HrGhlUopqJQawjH6hQWP9Bl+3PMuB4YfAxM9SxudiUG
         1Xrrsh7aEGJLa8nEq0hgTgKHiGBbqBe43r1Bw3UR8UoIxekW/iWJuTWJbrUeZOUtbis2
         YcxHZpEC7iBlWoNbyxn0GUOZn3yIJD2z4obpLLutIuXtbceTpDFFYEfKY4AiCDTC+pj/
         qG5TL2L62yr98K2g4xhGAfwivr7fYfWBtekYrraP6hGDyZfuUSe23oi0+a/YA8u9AXiv
         +3jw==
X-Gm-Message-State: AOJu0YzPeHppkKs9dWVqtxOmbt20xJ0ExdbOKO3kLfZ2BDhlZsyIUOsM
	olxwN1wqq6rTTHYfD/izi03g9eVH5vbk9C0hrOhUjwLPlqHsxcdgZ49aIZMCVzno
X-Gm-Gg: ASbGncuV6npZjqNONZDWR5Qvn1hDWoEX3npYtWzlXHUJcfwa2tHc8UjAGaXeltsW9mV
	lupiwGxwCc7oRugFF987pzlVnjdCgNKy7mVEZhtgIBeu6DJW7YDbIlAnFUHzF8JQTcpu/zi1jLa
	cm6kx4Z8AWgRf/1dqMV13SVk1mmC20UAgwXCuhkwuxlcivVfi+gHOuFJeiU5XDPDeCDnZb11i5G
	HxUhshacurHPeTYWFCkNSQXdGUczVpmlpv6wvK97crN1bRkFXVMSTjPn/z/RuErxi0KhNdr9x42
	XnQsFY8b5vWQ1cBHqdxNkZXrFou9Qh9INTrno1m+jqyZzZJ6+frIL936fq1QAkZgOsLzB/oW5Sn
	QevNt96xJ/begdyLgifPE7Q0gv4NnqhyQRkDYxQyHO0XKYWWyMwaLVqF2
X-Google-Smtp-Source: AGHT+IHE+SnrpxropfBlZ9cvMUhBmVIaf+GiGNLT5mGe/sAVOF+SAgtEHCxTrjMFtm1UubyaGKP2qA==
X-Received: by 2002:a05:6a20:7488:b0:215:eafc:abd9 with SMTP id adf61e73a8af0-23d700e9754mr12725552637.14.1753583442880;
        Sat, 26 Jul 2025 19:30:42 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe33f3b8sm25864095ad.72.2025.07.26.19.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:30:42 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/gpu/drm: Fix typo 'concurent' -> 'concurrent'
Date: Sat, 26 Jul 2025 22:30:47 -0400
Message-ID: <20250727023047.82354-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/gpu/drm/imx/dcss/dcss-ctxld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-ctxld.c b/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
index e41d5c2a3..8a4375af6 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
@@ -82,7 +82,7 @@ struct dcss_ctxld {
 	bool in_use;
 	bool armed;
 
-	spinlock_t lock; /* protects concurent access to private data */
+	spinlock_t lock; /* protects concurrent access to private data */
 };
 
 static irqreturn_t dcss_ctxld_irq_handler(int irq, void *data)
-- 
2.50.1


