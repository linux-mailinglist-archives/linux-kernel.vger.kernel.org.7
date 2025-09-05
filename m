Return-Path: <linux-kernel+bounces-803529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A21B461F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7361CC495F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEEF37C0F7;
	Fri,  5 Sep 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EjGAfyVm"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0823302163
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095972; cv=none; b=SsdHG5HPTDrrriNQOkt6bE3oc95AKCAFkdyE3CsBoHt1mPV3VkiTHS/NgEdFhmSOot+dC8fy4UYg5OwRsU7MdPMmrrKW8pc51fgxXxlco64jFjZJXP07M92e443fRem41Y7mFhNnQJmHpVhrkBRhejiFLI1c2DlNJnQLFB+cdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095972; c=relaxed/simple;
	bh=BMUZul4w2Wdqu3+6ZxGgii/wI/FeYD/KgRdlY83CvQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nu4pMXR27fiNcH/wNRxfFfAmyUwfk8pxl0FsHyhp6VTVnzYbXUdxBvr7QYusOnxGyV7ETYbWTAGYybgMI0Z0bNdDCdW8gRcM9uINHdo5AS1i9s62jzQMPM7UJcCmA9cKnBrYROxbP72pe9UA+eVo94nr6cIBC6L2yDsiebzb94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EjGAfyVm; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-315bb486e6dso2007077fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757095970; x=1757700770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcSrjebCEmD8D7u4qyd0fiTNVHOhu3JhXWISUNqvRUw=;
        b=EjGAfyVmOMKjrq2wnLZOyojnpGN21OEfkG93lBlpyrCIAFmtNRAXBoAApgsPnNadw+
         i4XuIN6tR35S8djBK3KB9pVUNdX+Vk+a7tZ3DDMtXYR6X8M+IgxRXT8DUxsJinPwuqP4
         Bh0ZEOOT9zTsM+LndMFSJLVi8Hl7PkHvXEX5GZ05S2TbC9K4wDkpMuiae7QKeNaRcTyC
         EzfT7beGbq0nJwV0A9VK6v9OPJncIaFGbcUrTRNUFdmimmY8GphMpnQ1qYjiOLEGiMsj
         JuAl+ZI8S8nV5QuH1fAb694OFiVvtRVLRx7DgJqdb9yLhFJUWjQEUL7EV2ZdxLHBKrNa
         qY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095970; x=1757700770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcSrjebCEmD8D7u4qyd0fiTNVHOhu3JhXWISUNqvRUw=;
        b=F6xoTwrIgHv2gCXMmwR1o1hGmfbT8XIElbPI47Pb1qCwglUFpgM/R+OILjMdtnKzk2
         vc6zlxTYnZjQWhfFC0Jt2hLSxXrwPfG5g8QV29FpJ+oB18UHjhktn9Vmkqz/8oVZvhIE
         TU9fe++u0e6h3Rg7GfjWA9eV7PUBhBqMQki4TbhIu4cyBWLpUs9oIONdxVStI3r4LV7y
         +lm1A38zSm7Pvm8aE1W6ixf+wLUZlDn8NzXXeh2AmWlwkJ2XmJ4JXtgpX5ZJBZ689QTy
         eQjrn7AodhNRrRtVWwwHoELJi5HejjpDWCqLbcBDnfvaPxTfR99Y8h6DVaTJGChSvB82
         aVRg==
X-Forwarded-Encrypted: i=1; AJvYcCUYKqqNL2xG9vnf0vadJV3mrdD0iZOK47aqtlyh47KcktjYHjl96+omCSmkDJsButU0unhOO8XmB2PKAuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdZglyswhWOd1p8WHeOMOlh8BYtJ9retq27lDeWeQz+Afk8fD
	nP+FnsA2TcS4e+BPFlLPCj0UpWC5VnQR6esWEh0P1r30vdsa00pMmwnUY+Xg2ZFGPVQ=
X-Gm-Gg: ASbGncsziWMLXcsE4cjgYWlNnUA/SL+wE//EPX/aUqEXe+xZ4xAFyr0NNSMqJg0HtgQ
	O12pAXfyMMzrY9zTAt4eiKraGXqIKCVHW2LRfPvxaO+jnaFukDPzLJEnkKswnCH031cv3cHWBl+
	fnOqymdcfSUH/JxhE5/RWEa21KCUvnlj2zGFMUldxn14U2rqeEaCGUYangVAfsRAZws+Ndm3VVc
	Z6yzxg0a8JBpN4LaqWI1QsvwNqFAxdQKHTuOdRMADc2EH8qR2/Am0p8TeY/7rcx+4PVUbd2Mp5P
	s3tGoSTSQWOhIdLDR/NMSwdY6VwOTaAdd+Sq0REYbGvRW6qFdhhGDhuFmvQlUdOvPobKBd5plSq
	sLbSQmCnh9Ibe8zfopsMxI51nUYOPunmdX36sQg==
X-Google-Smtp-Source: AGHT+IHjqh2TAkyXxBVFC12hRuJSEXtSHxoq52W9gS8+bIr5XA7E5vsCCX93r7ssCowzDZ/WUbTcig==
X-Received: by 2002:a05:6870:a68a:b0:2e4:68ee:4f21 with SMTP id 586e51a60fabf-31963113151mr11465607fac.20.1757095969965;
        Fri, 05 Sep 2025 11:12:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d686398e1sm3052292fac.13.2025.09.05.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:12:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 13:12:01 -0500
Subject: [PATCH 6/6] iio: ABI: document "sinc4+rej60" filter_type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-iio-adc-ad7124-add-filter-support-v1-6-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=838; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=BMUZul4w2Wdqu3+6ZxGgii/wI/FeYD/KgRdlY83CvQU=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDJ2a4jWuwq1lifObHk4J6ar777kyzLVPSfWlpjWitRli
 5q9F1bsZDRmYWDkYpAVU2R5I3FzXhJf87U5NzJmwAxiZQKZwsDFKQATqZ/G/j+xhtfc5YEFZ1dd
 3dfrEnp3v7FeXKZ15SdjVVw856reFoXa9tip2tYx2T9DXt5QXxnvlSkpYpU6ty5kqm2Y+OVPx9k
 Evn/tjrqZwfJpjzbndutVHO+3ainEssmteHi58oTB6/aituXqazm3nzl58Hg5g3B64v89iqf8LM
 pPv9KV/rIymsPQ6xyD1wuW735HJcxT2qY8XF6dnp90y+rsLif7ow/Pnuzw/iCQph19xn66S/20h
 Z5Lm4Ju6jve27J59wfRmidBh1OcZvWu61XIqj612li7PE6wS24H17I6PlXH1ivaCgctVCXVWC6u
 WDxha2PIuZq7cRJcGzbbzlEwDODwkP/1pXNaNpdD3do0AA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a bullet point for "sinc4+rej60" filter_type that is used in the
ad7124 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b19249743398b1ff0b538b03ced0340b..829ccfd902f2ca4e5ae38ca025eb3c4a9fe1389d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2292,6 +2292,7 @@ Description:
 		  1st conversion time.
 		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
 		  time.
+		* "sinc4+rej60" - Sinc4 + 60Hz rejection.
 		* "sinc5" - The digital sinc5 filter. Excellent noise
 		  performance
 		* "sinc5+avg" - Sinc5 + averaging by 4.

-- 
2.43.0


