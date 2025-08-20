Return-Path: <linux-kernel+bounces-777140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C04EB2D5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3FD27B7D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACCD2D9493;
	Wed, 20 Aug 2025 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irknLw6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D82D8DB5;
	Wed, 20 Aug 2025 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677510; cv=none; b=giBpr3Ff6PZ6ZCYoiBQDXlUkR9WKgMEsgrf2I0rv15KiE99X9in0cAcTKp0443fldrKENiHQgvKtf6QCyC1+maM15jDPvO5B3ez6GtNER/XaCot8xpmMC0hNqwjbxGEyslU0MfZaPDwbd+7dOdt+UD+2e+JXxFhlSkqWycdTcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677510; c=relaxed/simple;
	bh=7I4mVhsZ4PWXlRPOcS5Vrjm3MfJ24J5kXv7MZGrueVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpsdFw4/ya5oBeobiqG+wsMQZ3ad26eFnXK1binyl4F60PCbRn2AKZUn529m2rs9SH499RXQ7bJ9dEtbzcCijajMZ0wIipDJ7J7lQEAccypgP03BG6AM3llPNjhAev8bBFoBCrSapKpUs2zT/m9WEzRL9p4ULl9VQaJibRXyiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irknLw6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFF1C4CEEB;
	Wed, 20 Aug 2025 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677510;
	bh=7I4mVhsZ4PWXlRPOcS5Vrjm3MfJ24J5kXv7MZGrueVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=irknLw6HuwAWuSpoOl4fh1JZJBvojr+SJx27gy2XXvH8vp2SQIp76Ei5+15Uy5T2D
	 KcPgbPBIE8FZUoO7HKg3AvRJ3cxZxkCOI613d9KsFLgVtFHDJQHuJI0Lfbaxzp4NMf
	 ZAi6JN0SXueuU1bc+rBwyxTCaA+n3OjaK4qYM8vh+7zUyX9CDxhd4FKa8d24rsZ9Rv
	 hzLmnsGPqVl+wbDH1wOunRjDUkKFMc4yzsOEsqsoXa5UG4SKyzBBXlbM7/oyp8C6Y2
	 56QCSbLzZWluN7V3mb0+MWTOC89SCsJkyR8JerWMjfkDJgeI62goisrSn6PNUbELzl
	 oD8hK5UNiamWw==
Date: Wed, 20 Aug 2025 10:11:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] arm64: dts: amlogic: Unify the compatible property
 for clk-measure
Message-ID: <20250820-sweet-herring-of-luck-9c3431@kuoka>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
 <20250815-add-more-socs-to-support-clk_measure-v1-8-59f04ba67457@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-8-59f04ba67457@amlogic.com>

On Fri, Aug 15, 2025 at 04:37:34PM +0800, Chuan Liu wrote:
> The clk-measure IPs across Amlogic SoCs have minimal differences, so
> they can be managed with a unified compatible property.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi       | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi         | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi        | 1 -
>  6 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> index ab9ebabce171..570cac451d63 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -761,7 +761,7 @@ internal_ephy: ethernet_phy@8 {
>  			};
>  
>  			clk_msr: clock-measure@48000 {
> -				compatible = "amlogic,c3-clk-measure";
> +				compatible = "amlogic,clk-measure";

NAK

Don't ever send such broken code. You just affect all users without any
valid reason. This patchset is horrible.

Best regards,
Krzysztof


