Return-Path: <linux-kernel+bounces-739824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50563B0CB89
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878E654479D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CE12327A3;
	Mon, 21 Jul 2025 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqpacYis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628381A23B5;
	Mon, 21 Jul 2025 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128997; cv=none; b=MXwxCAz939794tR0xAigXLvlstWbaA7vv+vnB60/8XAU9Qqggu1G9xoYRe0i3TVKHNP2JXa9GpPX5OwJIgMlDkyQNopUIXOJxyU6FGc/n7kU+/Hz+eZXKQ9az+wD/FD/z/0OjEs7UrMIFYIv8niTYPYhf0EfRXYIU/ZffHJeUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128997; c=relaxed/simple;
	bh=rlb86JkfwjH+a1EcbjIussFtPP3jc+ntSHacOmNEriI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4abmfCjKLI3uB3P42tuJWSPd8EVcKljNKcvQJUGwu/2Gel6wjOb/Nd2vz4Y6FovwK6JbslCJonTumaTJZ0YjwytQgYoHqAEf/ODhulM99IagZ2YxWZ9pTsGjIJkwEyk0/cOuGJVNsdk+bjNAQfkCNDKfgJOH8XbDf/YZ1akujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqpacYis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B06C4CEED;
	Mon, 21 Jul 2025 20:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753128996;
	bh=rlb86JkfwjH+a1EcbjIussFtPP3jc+ntSHacOmNEriI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqpacYisUr5aLulE9iB3ZzI0lpF8sfZfVvVekT2i/3+AdZNiAHdVEmHEaeuQAa3FR
	 YdlL6jDRawNCBMmME0h550kImdTdbdrR7OUgbFj2Qeb5A8fap8lc433K/85Awyk+R7
	 6KjNRSnXqywGVtkUNX5Wwq1FtnY8smYZB05fkV7OZVzC1mg/SZDZBc/PKxFM3WZw2c
	 mTsz0c6ap9AC7zhDtzX1U7rVJBIHthjnyw93VuOlIYtmwfQI+Za2Wq//byAfuiEbBc
	 rnFdrZ+J6VrUyRw3Iw4XmNuxntsWYg0EniGnB21Ysx3F6edmtwIT9ns95gKAZtwTDA
	 3/id/djRa8bwQ==
Date: Mon, 21 Jul 2025 15:16:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: display: sitronix,st7567: add
 optional inverted property
Message-ID: <175312899553.1254894.11188428006937246926.robh@kernel.org>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
 <20250721-st7571-format-v2-3-159f4134098c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-st7571-format-v2-3-159f4134098c@gmail.com>


On Mon, 21 Jul 2025 12:43:33 +0200, Marcus Folkesson wrote:
> Depending on which display that is connected to the controller, an "1"
> means either a black or a white pixel.
> 
> The supported format (R1) expects the pixels to map against:
>     0 => Black
>     1 => White
> 
> If this is not what the display map against, the controller has support
> to invert these values.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/sitronix,st7567.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


