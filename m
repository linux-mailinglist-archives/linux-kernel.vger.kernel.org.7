Return-Path: <linux-kernel+bounces-813189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB39FB541C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D944E7B8080
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF54226F2A8;
	Fri, 12 Sep 2025 04:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQJP+BT4"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FE2620FC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757652679; cv=none; b=lfH/g4Ojs/JtnIa6VqrEq0NJeA2v0hboyGKbJmqIfUJ7Nm8Qw90LfBeZAaOXgdbN/pxqyLEL2TAIQYMYnRsKq21ecpBNPjPFSLrNGOlCnDdbRcUIyr6iMqqljF6vJThpVm+cjQJi3IC3ANgNEc2MEYrJRNH2v+N/ocxWux/4SYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757652679; c=relaxed/simple;
	bh=rlC6PlUTqNti3QT38c9nCMwO/b/NfFkTbVXEp0LGsdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dw5jIjVooxs5FMzOo4AbtZriXcVs8qjOil+REXoX1CIR1UEyUy8gllmGYKGTShrhklAg23uThuQQPjGnL/wQDr8MFIYP4iWV/SZfukCRTrrYi+z8jKfAgJZhsK8YHTaXrSmA9Of8bvVbFgSKGWGG/27EkaYh9a833fG68+CnDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQJP+BT4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b043a33b060so217963466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757652676; x=1758257476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlC6PlUTqNti3QT38c9nCMwO/b/NfFkTbVXEp0LGsdE=;
        b=iQJP+BT4JDTuFYGLe2C9ETUww/mDWcDdm/dD6BU79s32+7wuapeSnekkT5A4Q5mMh2
         9t017CRhFfYGAh50j3Bo5HGlI8mYlKe9l2d3LNgxVf7IkRYc4tX3HsplrAvAlqkPgON6
         roveD03FAQuU9RKstXKNj9J8UwNz3dW9A6zjHAys61z+c6X2AbR83ceJKiQITSpawLUe
         UoBC0aocKuGyz/kvmArKlVgwqFoTXyrmLnhimW0jKaT25YRRHcRWLHmKcubnMEnkbizv
         aI0GcDZZI6vUHpaYyCr7spjL/a/i7BmGIhTMtKzI4v/AdXICXIetxnT675k5DqRnNq1p
         eCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757652676; x=1758257476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlC6PlUTqNti3QT38c9nCMwO/b/NfFkTbVXEp0LGsdE=;
        b=PrWkDkrhlI9uQB1M7lnoehMuS2zp4g6Djm3KiLpjv9ZVy5FVFmcceGRICID8bn8uoP
         G+Vp97BS1HlmBmTRF8LLOHBAYoBhh51DnfpxdGrGQHgehQVt2y96AIdVUmL6kN2phIVA
         6asfS505Pe5Keayuqx/YO6Fnk3czuqknnUMB3Qc7TUl2VpqdwnAgLct4GkFqcxEViPxo
         RQPZ6BOsgsK5WtMLioto0K6g/5UwF6eDEwcqE0o8L/WxCE3LetpR9gIZzyHEqU2BLnWk
         tCuffY8eODfufT4guUtQpcwwxZGOR3vS4VUmfL00K2Gs/UCeut6242NZLJc2Xs2/T5F5
         qXQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8F4neVrDWoSw81sQX1qqvglmGyscmfcRP4NFaULdGOkKhiNR8rIf70dROeX37WktQzidi7/vuyCG7XRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY3lLhUA8Ymq4KUtFoPqXXTl8qEBcWaGUAjXQayeh0NUSKnoxw
	/K8qUMC0ow/0GA1vtBRlxgRFs44ZLtQDGx7z7aEwXgWXwEkiP9keTxV0yg/Setw94eRJd2fKZ3d
	t0y4dtHDqPiJHUHKAaj4ImmmJPZG1uok=
X-Gm-Gg: ASbGncu+LzqhHJBNP0TTq1U7pr1yaaL3T/oJi/TK5Oy1ZJBIJ1Whd01KAen5gSlcAZv
	pfPLKrEPFHniHmor4ILq+S18ilGk7wKg43nu6noAUV5tCTzA2zJ/ZA4Y3OBiVHzXgtdEilNBWqR
	05V0ljP2+NQ7rJ7/VP73t9F0LIbJaNgpnmhCwMcp1KWFwzoXNXavWY8SxSlA65wX7gRsQYeBLMG
	KvMTVE=
X-Google-Smtp-Source: AGHT+IEgUmSC5kaO6kuCJj+eNxyTqCvM9aMgvLzfRI2xIXUT0aF83rS4s8nOYOwFNdVSWxdA5AcO9dn+Ynq1WJm1iEA=
X-Received: by 2002:a17:907:9693:b0:afe:c1bd:b6d6 with SMTP id
 a640c23a62f3a-b07c353e733mr137553566b.5.1757652675933; Thu, 11 Sep 2025
 21:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Sep 2025 07:50:39 +0300
X-Gm-Features: Ac12FXylwjz_ZI_utuE9R2j7ogLYGeMVukWRZhDy75FP68KNOm2EIVd88U_p4II
Message-ID: <CAHp75VdtVPzVxSLH=i+Hpze=mkTBvW_PVnhy-OT6xX47pGZdSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] iio: adc: ad7124: add filter support
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:42=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> The AD7124 family of chips supports a number of different filter modes.
> This series eventually gets around to adding support for selecting the
> filter mode at runtime after first doing some cleanups to the existing
> code.
>
> The first 3 patches are just updating things to use newer APIs.
>
> The 4th patch is addressing a shortcoming in the driver where the
> sampling_frequency attributes were being limited to an integer value.
>
> The 5th patch is the one that finally adds support for filter_type
> and filter_type_available attributes.
>
> And the last patch documents one new filter_type that was used that we
> haven't seen before.
>
> This applies on top of "[PATCH v4] iio: adc: ad7124: fix sample rate for
> multi-channel use"

For non-commented patches
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

