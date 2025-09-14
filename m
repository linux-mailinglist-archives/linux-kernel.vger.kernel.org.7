Return-Path: <linux-kernel+bounces-815908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F00BB56C98
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5331899F69
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180212C3255;
	Sun, 14 Sep 2025 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VYiMzvbZ"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9C217722
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757885829; cv=none; b=dUF96VfP3h9u2sxKvd1/eir67gtWcjLhEa/C+8ALHXUCBGOC41D3IS0KdJ4elLLmUd3LRqyTTnsJpVvOTF3I9ufvZA0jwNtTD3VbtE/1ZP71dNvMrtNuVZjNL3vlXvYfchedRGx09UGif1s8MTPTA6S0xu4D8oPJYlx34YlllEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757885829; c=relaxed/simple;
	bh=0obPgRQ7Hm+Bb6cPAVsNuDVbFrVrACx8vDeCaH/fyOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaS7fDmbyhnjAJciohgWRv1mTRo/uRjvZcTJ3voJS7Q5nPhviYCBZvSEfvvpyrz8M4cZFQOcNHhjc3/7iVo/RQQAYEUqWxLUA58F6FX0tJGEx2fKzsOuW7HTeED1655D1IAO70FMAeLit9SacRXl7Ih4br7E19w0HoP4EyNl17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VYiMzvbZ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lAh2
	9qMOUXQ/TP64YFXHyhbZt3V0AZYWq1eFjSQXKFA=; b=VYiMzvbZwOlSk+oqTTcB
	OcVCIEbpJJAWaXZjzI13t6dPwMlOVbqbBxqh4OOxBGXazX1+6deHIWvLf3Km7A5a
	0zMhsHkc1a1/pQI5xi7b5K8/8elJ0Oy9hlJNCNiG0PfdfxbheqJWRTlGwkn6zYsi
	sq0n0iobgmiNtPsLWVsHxMiiim3e3KyhTK0C1wkF9YYi9nsPpASBH5je7Bc6zpiR
	0rWN4bgk+2hxEkjYUva2e//plPVeVg0d2/mBZXk4b/xA39YJgp8qWw5nDJhWNKBT
	yYsHWftZ23IJkeE/rHibXdOy6zr2gm2IcwPOn+LtyzoHJb5eOHiHIWualtHVq6gw
	ww==
Received: (qmail 2122476 invoked from network); 14 Sep 2025 23:36:57 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Sep 2025 23:36:57 +0200
X-UD-Smtp-Session: l3s3148p1@th6sr8k+CIQgAQnoAHzAAGOD5Y6fT3HK
Date: Sun, 14 Sep 2025 23:36:56 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] i3c: master: Remove ternary operator on return
 statement
Message-ID: <aMc1eMXynVbozUMz@shikoro>
References: <20250902135239.2632286-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902135239.2632286-1-colin.i.king@gmail.com>

On Tue, Sep 02, 2025 at 02:52:39PM +0100, Colin Ian King wrote:
> The value of ret at the end of the function renesas_i3c_daa
> is always zero since previous checks for less than zero have already
> exited via return paths. Hence the final ternary operator checking
> for a less than zero value for ret is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Already sent (and applied just today):

https://lore.kernel.org/r/20250803211256.18513-2-wsa+renesas@sang-engineering.com


