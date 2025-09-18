Return-Path: <linux-kernel+bounces-821933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F0B82A45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCB27B7667
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8F241664;
	Thu, 18 Sep 2025 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4IXSxTT"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252C23B615
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758162103; cv=none; b=qQi253U8g3MK81Kzwuu/JKdEe3SarroiAWp6WrtbhHCr5n+6cqyqxw7weRycCgM7i6siLfDvDYYwrDrvv9AWHjWUFZbCYdxD8U81j6BphAGuIjsS2ibpbgN9sPpcdiifpCz9Lrpv3X2t/ns3+AvHQLZCPzUBrRCWF8lu8j+JOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758162103; c=relaxed/simple;
	bh=wYFDhqZMpWEiQYUOZ4bLOFJqYbrY+MzBsawXh0UrLjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYFhXY+KGboQvB5kjRVpMTsOywGE3o1AvjlQSngtwRiFtGa6kR+GCtyfZcZbHjb3gMvJgnjxDVZ3tk6FytqMs8IKyIvIZmC8sCWPkAXpZTohCKpx8n1savALgEUl8ZY7mrrQTuN7h4KEgnX//vdmpnjx86G0EEL0E3ziMhuG0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4IXSxTT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7742adc1f25so382103b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758162101; x=1758766901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AP4EHyPiENgOeGo6lnIyAQbYkHufakN6exnZUysaUA=;
        b=T4IXSxTTdXMv3OupRrPYN9LkPLjgKGEtjXIJLiUmcQGYz4zc9tjLO392ihK07IHkgN
         H/ZDjHmP3iwVPZlwBZq/aJkcHyT6dCIJ4rD2mip7PhIfyVVsN/PpFw4xp4XjMGuwA58j
         fgi+n4eOJ0BKjuHqazZ4dzWKF6lghGLpCo3x4lT6HDNHqwMV8Re/YPkbBJt/2wO5JvQ9
         Zl8WZqNKdkgIhJJXiCh0FybeOGDzzRYIB0vxoM1Uo1DL069KbFQyKyCDksnOFDwrPkKt
         sJg6gPQfmd6ZfPEuDLuS5vi1R5b2zW34MFtlXX6xsKib8H49nPIjzScJO2zK75TfuxCR
         D+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758162101; x=1758766901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AP4EHyPiENgOeGo6lnIyAQbYkHufakN6exnZUysaUA=;
        b=KQWEQy6kzGVSoV5yK5LJpBxxFC6W3MDo3d2h4nZUKHb6TZDiureJwAQZy3ZDDQLu7c
         An4BS91Y4isGrI/CwIs38RUswg5mgfffq5g1ZTAEr0Md19TIO3BHUUkH9MRpfWLixLRC
         8o2a7d4cRv27U6Cc8bi4vwFIxFhvXsrU+6enfQwuLCFNHoF8MyCYQDnW9ML5A7ECFBNa
         IspbGpJ6ipIZ/ZmV17kMtdzptNC6vwhjdtJjODxIRLQgW8+OT3B6uNsN1pTJuejppiS8
         vZxcHtOgihvyolPJfsFn0A8f4hLXkamT7UCTbZ5RM7rod3WN0pWd0vsHE0VcBHdFedXX
         vKIw==
X-Forwarded-Encrypted: i=1; AJvYcCXM3Ymh1zxkJUTZFanD936EQ3vqywXPiIjKu9O8S92ob8niQdtzWxTJOzhB9W2upXtNdk9keaY0E1STemg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf2hf9fMglFegmGnTmAYS3byKEBY2ICzB+1LCPwLSjzmNRgU0H
	tlu34SV0iW/eyxYnDL/sX8WrdmEDTKfM6UarcqTnxWnw0+I1R/ULifmnbP/q8RhUdH96owfA4lf
	Li1jNthKymBOZGkvmQ3ZxVmQ5F6xBF4s=
X-Gm-Gg: ASbGnctZyYJJCi5K5q7W3Z+0jrgjbjiAwNmhAVUea8fCgVs/hx2ddH9SGL559k/zYlA
	vcYv4sn+cB0iUh+t1h6I+AiVaHwkiclcaWWuBLu1PhZnkiWS0+JsyiQ1eF9vqQ6RFJxQi+FuWfK
	JAd5n1LMINhHKpvXBBIfRS9eS1dSBAxL2NEXSRYr/W+Brk/NIjnYIPVYCWhqJWoeNlbr13oscIA
	/++aVU1zk2NQTJZzbvQp1YEwuc=
X-Google-Smtp-Source: AGHT+IFNb+V//PSot2NdNe8uHywPWrpykUBYjIUlGCyD/yVXRRWQERUfDT3CjUAAlpnDFP1yuGL6Iyf8GhGufhzMKhs=
X-Received: by 2002:a05:6a20:2590:b0:24e:c235:d7ea with SMTP id
 adf61e73a8af0-27aa85b47fcmr6198309637.47.1758162101119; Wed, 17 Sep 2025
 19:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com> <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch>
In-Reply-To: <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Thu, 18 Sep 2025 10:21:30 +0800
X-Gm-Features: AS18NWCtilTwOalEuEaTOVX5c4Y78vBcx4wNNE9JzBKwGJPsuMQ80m1HKt2v-vk
Message-ID: <CABh9gBew1=hbJvg1Mhg5dE7Lr_Z442_kbBX6zTs_6_C2NRyLbw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Wed, Sep 17, 2025 at 03:48:08PM +0800, Kevin Tung wrote:
> > Summary:
> > Add device tree for the Meta (Facebook) Yosemite5 compute node,
> > based on the AST2600 BMC.
> >
> > The Yosemite5 platform provides monitoring of voltages, power,
> > temperatures, and other critical parameters across the motherboard,
> > CXL board, E1.S expansion board, and NIC components. The BMC also
> > logs relevant events and performs appropriate system actions in
> > response to abnormal conditions.
> >
> > Kevin Tung (2):
> >   dt-bindings: arm: aspeed: add Meta Yosemite5 board
> >   ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC
>
> The threading between your patches are broken? How did you send them?
> git send-email? b4 send?

Yes, the threading is broken. I initially used git send-email, but for
some reason, only the cover letter was sent. I then sent the remaining
dt-bindings and DTS patches separately as a follow-up.
>
>         Andrew

