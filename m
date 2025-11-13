Return-Path: <linux-kernel+bounces-900079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF05C59912
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06B2F3454AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF8E2D7813;
	Thu, 13 Nov 2025 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nku4BofP"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFD314D16
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059647; cv=none; b=ueETjX8EWhVDba/elQ76zxAJGGvRoftgrPpqWONghmCxgbP96E2yIzuAuTlSHK69Bu4LCDbwPpmImu7XBdzlvOkeEpkBzp2Bxl6ikKbn8tYIvR9SNuu3Iabp9MDAe5w+eAcLYOajglNgYutgwPffOmDWiv/Z+5EJQ4xjRG00IyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059647; c=relaxed/simple;
	bh=m/TMgIwaPkUbXfwT5NIqlaTMIB8pf+yolwgjLBXes/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdQh4r0YjxIg3eg8FUuCf99jBMGrM2Civ/EsVT/9RCKWS0GLIY+1Dr5IBnfLDCAmu9f/QJ3nevkOniv4Oexz+h29qWOn3dqLi5DGZiArDWF9K/KsKotvCsR4Nqx5jx55P/plbyzFkmfELgFMeIyuIPMM+CNP1n2sEA4y1h10KPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nku4BofP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so1738287a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763059643; x=1763664443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pa5zOAGn4vfPtNLql7ISD9NlwOeK3Bkse1UUyaDWYw=;
        b=nku4BofP8TJlw9gdqTYJlDAe4x2O2ELI496I43r7+z18+FT/O2Dhx6Gqz33Q+Ne40r
         pmnznF6Zso4tegI8rd1h6DWmT+sOwJ1grL+5jmVnRDuD9u9/EYpr65Z5KvW27aMAOnLJ
         tCvz5eVRlfPHFEx4Hovrdw2O85qA3PxRhfVas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059643; x=1763664443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pa5zOAGn4vfPtNLql7ISD9NlwOeK3Bkse1UUyaDWYw=;
        b=p//8JdpK+5w/C4NV8WNx/Di/YIxT6bV85C6gqagBMyR9YkuFuB3pLNlh5EITwHP0I2
         bo6aP57v5a3WYY20yDHfmw+IwvhTpeD0rVTEW7O9ZInEKgEDsx2vVQGXeejtp83FR04P
         XhrcCAuTBUsfd3/j8Y0XF/O0jpIoeO8JBvohJoHYfqcInTlulCPSf2FvEIifdnsz4LX8
         UxKw/i+wCiif65HjFAlb6QY8oAmZdPpWrNC3O0JfaLapAkQl4GJaOtwTEDRiOMU7hfOM
         +g3GB7Is8Hm/+i/9iOfKOD0cXw7m3cvE+8Kg4Cq1p2FTbLpvpercVsZ6Xr8UgOwJLFX+
         7Rbw==
X-Forwarded-Encrypted: i=1; AJvYcCXlgsDSKQJqcMAttuuE9eJ82mp6y1IrZ9woSKkxkgZ5jj+VbQPVLyxs9qSah6wCn8wtoebA8TeoQG6NADA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpF963jwidOyIpQ7ph3Cxr04bCYYMcpVrW+R5IcI2dWA8Gzr5
	pyvhWCNmiLduMLTjJAk6Z2ZC9DiGnLO9RcdwaQOulT6CGgXbP5UExbpzTT3av2EhHLy8bO9fslC
	ZN/D+vuf7
X-Gm-Gg: ASbGncsGEx4KeTQclQI7u3YCTg8Ad/XJ2CiXKbjFfT5OjIUl1YRagEk8nIqWxhE0cue
	mXT3MOpJeRBehTpapBz4TlgpdFMfw2E+IoGwypGkLvDy3CrKoainZrjcnBubR7o/1ezXvm5oJxR
	O7L8zhtB9MJA9NEgUmsZkfct8RqZ6Kp2aAC+6/OLyzEc34D3YVEVuM6yYegxLX1QU9sW6yyEEOO
	VEFVwXjlvAXgHpIxtlayvwYyO8U+eL6cBUDUKBLA/bQgXa3axVTeG/lDKUSTxHwtqseipd3dTJx
	5ER1W0J5ZgPPKn7WJe2x8rARPsfAMp/JuLACzzGq1pFtBvod6h7uzyyAys7srF7XVmK6yX1esXA
	znsds3kbRoPjnWZmzncJGAqIzSpC47++lNvvq/WhOloPEYZRJasCr+Q7qUVZBE9HUMg6bF4zZ53
	KTOyNsjp9/AZ2EL4cy7QoX0O9joWFY6hIMJBkURxANOzTWY2e51xbU9k1ZwJOJ
X-Google-Smtp-Source: AGHT+IGR1vc6DhJ+hbCghHYiMJDsE4Xv2y34v4Gl2YHFA5gRDUdaIUeykZQFg2qJVYeVWHEfZ5tp9g==
X-Received: by 2002:a05:6402:3553:b0:640:bd21:242f with SMTP id 4fb4d7f45d1cf-64350e06e88mr332893a12.1.1763059643247;
        Thu, 13 Nov 2025 10:47:23 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b19dcsm1920664a12.27.2025.11.13.10.47.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:47:22 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471191ac79dso12798545e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:47:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXHKSitsdCxzWXctv0UVeXWqB27tCyaABfPMKNbYkz0RwaYyoTYin9lMzRDkdQClTu3pYQUFrYlL1QmUP4=@vger.kernel.org
X-Received: by 2002:a05:600c:1c19:b0:46d:5189:3583 with SMTP id
 5b1f17b1804b1-4778fe128d4mr5655535e9.0.1763059641794; Thu, 13 Nov 2025
 10:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113140004.v4.1.I894dde5015f4acad94cb5bada61e5811c5142395@changeid>
 <20251113140004.v4.2.I47e9f0b76399e6009854dec06420c20e68e23116@changeid>
In-Reply-To: <20251113140004.v4.2.I47e9f0b76399e6009854dec06420c20e68e23116@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Nov 2025 10:47:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V1XDg4xeyNsonO=Vnqtr_h_t-6THVSN94OwnAc0rL0xA@mail.gmail.com>
X-Gm-Features: AWmQ_bmudWlj27QvceuHdnhfsgBSCMlgVO4gHcVjnbaop7V-bBcQI7Hn-P8apkc
Message-ID: <CAD=FV=V1XDg4xeyNsonO=Vnqtr_h_t-6THVSN94OwnAc0rL0xA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] HID: i2c-hid: Add FocalTech FT8112
To: daniel_peng@pegatron.corp-partner.google.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Pin-yen Lin <treapking@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 12, 2025 at 10:01=E2=80=AFPM
<daniel_peng@pegatron.corp-partner.google.com> wrote:
>
> From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
>
> Information for touchscreen model HKO/RB116AS01-2 as below:
> - HID :FTSC1000
> - slave address:0X38
> - Interface:HID over I2C
> - Touch control lC:FT8112
> - I2C ID: PNP0C50
>
> Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
> ---
>
> Changes in v4:
> - Move change log of v3 under "---" correctly as below 1 item.
>
> - Modified the subject to include the ID of the chip as suggestion only.
>
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

