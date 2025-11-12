Return-Path: <linux-kernel+bounces-897738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC92C53777
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BB1A358F92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44AA33F8A4;
	Wed, 12 Nov 2025 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wHSSCKHn"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6F733DEFD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964838; cv=none; b=G4qwD5R9iV9zMKxq9sE7AQpNvRM67X2TM5MNKZZBwG/CfPP4Ic+WdDeRI7kJlMNDwIznw5zho9vOEA+TNJVjZMRonTqX4lyV5ovW02gN/wScqMNAnTvbxxcVVKKRVLyXQvsFHVI7P9n7XyOVal+f+xtPh9X6opHHlmcIO3lh0fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964838; c=relaxed/simple;
	bh=2J28k+rkBGEIQnqpoey6EUz8XjM8ez1dZhEzYa6oxzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=spHAm/zMDGY3LvP3rgbg070B2o/r3+XfO60A8q24YRAB3bfkXIUVarfndxLWePVKLCwVwS83ohtbuzF1ARfFiXpvOOGCnG0fIi4w9LuA4Hai85UtyjYT7qvKq17BxhYmv/sgt1Q8dNlqEUThnxQITh7CsnzyZgJVOIzpss1uPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wHSSCKHn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso5430555e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762964834; x=1763569634; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPkr/JoKjH8U6Lko6pTK2QTabDhqIIQDxw6EgSjYcZo=;
        b=wHSSCKHnFTRV00rAxT009La1Du5NEQJaKZH9AbdB26v4vqbTgXKgj3mip6not0+Lwg
         A4gNov04WOH0YsN8SPaHW10GP7KGY9yPwHtl2IKsNrhqf1rRg+n4STC/Zf8s4x4B1KLd
         k8x12lI/BaQ+9eXdQ13uhPxQccKZnJUMCaXVjlqVm0qDxmf1Vv3EQ3WxaArVLzofA5O/
         NK/dEWeJknpSvn4iFNSdKIJ1ET/8wbSdcQbfpQE/hvDDVEPoNlv8w/fakLKYXYA8fR5R
         GKzAKYfp3Pa5nzfIqs8S4gNG8GMWvLrAsi1IiAmzbsmne8fPYroaxVvjpDaSA6J+s5Vw
         8lIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964834; x=1763569634;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPkr/JoKjH8U6Lko6pTK2QTabDhqIIQDxw6EgSjYcZo=;
        b=dtAzFr3NZetb+TccrYBxer3Tgj1mJvOWd6lJg+mFH1zhkkJ5TJBgtWysSOvmYIIVNn
         Uqta9R8rDdhSaoK+fQkaD3BtiCI7wzlFNt580WInEKUJUORqgTMWZnPT/L45z2qaaD+I
         XZHm8CzKAnt61X0KbGK5QqfNdUIbwJ0Rz9px/lwSy8casrqZdMw59+so1OHYiMkDvwYN
         fnqPF2N28QBqXOzGiLOrdKShOkQHN1PBZFC0ZmHI96jtmzodysY7TM3AvHmwItnofpAS
         I/Z9TDmz9eTft7XMPTt7bVaZtbHHgAcZBoiRhZzzSjrItGwa/OXqRiIG9pe/m2G18L3i
         HyEA==
X-Forwarded-Encrypted: i=1; AJvYcCXsY7+PedouZsJ9zuO4i1hzm1pXvbyT3D2YyBpNP34goZ7OtgSQyfYr972b+WlIUnFQKJvJ78C38bpSZdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgSEU4Z3Vf/C+i9Q2AHyVlLHlFVzreU7PTWI07ANfagueIMkY/
	HB61fKTFMsVClLede8kk8VWj6X0A7KThpwNqvy5ZoZpQveJ9dX2Q3fwc5c9I7Z9YLvA=
X-Gm-Gg: ASbGncvndFKKn8RiOArqjEdmhIfjUUuM4X/V0CnnrohHH7Fs2Wx8b/C5YFYXDSfn766
	k5qilzwaS+Njh+CFChj/SoBJRe+9ZuVvNSVdDPGOZgoPckr7F52cOkTXyqK3NKsZgDO0jKauFEH
	7MFXDTrhI9Is/q9D14WBpavpODKHexDCPqE4DCf7a8+3DOie4YYA43yDwfRlvvl6ETJ7497Y1bk
	eKtmmMzHtc0oSIzHjA3Nsqe++kG179AH1WYtfHr1I48PerendyrG5+sIwttWk4CF7VqpC1QageV
	Tghm6LJ57/qKH7nsvR+oefW11JIT91ryqQq0T5ietzyqnmyaXSQwIBwwcd9XlwAeHWw0Wu4oyI9
	WSReVJ81gwRh+RzON4jBK0e2n59dbC23zNa4HLUmhFr4VRk56pX+dgo04VH9FAvpQ/+Wfe/6Vcc
	6LO2UTfVa3Udf3KMCctuvqB3nxtfPAOa4=
X-Google-Smtp-Source: AGHT+IGkEoN4sWg2lAUJ3rXUtrl89smNrKDWX680+800326hJYTJQMWhDrBhsVLjs3L/pc050EyNZw==
X-Received: by 2002:a05:600c:1c85:b0:477:76cb:4812 with SMTP id 5b1f17b1804b1-47787000e64mr38038745e9.0.1762964834332;
        Wed, 12 Nov 2025 08:27:14 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.66.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e36ca3sm48534815e9.5.2025.11.12.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:27:13 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v5 0/2] Add new phy_notify_state() api
Date: Wed, 12 Nov 2025 16:27:05 +0000
Message-Id: <20251112-phy-notify-pmstate-v5-0-39df622d8fcb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFm1FGkC/3XOQWrDMBAF0KsErSszM/JEdle9R8lCiSRb0FpGE
 qYm+O6RA20pSZd/4L8/V5FdCi6L18NVJLeEHOJUA78cxGU00+BksDULAmLQoOQ8rnKKJfhVzp+
 5mOKkBzob5o78kUUtzsn58HVH3081jyGXmNb7xoL7dedaBCACZOZGKUWoOklydsWlZkjB+zC9f
 YTJpNjENIgdWui7/O8vC0mQ/oLHHlrVI+oHQ/0aHT43VDXU2Rrugdla9WC0PwYi0lOjrYZGbXU
 H0FvkP8a2bTdj3YVgegEAAA==
X-Change-ID: 20250703-phy-notify-pmstate-f02ba5582f65
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 kernel-team@android.com, William Mcvicker <willmcvicker@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, neil.armstrong@linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=2J28k+rkBGEIQnqpoey6EUz8XjM8ez1dZhEzYa6oxzE=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpFLVcYFXUfJuYXtUM4uyqJbaJ6Y1c9sCsE32zd
 GbAifZjux+JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaRS1XAAKCRDO6LjWAjRy
 uuElD/4upiReXgng0xFPts/n3ptS/LaaZKG8BuwXA9peTmNePtMCmrgipdYQQQsNQZT9JEnLwcE
 QeLVgaAbODCp1WU4xlw0FbDR8+OMJciud3OLA8iOEOJyFC2vulmkIsS2QIaQO55LJeRhV7L2Iuu
 qC0S6fV8h8R8NJhJS0eQmrvfOXcMt7X8QFWO83xULfVXJWokZws2c29b7EMmEVn1e5mXTXo8F/t
 HToMgLlEvniN5KzxOLHsP1JyOuO5Olv3CeN9T9aIsgu4g4MWOUNp9WcMiyctkWhteU+JCpU+7+1
 2hBbhq+w4MKQNZUwk+Zp29lg/GvHe3jKc8kBMigkZdMZj0PTC11GmRw32DUdefMIuQd009Cmq+C
 FmI11O9/5DbloYzPvg6YAqVY9a+161ADKITnyKyNG/gqk3fUvb1RMYXMcliZlmMi8Yk98/jlDzc
 YwhGGmuv7jM2/74e59posAroBT8heOInlLav7HBMLlOnBfB6FffTE58bhIxFbFu5ciQ+Iqutf6K
 KzVQoeGGKtmYv2cnxrTTBwgEMrqGpNnod3X+cN8WArmlhDOotvgoK8HP71X3l/l3SaXav6bvDus
 +SRPz7xb1rHLxLRZHelG9PmQrZwriY8z3QAQhfT5Z5M8StdtGAi9jmxfWYeappyFNvp7T2Hb3e0
 P1VM8WhxE15WVgg==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

This series adds a new phy_notify_state() API to the phy subsystem. It is
designed to be used when some specific runtime configuration parameters
need to be changed when transitioning to the desired state which can't be
handled by phy_calibrate()or phy_power_{on|off}().

The first user of the new API is phy-samsung-ufs and phy-gs101-ufs which
need to issue some register writes when entering and exiting the hibern8
link state.

A separate patch will be sent for ufs-exynos driver to make use of this new
API in the hibern8 callbacks.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v5:
- Fix typo phy_notify_phystate to phy_notify_state in phy.h (Russell)
- Link to v4: https://lore.kernel.org/r/20251112-phy-notify-pmstate-v4-0-717d78009d15@linaro.org

Changes in v4:
- Add missing 'used' word in commit description (Vinod)
- Fix 0-day compiler warning
- Link to v3: https://lore.kernel.org/r/20250813-phy-notify-pmstate-v3-0-3bda59055dd3@linaro.org

Changes in v3:
- Rename API to phy_notify_state(). (Mani/Neil)
- Remove inline kerneldoc comment (Mani)
- s/phy/PHY (Mani)
- peripheral specific enums in phy.h (Vinod)

- Link to v2: https://lore.kernel.org/r/20250703-phy-notify-pmstate-v2-0-fc1690439117@linaro.org

Changes in v2:
- Add new phy_notify_pmstate API() instead of using phy_set_mode() (Vinod)
- Link to v1: https://lore.kernel.org/r/20241002201555.3332138-1-peter.griffin@linaro.org

---
Peter Griffin (2):
      phy: add new phy_notify_state() api
      phy: samsung: gs101-ufs: Add .notify_phystate() & hibern8 enter/exit values

 drivers/phy/phy-core.c                | 25 ++++++++++++++++++++++
 drivers/phy/samsung/phy-gs101-ufs.c   | 28 ++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.c | 40 +++++++++++++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.h |  7 ++++++
 include/linux/phy/phy.h               | 19 +++++++++++++++++
 5 files changed, 119 insertions(+)
---
base-commit: b179ce312bafcb8c68dc718e015aee79b7939ff0
change-id: 20250703-phy-notify-pmstate-f02ba5582f65

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


