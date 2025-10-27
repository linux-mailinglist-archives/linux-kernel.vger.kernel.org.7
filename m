Return-Path: <linux-kernel+bounces-872459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B48BC1144C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 691AA501C03
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D153C2F4A14;
	Mon, 27 Oct 2025 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FANvynyH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F35209F43;
	Mon, 27 Oct 2025 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594020; cv=none; b=mafn8z39vaGjiORy6+MbNzsWOC7hVUAfr4EyFkSv2LmzwAHDhzL3MxbDmLMrlVsIvkYqxgqwTqEf6PF0enF6xykSNpcESEmXiIlqL2qT/ietbGE24HKjp0HFd2Jq1/dxDxVJvVwgmZIVa6PIe4WAhvnNOpGYPzgNp24L3YOLeuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594020; c=relaxed/simple;
	bh=LBVMDVCrP2gD2L6aDDMW4YplNQQg6wbF1zUk45nqBYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQqsKDQKFXPvarrumat6PfjIn1w0Sx+Je9pREN6KxvNqWozhM7mf3zHxQcZSHUP13YcgE0istjJ1ueYFf5M1q84qZtvkZMTG+lfnucOXFmqHEqxwIaGB63rrlGID+4EBMOzrlhj+uxt18oHmgdo4Mlyrn9jcodKYBPTV6VVJWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FANvynyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B92FC4CEF1;
	Mon, 27 Oct 2025 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761594019;
	bh=LBVMDVCrP2gD2L6aDDMW4YplNQQg6wbF1zUk45nqBYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FANvynyHudqCahbTJmZRNDh5L5Vz8iiW7AquNMQVLjjSWtjVcxEe9k6u5izHUbI94
	 R7M5T34cIHryksdf4qTCwOy+DC93mzch2n3TU1ZAU0B1baGH4y1PSjhos9FH0u2/V2
	 hg11mzaMg0ne1XCwOk1kDN7ifLAiXfxtDTvgwISDkV4pmgJ9mYigobLSM+huR/piCN
	 O28LnQxb1A6QRxDrNEeYaG6FI0+U3CEsd4cIS6ebISZexYIW71ZhTphn8WsoJJaGrQ
	 v2+GnVg6YNMMb0ZS0wBlK0ABtMTrIQ0TdrK8qqSiNHZX5AHy82AHH91ItSp2xHaXBm
	 ABCX0EJu6hQwQ==
Date: Mon, 27 Oct 2025 14:40:18 -0500
From: Rob Herring <robh@kernel.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] dt_bindings: sound: ti,pcm186x: convert to dtschema
Message-ID: <20251027194018.GA1466990-robh@kernel.org>
References: <20251026-dtbs-v2-1-cd3b713a288e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026-dtbs-v2-1-cd3b713a288e@gmail.com>

On Sun, Oct 26, 2025 at 10:56:16PM +0530, Ranganath V N wrote:
> convert the Texas Instruments PCM186x Universal audio ADC bindings to DT schema.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
> Convert the Texas Instruments PCM186x audio ADC bindings to DT schema.
> ---
> Changes in v2:
> - Fixes as per the reviews suggested for the v1.
> - Link to v1: https://lore.kernel.org/r/20251021-dtbs-v1-1-493c1aa253bc@gmail.com

Still fails to apply I guess due to the unicode control char.

> ---
>  .../devicetree/bindings/sound/pcm186x.txt          | 42 ---------------
>  .../devicetree/bindings/sound/ti,pcm186x.yaml      | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 42 deletions(-)

