Return-Path: <linux-kernel+bounces-802106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E81CEB44DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07381C26995
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24726C39E;
	Fri,  5 Sep 2025 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rco3EMV4"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CADAEEAB;
	Fri,  5 Sep 2025 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051586; cv=none; b=MWbGTCtkl4tx4VNxx0cYhNnDqtAUZI3AwCfzlJ86anEA55MjsTZAIx4KBFLBW+YXTYoxo0XL+yqTDRz6im99gy187zxEnMvFRu5NXIRBEOVA9jnE3/1hK8xQbmX3OcQvTNj5LVYRHpFw6b+BVkqy3064Lcvqk9MkWiZZhMAqoa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051586; c=relaxed/simple;
	bh=tbNmxBvkmPLl/ntwp9nwG2AhqvpKbPi6ppZ4Gc0j83o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9f+Y0X0gDuAxcrphWCFAssFzAAg9Tdw7oODa1Q48Wuxag8hfz76fmZ0uXeX3ZmNRLL40GWNANIB30+EjOP8MEXGXNIjwFDiJRn8JSoWdKmG5hohi7RRTt5Fm7+0is2ZBaTJ3WDEd5PSGthUWNQ7j3YFIFwcb1gyqUbp3SxU5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rco3EMV4; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=deXU0gcF7yBIf+TpC1TbTUZssVkV6sZTs9sHoaAOhKo=; b=rco3EMV4Wt2VyqeetV9N8LyVPC
	dX6SlBGQuX3s5tjDwMdjzgjNcf9snf4erTwYbUd2Syp8dj8NpyLauI+F9q8WONGecmcxY24Ag/rAq
	dWx4ooli/OUns9yfIIvvWxkzlo8eRXKDOgHG/1AhSxp3mJdqdqhO2NawV/2tFjEq3oNrT7eyq1TlH
	nf7dB+c2oNYsAOn/bvpTql/QESyUQGHOpb1j+m3dy4mz6236lgeWhWEex+MTo8zs7TwPI9CBWFa7N
	ofNL0oRo7ifk5ab2jUNGaXdFji9RPT3BqJd+gw9VNOF7HOBxthcmUrqSrWJg47CJcvRcuc7CdM033
	dv8lWy/Q==;
Received: from i53875bb6.versanet.de ([83.135.91.182] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uuPNQ-0004GZ-TW; Fri, 05 Sep 2025 07:52:48 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: robh@kernel.org, WeiHao Li <cn.liweihao@gmail.com>
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 WeiHao Li <cn.liweihao@gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: clock: rk3368: Add SCLK_MIPIDSI_24M
Date: Fri, 05 Sep 2025 07:52:47 +0200
Message-ID: <2267196.NgBsaNRSFp@diego>
In-Reply-To: <20250905025632.222422-4-cn.liweihao@gmail.com>
References:
 <20250905025632.222422-1-cn.liweihao@gmail.com>
 <20250905025632.222422-4-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Freitag, 5. September 2025, 04:56:27 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb WeiHao Li:
> Add a clock id for mipi dsi reference clock, mipi dsi node used it.
>=20
> Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>

another process-related comment :-) .

(1) You already got in v1 the
Acked-by: Rob Herring (Arm) <robh@kernel.org>

So when sending a v2, please include such received tags
(if there are no major changes to the relevant code)

This prevents people from reviewing things needlessly multiple times.
So patch 3 would look something like:

=2D-----------
Add a clock id for mipi dsi reference clock, mipi dsi node used it.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
=2D-----------

(2) As can be seen in
https://lore.kernel.org/linux-rockchip/175690195013.3771488.435870786224873=
257.b4-ty@sntech.de/

I already applied the two clock patches, so in newer versions don't
send them anymore.


Just to keep in mind for next time.


Heiko

> ---
>  include/dt-bindings/clock/rk3368-cru.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bindings=
/clock/rk3368-cru.h
> index ebae3cbf8..b951e2906 100644
> --- a/include/dt-bindings/clock/rk3368-cru.h
> +++ b/include/dt-bindings/clock/rk3368-cru.h
> @@ -72,6 +72,7 @@
>  #define SCLK_SFC		126
>  #define SCLK_MAC		127
>  #define SCLK_MACREF_OUT		128
> +#define SCLK_MIPIDSI_24M	129
>  #define SCLK_TIMER10		133
>  #define SCLK_TIMER11		134
>  #define SCLK_TIMER12		135
>=20





