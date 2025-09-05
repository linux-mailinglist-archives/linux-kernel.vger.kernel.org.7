Return-Path: <linux-kernel+bounces-802393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C12EB451E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AD3A04C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E982D0636;
	Fri,  5 Sep 2025 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SKP4+Wkn"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8B27CCE2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061818; cv=none; b=CAVp+FhL6spKnxJfPlIhYfI9FZ2+8zOquif1n9RNktpXPM7Aa2M8uiHMzi02U7XAeZ3tZ3YZYE7YgNmGG99N7wWeRMdu3XIyzqHVx9XKTZaszrbfaepJUv4HD3plMlR4b0TYo+wg5lW+Z82/PLfIb0tiorRRYOanzD5vnL5J21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061818; c=relaxed/simple;
	bh=qj3CPvvg9Wfb4aOeiYN5qE3V/WXSusmxmAmvExZAstk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp8GrcLpKF5GpvDXSS1ZH23KeDgkj/3/QpRkLIYqXNOmDMud4nynjFsgNjLtFnwAQJrq0jPrKBYvnN/6AZnWMRGHtJh769Gx0B606XZB5AbV9o8njZD+RQKX7iPLHhtciMAU9gpfRzHcT3+vH4T/kQhhk/mM+cNfiLYnnM/p8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SKP4+Wkn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b047f28a83dso274932866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757061814; x=1757666614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFZ44yopGrsYMfdLKOB5nzNR8YL97RtHy31e0eAGVGk=;
        b=SKP4+Wkn4MoJaOptM/YoCxClv5GNkiv72eza2pvsFYpJ9GQeFgehLlCMNs6AfSKxfH
         fz9A1ztgZ9PldNft6odD+WizNt/fVoaT7MVFkL6JcAUoTGQHLku3KuiSjnDI6UV0IvRs
         b4ru+cPfatayyhaezIv8YOEprweGB/nZ109gT2/8iXa0mUm8ZjezNa06rs8qOKsaA++q
         hXfZaudFUKKyJ+DU5SOe6k3PjEXQK3YuXo2NvnFkSJVRZzCrmKwbUZHBAxaBuVJ0nlsB
         woki3hIPlzwNfPrXex5v1OxflJwO5qTO1K5vyZV2DaXQg5N6MN2/yASr9eqi7TovYBAJ
         csAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757061814; x=1757666614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFZ44yopGrsYMfdLKOB5nzNR8YL97RtHy31e0eAGVGk=;
        b=ROVia0HQF9AMcteLXuA9bk6J3DgKdK9TrF9RISVyhkN4JCa7Q0ut2qtTx+gkv/U1+z
         vnhOs9DXohg4086BBIlMrT6KxPHezuxHThhBdljIxD62DI3PDu5ixn8wat2opPoWhlyL
         X25Hjr/H0YjK1gL06bYzbiKD/R5aLwtDJDXfmzn3Gqns3E8Ug/U6J+f0HRPhEb+i7AxQ
         wlhZptDcYM+5irrQ6RECaSAjNyAfDOgpR1I6lfsb48KYS+PAjEkyJEDCKjuJHhq0ABdq
         qHksqEca9W5MiRNiT1ZrA8UCA5EsfiB2ZIfeMAsOkthyYVefXO78wtyigcS+5ounG6bx
         bfHw==
X-Forwarded-Encrypted: i=1; AJvYcCWHiyhLoHdA4Hm7NmhXp/BCH//5PFmusUSjHX50CX5AoZ9FlukN7jbyTOCHyatjQus714VAvsN5qyCZP2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxctQK3aEe7SZL0+4QiAUQrdjtN6tDvYLdaZh4IQVw96y3YvRu7
	/pIxUZHS7OSMLTgP7qWFwaLAQ4xwJWFkj7qLgn0coe0ZlMeiXwYIeFnHqE8wtjfT4o0=
X-Gm-Gg: ASbGncs6EKaSPWT1e1XkfdObrBFv4u7lu3rsn50RRsRCKLnRuoBwDy6amMMOALEE2xM
	QKfuILkKsSbN88ow2NmLI0kWvoCMefdm4Wr9ARiWyYg0+sD7igL+ulaam7MOkz1O3+6EOcHs55o
	Hta9io4T+SSzgt6sD+aslN7l6Ms97pAd/bT1RCt81wSdib4fBr9QGp92DzZFb5hxHdFbfIFMKsz
	Y8dLMgUYJXuzg/3eDqQ9POSKvrhEzenmQ+soqYlHQzy5I04EektqqTFDUnZBP3ScfKa9jyfJnXO
	4+sijRgf9lOuxWiE6V7kAYOBBAwNrFpiQinM3/ygn7PWEkBFmTc4cRczRGFteGXYtTxN1yYwmEA
	zBbin3Efl1XBsXUxWeb2FEAVIu8oFo3rA5+3huPJgXNtebfd4SpVTOHsa0o2anYRSutJWHO6liG
	nfN8RwqjkFW1NgdswXk8KqkzxbAYRZ/00G
X-Google-Smtp-Source: AGHT+IHSoczlmQQsMcIcDoA2nphrjHJmH+vwTBiXM5+w1FrleTBzhZMYXlRT74k2g1gKnwedKzI9pA==
X-Received: by 2002:a17:906:f5a2:b0:b04:3955:10e2 with SMTP id a640c23a62f3a-b0439551a93mr1777660366b.25.1757061814481;
        Fri, 05 Sep 2025 01:43:34 -0700 (PDT)
Received: from localhost (host-79-31-194-29.retail.telecomitalia.it. [79.31.194.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04148f95b5sm1353763866b.92.2025.09.05.01.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:43:34 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 5 Sep 2025 10:45:31 +0200
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iivanov@suse.de, mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 1/2] arm64: dts: broadcom: rp1: Add USB nodes
Message-ID: <aLqjK0FYSkXtBvv5@apocalypse>
References: <4e026a66001da7b4924d75bd7bee158cbb978eed.1756387905.git.andrea.porta@suse.com>
 <50b59b27-cdf9-4af8-b31d-d5ccc68c73fd@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50b59b27-cdf9-4af8-b31d-d5ccc68c73fd@suse.de>

Hi Stanimir,

On 13:46 Thu 04 Sep     , Stanimir Varbanov wrote:
> Hi Andrea,
> 
> Thank you for the patch!
> 
> On 8/28/25 4:50 PM, Andrea della Porta wrote:
> > The RaspberryPi 5 has RP1 chipset containing two USB host controller,
> > while presenting two USB 2.0 and two USB 3.0 ports to the outside.
> > 
> > Add the relevant USB nodes to the devicetree.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  arch/arm64/boot/dts/broadcom/rp1-common.dtsi | 28 ++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> > index 5002a375eb0b..116617fcb1eb 100644
> > --- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> > +++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> > @@ -39,4 +39,32 @@ rp1_gpio: pinctrl@400d0000 {
> >  			     <1 IRQ_TYPE_LEVEL_HIGH>,
> >  			     <2 IRQ_TYPE_LEVEL_HIGH>;
> >  	};
> > +
> > +	rp1_usb0: usb@40200000 {
> > +		reg = <0x00 0x40200000  0x0 0x100000>;
> > +		compatible = "snps,dwc3";
> > +		dr_mode = "host";
> > +		interrupts = <31 IRQ_TYPE_EDGE_RISING>;
> > +		usb3-lpm-capable;
> > +		snps,dis_rxdet_inp3_quirk;
> > +		snps,parkmode-disable-ss-quirk;
> > +		snps,parkmode-disable-hs-quirk;
> > +		snps,tx-max-burst = /bits/ 8 <8>;
> > +		snps,tx-thr-num-pkt = /bits/ 8 <2>;
> > +		status = "disabled";
> > +	};
> > +
> 
> I'd order the generic properties first and then vendor specific.
> Something like this:
> 
> rp1_usb0: usb@40200000 {
> 	compatible = "snps,dwc3";
> 	reg = <0x00 0x40200000 0x0 0x100000>;
> 	interrupts = <31 IRQ_TYPE_EDGE_RISING>;
> 	dr_mode = "host";
>         ....
> }

Ack.

Many thanks,
Andrea

> 
> > +	rp1_usb1: usb@40300000 {
> > +		reg = <0x00 0x40300000  0x0 0x100000>;
> > +		compatible = "snps,dwc3";
> > +		dr_mode = "host";
> > +		interrupts = <36 IRQ_TYPE_EDGE_RISING>;
> > +		usb3-lpm-capable;
> > +		snps,dis_rxdet_inp3_quirk;
> > +		snps,parkmode-disable-ss-quirk;
> > +		snps,parkmode-disable-hs-quirk;
> > +		snps,tx-max-burst = /bits/ 8 <8>;
> > +		snps,tx-thr-num-pkt = /bits/ 8 <2>;
> > +		status = "disabled";
> > +	};
> >  };
> 

