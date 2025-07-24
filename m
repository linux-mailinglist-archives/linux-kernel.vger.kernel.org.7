Return-Path: <linux-kernel+bounces-744404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D60B10C76
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D174AA7F19
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757FA2E7BBE;
	Thu, 24 Jul 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hL+cbu6y"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA82E49B7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365397; cv=none; b=oMCoGgV40nB52K8l3gadRtIkgZKz2Nhw1DdLPDYNUm9sSKtxakJqAs5MiorAvNTy/9Ugbfu7x9d4WZXADlwJk5kNWxBGbSzl2ohvowqM0JKD8gTlRzK6n0s4yUVOSJa9GepcgMT2teu9Uim3W3mg4KYuattgDz76h+Ptgd6jyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365397; c=relaxed/simple;
	bh=YrGjiFMH/zlkC3aj1afXt5OiVcA/uj0LuVvyhAgKIeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG0V0I8moZcIvYGFutY9DbFzZO4Za747Uf7vQ9WeOi74UmdlBPs9z47FUK8t3oI4mNLA2w1ovzcDNSrBmbby1b5COQlZe0x8LJwtet3AKdXaZ+aoeqp3H2iFy0vk7gQ7mUIiTMlJaWwULTcyA8hRvMhvjZAtiD9Xd79tdFGIEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hL+cbu6y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4561607166aso7021895e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365391; x=1753970191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFMrD7tjY0571sMCF+ur1VmM8eA36pvQygKXmIz05uw=;
        b=hL+cbu6yP6EjGyJww08MbKFjb+YHPqZ7YRN2X+iaJQSFXXSoejFtRUQUISGeGk3bnT
         l4Mf3gBSOeQVUcf3zkL0cuXVrR7T6m6I5BZmiqKv0e63ju/1voNOkmgIC5khxZFfZqcp
         6kMDmBdL5IZuYb0WxFzgvRnu3IMyj+HXD2LjI44tjwIJoOS/cZ8FclMf9WupAvrKNtza
         Mlx4V53ttJVOdBW+tWvRS2uZhgZ0UsJpdg+juC7/+pzmSFpUq2azjNcvDQmjqA0NuGng
         w7rYBsSgNtZJISnIcSBRNSMSguYIQCYYRDLA25r1LhK5sR2dkhetmsbw9M++vwI5m0vi
         syMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365391; x=1753970191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFMrD7tjY0571sMCF+ur1VmM8eA36pvQygKXmIz05uw=;
        b=kRw5Mi15IFTtAeBHgCYISS36kzFHpWhC+bhuXs2o4nSPTOp9oUabLfaR9iWSBzYkR3
         L2vq+ohO77GkMQgO78fRpCk1ie628qjcKJCsexbVdNFcgCadACyun2RTbKDDUaf18vG7
         IDSSCOJ6dd9hzSLeLTE7s5g1Dghc8NcEh6sC6y0RH+M6FqRHLR1ztn7Vuu/jJ+P3P4vi
         KLLuQBUvgLD6LzFdeOQ39ruUJPETyIOuLER3uuouGCYQ0NEHukI5DnZYsq3+kcANSGKj
         RB4gBUU9gyMZru2ZeXzsVrJ5XRTzTEurDZHZ1Mra/uKLUXhOpQ2hwUbZnW0Za1BUGwWH
         YHHg==
X-Gm-Message-State: AOJu0Yx1gC36/A1NYR770/E0MHGXWQrU3EadGVZ09lYVbfsv6UHL2kEA
	HaE6NWSIlXuXnNjSenA3Mx1YaOuklXbu98boYm04Jt8X8QbxTYhz15imd1NX5EqvEGrRIGIxcxE
	9FN/5VG4=
X-Gm-Gg: ASbGncsttCzitSdmIr1aqnHyCRUv4K2foKV+dygn/Pf3Dh+aD4D82zhVLtSCbHAXi5J
	0jVfiAU0pR4TMJZWj7pUggfVquO0RpQNg7l/1VHvcpqBUXJJ9lSpCo12PYFl/s51EEIIkLhKhHm
	jjh8+A6S7oEL/+nGbN+XcMGH9Yz2UBuNVURFQo4mz0iGh8aTq6DdDa2xMgKWBFFuLVeLpK2b8rJ
	UsNkgvYCaQyrPIyVffSlRiJkT19+kRU5ROfcpROwiIHGjgVWhVnCJE1QmsW28grnLkr4XSfvTMc
	fexRLsObzb9icPL5hRPF2hqUdF1uPP491PtH/e3Ir8SieJAUQAY2tD4cUgV0pjovWR4/csLP+de
	TLzD5+X3cArl9rXd7FnAnEZWOTSU9zrQ/mYj4fIYCxXMo/kpPZpq99yHiVbObq+L9FXMvv2BQCj
	mK3IQY7h8B2MlLRlRr3ERuppQ=
X-Google-Smtp-Source: AGHT+IHYV/rdyT8foqBo51VlSPNSFrqLVd1yTjWzm4T+7ubMqxXGaXLoYsD4QdIBTbjTZBYyuCKPkw==
X-Received: by 2002:a05:600c:3f07:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45868d80dd4mr72372095e9.30.1753365391122;
        Thu, 24 Jul 2025 06:56:31 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 10/29] panic: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:53 +0300
Message-ID: <20250724135512.518487-11-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - tainted_mask
 - taint_flags

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index ccee04378d2e..fb561a2fdb59 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 #include <linux/sys_info.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
+#include <linux/kmemdump.h>
 
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -56,6 +57,7 @@ static unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
+KMEMDUMP_VAR_CORE(tainted_mask, sizeof(tainted_mask));
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -601,6 +603,8 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(FWCTL,			'J', ' ', true),
 };
 
+KMEMDUMP_VAR_CORE(taint_flags, sizeof(taint_flags));
+
 #undef TAINT_FLAG
 
 static void print_tainted_seq(struct seq_buf *s, bool verbose)
-- 
2.43.0


