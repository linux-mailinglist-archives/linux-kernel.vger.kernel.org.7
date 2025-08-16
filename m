Return-Path: <linux-kernel+bounces-771964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0542B28D47
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7046CB06C97
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7725CC40;
	Sat, 16 Aug 2025 11:06:29 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62C29ACF9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755342389; cv=none; b=VkopX2/XhDkE5DjVJUbwamqBg9FYCab3sQCiYFlS3EjP0TuTMTpan952h0ofD+yQ5Mak7cd/MLUQ0tudxEnHqSizECSgi6az1w+T+xnJ2OaqaD6RqB7+hft7bidaMkMDCo2n+9ejKmEY89MxPTxYmHzx7XRgJU+fovOXE3UL/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755342389; c=relaxed/simple;
	bh=+4RsrZ5dgkK22aV5ztvZrKWbLIXFQ8m1eKeTB5+K9NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlX9sNP7SJiUI0yNwUWV87ScQ3SSYihqKJMTsrjzNqpLLNWktCWlvvY/CT2r8VhX+SUG1gGQoo4Vyz44+sZwxerOcjXlALxnipgjd/Hjhynbt05SulsC8eL+nDp4IP67LxzioGW0B6iCWcw7sWSiaHWgHMKBae2R8Si06i7vV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 453052009181;
	Sat, 16 Aug 2025 13:06:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 27C5030A43D; Sat, 16 Aug 2025 13:06:25 +0200 (CEST)
Date: Sat, 16 Aug 2025 13:06:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Yaron Avizrat <yaron.avizrat@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Farah Kassabri <fkassabri@habana.ai>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>
Subject: Re: [PATCH] accel/habanalabs: fix mismatched alloc/free for
 kvcalloc()
Message-ID: <aKBmMU0_e2tGwCHT@wunner.de>
References: <20250808085530.233737-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808085530.233737-1-rongqianfeng@vivo.com>

On Fri, Aug 08, 2025 at 04:55:27PM +0800, Qianfeng Rong wrote:
> Replace kfree() with kvfree() for memory allocated by kvcalloc().
> 
> Compile-tested only.
> 
> Fixes: f728c17fc97a ("accel/habanalabs/gaudi2: move HMMU page tables to device memory")
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Thorsten Blum submitted an identical patch a year earlier:
https://patch.msgid.link/20240820231028.136126-1-thorsten.blum@toblux.com

I've just applied his patch but added a Reported-by tag with your name to
acknowledge your contribution.

Thanks!

Lukas

