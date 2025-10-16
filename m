Return-Path: <linux-kernel+bounces-855783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E84BE24DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C795519C3726
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253D3164C0;
	Thu, 16 Oct 2025 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rWNm3s3t"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173293115A3
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605781; cv=none; b=CRqDSsrMlGC1hgsljEVf07Rl23ZhDHXyY0oJhwJc/4hbbLAyfg7MOVXVxeY3/amB8F+bsrNMn5W/Ux7QXCgtDGY9h4450Axpwb+9e0mCM8qq1EfmEkkJWLFlX3KJ2TbWaQ2YXHer5sxXyrb/Ytxy4y0WfUmh7lz7I9Ocf3H/djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605781; c=relaxed/simple;
	bh=+TqfTRpPRoq3AU8dHuMcrb7fqxyNtpoQv0+EpVlasEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cerrh0KreMFrGwn08I51+yZ9fhTg7ZhK7ALXK1veCJgtYzDH3Z+Gt/D8Q9zLQw1YRkaFHV0i645sDungTuqLQrm2Yexl8FNAeO7VvSbc6JdQqJUcTSyy8XMiLvZIZx0sVLAw1P58TsInKM/CF73V18l+iLJk69upLo5pxd4vOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rWNm3s3t; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-426edfffc66so286231f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760605778; x=1761210578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giyJvu+P/c/zBlzgMeJooxdfh7qZjl2zxl4gZFBxF6g=;
        b=rWNm3s3tKXxptLddSgePlIk+7tm9l3bLUYbeA9lNlPbHXWepAc5/6ANZgUfnoZVack
         TKGTddPCGYM747ujtArBDdvVhMxVes5eRmNgseX4+8055GSpJQpqu1PW/nVr9s/0z01f
         /CdEnwRQxT9+lL1ZLsMDw64SoPtpa/3ARpW92G7FdPpyVhy/Z1FDNbwnG9pALlhyX1uQ
         IGnrcP6nsQJ+xizRWUynnFFu3j/rwzIC+SclleqL/u+3QXJ114ygith1KKO0cv1oaIxa
         SMZwOv6k7Nz76DrOBGwIf/OKwLN6QbXZ1iKi3h8r91BVWLPqK62i64SyL/UUKajIHyzm
         X9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605778; x=1761210578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giyJvu+P/c/zBlzgMeJooxdfh7qZjl2zxl4gZFBxF6g=;
        b=I9RedbHTcwSkdXcYPKIANGntPde/e10a0CgeEmOLlwOOYJp40y6F4SiwG5CwhnlNLM
         beNvD6YVkIELQH/0AijS/ItQt3wpdcKEMlLxt0+rcnXgfbUB7MIGdkGUCNnipXAja7X3
         EMHD221rnXhyawPpxJT4a0ygEmW3xAYoKI4kiHQYcyUByxCKhOyWVJ1Cyf5Un660ig+S
         wpn9kCp553RVi10P7q90B8CGXCryjR7X0bPhCGpDnmDQdFrXzNAOtXCUdbCNhX/zcdKs
         dtF5eB2SJ14eBSQFG707CLoCzBZcKltv32Sp4EQTFy8uvYJdMznRpPm+bxhq6go/WdEM
         Ndmg==
X-Forwarded-Encrypted: i=1; AJvYcCUM2TsFTUUZllQopmYSh3WQUKp4QO7V0ALvipUIxh4Yo/82k5+hxX0UtaYzWBFXSFgwjtz0waNrz6jl/TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBXpoaEdfPyY7LAvNfiNMrpoH3BA8mhpehbcQ2yJmKPjZzAG/
	VTyoeQLILxQdDLVCa1+W6/h/YNAX0l/20PotNC0CFeJgykzmoArqErPyd1W2sS+mvBk=
X-Gm-Gg: ASbGncvxat7EZ+LhSxnii03FK32NdZ6RhOq4JDmpUHx80X4MKiHRHRiF3hY7pC4ThHF
	myInbYae9vadnV4aSAco2MC+aTVYwV/wgd1DNgFcRFXp26Pj7rnXri/KEMgW/yGbFcRNfvmwrT5
	u3Aj8if+nXC1+EXwYtdYPLLomWE7wqE872qxSmf6U5NdYz+NhTw1GS+G+Vb9Ujw8pmD2lcLn7VR
	vfk7d/yXPTvi9vWtVT9lqtcyhEF/CmDGlovC8Le3akZCE0wS6XWM7ClzOQzYs2eULS4a6oJbqsH
	UZ5oUNh3YUtAkAdldK3QAOVURUilGxGBEZmdDbomrIW1UThiXHv3AvsqD5iWHZKXQCdqw5HH926
	ASDRreEGqiZ4lE47galTyXgIKCIELQPEKSYxgRcjgPq1BUCbVTQOk17+hxAtSxSnm2Bt2GcY=
X-Google-Smtp-Source: AGHT+IFwQ1Vj0TPDw4e4cKls5YWKHTovuMxKu9ae74FALGIc/dMLGZ2EBvJ6JtiJA1WjhvYyV1IDeg==
X-Received: by 2002:a05:6000:41d1:b0:426:f9d3:2feb with SMTP id ffacd0b85a97d-426fb7ab9e7mr2401645f8f.23.1760605778274;
        Thu, 16 Oct 2025 02:09:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef97:57cb:86cb:f7c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm33191287f8f.45.2025.10.16.02.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:09:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 16 Oct 2025 11:09:27 +0200
Subject: [PATCH 3/3] gpio: aspeed: remove unneeded include
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-aspeed-gpiolib-include-v1-3-31201c06d124@linaro.org>
References: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
In-Reply-To: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=AnELVPWhjXwv4nNT8oy1ky6Ra8SlMALj94FDJwWeEnQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo8LZMRCng48xJlmYCAnXgnelIsEpfURlPAafHW
 lkDOwc8RISJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPC2TAAKCRARpy6gFHHX
 cjRHD/4gn97X2frtT0cloiZdcc6gGioOaf4UKJ2xeM/W83SKU24VRhJufxQDYnRAKZUHwS3vM0i
 5xRJI7ZSCBEnwcdXUYP//E4XMsNeG6l2QtsNGOVTiPZbHyJ3ABGl3gUHq0Yo+l8hgkzmtee8CBv
 izSfKQzKXubIdTaHH4hPG36fHFwPfHqYfWgy2SJhEsD2fqmKm/2bdpMKZFQ2b0rQaCjWjMGSCEE
 SnR3F25qf/1xIPbT41uHEwbR4AYuiNPe0jb1OiA9oZC/8zrXc2vuja1rUHsCdGJ4FJ/oZA2c1vw
 gh8Op0XLF4Z01G1BZNgc7VHxLvbokm0xXzhbogh1mi5KTEkK9F+Zt9N24rsbha3jTZkDkidO6zF
 jymTl5YWnc2pOmONTe8zmUEC4gwXBQWj04uOFs2iUw69r3/q02w6dtJkPdV02tyUVE6OFS9HA9i
 XysJDFCxs6ffsLaYUNaL0zsTTHARF7WVLqqp2wUNjix0lAB5NeoIdGq3cUo454LYGRt5Op56xs3
 MnmGoKC7rP88mtSv9/zVDuGuNW5gXczxzLEMiwfkRkEQlIjuSqHTuTPDT/RcD5cmX/4Zzclpi0k
 LBdw9fVriRvRaBoxsYsIScwPxGHPGgGrEpmwKx6qgVMDvzkur6TQ5U6cJXuDRKo2sOF6Xa0n8H6
 uysm6NlVANuLgOQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver no longer uses any symbols from the GPIOLIB internal header.
We can now drop the gpiolib.h include.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 3da37a0fda3fbdcb8077c07706aa41b233e9beeb..2e0ae953dd996ec1dbe7585c4a92f28622f8e39e 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -29,7 +29,6 @@
  * access to some GPIOs and to arbitrate between coprocessor and ARM.
  */
 #include <linux/gpio/consumer.h>
-#include "gpiolib.h"
 
 /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
 #define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))

-- 
2.48.1


