Return-Path: <linux-kernel+bounces-824343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899FBB88BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428B6586856
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15BD2F5A2F;
	Fri, 19 Sep 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="vEoqylhK"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8D2F4A00
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275964; cv=none; b=AhBJC+w9ipumDf7m8o8nMihy4qFQQtRf7hssR4X9ekwHp0gHktPCVSK2hPdqr/gtG4eg9aLX7ctZ0yJUSu5dfhyM9UsHp1cmoDqOv5YBCbhTOA786gJAsBfDRaKUzSPub5Ln05RXwhcBCjSfA09rPyL8Otyhu/NUAAlbc0yCdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275964; c=relaxed/simple;
	bh=DzHjTfe+PvsMShionbNF9cKGgZXDYYuDcp3aGm7pFps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s0f3IcTmayY9eDLsHQUz2Y1i+3lrx1OalaX0juc1Tj2lZIe2sPSzILURXCdi+nOOxOmIOrcboK66PnfwjRHN7lXyG2BZOcAFGUdIkXRi6XxWS89wn+hq26VzOhplnSM6Z05Tb+c5iIZQQpvFm1xFp3jwxut6F5s863vovuq50os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=vEoqylhK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so3264135a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758275959; x=1758880759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skAcju7YKAn8s/A/GRR4ZrH/gmSwELGHRwczNOae0t8=;
        b=vEoqylhK3QJazf5NhrcZZt3WNxESyRdy3QXc0hxN6SGRoaxH3SNzqSmBa1JyVyq0DP
         mko20UlB9PDTJ2eosrlbF3FymXdOxdz7pgZO0I4QmttIYO5EtDBK+gqXI78gEeHR4PVL
         +qqtU/jZ1m6y/wfLsfe6/I6PQc1bFKh0iym8MpzEcIal8PjyBuxTvBEz2qfNqxmtgMZw
         Te/QECiym/Nd1OGb2iqcgZGFuI2BYeZ3ptR1lfnzXWZ55qHsOddu9hBci4kh2nFy4cBn
         739fSdi4roOOUYk5NNtQvuyA9VhRtgBI+G3uXFldoiDbYH9++6a/EBPLs2L+klDpgvA5
         ZOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275959; x=1758880759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skAcju7YKAn8s/A/GRR4ZrH/gmSwELGHRwczNOae0t8=;
        b=YxmSj+6jQgiOgbdFBnQTeNwsydkZjWJryV3+LNZtAm9z745pyH9ezs8JwLKh/84xW1
         cTnsAAMmiSNSr3jAA1bCqeySsC5TU57xsyk98aPDYnyd7OuR3t845Lu0p88A01o/1oFJ
         xLMTZ9BKjppnNtC6qpllqjTlbUV0w6AuhXtA1vAFYxlH5pLmGhiS9UmnvOZhGOjF+Y5A
         YkkUKPmSSf0c3F8OlHk9ughlukQxYi7ab+an2VgPg+WhFXo0IohruwhzVdu0mQs6QmTp
         BB3hBYOYOQ2ne+SBakvy4PIdzDj7djdCjTJ8NlBWn0CqcL3DncMePgNLNXjXNkXtmYXS
         hYSw==
X-Forwarded-Encrypted: i=1; AJvYcCUaLOC87CCQMnLv6OnyFDrdyazfOrVAERBI/o/yhqME/8mPdJ+EyQT9tdxro1S62EyrE4xABKudPcBUpVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx82DPHdtlLaK+jHpjR+IRbVYZd6jtAXUIX/6iiB6s/wa9PF6sY
	0TMKgqgpSDXjyFSRi+1li7ZIbEfBi9qXbpfQ3WXG3TZBYLRgJpQPg831CHVYqCWYn54=
X-Gm-Gg: ASbGncvGargSdesUUDo+1PyLP0RbEaF0uAKVDAuEkAO7BJDVfkXzOOTxWQh2eaeQJ+b
	p+L7jf/9ZeFFFidlLiaE54o6d+gJ2/OQelCk+dLaqi7Wr25JsFPLp/IXytCnNYRvIEPWE8M7uNz
	w8X3+TPx056fNcAL2s7Q1VAX/NJQEQUFOVj4HYVskNRF2+XeFznU/D5rZiHK+DQ7GM91xy4StBk
	vu8h88zEnNpq+kCki+lrzdgosPbaHowOnbV/wOlaz/shmj6qAk5GBLCgyGeeR8VBiBatNpa5pQQ
	zWAZjFUf1c3GpkpdQsRMojobmIvMySVHIFqWsvTLxSLJFjuiGjIbl41pdRGHpDrKL3SJsQW0EAW
	OlRPyCKO2RJJrj6OL21JNds65c9NesiQ/zGOL2QT12GtlQP06qioxhcqZ+ykIuYO7QRsynQ==
X-Google-Smtp-Source: AGHT+IGcg73bZYLri35zpeSxGcbf84lNjzcJ9lVXYFxYS+H77YE64UdSEUtkMOObdzMncpDcwGV+LA==
X-Received: by 2002:a05:6402:4590:b0:62f:af:60a0 with SMTP id 4fb4d7f45d1cf-62fc0ae770fmr2120994a12.28.1758275959086;
        Fri, 19 Sep 2025 02:59:19 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa6f03008sm2972107a12.7.2025.09.19.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:59:18 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 19 Sep 2025 11:57:23 +0200
Subject: [PATCH 1/3] dt-bindings: clock: dispcc-sm6350: Add MDSS_CORE &
 MDSS_RSCC resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-sm6350-mdss-reset-v1-1-48dcac917c73@fairphone.com>
References: <20250919-sm6350-mdss-reset-v1-0-48dcac917c73@fairphone.com>
In-Reply-To: <20250919-sm6350-mdss-reset-v1-0-48dcac917c73@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758275958; l=769;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=DzHjTfe+PvsMShionbNF9cKGgZXDYYuDcp3aGm7pFps=;
 b=9VFYR0Pqu1iH5ar5ZlAGzd8yitkjjLnajYHWb6JRqnUWIorerIbWE+NyUoFK9xsMG83xD7v2s
 JFGROYBycauB8OiG9vpOylV18dL8CshQCYTm9MAqYN8hlrRs+EK1Eh+
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the indexes for two resets inside the dispcc on SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 include/dt-bindings/clock/qcom,dispcc-sm6350.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,dispcc-sm6350.h b/include/dt-bindings/clock/qcom,dispcc-sm6350.h
index cb54aae2723e8f20ff3eebde3e15e862be750712..61426a80e620ac795b6f0ccda173654d7e47e59d 100644
--- a/include/dt-bindings/clock/qcom,dispcc-sm6350.h
+++ b/include/dt-bindings/clock/qcom,dispcc-sm6350.h
@@ -42,6 +42,10 @@
 #define DISP_CC_SLEEP_CLK			31
 #define DISP_CC_XO_CLK				32
 
+/* Resets */
+#define DISP_CC_MDSS_CORE_BCR			0
+#define DISP_CC_MDSS_RSCC_BCR			1
+
 /* GDSCs */
 #define MDSS_GDSC				0
 

-- 
2.51.0


