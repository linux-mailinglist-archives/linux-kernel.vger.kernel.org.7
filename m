Return-Path: <linux-kernel+bounces-829130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D4B965A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A3C170C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06534289E13;
	Tue, 23 Sep 2025 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l7yKRojH"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C26264F8A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638281; cv=none; b=mFiYZOkiYr6BmNGymyIbRacSGGqYx93L9Ly8w1p0+SEvlq4k+24MDO6/uKn6L7DNEgDlGHl+EyOkuKoYRrJL+OIFn/d55ZbtAFWWagQYL0DvJ6XiwTC1UrDeF0So6pP0Vt6Qf0Bc7Svnr/YwcDtWeSSCcR5LGvAUtu8X2UXnA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638281; c=relaxed/simple;
	bh=vk6FwPi++rlEIdnq7B8swuH4Hfip4zJuCa4DgVBSD4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBI8btimg8amQxUeC+kZ0m4aAvZUl4vEbWg+QKq0GivsQaTHleif9s/BrbRiSb9vm3tUWnYmmblVRM+RYUZgnau7N5JHcHt/CApE4zA1a3MOhmBrJuLhykKkC6SZGzN9BsnAK/6YkULHSxrEnQXs8TvfP/3HQuwvgwnifB0FjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=l7yKRojH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b2b4096539fso377036566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758638277; x=1759243077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIxVfZFoAEsIwCtiKpIw9ltXsqh5nL/d8yl3mBu/8Nc=;
        b=l7yKRojHmr/mJZmd8M7gn3XgCqz4rF3PUCd8ePCsDIKrimpRXTgxyU6WwH/hgGOQAu
         +JsHV+tdhDuMrTpAFLD0kg/t1hm021kTodDASdsG1Kl4xPSnyFvsUXWxX279Mt3JLCFJ
         v955NI+12GkDBNoOaXxHGAa0FSy2zPiDiMXbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638277; x=1759243077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIxVfZFoAEsIwCtiKpIw9ltXsqh5nL/d8yl3mBu/8Nc=;
        b=H+W7ZMfNrnDQrl2/hMU1ILgFkCr4KQ4R6k18k7moBuyGoRTqknD7+JKiFSt4QaCA4/
         GV0yBo9rkcjg0QPNuqWBl4qQLzKjjbJgTxubYWIeNCk4SM5yD5N24eQ8UngbYMbS5xA9
         08q4C8qB9bEdw/43YusN6fB5wo1MR8DwU0L6VbyeyqbXiAFKAiImns98eKFTcNo76liR
         DOM3Hov2FR+NgOhf9ufnvipvTmkaOzAC/1cL3L3t6SHEIH8dQCgqwLYGgpLH+xUHAH0O
         CsIzoo2hzg5XCsMJwofoze6nQKByBdGYbm4Jfw7MutJHzpnuGy/L3WfDFu8mf8j9WmZV
         qDcw==
X-Gm-Message-State: AOJu0YyQQQrQjrcXMEERqewb921ODpr+s2WYYEasJVR79txASFQye+tZ
	mJL7u7MDwHZogaXJlMzCcumsXvhMl+zN9vFQXHS4OGNJ5ydw+/BKz7xMItN52qq9CZyxTAvaV7s
	AYSzg
X-Gm-Gg: ASbGncsAb2lKn0PjPAk0jJz1LRHdtW1lMg3UWiOOC8wG0mWr0li/mNc6s2uKTm4LKux
	JvVFrjIriicv2sMdT7NAI5r8W96eKSoUviK+aWTi3EMRVTqao75RRx/k9G51kO9bYxIFlOzSKfz
	BZHJamS0jhfVnNKlslsOCRM1xQ84NAWepjNCiy1ZypTtEZf0Z0CdqWgS7DXRf2B6Z5c72Aakan6
	BH7o3mLEKLMbxr6wEIHNQg5f/Mx90jr2Jwo7qla91HLzm7xAPWON96ZXgJzn3MR48+M8OrUITDX
	67m5wveaynVUd0/vBs8A1mainDx+5MXMx/gYaldmlb8NgS3JIu0ARaXA/g1jv6/AHLIZToH9NTt
	0ZfXoWe6MQV7Inqt8uZ13M4maobNJJ3ngTyntlPbWpcTOvfZcPXlXH0r7ieOhXCPN1IStRvdDC8
	x6bD+D2EuIuX28cwChaEyBrlIblNYiwaJ8g8IxXkLorr1ZifSZ+NIqzatdtmnnfswL+kS7hVu5s
	y8=
X-Google-Smtp-Source: AGHT+IH9SMkFkR71Kx+KKn5T55TYlat8HlxhxiB+GViGIA9Vt0hQfUrdnZ3e8AKspkcyGYH3r9r1+A==
X-Received: by 2002:a17:907:3d8d:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-b301e5ad661mr314613866b.30.1758638277092;
        Tue, 23 Sep 2025 07:37:57 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2a2a5f6c7asm665204666b.28.2025.09.23.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:37:56 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 5/6] ARM: dts: imx6ull-engicam-microgea-bmm: set touchscreen glitch threshold
Date: Tue, 23 Sep 2025 16:37:36 +0200
Message-ID: <20250923143746.2857292-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
References: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This way the detected signal is valid only if it lasts longer than
62 µs, otherwise it is not sampled.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---

Changes in v6:
- Rename touchscreen-glitch-threshold-ns to debounce-delay-us and
  update the value.

Changes in v5:
- Add Reviewed-by tag of Frank Li

 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
index 279d46c22cd7..f251a1028355 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
@@ -154,6 +154,7 @@ &tsc {
 	pinctrl-0 = <&pinctrl_tsc>;
 	measure-delay-time = <0x9ffff>;
 	pre-charge-time = <0xfff>;
+	debounce-delay-us = <62>;
 	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
2.43.0


