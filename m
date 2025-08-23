Return-Path: <linux-kernel+bounces-782997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DE9B3282C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019C81C231EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A0824168D;
	Sat, 23 Aug 2025 10:18:51 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38141F099C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755944330; cv=none; b=TUNufdjNp+WGA6RKi3dESCgp7DYffrzCDBXt+vrWwU8osHzWeax6N/Z0niCx1Y7DpReyMmVHdSktWttIIUQXdOiSUGmnf2LEi1jmaYP3CsUJrpdXLuwkHYx3rThZhacmwwwbWd+Dqb7d1D5fTTSl79HMpS68/GMgYx95qpwguTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755944330; c=relaxed/simple;
	bh=BWKnQ2cdyYkquUE5zgWentJdF4jexQdTYZ/Ieqvi3Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQqTJu8QUU4n+twbW0F4DjfYhBpnAcDjTc0xSftFlJBxQpgSOHoF4pdZvWFkixEef4aKlvLOyAe/Of3MaY5UBSm7kIK7WJXUOnr3KFy8jfcSPDEb/lfTn5T/9+T2mjAVmr+67ybRmPNYFgmnOaQ64QA1/WomuEvPHwwdBejGsNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 57NAIOQY021165;
	Sat, 23 Aug 2025 12:18:24 +0200
Date: Sat, 23 Aug 2025 12:18:24 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: avoid error in dup2() if old fd equals
 new fd
Message-ID: <20250823101824.GA21040@1wt.eu>
References: <20250820-nolibc-dup2-einval-v2-1-807185a45c56@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820-nolibc-dup2-einval-v2-1-807185a45c56@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 20, 2025 at 10:29:27AM +0200, Thomas Weiﬂschuh wrote:
> dup2() allows both 'old' and 'new' to have the same value, which dup3()
> does not. If libc dup2() is implemented through the dup3() system call,
> then it would incorrectly fail in this case.
> 
> Avoid the error by handling old == new explicitly.
> 
> Fixes: 30ca20517ac1 ("tools headers: Move the nolibc header from rcutorture to tools/include/nolibc/")
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Good, LGTM!

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

