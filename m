Return-Path: <linux-kernel+bounces-752224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411B6B172B5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A6A18C6D39
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100D02D29DF;
	Thu, 31 Jul 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRhDPM/L"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7777104
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970522; cv=none; b=fXS7bWllPsfMOS1VuIH/K9/FmRK9K6cMHrfSHx+NMxqlkJm+FV7hSP0OpOO4bG/vDeZu/vf0/TKqK4WJxW9O2N5bwbiog7yG/NBtmTS59Q7NvemWkz1jCQxPq76xoJUDDACxX8dHwvOgX93wmM0HfvXfKKO/GPLwI7Gmjw5WQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970522; c=relaxed/simple;
	bh=vtDoBOhDgvfsTUyaaPcWyqShvPac5U3nE2ogLxWYfzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTzsi6XMyNUMAbTNRnkGmP2cAWPSj2/UkkwWCBfugATrBkHTDQimxf+T1EK2oFodyJwe17YEWWgzcJjbQQcGCMPy/mLMNucZG61L/1aID5GbWFSBKg24QHeSRQNPK1jgVdnSUmrpBw3+O4gxFAXIArVCldsW3H4t3ge8Sh4yJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRhDPM/L; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b785a69454so673306f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753970517; x=1754575317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GV5s6FOxWw6F5tawQDBpDciMQ1YhmYggnl1ycVHKgck=;
        b=pRhDPM/LyLj9lwaUCnMMPHCkD9HiKSg/3H07nzENZdp+FzKQDwLhqrcBUAgwyH/tmN
         /0tZ1kIa7C44SC4qjy2VEu5UkVpCJGUAOOkj+q2tzq37ygFiAh0iNrBESy65lBX9JU4C
         5QELrxtBtvIP7uWGPiqNglNbrObcwZJpAOAEUCRYqfZp8rwVmlOI5EMpeL10QjsdtGPw
         C6WGNP+stoypfgErUA9xCf10jgq0YWnGOCEPG0fb2SmvIINF7JG0aCYYM5aiATOcmkXk
         gDnSM/o6EXTyyE50pa0TRPH3tfusizUdfzBFsQTOwQX5fs4IzZA2U/QhvpjjpHPuWeeW
         maRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970517; x=1754575317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV5s6FOxWw6F5tawQDBpDciMQ1YhmYggnl1ycVHKgck=;
        b=xAbeuMKabWA//nQZ/XkDCD1JIoYs/r45NYbmX9v5eUOj2PrTTdkEdreHbDONaoBjhf
         kETpUGaoLkDYOaCgOv0e8blW0WLKNLcJKcyq+AGGViDB2S09yDZXeGwJexAwOfsQju5x
         k91kuI+M3Z6vD3kkymzsqW13UeFgRdIcP9WFOcahUuYxlDeOtKPY27xGnPjk7DESb5G1
         Tp+lLRPeKSYuDpzw6uGoGXPv7numSclx1dq0JqpGEPNQOH2PzZWwkN3jINzsXTilxjGw
         HZJqVfVLBr8YIS+lo3LSzVFgHpHLf2cbIWdXrWr8wCNfbaYih85WX8N2rUEBegrT6m3/
         mLyw==
X-Forwarded-Encrypted: i=1; AJvYcCWS8Q7kwvgh/xXGm4TjFy+4PWWjvBkVKuv+riDMHV6rPiyO2zs1UmIq4e034VfWBkaMx3Yahvbmpfq92FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEkveIJq1VETkY19CAz+8UwbwMW+1vD2ftP62t6YeuReTioA/
	1zDXFjTRuGnk1tWRJqGW1lPTmf9Wl5xYywWD5xNGhyb3r5KHPtOrr5UTYbHZCuTooyhM79NONsV
	LWx9e
X-Gm-Gg: ASbGnctQSRuEPPxaRy0Om5odW2V9lHdnE4VCTOu0Aifa6D1VwrntJitdHWOkb4XX2nX
	Se6yYP50zW3B8H9xq5deOTgY4rccqKDufrAzwc+bio10wwwrv2FvMc6UScmdDEhIYRk8zUlcg1L
	8tVwbRAp71ynOF3aptSAkKckKDhZlfQb761Vp3Y9FPaDy5JuOHVosxB5qalRxINIOsFJyQO8BTV
	HF2JZV19u3WYgDRTfcsB8Ke3H91ytpJFhhPy3yYLVPbFyMhrBS5LQo0UV63k2b10TMIx8NNQohQ
	ps0XMIbBy2f0pbDMiohzpOxXAooSNZflqz3IV2T1aNoEIC+VFU6eD9xH3dwK1o7WG7DB/tQWDtk
	Isu0mmjAMhPfELF3YXQbjlzYi1fRmbqaoBOTN32re25L1cOqLNpgKJw3Mc8I=
X-Google-Smtp-Source: AGHT+IELpYq0cfUwdhdal+guuoengtu4ASva2Hzj0xykx429WqgpGqubTQ/jYn7p47HzHjuQsPyogw==
X-Received: by 2002:a05:6000:41d3:b0:3b7:974d:5359 with SMTP id ffacd0b85a97d-3b7974d597dmr5098700f8f.32.1753970516376;
        Thu, 31 Jul 2025 07:01:56 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm28121285e9.28.2025.07.31.07.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:01:55 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mbrugger@suse.com,
	chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: s32@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Add the STM and the SWT nodes for the s32g2 and s32g3
Date: Thu, 31 Jul 2025 16:01:33 +0200
Message-ID: <20250731140146.62960-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP S32 SoC family includes timers and watchdogs that can be
dedicated to the CPUs present in the system. The documentation refers
to them as the System Timer Module (STM) and the Software Watchdog
Timer (SWT).  This design originates from the automotive domain, where
the SoC can be partitioned, and a group of CPUs may run different
operating systems or firmware.

On the S32G2, we found 8 timers and 7 watchdogs. On the S32G3, there
are 12 timers and 12 watchdogs.  Please note that the 8th timer
(STM_07) is not described here, as it is coupled with a specific STM
instance used for timestamping. This makes it somewhat special and
requires custom handling in the driver. It will be added later.

All timers and watchdogs are disabled by default, and are selectively
enabled depending on the platform configuration, which may include
different combinations of Cortex-M7 and Cortex-A53 cores.

This patch series introduces support for the SoC and enables both the
s32g274a-rdb2 and s32g399a-rdb3 platforms.

Testing was done only on the s32g274a-rdb2, as I do not have access to
a s32g399a-rdb3 board.

Changelog:
  v2:
    - Replace the 'description' word usage by 'node
    - Reordered the nodes in DT regarding the address ranges
    - Modified the change description to leave the ambiguity regarding
      the architected timers

Daniel Lezcano (8):
  arm64: dts: s32g2: Add the System Timer Module nodes
  arm64: dts: s32g274-rd2: Enable the STM timers
  arm64: dts: s32g3: Add the System Timer Module nodes
  arm64: dts: s32g399a-rdb3: Enable the STM timers
  arm64: dts: s32g2: Add the Software Timer Watchdog (SWT) nodes
  arm64: dts: s32g274-rd2: Enable the SWT watchdog
  arm64: dts: s32g3: Add the Software Timer Watchdog (SWT) nodes
  arm64: dts: s32g399a-rdb3: Enable the SWT watchdog

 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 119 +++++++++++
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  20 ++
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 195 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |  36 ++++
 4 files changed, 370 insertions(+)

-- 
2.43.0


