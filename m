Return-Path: <linux-kernel+bounces-818548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D845B59323
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDEA1751A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C3A27D784;
	Tue, 16 Sep 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjVktaW7"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D32BE655
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017798; cv=none; b=VnrEE5F6K3kLTrFGauAYHulJtSsn7LqO8K2f8+trvnqrtu7zf0cvvRDq9h5tFkGEnbN6mi6Q7KtIVda5bMFeHUJwSNmaVGGeE4o0VC24/rIngpC9WIBTFShHPbp2/D5Q4paQch21W/AbS+Hm0dtu2DU9Qw87MT9Ftm4JyLFoxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017798; c=relaxed/simple;
	bh=VmZzhETWZwgrAXAyoyBia2dF4hbrFav1Sum4dtojLBk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UTqQAv+T3Ue9NpPZXFyj2XqenLPd7UwGu6F39BB1zhSPRqLK+d3HorgTqusajtTVXNaRdHluHHXinnbtXSQaqoelLBVN2pMVvXdRYRkXXePcGfUG/4os2yn0/6pC2wGQgBtzqz+kYY1V896BxUZUSt6uFFV0aHhxqmQgBTOHgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjVktaW7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ebe8dc13a3so938004f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758017795; x=1758622595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VmZzhETWZwgrAXAyoyBia2dF4hbrFav1Sum4dtojLBk=;
        b=kjVktaW7AZ99MOW897CGo5btfUWpf5Fb98oj+ECi76u3iIobYRNGf4/kp5iYe88+m4
         l06c4S0s/HwgcG0VGt/bOg+Kh4Mg+hrrkEkQbd6/RiTatzJgztYtinQcreZIwInaYVb0
         i4TwmOmdUl3xmVqHu0B9mUsU0DadHCzsFVRr6yNWrgvz6247d0R0315jjSMqaa0UpA8Q
         vFDv5+W6hkH+8AlQYGqO7fk7Tg0S4xtlA2TTdckNufDJB+jzxv1Zq/TBTIamnUGFb0M5
         k0Osfkiu9QbJ08SjvbkM6Vi16tA1w6NyBLIaEqRGW7+/VKzKdGodA1CrT9KOrOQJ7FTt
         ZyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017795; x=1758622595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VmZzhETWZwgrAXAyoyBia2dF4hbrFav1Sum4dtojLBk=;
        b=r9kF+dNZ63ou/25iW/jqaWLkGuvYUHqxV9M/1IDah13WNUJhcYrqHcO9Dp1zBX6H+w
         dsfbrNo3z+IGjgdteTbXqRVwSVfssEwLWnJU7HMhzRi/cqY0uFMhwl9OVnN1qcAL6HhB
         UEbb7l7b/1OzYQW+WI9qh2nMP5cDbkdaE2IIFVrJJjz0mvsNwBe6B3zVi7pL2FV+EWmk
         vPonlNa7nA7ingH6Ca9ScFWvU5LOsNTKOH+0nswW7bO3NSGzSt128IaaHsYYiAfQmXQu
         ZbGnsoxb78NJkmLAVyZr6phN6vXZ6Ie/A9wf9KSFysme8/SBrVNm0JQRSUYkid/OY9gh
         X9NA==
X-Forwarded-Encrypted: i=1; AJvYcCWgqhSRJq4LUetl3Qkp4ZT7EfpeoGQi1Rr9Nlyarz6581xMTgY8p5Na0FCrgXEj7zldWuSEtuT3P6afUT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwXsY3gIdxd+JjHZhNL+LKEVyFgI/+0AR35ptxmj7dRT2XbSl
	CpR40G47Bp7bNFNmepRxftv6BQrQSFaZJuxl+1x/e6bCuwqQQZuKP918
X-Gm-Gg: ASbGncvmOu246pcGr1veUsogTQ3mPb6Ipu79Q0O285E7gLRq4+Mnv6nkwbvgeyjZ8kF
	KCI4l4D4s5J/OZyTxNk04pzjXdCLjV3UfRGKHH1AG5FJqCacK0pZFBrfOW0GAjP6i8Ab2SiGFUZ
	OUIsO5D1eTaFgqsk/ch1B3yi4FlmfwVPZX8PVkPj2vC/GcJ9kDZCHDuIjEm20c0/g2L7c3fEMMj
	RmypYyrwpUrkl2/nH/QWS5T00TxiMyJeR64xVpTwRWCauj60CXii2PMjRxknxbvro2x7NINeVkw
	uL8rYX/0VaUuarHt7CQeyC8H5oL0BlhW+HHknNV49IABfBPXk8yvAtn8EQ4EUGuwvtLzbrwf7TA
	1VTFuNYWGkXYscLHnCip+qSRzFY963QU=
X-Google-Smtp-Source: AGHT+IEsDQnZ3ALRjZKNZkTIB6aa3ymyhHeIfAjtkOgrgqYBTsLvorpYR1r3Og+DA0Xw9SYb3SSGQg==
X-Received: by 2002:a05:6000:1acb:b0:3e5:d2f1:403d with SMTP id ffacd0b85a97d-3e7659e981fmr16107836f8f.36.1758017795283;
        Tue, 16 Sep 2025 03:16:35 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037b9ebbsm229691635e9.11.2025.09.16.03.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:16:34 -0700 (PDT)
Message-ID: <bb6ab3f73b6f18d7e8c37c28481a13a7808ba44e.camel@gmail.com>
Subject: Re: [PATCH] i3c: master: adi: fix header location
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: alexandre.belloni@bootlin.com, Jorge Marques <jorge.marques@analog.com>,
  Frank Li <Frank.Li@nxp.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 16 Sep 2025 11:17:00 +0100
In-Reply-To: <20250916091252.39265-1-alexandre.belloni@bootlin.com>
References: <20250916091252.39265-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 11:12 +0200, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> The adi-axi-common header has been moved to the upper directory.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/i3c/master/adi-i3c-master.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi=
-i3c-
> master.c
> index 162f9eed39aa..18597ba1f1c3 100644
> --- a/drivers/i3c/master/adi-i3c-master.c
> +++ b/drivers/i3c/master/adi-i3c-master.c
> @@ -10,7 +10,7 @@
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/errno.h>
> -#include <linux/fpga/adi-axi-common.h>
> +#include <linux/adi-axi-common.h>
> =C2=A0#include <linux/i3c/master.h>
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/io.h>

