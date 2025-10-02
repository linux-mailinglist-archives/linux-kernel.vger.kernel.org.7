Return-Path: <linux-kernel+bounces-840226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 855E5BB3E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7461F7ACC69
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931063101BD;
	Thu,  2 Oct 2025 12:23:30 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC273101AB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407810; cv=none; b=CzjGtAFa5WjA/Ei6dpUcDovK8N8WToG+vM1HwXajpm/Pz5iSn50WObkVWY/ELZY67gDgHT2hb18q73aCo6uCIV20bSbva0qUw4I21cc12RVuxUVgB319yngokYv0m723EOti5IUUYXQSzN/HUS/hrIUDNljnz184fqNqHfDZI8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407810; c=relaxed/simple;
	bh=gvmbEnM8Xq9x/tMwG+SeGSBdS/Mqy/IpPOizc/FKLiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBNZ+EcFQW2TiByYHLyfNWzDks/PyZ2tNqcx9iq4j87oFcIHZGsls9GTyvqJIzbLmdahVvhFdffoT6RCp5A/uXNGZlz8CxM6UsPLjg3pdlrOtPQLTE7W/Or843CwLs1RNiSSbvtCvpztUdgkvSGfqmR44brWZxpdpYNVGBbJwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b463f986f80so216282966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759407804; x=1760012604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQMLIxPrWBfFJ+so4wBwnJ1QOuXysLo+deF3cZFSCvo=;
        b=boh9f9fCVYHhvglU8LT+UPbT7mxfAP22PdUCo1i3FhDDM6MatHKvl90caXDNxVaina
         94nGCOd1TAvKDnTwtrJBgJp56nWSfCMOpWLejrU/gUGM9hafydohp0IaGdQEwgIfedFo
         s7im0ChQf2KQNerGDWZfbL7Kk0YHLJghy0s/gP0XRujhdo/dCEs0QuQ61OMw0gtA4/X1
         KbRASOk9BNwFhvgougypoMQL89RX6TJi5mxl+EVep0q6SgCnMEXMXHWNSq2lsIsj1sqw
         L81vRPz7v7r+J8FEdDW1GkKBVayYCVp83DD/QeUeHFmYPAes1SpMkf+gvXQmedoEgPU4
         nqlw==
X-Forwarded-Encrypted: i=1; AJvYcCU8tFfI1hMIjG+tB1yadaU/9FfO5DDbyl/Aat6mSKgbl93kNk38/D5UkgK1Gm8D0uVzD3MPNYpkAzPSfOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzagYi4nM89WV6Plxqz+2QUAlU7y2+tzfAzEfL8JEL6kyclt0Te
	q3m/ZTilCrpMpHavXKj4nx6832/wUl1lTmPg5miFBOWDyBxj0QxcxDukl3qctO4tekw=
X-Gm-Gg: ASbGnctauwjyiJEMk0AlIZ1zUb2UEMUbjp8qXQ+vVswX3RGJXMokKOEi729YoydZ4Ju
	V+VGRrzpKUYn+Q+VcTpNqBIgaIKD0W2RIXu9qf2ztGXBWDDi6uSQBcpSjSQDDf7XseiZuuSWa64
	XbFgcfH7LIsIaq1agOlUv8b3vkoxnru6ia+pjNCiNYtcV2uaahfZG4fQ8kHHD0f+c6HN0FxLtgM
	GNSinCtu/DxZ/xwImY7mPSpLUkgm2WTf2InyCIrvIY9g0oqNSqkMAFQG3SHEzRE/iOg4dv2S3Ae
	eDxwxCbDw2weAW06elXYToZ+tPwwacQg1nTVqgtY8U+/cbbnP3OQM+yg1ALobKq1LXkbi0wxsBD
	AQamG+Co9vJHm8VTfa5pSoDByCkL9/cdrv84bYOcUK6pK9yy/aSVNjTwl4MZjmH47h0ZJjQSY/l
	Rd8Ij6zJQmi/IZ5++EKtY=
X-Google-Smtp-Source: AGHT+IFI43vHVFOJaXyPgIjzqnTOkPbxekXgY44xGY9ECxGn0m+RFoI09EGHYo+JC5cykLIHbYPGJQ==
X-Received: by 2002:a17:907:980b:b0:b45:33bb:24f3 with SMTP id a640c23a62f3a-b46e6819037mr935472866b.44.1759407803749;
        Thu, 02 Oct 2025 05:23:23 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f94asm190537166b.79.2025.10.02.05.23.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:23:19 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso784653a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:23:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCo5X3IDp9xmPpUgKX4HADtAS7ttQ1l2GC18Td5dQbx5yPqxxJCzawaGcXqxPbSZULn9yasWkGiOp6XRk=@vger.kernel.org
X-Received: by 2002:a05:6402:31eb:b0:634:cb54:810e with SMTP id
 4fb4d7f45d1cf-63678c7b7f1mr5768917a12.31.1759407798672; Thu, 02 Oct 2025
 05:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-6-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-6-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:23:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXD9eUSJGNH0+naHSvf8MjqZ3ctdqFp8wkrMq=qY9Zaww@mail.gmail.com>
X-Gm-Features: AS18NWAfWE-zmoZFShiXGWGVfqa0891jOjlp3tuzjqrJNKFCJ5kcTO_xUtaAquY
Message-ID: <CAMuHMdXD9eUSJGNH0+naHSvf8MjqZ3ctdqFp8wkrMq=qY9Zaww@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] arm64: dts: renesas: r9a09g087: Add ADCs support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G087) includes three 12-Bit successive
> approximation A/D converters, two 4-channel ADCs, and one 15-channel
> ADC.
>
> Add support for all of them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

