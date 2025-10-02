Return-Path: <linux-kernel+bounces-840817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9CBB57C9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C446219E2BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0E027EC99;
	Thu,  2 Oct 2025 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDLh9pE5"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E983BB44
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440971; cv=none; b=kojufq+MCQluqcPf6a76ou5xLqOs9rJwCKCqkku91EyWKDNafObL2b63P4ihYhXt8fnj5uiGJ24KWW9U9I8FbxyeHdxo3JMFIQj89ogt+5R9mZMKn1hhmR4FspqR8kjWnRKyTsomN6KF0Jzn1ZyNrDgSi8TjajFTbOAm77wp0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440971; c=relaxed/simple;
	bh=sp7MqWAOc+vFOYpjOgl75lySjdmojqGQ8r2e4EDXL9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E82KcU9xkhzrPsqQtBaz6PV59x/r63NjMltCoMamzSlF7aYpN0Blaj7h3IPPYa+iNj4I2czJgOY7jCniskAM2poyBhfr+4xDZb1rnMCb+WXVDiclg8ArihOcOTNHDUedvGLB3e/uNe1bzFdCYuj/MI6tly6f+RsT1KeFry0Auaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDLh9pE5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f1f29a551so2105923b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759440969; x=1760045769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVcmxEQDygf7dbtJ7z7prj2fqI+0iw8tFUmQnUGZQm8=;
        b=LDLh9pE5L1v7i8Qe63FbqO925JUuryIDlUKRerLfEfRkPDH3e7lrZbhnF9f5/x9jIO
         CWdoXdKTxZ8RuBt8JctqnWp0ZlDkRUg/qyiu4/lYWHBhkWfLVtEkFTe+65QjEE4tc6mM
         6kNdiTgY7Z6jZ0+i6GODfEyffXYFfvdh/r+PstPF917eeLLjR0slDIbZmNw/Y0mijCru
         JA0vPgZQxqFkXs5j+mwvTZzrD53kFysM2VbCeZGhqP0OLGAlXJ/4do09O0oo8nHzQ+E5
         l1Vr8OXlbchFWuHuYyWg2tPsIDtwt8LYAdU4D2FH5yoyIFbBMzud88OlvTant5SCiOj6
         grRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440969; x=1760045769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVcmxEQDygf7dbtJ7z7prj2fqI+0iw8tFUmQnUGZQm8=;
        b=Vl1uUYGROS8opeGxiywF0su4DEJqOKuO93TYop784IEhbdKkS9/V100sgI48GX+7pu
         HdFhv+VDkf+mcgQ74VfwyUNgGLtI+RKP7Yku11/N91FwiezH7H/XQFuR88oiNUzL5m5x
         5eNOJDsWbxxl9b3a/OY0Udh13L8XrZPoDGL5UZkF0E2Uwa9QkYESkUtC8DDeaJR4sjp9
         xOTvuu9HZcTNEyUjeJxdBH8nrkXUnUIrY1uQusQOjdIR9FJpT7dcyk2HgSpm1Bhq+Isv
         NkFMyzUq0zzkeRQE6W9mmDm5535fyBkEdT/Oi6u5ql/kITMAwscdeGjvwyKpRFJy1N27
         BHCw==
X-Forwarded-Encrypted: i=1; AJvYcCUepAQjQKcooRm1uyDsvx+Sngc8DYUh7d832/vgiRd2R59uRye1bPnbAyVfWt/Pzo8bTLEIH9ROWvAQ668=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2c/+imb9B3J3HbELCnF7Krh7YqHtPLD44xHHZ/kjBLCkMwAK
	1fxGUP0V58YdTFJ/xOSuobZydtN3oqxLD0AwnCxTc6mJYnPSzv6kj8htqcXuPeyj
X-Gm-Gg: ASbGncvdLnhw8VJ5uq8gcXmCuImyEfgRPNjMo/94WcM0jfQ4QCNgzkhUF3IZ9WTgxdE
	kZay7CTVVsluSis8Ot9weYXII0NY9yGPieCIyFalM1KPnj4EO52CF6xOUzECfadbPO8+uRKpgtk
	BvtWjqjzloUdTeC4c2OKR/I02eWlL57PDh9blPm+DSTlU20X6yjc1x4IZbsxk24l3ueKKme87qj
	lNpjQwjh77be3GWu6miFB0c7Dl5o4HptLN1yF4wdnyip65H8K2lb3+vmC7H5dAmEV40QqbpL066
	9FakvFc9aVIJQzjBrIZiQb+ICK7QI5eMkYUGC3JA3yMbx1NQXCgoUNW2VoOi2KdRC9PFyj8+JBq
	IIsqyHPF24VPp3Lf4onTgzGwhhCsrUq88wX/69/ZHScCOefEcDeMY1ZlklWg=
X-Google-Smtp-Source: AGHT+IHue+jlDN4n9W+cwiftgnT/dK0SHQVUWlYe3W8oi5uNcGPOdbvkqxSuoPni8hyXXe4UdBJf7A==
X-Received: by 2002:a05:6a00:3991:b0:77d:51e5:e5d1 with SMTP id d2e1a72fcca58-78c98cb783fmr1124337b3a.19.1759440969414;
        Thu, 02 Oct 2025 14:36:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb16d9sm2989597b3a.22.2025.10.02.14.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:36:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:36:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Emil Dahl Juhl <juhl.emildahl@gmail.com>
Subject: Re: [PATCH 1/2] drivers: hwmon: ntc-thermistor: add Murata ncp18wm474
Message-ID: <a14a92fc-a21d-44b4-a613-e68747edf521@roeck-us.net>
References: <20251001-ntc-thermistor-ncp18wm474-v1-0-2c64b9b509ff@pengutronix.de>
 <20251001-ntc-thermistor-ncp18wm474-v1-1-2c64b9b509ff@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ntc-thermistor-ncp18wm474-v1-1-2c64b9b509ff@pengutronix.de>

On Wed, Oct 01, 2025 at 01:45:27PM +0200, Sascha Hauer wrote:
> From: Emil Dahl Juhl <juhl.emildahl@gmail.com>
> 
> Add support for the Murata NCP18WM474 NTC.
> Compensation table has been constructed by linear interpolation between
> well defined points[1] on the resistance vs. temperature graph in the
> datasheet[2]. The readouts of the graph has been done to the best of my
> abilities, but the compensation table will be subject to inaccuracies
> nonetheless.
> 
> [1] -40, -25, 0, 25, 50, 75, 100, 125 degrees
> [2] https://www.murata.com/en-eu/api/pdfdownloadapi?cate=&partno=NCP18WM474E03RB
> 
> Signed-off-by: Emil Dahl Juhl <juhl.emildahl@gmail.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to hwmon-next.

Guenter

