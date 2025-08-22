Return-Path: <linux-kernel+bounces-782446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9CFB3206E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC90A7A7A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9D137C52;
	Fri, 22 Aug 2025 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiYmya6L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D861C8603;
	Fri, 22 Aug 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879913; cv=none; b=H6zo3CuUp6WQ/kwshc/PJXjwkoDvCtSgm/W5ydnwAGTm4DidqN70ezbpgJzqNnxKsB7WlWPTaT6Lq1pU4QXcoAK3I+y7n+w87IaAqNzA9tnUoVif6S7U/V86WJ72tN5KshzFAzThalUnl9MR9qIzkf1CtYt4e9MQ9CPRV8nYUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879913; c=relaxed/simple;
	bh=8CXwgL/+PbdFXIfwkA92lYozok0rqy+77q6MtFphVrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAraylIiXn4pW4UemfUXiiTi8c1ZaHtPF3Z6RJ+me+HUWcaqxTSUTQAJ+NwelV5pExhK3hINz+h2OyLUwTCs9g3ur6vg183Vj5G2AwXTPTvrTBRBDfJbzuvA0JS87Pjx4aAdusJqYqQGZ/YTwR5w617DyQBFBb/1jereXFuQ040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiYmya6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A242AC4CEED;
	Fri, 22 Aug 2025 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755879912;
	bh=8CXwgL/+PbdFXIfwkA92lYozok0rqy+77q6MtFphVrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiYmya6L8kNHYERlvmgxjCRxpeVdqscnoIDjfqOoXEDB6Ox4pFLHW63cJqp5CzjnR
	 sFVDxiFSH6mnPlPKZMr5Am+Lr4PqPcZWQFNCbcXXvcLEhvy+aT2h8n1sbDdzMbAFp1
	 0uja6NqHnM8R+UmJmxAc1GmNq0d8KqMoulJXqfUO4NXr1p6TJ8GOC8NV6i7EwRta83
	 g3djrXMLHcbBxp/RQjoFzqiMtQa/3gm5bon23Fztec54T3sGqm9or6l288An5U1sHy
	 JMNvpGgabEf3B9K3EAe4BAUgv9E9Xz1eYLTyxAAB7nd1M9KII30dbCO1pQTArpqEwe
	 pEeh1W/GaqzXw==
Date: Fri, 22 Aug 2025 11:25:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>, Shawn Guo <shawnguo@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/5] dt-bindings: vendor-prefixes: Add JuTouch Technology
 Co, Ltd
Message-ID: <175587991149.3969185.13763012454689940665.robh@kernel.org>
References: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-0-b492ef807d12@pengutronix.de>
 <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-1-b492ef807d12@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v1-1-b492ef807d12@pengutronix.de>


On Thu, 21 Aug 2025 09:55:28 +0200, Steffen Trumtrar wrote:
> JuTouch is a chinese touch screen supplier dedicated to manufacturing
> high-end touch display products for the global industrial market.
> (www.jutouch.com)
> 
> Add a vendor prefix for it.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


