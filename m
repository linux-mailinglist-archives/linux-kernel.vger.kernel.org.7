Return-Path: <linux-kernel+bounces-881806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F15B5C28F5A
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 13:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E5A14E407D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 12:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8878F51;
	Sun,  2 Nov 2025 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GByaerpM"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DC3D76
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762087918; cv=none; b=Hq6c8iwZ7A9eRUUignfajcwPEjkbfdH4Eg4PXeNkcjBuyM+tatrrfrgByKrICGS2kKWJC8Nl5Bn+40csTmlVtLMJCk8KMstYhz6ttj/zMLfZ9nrEH8aieJYNsSdkZjKCAZTGFXobV8BbIRw46XiD9rUTkqDu2rwln2QZ5Fe+HX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762087918; c=relaxed/simple;
	bh=5wShUNnWbIaEVmSeITVINCju2QSF0x5YRuSv7VmvoMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/W5zWvHPB9DJkE2ivsjsRureyB3OYzDxJGgD2GyKpvQX5yokHbbVHzVk/uCZD1Jot9LAfwOn1jk38Q2EdEqRg+StPBmD76MqEXIrP0e7FqUJkUtSJT3qH+TElDsfapJdql733M/QUQZbHXLyWdzwwdi5TA4IxcHeuBxItM6irs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GByaerpM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762087914;
	bh=5wShUNnWbIaEVmSeITVINCju2QSF0x5YRuSv7VmvoMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GByaerpMWXK/9XOmo5Vz6TY5mbq2nrzBvSTt3E9AfbdUZ1I48TbImXLPGP9749v+c
	 75a5K6WP14xil1E+HFfLbIZEg52t4zGPBWmEiLnfVuH+S1ZWTi/5cYh4Uw2sea6eSA
	 9lKXTCKpdG/C6L3J3PgHqQeM65+6S1jfbVWTEAQE=
Date: Sun, 2 Nov 2025 13:51:53 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tools/nolibc: provide the portable sys/select.h
Message-ID: <29219c06-1dcb-440b-8479-98862b12bb10@t-8ch.de>
References: <20251102104611.24454-1-w@1wt.eu>
 <20251102104611.24454-5-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102104611.24454-5-w@1wt.eu>

On 2025-11-02 11:46:11+0100, Willy Tarreau wrote:
> Modern programs tend to include sys/select.h to get FD_SET() and
> FD_CLR() definitions as well as struct fd_set, but in our case it
> didn't exist.
> 
> The definitions were moved from types.h to sys/select.h, which is
> now included from nolibc.h, and the sys_select() definition moved
> there as well from sys.h.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  tools/include/nolibc/Makefile     |   1 +
>  tools/include/nolibc/nolibc.h     |   1 +
>  tools/include/nolibc/sys.h        |  45 -------------
>  tools/include/nolibc/sys/select.h | 103 ++++++++++++++++++++++++++++++
>  tools/include/nolibc/types.h      |  47 --------------
>  5 files changed, 105 insertions(+), 92 deletions(-)
>  create mode 100644 tools/include/nolibc/sys/select.h

Applied.

