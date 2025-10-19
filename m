Return-Path: <linux-kernel+bounces-859837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1491BEEB90
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82C01895CF5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A522EC098;
	Sun, 19 Oct 2025 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=palvencia.se header.i=@palvencia.se header.b="nC28rg7a"
Received: from m101-out-mua-6.websupport.se (m101-out-mua-6.websupport.se [109.235.175.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823992E8B97;
	Sun, 19 Oct 2025 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760900206; cv=none; b=DCCIsXnbyn9HnzVMsR/oghIUnqmP30zn+xBwGb9/13M1nVJEOWgJM6NRdOwIEfKXZdButsvkKYuGNLOFyxBnQbqpb4rTAjOn2tUF+J0Ar3WeTghdj1levaP59QmiwA6TTVYYoxL33xGotsnk1Guu3em9qm/I/Vfn2uRnHUIhSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760900206; c=relaxed/simple;
	bh=Gdh005VVFFUWHPDhsTxgWCztIj/mGn5sbNvKcgzI9xY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOHush85VFKotBYkxX+9nMbk2mpuajETGDoZvbu8Q4qltSwbyoS2Zzhxi6OYiPmdTIGOENMHZZz45fyPDhA6MTq3xdSbsw6d8eeiYHsTVWQQThvG2NlkKhfLH2ly1BmVn+hPr6zEYgtEKeLSnsvAUDp6sebpJFV1EhXuFUQI2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palvencia.se; spf=pass smtp.mailfrom=palvencia.se; dkim=pass (2048-bit key) header.d=palvencia.se header.i=@palvencia.se header.b=nC28rg7a; arc=none smtp.client-ip=109.235.175.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palvencia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=palvencia.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=palvencia.se;
	s=mail; t=1760899479;
	bh=GdCruKGnpf4W6CfP6MEmI9h0iCjx15NxA8dwOmLuHsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nC28rg7apx6pR5kRZM8gmR7UOqCmqBLQAmRWtNe8trIAo699ysmYJ6A1zMx5Xd5/R
	 TpQrrWP8w96stwWvigu4tR6wvmB+1lGSDQsW1lAiDHD72HLTJR1sq5v43qLYpi89Tc
	 8cScU4/MG1wpyLqad4I+Z4GWgNd5ZX5AuRw/RHvyFXMxmt4hxaPzHW5JVOzUgggi41
	 BTJg5IIW0hv2FSKLBoXVk8z4tUYWAZ1SVzhPnI3+BIvhQoE/U4OMGdWdBZoZEp+1s9
	 /KsQaAuKIsbXjhwxDTVHPfGMhD8PKtK2mhMvtv9XybXRwz44w7mzVEhc8upyy5L7ya
	 EHKLvAFOJSUxA==
Received: from m101-u5-ing.websupport.se (unknown [10.30.5.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-6.websupport.se (Postfix) with ESMTPS id 4cqSCW1zFWz1Ccc;
	Sun, 19 Oct 2025 20:44:39 +0200 (CEST)
X-Authenticated-Sender: per@palvencia.se
Authentication-Results: m101-u5-ing.websupport.se;
	auth=pass smtp.auth=per@palvencia.se smtp.mailfrom=per@palvencia.se
Received: from rpi (unknown [193.180.91.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: per@palvencia.se)
	by m101-u5-ing.websupport.se (Postfix) with ESMTPSA id 4cqSCR4QFhz1fWs;
	Sun, 19 Oct 2025 20:44:35 +0200 (CEST)
Date: Sun, 19 Oct 2025 20:44:31 +0200
From: Per Larsson <per@palvencia.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: wens@csie.org, samuel@sholland.org, mturquette@baylibre.com,
 sboyd@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: Mark A523 bus-r-cpucfg clock as critical
Message-ID: <20251019204431.32254cb4@rpi>
In-Reply-To: <20251019172647.80379-1-jernej.skrabec@gmail.com>
References: <20251019172647.80379-1-jernej.skrabec@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Out-Spamd-Result: default: False [1.90 / 1000.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_ZERO(0.00)[0];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:35790, ipnet:193.180.91.0/24, country:SE];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_X_AS(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Out-Rspamd-Queue-Id: 4cqSCR4QFhz1fWs
X-Out-Rspamd-Server: m101-rspamd-out-4
X-Rspamd-Action: no action
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 423
X-purgate-ID: 155908::1760899479-A035718D-94DDE7B4/0/0

On Sun, 19 Oct 2025 19:26:47 +0200
Jernej Skrabec <jernej.skrabec@gmail.com> wrote:

> bus-r-cpucfg clock is important for peripheral which takes care for
> powering CPU cores on and off. Since this operation is done by
> firmware (TF-A), mark is as critical. That way Linux won't interfere
> with that clock.
 
"mark it"
Also, I think it's "takes care of"

The change itself looks good as far as I can tell.


