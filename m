Return-Path: <linux-kernel+bounces-772245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B09B29055
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 21:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3C55A607F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C47216E1B;
	Sat, 16 Aug 2025 19:51:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F7212577
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755373911; cv=none; b=tIjE63Yb/ronbZImip8FIBQUVFnBJyJTzrNwPiZ3JU2X6zeDIw3B16VVwlYGmeIw586qn9Yo2LPC+4wb6twDR9SWHDboPuKKc/gZtHuDFqal1+Xe3i1w5/tEfOQrShZfLx04RQj/1XWufFvy2pjyZJP8NezpTA3CajsuFFIuYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755373911; c=relaxed/simple;
	bh=yvoe9AzN65ppG6zOVnkHVM6aX3zYmRGnUX5z8JYlo/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z5JpBR0b9NzaRZO7sdQaXVv8UoWvZF2kjRzvpdGyy7/ABWKenBJxNpYZ+VmcoSfqidTZqx+UjGRMWv8+nFBDN9zMr1rKt25XgVsDeKFzFLBUoEQJTFfiPZoq76wfT0AZGMbWRGfE0Lpr/FuMSF6zVqdJrNw6ON760X5zdb+5wtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7BDC4CEEF;
	Sat, 16 Aug 2025 19:51:48 +0000 (UTC)
From: Daniel Gomez <da.gomez@samsung.com>
To: Petr Pavlu <petr.pavlu@suse.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shyam Saini <shyamsaini@linux.microsoft.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250813132200.184064-2-thorsten.blum@linux.dev>
References: <20250813132200.184064-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH v2] params: Replace deprecated strcpy() with strscpy()
 and memcpy()
Message-Id: <175537390637.76278.4292051193743883594.b4-ty@samsung.com>
Date: Sat, 16 Aug 2025 21:51:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Wed, 13 Aug 2025 15:21:59 +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() and memcpy() instead.
> 
> In param_set_copystring(), we can safely use memcpy() because we already
> know the length of the source string 'val' and that it is guaranteed to
> be NUL-terminated within the first 'kps->maxlen' bytes.
> 
> 
> [...]

Applied, thanks!

[1/1] params: Replace deprecated strcpy() with strscpy() and memcpy()
      commit: 5eb4b9a4cdbb70d70377fe8fb2920b75910e5024

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>


