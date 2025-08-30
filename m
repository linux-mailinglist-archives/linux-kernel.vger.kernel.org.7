Return-Path: <linux-kernel+bounces-793093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01250B3CE46
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D617A60CE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083EC2D63E8;
	Sat, 30 Aug 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWq0F2uf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A5274668
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756575542; cv=none; b=Zo1G6BIb+tJ3UyyzNMK5joGSGBuWH5El7p1izfcJVHQGrMyigPpmd1XldPrwq3k2ztK/okKyA+os6b2Ay0orCcGHSAealkfN4fq/T/T1DlBg6Wh8F0N39l7LrftK8+nYkYYaIIbPYxGbLH6wWyvVqezx7POZl/mwNuxXoqp02xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756575542; c=relaxed/simple;
	bh=XUFaq11L06NRQuF5veBS9YFaeK3iZLILO+qa6z0KLig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L8v2I5WZA4SPx1uS2WoIxBC+3JcmI4JmVQ6wyaxRdSd6mRJfxoCeHodAw89+D1OYuwsb92CNEvcZeXq/qprCo369YQcCyGEOjfHiu5uAyPqwVFgIVtjgOfPuarycLCGnFjQrXMR+oT/1aQSbJPZj12BCovaT4aR++LjgmGJYfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWq0F2uf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24914277174so3594265ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756575540; x=1757180340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pd3QAgaI6xLn3TSraR7jO04+lJz847xBQQfmdUU8S+4=;
        b=MWq0F2ufAC43N3byFICVp+lovUYkrb196QIedVSI6mtWDCADDgLh9ZpZghGbmIiuKQ
         qOSWqIe+Ue8UnA3MJS8vuZaHQ7l51CCqoS/J3f2N7xtrFazRuesip/85qtWRnQ7g5/Of
         gmt0kcA8MuKxlwX0CodgoQjLEUdsAi3RMQn6UZodtvJmPO3cF2f62pzBpTIZgXq3xBpZ
         oESMVyUrl1rhE1Cpx6uIV+9beqqa8/uTVrWxQaV9EagXJdhOqaTLKTlFo/adXe+Pc+qJ
         w2lXY1mhIU0Gc70CwvYKHr3uz9mp28M9eJRIAxsRYv5rnY2UM8OwuVJeZGhbvjUL+ggq
         LSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756575540; x=1757180340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd3QAgaI6xLn3TSraR7jO04+lJz847xBQQfmdUU8S+4=;
        b=fnV8rosAKI0Y88Z9M3P8CgLtXHnpuX3NJlvqPs0aToWNdpA7ajSgerxB6treCanEyT
         5JVSmrd/0fgiUX9iOtD3+IUpoguXtR1mrscAnNTEUccGdz7yf1htPHhJo1xfo/koxNaH
         +/f6dj6s11GrNhuB0fEluQAd37rbVWjZF+R/UR8j41Rny6qT4gCFMMuadUMFnPnmoe47
         TgRipGweZFcqK6eMjc4hiodeNNDYs6iSoPn2HenPRhIn5pghTuqhEmXz1F78+qeV16ol
         JD5Ophy3epwDLqfp5rDtmbLU2y1P72Ro/F3i72iSbVVc09KKwHHC7vC3SlrlxUuFvnLq
         bkbg==
X-Forwarded-Encrypted: i=1; AJvYcCUf8K+Or0QI0G6vAK1Z14qIcOG/zkxxc2SjeyHnUuvfofXuC7eATQ3nDO4osTMcsUef5dgA1ZJe6nuBC9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvH8UMSnvBrM1y82j/xELikQFuiWRn92ohBZmKeM5fVr1MiZJ2
	VwjTLFFSdL33hgapuI9rgSaby9noSe+KR/R+RR3sGF5yPM8Omf+GFQCfEiRnHg==
X-Gm-Gg: ASbGnctt6g1DYDdQ/A9O9wjW8+MORmoXlCPRmArui4qAmuzoLOGGEnI872PT+rajolu
	sqmHBZZP5WIWJLXbkLKp3aBroTOq0hABjhJP2evOUCS3/b9r+ZQWXtp2/ExaEmcVXmagSD2ZrsG
	uq74vib/y8dhS0QkcIZe+N+U5WlI3QAbE94FCkcXgzKxXlyHZyj57rtIh5FuEDYKfapE1UVqH+v
	PKAd1pvdm+EjmkFEJfy9hbEuOoflpf7tS2M7sKOWK08xX1/tt6zQkZU7VwYJl1Vus8fAZvC93/i
	Au+JeWCOfnRyX15A8JMoxEsecVUDwPabG/9HgHjajZ6NJbxDKgI2i2ui7EiwGiBdg51YPyrONe/
	jLCVpmXtjuUvB7SbANsXesFHUqBb8O7BjoaPABzuo5g==
X-Google-Smtp-Source: AGHT+IGXSHsujaSl2ROKONAWQE6+Ygosv4F3z5UVve5pQ4wzulH1rYWqg7jKwQSm4YJbOk69qQJB0w==
X-Received: by 2002:a17:90b:4b87:b0:324:f79c:2dd2 with SMTP id 98e67ed59e1d1-327e666e931mr5142096a91.8.1756575540232;
        Sat, 30 Aug 2025 10:39:00 -0700 (PDT)
Received: from raspberrypi.flets-east.jp ([2400:4050:d860:9700:eabe:57a8:cf74:875e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ad39csm5154525a12.27.2025.08.30.10.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 10:38:59 -0700 (PDT)
From: Masaharu Noguchi <nogunix@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev
Cc: vaibhav.sr@gmail.com,
	mgreer@animalcreek.com,
	johan@kernel.org,
	elder@kernel.org,
	greybus-dev@lists.linaro.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	dave.stevenson@raspberrypi.com,
	laurent.pinchart@ideasonboard.com,
	hverkuil@kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH 0/2] staging: fix W=1 format-truncation warnings
Date: Sun, 31 Aug 2025 02:38:48 +0900
Message-Id: <20250830173850.323897-1-nogunix@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    - This series fixes -Wformat-truncation warnings in staging drivers found with W=1 builds:
    - greybus: prefix device id to widget/control names safely
    - vc04_services/bcm2835-camera: compose V4L2 bus_info safely
    Both changes use scnprintf() for the prefix and strscpy() for the remainder. No functional change
    intended.

Masaharu Noguchi (2):
  staging: greybus: audio_topology: avoid -Wformat-truncation
  staging: vc04_services: bcm2835-camera: avoid -Wformat-truncation

 drivers/staging/greybus/audio_topology.c              | 11 ++++++-----
 .../vc04_services/bcm2835-camera/bcm2835-camera.c     |  5 +++--
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.39.5


