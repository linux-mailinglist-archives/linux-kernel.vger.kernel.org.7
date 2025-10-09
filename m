Return-Path: <linux-kernel+bounces-846500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E8BC82E3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEC1F4F6303
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762C2D781F;
	Thu,  9 Oct 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="QBaQGiWO"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0843D2D73A9
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000807; cv=none; b=Gak0NRHo81/XWLp4Gak787fHQ7vLwV9uB610X/a98KNpWT9LSZ1uJsusbmRNwfGWYQIV6k6ZcPzxR9ZPLpMkzdn9mnk1VyI9Y2W2b44RcSDM1K23m0cxkwOUeomj00yyULuOeeV2rGhsxfbbOSmgJdPaxSU7OOtIyz/8mYf8tnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000807; c=relaxed/simple;
	bh=qJOv0iN/KQMg4cue3EwWtApI72quYVMhv24uY+typxU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W1CBDVSIWBLmB6+fSpHR30hsoKIX3eRdWBF5uN2Rs+d5B1tFt1uxU9zy1itGQXDU+9TNsQU8ENToalBf4sdcQ0PjIW5YyxRjrIGJSFe9eJpHdnV9PX1//p7J8MWbgNzCmbRv/+LGVjwZ2HBD/EBGzeJde6P/wGeHvUrx4vFCouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=QBaQGiWO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso1451140a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760000804; x=1760605604; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNhWTQ2jjRZ6dlj/JkxjEi0pSb9RpuzlHQTH6dcdfSk=;
        b=QBaQGiWOg1FZEDRiFa4WLwDaO36Q6AFSkTnuMUuODCUED905EoWXRDqV2IB8Fo9RK7
         n/yb/5+pbHu8aUz5tHAc5CKScQVbG5rRLoGOPYQtr9Xnw8UolPh6PFHV06fdagyI/s1A
         VO6ass0T2FgnFfUl8QbqXbBUQTMLsDFasSXMnBahZwT2WvuUbia/xmXagBIErn4dQLnS
         RBLIvVOMTJztKHPaDnhaC0ll19fnoaES+oZNvjLI9RcZ7YABweabqcZLkKDW2jbFnhAE
         6AjBNFv7TriiS/hCHC/R87y6Ch/K6TrtBt47H1tIg14DhFX2x1UpL5SOFPLRtSNfL6Jy
         kT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000804; x=1760605604;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNhWTQ2jjRZ6dlj/JkxjEi0pSb9RpuzlHQTH6dcdfSk=;
        b=PsVc+nxcXUSMXf51D/1XMZTIinDEisJdxsU5F3X4D4ODRHmH8bAS0qxMLOJf2KVL1m
         LKVAvPaTHriDk4I9Avw732M8EEVhcRnlFId3N18Yun7xKn+ywq7pUc/PWeRZ3RghRqGy
         RWD8RuY0DCdYqMA845k+8Z6SMHpdHAzP+dFsSLb4bkcRE/8VxuYCLYKpmfuKpPkPel4K
         nUt3OlGeMkVbHxRaARIjXBhtw3rdsc5ShV0TcxRl4BaXpXwszr9JDGXlpuuV99/LbCk1
         vebiIS5R1hWY5luljt5VKF75q4caGHd6tts4nBrhsa0AK0PleFoWLQWy4eM36oXQRpc0
         2zgg==
X-Forwarded-Encrypted: i=1; AJvYcCWlHBvZigmm8S6Vk22bP6H8dUGWbIjj076j1iqdAykJRLESr8RMrkySIDlGfsJrKtJjby6deWdiDe204c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRx+T9tWXHtlseIS4crmBLwODqhsiIxTtQeytvh1nS/h0c8B9O
	vDuG4L2oO/tap49FOvdcAnXY0jnKCFJgdAh91UBy6OzeeQrB4J+/DMTJWkInHsOlNO8=
X-Gm-Gg: ASbGncsJ/DhGEGGZitkUpEvK5+2XI4PoPoLgSaUQfJ6NXfGI9OoQs/ZBPeD8ZHSoZQz
	NHRKYQTIqYgjUOUmqxmCz/QlyPzLo/Ny1xTUqVnrEy+2YOSv7BDzYjMZQPim7GactNrCjIJi1EC
	DpewMmK/aTNaSGVjokya95mTqSetVZVzsYC8GQqc0OXIQutRWDdlt9jVeLLumuG4AIdCtJ3lsQe
	e/mMtpvFLVJagNMBaPuMMv7KosBrccg7I3Dr2QGY1fkcIN8HaaQvXNcdq+lE1dkuOqIAHRBFDGC
	aRgR3IPFzDv3LgKTdqGivzSbi/EC62MqJXKKQZ4/9tjKAPcLbFkpnaU1tK423DknABcqu0TLxul
	CmV75lVzzFzj1pQreVKY9+3dcEIRIdlE6RrAkJYor668JWTamqSQwSdQfbQhMeqr8V7iaaFwQgX
	TzUHBFSYdMfVFSj41lFpWY45yhW73/
X-Google-Smtp-Source: AGHT+IHVbQo3PobfFCRfWXYrwqODGaxC9rU9vZlXDMJPWoPDWQIzlNupR0cyBhTPPVPrWCFXXZGF6g==
X-Received: by 2002:a05:6402:268b:b0:634:544b:a740 with SMTP id 4fb4d7f45d1cf-639d5c31e7emr6572648a12.22.1760000804306;
        Thu, 09 Oct 2025 02:06:44 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f4109046sm1905755a12.44.2025.10.09.02.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:06:43 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/6] Further bringup of SHIFTphone 8
Date: Thu, 09 Oct 2025 11:06:30 +0200
Message-Id: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABZ752gC/4WNTQ6CMBCFr0Jmbc3wV4WV9zAsEKd0FrZkWoiG9
 O5WLuDq5XvJ+94OgYQpQF/sILRxYO8yVKcCJju6mRQ/M0OFVYtdjcrHSKLMKtHmfAi7eV2U6Ug
 3ODWIV4K8XYQMvw/vfchsOUQvn+NmK3/tP+NWKlQXQ1ob3dYd4s2MLIv1js6Tf8GQUvoCxMlAK
 r4AAAA=
X-Change-ID: 20250930-otter-further-bringup-f9e640c4008e
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Luca Weiss <luca@lucaweiss.eu>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760000803; l=1147;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=qJOv0iN/KQMg4cue3EwWtApI72quYVMhv24uY+typxU=;
 b=sUH9RKnqzC/H1UaTofL2s1bspY4tzj0A5UBraEAbGB/ov8r06zcLDBS7PuxigewegJS0UOLnO
 6nLhLGb1d4nBXl/piRRi7EjIzVdrF8zsFgFm6rFzwo45JSsMfMAdVP5
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add some cleanups and fixes to shift-otter, and enable flash LED, RGB
LED and Venus.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Pick up tags
- Also remove polling-delay-passive = <0> for thermal zones
- Link to v1: https://lore.kernel.org/r/20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com

---
Alexander Martinz (4):
      arm64: dts: qcom: qcm6490-shift-otter: Fix sorting and indentation
      arm64: dts: qcom: qcm6490-shift-otter: Remove thermal zone polling delays
      arm64: dts: qcom: qcm6490-shift-otter: Add missing reserved-memory
      arm64: dts: qcom: qcm6490-shift-otter: Enable venus node

Casey Connolly (1):
      arm64: dts: qcom: qcm6490-shift-otter: Enable flash LED

Luca Weiss (1):
      arm64: dts: qcom: qcm6490-shift-otter: Enable RGB LED

 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 75 ++++++++++++++++++------
 1 file changed, 56 insertions(+), 19 deletions(-)
---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20250930-otter-further-bringup-f9e640c4008e

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


