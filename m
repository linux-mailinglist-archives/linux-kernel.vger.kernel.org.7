Return-Path: <linux-kernel+bounces-724898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FDFAFF843
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8C2487146
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B548F2192EF;
	Thu, 10 Jul 2025 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ENcTZDlE"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D53B280
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123493; cv=none; b=CLBlec4f2pQRwYnM8Zq6OIxYtnyiurBn7kjj9h0uOtYB3tKpqIqNVQjPX1d0a3KtyA6ZKmgj3byDOI5HO8ew5Updeir9OEP6nFehD6Rkg7+t+p6Gb3JoZNimsVbuIrJktx9irL/Gau97t3pGdqIoGLKGm3UGNMoHWhJL2ez7jZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123493; c=relaxed/simple;
	bh=yO8H/Y98j2CWVFUe/hDF9GBVVNe4jMEqnXPweoW3ibI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLPYv6G/IPLai1fAr0wDup6E8f1asP3ZkPPjI6lhKMe2N7UbmcQmcgHxAUabxoyOcDWg/msLq586dZ/ul5HTiyb4fAZzjxJdAxb4Bf5rmFAqxFd2JA1ufhYguaXCCk5yBpasraddU+d3JXcNf2gVLMH4IYSaePZmgWU/EC6fRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ENcTZDlE; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e82278e3889so383548276.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 21:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1752123490; x=1752728290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEpA0IRuEna9Mxwq9qK3aS6tQm5TZpbjQfz5HQP3aX4=;
        b=ENcTZDlEtLmEGtIuDnjD/X4aGnh6tWV0XhGY6ld0OpVwWxNQi/j2dOK5ujRcY+2kba
         YkK3umA0RsljqZJ2InrwiLj5iNwjKl5xOnzgnJyGKxM4GCKYND+OG5Rhf5kICQ4n/4CB
         dKtEwXJuM4E9MqWs0lBjdA8tA/DRpzSpavQwzP4Yqg8IpUSvpO32/jfNk80InwMt+tJ7
         Gy3bJ+rMKZErcVC9gVbm6OWoK40TFNR2T4X++sSvvSFHvM97fRkhYO/AOOSRKe4Xhm5k
         DkwENA3+oN1jTGLkKJrIgBdfHNDYvcaLpmfiKw+MLWP8NmK4jIpGleSw9m8KAAhzMOgH
         rM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752123490; x=1752728290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEpA0IRuEna9Mxwq9qK3aS6tQm5TZpbjQfz5HQP3aX4=;
        b=Ae/fB7N/gRFoc19FuJKJbF7S4x5dqYiLVAm5UyiOH36Quqyw4bcaSDUROb6wyl9+LG
         z0w+9vQssqmzjdSVCNZXaZjOySwkHQwOgal7HpW9kRtVG5xcaAr2NpxiQyCerViIZ9to
         endz9/vLsdBsFmsFmHvl+xeaDmJdH+6gIdNZSGTy0KjTQB7pU8ka1vhEzjHY4QtEXLPI
         EUqwlVU/L5ENF6U3leYaxMjcJM+I1TSPrUdREeZiZF6A2PNs5c/UHNQ5YMOHD35buzMO
         Ns0nRfppUePsascGu8f2LZaML0HU4jQrKYXueuFjgfoVEWYPwmm4YwP/xCe7dhyy4Q0m
         VAGA==
X-Forwarded-Encrypted: i=1; AJvYcCVnJrt89sLWU6BOLMF+p/sy0McC9juUNdkXwqe7CeJHtJSF+bai1nwqzZu5O/OF1E367wLQQENXNlvOSXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQNJJiT7wWekAeg+gv9Zdu8/l+pxj02+v0pgxOghG69kGtX6dq
	TkYLnjAG/+3SW2HfLyRyCD13/AoimmdohO7jVxvir90Gg0t4rUSyVYLZeEF7KzXFuuDKDLAbG46
	Zvjb87EuYLLVHEhWBl56w/ESxfwjH9xgONwdHHDArMg==
X-Gm-Gg: ASbGncs5a28kXWEbIervgGV/mJnHwyiFFcBYb+UQC6s5xDS1tdQknsWyxdEimmAAbah
	wK0KvFY2MVafLc6ijyjjEJY55voCnY44JXjzA1JhGImyNEXMLCPfU9xBKE/KkvD14beMqVFBTaw
	6o68M96FYO29IsM2fpwxIx9/s/da2VxEoX5Tu58k7NNkxkiQ==
X-Google-Smtp-Source: AGHT+IFBYcBC73q2IeV+mY8fvhVWFYle/lCmmpRL/KWBCNFpGZtXkk2v1VGFKH7y6dlMRGRRkw9pg5tbSYlMjv4lsDk=
X-Received: by 2002:a05:6902:2843:b0:e85:fba9:30d0 with SMTP id
 3f1490d57ef6-e8b6e1078d5mr6486297276.2.1752123490524; Wed, 09 Jul 2025
 21:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708065242.26371-1-nick.hu@sifive.com> <20250709-startup-coasting-aa58a99c5585@spud>
In-Reply-To: <20250709-startup-coasting-aa58a99c5585@spud>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 10 Jul 2025 12:57:59 +0800
X-Gm-Features: Ac12FXx9o-b6Tc_SNFG1ki4fAOGr8tZ3fgq0-I4XfIsnvROH-808KefUmWQHcuM
Message-ID: <CAKddAkDM_-w-y9bcHj+5-afDBhd1rbV-x2JZorE8S9k0u3JSxw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: riscv: Add SiFive vendor extensions description
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:00=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, Jul 08, 2025 at 02:52:42PM +0800, Nick Hu wrote:
> > Add description for SiFive vendor extensions "xsfcflushdlone",
> > "xsfpgflushdlone" and "xsfcease".
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
>
> You have this, but no user or anything along with it. What's actually
> making use of this? If it's just for the SBI impl or w/e then say that.
>
It's for the SBI implementation. I'll update it in the commit message.
Thanks!

Best Regard,
Nick

> > ---
> >  .../devicetree/bindings/riscv/extensions.yaml  | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > index 72c1b063fdfe..10c37c61243d 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -626,6 +626,24 @@ properties:
> >              https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev=
.-5.0.0-Datasheet.pdf
> >
> >          # SiFive
> > +        - const: xsfcease
> > +          description:
> > +            SiFive CEASE Instruction Extensions Specification.
> > +            See more details in
> > +            https://www.sifive.com/document-file/freedom-u740-c000-man=
ual
> > +
> > +        - const: xsfcflushdlone
> > +          description:
> > +            SiFive L1D Cache Flush Instruction Extensions Specificatio=
n.
> > +            See more details in
> > +            https://www.sifive.com/document-file/freedom-u740-c000-man=
ual
> > +
> > +        - const: xsfpgflushdlone
> > +          description:
> > +            SiFive PGFLUSH Instruction Extensions for the power manage=
ment. The
> > +            CPU will flush the L1D and enter the cease state after exe=
cuting
> > +            the instruction.
> > +
> >          - const: xsfqmaccdod
> >            description:
> >              SiFive Int8 Matrix Multiplication Extensions Specification=
.
> > --
> > 2.17.1
> >

