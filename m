Return-Path: <linux-kernel+bounces-723374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62991AFE642
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB427BC986
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E32C374E;
	Wed,  9 Jul 2025 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnTfsvHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F322C3248;
	Wed,  9 Jul 2025 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057758; cv=none; b=K6KNNqY3KPE3TwsY3aRGn82lN9JXQwfJC5EqVrhPD8NS8k61WKPr2aPni/LhLVQHI+shO4X6JPvr5mIPaGo2UjKXluOmT9zDpsxydlLpp4M2eIq20y2A/+/yTolqdx7V0VbLLOUEUacgLADUOt847W6eK+8acJ2HDpfStTGdxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057758; c=relaxed/simple;
	bh=ulZQxy8Ri7WQh71xZUFQkLZk6gJnsLY5aUrmSokqQkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsdCY8ZjY1zIhQ986PZeWPTTNaFSet/7d5ez0VSXA8eESO+CkOvQ5cRV/ynQ+3HfGisRIp9Wz53TBMLrWM9X+m9WAih0FH0+LIpAApYFN5H+M6g3wz8lU9YbG4R4InkJkUNg/SDNBzOaDjEzcyWjA+AkFMrSbk1S7rupYLa2UcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnTfsvHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03EBC4CEF9;
	Wed,  9 Jul 2025 10:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057758;
	bh=ulZQxy8Ri7WQh71xZUFQkLZk6gJnsLY5aUrmSokqQkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnTfsvHSq4pJiT11N7jbbPYmom5R7sX69mVqA3LysS7quzLtFVJQ8hvAUP62eSafT
	 jYIbxzeHp3WaVGbyqi1mRLg1t6wwuEqzwBg5pAwGUKaJsmd73atzedFspUF7O9kOhS
	 RMItjdo0NmF3ZIs7n+I5xB5Po6FZv5bDMMxBKWfAWdmVIjLqUXWfJaadJnNEIG9isL
	 74WOZ7J66Xesy6I6CfhE8tDWvM/+GTXKRfcyb1aEGI1o15qjRviNHw5buEbYH+Gy3f
	 +Msqv9HHcV4m4ezzzekBo3X2Ds1yN4y93Dkq27GmBD2TkTq1UQ3R0TNl1EyxueUkTN
	 PdcdckjIWUGPw==
Date: Wed, 9 Jul 2025 12:42:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Li <nick.li@foursemi.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com, like.xy@foxmail.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: Add schema for FS2104/5S audio
 amplifiers
Message-ID: <20250709-hypersonic-piculet-of-fertility-7c4a82@krzk-bin>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-3-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708112901.25228-3-nick.li@foursemi.com>

On Tue, Jul 08, 2025 at 07:28:59PM +0800, Nick Li wrote:
> Add a DT schema for describing FourSemi FS2104/5S
> audio amplifiers which support both I2S and I2C interface.
> 

Another unexpected change from v1: subject: why did you add "schema"?

I asked to drop it and gave you reference explaining this. Did you read
it?

So again, same template:

A nit, subject: drop second/last, redundant "schema for". The
"dt-bindings" prefix is already stating that these are bindings in
schema format, because they cannot be anything else.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Best regards,
Krzysztof


