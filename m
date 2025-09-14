Return-Path: <linux-kernel+bounces-815830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B466BB56B94
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962D916F804
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638F2E0407;
	Sun, 14 Sep 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4V9BjNL"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E22DEA97
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757877976; cv=none; b=O8A68B7AJTXjGSHMdDoTr7JAxFqeIQlKo2yub2fqrM7AKFHMJ+EbsCLI3Y4Oxk5JRISMan7D4HAh/8INbX0DBTZkZNLIa7lTgS6ABdDOrw6WsMGHm6bpXSJ0HMQgXHrM3TbkR18mrEzZDyyESrI6aFAu087LqxHcN7tgBwbZE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757877976; c=relaxed/simple;
	bh=Bwvc4rU78HriKtF+dQxnrLeZu3hmtBcOywpMflC+wr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LppO2D1Z4c/6Oesg2Xpnj/6bfgQQE/ejX4TZLGdOedW14Kgw3CHM4oXMCK5IXwoy7+3k+CM0EK0z6e1ygDf5VYNhX/gg+dZX6DejUOEyGib3zUs0utLIYtvsjZJdihNG4wCxpdOLFXiUU+GG7b0faBV7cPvPSM8cGeuqTJhFRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4V9BjNL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so6934957a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757877973; x=1758482773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tWORggu1OBca7WXmFFjWgrVVhHzQJbGxIik7S26mM0=;
        b=l4V9BjNLhZlpd4omsZNmvmgPSoNxOTVQxMXjz9UqBAyP15KYGyQO9FMvuAcGQteykF
         +AF4f+CdDZXwh/Acgp8/Nrn8uo+fsnlgzaPeJ1uHSqwH+p4WUfefRZSi0g7Gr/2qprjJ
         tUcWfxvywzLNSmd0sU6GHJ6avOmsoV2ItaMd5OZPYYJS3mseXWR0HFnPHSz3c+ol97Gj
         Q2mZnRvge2qrSvtNuqixXrrv3ZxFg/S20HIIprZGCBwjBnVT29rN1byQCBFPjSEMS74L
         I17zTqpY5enWVa83cFhvwVny9zCiiRpNagHonBGep/olBISvgFP8vfA00xFGw6LmHIBb
         AEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757877973; x=1758482773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tWORggu1OBca7WXmFFjWgrVVhHzQJbGxIik7S26mM0=;
        b=ZbJBw3haVXP+5Bi/Ugo0mb6+Vjxt/OOkrweYkTGSngcVwO0ryOTCz4FBJb23eNHKEw
         0U2sJvla5HF6PKGAURq80itIYc2kn3GiUQgt4onYKldFJw4FXfag6bSEAv+EpMrwyR4j
         I9T74L+JRtF3mqJTsUfvpj+3DPAmWetSZwrAoVEkDtFSxRslZZsp0xHjPg/REO/6mjo/
         HjDfhDl42A8JXTHCg6d3ms5vWLWQph9aaev5BAwhkIDkf6raM93KJPC6WUt1YnkzOv6r
         2SJ9jcyuDk1QO798Gbg/RhPXr8kG/B0tDXVwLGVxQ0d9mL6zAkcNbkw4EDTlHTNQUrRe
         fKoA==
X-Forwarded-Encrypted: i=1; AJvYcCVrpFQGHIo5sRmXVg1lWygL7WGIGk6F87VB4PyjiTwrFNV88YUfp4vjH4hwUiDATG7EiW3JzEs9iF0FWa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfcNoLUKR7tgd2Ppd9mYMqP3Sax5cT3KTOSQyapG4w+JzC4JLP
	PlJ/mQijHZ1Eximq0NKpW/nC1G//qI7jVRi21zFP51xBYUkGB5x6ybU=
X-Gm-Gg: ASbGncvbTIndgx5kM8TVkSxHh+gknl5GQRemyrm6N7cakex2O3L0Sf1GalPN+tg0A2h
	Krmj9WQlCRnZGf2Twp5IoxIOTakBzJvKhpGGNyBK10Jpz+9D6xsCrPaiw/fa0jiLCgrVFulbVSd
	us6/5UwSDdz/Lm5s/p6e1v7KmsrB2lMvLG5skkJA4aEW1da8ErIdq3B3nAfOrsWX5nEIpan8BFE
	YtCidEoVjKG1+ReLUTp+/I49HQNS/UpQfGXiatSXyK+bvNx4V4Ix7tkzaI2p9bpr4I4kDY3ppIT
	aHI3nK4qCMK25pLeXfDgNfIBblpYWlXA3EutrzOc2Iw9nP1jWhiqmz2B6P7u4vR/bpmlBNq+7iX
	GDQfYYmYcwYw/9PGzWQB36FUXI7+mipoq4vswoOduvkWsGi0dO22SH/RF3g==
X-Google-Smtp-Source: AGHT+IFol1c2OgKrSsYSL0V4fY6x5qf+hsaS07Lg5SpcRo2Kco6q28gBupc4uxTJENFANQGaH+5BLA==
X-Received: by 2002:a17:907:6d0a:b0:aff:fe6:78f0 with SMTP id a640c23a62f3a-b07c3a65e38mr1054189466b.54.1757877972891;
        Sun, 14 Sep 2025 12:26:12 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:226e:7d72:f695:46fd:3aef:7487])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07baf35488sm707841066b.38.2025.09.14.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 12:26:12 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: andreas@kemnade.info
Cc: lee@kernel.org,
	krzk+dt@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v8 3/3] ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible
Date: Sun, 14 Sep 2025 21:25:16 +0200
Message-Id: <20250914192516.164629-4-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
References: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "ti,twl4030-power-n900" compatible string is obsolete and is not
supported by any in-kernel driver. Currently, the kernel falls back to
the second entry, "ti,twl4030-power-idle-osc-off", to bind a driver to
this node.

Make this fallback explicit by removing the obsolete board-specific
compatible. This preserves the existing functionality while making the
DTS compliant with the new, stricter 'ti,twl.yaml' binding.

Fixes: daebabd578647 ("mfd: twl4030-power: Fix PM idle pin configuration to not conflict with regulators")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v8:
 - No changes.

Changes in v7:
 - No changes.

Changes in v6:
 - This patch was added in this version
---
 arch/arm/boot/dts/ti/omap/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-n900.dts b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
index c50ca572d1b..7db73d9bed9 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n900.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
@@ -508,7 +508,7 @@ twl_audio: audio {
 	};
 
 	twl_power: power {
-		compatible = "ti,twl4030-power-n900", "ti,twl4030-power-idle-osc-off";
+		compatible = "ti,twl4030-power-idle-osc-off";
 		ti,use_poweroff;
 	};
 };
-- 
2.39.5


