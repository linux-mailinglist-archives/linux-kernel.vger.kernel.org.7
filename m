Return-Path: <linux-kernel+bounces-806024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6196EB490EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B666189692E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E523081AC;
	Mon,  8 Sep 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlMHOIKW"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B430C62B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340789; cv=none; b=d/XOmumEq8+lQ+JqXoYSXQNxddq9b6MpFHR++Kh99qDuLM3ZzPBOgOTvSKJeedO4xaMSwYvKK+rvpx/BZfKoQsscswXHJSr3Pl/URcNFEkuNc1FLUNUbLkfikTZ/YSmBbbfk8+9pVdwK9b1AKQ2n13h3aKRNYY1s94iFiBBurb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340789; c=relaxed/simple;
	bh=2fgRlL6oi2NJYIr3taFUqWRo08czRzxQd00ThPrISyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iu4ANY93VLt1RmdpWeyuzB48hBiI4fVoonlB7gucrYMvcWdQu5GiubZoPMyKrieL9ea7K7tuHiGFg3q1VyabTHCJMat0KVNX7TJvbpZ0b+51dTKvLodYonio/KRYPN8n/Vl8oY9sMSZr4lhHdSISsg0c7yPR/trfSfp6ZlK5qo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xlMHOIKW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-244582738b5so36800135ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757340786; x=1757945586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRlboR1j/sYEZ4y8841eR/apYQLD4WGaeuEbSq15i7s=;
        b=xlMHOIKW1s0WHPYXDCO56wNWuZnSpEMjPC5zg/mHAGFv4MeWwMQpW3xfj/wxjaqTS/
         ev0rFoHBwGiPrJLykBb5ZZOg6g/FgWU93d6UofhBks3uDP3qu9bIbHMjFgMoE36CLXPs
         HuUWCGRTtCKIbQcALx6GsaTgLaRQwNSDedJeYTGTeQPPEPjLG/8f6Y6bp10JI40Kp4dE
         ownT4YokmdrjwCs8pN1NXF7hH/fCp1PN3OXXk4Olduf79tEA6yOiT22sxkh2CcwuIsqM
         kqnB8zmQezvFtrI05w8zq6RKkl93JwFbvsY4K+88Z/V01ONg7nucc1gFpMJUS7nZKshe
         qdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757340786; x=1757945586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRlboR1j/sYEZ4y8841eR/apYQLD4WGaeuEbSq15i7s=;
        b=pOhtsKhw8LWxMTlLSVqBRvUo0oijaY471nS7dBfi1EQRC5+PX0Qi6NT03xyVQ1uaRJ
         IiOuJZ2AlfZexmw2yRhxlSQRvluMCL0qfUQXAJ3MmyKMg193JbyPg1F3PhdEzC84ZXlh
         XbN3k5MsIcZ0OJDOIKZKpP/vsf7j2PAyyWHnmBlmOSdFYyv6iZBNNv8zkL5n9nYREenq
         ww1B8TfmtZUCYKaABj3nCicI57HC8X66K4cn47b5Imsca/qIwP005LQXH36c+Wq6FDsz
         oojRjlcmRTwLOlPwhHPx7VaIH8HymF7RAcgRlSpx7PsOHGvLZRj+ewfZb5Iphkujt10h
         T35Q==
X-Forwarded-Encrypted: i=1; AJvYcCXB+bKrtYgSXVz49dDmq667dKJrYtP74lvDzxMeqzIoC9d3RVE+Zjk7HCsePsoyKqAXzYRhIrA/Y1VSWjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySfzoh5Z2Ty7Kqigk+x6lOQ8Ssen+3g6z57SKNbNVTeLsO4YZK
	6BSNljQPMnQhqXd1nXeXDRrM44NrbQ33Mu79N3h5eGr2duJr1l6io0gGymsI7c9muEMbaFeQC1U
	eTK1w2v+9gfireV8eZE3sKEevDPUwzFRVg4xEQ3rbkQ==
X-Gm-Gg: ASbGncsSuNeOMlIgbWLKPnOScmgVqKqOXRzXhdMsS0nH54drRUbZjAJSOpVuwuSlJF3
	FomDXDn3slFJ4BTfKs5Bm6YCQYg1QXVuKQjNS54SgN6BJ2/4Iv2GHPk4uCuOP5hNbURgrOkNMjh
	B60tWB/Al4QbiqSwJtfR54RzwFHI9VdbXbn8mMSqXacW6IYC/XbKiihFcn+6UsLCdJjRJ+FkLCK
	cWwB//8Hty/abJd
X-Google-Smtp-Source: AGHT+IEd8DdkxHgdaG5plUgmcm8Xuep198UNJ25N/qeyATAB8uk4bXjSIchDB/WbiLdPYyk6tQDnOBhph3KDrfflqKY=
X-Received: by 2002:a17:902:e94e:b0:249:2317:e811 with SMTP id
 d9443c01a7336-251756beeb0mr90842655ad.50.1757340785596; Mon, 08 Sep 2025
 07:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902174351.2457022-1-raymond.mao@linaro.org>
 <aLkAYitpWxWx131p@zatzit> <CAEfUkULwQxJ-EKT7bQ8+hkH+_xO8esThnL2P_Rc-32tHyMdA1A@mail.gmail.com>
 <aL5VZfOoy1g2uyAH@zatzit>
In-Reply-To: <aL5VZfOoy1g2uyAH@zatzit>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 8 Sep 2025 10:12:53 -0400
X-Gm-Features: Ac12FXw5u9129IUOnarwDAGAPCUwyAKhMBzRBf8Hu3dSinGoA8aJlhBDSSH3Di8
Message-ID: <CAEfUkUKtXZnGsyJAqGaBHE1CpRFOfA26FVuSRjXc+f=UAeK=-w@mail.gmail.com>
Subject: Re: [PATCH v2] docs: devicetree: overlay-notes: recommend top-level
 compatible in DTSO
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linux-doc@vger.kernel.org, devicetree-spec@vger.kernel.org, 
	devicetree@vger.kernel.org, ilias.apalodimas@linaro.org, 
	Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 8 Sept 2025 at 00:02, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
>
> On Thu, Sep 04, 2025 at 10:40:31AM -0400, Raymond Mao wrote:
> > Hi David,
> >
> > On Wed, 3 Sept 2025 at 22:58, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> > >
> > > On Tue, Sep 02, 2025 at 10:43:50AM -0700, Raymond Mao wrote:
> > > > When managing multiple base device trees and overlays in a structur=
ed
> > > > way (e.g. bundled in firmware or tools), it is helpful to identify =
the
> > > > intended target base DT for each overlay, which can be done via a
> > > > top-level compatible string in the overlay.
> > > >
> > > > This provides a way to identify which overlays should be applied on=
ce the
> > > > DT is selected for the case when a device have a common firmware bi=
nary
> > > > which only differs on the DT and overlays.
> > > >
> > > > This patch updates the document with a note and example for this
> > > > practice.
> > > > For more information on this firmware requirement, please see [1].
> > > >
> > > > [1] https://github.com/FirmwareHandoff/firmware_handoff/pull/74
> > >
> > > I think this idea is probably useful enough to be a good idea anyway.
> > > However, note that it leans in to an existing ugliness of the overlay=
 format:
> > >
> > > Overlay dtbs kind of mix "in band" information - the actual new
> > > content for the tree - with "out of band" information - how to apply
> > > the overlay itself.  Whether a given property is data or metadata is
> > > determined by it's place in the tree in a moderately complex and not
> > > super obvious way.
> > >
> > > About the clearest divide that exists is that generally the root and
> > > first-level subnodes are information only for overlay application,
> > > everything under that is data to be applied to the tree.  This all
> > > tends to have names that would be unlikely (though not strictly
> > > impossible) in a fully applied tree.
> > >
> > > Putting 'compatible' at the root of the overlay is putting something
> > > that looks very much like a regular device tree property in a place
> > > and with a function that's purely about applying / validating the
> > > overlay itself.
> > >
> >
> > Since all information at the root of an overlay is considered as
> > metadata (out-of-band),
> > If you think 'compatible' is confused, I can change it to
> > 'overlay-compatible' - which should be 'unlikely' to exist in a full
> > tree.
>
> No, as I said, I think the advantages of this proposal still outweigh
> the disadvantages.  Just pointing out that this is highlighting some
> of the ugliness in the current way overlays are designed, which is
> relevant in the context of concurrent discussions about connectors and
> the like.
>

Thanks for the clarification. Yes, I agree - the overlay format does
blur the line between metadata and payload.
I appreciate you highlighting the broader context here. I=E2=80=99ll update
this patch with 'overlay-compatible' as a clearer, loader-facing key.
If future connector proposals address this more cleanly, I'd be happy
to revisit the structure then.

Regards,
Raymond

> --
> David Gibson (he or they)       | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you, not the other wa=
y
>                                 | around.
> http://www.ozlabs.org/~dgibson

