Return-Path: <linux-kernel+bounces-894049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54689C49253
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2689A4E05CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5A2FB62D;
	Mon, 10 Nov 2025 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="f3IiMMyK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58A32D0C3;
	Mon, 10 Nov 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804384; cv=none; b=MXqmENEsSFTG7AGn9USheUSUmuCm+kM/K1gzpeoAGp9NkFeHKhdXko/M7j5+pVLV7N10Jb9fJ1pvHXudBZ8PAqYU9KAYoOTQ785nAIMf+5q9slm48Ur5yT/Qze4MYQtqMC05O/PqZ0Ll8FU+22KxXT77BKkO3biPEKgWbXeiLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804384; c=relaxed/simple;
	bh=593lg7WYhSNFDL+lX1yxQ4acmzaBL+9/L9NsHmC8mlQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s88Bti37/C/DifSNksXkaVZqQ/SGnuchEkIXLOoW6MYbnijMOrm7fZ80G1hVHHPtVjkndFUq8Sm3TXbe42of5LxWGfozCMSePZqSiyPPAuNrRctAqNKTK0z0BlJukoJAi+jz8OECuF3njXDGD59ECgmjgc4vhwHqbRoSzDanVwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=f3IiMMyK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C3AD040AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762804382; bh=3K2szgXgKGDAgRGNnpYWMY62UngUH3NvZLWb8UD9Djo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f3IiMMyKJzfAnVABkpPYsY5yu6X+LvIWJPMnMDhQI1oz0xgGfz4/uOlmvrvgn3s8I
	 cY/eEx6UwxEZ8t497pbBc+HAqQ/nINurLqN1IgIgs4cFS9NiUNXSQEcNsyETNgtJb9
	 7FutZ3YZfMAZXZ/Bwzqs+ADLt8BZH3MVcvcZYP91YHCAQ72wOOGeoURgJTOd75ahky
	 sgeH8rUm+rPv0WExnQHhz/VCDrV99y/HkjhlbdHzwxtFkpNRYiHHya8T6xHKUt8zuo
	 LBeyjsrFCfySCyGe3YN3n1GNcPwaL6QlspWLQrWhvwkx7W287DdiMvRkk+gQDvPQaX
	 vJKcP4oGkpp4Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C3AD040AFB;
	Mon, 10 Nov 2025 19:53:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>
Cc: Balbir Singh <bsingharora@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] Documentation: taskstats: Reindent payload kinds list
In-Reply-To: <20251104130751.22755-1-bagasdotme@gmail.com>
References: <20251104130751.22755-1-bagasdotme@gmail.com>
Date: Mon, 10 Nov 2025 12:53:00 -0700
Message-ID: <875xbhy89v.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Payload kinds list text is indented at the first text column, rather
> than aligned to the list number. As an effect, the third item becomes
> sublist of second item's third sublist item (TASKTYPE_TYPE_STATS).
>
> Reindent the list text.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/accounting/taskstats.rst | 52 +++++++++++++-------------
>  1 file changed, 27 insertions(+), 25 deletions(-)

Applied, thanks.

jon

