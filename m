Return-Path: <linux-kernel+bounces-889286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF644C3D2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6262135238A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16642357727;
	Thu,  6 Nov 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQqMdFnZ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E43570D4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456108; cv=none; b=Yh1ECEn43Hzo4pF9lg92G+tvNwaob0jas+tOc60SxaCrRWxRNlzlPhZvjKIeF0Ck7+hZYa3CMlEJ/y5WBu7Iewd3WAPTa6M+ihB1Y28gZC7J2vQDcxu4pj/7rFQh0UbeVuOw+FMKZOLqUmX+ILOfPZh07wojShJAAWynUVKV218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456108; c=relaxed/simple;
	bh=mMs+/htGtXYGsIA71gg7FmYxj0Ux55LRPjq4c7c7iAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/JYZpm9klxUAIVaBOslaDmOwRfOKErcm/0/zrYEeMOQi/75GKp5DglD6BFpZzLtr9NUfKCpGfXxSf8v0XL0+kJpH6YMwG5iO9OO8JONNiLZ0h945gwjBvPVZQHcq9PXTmDbpgC31miUxNdLdBIMnpRBTamolzU+t84LPIfY4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aQqMdFnZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640ef45546cso232193a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456104; x=1763060904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBDauKoKfPD4CnZZWtWcSb53n04sjO6bQK2uW89yUaA=;
        b=aQqMdFnZ/EDbn5WdteambA+Xc3GQlyI8b7m8ylszwSPejK+NiQFn7rcT+7F24nrY/H
         5fzrZKogx9kbUl6gwFkr5vQZzq66EfoB82318oCRTbWOmt7gQu8Wii70ZcEfOfn7krES
         XM8j7l0WEa2tACzmLoeDIKMWSu2bUaRaz3RB/h7cS2vAkgQ3dK3H6e3RFnXSYBfDR3lS
         OYtBw4QHPF7r5yCyXY56UTk37K4UiC+rYNqMHhHmyRJYhXBZ6N3tMAjS7DE+ShBBZs7V
         nnDiGh4m+bC5D5Wa9UrSeQpKVgIPu3HRDGJywX6an6ET8UQg43BnhDIYIhAtDFsdx9a5
         7IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456104; x=1763060904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PBDauKoKfPD4CnZZWtWcSb53n04sjO6bQK2uW89yUaA=;
        b=FBTBI7OmHnj0dKN9xPIsPG2oMfcd2SSgLcR56EdO3HvNQ02mxbAz4NDd5pe4hnm1+t
         VW6VtvMjLEHcR1rGzpNwEm0nVjm7TwtbvhwNSY/l90+OQXq5qFD5crIwmcYjvKL3wiuS
         8IHxGIv3IKLgcl3QySSQYxs2pi8aHOnn5tc1ZmvQc/qICe7/fm6uL9jkxkxuJGzzBk4z
         mZcYzeUYMLIUZTMf4MIYqkREUufePT4l8zm5yIh7RcM3ZPCusK1riQDBX33PquRTCLrC
         9TLxEHXNMlKHwGAJozfu2+//ExNn67az0uaAh3V/JjWAw1G6mbk8DL04AODwjAIZ02UV
         jZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVq3sFd4t30F5J2jWx4KIX2cF+ss0OGrylZgw4jyW7eDzDzUAzl4Z0u/NdVVvau4JtKvH+mcj5pIcux0Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTskY103//r1pymkCIzio5J2AAZpoT1Rhv3GLY2jf069AFAAZW
	S/vKJaWW22NzFaAqFlJDEBLKh26quf/5W/biHTMZ3CVJspdhHbxGf6R148FtGAp6z4I=
X-Gm-Gg: ASbGncsCxNrzigmp9i8HB3fCoW5jNza9FPscPyvIslGYf9rbv6qfBv+YMaZXa1uKZDk
	uWk8gJYuUUacxhmS0JBxoTFbN6wtw+nnyGHaOxyRtLHKT4/szyvcqBBlxntpDH2Xy7UyI7mu8mv
	QJuOzO+qpuMIyz/6dxGUJdNnMPMdLKPt9a4ozlIhywhB2POwOEuaelK/4L3K7Qc0mnhfhytxMZd
	JcDrRgMWFIjzDncZFrKqQDymcVQ/b56oyhBPvsnCgSvc32hldS7MSq/HRmnlngRdirOqCPJKpx8
	EPp5nlifu0uGrhlMi4S6D5M6kQuIgvlA4IbkTfz+VuN4QOX8q6VP/V3tG/0DFzQZ8fVWJfzg0ea
	amvbQ8W8ORM1A9nkTarajDz9fQjxyk2P14inFWjdq0XcLeo40JHaEWZn6Rv6B/b8ART0F+pALKc
	vRPbOJbliPRHDqRD9CH4FzXb5R3lU=
X-Google-Smtp-Source: AGHT+IG+hyJMTcEGj5iy777lLiyM71Dn2jw/AE3Pf8p7sH3RSp5ANpEt8SWqIzbEh+pnzhio1EyGSQ==
X-Received: by 2002:a17:907:6ea0:b0:b70:bb39:6f34 with SMTP id a640c23a62f3a-b72c085cb83mr16365766b.1.1762456104130;
        Thu, 06 Nov 2025 11:08:24 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 20:07:14 +0100
Subject: [PATCH 07/13] firmware: qcom: scm: Simplify with
 of_machine_device_match()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-b4-of-match-matchine-data-v1-7-d780ea1780c2@linaro.org>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=mMs+/htGtXYGsIA71gg7FmYxj0Ux55LRPjq4c7c7iAM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPIPnieH16c8d60rwZIiX6haowTgQtMDdTNgc
 Nt9m3EGIpqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyDwAKCRDBN2bmhouD
 15MND/9iEN4qP+PowaIfKdmRXiKRnNXohM8G8jgJAet6APPR2LlkfxfOSySgRZDLKCKTj6THV0b
 7S1uNUEDLipfAfqOyb2ES/O3p5hOdH+NaiNLbJNFfvKNEVsn1979VTOkhpl0yR8E/eLVMk6Rb4v
 3BjFCTTZSlOxYovGcx2SaB8PFO7Mb0UJEj9+6dJqeF+WyC1jWN89UziF9Aa9kShSX7nhipdwh3e
 ZvzDbpiCfcqIJ1oAWBlOLSkYTWAVyHAxnH07HvL+u3MaiynTgwewgye1+rFCFDZXCord4VxYgJi
 r/pAXsBB7P8GdbQ/0tzWWixP0N5XIW+p1fW23ZI7sp7IeSI/y8IOHHtzb3RfzN5z0cL89NB31Ld
 ZMzeoYy4VMqJsWvzxzO5H04KoDvuG8++JeHBB7TFbaBpwfMXXF/fhWawgvSGfvGlQVMHPkvwQzT
 pm/KFaHtPyRmeKO7mf/wyxYMOHlJWUFo5HgpPwzSKC/wTylBSMjmlVio4ZGFJeLMvA1hFqKE1md
 ncgtRPz3+HXM4i3pKZ1yCq3ECTajGjpZ/G0S8kFfY7AEKZlPseRRXMisGjDhnEibdRTOVnsmjBs
 vG5FsRPbRPg/s0BYkgUIUEREnc9tP+jJ3rCqmA4Bd4DOr284xpS3Rd+NkltT1CfIkfO1IRPgHtH
 WEqN666U3/TfL2Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node and matching against it with
new of_machine_device_match() helper.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first OF patch.
---
 drivers/firmware/qcom/qcom_scm.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index e777b7cb9b12..1a6f85e463e0 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2018,21 +2018,6 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ }
 };
 
-static bool qcom_scm_qseecom_machine_is_allowed(void)
-{
-	struct device_node *np;
-	bool match;
-
-	np = of_find_node_by_path("/");
-	if (!np)
-		return false;
-
-	match = of_match_node(qcom_scm_qseecom_allowlist, np);
-	of_node_put(np);
-
-	return match;
-}
-
 static void qcom_scm_qseecom_free(void *data)
 {
 	struct platform_device *qseecom_dev = data;
@@ -2064,7 +2049,7 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
 
-	if (!qcom_scm_qseecom_machine_is_allowed()) {
+	if (!of_machine_device_match(qcom_scm_qseecom_allowlist)) {
 		dev_info(scm->dev, "qseecom: untested machine, skipping\n");
 		return 0;
 	}

-- 
2.48.1


