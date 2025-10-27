Return-Path: <linux-kernel+bounces-871956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B53C0EF79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 080074FCE73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C8030BBA0;
	Mon, 27 Oct 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cr481KT1"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86330B500
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578550; cv=none; b=Hiq7Yj1BCpBFaMAerM/jIvaWrH6BavlB6vcXjhgCvvL+/SNCsUvyma08SFgpoZ9PYUcpTi4WVPERyMCulkzrTeLxMzLZsyNWYVyOz+IoNslUeYZMdGXEyfiSj5hokq1VtRWRA8S9FcEpqRoqL9ES/IivSxKdniyon7CN1tzkyu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578550; c=relaxed/simple;
	bh=L4UslJZeGhWR7oB5t6F0v7Eo08vuHSsbDsw7jsg/uqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/4/xPI6qrdokLPzsHhf/f6qxfRHH/XdiK4u/B6y+SX8R9iGUFLtQJKmiaEe0iSs42o8ecSI+Ox1s1SaL/VASY1jna6+VbZsb3nEbyo+asnLvrKmJFABxFANjcJJxtIbfUz5x1L85LDOl0nm8ykf73C5KmwGaoKghl4xBoVLUG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cr481KT1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761578540;
	bh=L4UslJZeGhWR7oB5t6F0v7Eo08vuHSsbDsw7jsg/uqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cr481KT1gbIrNczCFFrupeOc+HfxlN2EC3p7irvoR/JhYb19eOpicAFqUdeV8FCTY
	 hTfpGLoOnm0FTTXKuiLqlM0HPAwpYx3chbwmxXxiau/mjvJiIEDy4eq/zfZMGGceUG
	 sa3dE4wDGGoYUysnxr3YEbFintFirUZhRUAu/cLc=
Date: Mon, 27 Oct 2025 16:22:19 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] tools/nolibc: x86: fix section mismatch caused by asm
 "mem*" functions
Message-ID: <8c69bc3a-e67b-467d-8624-1277bfdb8e29@t-8ch.de>
References: <20251027102457.11280-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027102457.11280-1-w@1wt.eu>

On 2025-10-27 11:24:57+0100, Willy Tarreau wrote:

(...)

> Fixes: 553845eebd60 ("tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`")
> Fixes: 12108aa8c1a1 ("tools/nolibc: x86-64: Use `rep stosb` for `memset()`")
> Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Nice analysis! Patch is applied.


Thomas

