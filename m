Return-Path: <linux-kernel+bounces-722680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C5DAFDDA9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E6C1C26008
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923601DB13A;
	Wed,  9 Jul 2025 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ5DAkru"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2A1426C;
	Wed,  9 Jul 2025 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029272; cv=none; b=chlmzY3y80woWy/rxinq2zLtAR7MYj/QwxbArhif8by/h8XJZ5mQRcNaJozj0WMrI7SzYlTi4UyzODOHJ4eR6xJ9jKy0O46TjJMZvWaCVTzv3FlG6iKjCHmdx+KWbsN7VyVHA+aGtHckPpn6XCGLUz+YKGiS5P/saQuQ+7xlLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029272; c=relaxed/simple;
	bh=0Lv0YgrfcpDpaB58TcFFJmkkA+H7vxSRyzlBjqQoFx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijQK1zgsMhQieYgramCBCjqBzOQ5/T0ZkVmxAOWYc9WONZbt1Wpv/CRK9hmQEOP/l9wINIjdCjSn8hLbngXAY+jfMoSW3eX15bODpxIMiUS/zy4/n3Fr3+EMHuIkq3Ji3WE2xD8BQf6ZD1uqMbTeg/zgLLDE+yJY9LAorlPN4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ5DAkru; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so13392a12.1;
        Tue, 08 Jul 2025 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029270; x=1752634070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvJ1DnScpBFRBlV+VAHMOyg4AZW/K+RP8CE6fW8qvjY=;
        b=dJ5DAkruX+S+SFAInu1LtBlKs2cYWt11RvT3uCu+wHgH4Hqy+NjOunc0HoJJW9xvBs
         I7081mQ6uSX3Y7rd00sVtKbNs06wXUIWphY3n1N2GDwz1o8ZCDucZdaShHMsIgr125pc
         yQ2OkprPstNBac/2+L7j++LtJIEEbozu8h5WGpj6EuHV7I8KhCgBAxO2sUtwm0coQzUB
         BhuzQKzx6G86yEao1s3pmG252aTKKrEnJbt9p3OKWydJSdhiBL8PZt6v62nY1Al06dyJ
         tP3FRzEqYquRY1/jcMmDeeKXyhMwcbxpSRXKKdvSKBE1cLlX0xf8MrwMt3VYeF+88cpG
         wuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029270; x=1752634070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvJ1DnScpBFRBlV+VAHMOyg4AZW/K+RP8CE6fW8qvjY=;
        b=YmcNk9XzAgir1YnZ9nkjzYFbw2AspAXEWsapibyqnD+w7AhvRD5PucOUe1kZiWTbcu
         2OtAU4NTB+gKPRlxfuEY05BSMMkX67+d7kQjQXHr/MvlxvnN9jnh1pYze5GKlhwCirlp
         VIIrnMI1/bFNp+VdZJSL+Bx9uP0mLieH5xXcUuUlm5H5aukUnIv/vOuvpsZo7rq3/9l/
         AVsRchC8BnQNMuumZympapzqTBIEnr1LMTIAwmSCXmJWrvnvuADvy6EHCYfAr2tF55Nu
         /uJdrCTu3moxjW30aD0HMs01FKTFLZzBMHFEjUVchpdlpDadjqOVuUzMGhBOucIVMluK
         M3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVLjnkGAQ4mMWSQGSl9OOmwMrgbgdWVG9aAoqeln1I2AfxVocaeC6EtMeH6BlxnDhVKyuVcjmPCxBYR8sYc@vger.kernel.org, AJvYcCVQn2c+3rb2Ie/FywQno4FnrKxDIpqz9LuGmP/5Izuj40QeK3+GiFnHndPNQW0sVhru64WMUg5F4da2@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQD8y8p/Ii5hY6qFNRPxBp/dwg4AzXsjTsIaJ1TFisPHsYLQR
	T3PySjNAoxurWwjAg4V1tVmv+DSQbuqU8GAn+YEmwOYPf0kEZTTSddhK
X-Gm-Gg: ASbGncu5Y5gL8Hkf3qZXE4GUM1OCsibKGAfToqWwXlq2Fo0+RYQvaK1Q9wC7CEud5ch
	mIA7Jqd27Na2l6Stn1v0kQgIYADs00j8d8Q/ATWN7ocyxtZwpTZ2B+fs0Qt+7O/vgWae4Q/85Wb
	6Dr6/Z30plkLHSsCFs51y9kmVzHbnA7txIKZu+EBIkcucAxyYkOItcqOkvHXm0Xd6rvBX2hajYo
	TCZVz2aEf9Vv14Wnp3TkWGzftawY97GunHvTNpke6fNYq/FHDQVzoNHW9f4IW0QkS3HhwlL2a2x
	EDuooLcwYDAKV06UdtJ83w3qUVJE35uubwSXBhApBZ2gU9AZO8Fhix5N+AFoXWC6xMqIOlBbePB
	fykI5
X-Google-Smtp-Source: AGHT+IEHTwtKlKP5EkfXgvySIanUlWJEAddsRIGz6dpsctl6bAFefwPM0npLBBbc5B2BrlKjK76mYA==
X-Received: by 2002:a17:90b:2f04:b0:313:d342:448c with SMTP id 98e67ed59e1d1-31c3071be6amr961883a91.17.1752029269752;
        Tue, 08 Jul 2025 19:47:49 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300b50e8sm535082a91.31.2025.07.08.19.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:47:49 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] reset: bcm6345: add support for internal ephy resets on bcm63xx
Date: Tue,  8 Jul 2025 19:47:24 -0700
Message-ID: <20250709024740.194520-1-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm63xx SoCs have a register in the gpio controller that controls some
of the phy functionality. Some of the bits reset individual phys and 
need a driver to set. 

The other fields in the register configure phy power and will be set
by the network device driver. 

Kyle Hendry (6):
  reset: bcm6345: add support for bcm63xx ephy control register
  dt-bindings: reset: add compatible for bcm63xx ephy control
  dt-bindings: reset: add BCM63268 ephy reset definitions
  dt-bindings: reset: add BCM6318 ephy reset definitions
  dt-bindings: reset: add BCM6362 ephy reset definitions
  dt-bindings: reset: add BCM6328 ephy reset definitions

 .../devicetree/bindings/reset/brcm,bcm6345-reset.yaml        | 4 +++-
 drivers/reset/reset-bcm6345.c                                | 1 +
 include/dt-bindings/reset/bcm6318-reset.h                    | 5 +++++
 include/dt-bindings/reset/bcm63268-reset.h                   | 4 ++++
 include/dt-bindings/reset/bcm6328-reset.h                    | 5 +++++
 include/dt-bindings/reset/bcm6362-reset.h                    | 5 +++++
 6 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.43.0


