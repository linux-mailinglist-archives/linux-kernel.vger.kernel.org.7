Return-Path: <linux-kernel+bounces-844400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B1BC1D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEF13C47FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5062E22BD;
	Tue,  7 Oct 2025 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4fYmzd/"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341AB262FD1
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848995; cv=none; b=i3fyxbJhyOrzx04WGJMjn8zoYt9svDo1kHimW0miOJxKbVqqNOx6m64oqmT2NQpPF+LEPjGqVvA4kHt5dscpwjo8k005KDgCtGJypQ5324EYBk+DOT8ClpzGcCl3b8bSfTYdNkM2kJ+JDcnabfrTsJsQzlRD/Vk3CDfAGo/GTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848995; c=relaxed/simple;
	bh=ENDqyO+GBOTd7fOpBp9AzXSrQiEB5GrAN3MzmVDHS2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwDq4Ru3UsUypOuArhGuCSPWpnTyo+cyFZIQ+2ypdnAE6jIUlOCP5d6OrTjyUvZ2Khj33A8As/13ux6SmCgT5ctvAViRRSgSrxwiSGDk7a/K5g0rY3di7jJRUMWNYtjuXmRQOqBPo4FNCXSceyAmKgGDOhu43gmQqPihT/Wkw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4fYmzd/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-856701dc22aso650288885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848993; x=1760453793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GhP8a/ZKQuCgI57gL3YaLW/ubXrMPM4jolOkHKTB/I=;
        b=a4fYmzd/tCLJ4KuR8CdghIDGboNkAYUZ6gkD5bHvmWWLdZYT2oXkzz7o6bhTGr/NG3
         ZwYXsILqkh4mDVWTM0yeL7/Lla/eRazX28i6W929l3uY5pGfGYObneQrsx/Nb1M3cli3
         7N8JKzD/2bUcrM2i4QSXEGq7rTAIlDE6FjgDtNdXKijadJjmqZr1+A4IPb8ANxWbMlqj
         XPPH/74KpkkOD2avAC6EhLQSy5sMkxwp+rnhcMDQEYtArtHLwln2XVZNYd1HqVRpkmK0
         odxmnCivwA4MomSyg1hvWrIW65zTG0ywIoHQ5R09ahg+rJYGNzbg90Y8F/0p+OFbWGHG
         v8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848993; x=1760453793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GhP8a/ZKQuCgI57gL3YaLW/ubXrMPM4jolOkHKTB/I=;
        b=wBJ4SgfB6VSPKQjPURHlOhvEKEZ0yPdFIiEcN7bkLJPVzkRUgFoL7Fzj1e4wfzP2k6
         e5q/uknTbZjXW6KX3hX8yM/ERiw6y5t4Zug/W6Z3wZClvXFz1Nz7zvB+ujg+78pvLxBZ
         GNQoGV5R0Z+0qKnOqfZPqrxIRSCezC8dWvQm+PJS/aSDzrNtZo54DMnLH8p4eL8q+fRL
         H44o7QID8OOJit0Ga5pSnBBnybS33X4cZKCNbAH5qjxXXZliRHhmQSbecbd8yFd7V+Ol
         OvwI3NXmzhwI9eHwFss2pim4ykDe186Ze2KIlkdL+ixGmVLsYVvE0GBEtOVIgYsbkM2F
         /nxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO6Nvk7/Sq5bA9SV6axM8uCqHGymeSOvyL9rnt3SGtuoxwTI6n0kYRIbG8lqMdb1LwbwqxueIZ3TLXNRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkzyPbmWzq1gqX3VbgwXc++DXuqyHt3ojdGhObqYSokL8ydQ+
	s9QgmfB1lxQDjJX5c45way9ht/PKigsDBj2GwkulY6F9U7K8qzt/HW3+k/nOvyu6vG+jApPNLUR
	7/JJLm5NoITibzqmOzLzrbe3EpV+/xCI=
X-Gm-Gg: ASbGncvt8lgFvfZzcVI40g5ZD6KgD6hxsDM9f71Libydu9fCWUkS1NN2b7p0ntq//TJ
	hJfOZxONccnLXYJTnUkKwpFh55YmVGO4sUVgg4YKP9t9EzAWDHjL55/jl4t4+ZuPCTWT1uWJ8IQ
	infzzhg/E1o6PGmjN6DVsWqhC9USCQ3Hwq9Dp5h0/lBXoUsEQ/owYef0LtVKwfAU+HWpud8NX/S
	WVtJVCcsEmnFDhWJejfJxxllYJz2bNk
X-Google-Smtp-Source: AGHT+IFrXi3dEsVh64oUPSZQJlGSlVMkDxHPAisOxAhnbSx/xiMMXQ/o7YtNW7v7WGp9iWQQ9a0t5dArstXdxIY4V5U=
X-Received: by 2002:a05:6214:1cc2:b0:78d:5f57:e91a with SMTP id
 6a1803df08f44-879dc860afcmr228051616d6.55.1759848992842; Tue, 07 Oct 2025
 07:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929065714.27741-1-jjm2473@gmail.com> <20250929065714.27741-3-jjm2473@gmail.com>
 <5700676.tIAgqjz4sF@phil> <CAP_9mL6e8ekL14xycSfPmVSkL7pANLeyewWd=rjxbtMgMQXxxw@mail.gmail.com>
 <6a5b9e68-4f23-49b9-b744-e84fc28a96b0@lunn.ch>
In-Reply-To: <6a5b9e68-4f23-49b9-b744-e84fc28a96b0@lunn.ch>
From: jjm2473 <jjm2473@gmail.com>
Date: Tue, 7 Oct 2025 22:56:21 +0800
X-Gm-Features: AS18NWCQpv-6neUw-wCX8BxmrQo_hHgklBBZppkW0N1Nfv2AVai07jEpSNzQRn8
Message-ID: <CAP_9mL5C1vKJq=bGM6DoK47vU4p-qvPeF-k6kztdnEp3y=kUhA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, quentin.schulz@cherry.de, kever.yang@rock-chips.com, 
	naoki@radxa.com, honyuenkwun@gmail.com, inindev@gmail.com, 
	ivan8215145640@gmail.com, neil.armstrong@linaro.org, mani@kernel.org, 
	dsimic@manjaro.org, pbrobinson@gmail.com, alchark@gmail.com, 
	didi.debian@cknow.org, jbx6244@gmail.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2025=E5=B9=B410=E6=9C=886=E6=97=A5=E5=
=91=A8=E4=B8=80 23:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 30, 2025 at 02:20:57AM +0800, jjm2473 wrote:
> > Heiko Stuebner <heiko@sntech.de> =E4=BA=8E2025=E5=B9=B49=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=B8=80 20:28=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Am Montag, 29. September 2025, 08:57:13 Mitteleurop=C3=A4ische Sommer=
zeit schrieb Liangbin Lian:
> > > > LinkEase EasePi R1 is a high-performance mini router based on RK356=
8.
> > > >
> > > > Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
> > >
> > > In v1 this patch received an
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > >
> > >
> > >
> >
> > In the next version, I will add 'Acked-by' to the commit message
> > and then run `git format-patch` to avoid missing it.
>
> Please consider using b4. It will automagically collect all these
> reviewed-by, acked-by tags and all them to the patches for you.
>
>              Andrew

Thanks for the tip!

