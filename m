Return-Path: <linux-kernel+bounces-843568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B7BBFBDD
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B24D3C498C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7BB212568;
	Mon,  6 Oct 2025 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FpyspUHA"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7721ABDC
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791775; cv=none; b=CUWM7vsUZLLrDDu0DFxv8hI1xZX1ea8KdgovubaL+TU5lY1chhXJX09Kcpr4fCxRhFEE52IYw+xjCunblxC7mtrJB2m43UNS2ZmlZ6mrt+raFgWopi7VBleVB7K+itdByR/Et/Mw5LoLhP9luMD1Fzmca7mrxOW5ZNUPAvOLGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791775; c=relaxed/simple;
	bh=J5q0jWsK5BjH042bjuBuYYFQ87rhLFCo1nf6x44DvAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFuXsb65gs6FtnXmlFldDjvXMprQMGwGEcnzNn6/yeOezIiKyOv7LrKd/+xuIECiya3+bOLNBFmy4+V5/zRFmqkaEbpJPUldvwJfVpOf0EUBR6ILvLKvEPP6Jsvw4o/6N404kRV2vIEEd+o/h9W758gG6QnCvWgHIgA7DE/9sHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FpyspUHA; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42e2c336adcso19139385ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759791773; x=1760396573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYASDCPfiPbCUV1KYUTYbx4wHolb9ntBgheoD945Sac=;
        b=FpyspUHAbqwZXazaT9iNZdMk6sRLYYyRHaevXs3MQRqkRMU5Kl25+Jf8X5vCfjAoDp
         NQ1FfYXbTtrFhD0i9DnyGBHuLYGMcM7/4ChLQqs4WXCkVFTYRkh7uzzgsHwAlupaNe/q
         5ITTL3VRhb4jQufIfwgLYt6YbIxVqlyFEhARU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791773; x=1760396573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYASDCPfiPbCUV1KYUTYbx4wHolb9ntBgheoD945Sac=;
        b=vXwKZDPjZXYn+9/YhLNfPHgZobCEHWEQbXbSH3IliOUFTnOVCqG/Ts6NPkmb7erinD
         CG2Haf42Sn8/G6ToBHAzkSo+mdgzGdkBC6NPAzafBv3Tv3X0SLKIwDQhwBXN7uYJZAbw
         hs8Dw+UnNXiU4Nk6kxKgbfGH9Gq+fE22J+UmaY5kJrxbNrwia4p1D7Af1z0IFv7lA5f/
         pyyWOKq4Ti2Z43+UwzrU3gKJNS9aneVWeO9WJIz1X0epFOmsekXGOG1M85xXHjL4oIYG
         JNtU1HaUEfprH6OYPR+wdAgVV7G9qkMDMiIiGyc7qhZrka3LF4FI7LFM1lZBiX+QJ2AJ
         Totg==
X-Forwarded-Encrypted: i=1; AJvYcCXphfDpKCZsqmXUz7qTBDlr/SE5qqbTyCHxWm2FJd34vtxctYax2jM8SgjjuoTFOyOQ3vrWkOZhLMmKKjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDM+CD1vFOe7vl1mwzwgubcpaT1d6PbIqFIs09QEH3nj929cfe
	h4eOc8QPLGWQd9TPdRzGvIh7lEy5p3+0A6mJvxeqB7k2IoqYM5wQ96efzpz86VLOcg==
X-Gm-Gg: ASbGncvCdM4oyrmbkLFRhL1Z7KzI0xhLhoKP6c7buMtbIdwmW0uS2NQiaCjlyt20jYr
	DCdMVUq4ov3mwbOICqqpTfz73sSi1UYCrv8GOm/jB+Xze8Kl0UBC8hj3aBVN7c1cGvAyQhAY9PZ
	qOUk6JbWw/FVE3uKgcx7Y0wUZb1qCPqcOfU6gtSyqMY65/rkDb1zEMrXN05B9mm37UL4JoQ6pI0
	UIRjI03KQ3x5jTwm+7Biaahntde1asGci2FVPPXib6SuT8ZNnXEIEy+723mJj/4BkquU8nmaPJS
	OxdEG4P78OkLPROipLxyU6Rmiw8V7CDb7LBfMXrk7iB/oPqnmVlPiGaQ7GmN2vXA1Y9wBIV5Kaz
	wCPjoegauKZzRjgakg3VF631Zc/VbGoD34xvMvBR7oss=
X-Google-Smtp-Source: AGHT+IFWMMJp+NFmsOx6pq2dwd7Hy4kI7ynB4UcS1GCGMob/F9UqCyjwJZxXEHBZiF/C7t22Bn7ozg==
X-Received: by 2002:a05:6e02:174e:b0:428:c370:d972 with SMTP id e9e14a558f8ab-42e7acedb7dmr164223205ab.7.1759791772886;
        Mon, 06 Oct 2025 16:02:52 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec55bc7sm5422226173.69.2025.10.06.16.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:02:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	=?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Rong Xu <xur@google.com>,
	Will Deacon <will@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] kbuild: Allow adding modules into the FIT ramdisk
Date: Mon,  6 Oct 2025 17:01:56 -0600
Message-ID: <20251006230205.521341-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251006230205.521341-1-sjg@chromium.org>
References: <20251006230205.521341-1-sjg@chromium.org>
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
Acked-by: Nathan Chancellor <nathan@kernel.org>
---

Changes in v4:
- Rename the Makefile variable from 'EXTRA' to 'MAKE_FIT_FLAGS'
- Use an empty FIT_MODULES to disable the feature, instead of '0'
- Make use of the 'modules' dependency to ensure modules are built
- Pass the list of modules to the script

 arch/arm64/boot/Makefile |  4 ++++
 scripts/Makefile.lib     | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index b5a08333bc57..d10c85f96aea 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -43,6 +43,10 @@ $(obj)/Image.zst: $(obj)/Image FORCE
 $(obj)/Image.xz: $(obj)/Image FORCE
 	$(call if_changed,xzkern)
 
+ifeq ($(FIT_MODULES),1)
+.PHONY: modules
+$(obj)/image.fit: modules
+endif
 $(obj)/image.fit: $(obj)/Image $(obj)/dts/dtbs-list FORCE
 	$(call if_changed,fit)
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1d581ba5df66..c6a3aa653035 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -398,11 +398,17 @@ MAKE_FIT := $(srctree)/scripts/make_fit.py
 # Use this to override the compression algorithm
 FIT_COMPRESSION ?= gzip
 
+# Set this to 1 to include an initrd with all the kernel modules
+FIT_MODULES ?=
+
 quiet_cmd_fit = FIT     $@
-      cmd_fit = $(MAKE_FIT) -o $@ --arch $(UIMAGE_ARCH) --os linux \
-		--name '$(UIMAGE_NAME)' \
+      cmd_fit = $(if $(FIT_MODULES), \
+		find $(objtree) -name '*.ko' > $(objtree)/.modules-list 2>/dev/null &&) \
+		$(MAKE_FIT) -o $@ --arch $(UIMAGE_ARCH) --os linux \
+		--name '$(UIMAGE_NAME)' $(MAKE_FIT_FLAGS) \
 		$(if $(findstring 1,$(KBUILD_VERBOSE)),-v) \
 		$(if $(FIT_DECOMPOSE_DTBS),--decompose-dtbs) \
+		$(if $(FIT_MODULES),--modules @$(objtree)/.modules-list) \
 		--compress $(FIT_COMPRESSION) -k $< @$(word 2,$^)
 
 # XZ
-- 
2.43.0


