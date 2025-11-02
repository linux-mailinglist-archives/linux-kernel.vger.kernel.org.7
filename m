Return-Path: <linux-kernel+bounces-881835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD8C29073
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE06188DA2D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736F1D798E;
	Sun,  2 Nov 2025 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aNwYkmNp"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B381732
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762094437; cv=none; b=uGDlvuKfxanthoBI/zxjBf+tKeMPf1OCAYc1ivlCLq6ZQZH+XXCPq/TEw1eZA9/5+uL1XGNpkzi9tx8jWtOWXqbgJjrP91tqjFwWLPhsXKn/wLJJItcxfoWFKxcCa2mVdC90B/pKx7PcIE69inkXQUsJG12lRMPRO7/1P0UqjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762094437; c=relaxed/simple;
	bh=NxulDXsQijfkGUPxWuUODLJ/HAvZvhICQGEKkGTl4kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBAOJ8XlWo2QAKMwlvSKbImkA4xSI7aK9xLkkvXbiEc3neXVh6ZR97qRRWlhWw4ftJ8T7PtfACXpLqUJqYUDBEdG31Pop4MD39oQZcElpjHDBUNcklKN+kSkY+M1bDqhSdMAuMpaZ1aHVZNCj72Sn9XwyWSytKUr+uquEtVgASo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aNwYkmNp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762094433;
	bh=NxulDXsQijfkGUPxWuUODLJ/HAvZvhICQGEKkGTl4kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNwYkmNpIR0k+j2OEL32hO3YaKV7irRooS//ZGtjvnJH2nT5MEFZuVjxUbkqrrzcy
	 ztkrzasVnuyokPHP/zGjXagy7ZeivoFVDxs4bBaZsTity3p976Rkz8fkBccKNy4gIm
	 yRVauKwmtbtqDJhw/qxoZm9c4+b09H9qHsbSm7nU=
Date: Sun, 2 Nov 2025 15:40:32 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: clean up outdated comments in generic
 arch.h
Message-ID: <ba29f952-eb42-4361-b0d8-6a70fc4be6ba@t-8ch.de>
References: <20251102142548.15482-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102142548.15482-1-w@1wt.eu>

On 2025-11-02 15:25:48+0100, Willy Tarreau wrote:
> Along the code reorganizations, the file has been keeping the original
> comments about argv and envp which are no longer relevant to this file
> anymore. Let's just drop them.
> ---
>  tools/include/nolibc/arch.h | 9 ---------
>  1 file changed, 9 deletions(-)

Thanks, applied.
FYI it seems patch 2 never got sent.


Thomas

