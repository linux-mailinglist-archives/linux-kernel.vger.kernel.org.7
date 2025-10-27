Return-Path: <linux-kernel+bounces-872769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB7C11FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3283A67C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9004032A3C1;
	Mon, 27 Oct 2025 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ux06wiQM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DBA32D0D8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607332; cv=none; b=OsWUhlREac8WjeWfMjMt/MvpLsue1lZIYTLsJ5jNi7CbTO9S7lwvQRqZvsy4/ap/xTYdVKk3mgiR+rR19kStJ5yCX/vXLzUy2UCGACgnk8lAt/+PE3pn9NcbJbSwRAaWAOT5Ai5r7nRbito7WXJyv3U8GUglerFM5t74VG2vgZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607332; c=relaxed/simple;
	bh=P7ysm4/FJD4mR6EucRcT1c5Y9QYG15DBwqirU3YA+CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHkbWpyr1DSHepA+WRbvH53qBdfU48Btw9w8GGqckwwKfj4XnaJZBIKmwvmyCoj7M+TOfOlDrHPRMEjt8/SNBK6k5cmnZVd5lvGCfafpaa8VWP4ycrxhBPepKreMQA7fYAVYVVP1/8AqUvrTIVpj3Lu/gk/AAguqMNM9DfhvSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ux06wiQM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27ee41e0798so75273955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761607330; x=1762212130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiPQWeIHeevsOV0YNnrSX+B9LNP43U3Api7ejFSH8cQ=;
        b=Ux06wiQMhR90R7GZzc6ZESmOZG04sDLPUxaS4AUbGNgHfP9FNgWI4K/Cgnfer83yL+
         3u/rWp29WSs2Y21ZTsf5yYMurgrBul22soGUjPAFI5+XmWStkD+OOAxFZzHNErfvWQh4
         CYhq/C+ubgGBoiSOa2x3OJ0o4e6Ls7l5UgwwqWSGWiIrV5Zu/27aUQjUtP8BJFW9GZ4E
         XLQlOFE7sTqCmMf+kIduyAXUw5oZElhYKTrSTtxiNNstk836PDxZ+pp8myWSQ1u9dbla
         kQkEnlLgp2ScHBXssg/IwoPGprMe6nFvbamzG1bz4tzSdz0nKPHKKqVLMdwGrWr7quBL
         UvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607330; x=1762212130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiPQWeIHeevsOV0YNnrSX+B9LNP43U3Api7ejFSH8cQ=;
        b=vHpCdbTfooYoGQ5+cwm+VhqlIDq9CQVb6J0Vs6815pV0NFZg4+YvxuMmpKuC1En2yX
         n+genIaegKE++OJ48iFPAW7vKMW0LKZnb6tHCCIPVg0HoVMXwi5Eh7nIL8bMkz2QgGJ7
         eeWoIl6l+/hUH7lcpvAt64tgmuP3/0RsUBFIVYzQ6MKiZZIzqtKzD2PctDsy/JEbhrPr
         cKQdq2nH5lSVoCmYWfyOEq9xXS4+dO1J7RDfX2x5GO+cfsQ1Fba/19PZVMPnN79Fm/hH
         +xBqPdWRhZKUUbcp3BdUzFfrX6zNae+Xl5Doiqq+9s6XD31zBDTlmX4brN/+xsjzVa7r
         X0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUeclO+K1RYPWytTT09rnW9KdWTtt74kjwkOHJf5gl/dkLzHEsNSaTJ4Isfdxqa8HvOQJFRlliShSCOMMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0FXCwPp42ykq+o8RIE6RBWep8htAgmr4jcC7+Abpb9+1cBeJG
	9wuSmMLuIakVpNYN8nwxBNyYKPMrJHqxVtFiWOAVotSYIqMQTJaC5cf4ZNGnmwmLAOPZQX9AeSs
	Vw8t7/8yfwwctmTerpIi0B84kqNr4rEeSlWrAyRNI
X-Gm-Gg: ASbGncvWKgu0CU3sAvrcCTDwrPw4LaKtkJ48IC/v0NJB36Y+KmWlcEeZ/kqyvyGbhkn
	anPJhQWWMbWFEok/92LVYLb0EVPeap8gYAE59B+caDnp/bXBokvkMlql1cVyRstOV0nYUegUHL3
	lIuLLDfRLeNRojIwCAnxkTqrAsEruiV5XTRo/0OK5ey5vrSQN6X8asXElmioxfePqxxiaEGZdjY
	bMNrk8Wtkoo+Gml40FdXRUHpS3d9lWhecmNbZ74aU3LCs/h30s8a4GvMmFojWg9CkIAoI0lRNWo
	BXC53XpZ2ogNRMwDOg==
X-Google-Smtp-Source: AGHT+IFw/jdLBZAkI7aI48cv68geMt8046dhZdRqyhbPorbEN5vUOHFP9Zbu6h+jTvEqQPeotPAALO6GhBMyaapG0Vg=
X-Received: by 2002:a17:902:f609:b0:290:ad27:c1fc with SMTP id
 d9443c01a7336-294cb6893fcmr16828025ad.55.1761607329339; Mon, 27 Oct 2025
 16:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017235159.2417576-1-royluo@google.com> <20251017235159.2417576-2-royluo@google.com>
 <20251023-collie-of-impossible-plenty-fc9382@kuoka> <CA+zupgwQTLEs8_7i-VsGbGV7O2Y3XFA1C3aV7iuv2HLOwKns3w@mail.gmail.com>
 <8e4c8875-10bc-4f4c-a675-a7cefc68c863@kernel.org>
In-Reply-To: <8e4c8875-10bc-4f4c-a675-a7cefc68c863@kernel.org>
From: Roy Luo <royluo@google.com>
Date: Mon, 27 Oct 2025 16:21:32 -0700
X-Gm-Features: AWmQ_bnZfP-h63jIJfnjGht1z_4tHKDRepUQGmMIkJ_dLhOGQfclonH0qtun2RU
Message-ID: <CA+zupgzzkX2CEicrLaW7oGB08qNVqF=5Jpfgcw5HWS1kDW72qg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: google: Add Google Tensor G5 USB PHY
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, Badhri Jagan Sridharan <badhri@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:02=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 24/10/2025 00:22, Roy Luo wrote:
> >>> +
> >>> +  clocks:
> >>> +    items:
> >>> +      - description: USB2 PHY clock.
> >>> +      - description: USB2 PHY APB clock.
> >>> +
> >>> +  clock-names:
> >>> +    items:
> >>> +      - const: usb2_phy
> >>
> >> core
> >>
> >>> +      - const: u2phy_apb
> >>
> >> apb
> >>
> >
> > Just to provide the full context, these two clocks/resets
> > (usb2_phy and u2phy_apb) are specifically for eUSB2 PHY.
> > USB3/DP combo PHY has its own clock/reset that hasn't
> > been added yet, we would have to differentiate them once
>
> That's confusing a bit. You must add all clocks, all resets, all power
> domains, all pins etc. Bindings are supposed to be complete, see writing
> bindings doc.
>
>
> Best regards,
> Krzysztof

Ok found this in the writing binding doc:
"DO attempt to make bindings complete even if a driver doesn=E2=80=99t
support some features. For example, if a device has an interrupt,
then include the =E2=80=98interrupts=E2=80=99 property even if the driver i=
s only
polled mode."

I will add all the clocks and resets inclusive of usb3 in the
next version.

Thanks,
Roy Luo

