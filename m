Return-Path: <linux-kernel+bounces-887228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282CDC379E7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DAE18C5630
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A82A2D7388;
	Wed,  5 Nov 2025 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKoQGAoa"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C2224AEB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372952; cv=none; b=iVncgqr4WvRJNHamUWQcGBhHEeX7TxQQWK1lwBIsX71zlrN4Q5euMXAo5sX1lYLI4VD7UugeykTVit3vtGiwyViNSihbWtQJoAZza94K5kIF9kUxj8eo0ZjFvpPeKTbdu/UK/vMdF/Uge59Qa48I8q3OH06CRBQ3jfc28KcKU9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372952; c=relaxed/simple;
	bh=I+cyU1YsuCr2HvX/C46SKQfA6kkVDFrXjoT7BMxk52E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNwuVgLjlQc76G5td8XxtKtS1BbDLVlRens0BRe8JS3F4hupwhObXJRqNzzX8rhhJYsVU8ps865xGWQhwlhEcoKSUpo/IluoZkfGjMmnfQm+aHUL13YGVjS/cP8GVT8o47O5i9Kj1H+JqPKjVNLKhgHPioxZHH5rXzPxGYyvHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKoQGAoa; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e0e4601faeso140448fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372949; x=1762977749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2WgVh/W2QDlWrUEp2DhJYyH+fmgYqOSSyNzgizd879Q=;
        b=LKoQGAoa+0ILCUoKQJsGPVqJRjm89fhu1vhyQ++IJs3+kSQdOcq3BBmwvxWjMYJAGk
         J1IM5PYDgHrjvuTLinxxtGNTVoAfxrH81y8sbWRYpYGABiozK8ueQztmH+ndkTUrKaVT
         zKpUOTIjSz9lKozW16NwnrXeUJ3dGCAgC4rl5kTl5VstpcYvdXdas4E54HVtjxx2Jpfl
         u/CYj+DOwGNUonzsjwzy3Wt1ziZhoQaCsgvlq2E6k8FdZJ1SD1oassd6W58qxxXRO2fJ
         0WKavJBAUiOI3wrIovSp+WCPxzbb9gWQWq5ww5wUKDMQr6NyjEHcJgir24JKOYtJAp6L
         txXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372949; x=1762977749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WgVh/W2QDlWrUEp2DhJYyH+fmgYqOSSyNzgizd879Q=;
        b=IX5pKrjsLhwYzeDbZDUHmaV06bqCF8zK25LbkQVTiFRsgrYwc3AaJbTtohpVbdBZEn
         Fy1RFuUlU40/L5rBauJ5tVPoadBhZB/+l9TCwRgSEXsbfKuDVPtz2gtHBkrYYX9RYP+d
         ZHRcAIx22OsdmOvoquKR6gOv0tnvKW4oEMNwoAfYDU8EUz2u1aymAN2NLkTTysn0zIwE
         WV6lVMDoLeHYAzFbkbyfdLM2tu4bLEQHR977Xm7J3fM4yo0U+FGvsnA2C2y7lRndOKNv
         Lc0RbjmR6Vju7OZAVUR7VKlN2QhVIBaIsFAqo1h3ofBpBrETTYbc6nv+pU9Gahnk3mSg
         J1rg==
X-Forwarded-Encrypted: i=1; AJvYcCWUkNOWg3HJ6BmbPbOZAmtJjifKa2GYyC8WetjP2zmKEgWRSXM8+XjoGCinTyPCwUdIJnzG04ZSKWfzcr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5VUokcLcrmbg7DwGWBlOwzZqBkNUC58naqPsR/lAO10QZlas
	1HWRYWT0imOeueBNEXC+vYsD9VividZzHH8JxuNai4LDen7Iu2Vgik3O
X-Gm-Gg: ASbGncu6orMMZdlGP3TDSRPSCqlC3DlK8OpAQlr1hO+NkxZ4XlhL1InyCvYgrbobVvT
	oCwwyo85ElIrOfUOjpM6CiBmoSLCXebZUlB8WmZb8XH+TWz3YUO0UyKbrGZzhP0aZwMaWKcqv30
	MH1/rBKuNchvZ2OevU3Z7KHGFrdEr81rb13SheIMvjkVVYQFTD8SHU1T3AE1CyKZy5vDDZwmiBj
	bv7wsa5hkPH5o7H/0t6hEcZNd5KFyKI8oaDaOjZvt192lco8R+z6f+edRStXuDBoQY0tUUnQLdh
	iAG8aAbOmZ58gAnCGF+HHNihDxoFWiJ8h+XpTlC89KU0U84O4RvM1vUe9rWDYsguyNGNZdjB5NL
	baZLuSXjc2XeN1e0JLznOJ4AkYGAlMUrmaHhX4638eFhprHTAF7l5CNiDMPxtfrc=
X-Google-Smtp-Source: AGHT+IGSwk5bgvA4Oe45ToOFpKJoB2+FDTxvWYOBhAfgVYBhwy6jRCcKmE2cTHy1t1Zs4TzsM6oc1g==
X-Received: by 2002:a05:6870:80d2:b0:319:be1e:9dce with SMTP id 586e51a60fabf-3e198e539f7mr2033360fac.5.1762372949003;
        Wed, 05 Nov 2025 12:02:29 -0800 (PST)
Received: from geday ([2804:7f2:800b:2ebb::dead:c001])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e30ab3f772sm53209fac.20.2025.11.05.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:02:28 -0800 (PST)
Date: Wed, 5 Nov 2025 17:02:21 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aQutTbzS8rfW-Esm@geday>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>

On Wed, Nov 05, 2025 at 04:56:36PM +0800, Shawn Lin wrote:
> 在 2025/11/05 星期三 16:18, Geraldo Nascimento 写道:
> > 
> > Hi Shawn, glad to hear from you.
> > 
> > Perhaps the following change is better? It resolves the issue
> > without the added complication of open drain. After you questioned
> > if open drain is actually part of the spec, I remembered that
> > GPIO_OPEN_DRAIN is actually (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_DRAIN)
> > so I decided to test with just GPIO_SINGLE_ENDED and it works.
> 
> 
> Does that work for you too?
> 
> &pcie0 {
> 	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
>   	num-lanes = <4>;
> -	pinctrl-0 = <&pcie_clkreqnb_cpm>;
> +	pinctrl-0 = <&pcie_clkreqnb_cpm>, <&pcie_perst>;
>   	pinctrl-names = "default";
>   	vpcie0v9-supply = <&vcca_0v9>;	/* VCC_0V9_S0 */
>   	vpcie1v8-supply = <&vcca_1v8>;	/* VCC_1V8_S0 */
> @@ -408,6 +408,10 @@ pcie {
>   		pcie_pwr: pcie-pwr {
>   			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
>   		};
> +		pcie_perst: pcie-perst {
> +			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
>   	};

Hi Shawn,

No, that does not work.

I believe the pull-up mux became needed because I was forcing open drain
on PERST#.

Thanks,
Geraldo Nascimento

