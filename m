Return-Path: <linux-kernel+bounces-814710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1FFB55798
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E173B6F30
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438322D3EDD;
	Fri, 12 Sep 2025 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZT/DteN"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F792C236B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708855; cv=none; b=JcbdUSqou67BF+0gS1PP4U2VmNfcbUIzij1d7hNCWGEBJzzC5DLgVrTJgyX883nnY2nhLXCyqu2p6suMILd7Uo2gk5RiYUVKzc6oGj0We3tHdcZeKtzrs40j7BEIZrPWUkaevYs2CkRt8D8HaI7hqujWzbMDJnbTmC4jgZKmGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708855; c=relaxed/simple;
	bh=dujsJO2u3jBI2Q1VgAxUbE/yO1TtRPjWotq8eGPgRXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=liv2RJ74jhHwwlckCUfGg4JWraar8u13Se5xFZUCjtR6ddf78hv1VujRW7nqKsnm6Qz7vnFWpxAWebnfZbkoGvm8588ehbda9KAxhBTtUOMBSzctL/iyKoNU7fTxJW+DAWKq4kNm1d+XPv7sIMMU7/NLAMPb7BzyBKfGMp7Gcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZT/DteN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1739673a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757708853; x=1758313653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwyolwhQDrgiO4NYVzDiwfA3KI0SBXDSnFTG9Vkn+vE=;
        b=lZT/DteNf138LYyq0KULG1k+bYo3jjp+AzjRR/ytB3MTzQHoRk4bg9OZhFt8nSASni
         tiJhOF6I+AggZn64ZCVYNHjOumBpgX78KleU40tuIyZqMr3HyUJCBvy/cn5o4+cEI414
         +jaImcvq1u4AafMU4NUgjrt2rM94UCsP9/9SZx+Li6MrnaYvPuZM9o9fB2CzQlhGoVxB
         KPXzJe2KYcOqKDNAp2xATSSxdmiB0yEA3+ox9Q8vDYGY3g1kF1Ac9NWWhs1qFf1vuM2d
         FuwA3WrbfG4l22COcmWo0TPNG2vmj2+YgFDtSXt7KOKPBd+8bVKjYeOzLLJ772+Mh2+o
         VMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757708853; x=1758313653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwyolwhQDrgiO4NYVzDiwfA3KI0SBXDSnFTG9Vkn+vE=;
        b=wFfv2uxHWO03VipiV/+zy0+ZGdC8huUgAUy4Mj1F99k2++lP/mVCI5HfxccdPqsuAB
         oy1tYKtaoExQBrirXudoOcp0+zLFr4N3BGd9gv45/lXAw+me32QXI1nlXi9wVN/QU9M5
         sG+pqmtJl3gnAdvdv/vRWRjrgNs0fd/Gdwve0Fpx5kcvTqed/9DqDyhbQJnlInQA9gQO
         NDVj5Qh9ieR9P76uB1VFMFVILh/Z0HUZb5SEVu/eXTM0KTD2JWRgsudqPfs3l6zporQh
         aV/o9+3nZSuj+J6iJBgj5hnKu1kj1MCjEkFzNQBBgkCxb5XDalhMFgkR1eEK7eC1wxXY
         nrUw==
X-Forwarded-Encrypted: i=1; AJvYcCXF8E7cuX54hjN4AW1Q65n3FDuV8+zQ+V71qMwb4KEf88WJdKyL8qCdQfAggpBQS3LvkBMhwrH7T38xShg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySiOEDNP8BnQsCsgL83Q1Ka8K3+7HX9OQpWSqmNf8evW5yS1Ek
	Is08Y8bFGeQIOpeZczt0CIY8AUexpnphKreVDlPe8U5usSlg3ysf5e9H
X-Gm-Gg: ASbGncs5zldUkv+W4PcnduuA4SZd/lOkiKR8r/RReS4IHf6flWtezmBwxUc8kGKm5G5
	R50R7cyoeQ9pDXt65+uX79XwtSxTaMLbkPCWZfSUe6AISIASnsIDUO8abTLEEIaNqO2ouIGDDWm
	TrFvxwJEWthnbheBkvfdUI79VhciaXZaTAZZdM+D/chmjDzrOTqKBS7aSQRuR8BgZy1w+yjfzUJ
	0I9NpNQeZj1uc74ov4lntGTurnS3sDU5Xx43Pds0RYgGzEmXeIaT/Y6HD1zR02VRsQT7dwGtpMY
	W82bw5aHAwl4JurRgU68aOPOWcayPw75y05GEOxLrO6rQEifAiT6jUCY5KJdfFf7gruFtHrrd+X
	z1XVfRX93ngvpn0nlJkM=
X-Google-Smtp-Source: AGHT+IFheXSdIhdPEt8rS6r+83Oefz7TiZIzXprM2ltNs7ZL4vZRxlqmCP33DNNES5cygvIkNHRs3w==
X-Received: by 2002:a05:6a20:734c:b0:259:27fa:414e with SMTP id adf61e73a8af0-2602c050274mr5177410637.47.1757708853368;
        Fri, 12 Sep 2025 13:27:33 -0700 (PDT)
Received: from archlinux ([152.245.61.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a32ea462sm5603995a12.0.2025.09.12.13.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 13:27:32 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
Subject: [PATCH v9 0/1] arm64: dts: qcom: add initial support for Samsung Galaxy S22
Date: Fri, 12 Sep 2025 20:25:56 +0000
Message-ID: <20250912202603.7312-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v9:
- Change 'vph-pwr-regulator' to 'regulator-vph-pwr'

Changes in v8:
- Rebase on 'arm64: dts: qcom: sm8450: Flatten usb controller node'
- Use real name for sign-offs
- Remove device tree binding patch as it's already in the tree, merged by
 Bjorn

Changes in v7:
- Document the reserved GPIO pins, remove pin 50 as it does not
 need to be reserved
- Clarify the phone isn't limited to USB 2.0 but rather USB 3.0
 isn't implemented yet
- Add a newline before every 'status' node

Changes in v6:
- Remove debug features (bootargs, etc) that slipped in the v5 DTS
- Format and organize nodes correctly based on existing DTS, 
 move "status = "okay";" to the bottom always
- Solve "ddr_device_type" and "qcom,rmtfs-mem" warnings, the rest are
 from existing SoC .dtsi
- Disable buttons, ufs and other features for later revision

Changes in v5:
- Properly format the thread

Changes in v4:
- Try to properly format the thread

Changes in v3:
- Removed unnecessary initrd start and end addresses
- Make sure r0q is in right order on Makefile
- Properly format memory addresses
- Set r0q to the correct, alphabetical order in documents

Changes in v2:
- Attempt to format the patchset thread correctly

Eric Gonçalves (1):
  arm64: dts: qcom: add initial support for Samsung Galaxy S22

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 145 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts

-- 
2.50.1


