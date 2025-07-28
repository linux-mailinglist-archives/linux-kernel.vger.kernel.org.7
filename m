Return-Path: <linux-kernel+bounces-748143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C909B13CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14443A45C7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBFB26D4E4;
	Mon, 28 Jul 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT73o+Tp"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5026B76D;
	Mon, 28 Jul 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712426; cv=none; b=hpSdNwR86GtXitD0NTIyDNj0nqwYfLBeZxYmTpHEeehsV6c8cH+H7SfclTxdN8vJeUljs2aWf0ezZzP5FLcWlWgSn1A9Ciy5YNW3KyZQJu4/kWooCETV7YvlwxjyWo2Fhk9do4jkvA+tKLKlIS6cWJXqqnF26YQDHXVz4vk5K4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712426; c=relaxed/simple;
	bh=1PggnwSVufJ15eLoLiPtMJonLerZeCTUUrMLHt/MvWE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XTdsPVYqcB5VOqsAsm8fbbxtC3qywuBzEK7kDvQP4ESZL3t26D5oCrrM4FS8lxZI0Avj9M09kv9KCEjtWqbT7jHfXoK6VFQPDCB4K2K2eVYdPTrjfPtjeIaN+0pgYiwK6HaCx7grcFI5DtodibJRp2gsBMrB9XlcvU8BiGLTz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT73o+Tp; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7426c44e014so3680391b3a.3;
        Mon, 28 Jul 2025 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753712423; x=1754317223; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZbPgCBxEfjAABl7BFhrPe8nrXtS6lUGZ8fQixqxipg=;
        b=nT73o+TpESLzaVXy5b0GkfG4e3vGAqGVkKvauQNGRTKiUcp7TzXjniXxkCtS7w6Y7Y
         lPuWa4O/uvbxvYloeFCe61xikZTBCP4QYFgz/kDB/5KiUKVDjBxdQdPPmbWp/9H/eRNV
         2g0MyagJcG2rasdhECxlZq8lCA4WMB5BnPfY+dEKbiXd1VveQ6rRv+3e8TPkxVJx43q9
         PjjpMwpLPTQK6/lOOChVDOaxLYZLXOXoS7H1gM6hyViHqDUCL4YcKRJE1c30h4ucq4NF
         K8/HkLcMwPGcyYUynWX3DfbqIaSfZ23PQ8Qx/+vurGaGg8ibpddXQ2aTtBH3tyYgrtco
         BIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712423; x=1754317223;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZbPgCBxEfjAABl7BFhrPe8nrXtS6lUGZ8fQixqxipg=;
        b=LdE2HQislQ81ZixzbUqRa5Ffir4tD87a192kYiLDPvCvs++Io+cTQxOpKmfSaWV84e
         LLGPOungEPxp8UFTMfavj3Sk3s1KNx+H46xs3jIjxB+CgsXUqQgbMJhSfEYeO/+zoITR
         OXQzqlsriSeU5Hzh3dQeME3pyd7tdIsxzWizBD15tl31y6VMk/OhfuK4vSHClnclgTom
         0P/yvFX2ShOUR5YyhtqU85mY09ffYtIKj/ZWC+Uh2RbS+oGhxZgWZZF9cShimHj3cI6Y
         ljVs2iOnVW9Wg4MT8BklQCD1zOUBNrwGyrz+ATo6CrNeH57TwYMKWEcHRMWnAAndF/xS
         Yqag==
X-Forwarded-Encrypted: i=1; AJvYcCUAtudLmPYWMjSRDLoLsAybTzw0+wjzsGJSQCHqtGnvry/YnuXMUhO5Pt0/b4UOhvcc/GOwGWuSPZt/@vger.kernel.org, AJvYcCWaVoXwNqAhPvf/DiqOhSY1Y5CxWAwFmMz2OJ7Aon8D0FPBer1/AJBBk21i+F/VjwL0ZiabIwIOgBC3vLSr@vger.kernel.org
X-Gm-Message-State: AOJu0YxkRd7iyv+9jZIPaxVZTFNkNCX/q931PrwdIMnAuWXSppCtwv9w
	lKpTIHYu9+IeFBR8ZKw93Ivi5wZCIjRJiQMji0vex4+aNPGQoIPhty9BH+dpTssLMlHEsQ==
X-Gm-Gg: ASbGncvfA4Zf8C6Lz3k5cZUUjfs/fpF3fR5NSx242Q7UqMAb9z/6nULTKMDBjBGOH6h
	t6EZP9eDgf25LkFla6yuQJ11NRuSOInr9Og5y+K8Tub7cKdaoyTo3pI1NbdhatSI1uXTfle86HA
	95d2k1dZck7u3H0nSi6W/Db7mxeSHO9IQiuHxqqeBCMvUkgAB5IvmX2h1yWhqoklSikUKx90Eti
	APLkNXLXWEy+9/tBycHFll5e0HBmbcGVOY1i8xc7ztHEXXu3VzT5nrmM7RQJrF/j7H2mUdelIrP
	ncU8nKXyvdiYNosUxynR1h+FBSmd/MJuH1nxcjvTsPgZQ8xM53ZD3OOcvUQPzaitVkEORQ8sWbD
	rO66OlKYUprhNpSwypUQQCKHINjIhhC/V
X-Google-Smtp-Source: AGHT+IHtegYM4BlLYXwS9tWAhPo7ODJPuXBsbqpjo4lyceFKEN4p/yLS5sVZ/sven5XQoNC9rK1+NA==
X-Received: by 2002:a17:903:2054:b0:23f:f68b:fa0b with SMTP id d9443c01a7336-23ff68bfc5cmr57909205ad.37.1753712423167;
        Mon, 28 Jul 2025 07:20:23 -0700 (PDT)
Received: from localhost ([2408:8256:2284:4127:de49:6dc9:a446:157a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23ffa4bc557sm36791405ad.116.2025.07.28.07.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:20:22 -0700 (PDT)
From: Troy Mitchell <troymitchell988@gmail.com>
X-Google-Original-From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v3 0/2] clk: spacemit: fix sspax_clk
Date: Mon, 28 Jul 2025 22:20:14 +0800
Message-Id: <20250728-k1-clk-i2s-v3-0-5d7579f02227@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6Hh2gC/03Myw6CMBCF4Vchs3YIHSCoK97DsIAylQmXkhYJh
 vDuVuLC5X+S8+3g2Ql7uEc7OF7Fi51CpJcIdFdPT0ZpQwMllCeFKrBXqIcehTxyRgUZZW4qbyA
 cZsdGthN7VKE78Yt179Ne6bv+GKJ/ZiVMkMyVW8NpWzdZOcj02mI/15pHWWJtR6iO4/gAm3zi8
 60AAAA=
X-Change-ID: 20250717-k1-clk-i2s-e4272f1f915b
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Yao Zi <ziyao@disroot.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753712415; l=1761;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=1PggnwSVufJ15eLoLiPtMJonLerZeCTUUrMLHt/MvWE=;
 b=8/rLwSFmfnZFKcqahbV5wIBUuymvjJZLulCrEK4AJqVN8GYHfpSpUo+qbM/Du5QUrTG29NJ8b
 ggVx5UlgBWuDTyPGviJ3GCGDdxHb5d8QjCYF9Y8HM990Ykcu7Pyhy3q
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=

In the SpacemiT public document, when the FNCLKSEL field of
the APBC_SSPAX_CLK_RST register is 7 (3'b111),
which is a reserved value. And BIT3 of the same register is
a reserved bit.

But the documentation is incorrect. In reality, the value 7 (3'b111)
of FNCLKSEL is not reserved. Instead, it indicates that i2s_bclk is
selected as the parent clock. Similarly, bit 3 is not reserved either.
When FNCLKSEL is set to 7, bit 3 determines whether i2s_bclk is actually
enabled as the parent clock.

In all other cases (i.e., when FNCLKSEL is not 7), bit 3 has no effect.

Importantly, whenever FNCLKSEL is set to 7, bit 3 must also be set to 1,
otherwise the selection of i2s_bclk becomes invalid.

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changes in v3:
  - Fixing ABI-breaking behavior
  - Modify commit msgs
  - Link to v2: https://lore.kernel.org/r/20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com
---
Changes in v2:
  - Use virtual gate instead of new function for sspa
  - Add Suggested-by tag: Yao Zi
  - Add Fixes tag
  - Link to v1: https://lore.kernel.org/all/20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com/

---
Troy Mitchell (2):
      dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for SSPA
      clk: spacemit: fix sspax_clk

 drivers/clk/spacemit/ccu-k1.c                  | 25 +++++++++++++++++++++----
 include/dt-bindings/clock/spacemit,k1-syscon.h |  2 ++
 2 files changed, 23 insertions(+), 4 deletions(-)
---
base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
change-id: 20250717-k1-clk-i2s-e4272f1f915b

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


