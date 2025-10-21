Return-Path: <linux-kernel+bounces-862575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE79BF5A72
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A48A84E6DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96C2EBDD7;
	Tue, 21 Oct 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySx4ajmI"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B728261B75
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040490; cv=none; b=PiDLH/B7v2u19iBlhcskNa3U7zDHmEUBCSsIXGbHdwrJW+FdU5pDYsFQIx+dsl48cV6BX/MRbdDpOK9y25fvheGjeMz36LkJM1xlb5O3KZjdPaYUylsd7uEhRe6EhWepeg0Cc3nqokD7plWCN/rJ6lyNA8zBfPpEQhYnLz1VdlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040490; c=relaxed/simple;
	bh=r9mqtQbvHpUswv+RMdbgD3FsvcrUibcGXabhqOtDVoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UuhXgGYKd0DT15y0+ita5K8nvyjNNpwBuccyT+9pqNPMsVQxogMNGD27DXGAKA1ERiurSvuDKqnrE3IK3xgQOAiulr2rWGrmHTydW2sn7vxVudpSW9CiYmXExWteQNkh2gFLZXrxFO3KVrKoALeZH5qOx9QlcvIAuLXpMbgrGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ySx4ajmI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-427054641f0so791247f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761040486; x=1761645286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGJuDFRRuSHDHUNQgyFQLmeRV65OPg6adZAytCP4ys0=;
        b=ySx4ajmIEzPEFJ5cQ0bCBG9oZAwASpUuu4zEZMceSFJD/ii3ke7THN6Jhj6kcnqEuc
         k/QlPtt9d5EaAy1RiqUm/VNI+rDfft2CvzCjkXhzK8OiIzs17QqHTNV039BLIrb3fgFs
         6MASnF7F9EE9Kch56y+jtYqsU57nrZ1w/bW+oWqprMp9/uh7zlVAqmAgl6V90zK1m/Vi
         RkxuGdEnKBef6J0zKNNJRBLjtd2A9M+MuqAV3zJJsE6dNAvXr6AVk8DcbmmW8mDxKXn3
         BvBI3bx6LWVsJid24MXspKKfHP27BTc3y0C2FEzfreoUtOgbx1p0thQFOsiAzrgw/G3q
         gUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761040486; x=1761645286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGJuDFRRuSHDHUNQgyFQLmeRV65OPg6adZAytCP4ys0=;
        b=puwBhWkd6EFYujLDroKJ8i0S4cWNI3IzxIXYLjOAvFrzw8tgvz6j/jJkZI4cl9Oh5b
         IeJb1956cIEqmpvnmLsHkPysi2rLJNjxs91c37H8QdaXNjG1u7AxeqbKD6imS6BKK4m5
         fAiIXxwXAlFdu8IpM06viNHpy6Vtu+uSXmVI4V8ZnN79qM3fFEwIX4hRweTT7faDFOCF
         1rI4kN4KHdfw2P7vaEcHU8s0x/5zYEfSj+IYg/MjsET8yGBfgDGht97/RjfcbDg+53PJ
         goEWX3UJDlPCK6tspRRYZm8NoOakEKL/mx5cxJUG/5FWO/WwySQ5PxVriAerThw4ugoG
         r3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXFh6Lv7mI6YeyzKb2mOLBaPEcnIZYsvNJf86h2zycqfZoP9w464VEY5w7tUpF+//444x2YOT0VGRsOMuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3gdN5WJibrV+MNoqvbZ8w2k8fN5rLtwraMU7BAybX26YZ4Pt
	o2QOk+8rwH4LLRwq2H8Va0MHd9jPkc3+c+ffmhVMgDa81D5RtZE2itghWYWJdU93MEY=
X-Gm-Gg: ASbGncu2w/GSQUDcpQwM5moEzYChXH9hb57l6Ekl5wtNSusd51uy/dJ7ToHaRdDboNO
	fnbBR8NHgmJgnMVL1eFAg38c5qfzy5qOCF8OAVXqS6Jz3Tvw5l8jrpGGOQL1u8IBoffN3cO6wSK
	G+fLyVaZneQl6egE2dYbTUjyexm7jIgnRfumVIAZi2QqHIhGRzpp2+I82HY19pb5xMgaNZNMslj
	NOBD1zyyN+HZX7HoXcLL8uncP1mb3bydjFykaPTAIcD/Z8iiyqygAZ8TyTwDF8ced972oKh431O
	e3EZgTP9hwa4bvEvwwpxnnDfG9I8HmHuKDlUroCjyL6cCuAk/wxpdHBOflNSSmWoJ2Tl0IDHHAH
	ctatK3gFNKJvbHvuxvnA3tlcJstQNHXlKinfImkz1pcUIoQFLUcFsZQAl0nZF9Ps/F4Ipxcw2z+
	ywtLKsaZFUcz0OfHQE1tjOag==
X-Google-Smtp-Source: AGHT+IGWw71OlcYgXji+89JG5Sz0DKNTCPD0GYaCIpd2i/j7WhXpZlNWd4iMSirznEOwKDsUpO+ZUg==
X-Received: by 2002:a05:600c:6308:b0:45d:da49:c47d with SMTP id 5b1f17b1804b1-474941ec4b9mr10231385e9.0.1761040486310;
        Tue, 21 Oct 2025 02:54:46 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0febsm19491256f8f.6.2025.10.21.02.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:54:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] MAINTAINERS: Update Krzysztof Kozlowski's email
Date: Tue, 21 Oct 2025 11:54:25 +0200
Message-ID: <20251021095426.86549-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update Krzysztof Kozlowski's email address in mailmap to stay reachable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 8a19cb96f448..797eeb6aacab 100644
--- a/.mailmap
+++ b/.mailmap
@@ -435,6 +435,7 @@ Krishna Manikandan <quic_mkrishn@quicinc.com> <mkrishn@codeaurora.org>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Krzysztof Kozlowski <krzk@kernel.org> <krzysztof.kozlowski@canonical.com>
+Krzysztof Kozlowski <krzk@kernel.org> <krzysztof.kozlowski@linaro.org>
 Krzysztof Wilczyński <kwilczynski@kernel.org> <krzysztof.wilczynski@linux.com>
 Krzysztof Wilczyński <kwilczynski@kernel.org> <kw@linux.com>
 Kshitiz Godara <quic_kgodara@quicinc.com> <kgodara@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 04193ceb9365..13fed9ee260c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16196,7 +16196,7 @@ MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-B:	mailto:krzysztof.kozlowski@linaro.org
+B:	mailto:krzk@kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git
 F:	Documentation/devicetree/bindings/memory-controllers/
 F:	drivers/memory/
@@ -21165,7 +21165,7 @@ F:	Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
 F:	drivers/i2c/busses/i2c-qcom-cci.c
 
 QUALCOMM INTERCONNECT BWMON DRIVER
-M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
-- 
2.48.1


