Return-Path: <linux-kernel+bounces-871127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D1C0C79A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0E944F7645
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA32FBE11;
	Mon, 27 Oct 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4bpkMT/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2422FBDE9;
	Mon, 27 Oct 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554829; cv=none; b=mFeF+I+QM+woZmJFi7PgZwRHjOeGFx6JzYHbNHZFAasLKViblX+M6xQ9emmAJk23KN00DHu6Y9xp0dST2tha+kOm2Nrn+E80S8sNlhHhKoxbH+A9eZK07IiW0krGSJRubcpxe/2Qzp8z8XwDTnTbLLOHruSnDEzNIYxRzzKinGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554829; c=relaxed/simple;
	bh=FG7xuo5PggZ8cRzKnFZsudZmaT6IpZPajmInZq+Jg6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5mlKBuTJtQTQOiFVYq1dUB/YKGXBdB57gGoirhtfx8c814CaNCrepZOBK+lpnVvQ+PePiOeLhSJHSjZ/+N1W8cYDsHm6Asla8lDoEezXeUvdKtF4eiwu915l9a0qZeYpCE3VbQ66LYsR5wzOSSx+lRCEr4QsLkPLmTOg5K00XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4bpkMT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD50C4CEFD;
	Mon, 27 Oct 2025 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761554828;
	bh=FG7xuo5PggZ8cRzKnFZsudZmaT6IpZPajmInZq+Jg6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4bpkMT/8pHM3kQkf8n/IetbsLdf0Hk986MT9yUThljNjzsuzWVgOFgIB6CRgVjFb
	 Y7jpDGqzn9nyhRbK2SlMDOGplFSkvFKn7qvx2+0FeEWeM56QCZTZZ+ErXDO/Qkf3HU
	 YAXkI7RLtxYsGq9qo88L15La4rXYqHeTA4dqNzF1CbsbHl1IKVjjkOu7UxlnrZXvbX
	 ovTwsUBf+z/EpNiNILMGo4UyTanRJR4AIy/0q36sR1+SOgHHyR8xPsQFIKAxoddd2J
	 tLmvO05CBUOgoThG13R0sIBs5GypPILv68yRlBWC5nP3s2aJDJtD0FFhnhL4bi16K5
	 MhWquqaOJVIWQ==
Date: Mon, 27 Oct 2025 09:47:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 11/12] ASoC: dt-bindings: sound: cirrus: cs530x: Add
 SPI bus support
Message-ID: <20251027-tacky-electric-wildebeest-ff8ad6@kuoka>
References: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
 <20251023090327.58275-12-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023090327.58275-12-vitalyr@opensource.cirrus.com>

On Thu, Oct 23, 2025 at 10:03:19AM +0100, Vitaly Rodionov wrote:
> The CS530x device family supports multiple control interfaces.
> At present, only the I2C interface is implemented. Adding support
> for the SPI control interface, operating at up to 24 MHz.

subject - too many sound prefixes. It is ASoC and dt-bindings. ASoC
defines sound.

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

> 
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---

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

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof


