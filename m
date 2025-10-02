Return-Path: <linux-kernel+bounces-839677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C7BB222C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970BD42252A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ACA35977;
	Thu,  2 Oct 2025 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBxfyob7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C25227;
	Thu,  2 Oct 2025 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364442; cv=none; b=inJJV7JNlbQaoGEPUnlty5kf0EvtH5bdXF9EAZhzvoiPccaon703jTK3Su7akgcsqkXmhTc7VXTg9olDrWDK2HP7cVguizAEiuVM06T+KQBaPWCFkYvJcTI/m7bdSTqN5Vpn4AmQOZ6kDZcPVHVCUxJUTZ9l+cxVbz8s5xS/lTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364442; c=relaxed/simple;
	bh=Z5VycwaRGCTZh6B0+RfFBfHEf7Kh1kkGLViY785TdZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRPnx+yKNXMmhTHJwRlSFRL7U4WfmMLsWkSz3fOmwmITJv1Pnl/+OREtXdapiVkD6oPh86feBuN5UnpL353OMSCvMkWVA2v+Vzp+6ObduOrwoVES9LEjW5Ejo4kWVNYe/ayo940L46pBj8TmVSRfZr7dJ3uBWbohVNHXMid/egk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBxfyob7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7395DC4CEF1;
	Thu,  2 Oct 2025 00:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759364441;
	bh=Z5VycwaRGCTZh6B0+RfFBfHEf7Kh1kkGLViY785TdZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBxfyob737auB/QcF4F3g6r4Kc+F+nDjefh76CK3QaXDH2wX/4RrVopLminyOy+Yt
	 yBKeUbEZdPjS8nkPJ2y6ABhCR0iQWZFX3Vfnl07r2WSpNfY2PRyOtHOF4UIxKKYN72
	 OhqpKdj3F4Q9mKHw0iWbb3gV3msoegcF7YB9llsOqwDPTpO2S8EF4DaW9hXKao3ayG
	 D5ZUfPM1/bdBtx15W3EV3u3vZE32fBWg15xBsPX5z+iHXHPrzLKpM7XkIRL0gWtJ9g
	 mduSCiMtwkcrZjaHDbM3d9afva2YpizvZMPz9VYO/xBjyKiqyr70IylztsVnf/9Was
	 Tlg6E7Z+sKVHQ==
Date: Wed, 1 Oct 2025 19:20:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>, Andreas Gnau <andreas.gnau@iopsys.eu>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: airoha: Add reset support to
 EN7523 clock binding
Message-ID: <175936443940.2629153.2958124902767152491.robh@kernel.org>
References: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924104850.1930254-2-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924104850.1930254-2-mikhail.kshevetskiy@iopsys.eu>


On Wed, 24 Sep 2025 13:48:48 +0300, Mikhail Kshevetskiy wrote:
> Introduce reset capability to EN7523 device-tree clock binding
> documentation.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  .../bindings/clock/airoha,en7523-scu.yaml     |  3 +-
>  .../dt-bindings/reset/airoha,en7523-reset.h   | 61 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


