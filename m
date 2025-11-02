Return-Path: <linux-kernel+bounces-881757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193FAC28DD3
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37123A9ED3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429E21D599;
	Sun,  2 Nov 2025 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eSPs90Yt"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83334D394
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081445; cv=none; b=lX3WmC/uS5zruzTQRJGAomMxoqgum+OLl79xg+KeQqwiMuxzi993xZY7IleqCtbrs31WgoXdxYd/Z/yMa8zZsJGUeov74pC4oIQ6HPhi22eC6r5bLjyJf1QOC9V3KwWG/hnN88Ce2Xy2KEsVY65iUyH+41x1lr1u0EnFVUXaWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081445; c=relaxed/simple;
	bh=WaPYZpNNClyyXEdpsBSEBFty1sbBBAPIxKesHhAawps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW0md769AsglUukaR2wnLfaNX3JgBdrThlLmD7hxEItsI2qtwBi3wCnYMfCfKpqfATziCINHyoWoNIIqWjXNul0yR+c6J7Uwi3PXXk+wUfqaUePcnvV6OM8llRaAPe0CcDdH/5DgmkN9ATMCSuh7l7VX8PMLvKTWY6M8IY8uJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eSPs90Yt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762081442;
	bh=WaPYZpNNClyyXEdpsBSEBFty1sbBBAPIxKesHhAawps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSPs90YtQuGXFlPiC9e8upThgqcEEYURHTRNxQ+kA4yWCBqsyyAXkCxz0wQZSevYo
	 IwQ65jmea0TywFVZIPEQ8ib8aMZOhLeXVLTZBouX7Qy9L/M7queycXDsNiLexK7IWW
	 OoJ83/OdPSNvWGu8HvjXs116kqxILd5jadu3ygs4=
Date: Sun, 2 Nov 2025 12:04:01 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] tools/nolibc: add the more portable inttypes.h
Message-ID: <cc94509b-a87b-410e-a601-6381c2a2e6e1@t-8ch.de>
References: <20251102104611.24454-1-w@1wt.eu>
 <20251102104611.24454-3-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102104611.24454-3-w@1wt.eu>

On 2025-11-02 11:46:09+0100, Willy Tarreau wrote:
> It's often recommended to only use inttypes.h instead of stdint.h for
> portability reasons since the former is always present when the latter
> is present, but not conversely, and the former includes the latter. Due
> to this some simple programs fail to build when including inttypes.h.
> Let's add one that simply includes stdint.h to better support these
> programs.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  tools/include/nolibc/Makefile   | 1 +
>  tools/include/nolibc/inttypes.h | 8 ++++++++
>  2 files changed, 9 insertions(+)
>  create mode 100644 tools/include/nolibc/inttypes.h

I think this should also interact with the big nolibc.h.
Both being included from it and including it itself, to follow the
generally used pattern.


Thomas

