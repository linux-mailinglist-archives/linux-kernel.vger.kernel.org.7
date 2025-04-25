Return-Path: <linux-kernel+bounces-620677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD645A9CE10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 18:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B511C00004
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AD71AC42B;
	Fri, 25 Apr 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daNSzrZe"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567231A2391
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598321; cv=none; b=UHh9P7Ic/TNG3gCNiYqUpKUEByVNAz+10i+7r8QXx0S4UGgpv5aeCGygfXRgAyuRIJG/pVmwdaICPHJ2MF8AgB/6MuhwhMgUzPQWQ3tW+LEfnyl2xtnOeBoALNNizBzXlJi4UzMG3jW+JslWekIdOD4bR4rGM5yl7ZxkjvM0Qls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598321; c=relaxed/simple;
	bh=jDESTeGPU9MDLye30mmLZd33SKlSNdN1HChVExfA0Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7QrrXlD4o4ZEaoxn2c1rt0XAdBBveOa4uhqgDgIeGcaAXfQuLP7j+2RwUDY92Q5Hh1F/YlP8NNNsKlOnRj9jMQciTb3xSIJsL+JjrR1rCAvuVLUh/3SWNSNBWmonXgbhVyUpexy1bqXz3O5OdVGQ29p9W4TAVQ6vX60/IbX47w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=daNSzrZe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso16652145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745598317; x=1746203117; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4FZgopI4ZxsIka7o03SUx90lerW1gBB6Q7kNKaQ7xs=;
        b=daNSzrZeNdoxSONUW97WI+JGlpl8HJnO6R+p85fhUuo1qFCqD+f+6vzWEOvVNMTXSW
         NoPBAtgBzIDfxTB1RfgUFhIu89cKZqxjlK8cNgqbAabmPAwtAWB586WrdaUwaFbsLgKT
         YcqmZDnaXPSg/izyJh3X15EGGzAhs0rKD94Q+yl7g/opkqO3KxQIbSJPkpeqe3UsiqCw
         0gm/TkMeV6yvcFOqCCSwqigI61/h49JoKeSbMOAb+lqZYgr2OfKA1hPyB3zXz/X62AEG
         ztVuQ4jR4o17qCbVNb3GumHjA9FoFElmWvp0qGD+5zfaSuHRG4D6bdkC9HM9z2OxbzhB
         9t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745598317; x=1746203117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4FZgopI4ZxsIka7o03SUx90lerW1gBB6Q7kNKaQ7xs=;
        b=Mj7gn1KhtV2iLrW2LPBuK+UOKryYLG9V7LPf67bcHjjA198b5dnSLCJfqRW/kJQxAX
         5Z7RUnzxrYVlNHUBnA+u9137JLZVGK0F3t+arSDbjOJFT4qBaZB5oRMObEMJ4PNtZuAH
         4EUMqB892W5HBj20LjsiTLwROxW4TWKmEoruACscuepnRzzuOjrqguUx0fLcltMSCn54
         5o1EYjWvT+RihR4rtdyRP+XQEbG+DU+V1HVtlw3LN19nbsR1j/tHXBz09pCqfRsyl++j
         G/kaOAamWNk6wy6f6laM4pmreUM2xJ9i1dL4ZIoU/4dX8NU0pDGG+EzHTydWNTcsiTRt
         +yGg==
X-Forwarded-Encrypted: i=1; AJvYcCVmQhimbj5/r226FG4P2B/WW3OTnr/95YNnkSHDsHOy9YEcX41xlh21qJjwGQpxMpHSFGJKbbTcxzforoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXz6PoaUnQmpgbTIbivzUFT5GZp2KI+d2czXofw9mpfoKCbP1u
	rjxT87+5YBAIMH7Xer8QYw7aM+47Um9kroFtGDZltsoBZRbZxdla9IMhBWvttUM=
X-Gm-Gg: ASbGnctIdRpg31yGmhxdBgrG3PacuD5np2Kny82IdNh8CxFCYnvr39M/INQoDjk2ocl
	2oDH3v9Vjs+q4jPjaIevpDjJctvWix3ONeYBGDfRgudJxQskFa5TCVPGnkkUPS0jqWp73QpZLg8
	jLWNJivmwWOEZxT3q57O0SSvV034cYRKpG0vsF52wCAjq5dl4V0XgIu9sniUw9uZxoTMTYM6CmX
	7r0lVyRsM/4MTruyC/WS4Qr3iPErGttH+KDrhpDhAjtDeA+jZ7hmUpO4w23nu2NZK1bxdwpu2tP
	lEgd5Bczw/8iXBojSP42nj4T8mnIhITBShDEeAJsD3gTRvwNziyTH3jtOowP0FyQcWFmohmL
X-Google-Smtp-Source: AGHT+IE7ewBSCz6dzufilKElwVeNyis72holw0eLHnudpdGIGazAAFQ1AmdNEkWTEecjXbBaejzS3Q==
X-Received: by 2002:a05:600c:3b21:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-4409c454190mr75445305e9.3.1745598317573;
        Fri, 25 Apr 2025 09:25:17 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d8976sm61263715e9.27.2025.04.25.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:25:17 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 25 Apr 2025 17:25:08 +0100
Subject: [PATCH v2 4/5] arm64: dts: exynos: gs101: add pmu-intr-gen syscon
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v2-4-f1530de9da42@linaro.org>
References: <20250425-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v2-0-f1530de9da42@linaro.org>
In-Reply-To: <20250425-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v2-0-f1530de9da42@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=jDESTeGPU9MDLye30mmLZd33SKlSNdN1HChVExfA0Ho=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBoC7dmiFG7JA9zR4w4g8O+Mf3kIA2ug0OV3qoly
 RerRUrFIeGJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaAu3ZgAKCRDO6LjWAjRy
 uuLFEACboyto09agjXazlVIPElvgbIw/iF+OL/uSZAjKui7VXiW8ji4ucUcGMwBJYiW3/txfy++
 HJXuHFc6rFsji0RVualvxQ/vSzhmLCvXxQUHi9YfmTlDMQ8WNtNeVZkV4UvXzfwFEbhOJlyvOU4
 YJZbS4neqerGs9C7IFj0u03iACJn39mc1f9r5yz6KDcvgDK1C9PY306Q9loyRj4V+nx+SH0x9WR
 zFz6257An3NMYIQUaabn+RFBbrWrTb093RARtNDrKn376Mj93e9RzvD7KaDCpZNiV/xFUGjtgNj
 iPQKx7CY9+IoKWdSiIH3MyXavtov3enz8VP2F6hcCBPVlPIQrFn3YjRPiWCrrudawPkEm8s7EIA
 shS+OuiTssGF05d5yUCp8ydlc1OjSYHZFc5aN9+pJKsjT4ICVs+WIr6M0UsOAvDCJ74fFAmbmq9
 E7QL99WqeCvQME3q0KPipGhUVY7hYgnOMb3tlY6yspCIMfV4ruK80Xmu8Z8kq4o2s7LtreJ2H9i
 p9rpHNFk29AXz+VgBFbFGkZpKesM6jBxZmZ4bhQfk5f2MmE0z5oM/HXtx80xC+NNPuTnoi22VGc
 PfRimPPExVI7uyyKnjWhLwIUgyHqtarbgcbUx2TfJzoLG4txMZ4sWkn9Dz9q1VGZ0HzGFw118Wk
 7ufrcVR12LHnfGQ==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Add syscon node for the PMU Interrupt Generation registers.

Additionally update the exynos-pmu node to provide a phandle
to pmu-intr-gen syscon.

These registers are required for CPU hotplug to be functional.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes since v1:
* Model pmu-intr-gen as it's own syscon (Krzysztof)
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 91cda7758020563b2c5b5768d8921e87b1f4231c..48c691fd0a3ae430b5d66b402610d23b72b144d7 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1405,6 +1405,7 @@ sysreg_apm: syscon@174204e0 {
 		pmu_system_controller: system-controller@17460000 {
 			compatible = "google,gs101-pmu", "syscon";
 			reg = <0x17460000 0x10000>;
+			google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
 
 			poweroff: syscon-poweroff {
 				compatible = "syscon-poweroff";
@@ -1434,6 +1435,11 @@ reboot-mode {
 			};
 		};
 
+		pmu_intr_gen: syscon@17470000 {
+			compatible = "google,gs101-pmu-intr-gen", "syscon";
+			reg = <0x17470000 0x10000>;
+		};
+
 		pinctrl_gpio_alive: pinctrl@174d0000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x174d0000 0x00001000>;

-- 
2.49.0.850.g28803427d3-goog


