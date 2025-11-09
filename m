Return-Path: <linux-kernel+bounces-892015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D004C44168
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 16:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EA83AFA62
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DA42FF173;
	Sun,  9 Nov 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBPvfMGb"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03832D46B1
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762702382; cv=none; b=ENyaVkQMw1fmxG5R3zOaZvxfDyagOVvl+qBI2qPuCugVa58CHoq+l4exk2ImoV8uL68gxRV150aBxS+dLeGFC3KqriN/+kQ7/KBLvDXCdlaJENLn9dXXXrXeT3t2tu8d/5iI8eaCm1sZZGXMfSsNBHuUCFpJA03iDv6JTLzTJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762702382; c=relaxed/simple;
	bh=RaRFPf3WLcPxmxP6jtHr5ZQLaQLUHbn8Y0qrCApQKOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5/p1i/eQrwH+dWmUF+EgnJ5qsUoFaixObANovC0mNbromDYwjJFppItNoJCc1ufVjQdi8dSpboz+OPHK3DPkUIN5pIPnV3uY/fYDMsvCu348LXRFtu8p1DxtN7Sh2WzI4FUKPVvvwgYa9KTiLdts5ncOCNmCZu/n/eFDdoZlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBPvfMGb; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-93e7e87c21bso135276239f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 07:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762702380; x=1763307180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5uoeahnEfl8l8TmjLqUuFndb+f1D3bliMiTtmazWGrs=;
        b=fBPvfMGbWHjerSlOLBiRlkuiU9eLRF0JTLQHMMbOlX/5YokcrfXklkdQ75TBesvMow
         eRNEV7x66XFCCBCKGQwZOrjTZiqhV1jo+vRw7RFd7a9vJRD3q3aSol/mTf4VWBHzKyqJ
         5+wGkquKkwoX5ANB6LwkfvJn3TMnJVrlNqvtuvLq7znnYCinE2yt4SR+nRehPaf2dO96
         OqeuyfJ5FEP3Wad+nMy4Tlrrpw2R5T4ev2FDBojknB+7bHKuPwNLYZkEftDq3nSp04o/
         VQHWx0HJX430qv5SrCkAhKpErXGQmDbBJ5mxd3PfnGuf33XPKhrC3KUBlW7FAHyUYYA1
         qfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762702380; x=1763307180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uoeahnEfl8l8TmjLqUuFndb+f1D3bliMiTtmazWGrs=;
        b=E0JaGom2fZrnb9ZyqHt3kXr2JOBStaj3RoO6wtlUiuXgdYTjskf+sHdMe8t9Cl2QxT
         seFq6AUZWXkRftCrBjsTx+NzaiNhTytEOFP1KsepZ7/RpsQ30e9nYxwX80FZNZN941zp
         CT5Hop34Hyg7Owo0RSTFsMD1vmIJqP5mj+gbGQepJmTRIRk7VF57D9NAzUbpCgXxbuQ8
         ZnVhfRD0Fp3a4t+4bfutT3a1O5F4mpt6og6N1dnfMJMLifHehpxxWGBNr0isPgwb6j7T
         J5qkSR9SW35UzzDlrsBCeZ6qiWLipUjgLjFalRh1IHaMMkSEXCHZp6ep3U/TFxcQIQUK
         bR6w==
X-Gm-Message-State: AOJu0YyOChKK66axeogtPovgLWQFchH88Z4XYg28CwoVguLrxjMSRbRL
	m1XY0fkodpYEJV3L6M66kARjtCi1WOe+oVrTTk3Jed1KkSUoI1X0Hc3C9k1KLchR
X-Gm-Gg: ASbGnctKmguVs7rhwz8VHXWtXkIBokbeBJAzJhWnAtL0WVnADWZjdC+yaT34mZ/mLNX
	M/v9V5zLuIjORfZt7f9iNXjAHJaP3oXeg8g8n8EH7nWKH9rdP0M1aZTNAJW9+9yhECVDYFe+8QP
	wkqcN20QFwlY5LOSpTS2SWNGStO2LI00r3tY7ySMQZSPnIBeQ5CccFP554ABlKpjnPQmpXgBHVg
	JOwN8bK/TyJBI/P+WTsSWmi9XFlSEHFS+8PbQd7gRYe1ExAINtQ8GRd17LZ8Iwm9lIWIfNCX4XB
	j8Kze2DYJ7FRri7/3+cRZ9pKhLqLZ91fV4SFH1asDyA9VdJtBuUyDsjHn30LgMrcwhOo+6HiszC
	rLhQ5OkrKdBBfHKplOFcPGfJHwSmF04+hLsKf/AlzW5sSSkVycqYPdWx3BQZrdoQcfvlinCYzHS
	5rCmO1+LFMaBsXBhvQH69uBxnS8mlRHRV+c1/Td42yIOu2K9liE/81QfVhDRas17mskeQ=
X-Google-Smtp-Source: AGHT+IGb1FlwciB254Xeb1UpkwZAwAfzEondtkZcjipQEUrdmwzGRduu68ZWcEx1lwZ9w53abjhQrQ==
X-Received: by 2002:a05:6602:3584:b0:93e:7e37:26a3 with SMTP id ca18e2360f4ac-9489606228dmr764182239f.19.1762702379697;
        Sun, 09 Nov 2025 07:32:59 -0800 (PST)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-948a2af6cf6sm61329039f.7.2025.11.09.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 07:32:58 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 1/1] checkpatch: add MA_STATE to declaration_macros
Date: Sun,  9 Nov 2025 08:32:44 -0700
Message-ID: <20251109153244.2376104-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MA_STATE is used repeatedly as a declaration, add it to the list.

I left out the $Storage regex component, since I saw no use-cases
needing it, via: $> grep -r -B1 '\bMA_STATE'

This change to checkpatch --strict behavior fixes the following
lkp-robot report, reproduced locally.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild/202511071306.OJpTf7fK-lkp@intel.com/

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v2 - fix broken closes link
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..4b5e2e64dece 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1096,7 +1096,8 @@ our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
 	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
 	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(|
-	(?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(
+	(?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(|
+	(?:MA_STATE)\s*\(
 )};
 
 our %allow_repeated_words = (
-- 
2.51.1


