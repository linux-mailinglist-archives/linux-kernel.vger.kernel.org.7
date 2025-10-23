Return-Path: <linux-kernel+bounces-866361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD2BFF918
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 988CF547F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0D2E1F10;
	Thu, 23 Oct 2025 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSjgc91f"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121F2F530A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203987; cv=none; b=PrnJ1K5IdKQc8J5RlBMcz7LK+NKgEC2ULPN202rwkSkK6Vo+mZUl2aG0rzhDIEEkYE+LJI2ApGLpxXYwOtVA2JcPzrjKp7jv3fLNfP+evsnOA0EzUbQZg8ul0Czcd8ugWD9UUdRGtgJNbqMQvqjpL8ErKH4XUumf6ZZbhAGOm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203987; c=relaxed/simple;
	bh=eKKGOO+EUYU7mFuj7z5lwhNA8rPS+bCTcsDg6/XrPM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtydUNmWNij+IgTR7S+FbliPWAUsS6EEj7tsuLkhXHnSMmnGTeyW0iYRnvBg99AvDhMsWgHqO+NaqgBGosvLJPIfdz179uyGsu89z8Cg/PWTcg/j+rAUOLrO5oJhTNdeNwLlkw/5WTjxoFBjPmVGHlrWeKf2C8Dd2GW7y7cf8xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSjgc91f; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42557c5cedcso253410f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761203984; x=1761808784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKKGOO+EUYU7mFuj7z5lwhNA8rPS+bCTcsDg6/XrPM4=;
        b=BSjgc91fYRnfjP3+xsBySkpSzz9DZ1sMPXXH9X9a00asjdgtPR7K/hh+Cg2vaZhg27
         K9x8IYoIaV4CZUGZ3vkgebNOwUPr196exu/6EZ27zwPbRA8aMrvKXuUOYm0glikKkX3j
         bRkafoxKnnhJ8XoOfrhfFxs7Y+RLZOBXpIl4pc3JJld8q13x4j/9he7cjjz5Ui5JOWkV
         KN6sG25N+ohacgKEXaQgnSELyYW2RMbEvqSY6tW0IuF0TAF7OucvK1C/Mje5/CnnjGOq
         Z5c6dwdYlX44Zu1jEAoyWw1F3GTUac/rRPH96DrGvnIgqSyVAxkv+q3ZiLH3hmfBUsmb
         9Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761203984; x=1761808784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKKGOO+EUYU7mFuj7z5lwhNA8rPS+bCTcsDg6/XrPM4=;
        b=qKrgJr3/k+XZmmCZc21eD9IX19DjfLA/UU4DdfrxExq9gkRVzfRS5flUZY9U+QEVLA
         x6/9LVKEY6PX0VrI8wJhCilgSaxsTBX/IkYmh8GuXukg6OiJ3K0unt31wO8+iPapktG9
         UVVIjm4DwYsb+NrbTBBieK9ehy4S92gFrxJVG5aT9wyAd38BQlcr3+mDBbwZhcsD8j2C
         vAoTQYCdwdy+wxOCUVXBJK0NGiR2UMjTVFOmTJlf6Uw2hNt2AZSpMhj0O5KtP8cvqdc8
         S3nqtCCdw3z4q83VGYiI3pbTLabNBp+X3pb2dJaU/pqnwP4fDm2bUoLn0bSM58rVP9Wj
         Enww==
X-Forwarded-Encrypted: i=1; AJvYcCXWuxpzZD9/7spM7XCaEsnv4X45Fi3oXo2tQwHPjFYLjJihEYtiX25DvckKidwnzXUe+hQTX8GOstc/lrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2ENlvbWBpiK1cSqFkSxj4B3jMkxUu7QSkpvFKvIHwR5BPH8x
	+szoZrtDQPT6QcDbd8u/uCz+4OhmiTReNQopZ+LKyMQspBhfQDT7NA4s+pi/U10Kq8+AgYMpCyE
	nf46nC2QNgym7t7BYt66Y+0+YyCJKVXY=
X-Gm-Gg: ASbGncss3CTbY3LJwrO70VYhGV8gW651YndQk8/AdXjLaLy8WZcvwpsOoevfwrgjC/9
	fZxkHnPFbJW8SzECifiquRj0vDqyxQa1uic9d2m4Pn7wGtDiaTsTmE87rObKVnDc8Y6XNsp5be+
	o1Z1MD+1yqduMNH69pCaDhrCHwU4CDcj/Gp0KwayykIkLGH3pdkv0uKdCoWm3csCyD6hhNb0Tlq
	isf94hJL+xTv6kRM3RMXgSHXYDUB3YcrBHkGPvd5fgbOFLR8UyOWX8sgd61x0We2mQLNU+2
X-Google-Smtp-Source: AGHT+IH/mkmYloWSl+N3GeTRYAq7ya3Ct20DnnSTnKTWUDECJMSJuulDknWTBXri6ZT9mQCzclYrezLV30aAJPqFoCY=
X-Received: by 2002:a05:6000:22c6:b0:3eb:5ff:cb2e with SMTP id
 ffacd0b85a97d-42704d945afmr16411155f8f.29.1761203983713; Thu, 23 Oct 2025
 00:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923115120.75685-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <2025102218-blinker-babbling-5fcb@gregkh>
In-Reply-To: <2025102218-blinker-babbling-5fcb@gregkh>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 23 Oct 2025 08:19:13 +0100
X-Gm-Features: AWmQ_bmLla7MkDZZGpNbPEINbL9Ov2BbNibp0fEZqdf2JnlACZ-DZdND2GSrAnI
Message-ID: <CA+V-a8tOqZ-1KKgkEtoMnFpYghY+8wpnyr2T6XZFvPY9zG2Byg@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Merge sh-sci.h into sh-sci.c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, Oct 22, 2025 at 11:03=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 23, 2025 at 12:51:20PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Inline the contents of sh-sci.h into sh-sci.c and remove the
> > header file. The header only contained register definitions
> > and macros used exclusively by the sh-sci driver, making the
> > separate header unnecessary.
> >
> > While at it, sort the includes in alphabetical order.
>
> That's two different things, should be two different patches :)
>
Ok, I will split them up and send a new version.

Cheers,
Prabhakar

