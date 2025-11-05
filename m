Return-Path: <linux-kernel+bounces-885885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24C9C34225
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFC63A54B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC532D0C8B;
	Wed,  5 Nov 2025 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="N2WinqET"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5528725C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326334; cv=none; b=fvkfWVlqg/3RaGRdCuFcNXuItJWNYyWywCIdSnTop+x/83EVQTom3M80YeV5U7SrPB8d0KvKHcnr4ykdE8FtAR99ut49aYEUhs9GOhCOSi/mIFdkvVmAI7cqFjKV1chwtk0i9io1YxcgN2CXz7XxmB9g0BUpjZk0yfcorea2eJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326334; c=relaxed/simple;
	bh=VgW6wsvMJbO2Jr7vF/WiFeIjviPMUTU56vcFLD7TFzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIaB08Ci5ajrDTR4HEOsRDiqfURV88BdKzbgnsGOPIkar5LtEvsRA7slCr53fxvFbfNwsLQRZbW562pwl86U7fZnugPXkfxggrkGAbFfv7ukSOhEIDFqkYJVw0Jf1Q27m6RgpfLCoN0h4CEeZC6PxkWSHZOYBV3oEILywzT+YBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=N2WinqET; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47114a40161so14487955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762326329; x=1762931129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPFfOU42a9LX/ACTIOGykRbnsbucNZCI8/DjNyniCCo=;
        b=N2WinqET03KavT3Uj58D+bDnE9Db6x/bZ10Np30y/b6zcA6ceDeJ24riFjvDRlZzLQ
         vsqoo4/ZMYU3fAJPwK050S8i5xiQEC2iB5QfEaNuFMHhZc7dtJKkBCjxK24ITiBuv6+6
         9wTZm0zh7vnngPstc2QDGABcJLUVB8ElHtow5dw2E+SzJl+qbCfiW1OzshCJMsFgPodk
         MqgziFN98Egd93uvSxiao1lLsi4v1afUPoDDCHN6dfJ+7BcZCUQ4q+JKhfKADa6FYVa0
         GIjhcJDi5RkQmQHT1XPk+xkfFbiillMb3sfNA16pB1GyCoFOwHKlaeIyMOhhCMEBAbmK
         N94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762326329; x=1762931129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPFfOU42a9LX/ACTIOGykRbnsbucNZCI8/DjNyniCCo=;
        b=RsgSvnfsTSYzsAKSOwkzbadrMaFOl+/85Ad5Pm1IFBoFftVXhemFpqsEVPS3bwuRim
         g9y6fIBlx3AKN+aZlswFut9PdraBlpK1Ncrm/TSWLYgj2vCI5xi/W7KB5UzyLF3UY+uu
         Dq/ZCkfxqJm78EgookXco+aNyFRnDS/dLm5ksQ8qOfzZj/8g2qJmrLUiNq58C6DpbljQ
         nSNzZ+SE2QdLOSIXo0L+RCakLGHzrhjS5h+V1R5tOupgEETqbboS75/w9/melnzyEiwj
         HlhaRp29m0MG2+in0BiOKdsnOYqqsYXrGkLjlZOvAOfWQyK9S79Hwa6YRp1ZuXbA/y3m
         SLlg==
X-Forwarded-Encrypted: i=1; AJvYcCXkqnEpVyPjDrNUpxMiJhbshXMOED2Vjem2g2BUyVs4XQBIT+kYKKeI8X166vcAQ/oRHl61NO+caY53BIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEP/iDPezISmxgbx+UXerZZjY9uNx/ifGhWS1rVrny0HrbHB6
	tIszgbX7/WGLi2yiM8yDsCdALBH8/bwqovzMbZypA6UZ+8w3miwb+9xtd9xPxsAucmw=
X-Gm-Gg: ASbGnctXKryCfuGw17bcrd/qOtfY0+VrkrHcWUC7DUtYdMOhZTu8en7DL799FXBKqTb
	+ZRp46mIkO6pjAhaMqS6+dg+SxW6yiyvAaPz5Ulg15+6mBvr65IK5bPa7L9DsX8zRGl6X9U3xzg
	Ty2BY2chwUDovY7A3uIzaOYEfv7KnHUwcZYp8k1kpJaYSqJUHBbdF5ck04pZOIQQ12kmPlAZNT5
	jqkDDZeXxQCPXIhO3YgZ1tbTA4C6srKdAWR3Rb90kYhyOZ6TmMnZDED+Zz2QSdT5UTCf5VEiDdZ
	P1/yGdkRzU38u/bRoOkEnXalrDtSsceisn/WB/7tX/jkpCLCnv88pbU0IdEORONxpsx3VDBWNMV
	LLq1quagPBnO7Pzk49wduwZuUpsBNIlMd6d8IlTAbkbgI4UD5KOmN3rj7KozWlLtrnFZQPgNnIa
	FbVb5jzdI+3T1ozRE22cL1zytaQEUzQw==
X-Google-Smtp-Source: AGHT+IHSvh8+ekwxCLTZO76vzeOnZlgCUz2t3qfXI0Rb14HHoHI2UG2ksJtjK9Mg8ULpEdrsjSfU4A==
X-Received: by 2002:a05:600c:3153:b0:46f:b42e:e3a0 with SMTP id 5b1f17b1804b1-4775ce2bf06mr14162675e9.41.1762326329397;
        Tue, 04 Nov 2025 23:05:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc96edsm30520685e9.6.2025.11.04.23.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:05:28 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	john.madieu.xa@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/2] soc: renesas: rz-sysc: Fixes
Date: Wed,  5 Nov 2025 09:05:24 +0200
Message-ID: <20251105070526.264445-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds 2 fixes patches for RZ-SYSC driver.

Thank you,
Claudiu

Changes in v2:
- added patch "soc: renesas: r9a09g056-sys: Populate max_register"
- use all possible registers in patch "soc: renesas: rz-sysc: Populate
  readable_reg/writeable_reg in regmap config"

Claudiu Beznea (2):
  soc: renesas: r9a09g056-sys: Populate max_register
  soc: renesas: rz-sysc: Populate readable_reg/writeable_reg in regmap
    config

 drivers/soc/renesas/r9a08g045-sysc.c |  69 ++++++++++++++++++
 drivers/soc/renesas/r9a09g047-sys.c  |  79 +++++++++++++++++++++
 drivers/soc/renesas/r9a09g056-sys.c  |  69 ++++++++++++++++++
 drivers/soc/renesas/r9a09g057-sys.c  | 101 +++++++++++++++++++++++++++
 drivers/soc/renesas/rz-sysc.c        |   2 +
 drivers/soc/renesas/rz-sysc.h        |   4 ++
 6 files changed, 324 insertions(+)

-- 
2.43.0


