Return-Path: <linux-kernel+bounces-814355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD2CB552D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87471D621FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C5320CD8;
	Fri, 12 Sep 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfMx/0vs"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527C320A35
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689834; cv=none; b=cGAsb2YUhHjnPwPGljxUAl9hm9vFFDcjFtTkuZDuO5+xWKsj5sc6WchKzDWx9m4Luvq+NUx8gisuj+SbSYtFNe4Km/AVcQVL0B14DmCz2noadM0x80gN2OgthN3PCoVrQSae04BkIMkWu+sQT/kXyIe4MoqSlG/KGJxgPCAEAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689834; c=relaxed/simple;
	bh=k5/I3UYTWdnJjKzBx+/VZfwmc+jXcyZQNgYc3CqZv50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAZ6IwvPsokDncRSRa61qsMNVkgVRDjCriq7d8baqnRrdmVQ2n+f91MisDxn7iw+kelHD97f/duaEaJYZGMBCQBFjKa3GsMN1p9AlU6rbnHE5GgurSCYWsRbCu+uPjvR2E9eIdPqZtXKrxwITMaEnX/0nTRnom7a6HUWZWIBktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HfMx/0vs; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e96c48e7101so1629420276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689832; x=1758294632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1ubFmujdan3yUawwr3ZvZLjd/mUy6/pR3VRzzGBTTA=;
        b=HfMx/0vsbroSzJq953+Rkb0H9mHq9RI5B7qrFW1tGLb53uvBDW5BtguQARURlLnza9
         5N1YjSdgWvN8f/dqIDzl1GhsgZ0F8EE22Xh/hCTWIlVps2vCGSMMQi9ZdpaIzIsnUArW
         zIMaep99JpL829ErZkCMFjitM9/RwViNkXpdm1sMdVxotgIDHXYUDKouFDIbRJbBon3t
         MLEDeUwZwwznfow9A81XcDaK54+jRvzkrpDenbrH5qHPySSk64I/fcUpjvQ+Gq+ylNEH
         vNZPas2Od5OpRkSw9WWE6YGFp6RhTxZ5FgqeVv8wF+/tc+D+PoYUhx2Rzslb+rCnCqZH
         6jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689832; x=1758294632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1ubFmujdan3yUawwr3ZvZLjd/mUy6/pR3VRzzGBTTA=;
        b=RLEI4pu53AE8g4i97MYPIbCtsrmCFT2Q8gkJGLIQR7R15s66xRhty+TYme9eWZjN73
         EziIb+DRq/1KihAlJU+2Yuprk3rmW4V+VFkzBnior3qlGTilqIdREjkZN3CNp6nxxw0S
         c4bSSprcy8CStwJPiZT8MGNDtYeEuphw2NmOEikc1ULWtvNe7mgjpxJXvVwL3J4LdD7e
         OR/urIkeCi8k1YFH2FV5/ubATpVskzC2MJzEwMSFdwl7yETqij8sn7zdq+7APvs1nyTY
         Ftc4rr9u7z1AyJB3JHL8ibMhoTnqqLhSvkgReqtA93PU8UNlgi3p91F0qDXGh4gJZ4R7
         MvDA==
X-Forwarded-Encrypted: i=1; AJvYcCVc6I0bAztvS1sAid4dY26Xf36SEVFFfNvyU8gboFp6sUEyu3wvlHdcNsCeOeIuB2zkEs/7BLtT8uxFa2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8E5Gpiqy37zZZhXpBjXtDNCK9DDRifSwMomR+EidBFHaIract
	6MC8OHo0gDbvx2E/Zq5Q64jq+to0Gc8iKCMJrf+ybc+fCY5eaPKPqPgDMLYX1lTGYKE=
X-Gm-Gg: ASbGncvPi1BfK7b912+3UzckYAD5kGvTuzxL7CiC8h7iVyRWuOCdRPrBuHRbN7RDu9f
	gtQZH1h3SJJ/cMAkTJ+Tz00KaftVg7xER/4WRtj3HxF9euKocveiqdtf3OozvunIP5CAGLNMQz7
	ShTf6G9sixfdbCI4MZBWZp02WJOhfEWGzqhM7das7SRFxMo1V+gWwNsud++pMpATtnKNhal6Q3i
	UbwzapEcF0J849C+QDfcDGPX05Fh1Z3i1fwxIJSe1vhkl10RWOLdXyxul2RNNYSjPg29YHXVQ+0
	YaJD9U1L1mLGZVJ3YDLvfy0UY6ZbwOZzS8MuFS2bJ3sU9NaJ/3UN0fmvZygJq92mcAhoU5VJxcJ
	6qSNer55uFDERQ5pE74ZU1w20QgLYBUDrL/exgs8NRix4
X-Google-Smtp-Source: AGHT+IGQPX6y0JKi888sfyXxAah3q3fQIwu7cpMyf9JJWf5Y6/yYrim06D3kAGSOfpN7Gh01tRPdkA==
X-Received: by 2002:a05:690c:c08:b0:72a:2d15:a2a2 with SMTP id 00721157ae682-730627c9015mr33553397b3.11.1757689831515;
        Fri, 12 Sep 2025 08:10:31 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:31 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 08/16] init/version: Add banner_len to save banner length
Date: Fri, 12 Sep 2025 18:08:47 +0300
Message-ID: <20250912150855.2901211-9-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add banner_len to store banner length.
This is useful to save the banner into dumping mechanisms.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 include/linux/printk.h   | 1 +
 init/version-timestamp.c | 1 +
 init/version.c           | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 45c663124c9b..5bc617222948 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -12,6 +12,7 @@
 struct console;
 
 extern const char linux_banner[];
+extern const int banner_len;
 extern const char linux_proc_banner[];
 
 extern int oops_in_progress;	/* If set, an oops, panic(), BUG() or die() is in progress */
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index 043cbf80a766..1fdd795be747 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -28,3 +28,4 @@ struct uts_namespace init_uts_ns = {
 const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+const int banner_len = sizeof(linux_banner);
diff --git a/init/version.c b/init/version.c
index 94c96f6fbfe6..68d16748b081 100644
--- a/init/version.c
+++ b/init/version.c
@@ -48,6 +48,7 @@ BUILD_LTO_INFO;
 
 struct uts_namespace init_uts_ns __weak;
 const char linux_banner[] __weak;
+const int banner_len __weak;
 
 #include "version-timestamp.c"
 
-- 
2.43.0


