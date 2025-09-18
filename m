Return-Path: <linux-kernel+bounces-822873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C2DB84D90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780437C0B46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0415030C0EB;
	Thu, 18 Sep 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="o9epKl2Y"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8030BF71
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202296; cv=none; b=issYEbnB/uAOpEDBDdWHHeUby/XG5CAL1H9um2BIrVZUiIOWqjRBgoDtPO1dur+dgC2oxHPHL1X3PubXNXb6o3SuTfzOQy7KTUOp7/ft5wcy0MkHcc/v5DeD+Xo2ditkCOjQV/JWBtgDTsfOo2hIOSzdRgfVppICr7vX2z85yn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202296; c=relaxed/simple;
	bh=qPYv2m3jnaBv4/l/HZ0iG3MFsl4uuoIjun6WjOr6o18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sF1e9UmhUDPahg3Ll8RM1KyW0ifOT57rCqFhDkI9RCibUdSOJnp5DcwNg0PeOBVtrzwpgUjUJK+pwJloxUYfG6f4Jpw2Prd4u0muWZSJEcJuoZ0Ssmx97b59B3nObgqpERQqYS+6xcBrNN4D3ImZg0Jx6FoJm7pmAqLITFVlG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=o9epKl2Y; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-827ec18434aso96988785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1758202293; x=1758807093; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qPYv2m3jnaBv4/l/HZ0iG3MFsl4uuoIjun6WjOr6o18=;
        b=o9epKl2YKb7F2al2Yi3aNrsPu3ORw//EycCK8DgCQ1s4chfkcZ/eS+wzVkzChPU1dL
         mPXCN9rRcxXpZyUMIjEmkMTouxl/KU7RZPukLwrvFm2DniLnW3fH90qGqFRZ9i8NM1we
         DRgIMwU+q/TnvoTMR0EqLdbKWdnLNAta4fBbBBTL3a9jwcATJ/mpBY+H6Benv1nLyZ2h
         9mtU/dOYro8vnFAhrVTkjDbw8obXqpXfIk0jJYOLa/A9Ikpx6w4qmVxVQeSHRMgg5Dxr
         dcskw39a1K/YgB6tl9OagxNKK5typ67md/0vDCqBbtBNkC9xu2BidizmkHfpw3gWEEBT
         bjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202293; x=1758807093;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPYv2m3jnaBv4/l/HZ0iG3MFsl4uuoIjun6WjOr6o18=;
        b=HZeqD8HFSvhenPJ8RwxrGFVrme455eqVSg9bzNE0icLgYUdywmUWU7bo+3ysDBugwY
         B8fHm64tyHgSVA+7caNTMJUPXQyvuZwjag7iy3bsg22hBXPofIeX2cYXKj639nrYMVhO
         joz4AIAUEeC+yoCNzPeaxtdqfpTfiBmxWBOOM4zW21x5lVjcU4mrln2+GU3FQLbiVRCh
         Dj0m984drItzuKdQk9xC3PaUxQc54iD+FuZT9AX2cNPVMLjZj5dhGYEjYgo037qg/nM8
         HYGELOTz5E7yp06eeglEDkd5mFNzO5isS6KN2gvW2WPh7bOJFTrzCfD5+yC/+46iB6GP
         CCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNNpZ/p4lujtiNy9i6Tcj1uPJHfjdiIczLrh01OlTOAOiQaQcfcdmUjm79sRE6V+VLTBIKWdlK20DQdeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bTVHpjTUYMQhKmCkOsGHOKc1JDZBoMs30glH2rBIxEQPqb+2
	murebZVH9G8i5ob6OoAl5T7cF9iP3lCpMSvPWsl4GNSxBLA8Oze74Se6QCBmCWVWzqI=
X-Gm-Gg: ASbGncsZdPrunQoGZ19j2wpWOU4SRRaKKXSuFbS/LEZQDLlXLvfagOkUxSL1Yx5R1Na
	1o8+/Bcd+SXRxetjBoOuvqY3oexNjvIJyJ2D/PODW+CpDXhWJq/dcGo9Rv8IImftODELTPop6xB
	blfBezc7dbFV4pqmJXwYTXwJLSzTlEpmJFUNlNilBHhVBsjZ5sE1qyx6oT60qnsLn8hzMG5G/AA
	9H68PKHew8xkc6zc8QuCUr/bI477Vpnn37xRcRlU/fjP4q8cGQtvh49dVu9qWnEU9LJC4CZ0nGY
	PpoEbvdRzLlacp22c7BBa9c3mHt5UWfhudxriVELoEHNKTMhIPiNzWJCDja1p3CJ+YBkXPkhbM+
	sCl8S7+ZcTGgu3XUN5sHfyad5IBbY5lz8NuqDvQSv2Ctn4TcRhkGt6i2qUQ==
X-Google-Smtp-Source: AGHT+IEZMrFSL2BRRPxtTOKjAWDW7xdTVpOSqOm+sRqPhEGgZKYSOVPXEdh1+K0ZhOlHemb5x0jKfg==
X-Received: by 2002:a05:620a:170f:b0:812:afec:d5b8 with SMTP id af79cd13be357-8311186d1f5mr581762485a.52.1758202292862;
        Thu, 18 Sep 2025 06:31:32 -0700 (PDT)
Received: from ?IPv6:2606:6d00:10:aee0::5ac? ([2606:6d00:10:aee0::5ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda8998eafsm14022101cf.31.2025.09.18.06.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:31:32 -0700 (PDT)
Message-ID: <3a9f613bfcc560281d7287ca2e411dadcac745b6.camel@ndufresne.ca>
Subject: Re: [PATCH v2 00/12] media: rkvdec: Add support for VDPU381 and
 VDPU383
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Diederik de Haas <didi.debian@cknow.org>, Detlev Casanova
	 <detlev.casanova@collabora.com>, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, 	linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, 	linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
Date: Thu, 18 Sep 2025 09:31:30 -0400
In-Reply-To: <DCV98UFRGHAS.2DGZOEOVN9WNX@cknow.org>
References: <20250808200340.156393-1-detlev.casanova@collabora.com>
	 <DCV98UFRGHAS.2DGZOEOVN9WNX@cknow.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ka8JQHJLRBiB88+7XTFU"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ka8JQHJLRBiB88+7XTFU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 17 septembre 2025 =C3=A0 19:34 +0200, Diederik de Haas a =C3=A9=
crit=C2=A0:
> Hi Detlev,
>=20
> On Fri Aug 8, 2025 at 10:03 PM CEST, Detlev Casanova wrote:
> > These variants are found respectively in the RK3588 and RK3576 SoCs.
> > This patch only adds support for H264 and H265 in both variants.
>=20
> I tested this on my Rock 5B (rk3588) with (ffmpeg and) mpv on Debian
> Forky with sway and I was quite impressed with the results :-)
>=20
> In my earlier testing I found that the classic BBB video made for a
> really good test video and it played REALLY well. The 1080p version in
> both x264 and 8-bit x265 played without frame drops, although when
> pressing 'I' to show video info over the video it dropped some frames.
> But that never resulted in any visible artifacts.
> On the 2160p version I did see quite a number of dropped frames, but
> didn't notice any visual artifacts. Maybe that it got displayed on a
> 1080p monitor had something to do with it?

Sounds like we have "correctness" with ok performance, so that is enough fo=
r me
to consider the patches. There is few things that are not implemented that =
could
explain lower performance compare to the downstream stuff, such as the lack=
 of
AFBC. It will hopefully come later, giving nice boost when doing GPU stream=
ing.

>=20
> 10-bit encoded x265 files (still) resulted in a completely blue output,
> but I have strong reasons to believe that's due to 'missing pieces' (ie
> NV15 support) in the rest of the display pipeline.

Its still quite early days for NV15 (and its derivatives) upstream of
everything, so I would not block on that. It passes the tests when we read =
back
the pixels from CPU I believe.

>=20
> The displayed video seemed sharper and better then in my other tests.
> I thought I did see an artifact around 5:50 when a big rock almost fell
> on the little animal. Looking further, it appears to be an artifact in
> the original video :-O (I saw it also on my AMD GPU on my amd64 system
> and also when using software decoding).
> The fact I only noticed it when testing this patch set is saying a lot
> ... in a positive way! So I'm happy to provide my

That's it, your video watching experience is now ruined for the rest of you=
r
life :-D

>=20
> Tested-by: Diederik de Haas <didi.debian@cknow.org>=C2=A0 # Rock 5B

thanks a lot for testing,
Nicolas

--=-ka8JQHJLRBiB88+7XTFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaMwJsgAKCRDZQZRRKWBy
9IXzAQDaymJ1abHUHsMNbl/WYGVN2REm08PxhqTaHUsWwxU6ywEAy2qLFg4QWHSc
KidAMEhUNpEK1hwZcicsIl92zBbgPgY=
=H3qI
-----END PGP SIGNATURE-----

--=-ka8JQHJLRBiB88+7XTFU--

