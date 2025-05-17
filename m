Return-Path: <linux-kernel+bounces-652067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589C7ABA69A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 May 2025 01:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B841BA8165
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 23:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E74280A27;
	Fri, 16 May 2025 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1gO6Z3Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291216EB7C;
	Fri, 16 May 2025 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438267; cv=none; b=htHxiSeSnYjLcqP/PPOJCeE8bW3lyhuuBeorMzddUuD/37QEqxl7+ntqyn8OIC8TrWkKxa9ED7xRDQSgzuW74Y+1wZsv9ynXRXinWOW1Iaz2oV7D3IzxWzBzV9fVtEx0T5iPq+90tiJsybZ4L7oUWgEIdBmpK5hvJyfb0Clitrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438267; c=relaxed/simple;
	bh=LLXZH8CcZsv0YcixDzRJ1c9l0A1zuk/pzjDX3m7p/V4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQxfxJD2wbTdVNPjVG+v/UDqd/rSIarAgEy4AuJU50fbbjLrIZsdUca2blehRJrV9H0EKtGXCoeHuNc3vgU8ZtugYXUUhDa+Vxz6NP4ro4Ks3pg+z2XR2OlpqjIPwTWfOU04D3BHm+jt6Om87RvjRbf2Vu/HXMNPWxAHYCZ02Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1gO6Z3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A050C4CEE4;
	Fri, 16 May 2025 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747438267;
	bh=LLXZH8CcZsv0YcixDzRJ1c9l0A1zuk/pzjDX3m7p/V4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n1gO6Z3Z7Gvk7LqDSlLPRSu67oFEX4V2NsGLnIODlWsQ4jO8W67/4of9MJ0Sx83hL
	 kKC0+Iw5vXgsbLF34bNv2ldP2cVTmhtQKcdwNuqdmo31jBt0UVS3Ge+x2efjTc1LfH
	 gv8XzD+AlIONXgYcBIPgpaGFOHgQQQEAUc4pzHO6vCsUqxGBcYaDBslRQ3CpyC1Ql4
	 U/D003bt41MLHJQLF6UyM5rXoypEP0EhD8z2lxx+wo8DOKR8bttJIlhzv18CVFTRsC
	 3G6tmIQBuM+VrQOf6ahcpWVbPhjtQZFa9m/E/JzvVceNe/piLrOBAk0DAcNXTAr5vn
	 X8T4EYfANuXuQ==
Date: Fri, 16 May 2025 16:31:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Frank Wunderlich <linux@fw-web.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Daniel Golle
 <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
 <SkyLake.Huang@mediatek.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>, Sean Wang
 <sean.wang@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Felix
 Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [net-next, PATCH v2] net: phy: mediatek: do not require syscon
 compatible for pio property
Message-ID: <20250516163105.12088849@kernel.org>
In-Reply-To: <D997C4DB-1B03-4AFD-B48C-BFA19AB6194D@public-files.de>
References: <20250516180147.10416-1-linux@fw-web.de>
	<20250516180147.10416-3-linux@fw-web.de>
	<D997C4DB-1B03-4AFD-B48C-BFA19AB6194D@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 20:08:47 +0200 Frank Wunderlich wrote:
> Sorry, resent it by accident while sending v2 of my dts series.
> regards Frank

Unfortunately patchwork thought this is patch 1 of the series instead
of the bindings patch :(

Let's wait for binding reviews and maybe you could repost patches 1-3
for net-next without the dts ones? 

