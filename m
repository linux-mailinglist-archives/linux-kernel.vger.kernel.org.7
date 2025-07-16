Return-Path: <linux-kernel+bounces-733768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5C1B078B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90EA3BD3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F052F4A09;
	Wed, 16 Jul 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz5VRpAN"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079DC2D9EC9;
	Wed, 16 Jul 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677699; cv=none; b=thumCxe9108MAzU8KxfCceCCa0IqiXqlndpaVL1RhK9UoN2OrTYmZrSamVqrlqLv7DLN3Y2j3WTNq0CuunH3dgY1DDYjiHD86vtW5CnrO7/zQlXcP/kiSEz9+wbNQl6k7yBGEln8VtJGBLpWNYN6rTEf5KDXQjAzESQrHr/D1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677699; c=relaxed/simple;
	bh=U1ye5zeGjQA3o/GBi32Tjzdw9zujFdi18wQ8p2INZ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0G6K/mcbE6/T2knaVf5RsE9KiLTH53Gs8rDDlkArJfxpnicAqe04ZiizaHN88Wl9KKXbSDdK+bRCbRGnaEZTs8fQaLsUj9DCFi8rNzteS3L93IYCy2zp1KDslxDBK226HfdMqMirE2jb5vhJubdzSPCVmukrjzBgsCFCJrwiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz5VRpAN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748d982e92cso13411b3a.1;
        Wed, 16 Jul 2025 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677697; x=1753282497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mcqy95sD7qVdpf9tbc3dNKLz4mSDqVWr61ddzOReggc=;
        b=Rz5VRpAN1BEUZcbQS4OnnCe94isTrT4yu7iOF/BEP52Nc5fYYblVtg5YGw2S4srD37
         /zyOlOJEwvSyFtD8pAKt51g4jeYw6Z2NcKTv1s4xVzFlmPUdSiRyrkIz6B7NF7ukgByK
         D6ixiTos1uUxJpDSmZCAquOnWxDjY33/fMwFBJvMpAFHmHbFti15x62Iwqbm23UyAhfP
         j1dCAyP+HGa8tx2Q7vl7KkWbgpldJ/t0Q912qFqF1dAPtA+nbEYhByoVlaptIVIFWXrx
         a0dGrSaK4oVPprFEU8x9th4grvRLOdpbFgMeXjvEussH47gt4bRx/aWgQtcl1VQthWF8
         0iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677697; x=1753282497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mcqy95sD7qVdpf9tbc3dNKLz4mSDqVWr61ddzOReggc=;
        b=eSZM9C2qFLF1mn7hufAkJEv5rw6WOfWkN2VYEZIOgoC2ALd/c3EApXfASO1Q0HqJsp
         3cHBfZD2PQ0ApIVsNLj/+qeLIjahoVUy2WrH8dfEx+x2pYDLlksrGaLtJhYAt1JRkHQy
         AFK8ISgLMTfpRikAdRVg3Ixq5brN/62ltpz0EuBvIn2vbXFWsNZ65860whofBxFovK/3
         z6c9Gu5SGj4MyhmAZbrb4RL7tSbylVSZFdMhdN26s8qOVoF/PKdCleMMXjQM1ueraJNo
         4QWr571i8vJfiKKG0C5Fjqj3mQJAHBL6N0ZM4ZSM6/cREDeJAd4UDjdnsvFHf8X32Uwt
         5ADQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoeQxOoAqn/Vn5o5ulXwhqGMGF1w8gn2818+VZ1H8+beY4M1o0ZbYBEVYo2Lfi3vc/j16z4yWNstXf@vger.kernel.org, AJvYcCWEJOO6C9TF9NPvnFYCjuaLzyRFU3E2C0gN8F0omX/SJIamcVAwbsxQl4aP2OxksoaOLbcgwmbDOKYvVVg=@vger.kernel.org, AJvYcCWbeuw0QnBMBqGUWrJn6X1SLIWTpode0UbRj0Nyc/W/GR8J8F+vNVrox6XYqmq9nVtVetMX/rMwgNoihAff@vger.kernel.org, AJvYcCXku48suPvUq1uWggXkveaFm0/gsxPsBVu5YsjMcDBp0x9hQUe9Udr4C1PH6BZ20SJhpnbBkKFCyXmg@vger.kernel.org
X-Gm-Message-State: AOJu0YySJUZdYOXUho+/9r4QGCoSDYekC8HHcKOux1ILjOQZ6t75K6CZ
	G7fmuYYffSZtsefOGD2VO59arfc6ACT0tOt4rNqAMOgQka7HYHYBtRvf
X-Gm-Gg: ASbGncvfEVhVGxxt4Sxp+vd/wWrl7M3GmzPHK/EgVcDBkRt/KhIKZaaPmmjfAbthaYE
	QDfTDjHrikzxAV8uz2b0N1HCFg4C8Y1m46eqCEYY3SxvKSQnSPrY0etU8V1324imp8WP+F2UY9/
	uCu3C1uHXK47f1xd1aqgD54g3IRDKSzMWtCWr+2ZzE1Z5t6Gf5Vsw2JIWp7Oo90PZYZVXFn7GuU
	Qq2zKmv3wfi42wFkOdAS3plVzgtQr8UGyIvTnLY71r6vALclwz92qXrie8x1JrmQ6Wv6Uiyxenf
	0FYIQf0UCFjtEaov6DOwy57ZpIRx8NmWoIs/xkFJfed73vTWZf8eVjPEB9zIyJnlnDJnEBWSL9i
	lEXe0+l7SpZARJ4xVW6L+06I01vGyo1YGtf4=
X-Google-Smtp-Source: AGHT+IGnCbO6LNMPGJhCsUPnIx6V+qt4UYp7p1ebonKVVeiRo1ZGeX6yTN7zXwNrpc+3syhHDIn3Fg==
X-Received: by 2002:a05:6a20:a103:b0:22d:fd6:95e0 with SMTP id adf61e73a8af0-237d66186dcmr6214394637.11.1752677697119;
        Wed, 16 Jul 2025 07:54:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe579b0esm13908927a12.22.2025.07.16.07.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:54:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:54:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Radu Sabau <radu.sabau@analog.com>,
	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] hwmon: (pmbus/adp1050): Add regulator support for
 ltp8800
Message-ID: <988fecbf-776d-4ae6-b658-97fc2ecb6822@roeck-us.net>
References: <20250709-adp1051-v5-0-539254692252@analog.com>
 <20250709-adp1051-v5-3-539254692252@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709-adp1051-v5-3-539254692252@analog.com>

On Wed, Jul 09, 2025 at 01:43:27PM +0800, Cedric Encarnacion wrote:
> Add regulator support for the single-channel LTP8800-1A/-2/-4A
> 150A/135A/200A DC/DC µModule Regulator.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>

Applied.

Thanks,
Guenter

