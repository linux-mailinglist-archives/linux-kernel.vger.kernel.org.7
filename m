Return-Path: <linux-kernel+bounces-891827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29E8C439C8
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 08:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D2F3A3263
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 07:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9522B5AC;
	Sun,  9 Nov 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvuxixPS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA430245014
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762672414; cv=none; b=kx9Y2LVHtVQQfr/S6W+W0qMtk8fmDXfJFOobwqprvBzqXDgJDgkTXd+4aHhzFxQaxemSFVHTl2X/qRaD21vjEBcE8Um9rg9Rl+DVZ8kFfgy1z41rGU5yPq6njyveqgDYx8Xi5hmhc4Qlzjfou4Tuv3OYxu5A0eujtITjWmdhEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762672414; c=relaxed/simple;
	bh=7K+eAw4I0x35tUGWi2MDACS8ckhhjNcr5P94y70Esvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oat0sa9GG6rMhSZBzGhCbeijdShMNC/Qa0G4+/bcRqt/AToFp+10ecr7Zs4E6THo+To0CrUwHKiXbCGF4656MOmINcQq7zbpRDUnKWu36hbE10bYKRFnlKk5dwOS3X1W/zbBjIn1W7RRszeicHlg0bkOaUiURNjJswYuaP/O8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvuxixPS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297cf964774so2076765ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 23:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762672411; x=1763277211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Sr2F9MQzqFTYcs+5dw/LNJ/aMd5A19XEE7/9ksFfHo=;
        b=UvuxixPSYkgoc048RxtHdniPIjlV3tjsCMnUUD971Q8pXMwXwaC3obepiCOvDv6zsm
         o+B9IVaKOK/RJWXHBE7ck7cP86Ny2zsDoCE9Ixom9kxerF765WhUzwdj0UL7/WiQ+Rbh
         sG/qCMKyv3Giggn8fG31uYoJGhzFATqR+fiFexk/i1o3GtkKKWYbstkFd3FQIstKguJv
         fegUvMOzqi02XxAj28JTRUch0KOQDtIbnaNom9vDvnzutKY3l48b7UFj9gANG1caPa06
         9V9XrEsUAdcI77K4gY5+w/etYkCa8zzDOUDfmfvR4+WKJANGjBGlBMq9otJP5iHWA+DJ
         E5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762672411; x=1763277211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Sr2F9MQzqFTYcs+5dw/LNJ/aMd5A19XEE7/9ksFfHo=;
        b=AdVsagYkddI9nUIW0SJJvoabEGXnUbS5Zx0Td4VSETTGWx2BH7tnypYXe467T0bpL/
         wim19UFiI18Unf+1uae0HuTe27UGH1fkNaGBa1vBazmtfbI913WynBLttWm+zqFndlIp
         2FhelL5c9nCahpNPmy3JXlRXhNdd3qBLe82U0AZDGwTocOVRh8h7wgbVUbf3Cc9TInzj
         gaAFoCJQFqeXxSCIl+v2YsorxChmmkuQNjCJPXHA+ziOdI//mjUMSfaj6vq0miF9A+AF
         DLRrcYQ1EKOoBGxg3pN6MD/0xVNpAFShki2S6UyTFEUaF743PKaiCUBaLwAwZdh/PJQg
         Wwng==
X-Forwarded-Encrypted: i=1; AJvYcCUusupRTzHBeR4uy4by3NPP3pdgnq6Iy1AsCGe7mfBah3bqhxVvfl2oMCgumsmn7J8IL3kg87k/7qMJ00I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtrl0hvMNfTaBV1155cHmumzqkCZOJWzATioa7w5suajB1nj0
	zLgxjvRqrqo+QQfCpJ/z4q4TBpPDLjKJ3OQcuwW91HPMwpxXIne8Pz+t
X-Gm-Gg: ASbGncvFLJO8jGHlK4eJmgMeFF83q0rDRSsVT+EGt2wRR0arb/BOf/am43ZKyr2B0xo
	pKyoFA0BvZMxQEOktDWCXV9Sht2IQ/FXqiexw3d6hdL3sIC+tGLbdNu5BdccVSlKAHLtfyGxbX8
	QHF7XPw/jH0bz7fgdh3KYCZGULFe0FcW/em5kzTGukXlTX6sAj7pmMDTx9z9ECTnFO07Neh2lX6
	u/ekHMW/Ar4Avai3+8XpCZudZyrl7RVmiLm2WG2T0LxprBb6m83yaUdGCeS8LFz21eBF9vxPGCO
	nq4N4EusS5CXthvpo72QkFbDPn8qyedj4KzFkUPLx0BX2Z6IpgNgxY+cfOf+2aN9OuKAHmFIwkc
	lDWaptly14Kbmb8AHbvAgSCG9f8Bycnm3oZKQpX/bUpNerdx0esbgbrKuKZGCJXT2t0iTav6CFI
	K2fJhR1yRz65RXl0EhgGJjR1thY7Yh
X-Google-Smtp-Source: AGHT+IGbXs/m0KZgHZ/BEGvXV3TvyIMHnmN5bbAbrdte8kwOk8/1idc/hq0bNfXupt204mptBEpzrg==
X-Received: by 2002:a17:902:ea0c:b0:298:f0c:6d36 with SMTP id d9443c01a7336-2980f0c6f48mr3180915ad.5.1762672411223;
        Sat, 08 Nov 2025 23:13:31 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d6859a92sm57287495ad.88.2025.11.08.23.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 23:13:30 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: jesperjuhl76@gmail.com,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH 1/2] uapi: fcntl: guard AT_RENAME_* aliases
Date: Sun,  9 Nov 2025 16:13:03 +0900
Message-ID: <20251109071304.2415982-2-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109071304.2415982-1-nogunix@gmail.com>
References: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
 <20251109071304.2415982-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 include/uapi/linux/fcntl.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 3741ea1b73d8..e3026381fbe7 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -157,9 +157,15 @@
  */
 
 /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
+#ifndef AT_RENAME_NOREPLACE
 #define AT_RENAME_NOREPLACE	0x0001
+#endif
+#ifndef AT_RENAME_EXCHANGE
 #define AT_RENAME_EXCHANGE	0x0002
+#endif
+#ifndef AT_RENAME_WHITEOUT
 #define AT_RENAME_WHITEOUT	0x0004
+#endif
 
 /* Flag for faccessat(2). */
 #define AT_EACCESS		0x200	/* Test access permitted for
-- 
2.51.1


