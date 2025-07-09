Return-Path: <linux-kernel+bounces-724344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE8AAFF198
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EA53B6AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B7323F291;
	Wed,  9 Jul 2025 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGMIXGsU"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A321D00D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088533; cv=none; b=KzWPRn1xF1ZJpwxtGpq3IC2B1b0mzslxCgHu5qF2wl8/+nblOCETS4EJavXlc81f9Th3HV8xvMMysrA0mHzj+RbUoAWrhr77ujeB2ku2Xze9ZB1MeH1SXNZ/Gd7nQyhj9T2LfnMC2wXFYPuQYdoZqUbR+33E+HoYHZWq6WK6Xak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088533; c=relaxed/simple;
	bh=Vg3SYFcxbZhfxzHwdzewVgAiginzpLipvsLFtGoX06g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AncCl4iP4aw60hVSgrIuvRFuhvW8+tZ6fPR7sJN84HvZHYdsbRiSFs9SjC5Op4qzJbwqnudqhP+Kt2uPZf+6WhvtAzZ8NVSAm2ucyAWg9PO0oGUAJ6wCfuBcGunmqHrga2zFNTNhn2SFQqQQrvfAYZnBwEZRviaXDPe/pUqfBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GGMIXGsU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4f64cdc2dso35166f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752088530; x=1752693330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOUI37vOvArNOMfbDlU1r5BFH53BMkpjGIGFBJa2WR4=;
        b=GGMIXGsUNhJI6oHDJ5ZgmWlONrkEqHZhIkZ9ufW/GC9LhM2yYdYEIoa4j+dns7QowV
         kva0huBNSQjEvnP7JO7zlDkEX03nK/XqmTU1QK/6VnsSzBjpttrByHE99s30Y+r2XYTc
         4oVXgkflaXx2cjZzquTu5s2K8dZ9DPt6johmdtLa06hNhjdLDVBqTBSUIvEmIXC72BNj
         9ufzeU5eBQKGg7j/q/+H6/QSh1JxbO6deJnrlc6DDC7ZOpmlOn764hhQUgWxyCvouGcX
         gvzTyBZ6YvYXXHNsYsWIbOS+IY8CfBL2V940Ez4G2lI1z9l1NZTagDV63uleFH19TIvB
         qqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088530; x=1752693330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOUI37vOvArNOMfbDlU1r5BFH53BMkpjGIGFBJa2WR4=;
        b=TbI/Pg0mjSVpcYmmrzQwc3I+I3ofarAkp8/2srDGZnCjScT5PFD0eeDqdf1Mbb65Wt
         o3aJ0IX35TWR+v/sSFHj3PGlCqonGiU6UF44RpmAuNGuI+VkViJhNkmwEWoxZzEJG4b/
         SZtiO8BQqWtf+iSdTbfai0b4gZRSUL4QAmUP2mgs0lmlPJtECUGNft94TNAHX6oVIHW7
         5sOB8OoxuRcnT+ThDzp1kOKEdTJ0RQTc7FUYOqnLvTk3mZIMmY3bPrvFp/i7CWUJ0oQ5
         vvrHistqgT4oUR4g0HjryMCO5tNXZDrJpdhWc6SjzQpKNGfrc8vdRb+q/MTeO69kE2Jv
         fv/g==
X-Forwarded-Encrypted: i=1; AJvYcCUx1u2Q5nSFOW03kWWU+/5Lmiv2kBrVI6IA5t9z469NHhEAS+eMxwC4/bL3aSmSg96HtdxHqUOzt7iceHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlb7PxuhTB4k2KI/+I+Zl+sPNS7fvGuGbIhYk1lHzP2MHKhIQ
	Hi+JIPEQc5PkW0X6+iJmmHoTerCViAnwsdqS9jeCcLfFl2PmGdOJty5lmlJYuy2epfyZ0GGo44a
	uHldM
X-Gm-Gg: ASbGncsX7NF+mmNsJg+d+3RiD90sbiIErJmrTz6jtmMTF2aEYa7fzp3i/Fqq7Hry5gA
	u77ck2kwEIVIcxRotlpxIk93QFBcu8U5ZrAejJucvmaVIkyKvAmYOH6iqpzZIV4tKWs1Tt0lGxp
	UzEgqbWQPrG2cHL/MDhk8iMtBl5iw/OL0GCey3r82FNw9iHN1HjUIP+5iSLew+sTXWPycfZnROA
	VhOldJ8UDD14qpFRfeJiw1JzE0dg9XtZuBbxdFi0Hx3BhbjzFK6QamidXbKrsZK5jVdYTbOvD2a
	nCRO9Hah4BYZsaA/UTy4vLC0BUtx554D7LC/J1yjcJt7Uh0G/dEb0Czs4eYKcIgk2yMKBSRSfDU
	=
X-Google-Smtp-Source: AGHT+IF5fQuSnWVC1+1FSPZh+mnfL3zRfmekTmST3Oxxmhd4JajNQiGduP450T3HuQ8hjxFtcBtDTA==
X-Received: by 2002:a05:6000:2888:b0:3a4:d4a0:1315 with SMTP id ffacd0b85a97d-3b5e44e107cmr1444727f8f.6.1752088529780;
        Wed, 09 Jul 2025 12:15:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285dc08sm17159588f8f.98.2025.07.09.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:15:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/3] arm64: defconfig: for v6.17
Date: Wed,  9 Jul 2025 21:15:20 +0200
Message-ID: <20250709191523.171359-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Vg3SYFcxbZhfxzHwdzewVgAiginzpLipvsLFtGoX06g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBobr/LrlRRiB7NlTXa7KpRiF8ppNyVSL6muQZyc
 U/nnYOJbbOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaG6/ywAKCRDBN2bmhouD
 1631D/9+mUsRGRHWiIdpYnSIndM3CR/VSb5CpOedsp/WMUAxCfvyYm+cNPdqWe68MxqUBliQTxh
 1luK/jO2yNlAMjmvD96Q/UOLXSlS4g7NdpSePbKoaT3isLHiX8n972jvmX1pE684SlPD+rAl8Wt
 BflVWx59w+n0qWa66Hc+lMgBw58NXoJ2daiG2t2w50XLSdskrcF/Oadi1bwI5f00HEywZMPxKnj
 QkquXmlnBi6dyHdHfFGHu3c7k/Zjg9Qcy5F7ut+IOUC4wdJkHSsnAS5xgRC9nnjB5holPin6heD
 ozlaZ5iKoM25cHC3GxOJnmDjQBaRrMbb7vIdJkEVuQlr5HAFmKbPiZHusiVlJgVYMcu9nt4Axme
 fGeQkPXLKa6wxYWeS9QI+IrZEVm/Oai3bSurC/PZeyvoJu1w6pHZebKXR3FoPsLR0klnTkGBbL4
 zenZDZRqCT6Nq0kS8FAy0rAIyPykug3COaM4NCi7WsbJWpHXhM4hlrLXG5Rqtxo63beki5kfn3K
 yOoWXlfEQ6J9zcesgUhIyAFhgqvATrlJVJG318inhKHYbiR5YgeWikUbEeJGNlwgXDb6P2kITWk
 y2Hpg1qxObvXjVB6wKFdAVf++28TEW/v9h5UVrsnsxt4X5nEidEK+72Amfzl0J6zxKZ1N1/gLw+ ol9EG7e7CPuRbbg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-6.17

for you to fetch changes up to a7d7aebed4005b9c287f9bd9d22c273da63c9028:

  arm64: defconfig: enable Samsung PMIC over ACPM (2025-06-30 08:03:28 +0200)

----------------------------------------------------------------
Samsung SoC defconfig changes for v6.17

1. Multiple SoCs (including Samsung, Apple): switch sound to module from
   a built-in, because it is not necessary for booting.  Also drop
   redundant sound codec options.

2. Enable PMIC drivers for Google GS101 Pixel 6 phones: MAX77759 and
   Samsung PMIC over ACPM protocol.

----------------------------------------------------------------
André Draszik (2):
      arm64: defconfig: enable Maxim max77759 driver
      arm64: defconfig: enable Samsung PMIC over ACPM

Krzysztof Kozlowski (2):
      arm64: defconfig: Switch SOUND to module
      arm64: defconfig: Drop unneeded unselectable sound drivers

 arch/arm64/configs/defconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

