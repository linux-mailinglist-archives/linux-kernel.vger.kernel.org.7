Return-Path: <linux-kernel+bounces-771638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7198CB289D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 440BE7B59BA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD0EA95E;
	Sat, 16 Aug 2025 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN0TS77d"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70E29A2
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310669; cv=none; b=VcOfz8G4a60h8wYAwIMDXNjiKujlZxLc1pylO2gV6aYrHgTD2J4YX4DazJ9mlc0BJf6ACYy0684tkKAWU6N41NoZt9RRs1Dl/OxtW1TddVD+ZVVhk+PTV3SlpUSiN7Xmr53OQm0d9vuLFscZrkmA33NdVvi1Gi8TP921ZLZTIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310669; c=relaxed/simple;
	bh=+KcSW99rt+iWwEOI3NOtFYXtxLsr7J56p8F6iIJmTu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kyh9a3DAXCYH3wO9g2VpuWLx0ifs/aA1z18+PsVFEdLfvFl1eTMie3d3bFzhFsM6Gd7atQkAgHhUsQ1ARV5XA5nmsEL0x4HlpkgzxeNwOsQRfZv9cyKn6VRjDZOkt/h7k8Bz+Wdiec7eEvdcbfBnb1PI1rnF322XoevhjMeYnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN0TS77d; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e05b3eso1889391a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755310667; x=1755915467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kKpt/Zc97YCHeFvIlASYUissiWoPM8SRE5cGjcfnvA=;
        b=mN0TS77dxaPhVY8IpOveRCyHX34NiCpfr0TdcqqluTHpJwvpc/vXFMR/foVVe9NS5V
         1TjLjAthoRedow7h/D911kteoe2EwkGqyygbWomXl8rVq3UuUoRstHUOGHRi2u4Gj6YU
         CdLVmm+XYcugOaFNhtWi1Or5O+Ri0dvAvp/IN1abzKh7RqRAyQmypfAnxtjWLOt5Eu0X
         XgUVqiQmWrA9FXMS3WOPMAilt4rqBJUk+cmyqANuL6WrdXhxzuMbG1Ti2eO1xOfIxAQr
         fFF7XuWmlNEqTi3zapRCsFGEQWtNscklMabSaYMB4kfmvftFe56I7dwfj8TyReEFRKL9
         fxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310667; x=1755915467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kKpt/Zc97YCHeFvIlASYUissiWoPM8SRE5cGjcfnvA=;
        b=lwVuXQqMMDY7AP6OrpZrHfMR2rkG4Ss6pIgABshlszh96QAFj8BFP8eFo/ZYWxwwS1
         fbfZsTE88TmFNkFyTDFPf4bGlQpDb0MVzEJqxtcVnk5nXLmMTjH/9n5n4oDdthgkw3N1
         hMlOZ+dUksCZ8+AAGe33NvYIp3Axgn2794OTZolSJSHwTM7u3PD9r2/hk+q0ue1vewkJ
         QZoM07BaBXUDDsTULjZWg64zGWGVnLqtXT25kPyGC1WOuA+vU8pKDLdEfY9xgUp79SLd
         zdvBm7FkpbmTRbAShjqwmf/FzXiyKVUMOttmr7RLbQZAB5LMH2boQ1a4XcjEt1/hqiIR
         ypJA==
X-Gm-Message-State: AOJu0YxV48HuiR2vC9WvuuE8RDe1RYfjpyzlhL4ze98tiMyqCxb02cWX
	cz2VyhFlWF/bqyAd/vIC++FohDNMKPRN1pdb4K2ZGqepqoZHDSir9L79
X-Gm-Gg: ASbGncuHXy/qLrD2tbXAOPuaLvcPk9loMW8dUivRpADqjkGaTiruH1Vtw5O/HslKV7R
	S516HuJzpURnv6ekB/w+UDy+aAoIKTDV8U57hEekuAxjH+byEufbV7z+rmhYR1yEaliLfRFWKQX
	534jiZH1j5vasDjHA33/J+b/puQvvLvAw4kvVD+BmjI+s0ouEFTfXUIAsaqh2Evesia/mXwxEK/
	Bu9Pd7ydcEuE8kMZ+YIUA7BLXyyQ44weBbnetx+v50T6bFU+DKiXELWCfgoUOg5yqjsNzbF17QQ
	Ioax/6f8uU2s50jseSAQDA0fqucaLUMFqtMGCqh2F9bGQUY4lYiGHkw+/hL8rp8+hpxaJZ8oXZG
	PUA==
X-Google-Smtp-Source: AGHT+IGYavUVz7TBnV5Qy8DDGZCct+5yb6eIPLpxnyoKRPzvpEt+3kUKxuScGX6ul6hC54CgGYzfPg==
X-Received: by 2002:a17:90a:d44d:b0:321:c9e7:d9ef with SMTP id 98e67ed59e1d1-32341ee9181mr5852280a91.21.1755310667036;
        Fri, 15 Aug 2025 19:17:47 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::666])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7735f4sm2419656a12.48.2025.08.15.19.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:17:46 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	Collin Funk <collin.funk1@gmail.com>
Subject: [PATCH] ver_linux: Reference coreutils instead of sh-utils.
Date: Fri, 15 Aug 2025 19:17:19 -0700
Message-ID: <9ecf7c579454d89c73b8d2c29d13ddb1768079da.1755310602.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Fileutils, Shellutils, and Textutils packages were combined to
create GNU Coreutils which had its first major release in 2003 [1]. It
is unlikely that someone is using Shellutils today, and likely that many
do not remember what the Shellutils package is.

[1] https://www.gnu.org/software/shellutils/

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 scripts/ver_linux | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index d6f2362d3792..222e01eb9697 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -45,7 +45,7 @@ BEGIN {
 	printversion("Net-tools", version("ifconfig --version"))
 	printversion("Kbd", version("loadkeys -V"))
 	printversion("Console-tools", version("loadkeys -V"))
-	printversion("Sh-utils", version("expr --v"))
+	printversion("Coreutils", version("expr --v"))
 	printversion("Udev", version("udevadm --version"))
 	printversion("Wireless-tools", version("iwconfig --version"))
 
-- 
2.50.1


