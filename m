Return-Path: <linux-kernel+bounces-877873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B34C1F3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CDCD34D72E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4BD33FE11;
	Thu, 30 Oct 2025 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aSFRlqer"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A914315D37
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815945; cv=none; b=JsfCD8BPlOejinjJSrA02ziSXvjqiifXy3k5YTPjUia8gZdq30PqEM38LRm0LaRNRXCGO+1NVR6SQCP48YUihzOz4RESyxkhrc1TT04ERwK6Rgzw8DXc2vDon6+pTZleINPt5ZWTI/bPBsKEqy1jUnKrNdKDDOPJnhoNk+BAnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815945; c=relaxed/simple;
	bh=zqYIIl4nQJ86jOsDALK6PFe87lmlujk5rxiqWGuMMag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L1e8+Lm3+N5gsB0ebk3/rQ7DIkFdyXwqUFiEIoQRgLOvy05KOpr9NgP5QFBULD4Hrr87ESO+Q0r8eH5dVSRLKi0cDkwOrloCqUjXd/GMEAaX7ZwQ2ady+oKvU2i/gc32Cos5atDZkgGm1C/ZXs69fCDslwscyYplv/v1VBtBJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aSFRlqer; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429b895458cso268461f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761815941; x=1762420741; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSwv5JuXuXyqhsYe8FeccLuDilzKVXkpn0YsKK5l/YY=;
        b=aSFRlqerOD9E7rZer01+JEOb3p+jKWhYY/c1kHmCtBZ+5PAxq1xuq68mHQl9L2LxFV
         5pPuYQxcr9bNH3jd+RRMf6OsehnyzkzSsHLcvB0zQIvf456QzJXn0hrnNhZEx4zAm0o2
         Z+eiTWkGd6dZ8BDNqMnadxhW7850ZIRXsALwB3WjdPtdmCZ0qLaX5Dkkrxkdh+1XTq4J
         +il4ip5cmbJNmr2S9hJZHmP4RZ3pzxLUFnLm44ewe0QmX8ua73N9Kn9qCv24c7PNtwoL
         IsubryFutiF1UCqjOl8oLdpFKgGrBdCNOEiqtVELqrlqBdyWsWuM5R3VY0JFdFI5b5m5
         d1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815941; x=1762420741;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSwv5JuXuXyqhsYe8FeccLuDilzKVXkpn0YsKK5l/YY=;
        b=UL+gVRAatw2J9GP6sIbxQ5raNrK+aLl/zcienQpde8TTEeKb9Jb0g/w5WVgIhArgw2
         6iuke6YXETdKRMoegAtvyl/mzQdYC/hKcif0pUNK1l5GPquC1iwPyRdyDhym8i3AUgD0
         IMwIHzERzgxuw6BliPhfAAS1Mev6sZqGOx9QHpS25MR5AEIi9PtljJgbFpr7pwZBpmdp
         E6255EeYwaCukEGmBBtjoDxt9OJYbMMGyChzv11O/HznJN8vMWUcAYX2wfOsUFOhNkCj
         +YxA37cc8uIG34ihNvj1AnwEuczklBqlQ3/pN014AJ672MwonkJBT77lksiP9zMvDdEs
         5fPw==
X-Forwarded-Encrypted: i=1; AJvYcCW1Hg1VNFpzEVkSQCVy6LkMaTb5iABQes2bMj8aplwp2hHqlg6FkCaLPr2R1E2qrmL6l9pArdO1aM/5STs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNDP7ma9FYaaNk1pcIYtQ3u29nbZTyOuvb3Fh7+084N8xhKov
	fKCUPm9WnW+ObG0V0o9BsL36JjcCIEvACI2PbrDTZPLIbWaRWxxrTK9tZn5q4fMBCh8=
X-Gm-Gg: ASbGncvqjtYyItkH6PafmCJDVSQrNslM83xE736poXp9+Q3i2HMvwqpP/01ycqOsSzr
	CDhadc4zE0VyL538ANzFGNQfTQ5QCHrvBZehHQECRdzy3vOfSoUvWLr3G4L3DFqf3O7ddtwztAU
	z9H6GnQqleP5OtEd/CfHafnEYNmGRnaPcYr7Hqp3WfR+qh92GYN4G/HUwBDLhhl9Dd0y1tdVDka
	eiE12SrDdUfSOvV40wQTM1H219vjjzCLqH01XuWW8xtb9klVFGOHIVm1za5Q8GJV8NdOJ6ryOjg
	j4j8aTSbpZVMkfaimwF1RPaKju2H47tQpUa9smzEFkaL5iNeeeRfxIM81w2ZNqFUrSx9oANXfR6
	rvXZ9mHphJODLOf0YcLyLyFEyBpnrGxKXvJ+a41pvjWPmES9YFaZfDYGJ3+HKSpVS+4a0GZkjRQ
	==
X-Google-Smtp-Source: AGHT+IFBJraJgSepwNLraPb2/w3Ksa7ALKvRzY+k0hU5XwnAcd25WvkxjzsX4QfROikuqsVWVU8mTg==
X-Received: by 2002:a5d:5d06:0:b0:428:4354:aa36 with SMTP id ffacd0b85a97d-429aefcd05fmr5037872f8f.58.1761815941338;
        Thu, 30 Oct 2025 02:19:01 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952de971sm30459906f8f.39.2025.10.30.02.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:19:00 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v4 0/6] arm64: dts: ti: k3-am62: Add wakeup-sources for low
 power modes
Date: Thu, 30 Oct 2025 10:17:22 +0100
Message-Id: <20251030-topic-am62-dt-partialio-v6-15-v4-0-6b520dfa8591@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACItA2kC/4XOTWrDMBAF4KsYrTtFGvmnyar3KFmMpXEzEFuur
 JqE4LtHsaGFUvDyScz33l1NHIUndSzuKvIsk4Qhh/KlUO5MwyeD+JwVaqx0aSpIYRQH1NcIPsF
 IMQldJMBcQ/612Hhvus40nlQ2xsidXFf/47TlyF/fuSZtj6qlicGFvpd0LAa+JnhWGY0H9Tw4y
 5RCvK37ZrNebFPQ7EyZDWioHXuriTrv2/eWbhdpI7/muhWf8Rd8M7gHYgaxshXauiRN7h/Q/oB
 G692FNoONPlQdY23Z8R9wWZYH+kraK6ABAAA=
X-Change-ID: 20250415-topic-am62-dt-partialio-v6-15-327dd1ff17da
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652; i=msp@baylibre.com;
 h=from:subject:message-id; bh=zqYIIl4nQJ86jOsDALK6PFe87lmlujk5rxiqWGuMMag=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmXafTwYycM18bb1f8P+Ve37Y/899pCUuKf1g2/eeb3
 oMFgS9jO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiC2QZ/kprWF1c+eC2VNbH
 o8+r3+2W91NcH98o/OJ2jtPnKeWrPL8zMuywmx8WtfXiV3c2i6P9/sE71jtJuBvE/Plv5iz2PqQ
 2jw0A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

This series adds devicetree changes needed for Partial-IO support on TI
am62, am62a, and am62p SoCs. It defines system states for various low
power modes and configures the wakeup-sources for devices in the CANUART
group. Depending on the SoC and board details, some low power modes may
not be available, so the wakeup-sources are described in the board
files. The series also adds the necessary pinctrl settings required for
proper wakeup functionality.

Partial-IO Overview
------------------
Partial-IO is a low power system state in which nearly everything is
turned off except the pins of the CANUART group (mcu_mcan0, mcu_mcan1,
wkup_uart0 and mcu_uart0). These devices can trigger a wakeup of the
system on pin activity. Note that this does not resume the system as the
DDR is off as well. So this state can be considered a power-off state
with wakeup capabilities.

A documentation can also be found in section 6.2.4 in the TRM:
  https://www.ti.com/lit/pdf/spruiv7

Implementation Details
----------------------
The complete Partial-IO feature requires three coordinated series, each
handling a different aspect of the implementation:

1. [MERGED] m_can driver series: Implements device-specific wakeup
   functionality for m_can devices, allowing them to be set as wakeup
   sources. This is available in linux-next now.
    https://lore.kernel.org/r/20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com

2. This series (devicetree): Defines system states and wakeup sources in
   the devicetree for am62, am62a and am62p.

3. TI-SCI firmware series: Implements the firmware interface to enter
   Partial-IO mode when appropriate wakeup sources are enabled.
    https://gitlab.baylibre.com/msp8/linux/-/tree/topic/tisci-partialio/v6.18?ref_type=heads

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/v6.18?ref_type=heads

After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

I tested these patches on am62-lp-sk.

Best,
Markus

Previous versions
-----------------
 - Link to v3: https://lore.kernel.org/r/20251001-topic-am62-dt-partialio-v6-15-v3-0-7095fe263ece@baylibre.com
 - Link to v2: https://lore.kernel.org/r/20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com
 - Link to v1: https://lore.kernel.org/r/20250421-topic-am62-dt-partialio-v6-15-v1-0-6ced30aafddb@baylibre.com
 - As part of the series "firmware: ti_sci: Partial-IO support"
   https://lore.kernel.org/r/20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com

Changes in v4:
 - Rebase to next-20251029

Changes in v3:
 - Drop patch to add WKUP_EN and rebase to linux-next to base on the
   patch that accepted which adds PIN_WKUP_EN instead
   https://lore.kernel.org/all/20250909044108.2541534-1-a-kaur@ti.com/
 - Fix small typos in the commit messages
 - Use AM62AX_MCU_IOPAD for am62a and AM62PX_MCU_IOPAD for am62p

Changes in v2:
 - Combine k3-am62a7-sk.dts devicetree nodes with existing ones
 - Combine k3-am62p5-sk.dts devicetree nodes with existing ones
 - Update the idle-state-name properties to the new names from the
   dt-schema
 - Rebase to 6.17-rc1

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI.com) (6):
      arm64: dts: ti: k3-am62: Define possible system states
      arm64: dts: ti: k3-am62a: Define possible system states
      arm64: dts: ti: k3-am62p: Define possible system states
      arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source system-states
      arm64: dts: ti: k3-am62a7-sk: Set wakeup-source system-states
      arm64: dts: ti: k3-am62p5-sk: Set wakeup-source system-states

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 60 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi      | 22 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a.dtsi     | 27 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts  | 71 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi     | 27 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts  | 71 ++++++++++++++++++++++++++++++++
 6 files changed, 278 insertions(+)
---
base-commit: c9a389ffad27e7847c69f4d2b67ba56b77190209
change-id: 20250415-topic-am62-dt-partialio-v6-15-327dd1ff17da

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>


