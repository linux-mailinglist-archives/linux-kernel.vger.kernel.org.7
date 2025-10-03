Return-Path: <linux-kernel+bounces-840926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31162BB5BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B274A300F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F671A294;
	Fri,  3 Oct 2025 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9PCmBDI"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FD27FB05
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455100; cv=none; b=CfbsD4umW8mf7nXNLpsGcSeiNKPSQiwjG2SMWehisXqFyHimNd0lPDDe6p2uQCDBeXH+H2cnpEXjdqQtmklfKI4X8GH7iLuni7IxogCzHPQcdlyoiDzWpbka/zPc8oDXHhFhnSQDqaLO0i2AlsJFcoy3QpEf2cFiwv3pjathXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455100; c=relaxed/simple;
	bh=yCFFtscpUbpEHzpoWltQ7AJM1I/ghkrTiXICXyatrl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPyP6V9d1BxpoMBgm7kj8wa9EduhqO0HyibBHNw7AsmI6UoIbLVOyHZg8+UrbIp1oQ7MmKztgBpcZEnFTaSdEieLXWxpW5K1SGVhsM4ymEWTcwVDrrCAxqlbNfCjPcGZ5rps8qWLR9Yvd+phem+tqkb9/c5L2wcH/uGhlvOoZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9PCmBDI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso1634473a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759455095; x=1760059895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zgov3mqg1JWQnOI+E7/IFHeQFC41StHTfUVf14re2lo=;
        b=g9PCmBDIpOYR89jsfh5c4pRDFTmL4y4uZQfe3pSBv9XancgTLopODvPVJhgpZ2cLpg
         Kllnt22mrEMrDFdOyNGLFb45BzDyGe1yR9Epwk5KJ/xNR/hIua4WsHfBXQRftx9TZBtE
         LabL2bm6Vjo7YEG+4KPxbQZcaZgVyzEaGezpItV0VavHTDQBO/UhvFUtQiZmB4x1YSEm
         VSQWdv+qgtqMqhFQwv29/tvfYZdL2EH/lyn0woNKX0HIklCZ5KnqJInv/IVMoVS6xipy
         q+S5QiPTkC5pBJPqkCXZDmUVENP1VrtVMdytZrHrsFzVEW+Ul/H1gFvaXCkYBngaUZpj
         XDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759455095; x=1760059895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zgov3mqg1JWQnOI+E7/IFHeQFC41StHTfUVf14re2lo=;
        b=vU+BaMsXe7fvvLAU2w2CDbkuTfttbKvRq2Ws9imNIDzmVQ3ImwbKkLjboEGoJG+rY5
         QUk5cfyoxq9Pori/DhK/wPmMN6Y7SJ+7kIN+1Rm5rmPzCua6eu9DTH/1VeXq2URgFX9A
         2RSWV1CWYrG+STB4T4ABAzSJo6na/0AV6IYG2jAEVsYV3oitLr3Eu2w8vT7wrH0C005o
         LE4eL8YAWEYkseNT5ECgrX6u63ZI81MuL9BseFaVmUgJkX36eMSzbWl/Zn0ta0znZrUp
         0B8dVhySYUuHIuSmTrrV+1WW0P4eCt4APrR/Lzt4emIXGnyi2nBMUM9C2WKSbuhWL39/
         xjmg==
X-Forwarded-Encrypted: i=1; AJvYcCXZzQJK+GRBvsAD62maWPUDhlkoT8DnhcJfKygPa9DiTCNvDZWUoEMrwSNjCVuY+XMNLw6FsZ/oSQZsDKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYdvXSnr6zcwvO0NtDajIWW08palgF1U4kcIIK2JVPo7jQ+sWq
	ES7clNEGQLe0i++JpTQyIyr0jQt9iV5OT8PfKve2BePnCxUhvcc9Ac4MtLMcL+mwGf8LyqwXPvM
	SQsgNoU3jf/jorUAOtPPX9Km1TvOpf0k=
X-Gm-Gg: ASbGncvaSY34Hg8P2sykpebE+rqmtEgYNFzvR822JQGPyVxaLcqkaqNY0Rg5MXubV/H
	cveLyHM/mGKGBYFTnAjR1JMhI4bqcxDKj902b7+vk72xl1abgzGRSOI+A+aKGECAg2F1j3QXZX4
	mUf77bPIEhR12y/TuVOSJKSFfAQl/ZBIbxqMveG/nOu8ZcNoy+AjW3DC5KyuXCj8V0BZGD0gwVu
	xSxf7Uao/OstUEk4fZquF4+2vMVSw60
X-Google-Smtp-Source: AGHT+IFBBcoMSyrE+QoQm3Vaigr5y1LjVm/kF3OscSB6SjPP3hDzPLZ08qOkm20G5zQLmkLNSTYxFMbrlzXKgiaBYPw=
X-Received: by 2002:a17:90b:1c83:b0:32e:7270:94aa with SMTP id
 98e67ed59e1d1-339c27ba06cmr1415539a91.19.1759455094873; Thu, 02 Oct 2025
 18:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
 <20251001-yv5_add_dts-v3-1-54190fbc0785@gmail.com> <20251001-bonding-surging-af8cd0d09e07@spud>
 <CABh9gBcKt1zqvMQ=390HESPR5KrA42jaMFj9Ca4qmeS0d0ToAw@mail.gmail.com> <20251002-outmost-epic-9cb3bab4d352@spud>
In-Reply-To: <20251002-outmost-epic-9cb3bab4d352@spud>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 3 Oct 2025 09:31:23 +0800
X-Gm-Features: AS18NWAaCZIp75UYU-ToloKyuCFQ_kzh-3GlXmpsdfd_oQHvUv7DZqqak8PB7Qk
Message-ID: <CABh9gBebhm3o49o81JcZTLAJZhQDEocJs7inUS+Gn46zOK5DNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
	Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 2:35=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Thu, Oct 02, 2025 at 12:23:47PM +0800, Kevin Tung wrote:
> > On Thu, Oct 2, 2025 at 2:33=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> > >
> > > On Wed, Oct 01, 2025 at 04:47:50PM +0800, Kevin Tung wrote:
> > > > Document the new compatibles used on Meta Yosemite5.
> > > >
> > > > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> > >
> > > You've repeatedly ignored my ack, so I assume you don't want it.
> > > Maybe you want a nak instead?
> > >
> >
> > Apologies for ignoring your ack repeatedly, that was not intentional.
> > I truly value your review and will make sure to include it. Would you
> > suggest that I send a v4 to pick it up, or is it fine to carry it
> > forward in the next revision?
> > Thank you again for taking the time to review my patches.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> The maintainer will add it when they apply, there's no need to make
> another version for this alone.
>
Got it, thanks for clarifying.
> >
> > Kevin
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.ya=
ml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > > > index 456dbf7b5ec8f4442be815284e1ad085287dc443..6f2b12f96bd6ce31b41=
75e109a78d931dffdfe28 100644
> > > > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > > > @@ -89,6 +89,7 @@ properties:
> > > >                - facebook,minerva-cmc
> > > >                - facebook,santabarbara-bmc
> > > >                - facebook,yosemite4-bmc
> > > > +              - facebook,yosemite5-bmc
> > > >                - ibm,blueridge-bmc
> > > >                - ibm,everest-bmc
> > > >                - ibm,fuji-bmc
> > > >
> > > > --
> > > > 2.51.0
> > > >

