Return-Path: <linux-kernel+bounces-887677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C4C38DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933A53B9811
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1D3253B58;
	Thu,  6 Nov 2025 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4DmK8zL"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F192405E3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395869; cv=none; b=Q7gazaoi/ZMw1+vwnzAD/Tz/4iE9APqhBjyopNR1Yr/osHSaQOhYFq24hq8YQdyhr+it+fx7XhZTwqrMfj4DKLQ/QP4vYCeRbDmOxLQ6pwW7R3A/Anc3PZ3r7kYoDwtwVlMpP0CTd+x8jsAASvavjCWbeciQYngrRpdPQThDlfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395869; c=relaxed/simple;
	bh=7Q4xu4827zczeLEnSnPu22t5cmWiRzgvOmRy7BlrbzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDG506rtHamyC/UHt613Za1xmeHK3VzqwKuC1FhDpayXMMrfhlL5+zUwi2ueeFOxVwkRRWBhIaZrrFPA0cLPnj+i2gBwdz/aDjm9QH0UVHhO/DI5c2eQuXQImv6a9HBKQZLhSdSI5ztbTo++KYIQrYOCOsTynEsgddM15NahHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4DmK8zL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29555415c5fso6398595ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395866; x=1763000666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RgHKuGRcojJQByTkzvT+fYL9rE8yH/+/URCufT9VuM=;
        b=T4DmK8zLLmGvSUAKOd/8op+0tgVbqgswcCeDgJmHidAy1aiJ7smp0yDcZFUbcH8x0S
         3yxOkEDAv/0w+nENKGq8jQDzErzBOlEIoqXwY+zMUiDrAeJ+xFuErVJXPB0S2FNdKsFu
         jWRVFb61Oc0PWb2uSvj6PJ8JuJhO3AJHxp0K7iXahimN2MgfFP4XQRKH9M2Ndm1XOMSz
         WEOdfoQ3iq0tdW6D5C3n5w4U/B8DUM2aSN/+C+TftZnEMaB7RRva753KvdNXf87iG3T/
         fIWuoSqxBMiC5qjcdodCUPqkP8ENUrtsfQ5xZpOQ4FTK+4tfSzGymygHt7ZVvpNTZDwY
         GZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395866; x=1763000666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RgHKuGRcojJQByTkzvT+fYL9rE8yH/+/URCufT9VuM=;
        b=HGjGIiJ/TWQdAwSh1PN/a/dUwzia+2goPZkK7mMLPRBPRUBmbGXT3f/iyDTeLgjps4
         Nj18pfPnP5npuxuBARPT8r/M4HxVVKvaIGO3SWS2mhrRKOThN2QDwUoYcZJSVBnysLYL
         TjQn5kqUZk9AzLvab40mI2IEZ8KadEN/cZfcYmU11fv2tNgmWSeAq/z7rlK4cYw3eHdk
         X0WZRJaROuMuNoA6KHw0d7b4xGCxdcIcWYuoZYsy1DgGZa4PDOMuQxvWrTUgFJHMbnll
         K2pcXKFQZrWw/BKpiEShpJayFXoaQjN7CeZMc+JT9DTsjc6ubzV8qW2HVlkLotNuArsw
         Z48Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9Z46+MOtXmsHq6Llo8vI8y9SOS1Oios6KKs3/aAPBY8o356bWQA6rhZ4ERYF8TgoNhUykI4qwNMeA1rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LoglmIfArh4mQkGwlT3RpIAmaPjx36O8Q4dgdrCFxHG3tKZo
	RgF2kA+bo0u4CK4DdO/rjIBvVRhTj/mBVPbt5fPrWJtbvqXCu6kyyU67
X-Gm-Gg: ASbGnctsGJL8L+uTKel/ke3gvnjDc2TeWx9sFzN1LppB7U29oa6/o55EWgnJz47COjB
	1IefrjITIF+nzbyzQGFs59aBj7FyOWKoOXYikka6oxpZ2xT8FO2dV99FXSEhrM4tf8jcpSnkIOk
	qj3Z2CWPdUVFpNp0Jvljail9NnuZ0XrpizhM8e8VwtLR1gbN7Wzcr+6FzzxpaDepWCo1pmhaxJP
	iE7JGe48JbBiNyVmjFydX2cTMEjwKqp5ospVJRxRjCTUIMQ00lPRT7K690xYgv+JJFWSaZU9qVw
	rajPHC+YJBHECn5I5wd0stSzW6Cuc4R8v4tP7YMjRYHboUmRZZxEQvir5KxJxQ1nopZrNTAkFTV
	uSwMjepeF1T0FCzZkPUpoZMRN0T66LFF6APGQoesrT8oLS4M=
X-Google-Smtp-Source: AGHT+IFlTglLO6YbNUiSxiWM9LuEL1TE1korjNRnwjDSZonG3AWINPzmqjPU+srD6U6HHADF+p+Fdg==
X-Received: by 2002:a17:902:ce90:b0:296:4e0c:8031 with SMTP id d9443c01a7336-2964e0c8139mr28182925ad.17.1762395865886;
        Wed, 05 Nov 2025 18:24:25 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm9399935ad.44.2025.11.05.18.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:24:25 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP AT91 DMA DRIVERS)
Subject: [PATCH dmaengine 2/2] dmaengine: at_hdmac: add COMPILE_TEST support
Date: Wed,  5 Nov 2025 18:24:05 -0800
Message-ID: <20251106022405.85604-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106022405.85604-1-rosenp@gmail.com>
References: <20251106022405.85604-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows the buildbot to detect potential issues with the code on various
platforms.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8cb36305be6d..243d3959ba79 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -102,7 +102,7 @@ config ARM_DMA350
 
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.51.2


