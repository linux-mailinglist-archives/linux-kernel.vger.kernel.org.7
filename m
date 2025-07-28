Return-Path: <linux-kernel+bounces-748607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB178B14389
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0644818C2EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736E51FF603;
	Mon, 28 Jul 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQE4OWGf"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742E225390;
	Mon, 28 Jul 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735905; cv=none; b=bTOI5j3k3f1OuWrFOEgThqpqy5El3idbzV29ydZxMg74do/Esc3EmNVYJIxCI9W9AyTWYlLL6byBFfxzjbLtA6TSwAyf/6BuTyRzz5qC8xAQi4O9RQ1HA4Gwnx93Kx/krRASijQKC6uh4aKMhbIavHBPzC5ux4aqnGS5m5paY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735905; c=relaxed/simple;
	bh=F4E6RFYjfOv03meJmenFJfGewLwVLzMRi4//sH4JZfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hm+73XNZE8HeORXEErg4A1StlFPr0yMa7bP4ooFwVCrfyfwaRsgrtxZlI/bEoS0OvbRsjrH08ykBTrHn6Mdv0a5aCx+vj9VsXxUEy5/rX/Syw8Q06VlGc6Owievqp2IlYhVgvmm2uOVsb8sQLSpKj0ImVJ2Q5kCbawXmCGlqV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQE4OWGf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0c4945c76so686103366b.3;
        Mon, 28 Jul 2025 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753735902; x=1754340702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/a0TKjOObxecj6jixv6vDQZj9yyJYbd1cgMGX4deuYo=;
        b=AQE4OWGfkWKG+TEu4duMYDcmhZJCFIWTj9pIoJtbEmwDiemascqRNwxUkrw0DK0QIg
         nNsgS69oiDcGmyTKypJKRO06V3wNnMXKl0ufK7TXsCpo+1vkx9niuPJRF5WXij5s1j0e
         NYDW/GvwiaClGE9KnimvB+RnbcD1W9O0e9VX+mK/VjICIvSKi3XFdtk2FXkP/OLksIBw
         vom3Bq8u8dFOhmMDcUNRCbcm0Djblr5ffkYCER6PsDWvuP12Nir/G+b2+seyLuYUAIzX
         AsdcLqW+w9TWhYDDvJq582cHiBdgaoSyrXJcoPX4fTwMm7bB5QI6qcTiuS89pgv9mbZV
         OmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753735902; x=1754340702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/a0TKjOObxecj6jixv6vDQZj9yyJYbd1cgMGX4deuYo=;
        b=vSU3f7bb05hOB3O++ZslwUPW9iZVoj76QolTvJEF6w+lISadWns3JKMdVq7OP0K6ia
         SKCxxNdAuCTc1DbgNeIwrHiE0QXkEBlx6pBV+Pk5OZ0Yc9eNCWQFdB2sDY4164nU+ixg
         BUiedyDoZa38HBmkdNnXWcwwNtDtx+HOe/5y8X8OQho4+XHwA/Zn7w3KfqqpeV8Agmdv
         U62XjK1lmqBz29ecbpeYNI9FvWY4ks434oz4WSjbEgeIAu2N6x+legmOj4C1N7pl1Fqx
         +P3PwO35CUXPSBWRcvfRELPp6KgeqRSNFgqsWxIrvqx/CoaLH57dRSsmNDZoeJpsSYiP
         6YHg==
X-Forwarded-Encrypted: i=1; AJvYcCU8d+WdaCDOVMFA1e6w2RlG5D1N3yQdt8mkz83lEVerjDlnwrdb3CGmS/+OkfmAhiDS+UfLJq5xhzY=@vger.kernel.org, AJvYcCUxl7Cz5NjnZiYlVmAoR65kd3bjAVROSPISnSTSiAC/CvITbfw57w3VK7CV2u/aZJuAwWmf2kjxrGhvBm0=@vger.kernel.org, AJvYcCV+7I0++sJkaKzXLOKWGwNI61cBYtl954C7tzeRxEopdgceZIXTIpxu55pdECU0M9S7RVpV5ftmI5nBidbn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3D/y+1wXt66a0w+dU28EK9AzbVSMMWX2HbQ8mSQiJXLz7hY+0
	ex9dzJdLuZ059JhqzJRNuQrq8haNaRliFG5mryH0wLrsp17ED2bg88V0
X-Gm-Gg: ASbGnctcDTVj1zeK2m7Jtq6WkY4aZQupuTsUuZNgOo5bT0GNuVnDWDbHtrZ3vkep8Sk
	MdrHv+R3S2pfkqZpEHfpoN9ENjvyNJKH8uQVyz/G3S0CFe3e/rV2jSk217C0kxqBJrycONSAXuw
	76FP54qc0ZXqdLq4fUayehoxuj+DYYgdcnPgPMow9O3R4yGYDE4/jJdIxMOQekYj8bBJuucuwGQ
	1+rHLRBFI0LhVkGpwkzOSTXcFERCCdrySOeLIWTlFX5J3zeJnQNE0mo880xC2Zg70ieuZZ3I5Pu
	S0HLyOoh3zua2bA/swpJb1hpDAkdV4Lbksid/EBMiAxbYR8/xDSZ9mfRyOo8sPTtEVrKnIbsCxm
	UJ2X0FNT1tKhbQYmn4TVPfqPFLslwkBiJsiVGr9edPyXAQwm/nmnSiTBS2zj0sDlHIXDEyfT8YT
	j3PIZmoDQoGtwgMowL2sX4iw8=
X-Google-Smtp-Source: AGHT+IFQaIQrK75IuunS4601CxOtGOea7F/kDp2frcXVS3rPysCd+KbNrjMRGaOU5puaC/3OA28KkA==
X-Received: by 2002:a17:907:3e10:b0:ae0:d798:2ebd with SMTP id a640c23a62f3a-af61940ce29mr1315086266b.35.1753735902114;
        Mon, 28 Jul 2025 13:51:42 -0700 (PDT)
Received: from puma.museclub.art (p200300cf9f013400cc194b80e1760d4a.dip0.t-ipconnect.de. [2003:cf:9f01:3400:cc19:4b80:e176:d4a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635ad589csm469943066b.118.2025.07.28.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:51:41 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] asus-ec-sensors: add 3 board models
Date: Mon, 28 Jul 2025 22:49:07 +0200
Message-ID: <20250728205133.15487-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This submits 3 Github contributions, each adds a new board model to
the driver.

Dylan Tackoor (1):
  hwmon: (asus-ec-sensors) add B650E-I

Lucas Yunkyu Lee (1):
  hwmon: (asus-ec-sensors) add STRIX B850-I GAMING WIFI

Nicholas Flintham (1):
  hwmon: (asus-ec-sensors) add ROG STRIX Z790E GAMING WIFI II

 Documentation/hwmon/asus_ec_sensors.rst |  3 ++
 drivers/hwmon/asus-ec-sensors.c         | 43 ++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.50.1


