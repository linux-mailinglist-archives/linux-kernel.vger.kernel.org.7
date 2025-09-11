Return-Path: <linux-kernel+bounces-812956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1A6B53ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38F3171761
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590623BD02;
	Thu, 11 Sep 2025 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM/nVgfp"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5445823E34C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630889; cv=none; b=Ea+xwBd5U9fR8uB4KqM+ntCFG5G2gRNDo8zu5MLuTt1YjVfDPXau8Iog4dbti4WRh6CGQ4DsfEt1aZY+7SrESiPRY6o4zsMUq3n0p3J3sm4NXETs4wCWdx8cH6BYE06dpUOWPL/bd1hjW0UJByVxMt37XOg23O1oIg92h2tUb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630889; c=relaxed/simple;
	bh=ocs4EQ76GlEPr3yAQv3FQf9LAX2b/AlcV9MuFmVhPAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jzloj/Y8il0UAgK1B9H1c9mhMvJHd6ls21uP9BKsygpCEXFQJAHYC6M2f4VUun3wXytK1AJwmvOxhmpkPpF+t60N4SedIuXvgw1g5qojd1rxRCCIjgSJqZHT6QONSfapCUVQBsLQ6P6VB2J3w54qsexN+yCdmG38JRHt31WOPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM/nVgfp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77246079bc9so1447072b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757630887; x=1758235687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dqo+6lIPjlAvcSz8C9O1Kyz/i4EBXtrAu/454vmVrN4=;
        b=FM/nVgfpi1cPpX5+ysEHTqwnXMqQ9DCzUqJPnUJMy4QExYOEmkZ8rHVl8oco2kIwVq
         VukabTqCQa5DFdXZSmkynqKUA4eufOiaTuqZEKHQsY/L4tNcxSzVxu0eRrboH49LEVoU
         GXSrvXYTJLRUgOEzt6tJHE0cnOgsgGs+S0uu+yYWclpT0nA+PfaBNiFfxscc0NvqWdyS
         VtaNmlWfO7GwPgH7uLfg2ITVPd0O0b1OLIm3FKMKvc08xajbOaFzbdZiuo96HD7I/6ez
         M/NOPl2deWsHV0L9mdQGQHSq4tA6MIwm+ly853qnx/UUaBqos56Akh6tuoukaNA8XXL3
         DOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757630887; x=1758235687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dqo+6lIPjlAvcSz8C9O1Kyz/i4EBXtrAu/454vmVrN4=;
        b=Wx4TKHwmBZ7kZ9ge9jEwEHofMPwtQktxtgFkkPryl9tSITgWrSiCX2XZ1CnT8mxXTX
         WeEZlSopAd3FW5RnrXJxh5UPVRI5PPvirguj1TtT8Fs8rK2HEV9YqYAyy2O4ami4anIb
         uONs92qNIOWe3w8H17YfaQuqjXyszeLriwqT4LckomlfY8Sg8KYpQgnDVyMHyNryVB7i
         MaG4sAi7Elik97Cyme1CuZYZfbhx/lNlEw7SPsvrMmFUK9C4lqf06osfRAzS0ZPQ+BAt
         BYpVjMX0PxuZUNviKZTOl+Md0fAQInaqLjebuyFCEd+VCQYTCxq7OqdWeysUyOOuTNXu
         uzUg==
X-Forwarded-Encrypted: i=1; AJvYcCV/S8hP5Z3NwRzJ7cBBd6qqiB5lPwtudUlsz36RW9I9RDr5/OwurcDAywCEWmPW/igbuIBQjEzSHy6SVic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DTxd4/UWY59Xs0HlEQ/UJGuBbwrP+CFOm71dof/xdKCmWeEP
	h4mCgDAHcMxp9N0ziCIqp31qMMvT1ehqUR8OV0SHpel8lCb7o/NkvW/U
X-Gm-Gg: ASbGncvm1//DCSRU0mqBCCrq7vRQnrC1lE6W6qUsLeUypVAqkEWUkS7/ngE7tI68YMk
	WmtBjmCFPWJsXVFuas/35g2nURPGBTRD0360NuCkVgmN3DxKBXZLCzxN+5HTHo501DUt+DAHdvf
	6q4WrC9yjsBWJHXSud44pI94LEj3J5ro7gBf9wNwAlV0G7OPE7QPlO/zAqolmbRJk6bkeX63V0j
	Fy58lpqyIhlPryjBoF/y7aIwQpCX4pKpuioGbmXRZgsTnpqhvXyS97Dc5ScY7Tw0680sRkRFKQJ
	spGUGuxEBfqqyey3gKwFLAwOSXEbC0RnCQvrck3GlqZ8VhldHt8JT2J+dZF+HPvbMUjGai10NH+
	oyuEe5qILbK0DY68/vUqvLgkY1xQ04w==
X-Google-Smtp-Source: AGHT+IFq4DY2b6JZJ/5QAwwp9tb1KFmxBGf2XsSuFAK8OESIdaEFbenOGfnC37evdjtflJER65m0vw==
X-Received: by 2002:a05:6a20:3d82:b0:251:43f5:cac9 with SMTP id adf61e73a8af0-2602a49da79mr1029229637.7.1757630887395;
        Thu, 11 Sep 2025 15:48:07 -0700 (PDT)
Received: from archlinux ([152.245.61.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a4a24esm3172314b3a.40.2025.09.11.15.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 15:48:06 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
Subject: [RESEND PATCH v8 0/1] arm64: dts: qcom: add initial support for Samsung Galaxy S22
Date: Thu, 11 Sep 2025 22:47:28 +0000
Message-ID: <20250911224734.51415-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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


