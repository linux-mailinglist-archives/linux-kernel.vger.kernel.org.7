Return-Path: <linux-kernel+bounces-774134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B8B2AEF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B049E1BA559F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1E6154BF5;
	Mon, 18 Aug 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7hxJL23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC210284883;
	Mon, 18 Aug 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536720; cv=none; b=l7usCZRWD8QsgYjvqfDN5duMppI3iUN/hywnxknA6r3fmfGDuOdUnrXWPWDyHu45nmDHk03bJITq4rkwiYXM8VgIfJX6RQ4VeORnXu1QkIE//2ZazCtXseguYbODN1yB3BmM+lt/a4J5Xp/Av1UbQ/RGWmD81dZGb5Nd1Q16EYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536720; c=relaxed/simple;
	bh=2pTX/R4Py+esX6AELGCFAc0cDaJtuprLOovPJYw4ncA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnXF3sJwoob6JLSiAYj3SJP+EHoeqvMotBnY4saM44H6Jzr1KF9w+G1uKtLze5868XBnY/YZP7hJ2OBocIsAyN1AB3raBHiq/j3IE1CnGzvFQ3lfHRNWqgDiyN71+FzpQ+ySVOIz92iLCtdMMKXZTkJl5u0CNSUgNX+my+Rgw5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7hxJL23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAC9C19424;
	Mon, 18 Aug 2025 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755536720;
	bh=2pTX/R4Py+esX6AELGCFAc0cDaJtuprLOovPJYw4ncA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J7hxJL238YvWtTSBYmzv632JkJYKjSs44/iCyOvAl/MBQuBFeI4sU270q0stdq/FO
	 TkCEnwAQxp96Y4Jpe8T4FVESU2mhK2ELZp3KZEg9SAJRrHvz3iX6OYaQSLp0ArgXJe
	 0S4+RhZymtUdEPUJVQxppQF7I+RjlGRJtck1sQpI3UoW40EtHn+FthuTbxai9x9jEY
	 lzxly7dTOKfbSPjNIKf2D49i1zyJv5OQ1dh46Ardrw6v7Bg/CRRDdtAW+8XGe858h6
	 3z1eVjgRKlxOMBfg8yXBd96AaS3jB3cjK/0Lx0O5GgnpfCCJRNm0+amZXxjg+uPS2p
	 j/PiengDXWCrg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb72d5409so703150066b.0;
        Mon, 18 Aug 2025 10:05:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWa+usXIHVUPbHTlZIlWDe5Xcrw3fAQEY/mKh+pCEGenVFqPfNJPeQah3lVTlK+s6ih71hr2uydvLg++Deb@vger.kernel.org, AJvYcCWolmU3KPayQCwsJayWXQHtXd2/RuhXBb5DJueFE09MTUiqMFALctprG+VzWotLPgezo+DT1l7dlUu6Zw==@vger.kernel.org, AJvYcCXSshdCQWznQu6YSA1gIUT7HNATb96PFsuaQ5KPitxtF2FCwD7tJu/1UqJWYnc+Y2StiIpsk7cuCtoKIjNzJqC9PIMy@vger.kernel.org
X-Gm-Message-State: AOJu0YztGMKIq+6z2lPuKfQFambBnWBmUXliXCKFuGNpCKRit44cpsth
	Xt0rjqOQd+wq/SUFCv6t/HCy2ZrJwclsliNsXpqRfjo2Dt67sru+nRxkt42mEOW29K4H4SRZUX7
	dVLC8gZOlsruQGhgeAQXJAHnXx+6QBg==
X-Google-Smtp-Source: AGHT+IFsxw1De6goueSiLQsygt063y3Em9LIsPj/3kBuiIIVL0IBXDZEecYRcsxGC9YcJzVUf8Z2AqkfysW0CIPZB9o=
X-Received: by 2002:a17:906:9fc4:b0:afa:1453:662c with SMTP id
 a640c23a62f3a-afdd982dc9amr16474666b.8.1755536718771; Mon, 18 Aug 2025
 10:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430125154.195498-1-herve.codina@bootlin.com>
 <20250430125154.195498-2-herve.codina@bootlin.com> <0770a47e-fd2f-4b6f-9a9a-b0d539ace30c@kernel.org>
 <20250528185740.4bf91bef@bootlin.com> <49e1e1fc-412d-4334-8337-16e352a34788@kernel.org>
 <20250618113232.6d237208@bootlin.com> <ed6beb97-12f1-4d71-b4dc-b34d4d611b81@beagleboard.org>
 <3ff4b3f9-cc8d-4044-b2eb-33010d8951c0@kernel.org> <3889e19e-7f1e-4306-9e11-77a61432b402@beagleboard.org>
 <f3184805-3617-4b46-be23-70cebcf27207@kernel.org> <1884651f-5192-4fd4-9d94-ed755ea89570@beagleboard.org>
In-Reply-To: <1884651f-5192-4fd4-9d94-ed755ea89570@beagleboard.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 18 Aug 2025 12:05:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLSB=6FduyOE_JNRdy=Uf6dLOcHV-O4qa8psjCobJPaAQ@mail.gmail.com>
X-Gm-Features: Ac12FXzzXknuKrR_mxw6Imryz2nV501Hwb_I6jyaeft3v4yNXZVa3MZngdlepFo
Message-ID: <CAL_JsqLSB=6FduyOE_JNRdy=Uf6dLOcHV-O4qa8psjCobJPaAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: Add support for export-symbols node
To: Ayush Singh <ayush@beagleboard.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	David Gibson <david@gibson.dropbear.id.au>, Andrew Davis <afd@ti.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	devicetree@vger.kernel.org, devicetree-compiler@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 3:42=E2=80=AFAM Ayush Singh <ayush@beagleboard.org>=
 wrote:
>
> On 8/17/25 13:52, Krzysztof Kozlowski wrote:
>
> > On 17/08/2025 10:18, Ayush Singh wrote:
> >>>>> Hardware:
> >>>>>      i2c0 from SoC --------- connector 1, I2C A signals
> >>>>>      i2c1 from SoC --------- connector 1, I2C B signals
> >>>>>
> >>>>>      connector1 {
> >>>>>          export-symbols {
> >>>>>     i2c_a =3D <&i2c0>;
> >>>>>     i2c_b =3D <&i2c1>;
> >>>>>          };
> >>>>>      };
> >>>>>
> >>>>> In order to avoid the coding style issue, this could be replace
> >>>>> with:
> >>>>>     connector1 {
> >>>>>          export-symbols {
> >>>>>     symbol-names =3D "i2c_a", "i2c_b";
> >>>>>     symbols =3D <&i2c0>, <&i2c1>;
> >>>>>          };
> >>>>>      };
> >>>>>
> >>>>> Krzysztof, Rob, do you think this could be accepted ?
> >>>>>
> >>>>> Ayush, David, do you thing this could be easily implemented in fdto=
verlay ?
> >>>>>
> >>>>> Best regards,
> >>>>> Herv=C3=A9
> >>>>>
> >>>> Well, it is possible.
> >>>>
> >>>> However, on connectors like pb2 header, there will be 50-100 export
> >>>> symbols. So it will start becoming difficult to maintain.
> >>> And the first syntax solves this how? I don't see the practical diffe=
rence.
> >>
> >> Well, I was more worried about matching which phandle belongs to which
> >> symbol easily. Let us assume that 2 symbols will be in each line (afte=
r
> >> accounting for the indention and 80 char limit) and we have 70 symbols=
,
> >> so 35 lines. To check which phandle belongs to the 2nd symbol on line
> >> 25th line of  symbol-names, well, you would at the best case need to
> >> have something like relative line numbers in your editor. Then you kno=
w
> >> that the 35th line from the current one is where you need to look.
> >>
> >> In the current syntax, the symbol name and phandle are on the same lin=
e.
> >> So well, easy to see which symbols refers to which phandle.
> > OK, that's valid point. Any ideas how to solve it without introducing
> > underscores for properties?
> >
> > Best regards,
> > Krzysztof
>
>
> Well, we can modify `get_phandle_from_symbols_node` to allow matching
> `*_*` to `*-*`. And we can do the same in devicetree easily enough. Not
> sure if implicit loose matching like that are the best idea.
>
> Zephyr does something similar for compatible strings. It pretty much
> replaces the all non alphanumeric characters with `_` in compatible
> string match. Although that is more to do with the limitation they are
> working with, i.e. the devicetree being converted to static headers
> instead of being runtime thing.

This is just going from bad to worse... If there's a real need to use
underscores, then use underscores. But that's all beside the point. I
didn't like v1 and nothing has changed in v2 to change that.

This looks like continuing down the path of working around DTB format
limitations like DT overlays originally did (which both David (IIRC)
and I think was a mistake). But now instead of somewhat hidden,
generated data, you're adding manually written/maintained data. I
don't have any suggestion currently how to avoid that other than we
need to rev the DTB format which no one really wants to hear. Maybe
there's some other solution, but I don't have one ATM.

Rob

