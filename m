Return-Path: <linux-kernel+bounces-885563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B5C33568
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EB042708A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BB4346FA1;
	Tue,  4 Nov 2025 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nPXEu8nd"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3333DEC1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297621; cv=none; b=mhN1UYcA25dM3nSbnqP0oELQVvZox3Ibc+xkpO9IYdUpd1ao9FtVJLgbhDEicbjt59A9EMxjal8cRPpKqtp398m9kO9kHnBfn077FEeXyXu85fTcnn5bay6GkINgbPmsnonrrCqAhMPMAxNRc4yNmm6EatsZ0g4jJoiexoOnLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297621; c=relaxed/simple;
	bh=RR3IPbYec2NOPFOIfkwk6RSLhVYO7F2PV0hm2oD/GxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z98emd9y60OZh8jaLcDoiM8lLJ327qlJyI1rkaETahWaDvsS6YJ8E02nDHUiS6Ibw2acLNS0j9ArWbvQLAurkj00s8Igt2TXzih/ZJElATEGQ/OsJ0nzRMibLWdGwH8S4Wkdz29FX74mREvpR/OxlCSEgb+JERtiwKEUDed2YQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nPXEu8nd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29568d93e87so30799805ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762297618; x=1762902418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n13/8FCJMUqNvbLnkNEFU7zB6WHrbLEegcRPJ27Wm7s=;
        b=nPXEu8nd/TGAzoYXzj1GRLQrphpOHueP72dOh8mZvMFxuik1h1Ix0FijzCdM5C5Q3j
         MoDCSQaPGGHb100NAcVYbWQjMIa9+YWi6TsBDqZwfZULML/FxasfP4A5nT+QuuSM8KRs
         7JnkgRdTHlQ+sP9VkvdlF+kmOqjaUu6BuBO9OABsVgfMCZP6uYmOfkECEXa+kYh8ghWt
         hK5Stl3nPqyc5gMZVgoPMzgTngSnAlN06yFGeDExDooFar+kGpZsbi4DB24Ov0U8Sb/4
         H+MvGm23oiLfPuicJGF1rNxw41XoNNQKkaUwhjWHVFXWfzm57SGzvyPwSq0+cNddp2S+
         VZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297618; x=1762902418;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n13/8FCJMUqNvbLnkNEFU7zB6WHrbLEegcRPJ27Wm7s=;
        b=viJZSuszP/2HbVknQtlIcv5HHRwMPlUVrVbaQsq4Gujv72AhcF5kCx3Oq3qqgdcZCP
         BJVrNjHpyV+meHZzCvsHjUxLgAueADxcOhmr8NdzK/Biz911DTB+6tC+yDUDqC74xKLa
         UjvDtP3LoLfqxl6MJRsZJfh52Egwhl8Eg8gOrI7z50d388qEp05zKjIzgqw9vqpPNJQY
         6r8ofY74bz19nLD4IEd2mc4j14etgHZpi1LrPQpgssPO7kRaVmizaqO1MrKtK23tMOnW
         BN6IBMftLa6bmWaVb0l6ygualJg+JXoJXMpD4Zll7+xn+giZNn44Q43ZrT6qmUDkPbCe
         zAQA==
X-Forwarded-Encrypted: i=1; AJvYcCVPVHFlsGNInU07i3R1BntCdeG6GsnE/WovV3oTwxAKGcVokZfeaCxIprDhzig4dhl+sqFADKt+JBLWkOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyquY0aC70FIW9deSgcVLW9lvlU6HTvaCdv42QufQ3lKY8ZuOsB
	4W6OvZQebdiGJRmGyYAE6ki68dCZk679L4N12b0Q6V++u/mfrQ2n/nhppyTVtDqYZgx8XIfbKO+
	tY3kP
X-Gm-Gg: ASbGncuVNBSmZQ4bqFTg+Cf1HcaGwdhF+YHveSv5RxwfZsr0RotmRLhhrSl4b1cTWeZ
	2vXKbZq41oWDgeDmsOSeT/2wPSUGU9KaWi8bb0k5khe4ev4NIBYMTQg21KYwGWGGCzmA2wFzReU
	r/Wt3m/SPA6InyRaSS4Qd6+l7FJ6+DznCpDl/21x1y2rm/FjLmVPnHmwyc+8BrX+X1YOdexRFSP
	Xb8MNlU9Hs/T5QL5AWT6ciHjCFfRnpxOOd0xoD0GS4LIuWIaG+813qVsmv98n/WxHfs3W53eXK/
	o51DySDYYz6hH8kyf3XzOpJA9uvV+YwxslgPk8empDb8c+bZVGsZPPWip3GtF3kdLJUxWLDVos6
	lTMvIS1DQDpSQ9yVYy0dnlrvp9/rtAjrvFthrpU/qaPy//VFO6QHZQ343kkbKwXAd3wkL0NgKH4
	rv0xBjoCva
X-Google-Smtp-Source: AGHT+IEM+rk86HbN5JMS/+ymFnH1v9sQbDzBl1J+ZxaCCcuJJxl/HfOqx30JVy/lEf/aP5T0291XcA==
X-Received: by 2002:a17:903:1ac8:b0:295:7454:34fd with SMTP id d9443c01a7336-2962ae4cc84mr16715675ad.39.1762297618499;
        Tue, 04 Nov 2025 15:06:58 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5751fsm39372745ad.82.2025.11.04.15.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:06:57 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com
In-Reply-To: <20250826140853.2570528-1-alexander.stein@ew.tq-group.com>
References: <20250826140853.2570528-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 0/4] TQMa335x support
Message-Id: <176229761756.2840692.8952270327048836062.b4-ty@baylibre.com>
Date: Tue, 04 Nov 2025 15:06:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183


On Tue, 26 Aug 2025 16:08:46 +0200, Alexander Stein wrote:
> this series adds support for the TQMa335x[L] series, as socket [1] and LGA [2]
> variant. The device tree can be used for both variants, so there is a common
> compatible.
> 
> Best regards,
> Alexander
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: omap: add AM335x-based TQMa335x SOM and MBa335x board
      commit: 6cf18454d7caf5a56776f6011ab9c6bca823c7e7
[2/4] ARM: dts: omap: AM33xx: add cpu label
      commit: c579ced456db4b95c55491574788c03618cf88d1
[3/4] ARM: dts: omap: Add support for TQMa335x/MBa335x
      commit: 5267fcd180b170d39cd2017f62e332a26311534a
[4/4] MAINTAINERS: Add entry for TQ-Systems AM335 device trees
      commit: c8763978aa4f72ededff3adfafd5e35661862168

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


