Return-Path: <linux-kernel+bounces-863509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50099BF8046
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CE39356F45
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E4350285;
	Tue, 21 Oct 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="qw5BLrfu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2DE34F27C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070191; cv=none; b=PdvTwhcPVVX+sjPhA8mocV73GV82us9kIVFeEq6e3n+5sT2fiy6YiSX5zlUPMRjs5HMqnpzaWtteiWMIDmUUNzbBo7zJIAHqrUhcZArrQi0d0TT8XVwGfoyOBLEkVWtjC7neXFi6NxjXSuAlDK31KpVhfcyhee7RXMC7Q7x9WUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070191; c=relaxed/simple;
	bh=aRp9PLA2Ky1tVA6uHK/HKcddWUGAl0+QPgh6k0eSPvg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GjQd3EMmxSj4tIz2guSoMJF+RBup9bEC72IJuk3Vvl7Q8YUDDKEcYnfc3KWbLyTrHdXDG0iFvduhZNwTYLXdgz4qpLePw6LRCoMDH/ODp8V6MRdGICUJDFr+W2cC5R3pBGjdZkAvmrW1Km6qgxLisKqMDJSROrzuU9SNnqt2cCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=qw5BLrfu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso1130298866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761070186; x=1761674986; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruRUvdvkZoLr2jJW0Z1cLwXXKdDFMs/zL2a1Mukfk9s=;
        b=qw5BLrfuRyqVv/RI69PT48U1aQMImgHG4w+IxtLVGQ507YWzAkf/bbWVpcmuHRJBzj
         K/Vxu8mvoIWV66ccb3pHFssuCO1P6Ominbff4HBiJfYnv++HhDU+M98uuD6UOr8D+RLX
         oX0nsuf8KhXvVQJlGjvb7gPKjKNGk1WtKBMrt+Jjo+N/yrJgB3CpMUoLnO2emKkHm8PB
         C7k/qkEGSTeoxabXWNsYdx6oUiVHVqluN2+SVLWiQG6GcU0pZsswroz6rJC1L3o7APtd
         wos/GbE5AL8udIAcGT9a0k7vueCaQMSkDi9f01o2hU5vdB62iztixttAr52d4dPcpT6u
         oNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761070186; x=1761674986;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruRUvdvkZoLr2jJW0Z1cLwXXKdDFMs/zL2a1Mukfk9s=;
        b=ZP+inoqWwwaM0mg9FWfszi2XgLQvbdqg7RSJbYx/PnVGTCHyP5MDqLt9Csd5xWiGt3
         UkNHhvkEQtfFV6fPgWGuq9QIQIUdTHQ19OQKlouFZCA51L/yNPqRS29BRfmmot094BWj
         s4vmQYQT6KZjtjCiTY9c4k/gywfQuNLFcGk4DYeFmmkVlBebWRmPVLpf7Oq58/vX9TmN
         LnWJIN//zHhzq9mAg1SmG+v4hTzJxKM7koiUnf4bVV9+4Imu67/QGcdZlnsYjfrX6nAD
         g845I/FWMbV8JGZPM/79j7hoRluWisy0Ofpbi0gP1Dakm8BWwuKRrrwCo7X0qNC/kp3d
         gEWw==
X-Forwarded-Encrypted: i=1; AJvYcCU5dCp5C2bmBvZ7I/eWx/BGyWk3BdB5wTPx+jKfPP/CvlNQ9XkvDh0y+jmGNcjCrabyrU89eer71X3gRdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xYmYpnrlr2NNCUsyBL0VusRMgBhgXeWqD89UeaUJ/RPdP0y+
	5/AX7s549QhHDbPyCUCyfnf6CJtCa+hwgMh7TsSCRxts/zg+g2Oh2VRl61JXLEtDYq4=
X-Gm-Gg: ASbGncuwUxsaxQhIAW6+mWLUTBL7rV0RnHD4pwUbt+OuvH67KBEA3cKq/xsOsa9lzsl
	yUUG8IcS5mFJJYeu/6LKk8UriDJoY+oE1go//sht7f8epIijZsdnz+kROqDEkUlyQ4+ccUK+GHo
	nOqRdPYq9ZwWwpr/86s3mnwHKwEs17WO+LYYNxwdbKAk/MirR/1qQEwRInQ6gQhi6a2ODFS7n5k
	ttIS7nEtN2NynRHH3svsyk1qKWTobPm3SV+e/3oCFNU5AzvKi4/NKk/zbOS9WsPIkJU/oAa/G3z
	q+hWKtfKY2TdSvHTjVQ1vO1jCsg857rqaouqjcmtTrlJ32jwVrtf8WTZm4GYRS3hEqDwYraXK8R
	Z52GR1uNi4npTLCIGyptyKmTDb/6T1jJkVYHQl2V37ttyJ+3ulURNYWdgOQBQJqAxyaCdOeAfwS
	eCV2aqxlynb6U4Iz+q+w==
X-Google-Smtp-Source: AGHT+IE5avVzpvShmbvSnzjVvBNOm23bDLEnbiX6D+4Il8N66SDi+tTOysqbM0IZc2AcphKPy6ifOQ==
X-Received: by 2002:a17:907:25c5:b0:b4b:dd7e:65ea with SMTP id a640c23a62f3a-b6474b365c0mr1913226566b.35.1761070186373;
        Tue, 21 Oct 2025 11:09:46 -0700 (PDT)
Received: from otso.local ([213.208.157.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8393778sm1116758166b.24.2025.10.21.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:09:46 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Fix Agera PLL config of CAMCC for SM6350 & SM7150
Date: Tue, 21 Oct 2025 20:08:53 +0200
Message-Id: <20251021-agera-pll-fixups-v1-0-8c1d8aff4afc@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADXM92gC/x2MQQqAMAzAvjJ6tmAHKvgV8VBdnYUxx4YiiH93e
 AwheaBIVikwmgeyXFr0iBWoMbDuHL2guspgW9tRawnZS2ZMIeCm95kKOnb9QnYdqGOoWcpSzb+
 c5vf9AGVVLs9iAAAA
X-Change-ID: 20251021-agera-pll-fixups-dad6b12c715a
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761070183; l=921;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=aRp9PLA2Ky1tVA6uHK/HKcddWUGAl0+QPgh6k0eSPvg=;
 b=ZZm6/NmPI1u7xNg8IcgQWaMv/5laGL+vT63Yqr0y0G9t5kzsMV4D43xY90DReDodb7sG5F7Ga
 lYwR2fsKLeEAlTe4FrguUevMwr8AIOwddbg+Pd5SurfbMzZ1i0MXvEQ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

On SM6350 I noticed that CAMCC_MCLK* refuses to turn on (being stuck on
off). The cause seems that PLL2 (of type Agera) is not configured
correctly due to the implementation in clk-alpha-pll.c differing between
downstream (e.g. msm-4.19) and upstream, and therefore the USER_CTL
value is not configured.

While looking around, it looks like camcc-sm7150.c has exactly the same
issue, so fix that one as well.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      clk: qcom: camcc-sm6350: Fix PLL config of PLL2
      clk: qcom: camcc-sm7150: Fix PLL config of PLL2

 drivers/clk/qcom/camcc-sm6350.c | 6 +-----
 drivers/clk/qcom/camcc-sm7150.c | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251021-agera-pll-fixups-dad6b12c715a

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


