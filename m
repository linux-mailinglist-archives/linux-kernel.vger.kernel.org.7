Return-Path: <linux-kernel+bounces-870239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE9BC0A40F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FE63AFB99
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 07:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02728271456;
	Sun, 26 Oct 2025 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N09uaRca"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6FD2580E1
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761463576; cv=none; b=sozcIDk9W3uBwy0+O5R8QDb7+yT3lK4QAVPa/OA37NIeWXQw/JFTnPOIZnkEcqqRoNDRL3qaT2hChxijFRThdkgfspiOhOrEDRp8szMc5TOoM39FPZw/UweBzvhjXptWTgOmuyH3Q1Gpj4mty5PDX33ATsWX7h2OqkiHr4Axl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761463576; c=relaxed/simple;
	bh=Wsp8cxVy22klAhiDGv9P8tZ3IPZ7LUZzLpg3S21IfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKl5MpmNoJH+XGx+Am5TUyRsL0Law4vs8T7L/L1qnICpCa2yJ/MuyHxLWAZyC3b3Cd48NwtwObJ/nuaPU9gcxdszDDbJTj7D9xcT42PNykJ9CLip1DLe3t2Xexzv0zDGI4rRWYoJlIrz33FZJsTTIT7457X+96x6Vl+QegjFhgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N09uaRca; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso3339025a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 00:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761463571; x=1762068371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdMa6HWGVI8flyxHcsiTS5cMCkPtytHGgTVFhKdr0DY=;
        b=N09uaRcauINW+Qrk0LiGLJ1eBJ/aA8Zbltog3vai8RA5VpFjQv4QT+5skFfGNBNk4e
         1UoW4uzC21LoYB30lznALNevGBgD+X4npyUyXysENnfGi9sks7VWOHQ+n3uogHR8kDkm
         YgGnWTRlWSn9jBULLV2Zk/P7bE77WsdnNqV/NIkmcxAc6OomkjItaDJ1VcJAJViQwLLM
         YqDnkXIHGTN7hUYGv6iSyX/K7/ELUdu1e3+vhR+HZBTVyaD1TAZVLBP9hubZnGP2PyqJ
         mi2HcL/CAszieu39xTUUP683OjgXcNbyv2zZIs8trVbKdT4DSECbBVg5g4jdfIlOi6i6
         MfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761463571; x=1762068371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdMa6HWGVI8flyxHcsiTS5cMCkPtytHGgTVFhKdr0DY=;
        b=arVuJSMFZ6NPEK/YFNW8eiL+aDT9mcxQCGq1eL1yvpYLOe22MQ9r4XSXCXkKlkK91N
         VHeIA7SQEdc+/5ERYCnfJE7BvZfbHcu0vt62AgssbSme7ArnKuXaatmjCQoK52+V0EcD
         i8/+XkqkwMwBfIWUOIniOY/UyqXZIURV22i+6uJQvyOCVPGYypCol1eNt0ll2PO7Tjek
         5A0SB8bVNzRA6/OKogne2Xql32TCSrnXkZy/6UBZj8SGoK5mbl4c8Z91YVL4e/VWkHCj
         NXKiGwlpfRLtXzKdCewivUCVRPrRWPxAPapb4LB0wDlqu5bBHtrE31LDxiNPLvGwJeoE
         /OoA==
X-Forwarded-Encrypted: i=1; AJvYcCVzHuyK6oQ6pgUTqf6kyp/qUvPNz+pff0czgMgrftypuawuMM2/p4inLYH2WIEu/4wzZy3vuurV4+OnmMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZLsPyNq60IRolUOVviizpKE4vmvoFqkuILUtxghws5FgJWxX
	gyyYlpyAGcjKyrDVsRQk/ZQy1rVSz7e4tCltmPGKCB/gpAsSpc5Ym15Xym9f99Wn
X-Gm-Gg: ASbGncvB3GUrpwhjxuP7Afv97spXPUrgsTfXDTliOBcoE1eL+bipfAfrz2hR6v5YB+v
	J95j4NeQX371A4su/SpllTkU7VBP04k1XAcb/VSWECN+8atQMrqL3wGcZ18GWZookzfd7UCSRnx
	RS0rnhpAnKxEvWu8Hz0XS5GkajeZMtzzooSAltgt1CqqRbtubiIaln9tu+kvi/3wdSYbtAt6EJ4
	8wJYCNtF6BeDZ3YuwClg631667LQzorDEVk6qrQn3+zyWCzLndF6W0eoHLn7YJtJFzj6x3u0JWc
	4uYoXnvyGuiQZbPJB0cEQDKk0EnK6nwIVnzQpS2mO2Gulj5Mwb8MkJaLhBAPeqxiDucgwR2k70N
	EiqVRSxvb9LshYo6BlFlK+RSGkdKBMq47qkKbleNFBXKzGbNCr+VxWkIozWvsNRffwgD8FWm6T8
	1eGXeWW4eexzURfq+ITxmsyBgKGc/Z6RdKFmoB/xqK
X-Google-Smtp-Source: AGHT+IE5U6eGzQVnJuOp2Y8MluTWBLNlPfwZGE50frkHscCUegOKsjhIR8XeTV7M1ymJACtKk/unFg==
X-Received: by 2002:a17:903:2441:b0:271:479d:3de3 with SMTP id d9443c01a7336-290c9c93d94mr423076345ad.12.1761463571105;
        Sun, 26 Oct 2025 00:26:11 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2903csm42817175ad.63.2025.10.26.00.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 00:26:10 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: shuah@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH v2] selftests: tty: add tty_tiocsti_test to .gitignore
Date: Sun, 26 Oct 2025 12:55:46 +0530
Message-ID: <20251026072554.48786-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d1a483dd-5405-4e8b-8a38-816d49fffbc3@gmail.com>
References: <d1a483dd-5405-4e8b-8a38-816d49fffbc3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the tty selftests generates the tty_tiocsti_test binary, which
appears as untracked file in git. As mentioned in the kselftest
documentation, all the generated objects must be placed inside
.gitignore. This prevents the generated objects from accidentally
getting staged and keeps the working tree clean.

Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
staging the build artifact and maintain a clean working tree.

Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details

Suggested-by: David Hunter <david.hunter.linux@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog:
- Improve the commit wording and explain clearly why this change is needed.

 tools/testing/selftests/tty/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
index fe70462a4aad..2453685d2493 100644
--- a/tools/testing/selftests/tty/.gitignore
+++ b/tools/testing/selftests/tty/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+tty_tiocsti_test
 tty_tstamp_update
-- 
2.43.0


