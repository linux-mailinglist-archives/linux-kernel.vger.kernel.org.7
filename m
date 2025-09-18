Return-Path: <linux-kernel+bounces-822088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F07B82FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797E94A3EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BA527380C;
	Thu, 18 Sep 2025 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUhBsSjK"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4BD287507
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172855; cv=none; b=Zt5MTqZ4YZzmJwIZZuzdrlFDqtIXW9sgxnHz6yzr3G+nSXq4noBbBEEBC13wOh/l/EQfDl5B1Ravp2mPDlgdI/6esQ4NI7C1ICj6wicbtUpjHR+sFAFIBk/bWxvcJfeEnijYAsIhgWKn+5DUQLeiX8Th3JCb46O0SuW3w0Z/qXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172855; c=relaxed/simple;
	bh=mJBu47dNRLOUdwnQdDq7ahHq8KN4rsvXvyAfZf16StA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzfw+mInoyDhBB7GIfNj/em3wTtB8Ly1TLES15Ik7NQHRONEAicMKU1x7H0SsFGb2fqib5skJJmbtP+f9QVkMj/m1rt4588wdY5LtYvSNdc61kI6d0LlfTNqGhQV6ktzFa2w10rEC928tiqV6hP+Pfvza8+Iz/GrD95mV34qQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUhBsSjK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so512073a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172852; x=1758777652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ddz64abQ+Ip+tKkgy/htEThiGlqI2wjDb/I3daGz3hU=;
        b=IUhBsSjK1nIQeiX0wO3vX8Qx1aBkIYTkl7ZjP0CNoLm5taqHJEUT/RPv55SJRQwaZl
         +QJKO/0nYjkYc9BqRZf2YJ9J2ZMAT/gVaKjhKlYqfMCVh0YT6uLpK4bUiq+RJd10HJ35
         S4PFa9BILcngvg8x4ZIKKHVuPtsU168q5Qpe46c584b66NDKr7yquuPJ/HLvBvo17BGP
         /9+3ycNdgCSaywtpYx0n2+MhXhmv9VMnd3ZNoNFszIGjEJyC+WXMoFdZT6srsXchFRGQ
         8hjiiFGwyyhbUVNsqstrUIC54oIWlX+EmSrVX+Rv6XKNhYhwG32S3PMwm1mMONSobPiB
         DqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172852; x=1758777652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ddz64abQ+Ip+tKkgy/htEThiGlqI2wjDb/I3daGz3hU=;
        b=eNRPX0VjmTaU0GbX60OFgXTKaU7EkiHSbM8D83c++g919a+/2YVOmCwe3FeYw5seu4
         fgLT1NjjQS6X5oqc9Znet/h6LrRlHvgTZjqLHLGKR6q18AxYSV6tEfRd+hd5x41jVMXm
         7rC50p9J+YrME53IGYEfOXjlXtna1HDfrZY2lXoVniWQktHjGJslstoreVPaKwlnHbxA
         +irNeaJ/Swl0UAOa5UDRlOMvv2eCY6eiZUicCnQXCmWHJTomkERA6lBRotwe29z+bwOu
         2xlh1jrVUapo8Hq0yrJdgha/x51m8v5kNfcxL28ZUtVVhbxZq9XVtyHbEt1B7tjh4gTM
         A7hg==
X-Forwarded-Encrypted: i=1; AJvYcCWmOs9rXfzMfx9CxkM2GvCRSnOFixtLN/al7XFweemVn7Ln/QnLF+4ISbR/qaKk/EhBJKtQLY8pWVy6rQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsj2qCkl3ttxm8vJBidWi1yONONJ8DbT7ap/ucEe4sRrmi0Rdp
	f5phyhpUIz1kCsrmOxY5m4LYR5CUEa1qiDIMTZ2vtr9rIgbnNHYJ3MZv
X-Gm-Gg: ASbGncsDfLmr4tyrR7WfO8401S5VmsGFQEIdkJRjmsYcw8bIOTxc7BZcjc86FGnUqUJ
	9LPtecmhzIwNhzbCv9lJ/pJ6mKpE/B6o/RAL4llwcuivUxFl5R099LyXwbWhDANlxpAvZV5hnYm
	hJMIOyZA6wjIT7oYppAJWMflgXsFqk5zWn2rRzKzKnKYeJ/GSXAtA7Ihy0OqJeUTt7ega/VYDJ2
	8zA6UxvJkpRghButUXB2DF8SjWcrSUp6Qy8qqHkmlZ26bd9vXkmx+4BObF+wqDOS7M2RNERLkeO
	FCQ5x4rRkc3AWEwf0IGbfjQKdaArhkalXPMtAD8bD7pojjTqC15K2CUW6r7yZQQ7sOlk8SPewZF
	n3ep74639D42aBEQ2LUEpQ1VAdesinm5pQMOYCK4ZFA==
X-Google-Smtp-Source: AGHT+IG8CuXun9cOc4Miy8FKai+xpcWeH+yfmFB+Hb9vuMbp9yZvwClUBTpkB9qN/yr1gkSb+hoYzA==
X-Received: by 2002:a17:902:d502:b0:246:163b:3bb3 with SMTP id d9443c01a7336-268137f273emr60856295ad.35.1758172852491;
        Wed, 17 Sep 2025 22:20:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:194b:8358:5c91:3d3d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c098sm12567295ad.33.2025.09.17.22.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:20:51 -0700 (PDT)
Date: Wed, 17 Sep 2025 22:20:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Jeff LaBundy <jeff@labundy.com>, 
	Jonathan Albrieux <jonathan.albrieux@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v5 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <blpydhtx4iqc7izbjaccikwjkeninghdykjndcp4d6d33wbybu@legip3xo2fsr>
References: <20250915-hx852x-v5-0-b938182f1056@linaro.org>
 <20250915-hx852x-v5-2-b938182f1056@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-hx852x-v5-2-b938182f1056@linaro.org>

Hi Stephan,

On Mon, Sep 15, 2025 at 04:19:57PM +0200, Stephan Gerhold wrote:
> +static int hx852x_i2c_read(struct hx852x *hx, u8 cmd, void *data, u16 len)
> +{
> +	struct i2c_client *client = hx->client;
> +	int ret;
> +
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.len = 1,
> +			.buf = &cmd,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = len,
> +			.buf = data,
> +		},
> +	};
> +
> +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	if (ret != ARRAY_SIZE(msg)) {

Added
		error = ret < 0 ? ret : -EIO;

because theoretically i2c_transfer() can return 0 as number of messages
transferred.


> +
> +err_test_mode:
> +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0) ? : error;

You want to return the first error that happened, not the last one.
Changed to:

	error2 = i2c_smbus_write_byte_data(...);
	error = error ?: error2;

> +
> +static int hx852x_suspend(struct device *dev)
> +{
> +	struct hx852x *hx = dev_get_drvdata(dev);
> +	int error = 0;
> +
> +	mutex_lock(&hx->input_dev->mutex);

Changed to use

	guard(mutex)(&hx->input_dev->mutex);

style and applied.

Thanks.

-- 
Dmitry

