Return-Path: <linux-kernel+bounces-812835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED942B53D54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C729488293
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071DF2D839F;
	Thu, 11 Sep 2025 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h41+vAFc"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155527A454
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624225; cv=none; b=PXXcsWqlC2y876ZnqIx9XNDcszbDcHua43NAajUbG9otEwVtO03bpKDHVJNY5qGQYnfkExW47LS0+426WP8i5bEDbWTLXNAblAWhqQUO16i2XwfNDeyJ2jR31wS1D0rUK1UYVgeZggPJRzWgnVkp9WsUpJ++9q6j1UmcKcKfJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624225; c=relaxed/simple;
	bh=+xC6CDNXn1oK/byMrY52lfJ4BmZyeGSkuVmtXln3irE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=imb4w2YfDeZql7OT5memLDkuYBiVS6ACvqjpkxBi/m7WnG+GojiwJUCef98eE5wmZtMXaLnv6dOBk1/W3gByUDOOwJLGc9jF9WKjXlmauUiraij8qqYAri9CnXYYO2Ng3kgrYon23lV3lJBuQN/tHFvLE2CDwfv3qYrqIFhv09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h41+vAFc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so2413403a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757624222; x=1758229022; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upBaP5+a1jJVAeaFjcJnnOQrDZsY89ZwYZc9GW+jCr8=;
        b=h41+vAFcux3r57nvQsg+1UYe2iqHPxUfPxIyBEgrIGSWK/Vcu0Ydyh7ZFFbGqNKLXu
         iAoLMiE/Uj3WqnxW1Wl14ukC9wlMUTdJn8cohoj3I7vTMyvfZvEs6uEkQfTINFg8Y4sO
         WoyM1LQpN9Lo3LOpb3Ctfz2zd7ovQMtq+sMAUP20O+KNzOTh6RJCS13HANc3TiQ+yjPk
         Jz+N4TEZJKtarvJjEf1FkzfIQS8goGoNxrT6AnqBorWh7lBn/nk5er97v21DyPQ0RsGh
         ISpqap1cEKaTCMuDmD9hJbbcThTzDLwS3lRfYzC86RQPnF7IaeEQ7iNtTvU0gP8Ro1dt
         9Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757624222; x=1758229022;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upBaP5+a1jJVAeaFjcJnnOQrDZsY89ZwYZc9GW+jCr8=;
        b=ppCqOPg1OOLjDk5JD6td2l46wdxlUJRCSXxNJS9CF/nVcPBersGRgce4AATjRRm9Jb
         YkvOz6zKSGzmbsGzz0trCHW26SPll53PkCeeMEeXUQYvs52WgHjxvs4uORxfz2Klm8cb
         kJyhBt0UTdEJYgR8FIXR02wMhMW1UeTVS2M6kvDtYL7M9y8G/DKlpGwAlqgTwm54qY6p
         D1ykqJjvzWDg4pqZLHCSHM416ja5f+ZreD3yIOJoG3tJ+I6rgwEDDtgPnmf5lNbIiR+h
         gpfpQtCoyzx1cQCj7Qns+oCRGD+RGqBJpwUh+yAzRs9nUghXS3vodQbi+Warv0N8G4AZ
         itUw==
X-Forwarded-Encrypted: i=1; AJvYcCX33AwHddMm6mtz0olaRLjKEGwzeS2eucnNLdOda3+rK5J0/H8eDEOYEx0Uni6/EE/m2DHhDInNAhN6WHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBDy2YlJUmFC3crBZtk9UMxu28AG4kneXODgS+tlIjiFwRMKp
	dZwUsXgtugOq4KUCVYobpZjhKDO5by1PgyC8f2dmmA949qp04Vzq4dq+
X-Gm-Gg: ASbGncuIlU3zzxYeuFAU3xpAY6/DfFyPusKa303BPCZkiTucuL7w1QHtpV+pnx6QOca
	+jH1tMx9AFcadX2QqzPmSLfVqwn1FVKjRtvHutldZq329ER19L7j1GyQ5WAzajfEihL3OIshGf2
	nlaRRSE3puBXjXdH7XnpQmLR/TYAUvtxlr9PNQMgy++V3Rj0IEJ+X18Ku/Bj8cx7PX0WjxbyHcm
	99YDZU9bPNcigYqu+TKkqRnWXpq68I1pB7hjqPyEJ17uVXkU/y/AY91rJaDUjUBzWhkeklVQ63x
	VVLUgtVwS42CjhCDT2a+MYGDZMBJounzJgwYF+wO2gftyyZqVxOIb+AHuvKk5C//nb7YNgMqLm7
	2x6H8j8SXSViSYPcSL1d1
X-Google-Smtp-Source: AGHT+IF3xSfm287Jw/nknYwrZ2LBDEPdKd8SDnq3Oal/V+V7iI+rqO0Aq2HugZCC3qrU/cmfxHPyWQ==
X-Received: by 2002:a17:907:da2:b0:b01:af25:ebbe with SMTP id a640c23a62f3a-b07c3a9c8f0mr47113566b.63.1757624221743;
        Thu, 11 Sep 2025 13:57:01 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07c28f190fsm38775366b.39.2025.09.11.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:57:01 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 0/2] arm64: dts: qcom: sdm845-starqltechn: add support for
 slpi
Date: Thu, 11 Sep 2025 23:56:55 +0300
Message-Id: <20250911-starqltechn_slpi-v1-0-93ebf951a932@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJc3w2gC/x3MSwqAMAwA0atI1hbS4v8qIiKaakBqbYoI4t0tL
 t9i5gGhwCTQZQ8Eulj4cAk6z2DeJreS4iUZDJoSW62VxCmce6R5c6PsnlVV14iNLQgrCynzgSz
 f/7If3vcD/X6FZGIAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757624220; l=617;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=+xC6CDNXn1oK/byMrY52lfJ4BmZyeGSkuVmtXln3irE=;
 b=2/vi7Z8dTokGlwGsIgeDjhYuEzLxyig6OuVJ0HniY7V+mJts8FqQUd7yjQcPlpKAzjy5sjbdb
 ICnFgcgBDd2DQFdhC9uThYrRqj65QOvZR6cuVXwJEPu6ptEAUEwblCs
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This series add support for Qualcomm sensor low power island for Galaxy
S9 (starqltechn).

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Dzmitry Sankouski (2):
      arm64: dts: qcom: sdm845-starqltechn: fix slpi reserved mem
      arm64: dts: qcom: sdm845-starqltechn: add slpi support

 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 26 +++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)
---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250911-starqltechn_slpi-677008f4e06f

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


