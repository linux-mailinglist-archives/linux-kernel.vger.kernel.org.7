Return-Path: <linux-kernel+bounces-863157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00FBF722B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402B319C2004
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F233DEC5;
	Tue, 21 Oct 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="toizFAjN"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B591433DEEA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057748; cv=none; b=Rvn7tmmbe0Hv8qKoy2Mu8hb5dJAtUnCrFE63khfVF1I/M5nj40zPFAOEJs2CmM+i1DXrb1EEZRRPxnTjZXg9c/+9uTvRKq2BS7jgOh/RSbEqk4i86tISWDnMDwu9vMY7Dz907B1V4fUsfMU+gBY4mEH9YjNrPBVoYe7LkSmKSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057748; c=relaxed/simple;
	bh=VGc4m4oF+KXusmvdq7HCQy/1KNZxYxwVZz9pTwsoGlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njLz7FMleOASTTXMPdH+EIxaEuYl8T/Lrz4nXq23aMPYos3hiSfNEGn47+wgx7Jw9SLAaZ8joF+8gOJwBrybp53+lY1qLVR5f6HSFzI3AGTrpXJ8KucMMlYEtqxVJIwIIsB/O8YlVN8mkufeGkjAAGkAUJoeuDbI0wviFsNMHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=toizFAjN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-375eff817a3so62866571fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761057745; x=1761662545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZCOMUry8QgJDtmQTlzvKx4nzmcRl8rasbY1MAd0sQY=;
        b=toizFAjNvCxbdmiRGHruks9lNdp+nDZh6F3FBjY+riJ8JqXmbf8qB/h7+Yy/Y+PNIb
         Y1XHXq4NDJJhOOqfxm/B+jydgEWe/9Uh/MXHDM5RbRe8a7PtdrLX+JiHKn4GDYxrYmWL
         cOfNr6JwMpieNDY7kHJyV8HRzkNbtyzGmXnDIK4UX1Mw6dUVgzxMELa0T0vA8EOGLNMA
         jqY7Sjbn7vgOSe5dCIsnGfecudQM+vy7tb3EJjha7NZHtBSmq2u7wekCDL4TLhwGJM5v
         CpjZSkefszox10VDBWnaazFTX1dxZ0auiMh1zf8/hSGuMYXJbT2JkayM2lXFAhtddoeH
         jF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761057745; x=1761662545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZCOMUry8QgJDtmQTlzvKx4nzmcRl8rasbY1MAd0sQY=;
        b=vwnOOydoJ69TP8KJiSFABEcuYhGyNFobeqOUXDlprJKD06OVc7oXmhCZzS2RwiVAlt
         hYAWyL6gQuPo73QBtNJaHYNN0jae8YPHmayMI1MaeIAAUfcpmUq9xPJrZ50QDbqixlSD
         1XrXScqBBjaIawfgoAFJQQPs7NBKNwryhJNaTomuUPCo0kp2uowjlVuHb5HZP+jy8iDA
         89f3Z0eUxyAQtETT8fTwFinSft4WZLJq7MuvFFr4j2K+SA09Q9fYqZFOmfwfYacp2vFC
         9zKSXspe/gqRxB+Dvag7dchpHrB1A3mt8WyV8z/g9GshpXweihP0e7ooJbqfkAqknRnV
         NMHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRgw3tlcDMYLrRccyQiKe99CrFFii43IyQKHFDyo0iVngM7N0GQQ3lN/fbi8p3hEP52yLf6XFr4VFwBL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3QHm5OIZPm2d5bMMh/gdOWHs5ZthgKWRQpKPlYbt3jyQGv4g
	A+rb+88d3+MO4y50qoilLbICurOKVLl5vqDCXY3OAK0zNq+jbq0gxpoB1srrs57qDoZb0E0GjI+
	2OHltyJSXqyff/UFhiQKqX3fXEZ0wj3hJfxlbnvpMYA==
X-Gm-Gg: ASbGncuQsrCtyFAG8CJN/PpTeT4uq1Exrqmm1nuSG4tlZU3FxetrJoTDW/AGQDnlOnx
	WSZX80XPnP8/+reT2Hfr7iqBXUZP1LsjgXxp1qUAjbv0gxg2J2qwOs/I08uWWfRgQdixonZxj3e
	LeBH7wENOTrHgTnKywfwJiqhVvsOjrcoXdlH2EdEOn2KQeXYRhveMJjdheAovdF33F9HouX8AQH
	Bje1wgHKENziLXEjQyJYE3Tdp/sNc5ZRxyuHy9+GwYIQ+h/aNiN93JlEV7BknALoWH3Qeekt4nJ
	RKkXVTU5yVZEjS+L
X-Google-Smtp-Source: AGHT+IEAFGsFmUFG/YnJHTCDdPAr/87ZFEb44yMmd6QhcxQ6kY+xN7c3ywaYXlVUOsQLkH0hiixQGCRd64K7uAmIpvc=
X-Received: by 2002:a05:6512:4014:b0:586:9636:6e4d with SMTP id
 2adb3069b0e04-591d85622ddmr6106679e87.50.1761057744764; Tue, 21 Oct 2025
 07:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <CAMRc=Me4Fh5pDOF8Z2XY4MG_DYqPRN+UJh_BzKvmULL96wciYw@mail.gmail.com>
 <81bda56c-f18b-4bd9-abf9-9da7c2251f42@sirena.org.uk> <CAMRc=MdOCHJEyPxN+-g71ux68=Mt_Q5P9611QO7Q8J9e8UJv_A@mail.gmail.com>
 <0e1f3a1b-46ab-4eb5-ad05-70784f9b9103@sirena.org.uk>
In-Reply-To: <0e1f3a1b-46ab-4eb5-ad05-70784f9b9103@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 16:42:11 +0200
X-Gm-Features: AS18NWCeEZ0pLB4tS_IEx2MtW9IQz_axw-1Q3NqtyOuzDmGpEP1ZzpOriXTSxmo
Message-ID: <CAMRc=Md1Ve4hnYQOryYEXG6_HSPJrANrr9gj2FMzCwsD+q5Cuw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Mark Brown <broonie@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Catalin Marinas <catalin.marinas@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:08=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Oct 20, 2025 at 11:41:52AM +0200, Bartosz Golaszewski wrote:
> > On Fri, Oct 17, 2025 at 7:32=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > It really should be the actual physical state change that triggers th=
e
> > > event.
>
> > I guess so, but this would require some non-trivial rework of the
> > regulator core. We'd need some list of deferred notifications stored
> > in memory for when the physical state actually changes.
>
> I'm not sure I see the need for deferred notifications?  We'd need to go
> round all the users whenever a physical change to the GPIO happens but
> it's not clear what we'd need to store beyond the list of users?

In my mind I was thinking that we only need to send the notifications
to users who already enabled/disabled the regulator too but you're
right, it seems like a loop over the relevant pins should be enough.

In any case: this is outside the scope of this series but I'll see if
it's easy enough to add separately.

Bartosz

