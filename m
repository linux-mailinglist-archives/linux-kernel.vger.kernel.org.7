Return-Path: <linux-kernel+bounces-804010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46585B4689F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05B45A1AD6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBDD244663;
	Sat,  6 Sep 2025 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQfN7Plh"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754423D291
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128902; cv=none; b=sPhCtBx+iPUGUG1WyaKTb+0mWqbjfbu/L3rS3xyWWuIsx9elTw+qf7KjFqy6j7WBr6zW6dDb7R7Y8B00SSY+va9kOw72e4gmbHsqRjZStB6/pVtkyW0WD59z3TE+i8wd4BLaMurEak8GUXLMT9By4biVdp8PDQFGPDKFnmD/4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128902; c=relaxed/simple;
	bh=4nntbxd9QhxEvmQibcuTIkC0BAC5Ve0dSQ5OC0TBN9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyjN+1m7EUigH3M4kdQygaA2PECeJMnIOW1YID6dmejJwfmzsF7yon7OHEigkKi2ExLg7cpy/HqTXT6eAEzDe7qp+V96jLdUU4k5xJxI2bqJ82Ujruthr2bDpWa2gBk1sxl4OTD/mCp/aDsXUU3VrwDgQ9JHH+/B9Adf0MXv6HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQfN7Plh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-251ace3e7caso2005185ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757128900; x=1757733700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkyhEF1uSyF+/KrhAZe6tTEv+I/fUAI0IzZh62oGhRI=;
        b=TQfN7Plh5nM/KYRM+qzFOHIPsju3+2pPRq1HjEP3k4i58n60TUI2kmxkAXhDhGvKf/
         Qe+8mYzzPVuPxIai3eb+lKW5y7YWkC+DP6EP3POXe3pj4zgRdMZ7BWT3aj6tzTL+wlwZ
         fL9moJixo3gV7w/M/b8LoFl3Rbv0BwrxUTIeQpUPNMzFgygL0r3mIeglFiZ0ZFaDL0Wf
         37DqkyEr/yiqEXheASV6qbiT2OW5p1EkG7xyDw+eGueIsahKpQLjApvNOGuKXxfTNM2m
         eNZvSfcmViTolIR8UmIOEt/hlmd1wfjRXKwUAwi6Ol/K93xR1K4ky/K7Zrkgca7FQzw/
         b0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128900; x=1757733700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkyhEF1uSyF+/KrhAZe6tTEv+I/fUAI0IzZh62oGhRI=;
        b=BrbN1/UO+o8X8o+M87EEi2knUjZK8/odiuR+mTXGmH639gLZR8NaUnZHzVIiOnyC+5
         tNNe9mmlHXfmwt9F+D1gLGemxQkpAYrsjoeGFqMvZZvbtN3fPM/cHgZi/gjAIfL6YXhw
         Ye1rcRXdxGeJXogKlnOsEeQ4JYW+lTp/rlIn0rrzqkyz/AoaKp/WDdkIlAz2eK4pZOx3
         0UjnSG0GIBUpBHpHFI4gNUAjnxt7H9FgWpfl0weJRJaje78yNFGgEFr4ztIYmzQkE78N
         wXeRUXmZkcQq8jn+b8Sd7dWcoBDsHCL9SQTwfytyHndfmxj4CHEh30fLL1Pq7uyeJ0T+
         ClBw==
X-Gm-Message-State: AOJu0YxVwXnubOSBnvCp2aRbgll4XT4iBXglPFFsjVJPaUi1tIxQlbIw
	cF5GAhFDwTqXDGZlEgBK9uZfKLqj5cquOd0O+/bxINrkRor+m8U8f42+MbFA9g==
X-Gm-Gg: ASbGncs8sBHDhAWAPx8CgnjJ2xGQCqbJJjFLwjzXnG7fvfj3YzcH2aHcuH2cJnTqHfX
	16zLl+GtO7kmE9sBU+yUX+YsHXlF+/HpV4xds1Brwdn3wmg7QAUcKu0Tw8z2ORBOeBPUp7HIo6I
	l+PubBkRAveGkBdA4SpfzpybTif1nIMzglBkusbBIHh/ErIimAaJYjip8AkXjvVwXit4LycTS6u
	yQn34CCA6ArZVZF/rbIz4HeKudOinKhVVZPmtTVEOx/Tmwm782NpO6+k2RTJFlnfhhdAlAtWf5M
	gNcKGTbXkn2jmyqwP4QS6G+k9VfcKfPjvUb5qV9lnhISj2//0stY0iCdza54Tf6UB2eo8ENZHAw
	0xdwReF3GBRJHDax3773cYk+P9WF18CgQAFX+VH0ZFLSmBVbsXrtQUwjbqcCnIxIaT2KZYuPtbb
	PauGhSMXWt7NXcbw==
X-Google-Smtp-Source: AGHT+IELz5Hl28eDkQmWjh9VvWxPVwHn3R4dbl8eDRnMRGXMwQQmHsC316tJPGLthkxxSBAp5j0NcQ==
X-Received: by 2002:a17:903:b90:b0:24c:d6f7:2788 with SMTP id d9443c01a7336-251741866e3mr10292705ad.57.1757128900390;
        Fri, 05 Sep 2025 20:21:40 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da2896sm228127265ad.81.2025.09.05.20.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:21:40 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Huang <sef1548@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: mfd: nxp,bbnsm: Fix typo in documentation
Date: Sat,  6 Sep 2025 11:21:23 +0800
Message-ID: <20250906032123.21534-4-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250906032123.21534-1-sef1548@gmail.com>
References: <20250906032123.21534-1-sef1548@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling of "Intergrates" -> "integrates" in documentation

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml b/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml
index b1ade64a15..1705812f2d 100644
--- a/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml
+++ b/Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   NXP BBNSM serves as non-volatile logic and storage for the system.
-  it Intergrates RTC & ON/OFF control.
+  It integrates RTC & ON/OFF control.
   The RTC can retain its state and continues counting even when the
   main chip is power down. A time alarm is generated once the most
   significant 32 bits of the real-time counter match the value in the
-- 
2.48.1


