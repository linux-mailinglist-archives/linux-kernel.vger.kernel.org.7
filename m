Return-Path: <linux-kernel+bounces-812119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757D2B53337
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286453B03E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C657322C66;
	Thu, 11 Sep 2025 13:08:50 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55BF61FFE;
	Thu, 11 Sep 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596129; cv=none; b=YoMSQuuUYwmeMlK4AH5YkwlobEaNWW+i0iweF6nVG5dLBLCA+Dx1TwO6UXgvDPUaU30r8rRLoR3T1Fy826IM5UgqmHgWLdNsLGJ8Rl5F1DcWjUJMh6zhG8fKWU77q57a9EdurX5uYlCNv5XFUv+BiiaDwEiGg2f9kaOLQJ+Kd9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596129; c=relaxed/simple;
	bh=xnazJWXBcfz2KniCGMVpI1ypAbJdIZM7Pkx9ejLmHbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ew6z2IFhfUfzlKA3VWmRLDpnWl2MSk44tR7JlyPSBihHuzwGQgIyxq20ejJMYwRo1iUepuB2PLFQjV/TmCeUS65Z3SD7KNJxj3lDUc8/tB02Hjh0ePylEpVqzrSHt6BDH97Tya75l+SK2TaRXvlGzII1f3/TiFTT650UO1YqZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54492cc6eb1so425223e0c.2;
        Thu, 11 Sep 2025 06:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596126; x=1758200926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG5K1nBleVisCU6FRznqNgmm5nk8FGFClvtyMXzVxV4=;
        b=mE16GKznSw7R4D+sOGvVRz28r/dPHZu3VaEwLY5oXj8X5iLXPMnoGiUiFHtTjj+XIP
         Tv7LnqOej2AxhMzU5/xdIuHUWR5R9V+btfA3bEUDsSnHOVLiSECPLknJMaeI16e06NSN
         DwJW/uGHdRlefoOKfT2suJ3mbW5vfP7oloikBKOBpLPMaAISnPLBFzYqiUhulaz3byyn
         4S9svGhPx9CGX5hiecPaj7K2oGawXUljK7AAmLi1/kFdLnIiP5eVnA3jA8rbDDsdaM5T
         QmxYrVOPhHpQc5+BxYVNlq0ST+ErmTWi2XtgJbHALi7gSxN56/ufTWHRSOB5VvaFi/r3
         MnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0b6Vtb4ATOOkDMmztTG0SlIaNlweUze28Ma03PgzXE8dICDN+Pl0LA6JSDDFQQUgyBgnhkQeoV1Qq8Q==@vger.kernel.org, AJvYcCUK2FgK06mb2xRgEiN67xB0J4Yp1DVLmhmyuZRPwvHg6MrAr14RiiuNCq+yQVAj9jklPCC+ZIJdBItRqGE2C4rFShjs@vger.kernel.org, AJvYcCUmQCCquGTDkATONNY5GQmtSkDuxaYzrhcxaybPIwtDSnU1IO7uI+E13gS3M9JNtmD4O0+WniV7Bmig7+RN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxy3wrwh1eQYawPc2Tig6m5a4oWh9PR05wggm45XVi1IAG3wRH
	DF8DA4DYDlIucHX1UhrnlNu9otWork/iv5mV5PAsDOTMWNHjjkQbs1Iaedh3Nryb
X-Gm-Gg: ASbGncvF/S7qyHgtWvjm5wgg9dUCX+R+Rn6eq0wf1U/y8ZAqmrmBSWTNtqN9Ob5UQzx
	s5KBLs8pE2nkglgJX2E/RtszFluvmkqlN4l0gZkKJlS2SvqXCcotBLV5P7B6E0flZUwfazADgGJ
	DV3Cn+jVbU+u6DnHsC3JUqWC4fSF2sw2/AR/OYx9TgEQyLU3lpUZzEuuexXgIDDYMu0UTi5uKQu
	DNQ7T6Outeev5wMxCGMBMOut8o+0vNWEeLzOFNqHHVieeUI32aXWMS8H4QKmkLA9hknH11RK5dc
	TqtyNLKWQxep3/jUXLlyQYGqog8MvDtsSHKTimIViHdwnV8fqESorJh6RWmxBtDLlDRRoR26DzE
	Yx+A4D0br2jwBuGRhonvbtuw/mwftg2EnULRIikV0Z7k8WrhzjFBMU+0FfyU/P/PnSiJfj6U=
X-Google-Smtp-Source: AGHT+IGzL/CY0kZABIxLgFRNp1VwmErV/BXkJOZZzEs8xd8q0QhVQAAd6bY6gG80iofntF0TgE37qg==
X-Received: by 2002:a05:6122:658b:b0:544:4ee5:1334 with SMTP id 71dfb90a1353d-5472a006752mr6459760e0c.2.1757596126118;
        Thu, 11 Sep 2025 06:08:46 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d424de5sm226943e0c.26.2025.09.11.06.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:08:45 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8a00c77a62dso475553241.1;
        Thu, 11 Sep 2025 06:08:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEELFMiePh9rxmJIBcpY2pTqRBhc8o6NS+xHNlUqBODIQLouY687bkcaGvH5u0rG8Ad47EIyI+T00D28THCDqsvB/7@vger.kernel.org, AJvYcCUODt5RiujDffl9VOT40/mJcTeyf0/SbnFNCuESZ5o3gOScJMgrNqbSFOwG0mwnDHMlBvGtGxkzI9mjexUR@vger.kernel.org, AJvYcCVrJkhxl7I7h2vM5mjdSlWtdbzZjMrUekUSl8Fhyn2atQTDoXFL+Mns7Glj+Rvr/UVDhSm+AiZNO8ID7Q==@vger.kernel.org
X-Received: by 2002:a05:6102:5107:b0:534:cfe0:f861 with SMTP id
 ada2fe7eead31-53d21db953bmr573995137.18.1757596125422; Thu, 11 Sep 2025
 06:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902105710.00512c6d@booty> <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org> <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com> <aL-2fmYsbexEtpNp@zatzit>
 <20250909114126.219c57b8@bootlin.com> <aMD_qYx4ZEASD9A1@zatzit>
 <20250911104828.48ef2c0e@bootlin.com> <CAMuHMdUUGoaetdsTEVx27TYQZ_khzyCn0wzi2+TibYcvkg1fXw@mail.gmail.com>
 <20250911122333.2e25e208@bootlin.com> <36a85af7-75b1-46db-8df8-e83372d33b93@beagleboard.org>
 <20250911144506.51809eb3@bootlin.com>
In-Reply-To: <20250911144506.51809eb3@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 15:08:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULiX83n5bLEipE1j99HyuyXCpAYS9qYu-8y_vmEyO_ag@mail.gmail.com>
X-Gm-Features: AS18NWC8F9c9Xz1zFrQjM9AgyEVI6jdiBD3mJBt-Ew68CVPoMvwon9xnR63ml5U
Message-ID: <CAMuHMdULiX83n5bLEipE1j99HyuyXCpAYS9qYu-8y_vmEyO_ag@mail.gmail.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion at ELCE
To: Herve Codina <herve.codina@bootlin.com>
Cc: Ayush Singh <ayush@beagleboard.org>, David Gibson <david@gibson.dropbear.id.au>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Thu, 11 Sept 2025 at 14:45, Herve Codina <herve.codina@bootlin.com> wrot=
e:
> On Thu, 11 Sep 2025 17:45:17 +0530
> Ayush Singh <ayush@beagleboard.org> wrote:
> > On 9/11/25 15:53, Herve Codina wrote:
> > > On Thu, 11 Sep 2025 10:54:02 +0200
> > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >> On Thu, 11 Sept 2025 at 10:48, Herve Codina <herve.codina@bootlin.co=
m> wrote:
> > >>> The choice to map connA to the type 'foo' connector expected by the=
 addon
> > >>> and the choice to map connB or connC to the type 'bar' connector ex=
pected by
> > >>> the addon can only be done at runtime and probably with the help of=
 a driver
> > >>> that have the knowledge of the 3 connectors.
> > >>>
> > >>> I have the feeling that the choice of physical connectors to which =
the addon
> > >>> board is connected to is a human choice when the board is connected=
.
> > >> All these choices and decisions apply to single-connector add-on boa=
rds, too.
> > >>
> > > Yes, in our use case (me and Luca), each addon has an eeprom, wired e=
xactly the
> > > same on all supported addon, which allows to known the exact addon. A=
lso addon
> > > insertions and removals are detected using some gpios wired to the co=
nnector.
> > >
> > > Based on that our specific driver handling our specific connector per=
form the
> > > following operations on addon insertion detection:
> > >    - load a first addon DT to have access to the eeprom
> > >    - Read the eeprom to determine the addon type
> > >    - load the DT matching with the addon type
> > >
> > > This part is of course connector type specific. I mean having an eepr=
om with
> > > some encoded addon type values and hotplug detection with gpio is a p=
art of
> > > the contract between the board and the addon (part of connector speci=
fication).
> >
> > My usecase is a bit more complicated, since I am trying to model all th=
e
> > available headers on BeagleBoard.org sbcs (particularly PocketBeagle 2
> > initially) as connectors. However, that still ends up being a single
> > connector which can have multiple addon-boards simultaneously instead o=
f
> > the other way around.
>
> In that case, a connector cannot have the state "free" or "used" handled
> globally by a core part.
>
> IMHO, each connector drivers should handle this kind of state if relevant=
.
> I mean, in case of "pmods" compatible driver having this state per PMOD
> connector could make sense whereas in "beagle-connector" it doesn't.

It depends on whether the add-on board has stacking headers, or not ;-)

> Also, on my side, with my 2-step DT loading, the first loading should not
> consider the connector as 'used'.
>
> All of that is implied by the "contract" between the board and the addon.
> It is connector specific and so should be handled by the specific connect=
or
> driver itself.

Since stacking boards is a fairly common use case (beagle, rpi), perhaps
it makes sense to have a simple method to re-export / forward a connector?
The alternative would be to re-describe and re-export everything.

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

