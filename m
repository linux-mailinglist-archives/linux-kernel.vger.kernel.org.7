Return-Path: <linux-kernel+bounces-843832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE0BBC05C9
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC5804EDB9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5CB230BD9;
	Tue,  7 Oct 2025 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6F4DWy3"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B91922F6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819523; cv=none; b=D3IkBS4T4qLyfJr209ou63lzrrbk2yaw+Ddb9RDgygXQz3z6RjS2uY3G8sC3EIFcW9nNHd7NVcTIhF9RFVQVN2a4v1EUufjoptEM2sMtkUSMuP4q9LbrQGznK22yjVHyPNjmw2Wa9qNcBSReEeGMWrQS1o7xPHnw7gvL/SHGI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819523; c=relaxed/simple;
	bh=wN04ruwBF8mX2t4ch3708+WvxDoWId3SDn7ja/wo3YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOoMnkoL1YWUQIn7rokmjw/iXCF96GWokxgJRUNvRWkTGearOv+SJorBFJ+NvSG43zUoqotFNpQEgn+a2aY1gqfHsr4GBfr1VRvUEJ/CpO8fc9h6LM9jFVwjXj6vJIaCDGkTgP3+YkmaCmEYvdWUppwzCMhoxRwVjqUujS4xgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6F4DWy3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36453927ffaso57040451fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 23:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759819520; x=1760424320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uuu2lzkPEMfNDjhll/Vwo57RHAnwsEsvb4MVNUsLQ/8=;
        b=f6F4DWy3VMSNoZMfeuctBnm+8VNRBqAr16MEy5k+nAAxIwovBIEurmj+Ds0+Iv1Uk6
         F6ts7PdBWPii8v4kJ/IU37g+MvQAJ/+8qle3zLKeoUPsYqYt8aKqWy+lbMx9aBGHq9Tm
         V3RAFXwKstdueoRFl3gFt6W1SuPCgTs3TQ+UGPalphPc6+1c1XItXif9piLxzrRuAC65
         r2lpg9lYo9M2KnDU0WjCHgN64AcbOvVu8Fr1FfifjnIvRpXqnAqjbIj7z9jn1OyeIPjB
         W+3E/qyHP3i1R76oLoNBE9Ziz42J7XUS66JlEg7nD+t4G8YNQyE2mxgY6i8++ZQVGuNV
         ntJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759819520; x=1760424320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uuu2lzkPEMfNDjhll/Vwo57RHAnwsEsvb4MVNUsLQ/8=;
        b=Bi0OeH7gggyc1Bp2owIhxLa6EOhYsAVwI+j7S9I2JvUASAIPEhMS+oiHgDxfhzyLIF
         WIsD/jEf1c9Ovhcnllchx1GWMRswuBz5UecwQPGO+jPcmbGcIP0MpkA9MWZLnBmGNVOZ
         xShFA56QlpC4FzoTtF8E4MTmt6UpFC0jMX2+bWmcCBnZJUjuL2d7f9amulMh+bPxn1vo
         9yZbiJZRexoQIc3Qc9TIO3dPOqOKL9ua5UsJlLtpwC4mUNrdQlvKNIClY8rZMlWK+yp0
         YFf2TFM6+AcCob7rlN2yHpAqrYF2O//wECb8GDQ89jKmmPEfiHnDCjJm5KkIdMR8RRYx
         iZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWha9F14UC6NFCeX2zI27tyfSySsuTce5WH5Xi6ZYm77ByRJ3W9uH0jE2fRlMtUq8+73RZm31mkwLyfm/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YymXK3vHIUPMLdePfnS9VUTzvIzuoQsvlRwVT0YBmEFM6LxrVFS
	AIGcBFCKt4APhyztbgZzpSOx3ngyPBErT+TSSYHoi+DxLX24qLkxiTuiS/8zw+hB8fxrTPQgkPO
	a3nn9dIvPacnCE1K0HGUvWjpYMaZXqfo=
X-Gm-Gg: ASbGncsVCFxl+0O7gOHVUHr8htEQMjY+ATpAWuDfs6grpwZdAaBEFUjqMuEsncuvcFb
	LvSGWHzHdCeqC2tIpSoANHSzLXzn+CA42yfXkxLTzzmu0owqK3gDBHjO2jik+4PhDOyzms9NO/t
	bu8OloiQFhOElCJWWnjLFXKcbsNVK1TMWYxE650i2F+/2xrTvcxl32HnW8zBSU8YJdVxM+FBdOx
	bKsXOC1iZWml9sRPAOZgc4wfA36MN4=
X-Google-Smtp-Source: AGHT+IFUhuOPjVShvojOkNORDYcfkG57tc9JbnsqTlVqa/OxuLS0gKpps2AF9XTGawbbJ00RZIwVZzT6FP4bEoy5EmM=
X-Received: by 2002:a05:651c:25c3:10b0:375:ff2b:14ca with SMTP id
 38308e7fff4ca-375ff2b3d44mr1356781fa.27.1759819519490; Mon, 06 Oct 2025
 23:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
 <20251002184120.495193-4-akshayaj.lkd@gmail.com> <20251004140809.5a629545@jic23-huawei>
In-Reply-To: <20251004140809.5a629545@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Tue, 7 Oct 2025 12:15:07 +0530
X-Gm-Features: AS18NWCGzbZGMO__XelRr0HqcxyMv3idbhYrMuheU6eMEKCXIpK12KX-yXcub3s
Message-ID: <CAE3SzaQGb_3a_Q2DFwNT2_Vmxwc+vLvYfZHOwzLtOQ3nV3GoYQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] iio: accel: bma400: Use index-based register
 addressing and lookup
To: Jonathan Cameron <jic23@kernel.org>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 6:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> > +enum bma400_generic_intr {
> > +     BMA400_GEN1_INTR =3D 1,
> > +     BMA400_GEN2_INTR,
> Given the values matter, specify them both.
>
done.

Thanks,
Akshay

