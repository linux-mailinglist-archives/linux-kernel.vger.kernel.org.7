Return-Path: <linux-kernel+bounces-779564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D0B2F5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372DE1CC2D13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCE3093A0;
	Thu, 21 Aug 2025 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBQ7YQJ3"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA012ED17C;
	Thu, 21 Aug 2025 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773807; cv=none; b=OCFIHhKSo8zvHFH7AGI3AFw0i/HqolBTYBgpEtE5p3V7k1dlciGZ7Z5YpFZ+mdkQqJFeI3h3VSE0pbIJGtUwdOZY/ojHrJ2y4HXk1j2A1lEn1sP/l2oUCVYaX6wUbwKISmUEKSLR2G1GnngYsZaBaPlj7O7aV+HAKr0mWbMYoK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773807; c=relaxed/simple;
	bh=FoGQcz7DeqX74u0WtayvPR42rWrDI1OCq5th/Z+nfuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NLm0FiAP8pkGY6xdfunVWIpdi4J5gLIpykS+sa793kJ5tpoOHMY8iZP2a3ysbv3yuQ0RbvifetoyXyjA9w5HMUzGMXw1/kDAxbw2VjkZ42Z+/UMNtLr0aHKPkdODfOaMOAVAOZY7qHl0TpI1KxmlObKd2z4QlYpnRffkkIm5pek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBQ7YQJ3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb79db329so122475866b.2;
        Thu, 21 Aug 2025 03:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755773804; x=1756378604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sMyUEbLcanRX5H+fT/hbCuFWtgzsfYsMYARRkrN4bEM=;
        b=HBQ7YQJ3yJkV1gVlVa5Z/Ro7gbnpgalPFB8yOCkcgLE9OBj2l1wvQ0EutSXsdoWamS
         tueNsZSs3GbM4XjJNdSVjrP5TlVBcSa81QV6X9aWY3mzGGn9rwVQ7DWHnNlg8x6QL4do
         EV6OrjrnNTo+p+hVlj/cu2mlu61Tansdzq6UOqLgzTPOjo+MOKMBmFRZNZfTyXJeJPEg
         CWYZq//BqDY55mR9vOtZT5OSvhlMIIxsgQJykxdrFmvyzp97OrTWKG7y22WPSondEO7p
         xGd5tlqP2Vpsw3EXYVbH3O1fFZzpe6nUmz8hR9hrHK/me3cTnQ4AvzIZzZaPFSdlT4He
         6iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755773804; x=1756378604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMyUEbLcanRX5H+fT/hbCuFWtgzsfYsMYARRkrN4bEM=;
        b=Lz6rt6VgNuPzxcmF/BBd/olewkaUmRKFc/s/9sEPuN8dX+Us42Y0XH/Y3emlqFWWXt
         YL06hHAZVwP3jGzP9qkMjPR7NGghcmy4DlifM0/8WOV1BimZTDgS+2hRs1vR8kZw/fTr
         wqG0JpWp5lf4LfoR7jzoqf8FDu9lzGhIJIJNa9HMd1tKM0+2sAw9zbnGsKJzRP39gpLs
         5E64z7z+57OifqZhAdWbsAeEylcQHiBxA9F92KMQXneHbtQpCS1oY3ItGQxQRLIhLdcW
         SGqg0XsH29fG3f+TajKs/ANyWybiLAyNKbhz33CQeWgUlmEMgfoX4QTt62Q3OhKWMibd
         QBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU87WWAhi2iGfBLomd1i5g+4HIllBJU/sQ1IWenzhAX9Jo5pJjMFAqK0UjWS60XTbl/YVpyrey38mOh7XeR@vger.kernel.org, AJvYcCWiSDJf9fGcvBCqBxTkn6WrtcR0Q163yjdjy3UEaKDkvaV+rkp0VlcGwAwDIYS7JNK8ai/0no5G37SD@vger.kernel.org
X-Gm-Message-State: AOJu0YylCKELR3iwArmSNQfzTG1GaOUlULvrvjQuEsJi6ZJlks4+n+bg
	aMYr38VWdemRBrUHrRjco8gG0gfhTvtqRlzup7EnO4spj5Y9D1h4qx3/
X-Gm-Gg: ASbGncvwd04T2NUngYOvsoLQpQoSdLrAH5CjpC1oGTE+pNG0+TKvxyukPBTxBlo/I1A
	OMhsaKIF2WaWoqoFtMcUOvHk/BCK+yRERuO4AIy2nBCOewVz998UmPSIrJLnnVTNinix/ecDSfE
	yHnCcdDGpOOVtV+RSQhQC63xoh0y+j81IleFVd06neBZN97kcrlXOIzMKue4eSvDNoRoP7hEDwK
	Gh/AeJ7pAG36dxRm9hCIZp0SOUv73BjEQsRc0BXo31LQq+nlFXPmvR7zBDX2aWDwQVo3F/uOF/q
	S8neQpxyzFLipPaA5lDfbKoJP9ZSqJZ2XZw2I3PHn6g+A5hM4tl2Yhp0kByiHB5hEVtYrLYKhoc
	zlTuvYukRdD98PybiJtPv7+gcQyHedL1XUcOOWtYh2Dl0ZvacvGo6
X-Google-Smtp-Source: AGHT+IHms9vlv4FD5+T1jUisxyplhUFRbxyMMUf0tERN5qe6K/kx17X13rQpCE7FAsb5xSQZMirW1g==
X-Received: by 2002:a17:906:f583:b0:ae0:d9f3:9131 with SMTP id a640c23a62f3a-afe0781c6c1mr151935066b.6.1755773803670;
        Thu, 21 Aug 2025 03:56:43 -0700 (PDT)
Received: from DESKTOP-TTOGB9M.localdomain ([92.120.5.3])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afded4790bbsm373602866b.56.2025.08.21.03.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:56:43 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Switch to using AIPSTZ5 on i.MX8MP
Date: Thu, 21 Aug 2025 13:56:30 +0300
Message-ID: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

This series is a combination of the previously dropped patches from [1]
and the config-related patch from [2]. This enables the usage of AIPSTZ5
on i.MX8MP-based platforms.

[1]: https://lore.kernel.org/lkml/20250610160152.1113930-1-laurentiumihalcea111@gmail.com/
[2]: https://lore.kernel.org/lkml/20250707234628.164151-1-laurentiumihalcea111@gmail.com/

Laurentiu Mihalcea (4):
  arm64: defconfig: enable i.MX AIPSTZ driver
  arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
  arm64: dts: imx8mp: add aipstz-related definitions
  arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'

 arch/arm64/boot/dts/freescale/imx8mp-aipstz.h | 33 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 16 ++++++---
 arch/arm64/configs/defconfig                  |  1 +
 3 files changed, 46 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aipstz.h

-- 
2.34.1


