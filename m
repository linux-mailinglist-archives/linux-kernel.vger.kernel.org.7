Return-Path: <linux-kernel+bounces-802395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D2CB451E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CBF5A0E43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667628726C;
	Fri,  5 Sep 2025 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ALk4RXbf"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC3327FB28
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061855; cv=none; b=gDWpJNtsmQ++MblqO2CR9BbGFmI1iw9THRSvDv06ZSch9b7u39YbM3X7a6T0kFf/0YKRy7Y6h+Ds+3rUByj7ZL4pg4BfUGP06hhWGdcnPi19dtT+m7KbpqxOsmGZ9WBt8OO82ZPLvx2KowZWcRrNM1wQePJBY/jsFiLn8IaVCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061855; c=relaxed/simple;
	bh=Qdx8UmZRXzK8qYDVu0N8OvZfN2UCea6wjbMidO7B3Xw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiAEgOU0DJgj6xjnttYTFUTC2UsZjvNAcugReIH+gA6XkRweBVzfKa7C1BCiEPgg1SRgZVLbtdHGBdyWELAy3uuSrn58UlhOe2lvoZdG1IfaFVLTXBTWvCEemC4WPeiazQxagYe1o8ZoAMaoGvpTWBaj9IfqTzQSTaiv0VWGok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ALk4RXbf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61ebe5204c2so2611837a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757061852; x=1757666652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yR4MNdZIy35U00ccIKzjKaOutSLR2GPJ6bo+zIk+aFo=;
        b=ALk4RXbfEjbP3gxZtWV5wtVx/G5AVmoi7CujDXWKpHIZjcPtm/21P8Uqsx0XteQDK1
         1OzUC600rpu99ZT+4zYyIzs7hWzXf+QyFN/bfLFQy2ZtaZafK/zTYbj6HkHq7nAn+lYj
         yzLl0VKyCyjpLiKVt0suKfrJIIiqpV6okpFHYC24qk9mOM3g7wNI4fXwJIyrq+eau6wb
         ywYWg2FJKc0bg3vQbre38qR7Y6RyccaJoEvQd5r8H3o+zTl1WBUK5dJobVHnL74J4Sam
         FTq7AfPmh9W1Zc3orUuJA8k2Fwf3/8YL96Oz/ghwXk2h8MzhZfCO3BzIA1ezU5kanzRJ
         mQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757061852; x=1757666652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR4MNdZIy35U00ccIKzjKaOutSLR2GPJ6bo+zIk+aFo=;
        b=SNcYT6SNNF4bi3JgXXyl4GDHLkNsQOr3+R/mqn4+eZuGYGDWplP6oNWE6n68zFAbvN
         4J8RFUdOFqGBhj1kuRUXsy5z+7m1155eahBZw0i/W9ioPqjPM9G6Ncozcx0cdZcMvHax
         Be0VAdkNUqMeN7kLGQnObcspnzCa04VFJvgy6/FIgMhzxlHJbAzfmnO+SHM5tALkD5KA
         nDfQzQ8cNvaOLt16nmgeCsZSON8i+wSxK4ddYFLszSIQJbrWuf0xSwHXyHgN2YsqP3Zr
         U9WMjbrKM3HL9ws6LTcAxm2UPVYAsvrIIdj0IefmsHHwRMvxWcMf9Fn0xQ4Rc/0YhnHs
         nZVA==
X-Forwarded-Encrypted: i=1; AJvYcCXtThAnse1mXcCMSlkvfdyLOykQcjlOroRbUdSUNfA8EtFTkWU9GDC97UnbVMxwAOxCJV5TG2FL9dKhzo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrjguovmTnXUOfY2AWta7D8nvO5jY4Bc2VSSuf74uX5P8nfvc
	ju1WWJM4ShGKVGZONkLhamm07opNl4xQW00tJhsNRV4N1xjJIvs8nKv4+ebM3e/7ARo=
X-Gm-Gg: ASbGnctrLcNXSNXgH+FHYQUWiy8SXELoXYJGjcIHSrUmPmCw8lG0J0pF8VxoYjcUw3e
	z8Li2pYRjDA3VCu0F7fq/EjRik4QmFLo6eEfNBdxK2oQJNam54zYyBaq0o16TKdaPD3LxI7mAb3
	4MEraFqUV7Fht48ue1BX8NIodZ4uNmc/UCzTtssJ1mN1H75UZ/roX7FK7kj6wUcGRZ0uJweAohF
	kY7RzCZJqVs59xH5ivKrGysoikShLNd9gFOfpxl1UlaNq48ExHD+/k2DNGhZqYG5b6zXbOsjv+u
	dL4l2ZTzcmyidszeMUIe4T/dqG+Z0HxJGXeytynUa2LZ9gqg3+E3Ehhlkrfe+lQ1Nv3rMcErVHW
	SH6B3hUVSVotBiK+VYsN5kDWLZWVyo62+E6RR9wqIjLNmFFFsL+AP8q3ZrNr/gNDV/YWZG4MzZ+
	LsmgAUJIfUH9RrbjvMurceRw==
X-Google-Smtp-Source: AGHT+IGDLfdyG4Skr26W8CIxq2lA8TSvgcUdWiR0PPFTvWtp/0QiihczvwRvoN05VyOwttajNkcHvw==
X-Received: by 2002:a05:6402:2807:b0:61e:a13a:27ce with SMTP id 4fb4d7f45d1cf-61ea13a2c3emr14799399a12.20.1757061851705;
        Fri, 05 Sep 2025 01:44:11 -0700 (PDT)
Received: from localhost (host-79-31-194-29.retail.telecomitalia.it. [79.31.194.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4bbc51sm15734349a12.27.2025.09.05.01.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:44:11 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 5 Sep 2025 10:46:08 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iivanov@suse.de, svarbanov@suse.de, mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 1/2] arm64: dts: broadcom: rp1: Add USB nodes
Message-ID: <aLqjUNAdremFoM-F@apocalypse>
References: <4e026a66001da7b4924d75bd7bee158cbb978eed.1756387905.git.andrea.porta@suse.com>
 <f7bb0739-3161-4d70-87e5-8c978a023361@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7bb0739-3161-4d70-87e5-8c978a023361@kernel.org>

Hi Krzysztof,

On 13:05 Thu 04 Sep     , Krzysztof Kozlowski wrote:
> On 28/08/2025 15:50, Andrea della Porta wrote:
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
> Please order properties and nodes according to DTS coding style.

I'll do. 

Many thanks,
Andrea

> 
> Best regards,
> Krzysztof

