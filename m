Return-Path: <linux-kernel+bounces-788987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D901B38F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03039981368
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D230FC1F;
	Wed, 27 Aug 2025 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aHuclbnn"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E62F5316
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756337937; cv=none; b=ZVixUitcF8cxD9dv8bSkpKkoxI2mNwL3D4NR94xTsRCM9C7maBYh6Vkp3ddN6Yot4juX66cGawgUrQNvHbuBUicGhIxj829Zz0vHB0deYK9U71r8EuE+kmi/yXfCLG94Wp7OK4th2SWYKraH+kx2Eafk+sRmLoW8ihXDbYW2ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756337937; c=relaxed/simple;
	bh=MNeQOS0pzr3dprcINe5o9nkq6nNaZGCx++2bS8YcTKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLP7WuVHLlGaNOKiHBluS0er1IjIPIsRi9Pv5R5yDM7Y31GiV08w6JQ+XpBtbUxliUzviRlT6V/sOPNIz1K67LQaPe8vJbhqkEsoenLhB4zqVlz/rCBGwUj2qll86hzFpRribQDRFSoRAu6jAdCwncUvtwCV7pD96n1NCUT48FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aHuclbnn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326e202e0so337634a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756337931; x=1756942731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4COsJov1R6T5+fEFFn1/lYQvnIbPTGcTpVNB4EmSuqU=;
        b=aHuclbnn5a8gZebPt1zWX/2qqIQzQpnexgouymDJ1Nu6UamXjImIjaQXRi7/A3oIec
         zoeTBu2Y/ZRWnLT5Nb/Nq3sag14pYhiOJiegFojNrnc6Rq7CEy7jrg3vvGzDBUyBBsOr
         dijs+WlC5ODkeERJc8UVWyrNLhyN1s5Wrms6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756337931; x=1756942731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4COsJov1R6T5+fEFFn1/lYQvnIbPTGcTpVNB4EmSuqU=;
        b=Cg7y5L6gW9nKKh3hGxv6KEHtkX2aI3+zRnZ+FO7FOO2DLrcUUY6aBf+KskeYtEYwRQ
         uhu1RtFV3zk4DL5IPraFLV3BoYLTLg6A10L5VXM/4xVZZ0FzYTv/3ITOTPX8javG+ng8
         A2KskgND0JA8sU4zpb/T+03w73MN/YYtPhmsWnIpxE+BhE8+ggutWuGsHqj8Prgjs64O
         4cIwrisPCBC2+AYroyxF/xX8DGlXbp5AfYI2RWPoV0N+mbsJOOjENvhxDP+6Zt4nAaBE
         lppEGuKZTF6ooxCWVF0rGK9j6S0TZeZtV/y1SIUAwIMHUkbM3v9UfoGUTvJKsugB6eMH
         6o7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU6fT8w3vNNPkKlT/FMNg6ItnwqUp0mOkSOxXamjGkOER4FbJxToYZa61ds9dFCqDYP1clSN5GB8HGjV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFMGIG5sR3nyDma27bX391Ra61rjGgAkChdk1YFFnVn/AB5mGE
	JTahqh+VpBXQEk3bvfeLniXkflga5ol3yhhPtMvyQRwWB7AQPl6JWnajJbMT9IXRolxTCVbpvX+
	H/nU=
X-Gm-Gg: ASbGncvlBAUrIoGGX0L9aJQIA+oczuiPG96AAlxAvX+vgHlqsDkHn/0aOtct7mct+Ij
	tIcSpUKLLawCi+CR1oBKV5wuiN2P3KlzyMR1ri1742U+O3yMjrlrQuOPIAjRB28cBVtQvHUVxBz
	yoN7O9tlGwuuELkUhJAuzw5BETKBTPW9tCC42bAUJrSCZPvGhmhPiJPr/4PSVelNz1hxpaiBtpy
	BKvxJvDk3NCdDVNaPfhZso0JaAvWeNiog223GuwqPC/K1MKGOZHgtQLiwywDgsSeTRw1g9yQbvW
	zRtomev+1w/OmTv7MjeWhHVyGSjy82NuMTPRRJn54/KIYI2PeAXmO1wZnuMd/XGoYJSxg6kvF05
	72s7lA6a2qVEPO+tV8TgEq8uCgDs8Lr50gzUs8qPhUOBav4/zmFfcK5bsN54vikwq3Q==
X-Google-Smtp-Source: AGHT+IGZFemKdSYKgqYmaO0mwgcVCAF9yuVJt5HucWW7JtYB8/0vjuVqDXRWxmMpa1fkqFEgulD6eg==
X-Received: by 2002:a17:90b:1d91:b0:321:59e7:c5c5 with SMTP id 98e67ed59e1d1-325177426fcmr25285603a91.27.1756337930760;
        Wed, 27 Aug 2025 16:38:50 -0700 (PDT)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57b227sm3121821a91.6.2025.08.27.16.38.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 16:38:49 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-770530175a6so259453b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:38:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgA4BE+bK0xxXsDUbIHR75iGbWcaJ5/KVPM3sqakw4+B6o3JwCHI3pXiTUEUYxZi+KzuAtavSw1DoOQ0s=@vger.kernel.org
X-Received: by 2002:a17:902:cec2:b0:245:fe27:fe80 with SMTP id
 d9443c01a7336-2462eeb004cmr295833995ad.26.1756337928476; Wed, 27 Aug 2025
 16:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aK8Au3CgZSTvfEJ6@stanley.mountain> <CAD=FV=WEQf=PX52Uv_bjzhnUipKwcNY+BBTOfDHucv=EkBTzgg@mail.gmail.com>
 <r6q738p1-53o9-273q-0198-327s56qpqn61@xreary.bet>
In-Reply-To: <r6q738p1-53o9-273q-0198-327s56qpqn61@xreary.bet>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 27 Aug 2025 16:38:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vqp7zDi=xGmy+gq+jSr1Tq=bRAUbkOVuVcz7C9zFbWXQ@mail.gmail.com>
X-Gm-Features: Ac12FXyRfmac0GCbxwA7Nta6zibOiKLyJotJFxyDjgBD9G3VZ9lGRLVwg_SFw9Q
Message-ID: <CAD=FV=Vqp7zDi=xGmy+gq+jSr1Tq=bRAUbkOVuVcz7C9zFbWXQ@mail.gmail.com>
Subject: Re: [PATCH next] HID: i2c-hid: Fix test in i2c_hid_core_register_panel_follower()
To: Jiri Kosina <jikos@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Pin-yen Lin <treapking@chromium.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
	Wentao Guan <guanwentao@uniontech.com>, 
	=?UTF-8?Q?Bart=C5=82omiej_Mary=C5=84czak?= <marynczakbartlomiej@gmail.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kenny Levinsen <kl@kl.wtf>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 27, 2025 at 8:39=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Wed, 27 Aug 2025, Doug Anderson wrote:
>
> > > Bitwise AND was intended instead of OR.  With the current code the
> > > condition is always true.
> > >
> > > Fixes: cbdd16b818ee ("HID: i2c-hid: Make elan touch controllers power=
 on after panel is enabled")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > ---
> > >  drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org
>
> This seems to be missing closing bracket :)

Fixed. The tools would probably have caught it, but better to be safe.
...actually, "b4" fixed it for me. :-P

> > Jiri / Benjamin: if one of you can give this a quick Ack then I'll
> > throw it into drm-misc-next with the patch it's fixing.
>
> Acked-by: Jiri Kosina <jkosina@suse.com>

Pushed to drm-misc-next.

[1/1] HID: i2c-hid: Fix test in i2c_hid_core_register_panel_follower()
      commit: 5c76c794bf29399394ebacaa5af8436b8bed0d46

