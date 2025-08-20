Return-Path: <linux-kernel+bounces-777143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623F7B2D5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FC91894E54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C492D8799;
	Wed, 20 Aug 2025 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U39V5nHD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17072BE62D;
	Wed, 20 Aug 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677582; cv=none; b=izU3auU3ItGFDNUwnGuejdnKv/zIxJ/GA6oXPQRY0r0j30s5el8brO+S7QOdle1rGthU92zZNERDpF2rom4INUAJ8yDAhDzSqHLgHENWXJrUT9ZY7uU2VmgDi/Sn24/WjoXNdiKRkIQFD5od7YfJ37n0xjo+fko3NsWdO36gVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677582; c=relaxed/simple;
	bh=CH9L5v4OJHqNF11uvWGznbvo74AYetAeErsKQ/WIsgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql073ruEA7DXKDICevWQGy3Mu8ohAGYkUg8jYry2I3oEzAu8BgAxjlwM5jE8FZo61BXsiaPRX4oIj0YtZ/nXrWfIekhrKCuxhw7KJuBGUDzf5aD5XDkkcyosP+yffo7CGiHDe7QhSK02yPMYSqL79onyT7SKlIlkXm87p0uuhiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U39V5nHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97A8C4CEEB;
	Wed, 20 Aug 2025 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677582;
	bh=CH9L5v4OJHqNF11uvWGznbvo74AYetAeErsKQ/WIsgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U39V5nHDEseiJajLZVfudpRL/MtpIT+/avAlSeh2oaPpigXeGuFJlFtv9Pna+GkJC
	 kNET9eK9bntCIZOV0NDew5F0GzNZFpLDKfHgrV2S/HvEx1rQjz0A0tQf0IZSpGM5/s
	 pvnn1fcJKT4FcYPEf2olm8TjAC1e4yY6P2fZ8SluGuEOueXPI3lnSORQgxvhqfALwc
	 XNsB4pu+l2wzfzeWI6gtUQsCoAC/aS75Ory43kIpRCskfkScxIZinzwVISdWerqWem
	 yTbjFbdJmBoSKt6f4fies/UpbdtFvx2TnExtnPiIFUILzyiDLit7yzWqSklHvh3Nre
	 iqAt5wZ4daSXg==
Date: Wed, 20 Aug 2025 10:12:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] soc: amlogic: clk-measure: Add more SoCs to
 support clk-measure
Message-ID: <20250820-spectacular-passionate-oriole-eaacda@kuoka>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
 <8e64245a-d7ce-40b7-b884-84a7234c4a3e@linaro.org>
 <673d8146-1cc6-430f-81fe-9e99896a56f5@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <673d8146-1cc6-430f-81fe-9e99896a56f5@amlogic.com>

On Tue, Aug 19, 2025 at 11:32:07AM +0800, Chuan Liu wrote:
> > 
> > But the fact you need clkmsr-reg-v2 means you at least need to add a
> > generic
> > compatible for v2 register map and drop this property.
> > 
> > Overall, I'm not a great fan of this, it moves data to DT and duplicates
> > the strings in _all_ board DTs, which is worse in fine.
> 
> 
> If you agree with this approach, I can refine it based on your feedback by:
> 1. Adding a new compatible property: "amlogic,clk-measure-v2".

NAK

See writing bindings document.

Best regards,
Krzysztof


