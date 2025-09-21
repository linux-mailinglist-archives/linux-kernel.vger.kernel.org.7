Return-Path: <linux-kernel+bounces-826176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527C6B8DC38
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438EC189CB0F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683DF2D7DF1;
	Sun, 21 Sep 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhiS1r4B"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376022C08D1
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461675; cv=none; b=hMVN6oqqkwNSN7UB8z4DldCX8NtonUf0vZVwyPOaXEih9RdXTel0sgNXheCgs0SZVkHCoxTCn3z1P5axGMrPSjAmAig27iXB9ZTx6Fvi0Wep8yRqHFBshHcyx080GCtyq7D3c+/Pi3t6uKfm1xqD2a3qKHv6cVbPg+ZWLMMCRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461675; c=relaxed/simple;
	bh=W+MdQviWUrHmllDXqPNcRT0Vif/KVaI54aJjs7g2kRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWoH/mFZFRJ37HTuP+q1dSrsPSh1L+2M2e26SCRQfRF5lljZPyFM09Zl/bWx8jpPqdvCnsir/1woI4uum7YrkGyH2loUEbIqZheALZmnOOUWVPOuEPONE+eTex7G3oBjguhkgWYnjqd5jdYaReYciCga/f9LkMZsWeT65uEiTZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhiS1r4B; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee1381b835so2224885f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758461671; x=1759066471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMhhKCmyO0tkOfkSwmubre93MqE7/JLPoa9fLatUrvU=;
        b=RhiS1r4Bm5Ywpgny7F/7/ERcxFuVNZ1dLhJH7VxyiA2uQr8wjfbaiLOSVttpBRIWAe
         cNShyG7WMtyzga/baJiM31+ibBixPqsRJmuuRD5ZTi6uQTyuNj2ahWxj69PwhNfeCemG
         YBPYyq731QTmVexQrcZ/Er0KVuQafQ497ztt7+L5fX7920B/OYAAPPwBl3cz8WGu/Nch
         9/8OSHPk9fMS3INDh0MtZ6gsuBJ/pX/twCKP8Ie30TEPnoomVrysc9yjbVs6pJwx0dg9
         rIP7hmeY72SZv4Gtpybtt/TVLPJqI1yfqPqpX4XVHA0Yynz6Xc2JJHudVfPX+qjdALCy
         D6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758461671; x=1759066471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMhhKCmyO0tkOfkSwmubre93MqE7/JLPoa9fLatUrvU=;
        b=NPkgcItAtqtrUxerJxx/I64xqCP0Mp4UD01w8BDUEnzcoW4kR69Y82TbmYZWuPg4WR
         eq+H+bQs1nbXQ4tdDKJD4tCFZIAMqPSi55DJh97FDy/Og2qenc5CYcj4aLiknqzYyJV1
         0ySRGKVuwSzGiHfvs3NHzshex7C9QVW7V+9fDct18354yhR8X7784BKVLAynXNTuNeXP
         wHoWpA7tcCo7r4WB2k3f++BDTBho+1NrL+bxeIrP2o4RG/YgG0fyla0p1P1Q2ksK5eeD
         PfaStN1s+UfdGO8QDurhCsJE3kEzw508Ojc6n6AXFwqCG9YMtQw+WhEn3HlpzupmrBgM
         sUuQ==
X-Gm-Message-State: AOJu0Yy5Ss+kTX25TyaiW/Q4us78NnFzx9zcBJ6gKjVsIJbWapgAjVQP
	MTGwxeyWvHh0Ot44cLsYks9chekpCX7QJdX0RRq62+OThvTMFnFA8nA6
X-Gm-Gg: ASbGncvuBt7atOmrP6kvDf5FsQdbAA5jgKhJACa/Rv6Bmf6PFeuCBXmGKHhbGc2pCWg
	8VlMU5pWsw5nv+SVuKweFnOGzjRp8wqbseJtBsxs0RHGWkFWHbPk2KXf0dDFJb/XLT+BA2D6ogS
	srMMjE4CE6hiKIKh414rzyrMhlJFPGCT6UOjCIXG6FozwVsxICtzPpXOOBaSlXjJNAZg9j4b0D+
	UARstld9siv6ROAh/imxENqElzGbMlJodgB/3fnHUic8MHxTD2ExvFi90v6XFtji3wsxSC19Plo
	ozPwkydpvUsKOt12cS+ZODWb9IIYjGkRrCNCeYQJB9npdeCG7sK+MBGD+zue0hzvkHAr46dmOzi
	xXCdrA8qtyy61hDTfTgGf9qwSQlfTEJnwki0ovGaA
X-Google-Smtp-Source: AGHT+IEFtDhZUV//YELTB2p7puOk0cSYYIKzsLeyMKlfyOvsxg4B2DgsmNTjAlhUmPXeaySh7uGg9g==
X-Received: by 2002:a05:6000:2404:b0:3d5:d5ea:38d5 with SMTP id ffacd0b85a97d-3ee7e10616fmr8560965f8f.25.1758461671168;
        Sun, 21 Sep 2025 06:34:31 -0700 (PDT)
Received: from localhost.localdomain ([78.211.117.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fc00a92sm15910316f8f.63.2025.09.21.06.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:34:30 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 0/3] iio: mpl3115: add support for DRDY interrupt
Date: Sun, 21 Sep 2025 15:33:25 +0200
Message-Id: <20250921133327.123726-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This set of patches adds support for the DRDY interrupt in the MPL3115
pressure sensor. The device has 2 interrupt lines, hence the new
binding. I also added support for the sampling frequency which
determines the time interval between subsequent measurements (in the
continuous measurements mode) so it's obiously tied to the DRDY
interrupt feature.

Kind regards,
Antoni Pokusinski

Antoni Pokusinski (3):
  dt-bindings: iio: pressure: add binding for mpl3115
  iio: mpl3115: add support for DRDY interrupt
  iio: mpl3115: add support for sampling frequency

 .../bindings/iio/pressure/fsl,mpl3115.yaml    |  63 +++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 drivers/iio/pressure/mpl3115.c                | 247 +++++++++++++++++-
 3 files changed, 305 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml

-- 
2.25.1


