Return-Path: <linux-kernel+bounces-811666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858DFB52C48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405E0483E08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029F2E6CC2;
	Thu, 11 Sep 2025 08:54:19 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D152E62C6;
	Thu, 11 Sep 2025 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580859; cv=none; b=MYhqaG9NQawK4MBZRuzwArhPqzgJ7/zp04GTT+MoH88DbUhOAnGxopN8e7G9AKLYJnZq7fM4BufFoiy4umMNhHp5vXgnOvrlbFgtguSlaAWl//SoxiUQwhXLf9DrLfYxuoPxI2W1P8/ptMTTrmZwEWyV5Feope/Mlc65o0PSNBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580859; c=relaxed/simple;
	bh=JNFs8pP44gG7ElIniPIfOVDWDeqP2znoKiE+rRVc+/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOtv5+8K2EW4uj3zWI9bjwM36zpm10nKZMkWCPBzUMKjoGC0NOA8to3PDohtbV95b4/YMXZGlcpRmY+cLo0/7+6IBjX4Bjn5nSgfW2uankKynMmd+J42AFbTt5Tyui6eJTOrUl/Ol8SETS2vu6qKGwnTA+x70lJuKZiBfbweoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5464d3b50e3so182528e0c.1;
        Thu, 11 Sep 2025 01:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757580855; x=1758185655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Yn8cKNuXMAELrxYIIRAc2XhG/sfZknQ8GUCpOIV95k=;
        b=kENtus4d4F8LJMdjQjcsbB6yyBUEcXW6AphTWlsVQH+Czd80rSkTCMNw9AqdONJU7z
         dvmswxnk8561FdUuJT93g8nqbD7g1IhMhcu8HVfej4fhEHWTD58NCr59tKODhKZTo83L
         IsOElhbsUKnHzFClLZ4LVetWxCHWoXUYuS9brcYWsxY+kxNtzbFhiYN1GeAS3PJbiRED
         DPISwj77Gy2UKI7lWotDoVX/dXTJqm/dDOF/2xgMjOHNd4H74xqI8hxHp3hPzZ/QKk2N
         y+IU/xYDBlOXNygzPg6H8Q2MT8CNEDdhY4zyVwoE4Z4t1EtyGRg+r6uEIlM2RxkmZ0hh
         FV6A==
X-Forwarded-Encrypted: i=1; AJvYcCUwGjzMFFHCHoZ+Xn4/mmCnCnxEDltXlJnhGlHPX2pRenURFa94Q226++V4+NDfNF0F/t7WcW/AYWHATw==@vger.kernel.org, AJvYcCWF4yYpcDEFDxObX8AECR+IIhuvGqVI0i4jthj1RS56wqg1PhwXUJigpiMjRfr/zrq2g7QMkDpV3ObYJ8nz@vger.kernel.org, AJvYcCXD3ov0K5WsnFF1IOrndhqg4vvyMjBYUqXTIe67WGO7J9K+UDoT838QknHh06CZCk6RiVqkgSaEAfHGZALEA/LHlTEv@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQ5fhCLLOupaH3xKCTumGE5hD85LS6b4DsvaoKhqG0nKAAfVH
	4o8QJqyHKJ8DlWx5emph7C1i/8dzs5+ZDcQ0M/Pl2vo+kekbQPc6t7Idj71XQVvn
X-Gm-Gg: ASbGncvfXts9QtwEpQiZVDb5yAaWhhzKEMXbNPZqECo+iuraBi3kv1nFrN7A6ZzoQmj
	Ffk7cg8E00XQAD9vqqESSxXluxyUKjuu2WQIuhLhE5ApCFsOyldiuhSGPVZR4V4QUHyfofNf2tZ
	hIRQVhZ0sO/BDPE7a/pdl9b5yWQohRSux2bvCb2IC+bOG/7Fxs5TY4ovOX4VpcPNKNINOQ2F8Ni
	EF4WHJOIVPU3KW9vHc6XvgM/7zflg0a5RTDmRp1AKYfzFLPhRmBsvFt52gQIM+RIYFcuf8kPfI5
	/mPIMRzfD6DFl6fN3BUVYn+jq2N98z9lQF7J46GFhoYHtdlwHJD0KzZ9QghZ35hxYZ12WwEVb6H
	VZwIsbR0by77FE9901HshRhvftEE6Kc5jJ5GNiOY2L35eyB7HYyaEZn4yWf6VF9lB
X-Google-Smtp-Source: AGHT+IGBVRLytrLdgRtu470BHcrsrt2L/G9SO4bozmvC2w0P0a+q8VAjJv7ix8DuoqEz9bk0K7VPnA==
X-Received: by 2002:a05:6122:17aa:b0:53c:6d68:1cd7 with SMTP id 71dfb90a1353d-5472cab5777mr6628395e0c.13.1757580855583;
        Thu, 11 Sep 2025 01:54:15 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d1bc289sm166829e0c.4.2025.09.11.01.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:54:15 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54492cc6eb1so285360e0c.2;
        Thu, 11 Sep 2025 01:54:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZiViBpr87awuoVLen2j0W7oMk48YrEhdqypX1WtKAsm4KaEME9Od29NTn5A1yUsteKRd/svh27lX/ZwHb@vger.kernel.org, AJvYcCXAIhzfM94++O8dRTpfBR4D21+BRS50WASu4a6EBxokUtV54PucDCz4+xZ7DA+QmOiMeahWnOsAtmmgK/0A5+We6itq@vger.kernel.org, AJvYcCXq04AwTS5ERUzaYFM8cMll66LQi8yvl8DbRD+S7xX9ahHBU4hXauv5t2lBsCsg78YfZrsZszwvrGsbiQ==@vger.kernel.org
X-Received: by 2002:a05:6122:c99:b0:543:58b0:861b with SMTP id
 71dfb90a1353d-5472c0d3bedmr305259e0c.11.1757580854863; Thu, 11 Sep 2025
 01:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902105710.00512c6d@booty> <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org> <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com> <aL-2fmYsbexEtpNp@zatzit>
 <20250909114126.219c57b8@bootlin.com> <aMD_qYx4ZEASD9A1@zatzit> <20250911104828.48ef2c0e@bootlin.com>
In-Reply-To: <20250911104828.48ef2c0e@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 10:54:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUGoaetdsTEVx27TYQZ_khzyCn0wzi2+TibYcvkg1fXw@mail.gmail.com>
X-Gm-Features: AS18NWAoVrbTi79NC74S-5_lAIcg-X7SRp4SYN3okbKZAVMg_B0GAQdWQr377H8
Message-ID: <CAMuHMdUUGoaetdsTEVx27TYQZ_khzyCn0wzi2+TibYcvkg1fXw@mail.gmail.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion at ELCE
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Ayush Singh <ayush@beagleboard.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Thu, 11 Sept 2025 at 10:48, Herve Codina <herve.codina@bootlin.com> wrot=
e:
> On Wed, 10 Sep 2025 14:33:45 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Tue, Sep 09, 2025 at 11:41:26AM +0200, Herve Codina wrote:
> > > Suppose a base board with 2 connectors:
> > >  - connA
> > >  - connB
> > >
> > > Case 1: Addons are independant
> > >                +--------+
> > >   connA <----> | AddonA |
> > >                +--------+
> > >                           +--------+
> > >   connB <---------------->| AddonB |
> > >                           +--------+
> > >
> > > With addonA and B two addon board each connected at one connector wit=
hout any
> > > relationship between addon A and B
> > >
> > > Case 2: Only one Addons using ressources from both connector
> > >
> > >                 +------+
> > >   connA <-----> |Addon |
> > >                 |      |
> > >   connB <-----> |      |
> > >                 +------+
> >
> > Case 2 is what I'm talking about.  Case 1 is the easy one.
> >
> > > The addon is connected to both connector and uses ressources from con=
nA and
> > > connB in a dependent manner.
> > >
> > >
> > > The Case 2 can be solved using a connector that described both connA =
and connB.
> > > Having the split connA and connB is a mechanical point of view.
> >
> > I don't think that's a good solution, because it means you have to
> > make that decision at the board layer.  If I understand his case
> > correctly, you have a board where you could do either case 1 or case 2
> > at runtime.  We'd want the differences between these cases to only be
> > reflected on the addon device tree, not the base board device tree.
>
> Based on my understanding of Geer's use-case, I think decision at base
> board level will be needed.
>
> base board        addon board
>   connA +--------+conn1
>   connB +--------+conn2
>   connC +
>
> Or
>
> base board        addon board
>   connA +--------+conn1
>   connB +    ,---+conn2
>   connC +---'
>
> Or any other combination that would match.
>
> From the addon board point of view, the only think we can
> say is "me, as an addon board, I need a connector of type 'foo' and a
> connector of type 'bar'".
>
> Also, at base board level, statically defined in the DT
> connA is described (type 'foo'), connB and connC are
> described (type 'bar').

Correct.

> The choice to map connA to the type 'foo' connector expected by the addon
> and the choice to map connB or connC to the type 'bar' connector expected=
 by
> the addon can only be done at runtime and probably with the help of a dri=
ver
> that have the knowledge of the 3 connectors.
>
> I have the feeling that the choice of physical connectors to which the ad=
don
> board is connected to is a human choice when the board is connected.

All these choices and decisions apply to single-connector add-on boards, to=
o.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

