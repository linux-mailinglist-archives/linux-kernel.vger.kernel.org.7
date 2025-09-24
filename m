Return-Path: <linux-kernel+bounces-830877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03435B9AC46
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A539B17C63A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003AF30C0E7;
	Wed, 24 Sep 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="MH/NzWFm"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE812FD7AE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729033; cv=none; b=M691Ffb+hHxHDw1+U/rkcjY+yZhdqdfx7qUzMUjhkjPlbthXV5A05mqnCQxBCPKwzTy3BnH++/EG2DlssjcU8QThPgI/KFMuaDwZjLmOfskG5XYQRHLIfrhxq66QBtDRBSyo6bL13TSvYZT/+tPxbf5SLnwbjBJdHBnrdt2wUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729033; c=relaxed/simple;
	bh=3HFVHU2A86JsxNXWuaSgCTlzKZ3pf22FDrMEBP9wlaM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNaf/3DwrA6R+ah/xGc4v9z7CxnDlR4nsZNmx3HWZXaZ7zNhGzrZxfSojV1M6gmbU8nH7Io3ZVLrDajyZ6kDNsw/cSKe4shOUvwYn6ktUBdlfaGRBNaLWbvUVkRpSkL+iHwqrWxb/HOO7SILncu+cy4kpF3madJWJPb9JUad3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=MH/NzWFm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4c88e79866aso29910661cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1758729030; x=1759333830; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wKYKt3wBpNWpKAvLvz/Y9fS8qlda2gni+8GdP2SiBRk=;
        b=MH/NzWFmMK66WDJO0EcpeK4YNLynWzOQlyauaqvCkKb3hlA0JQn91tXAOyzlwp+b+o
         +wo6IafMnp+3aS9zFGtnQKugNM3uebSQZJ/ab30xfp5WBXV2fBzdPTbd2Gn64JC1wJMS
         mtLWtCQxbfwh9gO3CVdTwsorBka/UWYstT1vjOplFKOgKdOV2XHRFJ4dlv7G7/B3msSu
         oLh54+K20hlX3OY4CacgIe6uSMLi77toaBXRIjX9yBgwYA2vnr1cNv+vIjNrHIqZIlAK
         qQNmzgKhITzTwRRweswLiC5EqsUCB01mTUwvzvH1OKnbkcAEZKlqZadqHGJeVIAvewxX
         QPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729030; x=1759333830;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKYKt3wBpNWpKAvLvz/Y9fS8qlda2gni+8GdP2SiBRk=;
        b=NZDfS1UeS8iWBYSP7Ldn7s3XUVVZMkhsenJhT+gHgRQRZ6x2rg8OmR4unOPoQu7tsA
         l8P7OoxnRjVehUId0Y9EMM1zrZXxso8J1yhgQjiEi/ejBb42Jz8uOcrAapafe3uO/M2P
         RZlDMMMuWvlwjcZ5bRHMxn+HuheuvJA/fBoS0hZEnu6VLCkTLOQqkOdbwh00TjP42IN0
         uIbFnBzftQrLjrwabytDPFj5eB0o7HdkSFT/ma+mRLFf5UOoERuz3aX/K8VrcwZPbh/L
         G75k13pPk51vmPKg4eWwSXJ7wXvhB5I7m2YAT2zb/XsNhAWJtAvRi53FooI+5phhmpcw
         F5Kg==
X-Gm-Message-State: AOJu0YzR+/lHi0rIlQmnQyuLF5hglPpYuqXl8a3YQ+6PPxILd0lUMI1X
	wxT75RSJCq6rUubStXAPVrvQKAoQSMbdYj02n0EjodBY6Pw+gRbAOyIZWoDwPz/PElI=
X-Gm-Gg: ASbGnct8SBwDXecMAtKu9F5Tx9isMen9J74Yfd5SkcaI+UyoJ8+hiekUwMb6nS4G0FY
	W7nvNevSdRYpnq9QRUiBJovaWAKMJ1TrIy4s1y6g9WnEmK7W1ZLbiAeVm5tTs6EKwnzmqleZBc1
	239qLLDKLM3B+SH6Xvi4MloVMjJ/tMh7AVHMDsEs8JhI58DVtWTnL9UeaZpEWWhGsZdpH5ScxVw
	Curca/Ndqiz1TpV7jVjD5yyQ1atL8oAUwLWLnqJuoEzTfsHc4nyDuCQYU49mc4P991Iid/otxtC
	JIt87UTKzTDEbc3iYGYaej6LLb4oyOPajFuF9ewcX9WHsarR4R8po9gMyLQ+eKp4qyr1Shd0Iob
	JjCijgn2SnAlx+mJafgSCqsGZZIMW
X-Google-Smtp-Source: AGHT+IHFDw/Eg5JWh7qPZieLyWp9NXunBGjbJijvunF0rhToS+dVyRBZ8XDISKVOXGkGM4owfaf9Vw==
X-Received: by 2002:ac8:7d8e:0:b0:4cf:b74b:e1af with SMTP id d75a77b69052e-4da4c1aeacfmr3705331cf.63.1758729030340;
        Wed, 24 Sep 2025 08:50:30 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:ebd3::5ac? ([2606:6d00:17:ebd3::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79351f713a5sm109494106d6.44.2025.09.24.08.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:50:29 -0700 (PDT)
Message-ID: <b3c3a9b47a2075f6a0acc1ee501f885d4997679e.camel@ndufresne.ca>
Subject: Re: [PATCH 1/2] media: iris: Add support for QC08C format for
 decoder
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Markus Elfring <Markus.Elfring@web.de>, Dikshita Agarwal
	 <dikshita.agarwal@oss.qualcomm.com>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,  Bryan O'Donoghue	 <bod@kernel.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Vikash Garodia	
 <vikash.garodia@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 11:50:28 -0400
In-Reply-To: <ce08ae79-8f7e-4a37-85b9-d86c10567881@web.de>
References: 
	<20250919-video-iris-ubwc-enable-v1-1-000d11edafd8@oss.qualcomm.com>
	 <ce08ae79-8f7e-4a37-85b9-d86c10567881@web.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-BGkOL5lJ8hoFaStaZV+n"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-BGkOL5lJ8hoFaStaZV+n
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 24 septembre 2025 =C3=A0 14:32 +0200, Markus Elfring a =C3=A9cr=
it=C2=A0:
> =E2=80=A6
> > +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> > @@ -261,7 +261,10 @@ int iris_get_buffer_size(struct iris_inst *inst,
> > =C2=A0		case BUF_INPUT:
> > =C2=A0			return iris_dec_bitstream_buffer_size(inst);
> > =C2=A0		case BUF_OUTPUT:
> > -			return iris_yuv_buffer_size_nv12(inst);
> > +			if (inst->fmt_dst->fmt.pix_mp.pixelformat =3D=3D
> > V4L2_PIX_FMT_QC08C)
> > +				return iris_yuv_buffer_size_qc08c(inst);
> > +			else
> > +				return iris_yuv_buffer_size_nv12(inst);
> =E2=80=A6
>=20
> How do you think about to use a source code variant like the following?
>=20
> 			return (inst->fmt_dst->fmt.pix_mp.pixelformat =3D=3D
> V4L2_PIX_FMT_QC08C)
> 				? iris_yuv_buffer_size_qc08c(inst)
> 				: iris_yuv_buffer_size_nv12(inst);

Please don't, this is less readable and have no explained technical advanta=
ges.

Nicolas

>=20
>=20
> Regards,
> Markus

--=-BGkOL5lJ8hoFaStaZV+n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaNQTRAAKCRDZQZRRKWBy
9M4hAP4xMwFl82DVj9T4UD6n+w1SjuDmzrNmUl3WHwoFFThJMAD/de71Hs2BOyqL
rqF9js4QRLUpv4wRTLhyGSuePA0+EQ0=
=v93q
-----END PGP SIGNATURE-----

--=-BGkOL5lJ8hoFaStaZV+n--

