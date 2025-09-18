Return-Path: <linux-kernel+bounces-823675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89978B87246
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3D53ACE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624302F9C37;
	Thu, 18 Sep 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFUsDaaY"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3B2F7AAE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230960; cv=none; b=Jabd6OPb0EjgwzPKwX1ULfxOvpYaVBIqAdec/4p6/nMT0rKuM9CRZSZev95QPTJNnHy7S3ujNRu0218FiXQfaaFqKw+m7jyHXXFPwI5qmyKh+p+TCVFYQZi7gCzRJRwChRJdY6gyTmJ7jHg4mB4DkWF+LDbfWQs9pBtVMThV6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230960; c=relaxed/simple;
	bh=HhwvCvZmySup6P/KoBzvo8skgfYCyXTfkBl8Xon7+cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikw2cqiLuJhhhwYyRHLqKHbzsXkHGgnKGzsry1B0ccGgnuEmSzSlulRbpifBKWSeT6NitbBr1+BAQCeDuFZuxVpvNIZZfy2IrSCvjEsOFcR3Wah7EQYZwjCkAMTreMaWvLKQ5tZ/u1yCZ8yVyj3P39B80TK7n2zljZGoUFIlo4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFUsDaaY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso274245a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758230959; x=1758835759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5FfQ8fE9EyrFTigYn4OGWQVM7XEzur4GFkeN8+xurY=;
        b=WFUsDaaYKlacvEN4srcm7tRJNN/WwomU/K5jYTGNAjcJ71NxGHfoLYsUg9eIsfiQ7o
         ErQkrdTgdylUVqdQqPBhALFlNC87At3+57hcmSLvcMiOpIpdjzg3w8kKSIANQ4Y1X9+b
         YrTFmxpBYWFRSCp2CyKYEyzz75AwA/1b8ZWCN8xroZhBSnitEnuIBY6TBWEzWhuVVE5o
         TAE5hwKVDFQ6rJqV7TWy7NfyFSzuW6jvjd04Up8bu16QOjvFfNpCFmu2bkM9dNuoMCOM
         GEUUx7bj4JDPqoBCc0CjUvLBfl9j9iOR2bbcrohboZuMkJgMvceNSEs+OyEr89iM7FC3
         oc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758230959; x=1758835759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5FfQ8fE9EyrFTigYn4OGWQVM7XEzur4GFkeN8+xurY=;
        b=pK/5w4JsbmB1oxZ2g26U8/LAb8JbnlAQVDM29FYmValS+RaBwqEwxCh06Ky02unWlg
         9rusPUfVAGC9EGwHvImiDoKtxd6JDCLkDreBYBAMOWcOeMcROX3s5E1aqbBQJmJyzExr
         bV+PHe/pdFmA8wmLrunuh74YNQyqj794vbVro2M8ShGLlgKLEP2BcIdHPWv+WkePs+6p
         XKtnmswbcsCe/fNhCSYk0zxFtclAXWkYfEjukKwV+so3jk5IWXNprrwDzOmYrxNkvjsA
         WN7rRdlkx7V/hpR7cds2QGESnhmGXyCyKF+iSJnwuvNsAg95krC1nzSYFv+9e7eC0QBk
         +KUA==
X-Gm-Message-State: AOJu0Yx1eK6qdtGAeCeg4jB1b8tvJwNGOs6Rp2m9oJWDNLDvT/IDehJl
	I2ofWmQao6yqMoOh9r+bmzQ+IkWQOVZWQgZyT++otSeGnIvWVSJSpuby
X-Gm-Gg: ASbGncspBQ8XRPX6WNUm6BFQ1yb6QS1X3tNSbOy8cdiOAC+jSeXwKID9v7SjyEZCSR5
	4gdpvVNNcZ30F1h3ufE1U/VR1yEH8+mMR+yswehmz9GAZR82Whblh1wVw4atOMpNgAIu/H0jmPP
	npXzsF3kBlYhYMJbxb3Yr5EaDDXn2zYfQapfh65yazK9yS1ZLwzsn2HivMp/k1+ef8t9C+uSF4b
	nG36V/CWhh2jS1IFhmCqZ9ArSUTxVw4f24vxGeYeeXw31BfsOmPHyaIz+i8Ac9iQXerqYyVrLE6
	AbyEF72YetOpt4I7Fm4R5JiksJn6QQI76XhH8r6oVTLuexxmcqJB7sAEk36VCWVWs1TMa89EWeP
	TAxIKI8Awtbx59r775ZD4ljCXIoYuLuVYuy1l8GYY2w==
X-Google-Smtp-Source: AGHT+IEbft4paW40MvQeDZQuD9dWp8aiBG6nFm7xbVwWQWYmFP/VGjbbe2yfvPhDG9/lnQoov1z1VA==
X-Received: by 2002:a17:902:f691:b0:24a:f79e:e5dd with SMTP id d9443c01a7336-269ba5081ccmr12875835ad.37.1758230958575;
        Thu, 18 Sep 2025 14:29:18 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:8e3e:e1c9:1151:50c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5e9sm34246905ad.72.2025.09.18.14.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:29:17 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:29:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: touchscreen: convert bu21013
 bindings to json schema
Message-ID: <na323mzpk72zkrxqmqpbubacj4f2iylkggcen65hcvsafcb7ys@ez5jot73iyqn>
References: <20250918153630.2535208-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918153630.2535208-1-dario.binacchi@amarulasolutions.com>

On Thu, Sep 18, 2025 at 05:36:06PM +0200, Dario Binacchi wrote:
> Convert Rohm BU21013 I2C touchscreen controller device tree binding to
> json-schema.
> 
> Additional changes:
> - Replace <supply_name>-supply with avdd-supply to match example and
>   existing DTS.
> - Add reset-gpios in the example because it is required.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Applied, thank you.

-- 
Dmitry

