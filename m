Return-Path: <linux-kernel+bounces-858146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E6BE91F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362956238AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167E132C92B;
	Fri, 17 Oct 2025 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su/2IPOE"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE832C94B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710463; cv=none; b=O5Mwn1SvUPHuBXZjn3ge9tFzvXB54dl5dSLGqs91WlV2z0ZPVs+qO9/tzYgrH7IgOeWoReLxSV+jPLFoiVGRcVfP6qOGjSx27tMUqFak7HhY2ofOxNRwhwPOs/E5TWHtBY27zTBoa/2AIozdm4kYRoea/YlNwfdra2mjHqHArZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710463; c=relaxed/simple;
	bh=959p6xV6CKeeWXiRtPPtRMLL/TFd0b3Xs25RXyKYag0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KMcKzOc/IzzRFuW0b71SeRb/40CVPMVgO0n7wi61yKDBZRlU00ZBu0L/hMyqezQYrfOvL4IIsb/lyMeHqRmgDsLUlyzw06268q1d82RmOllp+nnCtIloGI8ghI7UXPxphlUJVlBC+/gB61UJBmC5KH65pvv0aCPb/SG6VJ4Sfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su/2IPOE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47114a40161so19708485e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760710460; x=1761315260; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FTLnHbprIsxNg0GlvOz1rxX1RAjfsFXOqHQiYRq25LI=;
        b=Su/2IPOElTtM+RsiQFMRs14hcKxioX7VfmNMd9Wuywrv8kjPCSJROetHVRUc9PhL2I
         ZjpamG/lE1Ugc0wWzT9ea9ryyVtx17N93Es7t2N2ZupCvSUQQ4BX5UNujWZck9SJoR7q
         W0QntK1fjnEpyAYA8Q34ed3VaoKiA8s4bzr5BES39aOL+4KzAcjAK2GMPPmbdKlJBdee
         grP8XDSLyGfaItUt6ripBXvyaBjV4bLCiV7qeau9gC7AfjJ8zVxxQy6cyQy6OFLeQUFV
         m8fuHnlvJgVRx/g2mdKfuCLgmlOr3OR5ADf1tOZR1OHehThLS7ESA71EksyUqROC8bYa
         buhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710460; x=1761315260;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTLnHbprIsxNg0GlvOz1rxX1RAjfsFXOqHQiYRq25LI=;
        b=V1U88ehylzHQYqkUlxvJFhy9SrypNVD8L9Qqq7I0onAdbMmycfC4oJnxNSeh258w4s
         HbyyAcqRIIT1WYfR068oJKh5+PU9ku9Rqa4BUFRt29MXfYMBawUF+uzcPZX4jjYsqwn0
         B1/XOM1EJnelMafn49ffrjkC1B7mVSu9z52T5rdsywre/J9g1KMSurnxcg4moeAIF3TN
         BHkopydQTNPjdVTLaCCkGD2JU4E8Z06+7DECZnLh2nYtBWSiuSIhUkuaakde5dYnKc3h
         yUNloGUEn44j22FdLnHD/ifMTYwvpdWsb2ziARS/IlEaGffb0jZd/Qrhpinn5Q1Ks71L
         ithA==
X-Forwarded-Encrypted: i=1; AJvYcCWPUYQ2RTaU4aMxJq5kCTbc4P1zhQN7/QwC6QnWdKFIhZHwwU+XBbjqzrxMpWGrOVabfks/1tKHMSZ/UkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHindKpeH2DcZgYKozJNdzohTfxUOn4KVCym4V5xCxK/JupMIM
	CEvCkKgVABk8ed3p/DuRg9SfOsMuRdOO7skc54X0qAq3xjqsOwghvv5b
X-Gm-Gg: ASbGncs5gT7zXPhgFgzAqJH8tlKd8TIUpaHGTZv+Eb7iuOH0fa/x0wOHU0cvq0GK7dU
	1suh8E0wxvAc6EOKIRf1DhE2nZTM6FXvcMn7+iL/IGlXvIdo6D5CK0cG5SIhQb9vhjLaCooQkbY
	A2x4qxYSV/7wFm/HSn9LVj8osAsIMPaK4ow33KNO8QYE+6cdAYxcfOwKLyDUjNiimL3GcTTmLlT
	wGqsJl0XUmlxnepW0Hlp+zQNX8CMbwQmlNr4Let7ZQ4BhOsh5XoV8Ue8KLhKss0m7llaXnqY+OV
	YX0/Dot+rWiQ2Z4b1mtjCZ0cDXMI9eDWGg6RUKYH/RgEnfBLAW+mRkvDG/oT++8DVnCZZndZmKg
	1YDJoFdJenwWbHccehofRDF3uW1xP1glt5wYpX2Q8Biw6E/npBXKhVsUxJ/BAkvIVFRw+e77Jbd
	FxbUCvbbITioW3H8R57i0=
X-Google-Smtp-Source: AGHT+IF2EM7mT5D52gnp+VTbfiNcarttRakEXF5/pBTZwv3B+9i+o/ZbwXxFScc6ahCV+wEMQcYNyg==
X-Received: by 2002:a05:600c:821a:b0:46f:b42e:e3a0 with SMTP id 5b1f17b1804b1-4711791dc89mr26441555e9.41.1760710459832;
        Fri, 17 Oct 2025 07:14:19 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114423862sm87177925e9.1.2025.10.17.07.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:14:19 -0700 (PDT)
Message-ID: <014f2380e9261a1449214907a149f11267acdd11.camel@gmail.com>
Subject: Re: [PATCH v5 4/7] iio: adc: ad4030: Use BIT macro to improve code
 readability
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com, 
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, 
	marcelo.schmitt1@gmail.com, Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 17 Oct 2025 15:14:52 +0100
In-Reply-To: <ec78fd7e4348e2cbc99ae08004c48b7ea238ecf7.1760479760.git.marcelo.schmitt@analog.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
	 <ec78fd7e4348e2cbc99ae08004c48b7ea238ecf7.1760479760.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 19:21 -0300, Marcelo Schmitt wrote:
> Use BIT macro to make the list of average modes more readable.
>=20
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Link:
> https://lore.kernel.org/linux-iio/CAHp75Vfu-C3Hd0ZXTj4rxEgRe_O84cfo6jiRCP=
FxZJnYrvROWQ@mail.gmail.com/
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

I don't find the link particular useful in here. Seems redundant with the
Suggested-by tag. Anyways:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4030.c | 8 +++++---
> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index 4393160c7c77..b2847fd90271 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -233,9 +233,11 @@ struct ad4030_state {
> =C2=A0}
> =C2=A0
> =C2=A0static const int ad4030_average_modes[] =3D {
> -	1, 2, 4, 8, 16, 32, 64, 128,
> -	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
> -	65536,
> +	BIT(0),					/* No
> averaging/oversampling */
> +	BIT(1), BIT(2), BIT(3), BIT(4),		/* 2 to 16 */
> +	BIT(5), BIT(6), BIT(7), BIT(8),		/* 32 to 256 */
> +	BIT(9), BIT(10), BIT(11), BIT(12),	/* 512 to 4096 */
> +	BIT(13), BIT(14), BIT(15), BIT(16),	/* 8192 to 65536 */
> =C2=A0};
> =C2=A0
> =C2=A0static int ad4030_enter_config_mode(struct ad4030_state *st)

