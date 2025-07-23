Return-Path: <linux-kernel+bounces-742809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF0EB0F6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4E55665C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F7327C152;
	Wed, 23 Jul 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+Nwg9Zs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD021ADC7E;
	Wed, 23 Jul 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284248; cv=none; b=azdFQ/UAXLq/99u8OYtx0CkrJL0xyz1aovQcaBGrtRxHMnAU31XPQU5ITu7OWq6SJhNcok/qNyFDm6SUsZkGUQU3NWtD385mTTh3iGfFDj0pdPZjMSaS1alqrEK89XZOpsjnGceckkz3mksUxm18/GENipFGgjqglxFgXBoweVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284248; c=relaxed/simple;
	bh=PfLBxB7iS5EknfRg10irNpQaBpSsgQPAbFFce9nbvTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWQNiEpmuQgvF5ChPNtDnqk0XiBnJeTN7nWL1ecaWwx8jAj3nfwYx/LY5pM6VMxqApVZPMog35QFYA2MdOBsmkZvp8J5v+SN5gvmbhR94onYzIQKiwsEAjvOrw1KZhFi1dLDTsJGfC1c6damN+4fHxTLL+0UjoZbGWInIQjmIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+Nwg9Zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70AFC4CEE7;
	Wed, 23 Jul 2025 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753284248;
	bh=PfLBxB7iS5EknfRg10irNpQaBpSsgQPAbFFce9nbvTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k+Nwg9Zsme67KdepN3vZz4POgcmZu1fbYhLEOFrmh1ssjhj7i3LYHELBbtUBTAX+W
	 /ROBNuwaeXXgb1M0bk5IrY6V0tk1hzye0uPQwYBvrZ49cXZhbEtKVIlrDqRqbF5J3e
	 QnhRxOyzgdFPB3Kbiveho5l1AZM6swW3s+63gGwh3z+aX+F5hRQFi1ETq9oa/nTNJc
	 YGVMqkK/6Ikq6Ak5z+nOaAFFprEuYbxAl/RkBEnKab+mOfYY36zXgc/AUW/soM1QSj
	 xzneXmtw8Q09icbEU5BLDIToafEsjSKyLGinKVSSnumieGTiY6J4F9qq5JHpLfVzgP
	 HDUe741HckHPQ==
Date: Wed, 23 Jul 2025 08:24:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: Warn when overriding referenced dst entry
Message-ID: <20250723082407.06686876@kernel.org>
In-Reply-To: <aID8FaYlyuVjeOH_@mini-arch>
References: <20250722210256.143208-1-sdf@fomichev.me>
	<20250722210256.143208-2-sdf@fomichev.me>
	<20250722190014.32f00bbb@kernel.org>
	<aID8FaYlyuVjeOH_@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 08:13:25 -0700 Stanislav Fomichev wrote:
> > > +{
> > > +	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb) &&
> > > +			       !(skb->_skb_refdst & SKB_DST_NOREF));  
> > 
> > Why not 
> > 
> > 	DEBUG_NET_WARN_ON_ONCE(skb->_skb_refdst & SKB_DST_PTRMASK);
> > 
> > ?  
> 
> That's more precise, agreed!

Just to be clear -- looks like I ate the

  !(skb->_skb_refdst & SKB_DST_NOREF)

part part of the condition. I think we still want that.

