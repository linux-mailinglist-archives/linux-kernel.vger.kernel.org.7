Return-Path: <linux-kernel+bounces-741632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EDCB0E6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D154AA2CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5EE289E0F;
	Tue, 22 Jul 2025 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VBmvdgwr"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D8728153A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225721; cv=none; b=mxeLchcFGF5wHhU8sQQ6FpcqS/W+rawjFaLw+VMMM19otVN51fDxI1iwWvMeYGvYXfEZp+m5Ig5wYtQo67dA0Jck/1amNNNVWfsmNSjvOPq4FFU/biFzsV1jlQup51oX5AKetb5s7PyF20Fqol7SkgIIOwnWo40EDW/pyOo52Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225721; c=relaxed/simple;
	bh=+lnyMb/F0sLNixP6Q7zYfcdherQ3Qd9HdsP1tmvnz00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5xorGsp7sPltswiPxrgwCeLnh/3AEY+nfPueM+2kvFm49dbfrd6H9T3eiDpf/6PrXsA4tSgBytsrwVMMTIvdlQf229EKKHjOosxeA85VIses8xgJ8Tr3YEUQur9QOW9QRiZCQ88HR0pztnr6ybboTtm+WT2qLS2C0I0Kx0FuLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VBmvdgwr; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61774499ea3so345557eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753225719; x=1753830519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsvRf1LNCehYae3lJN6n6abCG/sl0gR3RkUOBc2r6zc=;
        b=VBmvdgwrIFnhOAOkkXc4ioIz3UTBPh+Jbe9nM4MsG5xizeBFJuzD3yWZ1FngTYpjfA
         rfCciRNddBMjy5A1ld1ccpX2QeyJ4aiztjK/PsHfsKvbP23zUWzNWtzz0uTX4irCxgZL
         SRiY7be9i6wYcTFtKt2vWLdkKFa94zAxqis3Bxw0ypioZWQ2nSGc01mSEI43JcySVb4c
         9DHHtrpDvscAbDTp9qPCxGJFvy0oSECdlKQMp48vW7dewyQCB9HaDmcbWHWRu3zYMvjk
         p//TBvsuaTs8ktMyU6gRiE8fzvXpRzjx+B0IU2ZYePpTJ7qyJICZKdR3S1pO60d5uPg8
         dAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753225719; x=1753830519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsvRf1LNCehYae3lJN6n6abCG/sl0gR3RkUOBc2r6zc=;
        b=AO2nMzPbg+jp+vkHAmATs8TadVUhl3RETjdG/y5ky4kocMdzWaxgfsqz5mB7sDFssZ
         UwKKRp7NYECgFbJoVWBBtP3629wIr2tfm9Wxh3dMxoDvXP49Ab5bJESt+2pRJEgBGaiq
         rFnVJGP56p5Q3hNCbGJZSWK3ocO+KH1sI9CzB+02Xo9QVgdFiUnrXHSs+J4UxupAHwNB
         Aq+117p05WonE8U0w1OpXXJwX10V1zb1WwyhoKnjZxXuHwzyvVrle8YbuS3IYtBZh+g7
         YquCfmvrBVHkNFVWBKgEOaKYcCrYZ+VqRw22iN8UAje2PiWMFkWigfeIUbYL8ubKDaMf
         ihtw==
X-Forwarded-Encrypted: i=1; AJvYcCVDfAcm2kGmg2sH/J9q5avXTY7nN6G0yUGygALruhv68c/v1M50U1WoJh4NhS7huGnyiTVe2y0Mw7Oe16M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhWy4OkYwap04IUTlmyfLvk91rRHRfgphBxEKX06kSMvc7eX7
	+4mhgNpp3YaPb7239GN5PWT6EOv46y7BBzFkhOhM/Akb+2QmUu6zEWEcZyUuLBP48z8=
X-Gm-Gg: ASbGnculnVdB2A2RzMzTanPx9LZQxOKHpPZOFGgpON8iAB8IeJUzegt2HrQvJy/qNtZ
	l+Fe8fFIwDDpk172+AfxI7YJDC5p8CMXpU2sX8Np+OdMIc1+WOQ59L5TC1+p0hhsdthkDKYrb5V
	jP/LN8erl+QLvi/ya1tx7wqEZ/+4lVoWVpRIKkCgpdfo5yCEZb0OGPiidQtHfg3oCI66Rv+dmJj
	dtpz6QugE8qrLQSiiosfDJC8onRa8sl03EGy75Y+ywxG3uDudys7UYRdVPjYYeTmCJ6rwn088XR
	hSeQkrf+Q9GSCihCMhhWolRxj0bHDGRM+nEBfxnuBdv3AD5rV/93llLmqxZfzv5qYUbqJ6yARsg
	qqMJLhnl324huyZg+ZZOOMrpkmGiTfckpnOGjhYT4m3ZRfts09F8OFOnRCGNz46Z1b/cf1Le485
	vizm5GvIc=
X-Google-Smtp-Source: AGHT+IHSRs2wuK5jMgQaFfXIetgnLF8ptCHVtH0GA1PndSp8X2ODi9o3lUk4ufMYvg1hN8Cj4+IyCQ==
X-Received: by 2002:a05:6820:206:b0:615:9107:fae3 with SMTP id 006d021491bc7-6187d91376fmr509416eaf.8.1753225718898;
        Tue, 22 Jul 2025 16:08:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:11dd:c0f5:968d:e96? ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-615bcab270csm2091386eaf.9.2025.07.22.16.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 16:08:38 -0700 (PDT)
Message-ID: <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
Date: Tue, 22 Jul 2025 18:08:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Yasin Lee <yasin.lee.x@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 6:07 PM, David Lechner wrote:
> Change the scan_type endianness from IIO_BE to IIO_LE. This matches
> the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
> the data before pushing it to the IIO buffer.
> 
> Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/proximity/hx9023s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index 33781c3147286fb3e2f022201ccf7e908d0b6b12..8e5748a5f37a7b6674acc1604710394326818204 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -251,7 +251,7 @@ static const struct iio_event_spec hx9023s_events[] = {
>  		.sign = 's',					\
>  		.realbits = 16,					\
>  		.storagebits = 16,				\
> -		.endianness = IIO_BE,				\
> +		.endianness = IIO_LE,				\
>  	},							\
>  }
>  
Just noticed this while reviewing scan structs.

It is odd to have data already in CPU-endian and convert it to LE
before pushing to buffers. So I'm a bit tempted to do this instead
since it probably isn't likely anyone is using this on a big-endian
system:

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 8e5748a5f37a..b8076ca4d0f4 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -145,7 +145,7 @@ struct hx9023s_data {
 	bool trigger_enabled;
 
 	struct {
-		__le16 channels[HX9023S_CH_NUM];
+		s16 channels[HX9023S_CH_NUM];
 		aligned_s64 ts;
 	} buffer;
 
@@ -251,7 +251,7 @@ static const struct iio_event_spec hx9023s_events[] = {
 		.sign = 's',					\
 		.realbits = 16,					\
 		.storagebits = 16,				\
-		.endianness = IIO_LE,				\
+		.endianness = IIO_CPU,				\
 	},							\
 }
 
@@ -950,7 +950,7 @@ static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
 
 	iio_for_each_active_channel(indio_dev, bit) {
 		index = indio_dev->channels[bit].channel;
-		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
+		data->buffer.channels[i++] = data->ch_data[index].diff;
 	}
 
 	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,


