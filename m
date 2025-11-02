Return-Path: <linux-kernel+bounces-881927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F22C29403
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CE6188D015
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6282DFA2D;
	Sun,  2 Nov 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="lUZEjoEf"
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F315CD7E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762104813; cv=none; b=icTYOClh6ZuQA+yuoq4Tkv9LYW2hNi+VBnExPqJHjH3iBlCwFQ8+F3hHxlczO2xa6xNq+fL1n/TfP8GyjWksqS396r1DvlCSIv33cLZE3jik37Vv7xOthpZQ4FgjS209vJ3dy+09KcwKhHEyY1pLQvjO8Pmsjg+3UY2VTYe9F8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762104813; c=relaxed/simple;
	bh=ItKqm3nWeBkxJvaQ4qqyFN0riJaMo4uvQgoneJyURW0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQ7stxDb3T1Uy5/2Gn+HwXc9oHYfZWFe7epY9A/XdZ+VLMwbnYQfWAmpyV4sGi44/2gg3Gp99af1u0RtgUI61QTc+1mh9gcw1UHb5pB0y85kzdofiBMXsGSlj354JkkMSM14CAO734jkUvhV/FYfGdZ4u0MdHH8rUNPguz94Hoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=lUZEjoEf; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1762104791; x=1762363991;
	bh=Eg42W12IHvXKvQJqsT1U3vWkwNQoWbyboJvu+N96zJ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lUZEjoEfkt3P4WpsWN2l7VXrjmFtrmjJwV8XH0hxNUkLxj62S36Ec0djTSulQ+bXs
	 wmIAjPM8RYSnhIeFVDtDFpXKSpJC5fxiy+tCajMLJ5I0CvzYngcz9mQP/sNL0EbcbW
	 biBaIE0O/xfBh9Ko+fMbrRYL8Nvk9vVhgDLl918bkJWl5aMZkL0a5lPhhRI6MjJf/Z
	 hKSQASuzmG1iENTGpGwkfP3P6Vyjm/SFPhsFEe1GRFD4ARJAFGGpHnwIGsVbZdNaRB
	 eCtA+DOW17uYcbDjGLssHJlPkEE6FEQDUYRnxXN84GkITMXmWkf7WDmtnfuD6o2mGS
	 cVPkKcE9B7/Ow==
Date: Sun, 02 Nov 2025 17:33:03 +0000
To: Samuel Kayode <samkay014@gmail.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Lukas Bulwahn <lbulwahn@redhat.com>, Jerome Oufella <jerome.oufella@savoirfairelinux.com>, Frank Li <Frank.Li@nxp.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: update PF1550 driver email address
Message-ID: <zn6q6dsdihb6grnl6qllh26wegtcteh22fn6n6js334kwj2ea5@k2koqqtcvqg7>
In-Reply-To: <20251101-update-email-v2-1-175d221ec40f@gmail.com>
References: <20251101-update-email-v2-1-175d221ec40f@gmail.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: c1b32b10e2c177c0cddfded102c9d2d7a64016a3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2025 at 04:28:47PM +0100, Samuel Kayode wrote:
> Update Sam's email address for the PF1550 PMIC driver.
>=20

Hi Sam,

Maybe update the .mailmap file with the new mail address?

/Sean

> Signed-off-by: Samuel Kayode <samkay014@gmail.com>
> ---
> Changes in v2:
> - rebase on ib-mfd-input-power-regulator-v6.19
> - Link to v1: https://lore.kernel.org/r/20251029-update-email-v1-1-f38f45=
aac2e8@gmail.com
> ---
> I left Savoir-faire Linux but I do intend to continue maintaining this
> driver.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a9330f05e2fca6b8661bb698dea17dcfd7fc254..c44d2cf7e7b85104a6eb09142=
da8ef3d9fa7e55d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18608,7 +18608,7 @@ F:=09Documentation/devicetree/bindings/regulator/=
nxp,pf5300.yaml
>  F:=09drivers/regulator/pf530x-regulator.c
>=20
>  NXP PF1550 PMIC MFD DRIVER
> -M:=09Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +M:=09Samuel Kayode <samkay014@gmail.com>
>  L:=09imx@lists.linux.dev
>  S:=09Maintained
>  F:=09Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
>=20
> ---
> base-commit: a7d6255a0bf302c028ac680564633a6aac5f611d
> change-id: 20251029-update-email-f8ab42d1a5e9
>=20
> Best regards,
> --
> Samuel Kayode <samkay014@gmail.com>
>=20


