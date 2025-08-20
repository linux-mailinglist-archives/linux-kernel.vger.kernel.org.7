Return-Path: <linux-kernel+bounces-778355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2117AB2E496
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995121883E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A4C273803;
	Wed, 20 Aug 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPOjhJxj"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0424EA90
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712798; cv=none; b=d4yxYlySPRN63MvFHXB8t7N88hFjiMLZ9QfdhYSEN24Ak5Tn6ylcNe6DAipCRyS2YCs87p1Xq7DP9Tdl7agciKFr38d3dkA3QtjI9WO/NUqPiuR63H/0UIIYeVcBmaGO55BnMH3jpof6AsVH39ucRyXp1QA8Zpnxq2/AcE7AbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712798; c=relaxed/simple;
	bh=Oka69nYqhgw4mUHzY+3xl7uUA2VvGgIzb2JO2VYF0RI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FABA4rOMGXMmRNvP4r3I0yXvfdNb59pW6vsvved21tL3OQ8rTo0/QU0WgZGOjDI5BR/3BRROsvPfKZyML3fBQri6EHpPDbbmxe+jOjCB6rbVYXdRe/7QpnFgJaO3j01Pm23z7YyzU2Z6B3CcY4Sdh2ZUMHWBu1rUXTZu5eStUj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dPOjhJxj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so1020285e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755712794; x=1756317594; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psd7GX0dj7+39+JGOVBzQw4uHGDJswb4ASw50pIR/xE=;
        b=dPOjhJxj8AANK/OhHAwAPe1ERnEpMzeTLVmI02SRmN4uwOcxkaDFwMpXXdW51dm9TI
         q5dZ1H9Hs5wkDEd5bFC2OAkLYy6UwYxR0nIVeFli2EZzUuaVWo+FQV/UvXe0aJJjDSCP
         uSsO2hFvjRGNHJDRxt606M0wFovv5U9kZDTNr2RbuQMN681CYChAgKYoO4RQfIEg0lhW
         ycLbxOtZ4AYbK7OzQb53unTMz2fldejrvKZWMC7NrQDXALDXXsKd7u9I5GuWXGM32SlQ
         JRzZFvtsB+qxkF97twYwIL36+fpDQYxnD86TRT259hm0BWmrwa7hhA/gUFDS2GnJ6Oiy
         3+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755712794; x=1756317594;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=psd7GX0dj7+39+JGOVBzQw4uHGDJswb4ASw50pIR/xE=;
        b=qRdseHJywaejk9OWRvn+TE/j+KxsG3BeEqwTp538WBbDScZv6BA7dlOUWhOOwlL0vI
         0hh2+U22VfsbEAXd7uP7T9hfflT601DV5c/5j11Dnabv//r976krNOjAlz/RMRSoxUu2
         WYLDwEKReTplTTLKgsvMqOyjfftL9Vd4kydwQ1bPe8Qs7VkOpt5aHW+YtvWsQSF0Wa34
         b5fSOyoraAJnldXVws8tiqb2xh+okNQhuaWqTEF7U3efMv9Aqk7h1Vw/Nn0p6ZicPuLZ
         lywHq685mR8s+I/mGrIa+IvgEslvSuFUS/Z13yS+0QqAKbTeBpspxuL9QDNIblbdnbW0
         sx3g==
X-Forwarded-Encrypted: i=1; AJvYcCUcSxSdGzr9Zz7dTieBNTPmHET0pK+ZWmSjXao2BYgN9Q5e00RxtVDZfPZfhlnGxktf5U8qBX+phFCZlsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Jt4H1ihiXwYSCWdcJ2RYsK57Zac2rUF95Vok/qIkOAXHE/np
	gx2PfQFg3RzNzZaEbxW2f+d8zlrxXm60O6LPFBstawmv6s3iE7MphZ2GLvubHHK+FMM=
X-Gm-Gg: ASbGncsK8ur+9tbYLG/aZlTTq292T8Nb5DtHIbF9nA473GXDFiyi4ASCxjWeu3X0KRj
	fZOObsb7iG5AXJQ+2LXSIoHg4DWatgMKD+FANrFmebgfaFJMQT0vZPEeeZi94gewF8lPf56Xoit
	gHNr+O+UsRsGXXffqU9YNI1BLzHKMAdvZS3jOOclYxinzWhT2/TlY2LE1EVFVwiIvfjdnnfquVD
	nkKt4+fVGsas50Oncn+XsXHA8hC46PhCr+Z4tVhDFJBVsWdl/qXN3KmIGT9oGrpFqrdi9MWcvvP
	XsERdyn7ZH9vJYkjFS1NO6zhCFyQULwAAubjHvS+0Ukhl2PRNVQtar8zQQj5EJ+JXn8vpTId/aT
	CBXGnb9QW9Aify0s5tdMf5HGJxTYK9zLK08uKbw==
X-Google-Smtp-Source: AGHT+IG0HixLdWbK9CluBnPq2eg82Ql5cTYrFzVyRwWIRunFXARzLchOek5V0A927f6ndOI8kHBWcA==
X-Received: by 2002:a05:600c:3b20:b0:458:bf9c:274f with SMTP id 5b1f17b1804b1-45b479f34a4mr31709205e9.29.1755712794543;
        Wed, 20 Aug 2025 10:59:54 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:3a9b:1de2:5440:9326])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c8e379sm47740645e9.13.2025.08.20.10.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 10:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 18:59:53 +0100
Message-Id: <DC7G8QJ0XVJX.BBZHVVZO6OEN@linaro.org>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, "Srinivas Kandagatla" <srini@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Patrick Lai" <plai@qti.qualcomm.com>, "Annemarie Porter"
 <annemari@quicinc.com>, <linux-sound@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>, <kernel@oss.qualcomm.com>,
 "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>, "Pierre-Louis Bossart"
 <pierre-louis.bossart@linux.dev>
Subject: Re: [PATCH RFC 1/2] ALSA: compress: add raw opus codec define and
 struct snd_dec_opus
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: aerc 0.20.0
References: <20250616-opus_codec_rfc_v1-v1-0-1f70b0a41a70@linaro.org>
 <20250616-opus_codec_rfc_v1-v1-1-1f70b0a41a70@linaro.org>
 <1317c3c5-967d-4013-9c0b-f68844c63908@oss.qualcomm.com>
In-Reply-To: <1317c3c5-967d-4013-9c0b-f68844c63908@oss.qualcomm.com>

On Wed Jun 18, 2025 at 1:33 PM BST, Srinivas Kandagatla wrote:
>
>
> On 6/16/25 4:26 PM, Alexey Klimov wrote:
>> Adds a raw opus codec define and raw opus decoder struct.
>> This is for raw OPUS packets not packed in any type of container
>> (for instance OGG container). The decoder struct fields
>> are taken from corresponding RFC document.
>>=20
>> This is based on earlier work done by
>> Annemarie Porter <annemari@quicinc.com>
>>=20
> May be co-dev by would be good option.

Ack.

>> Cc: Annemarie Porter <annemari@quicinc.com>
>> Cc: Srinivas Kandagatla <srini@kernel.org>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> ---
>>  include/uapi/sound/compress_params.h | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/c=
ompress_params.h
>> index bc7648a30746f4632ecf6695868e79550a431dfa..f80989f7bdd2f1bfad843b1d=
c30fa263e083d17a 100644
>> --- a/include/uapi/sound/compress_params.h
>> +++ b/include/uapi/sound/compress_params.h
>> @@ -43,7 +43,8 @@
>>  #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
>>  #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
>>  #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
>> -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
>> +#define SND_AUDIOCODEC_OPUS_RAW              ((__u32) 0x00000011)
>> +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_OPUS_RAW
>> =20
>>  /*
>>   * Profile and modes are listed with bit masks. This allows for a
>> @@ -324,6 +325,23 @@ struct snd_dec_ape {
>>  	__u32 seek_table_present;
>>  } __attribute__((packed, aligned(4)));
>> =20
>> +/*
>> + * RFC with info on below OPUS decoder fields:
>> + * https://www.rfc-editor.org/rfc/rfc7845#section-5
>> + */
>> +struct snd_dec_opus {
>> +	__u8 version;		/* must be 1 */
>> +	__u8 num_channels;
>> +	__u16 pre_skip;
>> +	__u32 sample_rate;
>> +	__u16 output_gain;	/* in Q7.8 format */
>> +	__u8 mapping_family;
>
> This is where optional Channel Mapping Table starts in the structure.
>
> Should this all these channel mapping memnbers go into a dedicated
> struct snd_dec_opus_ch_map?

Ok.

>> +	__u8 stream_count;	/* part of channel mapping */
>> +	__u8 coupled_count;	/* part of channel mapping */
> Comments are bit misleading. Either we document them in detail or point t=
o
> the rfc which has this documented in more detail.

Ok.

>> +	__u8 channel_map;
>
> Channel Mapping is (8*C bits), one octet per output channel.
>
> The way this is represented/split in this struct is confusing should it
> be just channel_map[8]
>
>
>> +	__u8 reserved[7];	/* space for channel mapping */
> Any reason only 7?

It was 7 because 1+7=3D8. For RFC 7845 the mappin family 0 and 1 only
actually make sense for playback hence max number of channels seems to
be 8.
I'll update it in the next version.

Thank you,
Alexey Klimov

