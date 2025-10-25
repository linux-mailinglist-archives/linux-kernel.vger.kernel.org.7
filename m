Return-Path: <linux-kernel+bounces-869652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA2AC086B9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 659424FCD3D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAAA1B3925;
	Sat, 25 Oct 2025 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLlZF60Y"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0953D1465B4
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351934; cv=none; b=RPx9XKXTIoUztzU1Xls+WHdCRaCZhrQ+82YkMcApWbCvC9ol8c6qZ/6wdurm1fXiNmthcRlBQk1PG3N4vngpWM+JyCqZt7kq4d0bK/aqBx36sGy7gkRjXsvYMnOBgxSi+K7nN3HrZ1QcHqeTi5J5IStiCE4kXb5Gf40OW9wTEyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351934; c=relaxed/simple;
	bh=DV+93RqA20zYsiZVil2ilvoMWgypauFCp2tp4wJbtLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PO9HB8TzxoKQSqYL4sgMPsI7yOMlZi76HX5+a6P7DBRC3Gs9++HHiggxQpdrTVpnSnuF0pSUoEHa2E5jgJ9Ish3URRyj9ynYAI78pwASAj9sIspPDwWGg4Ys7fpdHzlKyYfeGv5MMpY4dh2qd4dJxBOhTtAvs8YB4damfs0hMmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLlZF60Y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so38851305ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761351932; x=1761956732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yg5EzbqpAhrvR1YouHoLR93Qim7L8FFl5LtkM7LFT7g=;
        b=HLlZF60YKSxUJ+x1g16WArTv8b4FzBd5ac0WL7yqUU3mktlj8KqvC1RncFfe0Q/yAp
         mlvuKsN40DfbXfC8KRbbjMyxrEqOfiAakxSQiQ84bIW96HszAKfQwHbHi+Bjia1nNRwX
         VNcyOZcJjK+X60Ipefu9bU4qmhT315nFlwjcXrVj15o4u78CyTfqCy9Nc/GTi9QscNpJ
         OcMSgbKHSB75iPDP3F7HCJhSFXqzuf7/dzmXymK0icrFwLCKtV8Z4DKEYDjP0vLpHiMJ
         HJfIx2wtKdMmTVCOGdCRzRF/uTrEWyAHFIdwDlpu69Q03BAdKvMP7mY6Z8PcUFrxiscE
         498A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761351932; x=1761956732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yg5EzbqpAhrvR1YouHoLR93Qim7L8FFl5LtkM7LFT7g=;
        b=cEB9W74AVXiYw6RqcyMiBFm8nauYrJFNfbUxjJbVoO64+oyj3ckmuMsZAaYBsIFH/o
         xkfeOdD/NoxUum/jtJi/1zqxQqeqT6pt2oqMWLEpOmKSaeqwUbBT0/UfJ5kOr+p2TZH5
         QjAO94Sjuew3o/3f8l/7gbVJbgBgaKUb+PQSdykh8vtflWjvZeM8RXV785vu1ybqc8UZ
         mCjvE114pL9z/2rmJljQXR2Jq+TePf/nmD8jcYhH20ipy/xDe/SBjCF7jgz/JhcdwrBy
         8ewG2SQpTYX+9dNgFVVBG9MHn1VdkeNSceDDYveddbDES5lddnGvV+GEXc60S00q1idN
         0bcA==
X-Forwarded-Encrypted: i=1; AJvYcCXqc9Bdbns6OwdjILwOYBfombeogw/TEH9YwBUhnK9+UyWrFEZOdbfvqLR0LZ7FB7rmORs8VcKM0rOjmb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyki2BsoE6iVgfLNuVNscRc3OgoM08IF1PI+Uq+AUK85m0lguGt
	dG8QsTN9m6nFs9iX+wCd6jL7OP08e1aACRHRP9R1993lQ/EAn9tYM5Ni
X-Gm-Gg: ASbGnctie9vs7fRgXoELZGRLk/W1J9Rf0wA0QLjtU1OTC22L0RfcJRhmUCxBXZazXsS
	6YEis/35v0nCX9aCIcFl+uNSYbuRTIk+N6FrTgYSXaTD9oSqw3IUFIKUgANlK1XvjwXjoVCD4cC
	V49EJTKW7rQZqDXe+Nbx2MndwkwlEgcNd+qWMhhcCduEC9tGM7U+/N23PhsRfVmFIDwPdTlso5E
	vdnxhzQra51kuTsxPZSxGYrMjwmTQp20HGuR56K7/hnI1SrhexVjww1P0HBb6HzaMev2P6PwlPX
	UDAPgd8dU5LjHS7GkiRXpCuYO0J0RY74XybyMgCoxtEmao+XOXGLsRF+sH6bOJuNvLvx4PWzAW1
	H0WkT2JZNPFeN0V6LE39S5Zpl5Nnnrz1V0cavF0vrqkwjqiBHe5OMrzgKqA4ylfnbTq3WtghGfP
	AYvUUn+oQ3rJsE092qOzh5hOUBDHLe3Vh7ERw3vIBTwlmTuboqqoea8TeLfCSpIYc4S+DF7qb+s
	AlRktS01K5Zsf68XI8h0m13HbOp6BGR2rsIh9+tq+jlN5c4QS1nww==
X-Google-Smtp-Source: AGHT+IEmYwFaqV8z42kKVpm+csA5lgwwLVTZWeE7isuCiwv14jZl51eAVuMpwZ1A5qrZNvfHQofXdg==
X-Received: by 2002:a17:902:ce81:b0:294:918e:d230 with SMTP id d9443c01a7336-294918ed5edmr33375155ad.56.1761351932492;
        Fri, 24 Oct 2025 17:25:32 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3f4asm4728885ad.11.2025.10.24.17.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:25:31 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 25 Oct 2025 10:24:36 +1000
Subject: [PATCH v4 05/11] mfd: macsmc: Add new __SMC_KEY macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251025-macsmc-subdevs-v4-5-374d5c9eba0e@gmail.com>
References: <20251025-macsmc-subdevs-v4-0-374d5c9eba0e@gmail.com>
In-Reply-To: <20251025-macsmc-subdevs-v4-0-374d5c9eba0e@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 James Calligeros <jcalligeros99@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=876;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=DV+93RqA20zYsiZVil2ilvoMWgypauFCp2tp4wJbtLo=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDBl/JM7uT5j/5uLhmIJrXj0R4mce1dxacTk7SWbXtmDFt
 k1TQ7V0OyayMIhxMViKKbJsaBLymG3EdrNfpHIvzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKhjrGPEwMUpAFNddpvhf8lXBsaJthzWLl7P+442dhqmB2rFujvXrvAzjZq0s8yAn5FhY5v2Wqd
 9hjPq9/XOutZTeMc+OfwDH1vU9kDLgg1Mbzh4AA==
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

When using the _SMC_KEY macro in switch/case statements, GCC 15.2.1 errors
out with 'case label does not reduce to an integer constant'. Introduce
a new __SMC_KEY macro that can be used instead.

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 include/linux/mfd/macsmc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/macsmc.h b/include/linux/mfd/macsmc.h
index 6b13f01a8592..f6f80c33b5cf 100644
--- a/include/linux/mfd/macsmc.h
+++ b/include/linux/mfd/macsmc.h
@@ -41,6 +41,7 @@ typedef u32 smc_key;
  */
 #define SMC_KEY(s) (smc_key)(_SMC_KEY(#s))
 #define _SMC_KEY(s) (((s)[0] << 24) | ((s)[1] << 16) | ((s)[2] << 8) | (s)[3])
+#define __SMC_KEY(a, b, c, d) (((u32)(a) << 24) | ((u32)(b) << 16) | ((u32)(c) << 8) | ((u32)(d)))
 
 #define APPLE_SMC_READABLE BIT(7)
 #define APPLE_SMC_WRITABLE BIT(6)

-- 
2.51.0


