Return-Path: <linux-kernel+bounces-797578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4188B41215
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28905606FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607C1DFD8B;
	Wed,  3 Sep 2025 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ijt8rJvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38481749;
	Wed,  3 Sep 2025 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756864263; cv=none; b=ApEXG2rUrANzfZwJMjklCmEAeIvaICgk8eOMUPi777giZkMs0BESj6LybhseZv/m02FFdIukmZXXfpLV+FC9SXo+x3r6Z3MkSLwqk3V4yfn0i/5zB3/afOoeS6jKH3dN+bL+1Ns6+0mjrIRqIm+huSGAc4GLOjFjJhoCqLqe7Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756864263; c=relaxed/simple;
	bh=UWnUSCLzGExhpc14PQ8sxyjjtdqvZUyY+G0CrAnF3jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3rRCbOEzdQBev9QFSO3HTJ43iYxOg+23JHBbcqrFUPvTosdQD7W4aHz53upuZmht9qjAJjzn4lhWHzuZ2mFT4UWMqPmRm20GrfKqGVLEurUtFRBl0F/oNBILgEDbdvrwIzP5zS5MTwaM/yhb9XbuN5iej+dOde0zeRv6hgIgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ijt8rJvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35E9C4CEF9;
	Wed,  3 Sep 2025 01:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756864262;
	bh=UWnUSCLzGExhpc14PQ8sxyjjtdqvZUyY+G0CrAnF3jo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ijt8rJvF4WQP1+v1wZZCA8bj4GDhjxHSbP8OuvuI9PveJWCSmnTHhaL3YwOvd7VTT
	 JW24AefzUoFrivSPVVHmYlmrAQ+mDMThV/slNJfdsmVnB1ciQzCzOtvJsmY4dLiAtd
	 EZ9LEXzrqGRVb+CpdcyxH6IAs0NgDqTPJGkrBoFDZH2XHxOvXBXIWw9c1aK27GrB2q
	 6iLyK91xmux2NxQU2LH0RWdK0pdRjfPKrPerrabLNKumenFaDCSM2Otv2HnwA5d0hg
	 KKqKdjadEpGtUw2QSijmjhK1mc4kw7VMcIZmuwIMSaTLnJQ/1RDA0kATl2Gs+LUfLp
	 6S8ZyAc2aUaWA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cdab7eee8so8348739a12.0;
        Tue, 02 Sep 2025 18:51:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoFHo+sRG3f0r+LENqD7IXq8XXx8Ra9goVcdj8nZ3+1wtLIfTENYkj5CXfaYWXS8U0MXbyqpDuo7G1@vger.kernel.org, AJvYcCWggmecfDsyka5f5wFYH6e4aorRZxAta9VU1HDZvRYQ7+JItbkgIpcFM1HCEZFQnnnnSZxiouiWUxXSp2oc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Ctv/ZCQx1sOz8S5Bzum1Agmut9dlIA5q6g5u0shPtcS9JSn5
	buTCjXjyBHuy/QSoMy9nJ47CDVE0p0QDi5mWRlEHLPs/uh81Wb5CiZOSeAcLG2jmILWCwmVjqH/
	bn857IptC8rJn8TA09TjGsSqSkV3lXA==
X-Google-Smtp-Source: AGHT+IFEzOKJp3CdAUlVBLekgFAfgyITfS2lG4F4nPimPGJmbDDqsnOTPnHiFjXPE6SnZ13guf6LeeqRUKJ4FkGPDkY=
X-Received: by 2002:a05:6402:268e:b0:61c:9193:a4c with SMTP id
 4fb4d7f45d1cf-61d26987b9dmr10334427a12.1.1756864261267; Tue, 02 Sep 2025
 18:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722171152.58923-2-robh@kernel.org> <5d7557f0-841b-45ea-901c-5b595ac8bde3@collabora.com>
In-Reply-To: <5d7557f0-841b-45ea-901c-5b595ac8bde3@collabora.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 2 Sep 2025 20:50:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJaC47zFY7zvTVFum9oMiV87dgo49a9e3HW1T5_vQtAzA@mail.gmail.com>
X-Gm-Features: Ac12FXzJRn6b-R8EkQgO1Kk-9Ab88p5fsgS_P7zt_q8WWK__4HS50sDm1CK_f1E
Message-ID: <CAL_JsqJaC47zFY7zvTVFum9oMiV87dgo49a9e3HW1T5_vQtAzA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: Fix out of range pull values
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
	Ben Ho <Ben.Ho@mediatek.com>, Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 3:16=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 22/07/25 19:11, Rob Herring (Arm) ha scritto:
> > A value of 10 is not valid for "mediatek,pull-down-adv" and
> > "mediatek,pull-up-adv" properties which have defined values of 0-3. It
> > appears the "10" was written as a binary value. The driver only looks a=
t
> > the lowest 2 bits, so the value "10" decimal works out the same as if
> > "2" was used.
> >
> > Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> > Fixes: 19b6403f1e2a ("arm64: dts: mt8183: add mt8183 pumpkin board")
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > This is just a few of the warnings related to mt8183-pinctrl... Mediate=
k
> > is #1 for DT warnings on arm64. And by #1, I mean worst. :( It would be
> > nice to see some progress on fixing them. Otherwise, seeing new Mediate=
k
> > bindings rather than fixing the existing stuff makes me grumpy.
> >
>
> Thanks for this fix.
>
> You're absolutely right about this, let me check what I can do (and if I =
can get
> some colleague(s) of mine to look at that while I'm away in August).
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Is this going to get applied and into linux-next sometime soon? Only
been like 6 weeks...

Rob

