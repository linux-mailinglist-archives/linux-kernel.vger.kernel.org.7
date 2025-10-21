Return-Path: <linux-kernel+bounces-863227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C52E8BF74B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2933A4E4CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC52236FA;
	Tue, 21 Oct 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ4FxT6w"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF90355057
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060185; cv=none; b=K61oEKVTKN0/yEElRZZ7O3Y6Z+eCoCUMIbw/xGMGuxMt9C3P5+nNKwbfDCqSR8y6/dF2NRHkfQWO0N1Qcm5PiJ+CFkG9oKHO2BmPOu4NstR+vZaBSIZAOt8KmMksMkfcy3Ew1IRWO3gFjMzDngHjtRb/pNXGFhmywiGtWTkkFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060185; c=relaxed/simple;
	bh=GQ3ckhum8IdvzzEfZpff72BYrgiczqI0CxjLSfyEQoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APegdcqpXo4/G6iXfHFg6R79ewnXc9KtOJeFSgJ2Ia5R0eMfL817OHchC+eEqONkJkaSpVxcui5Ywi63O8cPM0v/tBpI270xMUjsuUlZGdVQM6TmGxHEI+szgYRPnqtAZHceuZyXFIYbAyxYFBPqfKkUA+/68qf0SsVksl9EGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ4FxT6w; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b48d8deaef9so1122290866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761060182; x=1761664982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMVheGalK8FFbFn0JWrh/VoA/5vQNhUL74QB4lSqKMU=;
        b=eZ4FxT6w997rHUrczmVrUqNk53JNKCSsVVt6mIb38l8yw+Gu78DVMlREwo73z5czyZ
         DFltY+qFFM0lAFyqbl+aBx0zN2bTUOuyzlXu2zVji+dTZXDggxv+L9234z/IgMT6wLYq
         MjCmgsR0FvTFR1QqKNXQX9oKjoOkpwNhRbXfid6qJ7LrD+RW5sZ2+NlEYtP8ojA4ENRp
         6Mvj+VB4W5zbYsxiRNv7rFw0e+4AhjG6bHDQVZdogo3oPtqLF9MH/SdZGEQqRZy0AOnG
         OfnLoK3zfKu8ZQI3XRIHeuyOK6tQL/YjQ4mjPUwcGGBLS666GRCsPOByWQESkStzOVqX
         oo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060182; x=1761664982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMVheGalK8FFbFn0JWrh/VoA/5vQNhUL74QB4lSqKMU=;
        b=CUywI/0pPkv+KOWRJIvfWka9FFc65RTFTNL4No9PKI3vfCMcxIV44+qr/mng0lqFg4
         sIjHpT4JrqRViW1Lo0b+pMEx28zb2zz2tA7e+hAAbF9QbTYobQ3G1gP/+Fcmo6gLyFFF
         7YkttP2bktAH86ewjKWHRV6EbGdgV9XeNyemXWCVkpku7E+1IZK8ko2rDdOmVHFirKyR
         hmMfIReA2ZMP8KIzHEzeXWPhTfaBG6P6ETEBI7F3vQbBcgSuYhCMCoCIUXAyaDeVhcJH
         IEF+fi4n+co8uzUXXoQI/15EXj4norXuoWv946GJIEBI63eJoTEo5WXei4vAkv1igkch
         RNGA==
X-Forwarded-Encrypted: i=1; AJvYcCVhPqVXLqBJg4eQ75tz66Pbe5UAk/Wz2w2qWpYPhpHSk1p3VnGmJNzJZoznglDc7iqGJm0REhjTfFprUAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxskHWIAAasy2QXzYMmRhYnSI7GTLAv6z8lj6/lnSPBfbegsoDo
	mYhIWN/a6lX3TAaE1IR3Ry0zyqluj49T+1jgnm43dwgWVSVwZlTVD1ZY
X-Gm-Gg: ASbGncuZHzMVW/jrMt9KGqZTGSKzrtOzhpKB253UtjQc05s1T7JrUD71JJ4PrLilRZi
	zbJYFKB0TVPY1XeAIStBalS7RKg40qzEnkeEWY2mTslLOGqZXazfOUoo4lkElF2lX9POkAV64uP
	PBBwYUkPG6hp8OIeE4Djo05NEnHSnT+PM1lshFVwxz5buiv/AIbELH+0hLOQlYXm22XJMEHouUA
	hqOih9Nlveah8TdDSrSX/MaWFO64ypqFL9aTxV3jcxWJ4qDKCybHhdP0fIAuEqKW2joI4ps+vMO
	EQYuSAbLwAxmFQwerxSvomntiW1qoM1OX4IZlw/wkvKRTiM5zzZCrpSMHosHGO5tOTgos6hfFxc
	o7SJqydE+BXSdL/tL0Z3oGp4/UrUD2/WMSRvCSZ596q1d4Zme2ZLYvRvIyeD35JlONV2Bk3XgfO
	prfiLkHxhuxLemBAXjgEALk0yvjkIlT/ZrQN7Iwg==
X-Google-Smtp-Source: AGHT+IFjAc5AXcoHcQ988nnPs6wGFM+kl8yEEIE8fwdc9oeO900YlPPXdG3f/j1Bm9ul8xq81jy+LQ==
X-Received: by 2002:a17:906:fd87:b0:b07:c5b1:b129 with SMTP id a640c23a62f3a-b647195b8c3mr2176066166b.1.1761060181709;
        Tue, 21 Oct 2025 08:23:01 -0700 (PDT)
Received: from tearch (pc142.ds2-s.us.edu.pl. [155.158.56.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm1082737866b.31.2025.10.21.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:23:01 -0700 (PDT)
From: muhammed.efecetin.67@gmail.com
X-Google-Original-From: muhammed.efecetin67@gmail.com
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	lee@kernel.org,
	rafael@kernel.org,
	efectn@protonmail.com,
	daniel.lezcano@linaro.org
Subject: [PATCH v3 0/5] Add Khadas MCU and fan control support for Khadas Edge 2
Date: Tue, 21 Oct 2025 17:22:40 +0200
Message-ID: <cover.1761059314.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

This patch series adds support for the Khadas MCU and fan control for Khadas Edge 2 board.

The first patch updates the device tree bindings to add new "khadas,mcu-edge2" compatible for Khadas Edge 2.
The second mfd patch removes unused nvmem code.
The third patch adds the Khadas Edge 2 registers to the mfd driver.
The fourth patch adds support for Khadas Edge 2's new fan control registers to MCU thermal driver and the last one adds the Khadas Edge 2 device tree node for the MCU and fan control.
And the final patch adds the Khadas Edge 2 device tree node for the MCU and fan control.

Changes in v3:
- Renamed the compatible "khadas,mcu-v2" to "khadas,mcu-edge2" for Khadas Edge 2.
- Renamed KHADAS_MCU_V2 registers prefix to KHADAS_MCU_EDGE2.
- Used of_device_get_match_data instead of of_device_is_compatible to identify the MCU variant.

Changes in v2:
- Added a new compatible "khadas,mcu-v2" for Khadas Edge 2 instead of cooling-levels property in old variant.
- Added Khadas Edge 2 registers with KHADAS_MCU_EDGE2 prefix.

Muhammed Efe Cetin (5):
  dt-bindings: mfd: khadas-mcu: add new compatible for Khadas Edge 2
  mfd: khadas-mcu: drop unused nvmem code
  mfd: add Khadas Edge 2 registers to khadas-mcu.
  thermal: khadas_mcu_fan: add support for Khadas Edge 2
  arm64: dts: rockchip: add Khadas MCU and fan control nodes

 .../devicetree/bindings/mfd/khadas,mcu.yaml   |  5 +-
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 58 +++++++++++++++++++
 drivers/mfd/khadas-mcu.c                      | 58 ++++++++++++++-----
 drivers/thermal/khadas_mcu_fan.c              | 20 +++++--
 include/linux/mfd/khadas-mcu.h                | 32 ++++++++++
 5 files changed, 153 insertions(+), 20 deletions(-)

-- 
2.51.1.dirty


