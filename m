Return-Path: <linux-kernel+bounces-845808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE7BC624C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1732B4E2CB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E342BE625;
	Wed,  8 Oct 2025 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6ouxzpy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2420E030
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944487; cv=none; b=tjpMUP0U/I29AMEK5FyGYtGKf1vLe7XP1GOYUrZwn0coPOq2h8XMkIsOgFSZatUZMhCaLAq1pyQtKC7/woQf8B4ouaq9t7ZEyOfrY4shWsvDYZB0l89EDfFt/SkyH1ngv4u7dmh3vCMeMtBZym1SEJ2/IL+Z5SJcnoDZTBh6S9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944487; c=relaxed/simple;
	bh=jwdCdiB3JXrP+/r0f6H5LB358mwYJ7mIQcuQdBsmhaQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qsFOY/Lj3qG12n1FtXJ0yZPX3vmLS9+8WFanDXI9J+3pO7LivR7sowbYUVwdjOSnZ2sCKfKiLZFbVz+ZGqo6BlD1LOnJzSmodjig5m5+O8nJ/6WGu/REOrBe16UU3hd30grnWR0gXD6i7v9gSrSOaHLWa5dpFQxlo/lRxxvRYtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6ouxzpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171BAC4CEE7;
	Wed,  8 Oct 2025 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759944486;
	bh=jwdCdiB3JXrP+/r0f6H5LB358mwYJ7mIQcuQdBsmhaQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=N6ouxzpyEzXdYDVx2I5BS9P4P/w2S9R8pIxo8m1MoPcjHjdt0Fy6kALENLDqTY+5P
	 1IyQfiOSZl/f5w5TlxdnYXCyoDzQ5A1exTCnKh3ifsZ2nHx3bTYy8XcrLFflp2cDjc
	 w/QDw236Mi9qw5npJ/H3Zy7p3Ii9185gBherfQrtCGmk9Ovh3SA44X0+UkahBSciBM
	 otcmDn1kH9cjTLuR1SLYqBcmZ/uRepf79/9QMeRRW9AYfyXXXdxUupU5wGrso99kAv
	 hMISjmoy4k9JvR/koxSkc4oILcPrmJP6UYEFQJSSZ06TmR2HOq4c3vlObC7E+k+S7a
	 snVO0asEehymw==
Date: Wed, 8 Oct 2025 11:28:02 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: =?ISO-8859-15?Q?Miquel_Sabat=E9_Sol=E0?= <mikisabate@gmail.com>
cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, wangyuli@uniontech.com
Subject: Re: [PATCH] riscv: kgdb: Ensure that BUFMAX > NUMREGBYTES
In-Reply-To: <68da3e6d.050a0220.c13dc.0f9a@mx.google.com>
Message-ID: <2f6dd420-2bfd-794d-182c-74934577272d@kernel.org>
References: <20250915143252.154955-1-mikisabate@gmail.com> <68da3e6d.050a0220.c13dc.0f9a@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-95744204-1759944486=:929355"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-95744204-1759944486=:929355
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 29 Sep 2025, Miquel Sabaté Solà wrote:

> Miquel Sabaté Solà @ 2025-09-15 16:32 +02:
> 
> > The current value of BUFMAX is similar as in other architectures, but as
> > per documentation on KGDB (see
> > 'Documentation/process/debugging/kgdb.rst'), BUFMAX has to be larger
> > than NUMREGBYTES.
> >
> > Some NUMREGBYTES architectures (e.g. powerpc or hexagon) actually define
> > BUFMAX in relation to NUMREGBYTES, and thus this condition is always
> > guaranteed. Since 2048 is a value that is generally accepted on all
> > architectures, and that is larger than the current value of NUMREGBYTES,
> > we can keep this value in arch/riscv, but we can at least add an
> > 'static_assert' as an extra measure just in case NUMREGBYTES changes in
> > the future for some unforseen reason.
> >
> > Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>

[ ... ]

> Gentle ping :)

Thanks, queued for early v6.18-rc.


- Paul 
--8323329-95744204-1759944486=:929355--

