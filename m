Return-Path: <linux-kernel+bounces-867209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83500C01D87
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F4E188FA83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D88232F75C;
	Thu, 23 Oct 2025 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRs5BCkp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1632D451;
	Thu, 23 Oct 2025 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230472; cv=none; b=fneuMorNOVLlNOhhEbq9/JT94VRoA7SGlGTRP27R/JmbJYjhWlhVmC+equdJaQxBiKhXkwPAW2tQ6yyjxYSdinm+uSsIQ0N1vpavJOlKl9BIUzAoeV+UXNUaq/cRbesBTCAmZDOhHtZI3FmYl+fi28BzgpqogX8cPkVZ8TJt0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230472; c=relaxed/simple;
	bh=cW5QfGQMZ4PV7ftOby+XUE0ShspSksxnOWEG6f9oTJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hodD7Il/6QfJ/yGlT5O5hAFOU8VRtJUnfDermpi8XkIoH0uZsBeYKx++qzZ32I+rqJ9FwiFc6/ZckkzrWw1d0ZspbbXZc5oA2x6OSXBJUhU2ilJ/g6APow/QQkRAXLYM5bUw2y4KIN9rLzp8Yjk9ayap8wSajlMs8MN4wXDs9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRs5BCkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E0CC4CEE7;
	Thu, 23 Oct 2025 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761230471;
	bh=cW5QfGQMZ4PV7ftOby+XUE0ShspSksxnOWEG6f9oTJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRs5BCkps7/vPSnGGJ4UYvEDCBpVB6nA3F1ybLkss63umQFJr3yBnYPw4vKdoVfOa
	 y3IDRocWhzEUP/1bjuU7rr2qGPsTraKGkJG//VBqpcoVGGsOHKsabFqaMd5seTRORC
	 WGYCMTvymWnNnuVYRW+vbr3MGC9g9qT/8TGtlL+1gCyAJN5e86kpUNOA0KM/3rcz33
	 aTK/JNW4t8WXN4ndPN133WaTYW5XihciU8J4mW20WNNShJvzZXqqudFxo/7W6NUKma
	 Ob+JZ/jweAP8z2XzSWLhmu5dSybJS5Crjq26ekfkZCZlnKxxPQemPStbwgYIc4w9Xk
	 j5wW5GgYtDrjw==
Date: Thu, 23 Oct 2025 09:41:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, patches@opensource.cirrus.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 05/12] ASoC: dt-bindings: sound: cirrus: cs530x: Add
 cs530x
Message-ID: <176123046698.2903235.16983814748278675361.robh@kernel.org>
References: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
 <20251023090327.58275-6-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023090327.58275-6-vitalyr@opensource.cirrus.com>


On Thu, 23 Oct 2025 10:03:13 +0100, Vitaly Rodionov wrote:
> This patch adds additional cs530x family variants.
> 
> cirrus,cs4282 - high-performance, 32-bit resolution, stereo CODEC
> cirrus,cs4302 - high performance stereo DAC, 2 channels
> cirrus,cs4304 - high performance stereo DAC, 4 channels
> cirrus,cs4308 - high performance stereo DAC, 8 channels
> 
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---
>  Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


