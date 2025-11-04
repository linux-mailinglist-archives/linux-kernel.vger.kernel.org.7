Return-Path: <linux-kernel+bounces-885026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC91C31C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E673AFC1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBED24469E;
	Tue,  4 Nov 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EywpkVeG"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDF19644B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268820; cv=none; b=B3jDX8A/h8IFtp4z7wsoU8EGT+KCuL+l0nMyENrXXf01tILK2I+BxxBZl8DtY6ycm+BvTVMjt15uNPnZR8egwS/IldWUPyTMu63m0Zirsfa67qodFHMNg3z8jCj9BGH9DzGOaFvk+Ifbk15SvA6N5LPg3pcFXZTYw+uaMkns4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268820; c=relaxed/simple;
	bh=p5LFmwEX6fbf6gDhCZzGUh0cp3wC6wAYcyXldsJFIIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4Q4ptov1Kr/arNX+Asr3fXX3uIXXB6wXzZVwceHqnOfcGv0mYzAlGsk+EQjDblT/y0DgO4iUqnf5N+HC79i7+oZJT2TYQfXpjonCPFlP+kyIU3XUHBK2xuk4INOd0aKyogqDoxZv+/jal2x9pxxz6A48xGdwFDknA6YPelWMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EywpkVeG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so2878624a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268817; x=1762873617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5mpUIW6+CyzXZCjIETW1X/eFRIiBeTonduLxFWGZK/o=;
        b=EywpkVeGojPWKfwinjWNU8CQw/sSxWBgwCoGqZOYEUDcuUZO66DM4aXSI1nJhmg9wJ
         W4Y4s4nk5I8wYsexYrGqV0c3MnDPNhBYRoic0JiP6EFedQXXgWvVxvdvdbq3JW24Cqti
         gSd6tgAEmAe9OLZ1ozHVhQS1KehtyXqlzlLZz3HwodgzqbOxfjKhEmgMvY/lqjseabZy
         noXJXOUTYWHPASCs3F4xuOD6/SB+Oeh0lJbLlYTUKn4GLmuVi8sGvIgxDjqs29QtWNfB
         HorT/wWoWHPtEXscvk2am5ifl4H0ObxsBo8IUNpvieUFuVIWlRJAKvLW8UPor7pDpXui
         eriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268817; x=1762873617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mpUIW6+CyzXZCjIETW1X/eFRIiBeTonduLxFWGZK/o=;
        b=m3sE9V9jUwW45/iYxsmR0MOZNrpxVCuRydar5xMvmMFEH459opE69flcoiYIF25wBo
         g3aF/IICiUxULV59IhzRpXGvPrhK5gucZvArly8x8CM7a1etZED6aGuA6YDPgw+FEeG2
         P7OPMMyEsNIht3x8irbkkDFr7LpQb5exLgeKySzO4qd0aLWSD5KNkBr8cZtEPjS8Zt4G
         b9AmkddTWyhOIYm0l3mZpUMiHQD7O1CsjkndzsYh/V6Ned6uYNJhir/DnOKn307ese81
         GLGFXiWHNqRlWKanf6WNcX1GrA9bjzpa5bn6OMzPzejmoHjZDMoUEoNLCzVelaV0oxwu
         Qs0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/ARolXD4TWI5fE1ZswicrTXZbO+aT2IXZgLtTitzOj0Ak9gGs+Cj8Z7WOuxc/y2prEsQIpRkjOLCJkQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/RPz3BfDUGqFcM5XjfC5hiDjdbHr7hKTgJchBNMCy1grCtbQ
	WXXk5iVDDrD1G8hq7Yoqo9k88rNv5UqI/CxOc7V9pLGcQGTtuQmpJna9
X-Gm-Gg: ASbGncs9pNT2LgvW3jUkJrHDKdn1Bkjk2+DmOaK/41i+gb52vdK85INvbq5R3Y3pcdi
	Xlr1O+XiUYLbqkGVemgf5YX3qiP7sI7SOZ/3VvH6Ni6MDIkFZoewx9oZ67ySWjkhE8HN3NfFYpG
	4m9TtTEBTnlkIokShsCJGkT5/+toXqaEIXMvNA9aoiHnO2aMyBwbihnGebY8fKIb4FQWPzgAm3I
	Wecqpt2vuwdY49l3GvlLDYgaY1cIaMCEaoc1EY300IhXpjnVquuqaiwWJ3T4OD4Swi9GYJNHJZF
	Nlfju7nMkDkXmjYqhVdS0a2HKGQ8jSMgg4YQg9alhQ9Mi0tc/W8TmHIdMxnHrMV4UPZ3S3el9sc
	GmQ4U9+wkAQ708dbcUhHgZqVO80c8bpiZaeTGTBk949BhinwiHH84ZLGt98dSm4Zkr2TDkbnzsE
	RA8yj9zaXfnYntah7OGqOYb5NWuQ==
X-Google-Smtp-Source: AGHT+IHpPTJa2+j0h+Cs4K2bC2PC8wb2EuNR51cOnJgsXf5x4woRyQv45qLS4utiEScOeGGzpAw/cg==
X-Received: by 2002:a05:6402:50c8:b0:63c:4537:75c0 with SMTP id 4fb4d7f45d1cf-640770823a5mr12779586a12.38.1762268817213;
        Tue, 04 Nov 2025 07:06:57 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6805da3sm2342014a12.15.2025.11.04.07.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 07:06:55 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Switch to using AIPSTZ5 on i.MX8MP
Date: Tue,  4 Nov 2025 07:06:09 -0800
Message-ID: <20251104150612.1874-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

This series is a combination of the previously dropped patches from [1]
and the config-related patch from [2]. This enables the usage of AIPSTZ5
on i.MX8MP-based platforms.

[1]: https://lore.kernel.org/lkml/20250610160152.1113930-1-laurentiumihalcea111@gmail.com/
[2]: https://lore.kernel.org/lkml/20250707234628.164151-1-laurentiumihalcea111@gmail.com/

---
Changes in v2:

* squash patch 3 into patch 4.
* rewrite commit message of patch 1 to state that this driver is used
  for the IMX8MP-EVK board.
* rewrite commit message of patch 2 to (hopefully) better describe
  why we need this change.
* link to v1: https://lore.kernel.org/lkml/20250821105634.1893-1-laurentiumihalcea111@gmail.com/
---

Laurentiu Mihalcea (3):
  arm64: defconfig: enable i.MX AIPSTZ driver
  arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
  arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'

 arch/arm64/boot/dts/freescale/imx8mp-aipstz.h | 33 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 16 ++++++---
 arch/arm64/configs/defconfig                  |  1 +
 3 files changed, 46 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aipstz.h

-- 
2.43.0


