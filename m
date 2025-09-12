Return-Path: <linux-kernel+bounces-813183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB1B541B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18256587E74
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29326980F;
	Fri, 12 Sep 2025 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC8mBrKf"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8378F4B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757652035; cv=none; b=EdwB8zlOjuI5iFso4OcbMGFo3MM3WYpWggmGqqTfNG/s6/DBjkNIUPLiaro2BpeKAX0wcnFco6PGwCetB3u/w3szTpAo5iaoaJmRyBJM+2sQJAZzGp4hvZ7h/5aPw0fW0I37sASSWr+S5C8jxNFln9/UxxSnGGAd7+1erCAYOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757652035; c=relaxed/simple;
	bh=JnOJEtY+4oI3dkX6hygsdXN4IOFa6dvROTGR7RWiews=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdLakAYDd0jk35f+09OfVkBziqHEnk+kwWXIZv3McxRnRooIXW+PSWbHiTD3dQ3S5ln01WK5/cosmmqHhZgBYsfGicR7sUYKAQvNYUTFtMLC2YU4u0hW+1koMtL1bF0aCaj0XdYnhCVpS/bziKShtMx/LSLpvoAKG1cIJZV6hbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC8mBrKf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0785be64f5so427139766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757652032; x=1758256832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnOJEtY+4oI3dkX6hygsdXN4IOFa6dvROTGR7RWiews=;
        b=JC8mBrKfDi/iIlj8wB8Qmsq9Hoc2xJG+q1zh9JctvJBUVZiyzNSVPs6i6QlRYBuRNB
         V6dp6oOii59EGXDgNWQQOsbHI3Olsejg3yKAF4CIe/zanjleiSdEsX6X+Uy+gBc4kQbo
         YnYmD8BD8i0qWDJJhYj8rjzoQxAISmgQWTY2Qb/iqb/3aYuI3EbZGYm+d8sirDR5p6/+
         MWAt5T1Op0d8pRRAe4rsmDa5BrD9erSg3QDvSMf//X/Ygx4YCYqcxQck1SCKYHflKCsR
         31ZAcdEy/RsasVB5yTg9ZlgccpftOV3jx6W6nLhzYy+XwwMiTjXf/xwm564rb6nyhPlK
         KciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757652032; x=1758256832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnOJEtY+4oI3dkX6hygsdXN4IOFa6dvROTGR7RWiews=;
        b=rw/cx1ntL5xCUCVSYkmdk2c3fJxDMqTDrG2h5hG/n3LVlTERn3PT7H9AD4z560z6T7
         1/FeNX2DE432my2dpqC9YaZTeutEJ8JO627kELt4zwdk4l9NUT0gKUB7xccEVUIxe8uw
         bGceUwHq4yailzgqou4l6D/yIH0ZCFnRcu85UgbwJgfV31sNMqwjvdujL+g700vT6SGE
         DmuMw6azyozDTDBJb4ux3i7KBEWUP1t2MP4fCF6WGo+Mu3a4WYmDA3PEDVHjNlQQQSQu
         3xc5qb2UoJ9rP6ZRqAaGLMtqD7lTJY3oLMW2RSqZ4d7+/j+wHmZrjl51oDVGazyEz1RG
         C/nA==
X-Forwarded-Encrypted: i=1; AJvYcCW2aJzRQxHaLtAOQgJSDtAVuDshp4Fl7xnQqbuy8HJ+qDlkCeHyIWEYaa8TbpnuLfHlgph7MwbTclxOqjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqARGCFKZMq58ZN7RT/It5Zs1hQ8VgJ5c+pmQO1EpyapAY2Gz
	L/ZWEYV4qwUitko7VDTvaLqQ+uVVkS2fXDkQ5rM0OuNFWfNNLKqAldsZo2xyeRXLdtrQ+LtAm5V
	t9IXMFuCoKiolZPn/Ehx531brsAsBl6U=
X-Gm-Gg: ASbGncsa/CjcDHr1lSXvpdsoIpgJWxUpDPcUaKF7CQUaXTdTiMiH7WI6eJsWRhgisui
	raIj8FhbN8ikCEzvdukZcuOK0hWawa6bTvWFYS2+MrCibDeofqVlYYf07Tkzk/z37Z1WxA4+R0F
	FNAuHIfwh9EeM3qbiGgD0pmfYRpLObyN+7CwimSvCGgEdt0VeR6jLR3ErZjlaIaSyNY3OdpHvDv
	PPN7E4=
X-Google-Smtp-Source: AGHT+IFrfcnrpMLV/t/LzuVFjBmS4lyJP+lzg+q2uPkMoRZmooYUhr/7XgxZrK/LZBQ4oKfXikDeXrDmovFmxBLs76g=
X-Received: by 2002:a17:907:97cc:b0:b07:8930:b09e with SMTP id
 a640c23a62f3a-b07c24fbb4bmr175250966b.20.1757652031494; Thu, 11 Sep 2025
 21:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-3-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-3-b09f492416c7@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Sep 2025 07:39:54 +0300
X-Gm-Features: Ac12FXwkkmmo9DDKVMvnCsQpKMsHCLWHUjcsGaAij9tSRV7t8M9EQuR242A3AIs
Message-ID: <CAHp75VdVUOxkKhiheujAK0gjk_GXGqQ0g=LhNDjZr-Of1gH=sQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] iio: adc: ad7124: use guard(mutex) to simplify
 return paths
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:42=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Use guard(mutex) in a couple of functions to allow direct returns. This
> simplifies the code a bit and will make later changes easier.

From this and the patch it's unclear if cleanup.h was already there or
not. If not, this patch misses it, if yes, the commit message should
be different.

--=20
With Best Regards,
Andy Shevchenko

