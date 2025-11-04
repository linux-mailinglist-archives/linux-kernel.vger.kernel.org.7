Return-Path: <linux-kernel+bounces-884541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DD8C3062A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5D044F5551
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB8314A8A;
	Tue,  4 Nov 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Efw+OwsJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49028BAAC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250225; cv=none; b=scUPy8XNJm4NuTxPFsg6jd6DPI99MAfn/go3FG9jBgixv68KqA/bRElsvjRljLdcgSlw1Nlgr95D8y+9+ignCfrxZ08CusOb1ogR67aHC0FbDGEpr2BawEXIhXZsIa+t8mfcKza+25I34qbCaCD7w+tUpfjZvwcn4YEHSsrDS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250225; c=relaxed/simple;
	bh=YXgMCxTuO2ciz0Sru322MFOCfmYaPI0BXBaclGFVV9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kEkHB5D8LINi/Ul0Oa8JQ6Z5mLmDPIrd2dqibImKc3nucErM7niDTUdXK46+3wZgCBPA97rw+iMG8PMMIqOKH+Phm4J4rf3aTryYAJjjiaelIuSQ+myTBHzNd3V8s1iGQWGDLr0y2Zw0VO6nxKEGP/cobL+ZdSCmqMswAN4aNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Efw+OwsJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2952048eb88so56397445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762250222; x=1762855022; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=firJhlNAxZ4Bo36QY+xlGNWblVJVC08hGepLC0vNhN4=;
        b=Efw+OwsJsmo19JWnqn2HEBW7aPcDes1n/LBc3iDOtkS07ChcCEs+VNpFHJEqdxdiJJ
         AHSEL/C0b6BJ80QauVD/HgnMTVrCeeVze8GpzVWvVHXPYcS158ZUYzk4ue1rr4bYTCIV
         mfmNRVdQtokmwueQo2UjFI0iZa9Qqi1NqFRNXHMEosn/OJXcjpJ/TQJvLrHvqqMMIchi
         L6mfVqB/Fj4vDjI0qvUdrMj7cadGb25PMSRLGa35XPijHo06p3WyP55wxsLLSFrUG/1v
         5hYLp9lmfIsqanjJLxqdOY8PUjeoJvN/S/GXFuLz0sV1kyJriE4+ptUYb0NABIyhhWIC
         3NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250222; x=1762855022;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=firJhlNAxZ4Bo36QY+xlGNWblVJVC08hGepLC0vNhN4=;
        b=H0dEdfzpuKN1r1ASOmbAQN6dyJIdxfJv1wcWgFlyaLOOeh3BkPjLQoisSfgm628UJx
         Sql1hCRbZVZkaLlWoXLQYETpCyeusjeNnhYK5caUSB4hZYgxYKpys4ubp/qJviDO7Cjt
         +dDbhEJILFaqMh9sg/dPnr3hk9TnqQ+KbsNGAJMNb9sEPeC8WlkTIVgDNuvWeyJZpMtq
         qpMEr22OgYDkC3OYXa7RnzrneweXayjE+tT+70/r7EouTO1PeIyVY7SrDe8TK5u7DQX3
         JTwhbAYnWlFjo4SVe2bUj4lZMi5jGF6SyOtKd1Z/26MRP1ifyUvNwKrxFpGs1lfrTcLf
         L9pw==
X-Forwarded-Encrypted: i=1; AJvYcCWJd8iFwXSZQeLZe54ZzBw4lacx4Oy1W3vfCuFsTWniWTnHckLmg6QIVwPjpEpPHW4+Gi9eICDgsRHndIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgXV87Y36MUlublef2evNLU0MA4LTdKLdUC6pMLECgWBOR+76L
	6WzetPN2x1s5pYYaao11tVWQa4cEEA8njvhY6sZ0pfL+tn2Vz0vqquwFbYusd/HC
X-Gm-Gg: ASbGnctK0HJhJw8rwMpPw0X/6S2xqRvHSrjAKf+AflC/vV8AhejtRa8sPYh+Z4gAIPc
	0ZfkHqH33rNuUZHs50sTseaIDHDMwPhlIvl7APJE0Z5aeSpw06v4fuGz0zvTrVTIbBEtEthymmf
	Gq6Act9hu3sPfqXQL08U6NUBFOcZKnfvnXQk2z6zqGatQ/r1+QIL3gCDsd8OYydIL8c/Buzw2KP
	gvGniGgjnZixCZw+VJ2PNIPgRyvVwV0AV85xyDVxA0VPr+PqWlTGqghQzjVCKmwTR/Is4FpA9Yu
	qAzfdot+FaX+shpNGuw+V1jUoQxrVBvTzybrFUL1ecTlRo7dj1PqkCdECayreNFOQAPKLP9myKj
	KZdPkOJtsOrYRcwYEarLbkeRgGfGxwPS9L1/9wy0W4+cWXIQW9ZkH2PCrFgksumhgi6KmnqnBAR
	P+
X-Google-Smtp-Source: AGHT+IFTc11NZSugLNGRdVCpbxSiHXxcaih8Y6Z/ZMsSEsoPYqNZNA/fO4ac+K7zvIFEYqXkq3oyqw==
X-Received: by 2002:a17:902:ce01:b0:295:6c9d:1905 with SMTP id d9443c01a7336-2956c9d1b4dmr130031905ad.18.1762250221916;
        Tue, 04 Nov 2025 01:57:01 -0800 (PST)
Received: from aheev.home ([2401:4900:88f5:503e:7f32:6f1c:2f94:2a7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019982e3sm20396955ad.28.2025.11.04.01.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:57:01 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Tue, 04 Nov 2025 15:26:51 +0530
Subject: [PATCH RESEND v3] checkpatch: add uninitialized pointer with
 __free attribute check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-aheev-checkpatch-uninitialized-free-v3-1-d94ccef4917a@gmail.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 David Hunter <david.hunter.linux@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3327; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=YXgMCxTuO2ciz0Sru322MFOCfmYaPI0BXBaclGFVV9A=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDI5zz7bnhLZMLn8zY1dt2/7LjkhVt+967RH2OfvUxwal
 N4k3lgr2VHKwiDGxSArpsjCKCrlp7dJakLc4aRvMHNYmUCGMHBxCsBECkIZfrOf72ZefTnPy3e6
 +Srvr8sfrzqrVx92s+d458M+eSNz37WMDDdnlxVk8S7rXaUVvDvnhtCnhsRNrg7XfZbKzC3z3X1
 gAx8A
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

uninitialized pointers with __free attribute can cause undefined
behaviour as the memory allocated to the pointer is freed
automatically when the pointer goes out of scope.
add check in checkpatch to detect such issues

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Testing:
ran checkpatch.pl before and after the change on
crypto/asymmetric_keys/x509_public_key.c, which has
both initialized with NULL and uninitialized pointers
---
Changes in v3:
- remove $FreeAttribute
- Link to v2: https://lore.kernel.org/r/20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com

Changes in v2:
- change cover letter and title to reflect new changes
- fix regex to handle multiple declarations in a single line case
- convert WARN to ERROR for uninitialized pointers
- add a new WARN for pointers initialized with NULL
- NOTE: tried handling multiple declarations on a single line by splitting
        them and matching the parts with regex, but, it turned out to be
	complex and overkill. Moreover, multi-line declarations pose a threat
- Link to v1: https://lore.kernel.org/r/20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com
---
 Documentation/dev-tools/checkpatch.rst | 5 +++++
 scripts/checkpatch.pl                  | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d5c47e560324fb2399a5b1bc99c891ed1de10535..1a304bf38bcd27e50bbb7cd4383b07ac54d20b0a 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1009,6 +1009,11 @@ Functions and Variables
 
       return bar;
 
+  **UNINITIALIZED_PTR_WITH_FREE**
+    Pointers with __free attribute should be initialized. Not doing so
+    may lead to undefined behavior as the memory allocated (garbage,
+    in case not initialized) to the pointer is freed automatically
+    when the pointer goes out of scope.
 
 Permissions
 -----------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..e697d81d71c0b3628f7b59807e8bc40d582621bb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7721,6 +7721,12 @@ sub process {
 				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
 			}
 		}
+
+# check for uninitialized pointers with __free attribute
+		while ($line =~ /\*\s*($Ident)\s+__free\s*\(\s*$Ident\s*\)\s*[,;]/g) {
+			ERROR("UNINITIALIZED_PTR_WITH_FREE",
+			      "pointer '$1' with __free attribute should be initialized\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on

---
base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
change-id: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1

Best regards,
-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQBFRpOLrIakF7DYvaWPaLUP9d7HAUCaPyCqQAKCRCWPaLUP9d7
HMY1AP93A0fWIkV06Vcd8EHJy3w2G8hoinjDBpy5dZIXMMQFJgEA945Vs2tysbbR
qVNPU2EM8cnDwRabEkET597he3AbpgM=
=PL1b
-----END PGP SIGNATURE-----
-- 
Ally Heev <allyheev@gmail.com>


