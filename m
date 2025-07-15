Return-Path: <linux-kernel+bounces-731611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6997B05723
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BAF1C20980
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298A2D5427;
	Tue, 15 Jul 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+v8B6fV"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1033991
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573203; cv=none; b=YZY2BEuTQgXIBR/i5aTVvlAQja1Lhbh+g22qXFyib7yj65M0l/Rn9OK8Uimw5MvRzMf5vsSrcTaBttlmeYwtktXyz/O4oraPPDUFpCIyI+YAAzDy2gn/pnJAUFrYELCA48DTzUSWOmpDNUK+kUXhMZfVxBIXu1foUacJJDGuSPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573203; c=relaxed/simple;
	bh=hdNF87GV2fWePmslMU1NtQufudv4sfo++yaOq7Dlqlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+sh5cpYg3ehHIGUg3z7WvDW6x1a4q8XgrP9laVdWl4r2K24M3tWn8h6VDABsQ2VmBil2aNAmn5ZBy4KNSJuHFy1cvJUmVKdUV45uoh8he5gM8jg+Dr+AXM6TLoQqIm4lfSA7xO+QF3jDkjXQjcUcKCj5RofvGt7iiswJ8Rfslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e+v8B6fV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4f64cdc2dso761860f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752573199; x=1753177999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VQFCrQS+5bGchAPhyltjjz6iBpc703vtRLaUH4uJQU=;
        b=e+v8B6fVCNt8q/0zL7OXBEM4HvP72E3mjZlKqNf8Y5d/7psdx5ZczbhpBWbCX1tygl
         JheyJ5y4bO/G1oGhnL6bTost9TgR2DIPjNoVqK0Nk2PPQRWJUFRVMCAezx12YUNgn5CV
         IDgswM4qE/aUQ88tlXeQkZY43w7X1QQ1XeY2X7jGcw3G7lDA8IUh8rnQSC1C4AXed9r1
         WLedqKm9S+vK49S18PXOq5mGxXOsoUIee8/wUgufdmMed9MA2CgsO+JiAwImO/IHv45u
         xyB3gns5BCJHoanJW0Vwbvedbe6Yb82F81GKEtYfawx5V09Ifsg3NgnPNIXT0xgwYFAs
         ZyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573199; x=1753177999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VQFCrQS+5bGchAPhyltjjz6iBpc703vtRLaUH4uJQU=;
        b=RLWjOVggH4G+LjDAAgFB7q82Y05QiwInj6lj9rK6C+Yz3crLUEuRRjttcbtiJNVhZG
         zo4vsp0CmIE21gTkC/fyjleWjc5h67peNIo2H200Fxn2qRn/ImkuAYYC5ZIzzhL0mi8/
         I9cI1kvTUcRTxdDBKOQMeyGmsWDB9sYcJxkSsXU3+0SoCJTCvoogDdm+Gn3RpmSVPEh1
         3CRDY+TqPEHZ0aH0B/AqkZ2a5+Nfpa6z/fjey1uEaOpgcocrS8DZuuk+0rZR9sq9NPPh
         8W54aVgo6sPTEo9YB/UpRLYLrYxAEBOF0nPZ3FS8/udBcwBIchScxUEqouLYT/2oErP8
         zQLg==
X-Forwarded-Encrypted: i=1; AJvYcCX2JITBC3O024PCv0kgZlLyz4vlXhKYqyqbgFJEsWaiAto66PnOStwH3qv0KSWk2oqggx+ixXYxEcQvo5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4e9PaR4hTxI1CGjzK+Sx70X67iM4EMq0xi5KgUFxI1J727eRg
	L4zA/1E1t6e3bJ4aUE5CaMU1C/l9Xbhxyt1uzqxUjY6rHaeVr2NGNHNMxz5fuHoWekY=
X-Gm-Gg: ASbGnct5XYXFgKainfiRyDh6Y4gsRAEQPgz0FccL6Xh6/l7qBm/vqPaovmf3rXEkXoI
	DGrr0RzPjtiRCiHpUV+epbgQcCiKh0M911ksKIOYlK1kqhFt/3+lAwKQy2PuWh6Lex+ZPDtF/9C
	Z2S8zLKhQ1HGsOImEKbwnvAdIUUiRj3OasZwJWjzv4dAdYmPIiPocu3IfV4mqydhyDmztBRQ6Hw
	fnfxYzNqyY6t6ijkm3UnYVTwAAc0ioiwcYkDoP8CTRisCXHo5WNB4Dz7gg8esFpT0vps045//2I
	mcHFg44qFF/x7WG4FYc0O5p3pM1rQTnFRHaA9CZkmjfFLOAjw/3935CX/tCVDfC+u56v/jCwwWZ
	GkYIgStbhQjCwzS+mre7dohArWGPFNscHne4=
X-Google-Smtp-Source: AGHT+IGs2CckTXIolbdnM6YkcGeVbCoECGd88RrOnR/Gtlb5TjwgUc93KCulizhEe3JrwuaSZK5Kwg==
X-Received: by 2002:a05:600c:3b88:b0:453:7011:fcdb with SMTP id 5b1f17b1804b1-45629127ce8mr4377775e9.1.1752573199432;
        Tue, 15 Jul 2025 02:53:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456114a417csm78548155e9.25.2025.07.15.02.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:53:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.17
Date: Tue, 15 Jul 2025 11:53:15 +0200
Message-ID: <20250715095315.59299-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=hdNF87GV2fWePmslMU1NtQufudv4sfo++yaOq7Dlqlk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBodiULNenkUQzM1iNZM10NYbU29gK+VYrKrcqI5
 bqU+sYZxmmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHYlCwAKCRDBN2bmhouD
 1+muD/wKwp0dL06Y4+v06hD2jgWUNk+0uO91jiBFPuDw8bI/Y4jbeJlAupBVow45cte6n2nTYdk
 gQrK1sUHtYff37PyuzZX6NSylw+aiZYHxS1zMvLtCERSxHdrIcqUSfvGekYRCp+pL3NVTrk8Jfd
 DG/2nXJt0eHZ45Y3KjwrgAwYOyoSqsj1TH0iY/gbaAOOZQB59x5EKNhcUD6GY/BS9VtJmQhEB00
 IUnaWplezZlGIW4v/5gh9BJaXJve32NYN6F9jKDznp50kMdWUoaDMnMmBjnQ4LNhrFo0XE2bKU7
 7ZWt6DRtyQReyRZHRf67lMlswn+ZHbc7h/sJAsgATBHn6l3BKNUENhWYoJc7LKGM1RIKd1Q6Pxx
 XZEx4vDDGlOcZS6Wj1FOWK0tN1L95+J+JoOTPm6YLJ/Cs/hk+PKBQpRcyIZ9L1wJrtyPEV7OIj5
 eAxgdgT2mRUnXCFxqh292qRWle+V4vXltrAtaVbkQ3gG8KxS6yNHYiiIq0wLCdQ6miOh9AhFKQf
 db8kct4PNZMahckb6Lqxs0xjB8TAXcOQF+WF/MuiDeRV0i7IHUXXqvnREDSNEFXJimfVGVybxeX
 SadcZMByUEfmicTKb5XbSF0AC2LoLQxSoRhuarMcDsihO+on4/UylTqDi6HhFEI7LAk2m+LS07b tVEZQgYXYsP/jdg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.17

for you to fetch changes up to 93a7aedc4cc4476da54ea45f3ed5308aabafef75:

  dt-bindings: memory: renesas,rzg3e-xspi: Document RZ/V2H(P) and RZ/V2N support (2025-07-09 20:23:59 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.17

1. Several cleanups: Use dev_fwnode() in OMAP GPMX, convert
   arm,pl172.txt DT bindings to DT schema, use
   syscon_regmap_lookup_by_phandle_args() wrapper, correct kerneldoc.

2. Mediatek MT8186 SMI: Extend hardware bandwidth limits to fix VENC
   hardware during stress testing.

3. Broadcom brcmstb_memc: Add additional fallback compatible and
   simplify device driver matching.  The change comes from Broadcom
   SoC maintainer (Florian Fainelli), thus its ABI impact is
   acknowledged.

----------------------------------------------------------------
Florian Fainelli (2):
      dt-bindings: memory-controller: Define fallback compatible
      memory: brcmstb_memc: Simplify compatible matching

Frank Li (1):
      dt-bindings: memory-controllers: convert arm,pl172.txt to yaml format

Friday Yang (1):
      memory: mtk-smi: Add ostd setting for mt8186

Jiri Slaby (SUSE) (1):
      memory: omap-gpmx: Use dev_fwnode()

Krzysztof Kozlowski (2):
      memory: emif: Add missing kerneldoc for lpmode
      memory: stm32_omm: Use syscon_regmap_lookup_by_phandle_args

Lad Prabhakar (1):
      dt-bindings: memory: renesas,rzg3e-xspi: Document RZ/V2H(P) and RZ/V2N support

 .../bindings/memory-controllers/arm,pl172.txt      | 127 ------------
 .../bindings/memory-controllers/arm,pl172.yaml     | 222 +++++++++++++++++++++
 .../memory-controllers/brcm,brcmstb-memc-ddr.yaml  |  54 +++--
 .../memory-controllers/renesas,rzg3e-xspi.yaml     |   9 +-
 drivers/memory/brcmstb_memc.c                      |  56 +-----
 drivers/memory/emif.c                              |   1 +
 drivers/memory/mtk-smi.c                           |  33 +++
 drivers/memory/omap-gpmc.c                         |   4 +-
 drivers/memory/stm32_omm.c                         |  21 +-
 9 files changed, 308 insertions(+), 219 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl172.yaml

