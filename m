Return-Path: <linux-kernel+bounces-850591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED92BD33E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E80B334BB10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56B307AFC;
	Mon, 13 Oct 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM1UaWHl"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1E26D4C1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362918; cv=none; b=t3fN8e9N/WvfO956HTU2TaZwh0N+R9U9DEIhdOVv0KFE9dCe7HPD85qmTSpxEsDK9M03dXU9y557B9MCeX68kHLvqrMP+ijxfgG6L3V+aNQp90I0kT2dqgWn7VDlCtC5gxJDDpZxBEl526v0PRGOYTVxthgS8CKhzx9Kl+laJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362918; c=relaxed/simple;
	bh=jofWWnwmoG4Nrm+u2R6rEX8xNv7yEnOjBBXdOGfBxTY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lca4n7O4rdZDIMPQV+MSW33yaWQzS/V0JIUNHtxiSzBqVTvEKJomkFXfrRnVutq+H9DWaWVa4/ghsp4RQ5WAPifGmGIGXmwFcW4CoxMclK2kiLdhIT+dhzx7EgwCfNozlEfyORPpzl4FyuOO6SD0euEdlqV5Y2PeML0l1Nv9tfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fM1UaWHl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso8437455a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760362915; x=1760967715; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pEYynqLlf97tqquz7gBzDn5fbpmeV4yt44zAz5u1qM=;
        b=fM1UaWHlRd14xskxqcqtIe14cA+6vlilfymhbso1USIylcJCulvX6eO7+T4tbHW4bb
         Yd9z1SApzDUU3I8noOmiFoyNMIBDfaYqzARyPXBjI2rqd+uoFElGWnMaRUKgUNWZLIXe
         yM8SO6CEjNfxwP7urgWoOZNiVHfFYTxt+nVUV41vWkSzbT5WBLgZa0oNiMcSmFGGmynd
         g1X5IaM7+1bs1JavpcyGbhPRNxO7gpbXoIMclo7iUzkNcdW7xustMTiyJIn72I2tcBxN
         PSZtzEdVKTWSuNByHYg/fMNFl+jsLVeDfl1PllsFo8JDSsHsh8Vsb4K46YCmQR2LSdWy
         u+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362915; x=1760967715;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pEYynqLlf97tqquz7gBzDn5fbpmeV4yt44zAz5u1qM=;
        b=HAdZBKvAKEBssSMETs0e+dBNztF8MwBMLpFUHrgnp1R3nzflfHq3oKi8L228E9TIMk
         +x9n8kRMFEa9X3jk8Bi5h6XlzEjDJoBYvoea87DoUrUIRoIZ5ADUcUpsaZuHqU8Vum89
         yWIr52BDEN8BLg1SHR573ZFAQz8IruAfYEWWyoCwULyoNV5iv/TzGK7dwEepZlfPOtOn
         d1GR4Pb17BL102VaH9C/TP6izFIWI3wVquVVzJutAwfrtk2dwwxN+Ljn7UkfS/lLMhW/
         Tb1qa56OQEgYM7Ot4WXFF3rx6bxwDJmxcUuADUVlTfjsnPsbtcdxRA8jXZYvUhVwJlZh
         0Vkg==
X-Forwarded-Encrypted: i=1; AJvYcCVGJKzpXJeBFTrpPY11DQGCDWgxpkV/3gdm5FO7sKyzAG4io0Q/ttfAIxyN/hmMmJ9TRVMcIbMHAGReSpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrOveucOTXGh+ip/PWxczCcpoypqegYCbJZNwDtoUhh1xYwkg
	0AX9EKNhL6herfLh1u7IJ6TUr7qnR3Fcs0P0lfyUUq9F+80VGV6fo3KR
X-Gm-Gg: ASbGncujmOHveRuPhNK/czemW1nsxO1sX4DX/NqeU5rn2HkONYE92fnrDu5mny/c7ay
	ZHF8DyBrK8bIwkxeb5MdVHQ1ZcogZPKcHP6nI+dj7XhH7vaPC6QJKMdpy7cNaPnV24+KkjJf2ab
	EoaFjh0iL9z0RwGKqAFJ51DSg3S0mBqOB7/9086iHGZn3g3xeMyhG6fZTXC/G5OhN66h2grqe8K
	p/6Dc8py/oyCecm6SjajC8idygwG/hJD5Xdx6zmNvMS0d7v5poweSjvMxJJ1eSr6o+cucwHVifU
	EGenh+l4rJG9ASSSMEVqxWPu0ZsLNf7wiRdrfbJnBhrzKPQTyVV/k6uO2n9msHTCROE0Kk9OvPE
	WdPOGAVPaEOeNrzwBVfix7qQg5PlMHqIHiMf8TNl0pSRbkMYcFKsFbdjJVsVdzb+rx+gaHq/ZTV
	lmv4DcJhK52iSdhAe7xRSav/8=
X-Google-Smtp-Source: AGHT+IGTniZJrYciFFYZBc7bF6mk7b3Np/gZ8mj4KDQqFogc0fSKiYX5xC7hJ7v63RRcAe0CRjZAKg==
X-Received: by 2002:a05:6402:50c6:b0:632:930c:ed60 with SMTP id 4fb4d7f45d1cf-639d5c57a9cmr18367424a12.30.1760362914853;
        Mon, 13 Oct 2025 06:41:54 -0700 (PDT)
Received: from tablet.my.domain (83.21.75.22.ipv4.supernova.orange.pl. [83.21.75.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c32249esm8729019a12.41.2025.10.13.06.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:41:53 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v7 0/7] clk: bcm: kona: Add bus clock support, bus clocks
 for BCM21664/BCM281xx
Date: Mon, 13 Oct 2025 15:41:47 +0200
Message-Id: <20251013-kona-bus-clock-v7-0-8f473d99ae19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJsB7WgC/2XOQW7DIBCF4atErEsFAx4gq96j6gLwkKAkpjKt1
 Sry3UssVbHs5Rvp+zV3VmnMVNnxcGcjTbnmMrRhXg4snv1wIp77thkI6ARI4JcyeB6+K4/XEi9
 cgzNEyZPTgjX0OVLKP0vw/aPtc65fZfxd+pN8XP9TuE1NkgtO1hjXG+Mxwdvp5vP1NZYbe6Qme
 HIl1I5D416hiugxGGe3XK253XHVeI8pdCFFFdBsuV5xuee68dRpLZGsApu2HJ/cyv3zuHCPqtc
 OhNdrPs/zH0h8yMqoAQAA
X-Change-ID: 20250212-kona-bus-clock-4297eefae940
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 phone-devel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=jofWWnwmoG4Nrm+u2R6rEX8xNv7yEnOjBBXdOGfBxTY=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBo7QGfsqDN//gqTt9R3qAwvz9aqyD+IazKsaM/t
 knYTxVTgLeJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaO0BnwAKCRCzu/ihE6BR
 aI39D/0X/eu+v0YEBQ0VmNui0QudP42X0o5jin/jjC4l4X2qk9bEyFuipLBEKShMoN5CDEQuK8V
 bnKcFkFtzfrAVHLAbS3MZeEtTaSnV+RGe72uuMIgWvN0HloBShTTvLPscfE6eqjFNjEHW5KL4Ir
 c2hidjnG8fM9YuITj2TECgcG/V0GMVAItCQmfonCSDSghJ4EkJhGGW7UXK2txDfeeHbukbopNt0
 xQPoCJj93OpDPADkXeBrm+vHPWVrvC9EDt8NSXf8ZVv6On0YYgcjDYPFsN1VgfbkXjZpWwnkHJA
 oJkg+dtKNCnbdyYcgfi4NvSTYYfpgNj9AZcaijsN0nzD7ep6bGmcJRjzbcI3nTwQUagfdys2WHG
 otC++HrlPcukmFX9awoCuCDwvHtXFxmXN54nQD1DUv7T5zohwHJw+wucfIOneEyx19B28e6jTFY
 4cDuQGs6X+9zKFr8tVD49njdwjtyCw9aXx/G6CFwOOSrQ6gIVaj3lmhJKiTt8Hlq+K54GTel2Gs
 En416gwixlgYjlSg0wkIZvImSVTe7n0HS2gZAkNNidKHDT8tJrV17CIM6meumFN6Qix2ifiG2XA
 01uG5sL5Yt7K5X0Nc10SbsgYY8pOem5KpOc3mYGerELAqODmicLitZsg6bTLDa/XZ7Ic70DAxIQ
 8CeferthCAFGRwg==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

This patchset does the following:

- Introduce support for bus clocks. These are fairly similar to
  peripheral clocks, but only implement policy, gate and hyst.

- Add matching bus clocks for BCM21664 and BCM281xx peripheral clocks
  and update device tree bindings to match.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v7:
- Drop DTS patches to make merging into the clock tree easier. They will be re-sent
  in a subsequent patchset.
- Link to v6: https://lore.kernel.org/r/20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com

Changes in v6:
- Rebase on v6.16
- Make kona_bus_clk_ops const, add a new commit to make kona_peri_clk_ops const as well
- Link to v5: https://lore.kernel.org/r/20250430-kona-bus-clock-v5-0-46766b28b93a@gmail.com/

Changes in v5:
- Pick up Reviewed-by trailer from Krzysztof on patch 3
- Rebase on v6.14
- No code changes since v4
- Link to v4: https://lore.kernel.org/r/20250318-kona-bus-clock-v4-0-f54416e8328f@gmail.com

Changes in v4:
- Rename moved CLOCK_COUNT defines to CLK_COUNT to avoid redefinition
- Squash BCM21664/BCM281xx bus clock DT bindings commits together
- Link to v3: https://lore.kernel.org/r/20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com

Changes in v3:
- Fix DT schema example in BCM281xx bus clock bindings
- Move CLOCK_COUNT defines from dt-bindings header to the driver
- Fix BCM21664 UARTBx_APB IDs being out of order compared to clock
  driver
- Link to v2: https://lore.kernel.org/r/20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com

Changes in v2:
- Drop prerequisite clock patch
- Move clock/bcm21664.h dt-bindings header change to dt-bindings patch
- Add BCM281xx bus clocks
- Link to v1: https://lore.kernel.org/r/20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com

---
Artur Weber (7):
      clk: bcm: kona: Move CLOCK_COUNT defines into the driver
      dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT defines from DT headers
      dt-bindings: clock: brcm,kona-ccu: Add BCM21664 and BCM281xx bus clocks
      clk: bcm: kona: Make kona_peri_clk_ops const
      clk: bcm: kona: Add support for bus clocks
      clk: bcm21664: Add corresponding bus clocks for peripheral clocks
      clk: bcm281xx: Add corresponding bus clocks for peripheral clocks

 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  49 ++++++-
 drivers/clk/bcm/clk-bcm21664.c                     |  99 ++++++++++++++-
 drivers/clk/bcm/clk-bcm281xx.c                     | 141 ++++++++++++++++++++-
 drivers/clk/bcm/clk-kona-setup.c                   | 116 +++++++++++++++++
 drivers/clk/bcm/clk-kona.c                         |  64 +++++++++-
 drivers/clk/bcm/clk-kona.h                         |  14 +-
 include/dt-bindings/clock/bcm21664.h               |  17 ++-
 include/dt-bindings/clock/bcm281xx.h               |  24 +++-
 8 files changed, 499 insertions(+), 25 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250212-kona-bus-clock-4297eefae940

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


