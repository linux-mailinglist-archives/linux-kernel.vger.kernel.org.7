Return-Path: <linux-kernel+bounces-733524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCE0B075C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3AC3BCA0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1182F50BB;
	Wed, 16 Jul 2025 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFUkxBhg"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC02F5C40
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669231; cv=none; b=m4xmjxJ5CxnYKvxS/3EH9A7BzdDheqTnPjyM8MAGvpr3+BlaHrqyY2QY3DGoZ9w/Z21TSu+gLfE7TKMZqQn+oDhdNFx3VlTeS+uQlRmNiWBUfczydLpgxEUTzOqaDz3bO+g23dcsaqfsTNmBNiXwonloSF/6QReMEJNxJuw015A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669231; c=relaxed/simple;
	bh=l66YMhhyoUq/kOfTDxnT5FpNrTVvUcvvqXdHjhPBswk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQ/64DRVRPUumhsr2YDqXH5ZB9MOPEgkLQlcq3x9enbOR3TR0WH4KXTOPgQT1WQ+e6GKhFdfcETmPlvnjfljReAHxIWXCPNaITHizwJ0cn24nVAQ0cOLJiyIqMT2/1LXfC8mOmiMUr/XmCVT0OHuDxxuyJSXwxxds9sMDDLsCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aFUkxBhg; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso58551171fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752669227; x=1753274027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORFGIaRZiQ2r3h2UbbHLjv8bRy43CZUiObx53cFsM7M=;
        b=aFUkxBhgTyF/UQHnbpmfylEUNpw02hm8LMViJ5VkKE6YZQMU6IYkJc/8l4MM00W2sv
         I7eVY1GehR9QwVAEmlgTTtWam1bhjuTSIPt6qxtO3wcEEF7bm1LhQJoXxY3lIbRD2Pke
         ogXd6mJWED68dK0X2OMorVo21WH+J8+lBf2a+WRNhO1Vg6gNBFFkJWjjjmIBcT/lXI58
         k8Cb+od2DMnbW2cQCyVhJRZz3CvUN1GCWWt71zUXKtDtTTsg3IT6Oey5S9PbVuotuZSt
         hXzDwY3EUudpXw/Dt74oQ0BefwtJH8vqH1kZidJvsSHkwbKGafjjX8NXaLoVdQ5o2cMC
         j4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669227; x=1753274027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORFGIaRZiQ2r3h2UbbHLjv8bRy43CZUiObx53cFsM7M=;
        b=hbpsKHQ/IvSzkaLnCme372E3t9nlIgHwUlGV71REeYQ1NF6QAwq8vE44HacDE8cRlT
         88A1My8/Uchct+kEa8AE+HPgrZ3Yl40hYcdemTb2OK0PWwnb71qF4PkziiKVCILVGXoF
         lfsTN9hLvrtXKBTiEwC8LuHcy9rBDN4HlHszfb7IAyBZXamUV4/jtGcbmsNBhG5u0u+9
         eqJKGgGudCFZRCoshXcYUvWdEybPOqZYRx7128DE3Z0VCZZu4p5p3BeHNLHIKskzrqYP
         +cCFT4Z2cJimVqI5n0PdlI+9SXm9pwY0JlE40kbj2UVQb9nXYY2d8EDazmWBkKwFAHCe
         R6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVubPnPW2utgU5IDTebLwcDzJRH/d7HKAb4+tMurT3abzQwCMEo1cA7R7mk0y8IImyVbNI16HtZxS7GcU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65BZqly9FfeGbMARTWILLgwpaG5Ah2taxa6xlbNp6EQADLrcW
	NFhP2o2fdx/dIAR84Nyl93E3PXChKfDd8IDjleFD5a93Ue9yzL9UxxqsCohGwJyTa9g=
X-Gm-Gg: ASbGncu8VLbN+CwueKeaMuhjJn25abXtyiLWK41LOfMJC7Aa+/PLrOapyrR7PqhHmOM
	BWABeW8wrigdFWDv/w76LqfmYjb0GCkK6F/B0TCR2nASQN95IQcLPsl5l4aCrGhQgBaVOa/Wkc1
	tcPG7n8xs7MOABUqIsj84vJWXN1aWIdmE/vyVEu2kRDJSEkYRYkeuSGIS3M0zuGlEUEIReqIYzC
	F3/MnD04JDtyNc5kV39dqggQiPfGLpdSKe2Lg4oxyrFiDiHOS4JOEfFHvJxu2t/Zz7AGkFW+2t5
	F7lolzv4B5d7zba4amvyT8S/02YQyCC3vhZdTbLQwqItxeagg13GKcXsYu3O0ALTAsG+wTJ1zXh
	NWcI6hJ7cCrolCugwgxJBe1xIwq0yZi8Ib0VdpAaZCxnzKz9OONc0czLWEVahjPLU8+KK38fP
X-Google-Smtp-Source: AGHT+IHApt9dKWWo4VZfdfPAEXf4QKxQRQ/nikIwYXMJa5THXkanpElGwpOalL+3xkUK7ywi2MDTCw==
X-Received: by 2002:a05:651c:1a0a:b0:32a:8297:54c9 with SMTP id 38308e7fff4ca-3308e34fc82mr10139451fa.8.1752669227417;
        Wed, 16 Jul 2025 05:33:47 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134d4sm21136211fa.22.2025.07.16.05.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:46 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 3/3] cpuidle: Respect the system-wakeup QoS limit for s2idle
Date: Wed, 16 Jul 2025 14:33:19 +0200
Message-ID: <20250716123323.65441-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716123323.65441-1-ulf.hansson@linaro.org>
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A system-wakeup QoS limit may have been requested by user-space. To avoid
entering a too deep state during s2idle, let's start to take into account
the QoS limit when selecting a suitable low-power-state.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0835da449db8..5f6dacb5b134 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -190,14 +190,15 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
  */
 int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
+	u64 constraint_ns = system_wakeup_latency_qos_limit() * NSEC_PER_USEC;
 	int index;
 
 	/*
-	 * Find the deepest state with ->enter_s2idle present, which guarantees
-	 * that interrupts won't be enabled when it exits and allows the tick to
-	 * be frozen safely.
+	 * Find the deepest state with ->enter_s2idle present that meets the
+	 * system-wakeup QoS limit, which guarantees that interrupts won't be
+	 * enabled when it exits and allows the tick to be frozen safely.
 	 */
-	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
+	index = find_deepest_state(drv, dev, constraint_ns, 0, true);
 	if (index > 0) {
 		enter_s2idle_proper(drv, dev, index);
 		local_irq_enable();
-- 
2.43.0


