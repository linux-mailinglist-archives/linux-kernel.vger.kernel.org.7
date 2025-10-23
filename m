Return-Path: <linux-kernel+bounces-866397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BEBBFFA92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E6A74FBC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7527A465;
	Thu, 23 Oct 2025 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpQxEKn9"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329EDDC3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204960; cv=none; b=Lw6LEMujHXAo6FAqJv5tcc2dX3iqOheOdhiePv+lqCGW4Wx6U4e06ZKnx364WcWulPnf93O34Zt3oleXPBoB0FclOcSzT/WaOXZNfuOIguttfizdfKTlOtGtgqoXQYYZd6KbW4m7rbI0OR+hOFi7m76JDHQPW8BbqUjEkp2gxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204960; c=relaxed/simple;
	bh=nwJyJEU5maxkZelRR+G61NdovwyL4hcRCCkUlipo/Ak=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KHrPV3liOVWeF2y7VeDgPw7tJia2Fh0Pj+Iq5ZJV2AwfwZTm1+rsqUue4r19XCO6MOtLthqSKGBr/cZQ1u4vnw/YOSucB/+SI+i/vQBC3oyOKRkquQvXYuubhCG+dNDB0wLE4pWY9HcCHFMnMyPiEWj17mRWBHYTe9b/msWJNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EpQxEKn9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so3475355e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761204957; x=1761809757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nwJyJEU5maxkZelRR+G61NdovwyL4hcRCCkUlipo/Ak=;
        b=EpQxEKn9gRK1edoTN/jsZ8sTeh4A5timaj6T4SZfo6lB7cKPzwm2oEiWYOfdR1o9TO
         abMDSBpKk2yvoaQdUnTNThDBNO8DBGJPiOe9mnt8wVhsW2vqwOSli+ZjNxxVCoGwMkQk
         UNDnWYN2hTwQMPZgZ+LythekKSUKJV1lW4OSkJiPqycFfQ/FIQUxs5hBUtdfmnYl/1iB
         GfwvUv0eEBtrTarkshTrtbDDBxn47UA/JFzBh4iV1c5LL70S1GAYjwMe7CfcygcLBm3g
         8amRGCiXqyuDbh4P5cgJmk9Pc8mOnmqkIW1optlS8H9lM8A6I9H2cDu/R0EnfJS1mky+
         FhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761204957; x=1761809757;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwJyJEU5maxkZelRR+G61NdovwyL4hcRCCkUlipo/Ak=;
        b=MVnJWxtLqVfWuR0kBTp4WRiP5cVirEkQbViKzWwGJFoqvp1fj9g4pc56gRaGAkXfuO
         l2Fd4HK9/QNQwE1QDrApYFVkv7hAQvb5BoXlQaykUa6FHOgOUql0xY6YxSBWyMUaR1e9
         gmFGjuuYob+DgfRFOf005MLyiTS6dzE1nin4EjDxte2gaOOS1DzYrChHqjE+QMpJP3Q+
         IyppIv20hRXqSItjZPtabi15dMkKp4CgLfp2Hf6MkdX+zsjnIvbtHalfY309Q5EQ5ZHt
         8t7197OHt+pEHyiZv5teD/Vw2b/acHF/rjsAcdkb2YMV8CFRe09qWXhwlnKEE3AXMEsv
         v9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVO1brBrgNZHrbyxx4sSTO9OzkBJH4VZp9rlGmsiMm4UF9Mcj3N4LStUAkOz1AwUzo2ywbjRR01FoJN0eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWAq1cxrQj6I3Dav3v6PQ9f8lDfp/2wRQyLmH1st4zrtM3rdS
	whw68iq+GW7COsYxJBvJEDVd7NkidCF12lJqd1nxwXRJk7bPBURCL+SZvKD9zXDl+YA=
X-Gm-Gg: ASbGncuAH6v2pQoDqzMQtRbbjNxuxStftGr2YzL28MCKaceSoby5ZTWuh2hIpWewhFW
	wfW8svrnYeuuxfJqicdfEHe720nxb5XQ2bcZutCa5SekcpZC2NAnDtQexQopxIqHknPDV/zHsfH
	rpBl2/vvv9sCiaNu0PyEW1hNt99kQvo3dc6oX0f1bLiOYZzqEod3/FaQDbIi4vLJtJKr+DPugLO
	4qMdsPhLQBuqlUbcmxjTluCmjMERTpEhNtuKrcOfKQtVGYpAqPCRK5kJ1/HhL9QhBtLxAiJfgzX
	oAbZAGL5mSpEOMW8D+bOxMvDpLoAVa8Z3Tw3RnLQYGqqhTHY8NsuXtWK3yeELsUH7GFveBkqBqX
	3SB/jszSYyDNvBT1QHPh3IQhFOpPz0pwLei31DLdI0uZAXnt/Lv6r53GeCvn8ZL3PvKEBW84wFU
	oton/4jqCC
X-Google-Smtp-Source: AGHT+IFK/1BB2uEat5p1r8woPESD/DsfHS90lenaxSW5z/swFxmF+0BESbOT8FwArT5vdTSsYQ4A0w==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr177250155e9.33.1761204957225;
        Thu, 23 Oct 2025 00:35:57 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ae5510sm53341735e9.3.2025.10.23.00.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 00:35:56 -0700 (PDT)
Message-ID: <0972738d-0c64-4d9d-9867-895222a8f535@linaro.org>
Date: Thu, 23 Oct 2025 08:35:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup
 hook
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Takahiro Kuwano <tkuw584924@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20251022-s25fs-s-smpt-fixup-v1-0-ce26d4084b2d@infineon.com>
 <20251022-s25fs-s-smpt-fixup-v1-1-ce26d4084b2d@infineon.com>
 <59c3d45b-13ff-4393-a87c-f0504f224acb@linaro.org>
Content-Language: en-US
In-Reply-To: <59c3d45b-13ff-4393-a87c-f0504f224acb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/23/25 8:25 AM, Tudor Ambarus wrote:
> The patch looks okay to me.
with a bit of more context into the commit message, you can also add:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

