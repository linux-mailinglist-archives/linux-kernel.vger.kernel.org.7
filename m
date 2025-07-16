Return-Path: <linux-kernel+bounces-734363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490C8B080A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519EC16A309
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484962EE990;
	Wed, 16 Jul 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GT6jRbL4"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C9221FA4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705990; cv=none; b=r6L0tKjl00IrCPh2uVy9ZPnnKart9s8WUOWKNnnaql3dWvon6YovYS6R1Q61llpz7HUV3RcOMzydQJ4UdlpBoK0uu8QWaH5ZCDCkUp/sxwir692Hgl+BTkUWQG4XPvLZ4Z4MBLW7P3YSNtcaxV+Y0Zxu4KSG/J+WcbMNNQSUMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705990; c=relaxed/simple;
	bh=R+Lhq1vCYha2kVC/gKYBwgMh0PCi0r6MdFv+dfqI1y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYVGk+iu9QJ7E+U/xSLe3h5AijGmdz1iX3j9P9GBZpokI7Oa97EjjOF0KNl8+dbLt3aOMMCw++hd3nK4vZzbiMFCpzi9KKFozA1gMSnLczOrarqcLq3V7GqxpsaDBZdKF0ZBnuoYbDuQihrr9+k09cZIJa4mVVbP8KA2AClCsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GT6jRbL4; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ff8d43619cso307274fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752705988; x=1753310788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LiiyQhkDqEe/y4fMk89A/2LpiKkeCtnb83PrX3E9ODQ=;
        b=GT6jRbL4qOiV6P/ILHAW1NRvvZiBl9f87g9/hpGBhOPkOAN0ulLlSot1toIyw+j3x2
         sWDkcFjgvndDWTdBLSlWLHH5bQKNdvlbnRqagAd5o5PCR3Ay+wp3aItfPtLxQ+K5gj4G
         zlS3U9jv8fpFr1UqCGBw03Gnu8ZRGSZSYXBzCoUgF2PSTc/hd5hO6S5/z1Zh6HeVSIWl
         PtWPFfQ28bonR7oRDAu5jWaZXlOLPpQsV44EbNUKiBU66uWxxs8AQj4pq87X+DHqa16x
         Pqc0hR97vGRplkmbuChXpgYAE0DR36Dc0+sLijkfIrwGsa3SUd42/7Cil2lp7kljkP0A
         YFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752705988; x=1753310788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiiyQhkDqEe/y4fMk89A/2LpiKkeCtnb83PrX3E9ODQ=;
        b=IBmROdu81/RBDLMQHnbgazxwYo1nOMAR/2ddsYJj+cZ5lGJI/yB/mP3rQUzc+YDvYI
         vWer1Md8dDuMC6i6h9iS8ZrNY6q9KJV9fT3wytD5C8vjLq1qwkjT0IISsjNQBCsxJ0XM
         pekSBW1zzv6GvPk4WS1f7siZ39ONhIT7TIQFhJP6yfyxxmm87o1qZKYxSHByw54UHNP2
         G6ZR9wggJXucvP2xwcderXXDnXes/U+C4kxMsTXzg/k0zqu4biA7aekUiDjcld1g/ShR
         hi8NNQ4w97VQcKe3AuH3aHnlJ2wrFikjtczvBllPol+O09E8UCLxbvaK2BBPz3tl0fH7
         B94w==
X-Forwarded-Encrypted: i=1; AJvYcCWjk+fTXUUIsKZDc8XhIGcz3sNyrSz4L84V09+VPWYRgnwRFbhscL7Rw4CE+QuinjZZS17NQBscdfjEmBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvBZOR/GI2gQZG26jQxzunoSlqxO2z1uD2yh4j/eW437sv01I
	7w30j+b1PBxzsk2TagRXX4GiJlJtrDapcee9MpExKfU1nPuhFF6HFvv1y2qiro2JlVA=
X-Gm-Gg: ASbGncs81lvbZdZFWQqFhtbPhZCc4BH3VCE8Mzlnk/5Yp0QWMoCK8wrzjzstWTlnTrC
	yOxG3+3Xb+Fuxuw9mqk1hVvRNeDgypnv5yz+Oavr5HoxcTj6JXUwlRj2fT6HWbyAsvVPZzKyxGM
	3io42d+l5OWCHcr5QylqxzYwJdW71GBSaKoVvN3QGViVhuDDE6xVLER4tcAsP3zme94746wMZEj
	4Aaja7uPHG2DLfJrZkrKaHOZPNInX6mKT8o2Sa+5Vj41QpVP6ugWe8RPSifTG4fFqQ6N3ysFa4b
	/8OQ3n14RVVUCDjl6TPM9Gmok2x/eDKJan3cyyTd9TiCUy7vLNIQecdl6ByR6uYDcfqAK9K88uU
	ro2iRwQs2ZR/CfiBElToPYLNMaenQUg==
X-Google-Smtp-Source: AGHT+IFOGaMrw9AqIgbXe/jwkCHgKj22Wqht7XROv3FQmVROEgsFQIi2GM+MArU/0+grsGQkVTtJVQ==
X-Received: by 2002:a05:6870:e412:b0:2ff:a860:3402 with SMTP id 586e51a60fabf-2ffb229c2b2mr3886783fac.12.1752705988172;
        Wed, 16 Jul 2025 15:46:28 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff11681bcdsm3928163fac.32.2025.07.16.15.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 15:46:27 -0700 (PDT)
Date: Wed, 16 Jul 2025 17:46:26 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: chipidea: imx: Add a missing blank line
Message-ID: <36d1c961-319e-4457-bdc1-69f8b6bed33e@sabinyo.mountain>
References: <cover.1752703107.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752703107.git.dan.carpenter@linaro.org>

Fix a checkpatch warning:
CHECK: Please use a blank line after function/struct/union/enum declarations

Reported-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/usb/chipidea/usbmisc_imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 0b8b980409bc..3d20c5e76c6a 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -1118,6 +1118,7 @@ static int usbmisc_imx6sx_power_lost_check(struct imx_usbmisc_data *data)
 	else
 		return 0;
 }
+
 static int usbmisc_s32g_power_lost_check(struct imx_usbmisc_data *data)
 {
 	return 1;
-- 
2.47.2


