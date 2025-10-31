Return-Path: <linux-kernel+bounces-879430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BFCC2315A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 298A64E56C0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA36530E83D;
	Fri, 31 Oct 2025 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukhDa1qk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BFB27E040;
	Fri, 31 Oct 2025 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879443; cv=none; b=BUM+sHAbkMLCyw4fRsYZhPl2Xc1cKxlZH0DB3QNT9pJjp8K9FPGkTz+nkGdLRHhfAxe9Igos9ALUSxpufYH6nfI0CEnef0rNCXwOQADUkbO8h0ctjgNCGNAi6wh+zFOvqPUgLJZ77akZ3T1Cm91KIHDg9mzPNWuNm8nysi7m7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879443; c=relaxed/simple;
	bh=KUsx73wI6sPC91XwqDu6VZod5VCxoTfFdHsrrDX5nf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7qWVxLhYAzbB6g9sSXhzjZ6KMI2Ek32q1CS9cTsSL1Ag/YbCK21CaXBwVjJNHg3W9dNL3fizfRBbjACh19+7xvob3KRPIoVqvBvf+G5jJ5WRDIv7z62oESq1k2kKngSMY4ZsVgK46RYdD1m6nOHWmmKDSuknCnRhl2L5ZazVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukhDa1qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E85C4CEF1;
	Fri, 31 Oct 2025 02:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761879441;
	bh=KUsx73wI6sPC91XwqDu6VZod5VCxoTfFdHsrrDX5nf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ukhDa1qkvjAzY+T6gBWTtd0jrGSBFVBl09O0lJYB2SHzAOkMz6sTMtOR/dj+TnIXd
	 LKZzJvbJ/0Qcoa+mSFCf6INBUkBhBfcr+xfw83aFPRW3DgpByzn8jq71LeoORgFtXF
	 rsspDY5bF10qgLba/5IRnXdYcg6qvi65+5BaZ3g49HXYWerJIuM5AFURncimGWqQgo
	 gJYMwHgKqFcjWR22DcBqvbRcLpg8c0pMZVtQKyhMzYkpO51WfoyYTYXPf/6BhtC63p
	 9a3LBIl6DJQhdIN1PTVP87RynTFfRaInze9g3nZSylz9YcqYTyNxlxhFgvhmOc//U7
	 dNf7nuRJe+ArQ==
Date: Fri, 31 Oct 2025 10:57:12 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Peter Chen <hzpeterchen@gmail.com>, Chaoyi Chen <kernel@airkyi.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 10/10] arm64: dts: rockchip: rk3399-evb-ind: Add
 support for DisplayPort
Message-ID: <20251031025712.GA1284354@nchen-desktop>
References: <20251029071435.88-11-kernel@airkyi.com>
 <CAL411-o6mF71oBeRsJ-OPZNbLegn4iJ_ELN9xVdppTM3ssUPOw@mail.gmail.com>
 <cc8b583a-77ec-4a7f-97cc-2d148f7fee9f@rock-chips.com>
 <e0c5bda3-7428-49e0-9955-fa23f1e4f35d@rock-chips.com>
 <CAL411-oXfvp-iqN+uRmFHijdmW=1omKwozKOoZ2shxukMHmwPg@mail.gmail.com>
 <C6253E8254C80B0F+839b71d0-1bd8-40b7-9515-7ce4a1eb8673@airkyi.com>
 <CAL411-pULVu4AYybW9oW7kmr4M_kJhdytgBjLPb4y6w_2dj+0w@mail.gmail.com>
 <7853bbf0-34e5-4880-a2f4-2d73f25cd5e6@rock-chips.com>
 <CAL411-rFK0o_cxBO_yJFHWurGFKxZGxw6=kpqxRipMetJskTaQ@mail.gmail.com>
 <e2fcc437-0650-4fdf-bb75-3463a80299fe@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2fcc437-0650-4fdf-bb75-3463a80299fe@rock-chips.com>

On 25-10-30 14:50:33, Chaoyi Chen wrote:
> > Hi Chaoyi,
> > 
> > There are two questions I have still not seen the answer to:
> > - Why USB2 PHY is related to your Type-C patch?
> 
> I was just following other people's approach. Sorry, this should be removed from the dts.
> 
> 
> > - How does the USB role switch event notify the USB controller driver, eg dwc3?
> 
> Sorry, I misunderstood what you said before. There is indeed a missing usb-role-switch now. I referred to the approach in rk3588-evb1-v10.dts. Is the following way of writing correct?
> 
> &usbc_connector {
>     ports {
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         port@0 {
>             reg = <0>;
> 
>             usbc_orien_sw: endpoint {
>                 remote-endpoint = <&tcphy0_typec_orien_sw>;
>             };
>         };
> 
>         port@1 {
>             reg = <1>;
> 
>             usbc_role_sw: endpoint {
>                 remote-endpoint = <&dwc3_0_role_switch>;
>             };
>         };
> 
> 
>         port@2 {
>             reg = <2>;
> 
>             usbc_dp: endpoint {
>                 remote-endpoint = <&tcphy0_typec_dp>;
>             };
>         };
>     };
> };
> 
> &usbdrd_dwc3_0 {
>     status = "okay";
>     usb-role-switch;
> 
>     port {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         dwc3_0_role_switch: endpoint@0 {
>             reg = <0>;
>             remote-endpoint = <&usbc_role_sw>;
>         };
>     };
> };
> 
> &tcphy0_usb3 {
>     orientation-switch;
> 
>     port {
>         tcphy0_typec_orien_sw: endpoint {
>             remote-endpoint = <&usbc_orien_sw>;
>         };
>     };
> };
> 
> &tcphy0_dp {
>     mode-switch;
> 
>     port {
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         tcphy0_typec_dp: endpoint@0 {
>             reg = <0>;
>             remote-endpoint = <&usbc_dp>;
>         };
>     };
> };
> 

The general hierarchy is okay, just need to fix some dts coding
style issue.

-- 

Best regards,
Peter

