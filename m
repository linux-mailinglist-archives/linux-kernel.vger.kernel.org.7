Return-Path: <linux-kernel+bounces-735919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 058ADB0953E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430E31AA1E56
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4221D3C9;
	Thu, 17 Jul 2025 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Kg9sYn/z"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC221ADB9;
	Thu, 17 Jul 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782044; cv=none; b=U5BLmDTIz2lwjJiNFHA0lFuKV40vM5m6Qbm5yCG9dz8RQ+Nd3sUl5zOZkIRPRxPxmwekEXs7S4qjGZjYF2/+3hvglscmCFiYUKHfiv1rwrKLfGBewLcpi0lhnEiAIfO6gh0w9X/qC1uRKMRudVZS3Y0BhxDTdLeAai3ESvooy2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782044; c=relaxed/simple;
	bh=mxag0EA9QVtoEFbB3/fb5eEsLO9x+lg+p4NHcMB5xlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vx6mya9MG5uH6OsvGurzOlq4c/DaPDPnlzqsxuDp0cxZRw+0kpTv3Vp/erSJWeSb6gG14xNCJrz0aIQVON+TXschTNVDwV8DF91NYK9SYZzktJNr20OSIBsksGlNN/9GfUjdW16OM7//zs+wBS5FZec4YMCA4/5dyaVsx1DUsj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Kg9sYn/z; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 84C29403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752782042; bh=rmLGjZUOzw2uabknsvY65okDR53aN9pw+FFFf45vLT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Kg9sYn/z9kma55rXvG4dV5KkaUuOGiGrEFf8uh6IDeBI+lO6kHnM7RvzFuNFBrm+d
	 wWEgNDuoR7KeA3h30ZcCtAaTnO2soVgOyPwFoOX1TdKcZI9zODHIwcscSgTqVDFbHF
	 a5PZjpNkrdVXaEsy5o7BbhXtsWXUrU+MGPWiZxyJIRBSNMHMHskkHokxQ3ZNeS65e9
	 4rJrBcX+/TEfOHGWR5WXCp4ADpF0mHs0eiIDkuv5+nS7HNmDp5juPuLIjNtgb1o4ES
	 smhBqXTgmpcpf2aeReWhWjMOoPxdM4a6WsIPzRCjfPzaGt71KuZv7MRRpUUAvrexo6
	 xfDgksPSbvrfQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 84C29403E1;
	Thu, 17 Jul 2025 19:54:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nikolay Borisov <nik.borisov@suse.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, kernel@collabora.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: document linked lists
In-Reply-To: <0b85f378-221b-408e-865b-b4eab675a351@suse.com>
References: <20250714-linked-list-docs-v3-1-56c461580866@collabora.com>
 <0b85f378-221b-408e-865b-b4eab675a351@suse.com>
Date: Thu, 17 Jul 2025 13:54:01 -0600
Message-ID: <87seiua90m.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikolay Borisov <nik.borisov@suse.com> writes:

> Nit: I think it's unnecessary to repeat the initilization in code since 
> you've already explicitly mentioned you continue form State 2 of the 
> previous example, so the only salient information is the additional 
> list_bulk_move_tail call.

[...]

I have a nit of my own: now that the kerneldoc for the hlist functions
is here (it naturally moved with the rest), it would be nice to have
some sort of mention, even if just a paragraph saying why hlists exist
and when one might want to use them.

That said, I have gone ahead and applied this; we've put Nicolas through
enough rounds, and I'd like to get this in for the 6.17 merge window.
The nits can be addressed at leisure with follow-on patches.

Thanks,

jon

