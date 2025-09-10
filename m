Return-Path: <linux-kernel+bounces-810358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F0FB51942
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BEB3BBB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768DB324B2A;
	Wed, 10 Sep 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuGxusdt"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9126FA77
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514340; cv=none; b=KrTbOVtKyQYo8QtvhYLtzAqTv48nbtfkDPKTrXYOn931mkqTz0RA7e2QKUk3RDmtrw1n2yeKF2ZYtjB1silAQTrqvqxzvz2bKoXJrGTAlB1eJgPLgSXJI23FhxZdzMZq2a4eRyROivlnwX3UiRjrSCaLiLn0jc8/Nd/bpw54UCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514340; c=relaxed/simple;
	bh=sz91Zloakcli8G5vFjtjjdi2c1ro9ghZGDytEBUH0iw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Jm3pJ/Uqt6qOrtOaAHePYNgVT9QOA5gHTU5f6MCEqTYIoXGJL+LJQtv/DvUjjfKlvRBanNdVem+eDLOytdB4dWynHnEViyiNZcdbzlJMvNcnLr6qXAtNrnfMaVFyUywcELC2kLLDBu17JEoYwIOoyDclfUlTVh2XZdqNTOj9SUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RuGxusdt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b00f6705945so84172466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757514337; x=1758119137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiwaU6FIAzKELv4o/QafaY+UUTlkSVnAGn1VPDhP6ws=;
        b=RuGxusdtOyD5oiZMmhhrbMnQ6/k6KcUou5tyEQeyPAmYn+t0Ut/mt0fO22Ez0dmzrK
         R9WBGrPMntOwIy2DkAWGKalQt8sdy30Yj+N94jaR50LQjXojwO5A6tVgeetpc/OL+Ilb
         VVUWSeqH0/rPDGh8XJSDlofkI6F0uwFzXWaGS72k4c1rEOGckiTNphh5AMpgKb/Z8PTy
         95txuZ+MOORiEIbL9edcvzNG18ncGFELBnTgEdMsIZTK8G3cJTEcS7s8StqISi3ui79C
         pdqEE7kEl8e2Bm7Cs5KdO1V7I3+huFJOAMzBV+08C99tv2hGZjg4RY9KnLcMiUYdwdiI
         uvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514337; x=1758119137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiwaU6FIAzKELv4o/QafaY+UUTlkSVnAGn1VPDhP6ws=;
        b=Uvgm4Jt+OT9BVIMiE/f4P9CU3Ooo/oFre+WpLLdyDP/4xJ/xdCEn+wDNtlmtUyzWz3
         ho20IQCSBzlcRHCKDvG43kUJICLGTqGf5K9LodFfgrzl1E+Ji4Jf0QDy6J+PjBUmUedT
         sDjlu61ZqErx58cU8v8BDpRyiCZon0V5/0lWS5+YCGFsTOW9rBhB0TokJtyBdDIDIxkW
         f/dMacdZqsi1LmmTx2ftrdGoBk+voKnlsLtRPWhMJWeDerBIuV9EiYqWs/Qch5ie9rKj
         0vcRaoJG/fqXZxl2nQLPS9jd2LBGqYE1D6Piy2TNC8JGAhJJMHQUQMw9ZBktVMQzvSY6
         JU1A==
X-Forwarded-Encrypted: i=1; AJvYcCXDP4FYOngjhROodqGu5aMGUbjidtY0+drg5JvZokBAeQnO4rdXgKC/0MfRm2Cl3t3Btn3mR5j1GhcipHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YydIPlIzQV0yJ+gWqZXenNHfsfWazedfN3g1/kbyyPoburbEItC
	/oSCB9gWk9f4eMT6o1X1If+EKGy2aZ4HvETEMnIsyNxb1WQBdr7siHijDeQQJxG+ZNE=
X-Gm-Gg: ASbGncvsyKPqGTfLmGS5sLVr4bLH2XUKGp66pgrxrxYWLwBWPoIW88had+465VHMrsN
	k60C+IPXnWpumoSezA+XxbJM8YhWAYrjKiN6BnxH134LWObI+kAim28cTqfZrYiO3A6Yq7tsPrH
	I5x8QK4ILdyEm2fmnbAWHAC2EsvuxCxXDl1cJJp03INE7HYQs9NNh17seCJ46t9oEPTl0MN9MWC
	HAx/sIzQs6uLYZ6XMFZcOxe09Bh7WIGYNneQ2z0yuoxyULkgohR6vk/IE1AWtH6jJFaSpGGipr3
	rT2UJAwBl+Ss14KkmaoPXRfla/xnb3OZNWzS9xHDX3C8eiXy33/gKTilap82l2zohc08ZUymsxI
	JU2PYe92nXKcIfoFFHUmYrhN2fPoFMB0V6w==
X-Google-Smtp-Source: AGHT+IGv1poiX6XMu2CzWbLyyhv3D9ziTLRppA3CCyTGGSqNkx0aCEoiq5MhBrRwBYrVTHIVFPc3GQ==
X-Received: by 2002:a17:907:3e0f:b0:ad8:a2b3:66fb with SMTP id a640c23a62f3a-b04b140d1b9mr813384066b.3.1757514337318;
        Wed, 10 Sep 2025 07:25:37 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833a0c94sm179071266b.72.2025.09.10.07.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:25:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Input: Drop melfas-mip4 section
Date: Wed, 10 Sep 2025 16:25:27 +0200
Message-ID: <20250910142526.105286-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=sz91Zloakcli8G5vFjtjjdi2c1ro9ghZGDytEBUH0iw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowYpWVU3H7O6NA0Zkp93/4ehpEU4f7p6wxmOj7
 jsjqHuP9MuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMGKVgAKCRDBN2bmhouD
 1zQGD/wLvY5yHmTOdi95WNhJOVjmiYcAhRFWok4FRDccCVEp04HTtCTEzf1WENRVPHmOshFW2M3
 GFlPWg9G0JVV8BUgX/joysTtWKf6dHI128M4fSp63JuchwxDdBqTopAnLoFiC1nfoZGz47cvlQD
 GtmY/Zli3725ym8rw41PSVV8KSyVk+seqmQLwtbVpDeVEbkUcopmsYAvETLhvyL+GdanzMj9Plq
 OrJO98Biddq1A9VukCGFvD1eFXsdU0ZXqZYFGa2RGpZ3Hv+qKM3oQ4AruU5ekRCBuS5K1NoTvHA
 4h1kEtOjfp/A1zVdTxsHOSDAG9AeDCKQbWenExW9euOlmqpcgKm5IwaN6E1IWV38zrK9ZZ5ihpm
 /pLvKShD5Edjqwv3w1WALyyMUIq5l4eMQSLZRdo0Wk1yCFWudewyCAM5v8U+MM5+mitnaWrHSxo
 BD3NwBWCWHcYt1rXWXR31t3GiDC8Xzd5f0AmAYbkHd2t+qGYBjLlDo42cP6x/sMoGUc9OsLdF/Y
 qBQWPlWcBtVlP3+eD45qW9+sQPyFzS0w7Ive6kHb44UBscs7wlNhLEwXMbXAedozPI2hdil+6DE
 H54ZpAVDs7E84OdGgVH63v6kIFoP6jrimVlxsoctyReUHHGRRUMthmdAHoJaXx6r8HV/8a+y0It 62t5pDp/ChnarJg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Emails to the sole melfas-mip4 driver maintainer bounce:

  550 <jeesw@melfas.com> No such user here (connected from melfas.com)

so clearly this is not a supported driver anymore.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 135c03ac1bb0..f8e45e0ad5e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15863,13 +15863,6 @@ S:	Supported
 W:	http://www.melexis.com
 F:	drivers/iio/temperature/mlx90635.c
 
-MELFAS MIP4 TOUCHSCREEN DRIVER
-M:	Sangwon Jee <jeesw@melfas.com>
-S:	Supported
-W:	http://www.melfas.com
-F:	Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt
-F:	drivers/input/touchscreen/melfas_mip4.c
-
 MELLANOX BLUEFIELD I2C DRIVER
 M:	Khalil Blaiech <kblaiech@nvidia.com>
 M:	Asmaa Mnebhi <asmaa@nvidia.com>
-- 
2.48.1


