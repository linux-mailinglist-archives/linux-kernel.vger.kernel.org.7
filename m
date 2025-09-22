Return-Path: <linux-kernel+bounces-827952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C56B9383C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48B948097C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB43164D0;
	Mon, 22 Sep 2025 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WPn7RD5Q"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CE31691E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581348; cv=none; b=WN/ZicOrIrxZii7v8df6FM9PvgNm0c+jRT2wf4MwMw5M90QuU3/NVghHxiF5pcOgFMCJNnCyGzxGnGM6cpHLuhgpH7eV+oTnUNFbRr+xtxZwbRNIQz125uhthjLSWKranib0PKZ408oL5ASquIuaZJF+K/M/z3jpCGKdhr8nae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581348; c=relaxed/simple;
	bh=ILLo7rGl9b9zjnbqd3MGYox6UQqDjx+Lj+bAucxUn3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0vMcz1Vq2DqbzP0LfgCsY7pISdng+dBDWEontYb7fx6yRWkAFfvhYMQWLqysw5J5+ulIB1WJeQdeh88g0njTg4IHkyi5OF7vbbnv6+VQS/k+IM55o35xGdYOzROiWisyWwb/BuURuj+XtT/slO2nxY4UazT6oC0uQLuzPvm1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WPn7RD5Q; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74542b1b2bcso4447774a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758581346; x=1759186146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1e3rwdHznymhqcKmmEPEdrOZ6tPA6MN5wQk3iVJNOM=;
        b=WPn7RD5Qi6XSMcYEJ/8JyYVmhbIVoweqcxjNoEoZz6gNAx3KE++DDe5dEPHnPpQgRE
         QGR6UGMB/PQUiBNWDg6gvt3aIxDDbN4GEdaNQcwjqsW0X2scOuyA8FglF+3/luYZy3kP
         d3CZb0KFs62EHjTTEZSWl+2svSrNyI+ovIxJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581346; x=1759186146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1e3rwdHznymhqcKmmEPEdrOZ6tPA6MN5wQk3iVJNOM=;
        b=v4bmVOEdY+bEOi1xfhCYydM68SztE2iaLgZQRQjxSpjRZGsetUbxnbAWHfXCIHHIRj
         4FaOOPJlkxw2OSPV0uRIKdJ8/GN4Fz/rhlb6troxTu4hNqq1dfcOfztEnFPM5YkjDA2P
         Sqq7SnGXk1VmE2rm/clusi9Dyb+wd/UeFNZw++reN/o/3EHY6nT5MxQM6fXOnkQCg+fl
         JqTb7c3KERRIQ42Qd/MMGEvU5OkzEnGUGUZx6ftX0MoIXqyJspYySB7PuPoZ4jgoRe0D
         iuV9ZI8ZNN7PMrjeB+/F5prwSaRGuPWRzF31G5fL5p3nA4Sr0/SD2bzycUGlLZapl3Lk
         P9gw==
X-Forwarded-Encrypted: i=1; AJvYcCWcH6QrmtukMpC9+WYyp7iOuFx8fCAC/zj7cIqoC3w+K9b9lUcs9C2tfC3bz2LNl6wlOnCZi4jSoF9jvuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfdDUO1F9g+j8j81/DOdyve5nu5LXPq/KF7oOSr/BDd8xgAG1e
	GKpR8AEAPbI/FodZTMYDJ7Ox70LOuqatnwNFzrw5BAaeowe5E12ObwQbpg15H/Lsyw==
X-Gm-Gg: ASbGncst2I/CrqO5y9PyBG/gE9GSmrkGP+5MBQvXhN8QKDUqDvkqBNboWMZVyh1Jwwn
	8T+qTVyZUzwIbvv0BCN3kXwH5g+mB5zbuvWSLijzmPvB/BIf3OZW7L6RBhXUb7Pw2bjJkls7EZA
	Koxw+lf1GDzLN8zWW382TbzG62AU+ej6F9J+F3vTTTdxCGlxzS0K6wOshFFjUmit/9cE1YPeJlD
	7i8HGLxez+/v6rfqyM6Lpo2XFi+JZYJLRZ/7NIfcxY1cqJTWIpvA/idUN0sGowNyWemPsAhPG25
	OEP8SXRph/BbLczMm1zFJ+TJJols4g45dC4sSOfoperiSiWUYpRPtgDC10UK7fM3WCGI9/JT0Ay
	Ut9JSPV5CIYHYNyjPtuM=
X-Google-Smtp-Source: AGHT+IGr6tap0sPqebFz42P7hl+4lEILp28PDgb1nPW+SCIac0Vdb7urReiwBVQ18LGCt5FqC+bUvw==
X-Received: by 2002:a05:6830:3484:b0:748:317:dd81 with SMTP id 46e09a7af769-7915d3cebf7mr212842a34.29.1758581345941;
        Mon, 22 Sep 2025 15:49:05 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-78780383017sm1167244a34.37.2025.09.22.15.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:49:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Tom Rini <trini@konsulko.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Han Shen <shenhan@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Rong Xu <xur@google.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] kbuild: Allow adding modules into the FIT ramdisk
Date: Mon, 22 Sep 2025 16:48:32 -0600
Message-ID: <20250922224835.1918759-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922224835.1918759-1-sjg@chromium.org>
References: <20250922224835.1918759-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support 'make image.fit FIT_MODULES=1' to put all the modules into a
ramdisk image within the FIT.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---

(no changes since v1)

 scripts/Makefile.lib | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1d581ba5df66..2e880d9b4706 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -398,9 +398,15 @@ MAKE_FIT := $(srctree)/scripts/make_fit.py
 # Use this to override the compression algorithm
 FIT_COMPRESSION ?= gzip
 
+# Set this to 1 to include an initrd with all the kernel modules
+FIT_MODULES ?= 0
+ifeq ($(FIT_MODULES),1)
+EXTRA := -B $(objtree) -m
+endif
+
 quiet_cmd_fit = FIT     $@
       cmd_fit = $(MAKE_FIT) -o $@ --arch $(UIMAGE_ARCH) --os linux \
-		--name '$(UIMAGE_NAME)' \
+		--name '$(UIMAGE_NAME)' $(EXTRA) \
 		$(if $(findstring 1,$(KBUILD_VERBOSE)),-v) \
 		$(if $(FIT_DECOMPOSE_DTBS),--decompose-dtbs) \
 		--compress $(FIT_COMPRESSION) -k $< @$(word 2,$^)
-- 
2.43.0

base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
branch: fita3

