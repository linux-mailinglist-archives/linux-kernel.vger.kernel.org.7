Return-Path: <linux-kernel+bounces-835585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC5BA7834
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97857A1489
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B429BD91;
	Sun, 28 Sep 2025 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gWFBrYIE"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B2125B2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093935; cv=none; b=lP2Ke0MwcHp1+mCXwLXoPj67jAgN6ok+xVvkepjbqJlnXG+FxmBsZi0hgUbmOHKBaNMU3qSMLMW/oR0Y4mGXFztNiQDgBuwwvfUCcdytci5UiPsGqO9Ogvj+qtALDAGZ2jzVHAjhGIvJZmY7ra4EeARL8qlwDecwIMmUkeDg5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093935; c=relaxed/simple;
	bh=L9Wr+oB+yImWWeNWztttdaO+JL7qll64cuGGoO1pokQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlQQwGyjuqzRm7jH1bMmrNSYUUyRr1NvQScD18lgDdmA+Z6JkbR1zutLEfO1Wcrj4MuIqrPmavO2SLEDbJmIWVI35ZPf2bu9qZyPb1ntW3IqKVUyZjvHkqq/06CkOsaM5/JmYhRiq/eqCNF6M23/bPdgXi6GuvfEfllJx7+f3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gWFBrYIE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78118e163e5so1658705b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759093933; x=1759698733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9Wr+oB+yImWWeNWztttdaO+JL7qll64cuGGoO1pokQ=;
        b=gWFBrYIE31P/mbQKgAsTlzBoAFb3IcHyuBp6uwitcLEBGkvqmsBd7T+yKBzohlWgB9
         1RDG7CRMIoQjKNbH98sILLVBl3fay4KGET/dHoTSkfgTWB74Y5+BrjcU1HlycH7JGZMl
         Nvv6t4P0pII1VjkLq62AiO2s10xcfWTfg6qKt6nrTvgvLQ1m/lP6UaHjg4Nub3lII4rF
         M+oY3ChiGONdxPcBfVTuUmNtQoTM7F3nF1tsmG1Aa0SAnYK7m74fOSMLRzuiZUWGSTS5
         6w/dyZnet+fz/bBLjeXRD+IfCVA6FOeT/GMRJPCeWaR7CxSHRaXBLrOSDOe2OOFIQ9Jm
         60zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759093933; x=1759698733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9Wr+oB+yImWWeNWztttdaO+JL7qll64cuGGoO1pokQ=;
        b=uXqG13/Y1vSnaKJF4eJG5Jia+coviFEFyTuigpWqwX+06WLlse4A7Ffd79mr4bOrac
         EWadFRM2s/Ift6iBkDUuNtaR2ZTamm8doHV7spCadUAEiLA0Rp3cID4M1tmcTuYAfhar
         Yfdbc71+ni/l/UKW60rvMyxXqFKaomc2STMMYgQ0goT4qpCFpoeoh/UMLpHzRy8YSiuS
         WEMaGsAFtahVKLZB4VxgTM5Vh/l5q4L4sH3BmrIk2SzgbzY4Cwi2WPzvJMUx2kLpzX9S
         shrOk2KphmTKsFmPZpXBSR1agQg5jYQGNhx/ikiKlzUnywNpZtuMXx7Q6LJN0LFff3U7
         tOVg==
X-Forwarded-Encrypted: i=1; AJvYcCVDxoe4qrtkS2Gvsudg/VVExSBg3ZsYQcvYDjmWCRqNRxsPLR6B+0YT5bkZf01pPXfFJsH3rhcmnVF+QSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30GHtMUn6dcjQlti5FyJUAgwCuw0jyQA9ejTk4MP1NtxmOtfh
	+aPiAyiSYszahkcVrB/wzSyFaKklvSdWnlbBzSUiQqkeb3fjYOWh2NILn6570lUmmbWoUxYF1g2
	B54K+/JU205K13XEh6WLb11HPVthbcEygBw==
X-Gm-Gg: ASbGncsBVVwLuW7GBtE8NhProeZ6a+cC0F9VIddXfQg+YXqzA+2vM+6W0N8aFVwDIMC
	yBGihLbIupyTraFfAOJJXUx6PJNpqxlp97yL5MGPmf1GFKdMZkIQo24zP5i03c9A3MTiKdavmWV
	8w+BSLZDBCSMNYi4e/3FzQoFSrgxQjirBa1W1TePtOgXx7GAxtu3KeolWOpPTvczjuL7K0tRGsO
	rFBdmhOd+GKqsOxhSjXN103YB8j3St/7i915uQdb7l6TugAQQgX0lHF1zwFiw==
X-Google-Smtp-Source: AGHT+IEzeCWoAcjeQc0mkokrPasLODpJyV0OvfwXH4nf4WOVTR25YxHcNFHmxB2wa/0TSLPGrvZCSjajqVhJuA6GrUs=
X-Received: by 2002:a17:902:ce01:b0:27d:6cb6:f7c2 with SMTP id
 d9443c01a7336-27ed6e0575amr147835175ad.17.1759093933080; Sun, 28 Sep 2025
 14:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927125006.824293-1-christianshewitt@gmail.com> <20250927125006.824293-2-christianshewitt@gmail.com>
In-Reply-To: <20250927125006.824293-2-christianshewitt@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 28 Sep 2025 23:12:02 +0200
X-Gm-Features: AS18NWD6fXr03inON1_wapYEKrdYX1AMtat52gOUZi0JEEmswI8favZ4PtmwBLQ
Message-ID: <CAFBinCDQc=2xrKbGunSKJjLhGd0bCGN+3oYd_bg0ySs+WHxZjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: add initial device-tree for Tanix
 TX9 Pro
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

thank you for the patch!

On Sat, Sep 27, 2025 at 2:50=E2=80=AFPM Christian Hewitt
<christianshewitt@gmail.com> wrote:
[...]
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-tx9-pro.dts
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2016 Endless Computers, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
Is Carlo really the author?


Best regards,
Martin

