Return-Path: <linux-kernel+bounces-815621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D649B56911
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3E04203CC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0173D1B85F8;
	Sun, 14 Sep 2025 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwI51HHM"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A07262E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854979; cv=none; b=PMZKVg4jeHYb+CYhHlREw/TYOHEDSG2oYjuQfqy4QakxAmzfP0i/mBxN1gPwjxXJI63vpoaQuOjb7Ws4O5/SPoreYphrsMsq+agYf69Ii/YhkJcgzfdF5aRK53acnnLKr8SmfttBCSn5FOJR0/jG0KYayvxULtCoiUGtkzrKhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854979; c=relaxed/simple;
	bh=rHuGnmNSAWtGbO8Z8WgRAPBhmsVTpCs/w3FGfSbK7vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wc/XyA3PFayY7zxdNSchnjNP4ZGpA+1u03sn2xTfgq/Wm//ORgn5jYUCNZ+2nc/BZp+JqWNUiO1oYR0tJYxeIiiYs3bjnqdKwk07k2Mld6W4gdtZAMYXag/ncO8zhOUhMUonOtgW1cdTsK0izyVKE8XAnIE7MByj5j01lqzmin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwI51HHM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dec026c78so33257695e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757854976; x=1758459776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3UizsZpg1Ha/ybkP8NHn55rTYoNi8egOSFYxh+y7kw=;
        b=FwI51HHMACcv7AjyhdBSY3NnDunfL1bVOzp97DOdRWHrDaLdE07dyG8J3F6K30161y
         LHbPWmB7fn7YACE3wEIBrXUnP2EyxiEoHeb6MiozeqtT6VGoKLWoa7IP4L6oACeEZOUy
         vUuonmB9JPp90AyB5t2omsaNFoJhMv4Y239gv1N97ZWdqaa+zYl6D8fPmSH9qb04g462
         E4gtr1PSLqSOQudmmznnODNCMNB4zpO/qcARoKI7MjWSwSZkuKdM6l41slOmNOLyjiJJ
         o05htwq+dENOFwrkaOZdGxOgk5vQzLTmcFblUmT7gob+hoVQrIKnoEj/q7Om6Zf5wuYP
         +Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757854976; x=1758459776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3UizsZpg1Ha/ybkP8NHn55rTYoNi8egOSFYxh+y7kw=;
        b=ALRxmZRUFsnjdR8ia0jfhhnszwQZDEUX6vUIEE4V+zmv6Tr6swE+2KuT0s8PdhIgEN
         ScEsF0YLZhT5gJ1xW8KBP2XuVeDQMlPMzBSo5tlDIF/EF7hPRSRMHPwtxTx/QR+bl4vD
         FErbDEL8LRwjY4gIQQ5tZTooBP9MRZxCSBJk4EvjbpC2VlenjJSv5tftH+rupQ8csUJZ
         3DnYsipH/V4oa6AHjKKLBelggbBB7TVgiVP+JtJ3sThhv6lI0gGLC8C9nHfNnKNExqS0
         ZSER891a+sBIZpC37sqGaqZCXHBMaZoYFuD+cV5rId+zF3S7cP+ybdGqlWt+76RbI8mZ
         A78g==
X-Forwarded-Encrypted: i=1; AJvYcCXf1SDXbR6jdqss266Ft6GJjGnS35+OdFsgwzwumjC0SjYeve6TAwxdZY9PqAVXvaApEOGeYsJs4k8kLEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwlpx/wLOKC6ECnFBcwrAm6UvcsgJQJ59eBqVrFeQ5wAgzaYUX
	a9MqUw0AptxfHAd31gWu5q2YR4gVHW5mMJtmjzqLh2OmIxVl0NzVvvFrvblV0Q==
X-Gm-Gg: ASbGncv/gmZaFh4TdeNlaDye1qreDYoj2+HE5bs8unSr6EPQW532MFKmp7vRarp5T11
	V76g4sxq4ba80IH98DYd0jlbKh4eXaTHC432bnlbkIIwftY+JsvCd7aa0aimEAyXoJqz30t0bwH
	hBHVfQ+LuObuglQu1KGwM07p//QRizu5KBOuhRxXUe5eCL4WB+Gf97CVidYMKmgiyobKIQ/TInQ
	ungBU0orFcuy20NqxCUlJRVVFr42NJlMX9S2yKzj2tHMH1a5MhYIGWr68GuDiEO6OJvBE/Z2gM9
	jPUmTaUqjr5qQ/NRv/bniV/rWvAZ39Qyj318+1TbbHaH/H5CbVjxav0/kmr7gAkLwV1yt6N9fHh
	38ViOMnQNh3OxRg5snsRgdrl4fg8okG2w4yxf9qnRw/DLmpIgroucKQ63fJen4HU9Lf7cjc+3PQ
	==
X-Google-Smtp-Source: AGHT+IGmdtP+Xjj7Yz1YjXKOoV3AmMEnzLyC4YA+29C+PPV4+VMe7iGYUdI+/lEFqgOw121dIqHB9w==
X-Received: by 2002:a05:600c:6dc8:b0:45b:8366:2a1a with SMTP id 5b1f17b1804b1-45f211d577fmr60534635e9.11.1757854976111;
        Sun, 14 Sep 2025 06:02:56 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0187f0a7sm77060965e9.3.2025.09.14.06.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:02:55 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] regulator: max77838: add max77838 regulator driver
Date: Sun, 14 Sep 2025 16:02:28 +0300
Message-ID: <20250914130230.2622030-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patchset adds support for the max77838 PMIC. It's used on the Galaxy
S7 lineup of phones, and provides regulators for the display.

Best regards,
Ivaylo

Ivaylo Ivanov (2):
  dt-bindings: regulator: document max77838 pmic
  regulator: max77838: add max77838 regulator driver

 .../bindings/regulator/maxim,max77838.yaml    |  68 ++++++
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77838-regulator.c        | 221 ++++++++++++++++++
 5 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77838.yaml
 create mode 100644 drivers/regulator/max77838-regulator.c

-- 
2.43.0


