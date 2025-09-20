Return-Path: <linux-kernel+bounces-825867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8608B8CFD6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D209A1B21AFC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97123262FCB;
	Sat, 20 Sep 2025 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRPQfijP"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6022A808
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397691; cv=none; b=urMVQ2xD/F9gpytUs5W86bCtaTH9NDsMbRGFAe7LnNatC09Cp33Uzr7QzvHaqEepuVZ7qvPJnHE9/yxPHWlAQHjIy4SWmUs7WQVdgTJRUWxxFgo8WwG8znhNK+RnGvvvMPbcBZBy9Shd427MIMmoyL3DKwN5VdpUyRWsjrJZfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397691; c=relaxed/simple;
	bh=gU+YxKZ/v8Limtqadb/7wkx0BporxGIAHtO5oAwna9w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oCNR9zDs9tlk7Uf8/ACh4d6hU+nOWSSHoBrQU4Hvd/+QZgYoOAXhVb3mgtAd4ui0hhi3bjbfIoUFEtc+4VG0AdAAyMKjojlZnRKzYdds9PI/6O3qH/yPf4ES1sImjrY8+kf+D7wY4GOCIu/w8aoy5f6wx+LG0Dee9hWuVnuT/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRPQfijP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae31caso543847766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758397687; x=1759002487; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ePb5EGGwlpqv6lGAq8K2sn88q3g8jbxDmw+QHlGGyhk=;
        b=MRPQfijPwXsuhhEegbsvLcZeQa/gm8+EtmQ0iMaFNoAvbK0/aXIHdzrpFuan+oZMR4
         L4mLQV7pIfzgg5jh/+J7MyZ0EcPZhHH46MdcfDsee3RWhjJM+eHDjhnPdrgCiPEIZqKj
         zaVNl9dCeYBa2EYIBTt9mF6VL0s61fC1mLbLlr4g53OLKGmqZ8xck+jqHSlwybTWELWv
         LLycVzi4bteDGTzS+mCL8KG7etx97L6XkHHaIdrySNaJERcRulfoM41AoMvCzAEPRbcI
         EkmcnGjGEEPavgBgRgcq2lBq0KLHdIlHFztldGR0C4zj6bYxzAjncYscOePKrVmNiWAK
         DFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397687; x=1759002487;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePb5EGGwlpqv6lGAq8K2sn88q3g8jbxDmw+QHlGGyhk=;
        b=j07on2ZrmOkTNb27u84D+aWLSYmSMNGKW2TbuVdxwdxRKDCU75P80HE4tth5htKb9E
         8edT0yH25tZ7R/hMMvVhQSncgdLBXW8W21HPuGqIS30QhgIdLVmMWacSnEW39LsFyDnn
         6K0vtj9DqMLFdf20v2ubXFYMmP9OrRtrMixp0DmyMo/u+UgDZj+gTwcRxL6Ly+zUYe4c
         3XFKTjpaPXbyyRowfXd/jB81o+uSy6Ge3TneM7Xc7AntOyxAZ+06XVvALPYmMBtRPVUv
         sSEP6q4RYn/E4euzLi6X6O7V/4iQdoIIeKTq/D3iUxd3iCOgeJNAbneJN3QR/IRdcXJ5
         dYJg==
X-Forwarded-Encrypted: i=1; AJvYcCVTcCVVL1N7Nr0sk9k8C7ZvFNl6sTTlJz46KTqUoj3m3e4ckNrML0uwza5FWa+fqrN14OTwJXD99TfRs0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/QqnNBlNZS5RbLh9FFQ4DT1RLOPJqzej3gOD3lpBlr9XouFMe
	SQ2vy15yQdKIicZyv7JenOgL4i3FgesLEwvjbmCEt79A1mHU/P1xNkwIJefd9Qm/
X-Gm-Gg: ASbGncsGx3e7vVvMwW0JL+6EOPgL+7atclTxtNxAm6Q9RugNVyqnHkgzdcgkAV0aOt7
	8CFjN7Lso8xwFTryIvti+gjcMQV8jh+5HUCvJJj89UubWcJRXzt3vdBJag21QzEg1rHuhURi5W+
	uA2+jD/dPPyK0GtZhmoPYZm7Vu21AxNeWDSu8CAOlipszCjzy3bCMfYcWn4jDFS3mArpINh++a4
	inasjs1yLOzjEjaOBFsCVYZsfTiF0cXjnRlrKA5U+QDw4NGsVn0fmGbtOdxd+xVV3pfWnY79xLp
	oXVvN3q5Fa+2lHTrWT3U1tGURBpFUQyr16/WMeDfVAspjXhd0kjipOZw4XNMhjQKvfYJveGzkfh
	UGrB60HDN7LQNBRSC8ZbNShomGnw2PyqArRdqUnuppBPJP2X8a4jqVg9zGS+7SDSAAuYlsTssSM
	Eg
X-Google-Smtp-Source: AGHT+IFktmMMA2in2WgzjbwUbkKH3G4w2hqcprGJl0Ehg/hvvKCdlA1C05/jZ9eOeBXUn+2RD3PUVg==
X-Received: by 2002:a17:907:2d2a:b0:b0e:677c:d478 with SMTP id a640c23a62f3a-b24edb68b5cmr803940466b.19.1758397687342;
        Sat, 20 Sep 2025 12:48:07 -0700 (PDT)
Received: from UC-PF4PV1FX. (246.79-78-194.adsl-static.isp.belgacom.be. [194.78.79.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd15cb2fesm729271466b.89.2025.09.20.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 12:48:06 -0700 (PDT)
From: Philippe Baetens <philippebaetens@gmail.com>
Subject: [PATCH v4 0/2] Mira220 global shutter image sensor driver
Date: Sat, 20 Sep 2025 21:47:57 +0200
Message-Id: <20250920-mira220-v4-0-921b2e83a352@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0Ez2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDI1MDCyMD3dzMokQjIJ2abGyWlmSZZmxhYKYEVF1QlJqWWQE2KTq2thYAYU/
 D51kAAAA=
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Philippe Baetens <philippebaetens@gmail.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758397685; l=1124;
 i=philippebaetens@gmail.com; s=20250821; h=from:subject:message-id;
 bh=gU+YxKZ/v8Limtqadb/7wkx0BporxGIAHtO5oAwna9w=;
 b=JJ0oJ1TMfDOwFXNz0rEmd/b6zIJZugUepDVd3FEDcZifG7NtSEIQ1O421Rw1aw73iWBPo1hmI
 UD5fJXu9a3TARSgEnpnWTXRJclJmaUQui9dN01RviMfcVjnMRvpApn/
X-Developer-Key: i=philippebaetens@gmail.com; a=ed25519;
 pk=ncW5oAP1p6X8AZAmXP1ADcmlj6QUxXkN7oPfZV/DqYg=

Mira220 is a global shutter NIR-enhanced image sensor by AMS.
Driver is submitted in the next patch of this series.
Verified on a raspberry pi and imx8.

Signed-off-by: Philippe Baetens <philippebaetens@gmail.com>
---
This is version 4 of the patch series. I made some changes after review
by Kieran Bingham, mostly formatting related..
Also using b4 now - hope this improves my workflow. Krzyztof ;)

---
Philippe Baetens (2):
      dt-bindings: media: i2c: ams,mira220: Add mira220 image sensor
      media: i2c: ams,mira220 Add a driver for the Mira220 image sensor.

 .../devicetree/bindings/media/i2c/ams,mira220.yaml |  108 ++
 MAINTAINERS                                        |    6 +
 drivers/media/i2c/Kconfig                          |   14 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/mira220.c                        | 2032 ++++++++++++++++++++
 5 files changed, 2161 insertions(+)
---
base-commit: 2412f16c9afa7710778fc032139a6df38b68fd7c
change-id: 20250820-mira220-ec36fb9f3806

Best regards,
-- 
Philippe Baetens <philippebaetens@gmail.com>


