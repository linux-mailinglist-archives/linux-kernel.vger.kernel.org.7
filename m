Return-Path: <linux-kernel+bounces-832841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB992BA08B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCC51896D84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB60305042;
	Thu, 25 Sep 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIBV1NA/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE52F617E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816421; cv=none; b=j396Fp+bMfKYjf8J2kdZln9W+5bLqqTwEO3PTCxNX0IBaPtbch1yzPyrp2weY5Srz5DfzP3MmN79k4CLT3gps9R4/n940Jv2gQOzgC68MQWd5ISv8saX1sCrQ0einq6oKk9MjSE4dTb+fA+anVnfSPH8S2FBWkG2Yxs/2v0083o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816421; c=relaxed/simple;
	bh=BpXsWsbIWOdqk7uF/WtIMG7A8mOG0ib8Ejk2jxL4vcY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhRi58wVk+bXf4cncWocia1x+i8c8WDqR66Qe5I5wjou8s6MWeH4oJRzmsYexDPe9TSKnFkvNvgniCTti8Tm1SIpTW3+ixycIxmQJ7iAHvJ4zojIpIwZE5F6ru4j69m0S6jqlemDLGtvTbOhZ5SzDdp8nsuRkhodb+DoRrlZdmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIBV1NA/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1077784f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758816418; x=1759421218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v+lassDmCrGUqK1j75W06mPpLprXWJRC5SDVpvwTaVY=;
        b=BIBV1NA/0JnyvO/lqOUBARKBtEQFtciN9/cKnCyRy+nfEteg8ShWM1CM0xBpmQPjVS
         TX9JXzb3EH1MiuFbdcAU/a9RUEhOh3idfouUNu3l3dmKMTL+uU8s25cPK8JS3A/+8BZC
         sEPoxzGcb7Q8Ogc8J5N7c7V2+T9+E5agCkrtt8heHUJcaaaMNwbpmDD0KkGTu7nBjdi/
         kfcZ7KSDnT1GmohZbRgb1BLkLK91j784ooFeBT9B8lEvOfN9ezpBCGCEDWdxwIAHnti3
         goVzJIiYEhEdExoRhKk+9xCbeEqA++P1nZKRygnH+vWBgixId0Hz3GSlEEEYtaC1T3va
         HIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816418; x=1759421218;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+lassDmCrGUqK1j75W06mPpLprXWJRC5SDVpvwTaVY=;
        b=E9aVIw5MeT/s+vxT51P0zgwlKb6Mu6WNfd/+GCirxrKKzjRLWsaJwZHXrPj1P7lWX2
         QVIBqyAumoWgkalBQRKh2oOVj7jaRzPmp3nMeQdkNHXKu4r0ZdG05/aZx5gR5unjjjLV
         AccNEbpHdsk1YvSF9b01JLFA8MulcR4D8dpo/qrbprHQVQq4h61b71zcnMNlPf81JJ2X
         i3nq6qTMRkn5/HEjcM1B98vbvXhJYrdx/WLZ2c3nv2MnDEYfG/7j7NqgIy+CmNKEga1A
         xWeymcPbID0VzSTsCrk28ZTOqhBYuARx7DjZwc1+kHQ9XRj0BOQqralWMbbKMT64qqhE
         Hq5w==
X-Forwarded-Encrypted: i=1; AJvYcCXjN15uGXR2DkJupKikzi1X52v7Ngbtv0tmIHsNHIDkQJ41Igm9oodzrNyyRlluPy+GeHtQ4AcVqOgIWXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqzbywqgy+gXR5D4pTd6vCxzQElCWPNS3sv1DMrVX5iiXXonNO
	hC20VwhCINIowW3DgMhgvakqwu1HkmKkwi/OHJLr3B9E0niEzCJma/Io
X-Gm-Gg: ASbGnctCJd+MTEzTaIsU/x/MqEI7JGPawPfIujSqvnOkuFwFCm3GXo7s79URi707PIV
	BINtEc9P0K816UERFBx7I4KlKm4ZWTkqH5Gbs6zGVFD1Fayv5NqBHPgSzED9fdbHSm0VY8DlTMG
	VsqtccLC+hiwK4K1wRsezycCKZObZdvg966gpAmimEGvsj9BwHkl/qoBRD8lgiT8lIHvRRIrkNF
	D9lCb7HNNIBAaBy/yWMIb5hIbXRv73BMrxK8lCpzpc2dsyIXqv0R8o5Lyx66Xbop4spFl9pAEQC
	hbj7wFMYTfD5UhpOtpW1IVGL9T1XiGHZg3ds4McXMozHr85rjKd9OnxgCXofoKKik+tuPWqA1+n
	MJ+uctZO95HkVbtbLGrOl+I59PWr9yTTdfkmUuG4AjFZpv5OJinyBpvDjgqweT3/U7j1MhLm8lh
	3qdfUA
X-Google-Smtp-Source: AGHT+IEHMIJU9u8ueZDndaal17u8mfKe0TgyHQU77XQdzJ/EbxOIGOMX4Q6Ld8eqXuhgbWlq5qhIfQ==
X-Received: by 2002:a05:6000:2486:b0:3d4:f5c2:d805 with SMTP id ffacd0b85a97d-40e4458c89bmr4101481f8f.16.1758816417869;
        Thu, 25 Sep 2025 09:06:57 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32c49541sm20807025e9.5.2025.09.25.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:06:56 -0700 (PDT)
Message-ID: <68d568a0.050a0220.19f5c.8cb6@mx.google.com>
X-Google-Original-Message-ID: <aNVonSpnm70dLOUL@Ansuel-XPS.>
Date: Thu, 25 Sep 2025 18:06:53 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: mediatek: Fix wrong
 compatible list for hifsys YAML
References: <20250923201244.952-1-ansuelsmth@gmail.com>
 <20250923201244.952-2-ansuelsmth@gmail.com>
 <20250924140347.GA1556090-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924140347.GA1556090-robh@kernel.org>

On Wed, Sep 24, 2025 at 09:03:47AM -0500, Rob Herring wrote:
> On Tue, Sep 23, 2025 at 10:12:29PM +0200, Christian Marangi wrote:
> > While converting the hifsys to YAML schema, the "syscon" compatible was
> > dropped for the mt7623 and the mt2701 compatible.
> 
> Is "syscon" really needed? AFAICT, the clock and reset drivers don't 
> need it.
>

Ok I also searched downstream and can't find any patch that would make
use of syscon. Guess I will replace this patch with a patch that drop
the syscon from the dts.

> > 
> > Add back the compatible to mute DTBs warning on "make dtbs_check" and
> > reflect real state of the .dtsi.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
> > index 9e7c725093aa..aa3345ea8283 100644
> > --- a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
> > +++ b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
> > @@ -16,13 +16,15 @@ maintainers:
> >  properties:
> >    compatible:
> >      oneOf:
> > -      - enum:
> > -          - mediatek,mt2701-hifsys
> > -          - mediatek,mt7622-hifsys
> > +      - items:
> > +          - const: mediatek,mt2701-hifsys
> > +          - const: syscon
> > +      - const: mediatek,mt7622-hifsys
> >        - items:
> >            - enum:
> >                - mediatek,mt7623-hifsys
> >            - const: mediatek,mt2701-hifsys
> > +          - const: syscon
> >  
> >    reg:
> >      maxItems: 1
> > -- 
> > 2.51.0
> > 

-- 
	Ansuel

