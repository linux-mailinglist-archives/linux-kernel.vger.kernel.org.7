Return-Path: <linux-kernel+bounces-889921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8229EC3ED67
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937383A3A55
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613E930F54B;
	Fri,  7 Nov 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhsmOxEi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12330F52D;
	Fri,  7 Nov 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502302; cv=none; b=cxvvqM9KJCjqww+lQoaXgC91gweLTMuwqFN6OnyX8N+I4+c8G+nJgopUC6Bh7w1mk5Lagk8primcAAFZ88WMvbxbQNUbMjRDLw+t679mcjRRoe2PsLpnkzwEMxrp3PAac3+5zzb2IQYkcaIy7OZfxEo1OYi25LtGD47JnCwIZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502302; c=relaxed/simple;
	bh=uxmerTTcORrb6gRQpPcQTSUxVg+OYTqzzOK67t9Ljfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6qnQcn+i9Sq/c2WpB5IUja9dtqyAAzYFjSD9vjk6770nD9mFYU38w58/tdVs/kWgDue1T6k/hW+7OFNEKM9ueFQ1yIDShhehgm7SLXCKBJtRL6UozP7p7Gejs9jZXL0r3wnihiVfqYkWKGiSv7EctKkSquhQ7KQVyckb60iQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhsmOxEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A34EC116B1;
	Fri,  7 Nov 2025 07:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762502302;
	bh=uxmerTTcORrb6gRQpPcQTSUxVg+OYTqzzOK67t9Ljfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhsmOxEikENFYBwdf+QqUISutA2BoruiWARHigdan/AxkZTUXkU+ZqsqaU7o1SG1e
	 4caM9k/Jj/yL21kTkVVLCEMkgZyfsuCWtTsPJYV7La0A6Uj2AR+Bw+hkxgKzU8IwYW
	 m7HaFfbGNI1TQkcDV58H6g12DVxcxD/FicE6z6OUeaXS2WTn4+3zoGnW8LeblQ429o
	 Jb/tR0rLSyBEgM7ffHI/dpIaZzmti2MaCugNYKWc20KOKXmXVMGIz7/DVCzF7rvDFk
	 KBWJ3n3Y896rujozkrKl7ah6fbj78rDeDkgKu/d20yqim7cxliO1VQjPPn2w4uLuum
	 i1O/GVVp9i9NA==
Date: Fri, 7 Nov 2025 08:58:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swamil Jain <s-jain1@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, louis.chauvet@bootlin.com, 
	aradhya.bhatia@linux.dev, devarsht@ti.com, praneeth@ti.com, h-shenoy@ti.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 4/5] arm64: dts: ti: k3-am62a-main: Add tidss
 clk-ctrl property
Message-ID: <20251107-congenial-quaint-tody-dddcb3@kuoka>
References: <20251106141227.899054-1-s-jain1@ti.com>
 <20251106141227.899054-5-s-jain1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106141227.899054-5-s-jain1@ti.com>

On Thu, Nov 06, 2025 at 07:42:26PM +0530, Swamil Jain wrote:
> For AM62A, we need to use the newly created clk-ctrl property to
> properly handle data edge sampling configuration. Add them in main
> device tree.
> 
> Fixes: 5cc5ea7b6d7b ("drm/tidss: Add support for AM62A7 DSS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index 9e5b75a4e88e..15a9ee35dbce 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -77,6 +77,12 @@ audio_refclk1: clock-controller@82e4 {
>  			assigned-clock-parents = <&k3_clks 157 18>;
>  			#clock-cells = <0>;
>  		};
> +
> +		dss_clk_ctrl: dss-clk-ctrl@8300 {
> +			compatible = "ti,am625-dss-clk-ctrl", "syscon";
> +			reg = <0x8300 0x4>;

NAK, you just ignored everything which was said.

Best regards,
Krzysztof


