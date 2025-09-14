Return-Path: <linux-kernel+bounces-815695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C569AB569F0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEB33B735F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED47288AD;
	Sun, 14 Sep 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqxMqJ/k"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA641DEFE7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757861769; cv=none; b=djL7CBj5OnJJi/bEoPeRi1BBr5jLss6VeGy8K7iQrbLz4dEse3kMufs5Np5WiweB4LPftF24VbTRCW0hfGxo0JzS1sGHmZPiZ+j6Ge13xmv6ABNMB3eCiF5dln2Gn8i7h0hH8oJ8fjS5iCETKwkbOU8hgnTz/vyOU7DiEoxpMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757861769; c=relaxed/simple;
	bh=GtzfjRzPIcRz3TlDPzQkhFG0JB1MRNghy5cWBQyLfB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnfvAEz0PIAHMqrsUjBVCR7+BCWWKQgURKZ3lSz+v2fofQvIV/f0U6aclk3F9onBokB5Lg+kNjYJl00CcnCz0PQT56GozSh0ykT3iLiNy3flix/JJ5FWNbCuNQZv4RHQgYM4pnrLyIG3kM2eA3mPGgCXeiYowMZ/VCsLNCGXEhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqxMqJ/k; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e92ce28278so702475f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757861765; x=1758466565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qapOJtKxyY0MNaqH7qXtB8qqR3nlxKXEctWyb1YrfM=;
        b=eqxMqJ/kF3Uo4/Bf1swgDqKzqb1RNYU4W1rBYitmTmYaurnEh2yJQVCiwyGpfknVBw
         sbbjw8eVEHm6ZcSVXTNYNJl9x8QHDKk2AKP4/bT/nu732Okan662mosSeei4G6UTceYh
         YGGiNqCDBzYf21KUc7ufl3ztwjn5ETniKHGbZbu6P59KBrVw89Sq11Ur+6uYBQ9IRvD2
         qLXVPrVsEhJSep1r8Whv+axZNrbqILqIsAQGA6o6LIfhkPWCjJEnm4yDQXmxSMuhew0z
         TrYOs5guhHIoqcW+GB4AmW1jYcr95SD3XQ3ZBkc3BDWwumcrvLPRcpW9Pp7mHaK7ws1D
         r7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757861766; x=1758466566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qapOJtKxyY0MNaqH7qXtB8qqR3nlxKXEctWyb1YrfM=;
        b=uYuWxBjH9L+X2qtGVMe1OxlDbFXR+JBX09ciMHflW6Y7RfCtvaa63v3oqhZV2hhyD8
         caeSMIzCnydQYdPhJJb3J8r0CG980D7ewQiI8/HZbXb9sAV6285PII3nxAw4UUtnygUG
         z2B5Uq4HvrNNKF5p1DhPly93F0eEn5HF8XvRQ/No28cPVJP2k86Hq2HwOHE1tq/DjfIa
         1vGXstyBjt05YxDY3jVdePtnmcPv/oLsk7PfuQ11jm7/egyEQAW30OIeahk120cndrlL
         zZBJYb0SpRd8gDruFRMSodNUbD4sV8VU9qRpYttTVdP0y2wwLVsI3QoP0cdOPw2ON/y6
         IXOg==
X-Forwarded-Encrypted: i=1; AJvYcCULD6EVNNIkJ/iDFTBQEekpjPB+Ztlz+0Kv8YhuxsrvKyBsNR5jCI6pJ87GHykGo7MwKc/+YErcyncHpVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeYXuv0YB6bZPHUH2DIOTzpTI0DrFBbVOudimVO3ULuRk0dv4
	CwdcRXhDLhC4A/oKwZb3kIZkM7SNNT8jQ7uElQh9YmGPn0m2WgF8Fs6q
X-Gm-Gg: ASbGncuFyY0p9VOPnmI2p4Q0uc7oEQW/fyYKjk5oa3Q1LoaKWvg8Kts6r7FyR5Hi0Q/
	T9cXrHWqreJikUznZorsGObz1WWPtDVf9Co01wGCNYdIq0+QXmwowkVTVKxF3Lw4mTCoh36T/mx
	WKTsiJpseWYqR/O+YMfLAQVRSg0aC05yDzVeMLq72YwXgStRNl49SDU3Z0fX4Wg1Twd2q0TRniU
	cdp5tTC5U3HK7wUXKLAkgv8IDcebJtAmCeiHdcUdkflPQ3tKfvsnn7Y+BOZWN191OkF9jcv4wPA
	40EYBCogRsgEJxuAd8Ky3vhaIhi5OUw2QCktY/eUGU+y4TgurpUm5v4PCR8/EnbsIq329n0wt33
	x4Ne80j3d7UIlADamnZ2l09bfOArwb8dZGZkU0E/Aha4rmRRmisTWReAgkvyNmMvH9gnDa9SIQw
	==
X-Google-Smtp-Source: AGHT+IFV/3JZpFtVZv9IijfdfagkrdK3hCy/JcOZd8MWso5BvseWKVtiecc8/LFjzi/kNn1nTtuUIw==
X-Received: by 2002:a05:6000:2486:b0:3e7:404f:685 with SMTP id ffacd0b85a97d-3e765a197ebmr8559306f8f.44.1757861765516;
        Sun, 14 Sep 2025 07:56:05 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d62besm136303475e9.21.2025.09.14.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 07:56:05 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] phy: exynos5-usbdrd: support the exynos8890 USBDRD
Date: Sun, 14 Sep 2025 17:55:53 +0300
Message-ID: <20250914145555.2631595-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patchset adds support for the usbdrd phy for exynos8890. The SoC
features 2 dwc3 controllers and 2 usb phy controllers. One of the USBs
is used for DRD, whereas the second - for host. The host one seems to
only be used on the MV8890 SBC, which... I don't think anyone has,
really.

Code from this patchset can and will be reused for 8895 (I actually based
it on my old 8895 work but decided to upstream it)

Best regards,
Ivaylo

Changes in v2:
- fix up the messed series (a patch from another subsystem was accidentally
  sent)

Ivaylo Ivanov (2):
  dt-bindings: phy: samsung,usb3-drd-phy: add exynos8890 support
  phy: exynos5-usbdrd: support the exynos8890 USBDRD controller

 .../bindings/phy/samsung,usb3-drd-phy.yaml    |  25 +++
 drivers/phy/samsung/phy-exynos5-usbdrd.c      | 210 ++++++++++++++++++
 2 files changed, 235 insertions(+)

-- 
2.43.0


