Return-Path: <linux-kernel+bounces-809338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D702FB50C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0C5173BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CA425B2F4;
	Wed, 10 Sep 2025 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EefktYQl"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1C4315F;
	Wed, 10 Sep 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473564; cv=none; b=Fc+pK8PseYCSWg7brQICad/Bok7TzCFyrsaXcXLXCUP+VQzBp7ylFqpQxEXqJa2I6qRyxBcZ+0TpUoPmZHjVEhu6N6J5uUyKT/z55W6fa6YHqJHfdqaG1Id8yvk18oIBAVLmZH4mwTbM7iwXAkeJpyJ//IDNCdyYybxV8m/0Wzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473564; c=relaxed/simple;
	bh=gfjTr5zP2U+GyvGLNyxX4J33NOBtOA+LsVGcthn3XR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mTE7kX37TBnrZqSVEQ38a+R/aD/sUQ4Hmpj9l5sgrYp6xjT8R2auJYWXot0bbGZxafjOPL77sWIjE+phmyvtGlCz7pXUscqQIAFitXOl6PnzFzXNCJzKyqbrSQyd2NFm/qFxLBWfAL1rGlGzZ4qkb9p/HTyZpM/dU5yTwuMb5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EefktYQl; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266d6f57so7046395a91.0;
        Tue, 09 Sep 2025 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757473561; x=1758078361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQTQWVOok5Rz5EsWa62UL+1rMIHEWSusnO/rTh03xFQ=;
        b=EefktYQldNppBJcOJj/FE7xRB+fwLuoa3RCoqfWbmNa0Wl6xcB7Qya9M69CoCCQhlP
         5PENsHbQ7OnGUgeeZ1qbpxqM4H3Idut2ZQIISFs9XCXF2o3KTeAh+lulQdv5WQFwXBkZ
         4N+djyPThhe0ohk/kFjRu8Osw5j3ASwzIcS5vN+igJ7TWPdO2G6FodjIFsel/PF6BlJ5
         6g77HQzEomZI854kI14XyqNUGffp07KsmbbU1vb0gyybAndyXKer2JuURXWIYkZRnDVx
         SOoKLCxlpwKAGkHq92kY352sXh5HbR6E22nJOhMjbfypjSAoFZzerarn9zdUpVZxJO6m
         dZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757473561; x=1758078361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQTQWVOok5Rz5EsWa62UL+1rMIHEWSusnO/rTh03xFQ=;
        b=HnULef9YxkvoXGTmnygjauZHhcRWclMwQG9A+TW0I0sVvay2UXQItmqeiJdtaQ04kO
         c66qEiSi1sVUn+AtyCfwpRZlKG2EUNwiFnBo/WzsqSTeFJqNQU+YpPdA0OHJqTGQU5z4
         ddrGZnIZ/qHyr5kIV1N2/ZdBhj8pxI1xxPffCzMPeJ23iplFQdsa/X5NrBTLb9FYlAmw
         9t88VFK4k4sLHWbIvmy1ZkvPi9pIKU70ovIZLF6oNeQ0GuDgc+6Qc6Szb4oYfzanaa1d
         +cSIPGDDBCMSxJ1b/egc3n5CInHOXkY7RUY2cL2re+noelWgJgxg6pvhuHZfoTpHiBaD
         xlIw==
X-Forwarded-Encrypted: i=1; AJvYcCWQT0RV7SuP5nNPZrzbuUWe7PDwdwPRqylxlXVUUyjZVEh4eTHHoeSCBmR8kPnuaUIBdcabqrHJZeuFPWT5@vger.kernel.org, AJvYcCXX3NRcqVIU8bw4U0YIWrmSBPtG5KQkak5CI9c1shbvabPoqWBApJmfwIPvo3koZzFDMtrYlbsorjDk@vger.kernel.org
X-Gm-Message-State: AOJu0YyywY9B5OXPcRUtzkSDvqkKH2AxCIgGbPRnqeTuTaH656m3But5
	kQtzMT24+WybEOgfNUmsKaUcfneIVBkPJHhehqF8a2qvtDO5ZY2VyD/y
X-Gm-Gg: ASbGncur1O7cUCah99D5Q1U0NQmaDtVnZQXGFPj6DJ6FWcBe2UGAlAw4frc0vyrSG08
	+uU8o+3vHIgdGKfS4N4VIQwrGFbz7FXYGHNxG2+CQBs1asipq+/++g3FSsk8vam6TIT2AJhyiTX
	QaNGm8DpxHQi431srZHYVjHRLzTgpfSi2J1h9EUaep7k49AaMGSRAUJDYDu9a7X9Mx4IXfPO9ql
	lS2Y8RmQA+uN6yQ2/FGESPaSZrdyr+Wz4e25jQI9bwKlUP0UHKhtpi0RomWlL8wtz51UXA4yqz6
	DvOtR7uOo0vPZGve77h9YvWs3ouqX+MpUMUeu6tGbNG9oEoJ3FzTt2vCdw+NxXi0ywc9wLhFn6E
	0NJwdSHp612O8WgC2b+W6zNFQxGPReodIfhVdhV6xU+vRwnxLjR0hM/frxVeHucsyaljsG/ff+0
	C48uxlnSTeLIhlg6biAIXw2dMteYB6VsZaWE1gTzK0yNR5szDIQRSpn2A=
X-Google-Smtp-Source: AGHT+IEQfzBjwOqCuuatAsbH0lkQs589LNfHL0lVajH292OEXnFVwAmGYUIRPLqbMCBNk93dfO2O4A==
X-Received: by 2002:a17:90a:c2c7:b0:32b:df87:1ede with SMTP id 98e67ed59e1d1-32d43f18a2bmr19741918a91.12.1757473561477;
        Tue, 09 Sep 2025 20:06:01 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466290d84sm3539093b3a.65.2025.09.09.20.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:06:00 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id A4845800FC;
	Wed, 10 Sep 2025 11:10:33 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: tudor.ambarus@linaro.org,
	mmkurbanov@salutedevices.com,
	Takahiro.Kuwano@infineon.com,
	pratyush@kernel.org,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 0/3] mtd: spi-nand: Add support for randomizer
Date: Wed, 10 Sep 2025 11:02:58 +0800
Message-Id: <20250910030301.1368372-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Introduce randomizer feature for SPI-NAND devices.

Add a new DT property named "enable-randomizer-otp" to enable the
randomizer feature.

v2:
* Create a global NAND DT property

Cheng Ming Lin (3):
  dt-bindings: mtd: spi-nand: Add enable-randomizer-otp property
  mtd: spi-nand: Add support for randomizer
  mtd: spi-nand: macronix: Add randomizer support

 .../devicetree/bindings/mtd/spi-nand.yaml     |  4 +
 drivers/mtd/nand/spi/core.c                   | 24 +++++
 drivers/mtd/nand/spi/macronix.c               | 89 ++++++++++++++++---
 include/linux/mtd/spinand.h                   |  7 ++
 4 files changed, 114 insertions(+), 10 deletions(-)

-- 
2.25.1


