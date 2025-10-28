Return-Path: <linux-kernel+bounces-873066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C272BC12F49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E891AA4C68
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED122EB10;
	Tue, 28 Oct 2025 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMuHqPz6"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE911713
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629578; cv=none; b=u9vpnF/ijKhJ/gPnijmwEmDL9BIRWgB4XOvkcinyGlG6Z5PyY1eHdW38KfI96P93SL34FYJ8wYmmpbZmzdKVsCClAoxCDjy+37is8SrZhxrMgwQ0I7OxscSaHAOpoy3cMi8rf0lgcC+OpGhY/Myh4unOidZxUQK92gdzdU9Ztf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629578; c=relaxed/simple;
	bh=e6JmMMCtHtaaPFxfG7T73rKv++Cw8zq2s3Ldv1lkxiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qm6rThOSYJnDtp4FShSK+VKqEQQqSuOYBtKFUORTp3XEFrjoHZMy5lsK/TIFozGp+/JUxqfOFpqBTkJDlRv6k5KnyOyhdtHXdw7CxbjroJ8H5YbJ9Ez3gwcHedqQW/Dkl9lF4GI+4nakwCXRWeUXOG6826wYsR/mQro1HPNjX9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMuHqPz6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so5464645a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761629576; x=1762234376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFRcv76ANZA3gzIrveFcs6ALPGGM1pUqXGSda8XF/1Q=;
        b=aMuHqPz6CWcjG0vd6+6xlV9jZj7ho8RS9LxTJF3PTcK4Lki4T5XIIBO8R6CEVjzAlz
         PIvxpdbHDuC2fDZ0XYduoWFPlZVt2GKZWOI18HN+/mLUGnPzloYpcJ/B/10lEWHv8V2U
         i/YSHrSVu7t0VeNw8vITlOeNcH9KBiS167Kmn8iLiYfCRGaPzwBM+PHLpJRzQ/VzJ40g
         pa/zAaojAOfb4ItYhnXUkn4AMsJdstIJFQJ6ManWbjTQ1mMiUXJjF280+QS+XC8f/tqL
         JMy/w7aLW3N2/SU9pceNT3z+WUDBuwF3++CKEstuhmbks6Ms5xO75nX4WMuA6hQ4pGxR
         DJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761629576; x=1762234376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFRcv76ANZA3gzIrveFcs6ALPGGM1pUqXGSda8XF/1Q=;
        b=DWnvT1vQjVvRsvaRP+gF0pkE3QMITiGCAIbIDxjjJmJejetCozw0400Om3zWROx6et
         bZG1ZFUe0tcphlhfAmFyRtGNAZcoHTZLQTqTh310yHEJGoEH4E0SJjyd4Vl8dmluMOz3
         89VNKTClB1Gipd6ALtBRn5ApKmODwLqbIvzwRCZuPtQmA/M+sv/3QrJ4VyaDi4uSJXY8
         pL+bkIrtqfUeoY38V2ZoTYmFCEAqMpBGlZHpIlxH+50nta9jEvu/QNLgrbTOpWBgsA24
         PmpDn7b8e1zizDIa+m+fFybaq27JHAugbCvrC9Yp9EYNPqKOTYGoNsHDYaHZWeDlXyIu
         tpgw==
X-Forwarded-Encrypted: i=1; AJvYcCXyE58Dcc1ijUy4SXJ57o+P4wagfhjF5sYXKropHBfODjNSvhe9mvVuKKXBmVFambMfeD/VcSxRccKoRj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+fdAzrT3Pq5WN348+9pFROx/OVf/A5pIvIMoYcyNHFz3yHvD
	nfB6hiUcuLxnzp8dKN3NnqMt9V+BFoU4HAn59zTxCUcmsYI0Zf1IQTsS
X-Gm-Gg: ASbGncv3jEJ4C3wl/V3lubKPcW4d2hSlgGiR3Tksb3e23MBTphsuMw+EpFW0fQDqevt
	EdXJVtmNT3MCsUrcZnNPXwK3visepGeEB+Y6GIBNL4G9yCLBC8wcrv52nc/MXSikdm63JaJw0fO
	4R4iiw7SuuYlHKHT22RBAjo8iNW+DgoC1IpZv7e+m1dKxLYQFI2aGCJGj6a64IE9OFpftzZtdyu
	p9luwkVdEPLA5dng82YGt3u9NiXV8ArDlU0IBDrx3QzqamQBS1BP5RW2H8bhcB53xfHshtrfNYM
	QQM8HOc0dBcj5VQKIxtNLkO7ZQuz7jhqZ0lNLEv0j28xnN3xVZh19JqHGFNn0VuTYrq/e6Xvcww
	yJYWJd9Vw/c/S/dxHhfMnqj7EWAMGXH9u1ZzepTXTp05aNpQejsuQWHq/PiGiPMX1HG3Fxzo9O2
	Zq5CZMBEtfR6BAo9+Tt34/wUDLun+QQ4Uw8M93
X-Google-Smtp-Source: AGHT+IFG71VLpRXivUpjZ9QwxZssTUJUowz4hMMBFJiOjnkSAnrre/m7rTDb71KnYjEdyq1Byr4CKQ==
X-Received: by 2002:a17:90b:1350:b0:33f:ebeb:d7ef with SMTP id 98e67ed59e1d1-34027c19552mr2900601a91.35.1761629576469;
        Mon, 27 Oct 2025 22:32:56 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70645fsm10649477a91.3.2025.10.27.22.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 22:32:56 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v4 0/2] Add Qualcomm Technologies, Inc. Talos EVK SMARC support 
Date: Tue, 28 Oct 2025 11:02:46 +0530
Message-Id: <20251028053248.723560-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patch series adds device tree binding and board support for the
Qualcomm Technologies, Inc. Talos EVK SMARC platform based on the
QCS615 SoC.

The first patch introduces the DT binding entry for the Talos EVK
SMARC board, and the second patch adds the corresponding DTS
files for the platform.

Note:
USB(usb_1_dwc3) supports host-only mode based on the switch SW1 on
the SoM, which is purely a hardware controlled as USB-ID and USB-VBUS
is not connected the switching cannot be handled from SW.
Hence from SW Host-only mode is supported on Linux boot up.

Changes in v4:
 - Updated product name to full form per Krzysztof’s feedback in
   dt-binding comment.
 - Hook up the ADV7535 DSI-to-HDMI bridge to base DTS file.
 - Add DP connector node and MDSS DisplayPort controller.
 - Added USB note in the cover letter for maintainers' awareness.

Changes in v3:
 - Addressed comments from Dmitry regarding USB1 `dr_mode` and 
   added a DTS comment.
 - No functional change in bindings file.

Changes in v2:
 - Renamed compatible to "qcom,talos-evk" (suggested by Dmitry/Bjorn)
 - Merged enum entry with existing `qcs615-ride` block (Krzysztof)
 - Fixed subject and commit message to use imperative mood.

Thanks,
Sudarshan

Sudarshan Shetty (2):
  dt-bindings: arm: qcom: talos-evk: Add QCS615 Talos EVK SMARC platform
  arm64: dts: qcom: talos-evk: Add support for QCS615 talos evk board

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi   | 442 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/talos-evk.dts        | 134 ++++++
 4 files changed, 578 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/talos-evk.dts

-- 
2.34.1


