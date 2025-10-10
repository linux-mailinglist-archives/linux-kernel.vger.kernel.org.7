Return-Path: <linux-kernel+bounces-848393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3BCBCDA24
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FA03B5438
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0492F7457;
	Fri, 10 Oct 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuzBevIT"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E32F619B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108149; cv=none; b=OJ+wbv0VABa+QGPNIvzDuVSyqQ3QSLZ9p02fvOVAnwNeCGAzw1Tf9yjcj3tKwRFLBT5ntVsKTaWO77B+01hixzTqY7wfU9PWL/55jWj4VutW6DgcwZTmSj00waAnyqfA1P14lMex4JTmNf4tvdXUcrCaddsYxqxx4cpA26dtQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108149; c=relaxed/simple;
	bh=6+gv/w4gUrEGa/XwIA7UjRaNyK0xz55jWAx88AKH4d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvikiZtvBEL33pWmwiOC42ceoYTSmvrmiFeDNn/BS07v7vFqcUwe7dtnZykLjuDRex/TJVp+8r1ALFcH1r8t9HvU0BGWPGYzgcySUuI0Chg24aksDBZqyMnUWy9ABvehlEruMv+svnuA0t9X3fhX/ItMC4i6a9KE4DfG3P5w9sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuzBevIT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3b27b50090so404219366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108146; x=1760712946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPLbWNPxZc2wfvIlljRognyXQF9RLtB9DEHDg3spNS4=;
        b=QuzBevITHS31OVdN2VllQcYiL+rnhdB5KzRrFg3yC+uA2UeFtuUOwrdCyGSYtG5CwA
         WizpIrEYxHrW7EhUX7woeBmITUJhxv0qGcO82sB7ngvPPujgGm5w47KMDVe73x9HSSrk
         MCrD5G6L2L0bWMIYn9aMF6beAPhqgXGliE+y8xhEJWzrvNs1nkxQP6SLG6IpkofL1d09
         ZyO1oa9BnVgqEyYbUX2MDo6mt2MPMSIDSXlGwjrCNwyRP73wjBuI3ciokQ+zjwt1hmmp
         +pVvoYXo8xG8NPZ7To9kDrWjNogGs6Cks6QrakW250lG2HaHxQLG5N4+NH8ueqH7Fr1U
         IWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108146; x=1760712946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPLbWNPxZc2wfvIlljRognyXQF9RLtB9DEHDg3spNS4=;
        b=KeWMxf0sqFWVOqPQ32/Zny0ADVH264GRdyRnwg8vJka/0IDzgCdFFRlOIqGVehNvMj
         mJ760z0OOXnRPsoNCo/Ct/7GgytTNiSdUmfie/pXZxfhAWBYu6AEW7F26GBctLq2nPWV
         MM+N2cZX4ZTrQnWmumfEgJMB08ho+1WPXK+Xnr0tjY19XWGBgousoe7jEOwZXbcKaPvA
         UqGuH8rFF/F/g5y6EDpgvoMJAzqu+ovf+MPcqEPiSSobZZ0Z0viayKaIc50bfW31ehcO
         Z1PX0mfsD67ECwl6jbUnf1gR45m7J8iPlxSoo0hXNqHT2aDo7Za2NTbLLo5J+8NnJzU/
         D/mw==
X-Forwarded-Encrypted: i=1; AJvYcCUTX1bZbp6E7HcwWKF/VNrZHU9tVgHsJFG/eycEHM4vOy8GAEXx357gckX7s2X8IbzlAlUctgllc+uqIVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpMya3K9aC9+MzPd/5fKzAQ9cLGxmkxRp9jW+dwpgmx4vR7+T
	+6yhpTt/UbSD8XZ3bgMHyRFJ/PhjBRb+r3ZC91T7SJ3UhjSEKKaHu0SAmgvw9nGtn/9Hr1qUvDL
	oIAp605IZkYVENio5loo6cge+xPy6HFM=
X-Gm-Gg: ASbGncuyLtDaVF0CAUBcspI29vyf8h8pY88rjdqmGFVl81F/hbktaUjgCg4vFexnXVX
	E3qUPktH9auZIE3h6yVz9vBb306iHIlJWOtsIz83bWPfcnFXAwNCkbjxFEV6h7hRJ9J89xDP4ww
	BCx0QNWUj8B8rST8DcVbeP4CzHioWAQ3MWoswA5xjJ3iS+HTG9k3+fuVjGg2AgAO8T4spb0XPoR
	4udgAhB/8AxCl5GCvqe+QeH+yIdxqUyhO9Z
X-Google-Smtp-Source: AGHT+IGkvwFBFghkv/zq53Sv+Yq1LeqEQPVseBK8uEWfs8vTYsR13eTVsDsXGa4XRQtqexUM4bBgzRzSTpZwrJqX1DU=
X-Received: by 2002:a17:907:e8f:b0:b34:985c:a503 with SMTP id
 a640c23a62f3a-b50ac1c34c9mr1122595266b.35.1760108145750; Fri, 10 Oct 2025
 07:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009173609.992452-1-flavra@baylibre.com> <20251009173609.992452-3-flavra@baylibre.com>
In-Reply-To: <20251009173609.992452-3-flavra@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Oct 2025 17:55:10 +0300
X-Gm-Features: AS18NWCWhWCW7KSsOItV_xEhoRQPB-J80xRVLRJuJLRllK75wOUDTJXaeqkV6Ug
Message-ID: <CAHp75VfOfeS21=5SK6Qa9Fc-WQdjDkz1ecoTFrk=hT1NGGt0TA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 8:36=E2=80=AFPM Francesco Lavra <flavra@baylibre.com=
> wrote:
>
> The rate at which accelerometer or gyroscope sensor samples are fed
> to the hardware FIFO (batch data rate, or BDR) does not have to
> coincide with the sensor sampling frequency (output data rate, or
> ODR); the only requirement is for the BDR to not be greater than
> the ODR. Having a BDR lower than the ODR is useful in cases where
> an application requires a high sampling rate for accurate detection
> of motion events (e.g. wakeup events), but wants to read sensor
> sample values from the device buffer at a lower data rate.
> To support the above use case, add a sampling_frequency sysfs
> attribute to the buffer directory of st_lsm6dsx IIO devices, which
> controls the BDR for a given sensor independently from the "main"
> sampling_frequency attribute (which controls the ODR); introduce a
> new `bdr` field in struct st_lsm6dsx_sensor to keep track of the
> current BDR value, and use this field instead of the `odr` field in
> the code that deals with the FIFO data rate. In the sensor hub
> driver, make the bdr value always mirror the odr value, since there
> is no separate configuration setting to control the BDR for data
> produced by the sensor hub functionality.

...

> -               *max_odr =3D max_t(u32, *max_odr, sensor->odr);
> -               *min_odr =3D min_t(u32, *min_odr, sensor->odr);
> +               *max_odr =3D max_t(u32, *max_odr, sensor->bdr);
> +               *min_odr =3D min_t(u32, *min_odr, sensor->bdr);

Can we get rid of '_t' parts at some point? Or IOW what is the good
justification for typed macros here?

...

> +       ret =3D iio_str_to_fixpoint(buf, 100, &integer, &fract);
> +       if (ret)
> +               return ret;
> +       bdr =3D integer * 1000 + fract;

MILLI?

--=20
With Best Regards,
Andy Shevchenko

