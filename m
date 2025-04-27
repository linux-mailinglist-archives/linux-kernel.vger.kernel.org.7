Return-Path: <linux-kernel+bounces-621992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA31A9E13A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 10:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1873917EED2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 08:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA2924A07B;
	Sun, 27 Apr 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gb3ESE6h"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A679246326
	for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745744242; cv=none; b=DzsrnSrn1yxkzoQTH2hmuQIJyl/NRc0/ZO65CeUoTr7yFPmTgkfWI16CRfrib70I6yxhRQ+Q+jOeNrW5epEss/pvZZcGbBFScwq1x02sFOLmTV/DkdiMxpiP1cBBN49DiEMyGPRL2VJkBCg2LI4d3Qp2K0mlI/SGAByFYYEanRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745744242; c=relaxed/simple;
	bh=YJJpOOPhhRGCzDekeP0edTFaZoiIZvlimNyXq/m4AT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRwd3i02J1c2YnRkKKFWbTuvpHNeq9QAoSoYjMM+J93DwG5efv9tCWmc5T5bCLCFSWXA8h86l4o7a3ef6LGY2DXnklXq31PlWM9z9N7wOjwELH9R2pWMpUjwMagV8hBT/RyPbgIhSlZCS1x1GP2XnCi5JnOhL1guyALGp3RnIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gb3ESE6h; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745744233;
	bh=YJJpOOPhhRGCzDekeP0edTFaZoiIZvlimNyXq/m4AT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gb3ESE6hAVpaam9l4jNbXwEihGzD3do0F2/tP/MPr8ScvyM+V9vb54ng8H3zi0Bmh
	 3eZ1ssrP+W9ZlS9ZwCTP8+ZAoIovfn/sD2+0pxAqfEyqpf7czdebDJOuxCl88/BVEk
	 eJTzJpmdWFEfT7yn0tV4V8N4o/+sKTmtNXUCEf4o=
Date: Sun, 27 Apr 2025 10:57:13 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Daniel Palmer <daniel@0x0f.com>
Cc: w@1wt.eu, linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, 
	linux-kernel@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>
Subject: Re: [PATCH v3] tools/nolibc: Add m68k support
Message-ID: <63007b04-80e1-497a-ae80-ee518c9c0792@t-8ch.de>
References: <20250426224738.284874-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250426224738.284874-1-daniel@0x0f.com>

On 2025-04-27 07:47:38+0900, Daniel Palmer wrote:
> Add nolibc support for m68k. Should be helpful for nommu where
> linking libc can bloat even hello world to the point where you get
> an OOM just trying to load it.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

Thanks!

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/arch-m68k.h            | 141 ++++++++++++++++++++
>  tools/include/nolibc/arch.h                 |   2 +
>  tools/testing/selftests/nolibc/Makefile     |   5 +
>  tools/testing/selftests/nolibc/run-tests.sh |   5 +
>  4 files changed, 153 insertions(+)
>  create mode 100644 tools/include/nolibc/arch-m68k.h

<snip>

