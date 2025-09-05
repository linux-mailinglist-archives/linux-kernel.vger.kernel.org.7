Return-Path: <linux-kernel+bounces-803628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE96B46327
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3260D58356F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3552750F4;
	Fri,  5 Sep 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YNZ2vfPU"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A5315D22
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099203; cv=none; b=ff4dKs8/xqqz0yIUyVulIz1xFfEd7nEfvHeuWNM2+NxvLyGBrJBs/Y+8oZSvluvw7SOqZBwR9/F73yW85Oo8h3KG8ZTkoHTQjFoBv4G5bh2112fjplYRsfgVeG6MIn95Y0A8AAIx5UKQJ2ihgBgk9d1+/EIAiPUfBSi7iRLoQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099203; c=relaxed/simple;
	bh=Oz5yDzgQI8awDA1imkucYa+mL2QojOG0Fc1fuxu/aJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QYsOEqN6gVeVruB/xwp04IAbc98iAbPIHMCH7KU0Q11of5lSmB3bWwb1N/huOD5mMG5JM9h7Z36vqDvypQrzWO2rqgCVnUEltdmgVgOeN3D8NZTLuBHwgmDuzIDhX8nQE6feSRNtwDe/wG84Uiwotm3NY+48ndiTYYykNdJhvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YNZ2vfPU; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-61ff9c5a0c6so645325eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757099200; x=1757704000; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=etsxjyg4YfsF136YzaCNVjjN75F0ELAgmQtnre7usq8=;
        b=YNZ2vfPU+9WNHOLocIvgTpnkXTaX5I7qhHP8rJiCQjWyq/gTrWKwQp7EFrskhEqdOR
         MB8l9+vlx11dwaLYIwW4uxWNoPsEPww/WN3WQ8P0UYa0nW4QTk3j2f9a1ZC18oLCqcBA
         467Czs4INLFpj29DkUuu2KERP1LMiau+3K4dvFwFGOK3hnHlcGeYRrXch2F9R2Gjyabl
         JA08wC0UNUeK/kI+mYbdkkW2L+86WZPalZIjNHy2o5GSbx9cOKBGs2ek3t/vZQWrJghr
         t+4F3HseqxstHwKux8AdfsCiC431BqsM7OrL1GVyantMDhnCNrSGBA6eg3SxXnwh1t2a
         6Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099200; x=1757704000;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etsxjyg4YfsF136YzaCNVjjN75F0ELAgmQtnre7usq8=;
        b=KstJjibbuihnubVjQVm3ypq06RwPbIdMoXlxto8EazdSsny05rKo4ZAhf0uDWERw33
         vpsLiDKarzLFVw1b3mMU0+PXRX7IYqxkp5q7qlikfJtHJXxwo52NhWJkOeszcbKKpJrk
         c53hFOZ3EPerxFBetLYBesTkwEdAAcnIG47+FsSyuEiW1O7sIliMS42dsB3BZO4Rq3OI
         wAtB+oUA72tH5x6lENU0PSt9Sh26gDOqMEJ/t9d02lRw/ijUkpksG77NjKfdc6RsWCqJ
         Gmao/jp0zrwhdZRgWzLqiubka0tJRxXdyCESVcnxlSimiEyQjxL8nkj6V2VApUzuU4Yd
         +sFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZJA8Gjqiei6zgxBrQ+n5It+m0fjuMg3Be98+25e3Szyed5GG90BQTB9CuubRfPH/e73WgO8gibkGnpBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF1tr/bIaoBUBhjQ5EN1KCvIZhgj9QCqoFJ5jpkGnI0W2Q23CR
	PTqrlxWE7JDWO7kUEe6/N++5XW4Wct6ju5ixx/7NH/8YkGXVttfEU4t/x0/ZMDVeBMY=
X-Gm-Gg: ASbGncup7YesCwzuBRrQ1TtK4NoUSb9vF52F2Z6I4cDir1HkeBBv8gd2cdjMLJ+lkad
	q8cRWI9eE96p0gOTkl02f78OdA+jf3GaC11tP/mgMxdgvz0v4ib9q64UhSiFxO+wARE9SegS2YX
	EHylps6bXH6Y/oZOaUqmsZdmQqu4/iq7emM/9In2YYcAR8VHxOpKH4TbA45T08qceGhkfyxlA7o
	6Ox1jv5/lj+0Zfg95rq53ZmUH8Fc6phWTp5JEqJtLuAefVDCYEOX7dK1HyYFFNhZHciaKkaRx89
	FwQ6wEFZEBmpketixqZIeGI0oNrcJ46Pw8+DpO1qmzGU0jrSg96ZV/lTUdziREh5O6U9E8ZPMsU
	M1Y6rqgH+fMt25kf4mdckGTUBdGBVxvN0j7jvxQ==
X-Google-Smtp-Source: AGHT+IGb2wPJ87GBn5tZFfPrsJ5SE9jzXrr8X2eXRsXMsEyQczk8Kq0+HLyMFMXmoPvldHEQl3ByVQ==
X-Received: by 2002:a05:6808:48d4:b0:437:e5d6:8c2d with SMTP id 5614622812f47-437f7d20d05mr11191216b6e.2.1757099200370;
        Fri, 05 Sep 2025 12:06:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743cdea4sm4474018a34.39.2025.09.05.12.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:06:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] media: pci: mfb4: iio trigger improvements
Date: Fri, 05 Sep 2025 14:06:18 -0500
Message-Id: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-0-55996f077a02@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKo0u2gC/x3NTQqDMBRF4a1Ixn0QU4XarZQO1FzTO8gPLyIFc
 e8NHX6Tc05ToUQ1z+40ioOVOTX0t86snzkFCH2zcdaNdrKjRHjOUlZK3JZByCy7MgSoMBbNByL
 SXmWCc3c8Btv7xbRaUWz8/k+v93X9AHU3OgB5AAAA
X-Change-ID: 20250905-media-pci-mfb4-iio-trigger-improvements-9e223e8401db
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=538; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Oz5yDzgQI8awDA1imkucYa+mL2QojOG0Fc1fuxu/aJ4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouzSsMhuA2T7Rd2KLgFjqVh8RHlIQ9HroD7RTo
 9zWX9M/26iJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLs0rAAKCRDCzCAB/wGP
 wN07B/9aoidv/luxO5+2nSwYfZqdQIx0hMvAPa8IY/Fq6zuk6JiRGh+/JYuiFmmC5OqEMXvZufB
 sKkLsSsBJlS5lGVBG5PImh1SIzTMgqMZ+kgFV8tR4PvJzZianRyLPz8IhBHoQbS8TBEJ++vALFQ
 jF3gkH0Ftq5hKvUmlp/XmyeJQ78UG59IouM3n3l+pcwkhz1GVm26Up1hkEUYSHhNM0ZSkFvsnI1
 5Kq7loObvRTDOASrz7pdYWBIPSelxq4MUf7ct+PW6cR7E/kCOAa19AX11PzI6NorowPCEDoLgLw
 6hGIvI811zFuQ36dDJj/kmBKEqiIimjK9cnSd0whdfa7oxDO
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This follows up on a couple of suggestions from Jonathan Cameron for
improving the IIO part of the MGB4 driver.

---
David Lechner (2):
      media: pci: mg4b: use aligned_s64
      media: pci: mg4b: use iio_push_to_buffers_with_ts()

 drivers/media/pci/mgb4/mgb4_trigger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250905-media-pci-mfb4-iio-trigger-improvements-9e223e8401db

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


