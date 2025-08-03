Return-Path: <linux-kernel+bounces-754470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92983B194A4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47C2174AA1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06481957FC;
	Sun,  3 Aug 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q6M8mhpz"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5CD2E3705
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754241527; cv=none; b=ZTPCOgrQUwrrXkwp7o141IdOENS/0E0tQqoUkbKNO/BZgFNMULELBCplikn8njDDRLBRo3HWe72elyrzZyfOv465AD4NaiWV7iGF4Qt+//yvTya/HFO4jImM9xqhiCORiJbM0ohjtkOVttnOqD2azpHHMLclafUJP9oK9UtMBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754241527; c=relaxed/simple;
	bh=2VeUQAFsYpgUGCW3n7CfxT7zSkXN9t4OUVHM7m2rrwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNc8lGroiYuV7uIrlpMTFxwjTVccbHafqYc1WFkkRB78skb3ko+8xXBJpp/7+pbdaYVWuiSe9BuHqQoURxgKz+zacx2lOipJp4EAQXafXC74nPA4L0zHCQxLPemeYU3d9O5CQsjUNQm7QgEzl7o0rIDQkbHkkxqINCXNaONLiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q6M8mhpz; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 3 Aug 2025 13:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754241517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezWtFpUA8HJ8s2mBTOH7FVKV44vryXvEpySF6TjdsUQ=;
	b=Q6M8mhpz+B7S7CAaG9Bw5ej9YPPVy0Dy8FMVHcnHAECUqymyQUdDnXry0XF/AQ7QREQk5c
	zW7wdFwkbYYwxRVsoAHQeshSL+X5bZt2xsUfdPCKFYj/f6QstEA1Ui6XPsPmI5xIGC9IGA
	TM9WJrxNQKEKXvt2fo7Wg2HAFvhVKzA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "open list:BCACHEFS" <linux-bcachefs@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, willy@infradead.org
Subject: Re: [PATCH 1/4] bcachefs: Remove redundant __GFP_NOWARN
Message-ID: <meipfzgml62kwea63bzx2idp4asce6kbjdm5zqpskkqfcjyyfv@5smvbtt3depd>
References: <20250803102243.623705-1-rongqianfeng@vivo.com>
 <20250803102243.623705-2-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803102243.623705-2-rongqianfeng@vivo.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Aug 03, 2025 at 06:22:39PM +0800, Qianfeng Rong wrote:
> GFP_NOWAIT already includes __GFP_NOWARN, so let's remove
> the redundant __GFP_NOWARN.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Thanks, applied.

