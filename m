Return-Path: <linux-kernel+bounces-803243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E20B45C90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921B7189FB9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DE92F7AD7;
	Fri,  5 Sep 2025 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4uTbyUOf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YSYcbSiR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D92F7AC3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086062; cv=none; b=ovwDXzDivXDeHAbXiGseCL3DDFA8Yvm0Nf0KWsA/sQlU6hWk/+GSjK2MzJIMdfGcRsJMdRSYvAbF35SdM5CH74COu/fafVwT3Zeg7gQXP9dV2oFE2WkJ5lAMYCkXbsZmu+BN9iM1rjmgZ5TpnbQqbbkm/L+tRrLH1qY/Ixj67yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086062; c=relaxed/simple;
	bh=MvtFNwZE/5qAGJecxAQcYgQ0r1QqcdO3KaNYOXqf29s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nzD+nzbY0ixznOPO5Fdc8tQiGwBWYm73HUdRmpNaBdV98DSkXvDL0rKqoCqXc6jfu4g2Na5VDwqtQhyEz8/YCYchm45joZTM6uS45yYZBeL3c2EUhNFGHxGeWMOfxChdXBkmT+2Lg2acYoDsVSLC3dV15HRaXy6Q39mXPuHZpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4uTbyUOf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YSYcbSiR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757086059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MvtFNwZE/5qAGJecxAQcYgQ0r1QqcdO3KaNYOXqf29s=;
	b=4uTbyUOfLqk56yMwyKWtFt3UcquJ136EGcfWmrwznOLtc7u/BP1ihKh2842TGHZY33Stz/
	eFEa44jHvzrxd75lYZv+YUtRYHzgawWI1B4lTxK5tEfIeZsiYQ+PBlvHvTu+GceWBOpGfl
	5d+lQynqLPDMU7FN2VLpnt4Nj63JL5BSV9IM14rGpaa8IyyKu4WHzuIHosWvyt1/dwb1jG
	ThTHOxPC7vQiQJVyGp7LXKM/4YdNQyEtuwdOrMOaEOvZUIZ1LfN/3XZmcNGFMYFNh7eXd0
	lYxABXfu1pasKOu7Lit2djz4YTcGlYnfTeGfOzgg2+/pWti7OzUUxRfUFYhGmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757086059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MvtFNwZE/5qAGJecxAQcYgQ0r1QqcdO3KaNYOXqf29s=;
	b=YSYcbSiRoIFpGPkKe5z0m+T9BBCL6i/B0OYzowiX6rpXrc/x916yVbx2PTv4EdYvm3BPVX
	3sUu/QhoBQF0O1DQ==
To: Daniil Tatianin <d-tatianin@yandex-team.ru>, Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 2/2] printk_ringbuffer: allow one data block to
 occupy the entire data ring
In-Reply-To: <20250905144152.9137-3-d-tatianin@yandex-team.ru>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <20250905144152.9137-3-d-tatianin@yandex-team.ru>
Date: Fri, 05 Sep 2025 17:33:38 +0206
Message-ID: <84qzwkex79.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-05, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> We no longer require a trailing id at the end of the data ring, so
> there is no reason to check that one fits.
>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
Tested-by: John Ogness <john.ogness@linutronix.de>

