Return-Path: <linux-kernel+bounces-824220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EEBB886B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC6E7B6712
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FBC2FF165;
	Fri, 19 Sep 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="aa0NPGEp"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE82E7162
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270571; cv=none; b=MwSQC7PrVVVl6bnKVHrR/FM8m5h09vOduJxueStLQ5FlWB0bAylRK6RA6qhj1iwV0cpINa01ndzb3F9YKSekoYSckjw+8lnjvy3FmoKTzFJNJXEPgWHauDxakcCHcqsuQ8n9IVCmywPVuuZECsIQlzRl70+4FmBl4TGau6loicc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270571; c=relaxed/simple;
	bh=As52a1nw65MeS2EVDNnOtJqa3+aKLFvzaeDu8JielLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIHsgyKV4WFEZttw0rhLovStx2k1UWLshRjlcqdpbUABGGI8KP5T/iWN5L8UYUVel2t5Dml2Erwp+1Xor6znq8xIB52FnXD81L57lM/4hIrQu/Mf0yjpGk/oEg2CnHYGZIm1InF9wZUPipmYfEyOCQc0OXzHz5wbQyiNTCqfnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=aa0NPGEp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4687b41fb56so2083755e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758270568; x=1758875368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Iqorv+wUzYclI5plYgg5gZXidkIOyHodYIQisr+Wws=;
        b=aa0NPGEphQblj8Zl5Q6TZqM0/mrDmTaofSSu49Fa6bNBc1wNwtOyzaDHLO64zf0qYy
         mtE1f9Sp0NmpoRE3863a4uLeBIA2soa5Op22HsKdT2/hl5zinT5veg9L1AFI050USfeV
         AzJnAlDHftbdzid5tS+/p2mJArop+M6ey4T4fMT0VG8zMsPSMADRi0pE2OJ0MYZfzQ5S
         DagLo12TTQzp4zkaaIF1Y3kcBcKenJL598GRk+QM3KfrBMOYnjYV7kl9LsegzKZwG+4O
         shKi4aXd5lqwENETgU4xlb3rS3FnByhW4IEMwmaEv8BPrOpS0iTrlx2tqNj8vDnUTuRi
         qugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270568; x=1758875368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Iqorv+wUzYclI5plYgg5gZXidkIOyHodYIQisr+Wws=;
        b=f5oVSMFKg/189bwUcOwH5LtHf6WlLo00bQ9Zck02yP5U6uJZjOG7IupWvYRouLmixZ
         7X1BDEv8L3Os3zxjMkCAiF3tl2nY+H8JWeMZvgQ/Hq3fZAfJz270SFGhD+vVgpmfJ7Dz
         9m0BW+Pf+IOR9a63BLvxYKyMilRcbBLj2m0BiQqH+0TICSK+lM9hFnXiCkgMWdI+iUqg
         seEsJ3Qx1LesEjoTvMFfX/kBLbvHyWaDtGX0Ha90NJs0wZIHRtge4iE//zSfzPmoPzx9
         8hs14LUacRDkux8MSTTpqu+ekbG3vYzpEQJtzVWaQpsHUFESeQKFizvjms0v612lqwA5
         tZyA==
X-Forwarded-Encrypted: i=1; AJvYcCXHrS+k4dZXsxCk8zngSE321fLQ5hr8iNV7Qv9ojQzm4FSwXW3Co0uFOr4PvrfZFXy8SdfEbH/JrMj/thk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywyoFFec6hzCiLQoo+TlVQvyczri1V0zFxPlH+jl92RGRMICVU
	GZ06N25OcjqT/+EU5sI3KiGCD23d5lwlKefXZzZR4GScYZat57cdmbtipJv38JkuYdU=
X-Gm-Gg: ASbGncv8lflMWO6SJRh0OlvxnXq0SI0V36xJDKxSiaWAjhgxygnT4sDwTFtE+sA1f2e
	oURBEpr+cBvoBF912834pUbHmLssWKAit5LAi/CaHoFr+yKktHCuR04/rzmibPQDuLdRHawx56F
	8gUgiK3njBDa8zMyi5z+QQf+yGb3U9R/mwLc8tWQksMGH4/eCgKWSyZ3wDWVwfycv5eKkHyoyuL
	ogHRtPdLuECBUqv3+nycFjKPOKdj/Yarh62I6MhxsXuPdKgOdX2hC10TGp7J/8lVe9Kp1spn/vV
	rr2HK0SGZYEQoSXj1nLiPE/8wqwdDJJm+SVCvs0bj/7ygY6MJD+NOggFcBMea2K+h8h/XFgCIOw
	uB+bWM9VCwwbLcYVW1dt3rKfD1DwsxMjytlwd2MefOX867A5hkAdzeNJv6Dg=
X-Google-Smtp-Source: AGHT+IEtW9bDEtW63n2FFQFrDqExocPHVGlNiU4ceV5mEcoaeM2txyi9xWtkdtxYtKJI6N9PvSedCA==
X-Received: by 2002:a5d:584f:0:b0:3e8:f67:894f with SMTP id ffacd0b85a97d-3ee1d504e20mr2552236f8f.26.1758270568481;
        Fri, 19 Sep 2025 01:29:28 -0700 (PDT)
Received: from fedora (cpe-109-60-83-189.zg3.cable.xnet.hr. [109.60.83.189])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee0740841dsm6771286f8f.23.2025.09.19.01.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:29:27 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	steen.hegelund@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/2] reset: sparx5: add LAN969x support
Date: Fri, 19 Sep 2025 10:28:39 +0200
Message-ID: <20250919082919.19864-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919082919.19864-1-robert.marko@sartura.hr>
References: <20250919082919.19864-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the same reset configuration as LAN966x, but we need to
allow compiling it when ARCH_LAN969X is selected.

A fallback compatible to LAN966x will be used.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Drop driver changes as we are now just using fallback compatible
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 78b7078478d4..59245cd0c393 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -170,7 +170,7 @@ config RESET_LPC18XX
 
 config RESET_MCHP_SPARX5
 	tristate "Microchip Sparx5 reset driver"
-	depends on ARCH_SPARX5 || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
+	depends on ARCH_SPARX5 || ARCH_LAN969X || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
 	help
-- 
2.51.0


