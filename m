Return-Path: <linux-kernel+bounces-892133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E6C44689
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D8404E3AC8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D0C24BC07;
	Sun,  9 Nov 2025 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="s5IOxCIj"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B51482E8
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762718286; cv=none; b=TDjjwbTk0Tb57J31NUUW02//z7buxONbrNsfiEPe+UdlbWS9tfdgWPl1cpYbA9GGZjTA+3IOs/9B8RrrN/uW4sCDwH0o0gHnQ92tocL92kTMU8wN0EedaiyXuQ/Gy+m2RK2Kh17nWsttXDDBgdqomZ/9QjcZ62uIIAVszoGjXss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762718286; c=relaxed/simple;
	bh=StOs7dStn9wwdThcDLOsJzZOWVW5GxvGvktMWrC5SUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh5CxbQhrO8U8nUCZLb82rPTuA5hH62xzJ9tFKcIu5U6ZxGOCqiiKVWvrG2FzUGpW/4VX91WIocYGLTQKjGCXGoq3fFslH9M9E1z5RD91NmZ82k6LGU8I/ZJc5I4qlbH/C4xq7C1VF6NR9mxhIjtBgkJdwmGaFxnmkcKPfS3sN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=s5IOxCIj; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762718275; bh=ACgTvlYldF8p/INRuO/CSG+9SckkRr+QxsgUqYxASW8=;
	h=From:Message-ID:From;
	b=s5IOxCIjoDiHMDSVQChBUUBnO34JErOekk0QC4ijs1kOI7+EfKEejJjmHAD/geaxc
	 XVHfynQpuFt07TdZ9GJEE/MIzIkbuQsU8oOL2w1nDA9hompEuqy73+c8UZPgNfIkVB
	 b6gUKlSgTqmqhH3wY9yaR9ssfHq5WeMqeJ3iCDmY=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id BBCFFC06F2;
	Sun, 09 Nov 2025 20:57:54 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A9Jvsp6020530;
	Sun, 9 Nov 2025 20:57:54 +0100
Date: Sun, 9 Nov 2025 20:57:54 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tools/nolibc: avoid using plain integer as NULL pointer
Message-ID: <20251109195754.GB20023@1wt.eu>
References: <20251109-nolibc-sparse-v1-1-02256638a99c@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251109-nolibc-sparse-v1-1-02256638a99c@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Sun, Nov 09, 2025 at 08:27:29PM +0100, Thomas Weiﬂschuh wrote:
> The integer zero should not be used as NULL pointer.
> It is invalid and sparse will complain about it.
> 
> Use proper NULL pointers instead.

Huh ? I've been using that for decades and seeing it everywhere. That's
quite bizarre, 0 is perfectly valid as a pointer. Ah, here it is, in
C99:6.3.2.3:

  An integer constant expression with the value 0, or such an expression
  cast to type void *, is called a null pointer constant.

The change is small, so if it hurts sparse, I'm fine with changing it,
but at least the commit message should be adjusted to say that sparse
doesn't like it and not that it's not valid.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202509261452.g5peaXCc-lkp@intel.com/
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

For the patch: Acked-by: Willy Tarreau <w@1wt.eu>

Thanks,
Willy

