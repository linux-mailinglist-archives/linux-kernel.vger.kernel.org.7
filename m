Return-Path: <linux-kernel+bounces-726838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB228B011D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B888487CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E89F1A0B08;
	Fri, 11 Jul 2025 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irQ1SmV6"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA5182D0;
	Fri, 11 Jul 2025 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206305; cv=none; b=jmlM5UXXEU8mQJq1mViCpLRZUm6AP9c4e1QbhTnduqU7wTbKudDDOQMxouu5oWTogdIYF4rn/tXsmuNovuZI5fn+ZH0acW4IVn1nJrqlS+nqiA1T160sz9NzDiwevQkpXfdwEfEcyWnyaG8OiezBPK/ud89Bcbn0EgJvB/sQqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206305; c=relaxed/simple;
	bh=eCnvz1UlgpG0eJcxw9ECiK+Uk5BVPyIsGzFKnmJ+HQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgLHlq2F0mlH0HccpDhEBGBqu/9c03CXKZUY5XPt5V22SedkC2AFPl8noDthaesLn5jFFUn2pA0cROZ5BbhDXyfV7rumuYJVVHE7WSn0jtXsWLsq70if+ks6tB6HYaVpOM3TVGV0oeEFXts8ktG2sples2SzyfIDJh9tgFOodEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irQ1SmV6; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso1714789e87.2;
        Thu, 10 Jul 2025 20:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752206302; x=1752811102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z7CteOKcSR5wpkrtCw/0yNUE4pwZlcXOtUiqDdXOWRc=;
        b=irQ1SmV6WIcxQgLPS3vUWq2UO+iGVqQMjy5pjb58RlVBaCRUpkwS8IY93Qt/yY2vdG
         2u2CTqgZgERa2bPTqIxXwfisVfdGtRX6RXNpUzvaOoqrY89nJ03YTC6yI+wg7v126fse
         0+qFqCYnZTwUpdg7rzQRMLR8x0CAavSBROwUQkZNBRbXA22qzCLuYqLeOb7AqH6qv+f6
         t0iAb15e3QLnrslGiPcO9INvVzcLg57hmaUWRRTYyJusZoNUIvNtWdQ2Rps9V7vDoDzY
         JigxgfZKMMYCxuC6Q2tdte5BDL329wY75upyp6YB3sfC5bTMoMeuUgzJr65u84z5M+dg
         6y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752206302; x=1752811102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7CteOKcSR5wpkrtCw/0yNUE4pwZlcXOtUiqDdXOWRc=;
        b=TGbxD1EDKtSrs01EKHEhbbeTCL4CSC+514tyfCxWblyr7q6aOJhk0wlZKqwym6B4K6
         KKineCRDr4SeVqxJrz0zTOqKhXnNVlVP7XGjXVgtWGQX0kptIGc+zSYDkMzD3H8Z0fR1
         FV/aJBFcXzW1qxpACDs4fMJjIKF7XsMxKpQfdjM1FqcPk8rhDee5//svCw1vcpc1t+Im
         brzQIkFXC6jOl67sIOCKJI79zp3MjVx/lSWp9Znz39LYGj8VSpSlAIf5oT+qUPSPmL7s
         Ta1B2ZK5Ikn3ZptbJuV61MZfYy17Modyb+AEF+7vHE7tKTIetRIMvSw9IFjIWfAkURJN
         Rrgg==
X-Forwarded-Encrypted: i=1; AJvYcCWLdOGC8ACmTDDxlMdbP+JkPXSWuL0HneWlpse35lwvLRBSEBD5HbAfd578yP3Mc4ZNe38uFQpc+9Xw@vger.kernel.org, AJvYcCWibPSekpPVUiVDE7JCKP69xzzEqwSeMrw0n1W15qI0dv1oUmpxbdrN8AAu/IG6YNNQ8GPOdA1dr6FIpzrf@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRxgIJ19Yzbvf9BgYQsJRypH+cY6tCnpzlgZbWpnjxLiIokSL
	pnR6ws5leZisNTBFEDXw0Mcp2X1KDVWrK7+GwghDOv88qJ0TU/7qh62m
X-Gm-Gg: ASbGncsSr3q4ko9xNF3M5gau9koNsh27YVKvADEVCtdE/4UfbVUyHZ2iJR0q+nxLU9k
	d/JQ1FDMSkBeK+0CpmSTSTzYMiDDcoZHCFfO7lvpfHI93J2iJ/qYQNbPrg3CPOi5AdiJ1qKkiJF
	Q3mEq1mgAKTxbwa9duxZWI7iBayFCI9hcvMdmncSmKyz7oxpJXcRPDzCLI81HKYiiKIJ76QR8xp
	Jj3pwobEmBl+ObFHV6a0G74ZRMocVgq+hqkuhM0xsK3Yu8c6hTv3JVkZ7wlmd79lK0cQA62gJDo
	JXtcX/2SNx887bMiVnhJidtiVeZUaGHZAv5TnWf30y6ts20eYcDlPwgLamT2l3cFkT/gdZoAv2R
	kO3JY2jZyHf4=
X-Google-Smtp-Source: AGHT+IGqjUC6+LzbpSLGosnqY439fvJxlZO9uR+Y1dc/WDIuRFhbiDBiR8QodGnlwa6oUPkK4Xs4TQ==
X-Received: by 2002:a2e:be11:0:b0:32c:ef7a:ccf9 with SMTP id 38308e7fff4ca-3305348a960mr3406601fa.32.1752206301782;
        Thu, 10 Jul 2025 20:58:21 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa2943d46sm4971191fa.40.2025.07.10.20.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:58:21 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.or>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/3] arm64: sunxi: a523: Enable Mali GPU
Date: Fri, 11 Jul 2025 11:57:26 +0800
Message-ID: <20250711035730.17507-1-iuncuim@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

This patch adds gpu support on devices with a523 processor.

$ dmesg | grep panfrost
[    3.826968] panfrost 1800000.gpu: clock rate = 432000000
[    3.832305] panfrost 1800000.gpu: bus_clock rate = 200000000
[    3.838353] panfrost 1800000.gpu: mali-g57 id 0x9091 major 0x0 minor 0x1
               status 0x0
[    3.846050] panfrost 1800000.gpu: features: 00000000,000019f7, issues:
               00000001,80000400
[    3.854134] panfrost 1800000.gpu: Features: L2:0x07110206 Shader:0x00000000
               Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
[    3.866011] panfrost 1800000.gpu: shader_present=0x1 l2_present=0x1
[    3.874108] [drm] Initialized panfrost 1.3.0 for 1800000.gpu on minor 0

Since there is no support for image output yet, it may be difficult to confirm
functionality. This can be done by running weston with vnc access using
the command:
$ weston --renderer=gl --backend=vnc --disable-transport-layer-security
--xwayland --width=640 --height=480

After that I was able to run glmark2 with a terrain result of 30 fps,
while I can see that there is a load on the GPU in nvtop and the CPU remains
unloaded.

Tested on x96qproplus and walnutpi 2b devices.

Based on v6.16-rc5 with patches:
https://lore.kernel.org/all/20250628054438.2864220-1-wens@kernel.org
https://lore.kernel.org/linux-sunxi/20250628161608.3072968-1-wens@kernel.org
https://lore.kernel.org/linux-sunxi/20250627152918.2606728-1-wens@kernel.org/

Changes from v1:
- added compatible to the documentation
v1: https://lore.kernel.org/linux-sunxi/CAGb2v67Pu7CTJx3K=3CVSbQ9mNB-4Vrq+iaA+hUWtxdwS2aD0Q@mail.gmail.com

Mikhail Kalashnikov (3):
  dt-bindings: gpu: mali-bifrost: Add Allwinner A523 compatible
  arm64: dts: allwinner: a523: add Mali GPU node
  arm64: dts: allwinner: a523: enable Mali GPU for all boards

 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml |  1 +
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi    | 15 +++++++++++++++
 .../boot/dts/allwinner/sun55i-a527-cubie-a5e.dts  |  5 +++++
 .../boot/dts/allwinner/sun55i-h728-x96qpro+.dts   |  5 +++++
 .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts  |  5 +++++
 .../dts/allwinner/sun55i-t527-orangepi-4a.dts     |  5 +++++
 6 files changed, 36 insertions(+)

-- 
2.50.0


