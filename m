Return-Path: <linux-kernel+bounces-725406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E73AFFEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F5016B4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227EA2D59E0;
	Thu, 10 Jul 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgH9rSM8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2A21D3CC;
	Thu, 10 Jul 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141618; cv=none; b=opgDY7qnRgR8dnG+VOUII6dwwu8vlTWoZ/hG/wpLJg4I627h6Ok4o7HNa4fwS1WRuZ00pOkQ4JQmbgOWy2bLdD7vTEYnJC2w29wt13RAepc9VaI2l9WSP6gfYWJ/xr3qVw/CJE4OrXPOgtmOG2v0MzpAOsVEK1vZz7g/V7DkCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141618; c=relaxed/simple;
	bh=/HypvwY9siG+NKlMHRL055oVGuG8EQyAhL0pCkMlU9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K22rLD1prwSyxzKJn0UHw28ahdCyfrEjIr11q8wuIZBZFT6zpuN6lSGC7R8jmiRfZfoX1q4a2g2gCMAwwO5ERJ8daJl0KbB24QUaHSbq37RCfYU6IXL0yx2YRWaBNqoSYfJn6fgl1oRJ0uPikS/BK6rLgBIbOzkzjAJYmtA/TiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgH9rSM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5E8C4CEE3;
	Thu, 10 Jul 2025 10:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752141618;
	bh=/HypvwY9siG+NKlMHRL055oVGuG8EQyAhL0pCkMlU9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgH9rSM81IICt1fB+Gh/KefdOe2vZUM//WOoytGXZsskl2aiuW1jIeRJfvP0KjO+Q
	 NkUt7ktYbiCbpa9n3Qy7LnDxSOWciCUeFd7uKgWF3G3IVvNtAXKLUHJL6wxXKq35Wf
	 BiL4LSHtwl8epTKBM5gIiEeb4PfJWxkiOb8uhS5B7YrRrO7M0Fw6s32XaMCWCyL5Nr
	 dQ/2uAbrLwrcGcocnQb2ts39mNR46wgqefgY1v2szbMvMBP9F9XilkKrFVecZGkE+r
	 RtN1otoRzuZD3zXw2CeDpsXtITGj5ETnBG96r7vxprVxcZ4LcMeOxLm9+iclboSwW/
	 AtkVHqx13nI0w==
Date: Thu, 10 Jul 2025 12:00:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: hwmon: Add Microchip EMC2101 support
Message-ID: <20250710-rare-realistic-fox-381781@krzk-bin>
References: <20250709164829.3072944-1-noltari@gmail.com>
 <20250709164829.3072944-3-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250709164829.3072944-3-noltari@gmail.com>

On Wed, Jul 09, 2025 at 06:48:28PM +0200, =C3=81lvaro Fern=C3=A1ndez Rojas =
wrote:
> Introduce yaml schema for Microchip emc2101 pwm fan controller with
> temperature monitoring.
>=20
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitt=
ing-patches.rst#L591
</form letter>

Best regards,
Krzysztof


