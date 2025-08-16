Return-Path: <linux-kernel+bounces-771960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6289CB28D40
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F671C85B43
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3982277C9A;
	Sat, 16 Aug 2025 11:02:33 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014452750E6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755342153; cv=none; b=hUiYRmd4W9IfhX8J1JftsUg85I1WXMweoDCeHV5LYJ1PGVQklp06jcTvQ9ydum2l9UeELzD2cbSjCz6DCBtl/HqjV6+8sGllmze3HZ7U+ftAGw3TJY87wwxLgmkxUNTnPfCPJiXzDmG/zx3Suw6Wv2RTX8h0KjSLE+ziHsaMkLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755342153; c=relaxed/simple;
	bh=59HlvgTSA5pq8bEehTsORj9Ymxa3lmVL5TaQBN5dr0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJJvGu9pfRj/+JIh6AtrnkULuLLXJtz5i/hnX/GzZ4x5zvwiNseyUAI+mzyWPwmL99nI0T28FT/yB6jUSRfm+g53klKhAsWzgqHhoekqpZ/UDcIZG5F/IOf8rmDO33x75Vvc4GFEeTzK7kDD6575HsBQHB2kaHw7slUMVIip6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 604372C06644;
	Sat, 16 Aug 2025 13:02:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4BF932E66FB; Sat, 16 Aug 2025 13:02:22 +0200 (CEST)
Date: Sat, 16 Aug 2025 13:02:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: obitton@habana.ai, ogabbay@kernel.org, ttayar@habana.ai,
	fkassabri@habana.ai, osharabi@habana.ai, dliberman@habana.ai,
	quic_carlv@quicinc.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>
Subject: Re: [RESEND PATCH] accel/habanalabs/gaudi2: Use kvfree() for memory
 allocated with kvcalloc()
Message-ID: <aKBlPnl69z85WblU@wunner.de>
References: <20240820231028.136126-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820231028.136126-1-thorsten.blum@toblux.com>

On Wed, Aug 21, 2024 at 01:10:28AM +0200, Thorsten Blum wrote:
> Use kvfree() to fix the following Coccinelle/coccicheck warning reported
> by kfree_mismatch.cocci:
> 
>   WARNING kvmalloc is used to allocate this memory at line 10398
> 
> Reviewed-by: Tomer Tayar <ttayar@habana.ai>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied to drm-misc-fixes, thanks.

You used toblux.com in the Signed-off-by tag but have since amended
.mailmap to use linux.dev instead.  To avoid a mismatch between the
Signed-off-by tag and the commit author, I've taken the liberty to
hand-edit the former to use linux.dev.

I've also added a Fixes tag and stable designation.

Qianfeng Rong later submitted an identical patch, so I've added a
Reported-by tag to acknowledge that:
https://patch.msgid.link/20250808085530.233737-1-rongqianfeng@vivo.com

Thanks,

Lukas

