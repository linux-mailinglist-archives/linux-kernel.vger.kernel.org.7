Return-Path: <linux-kernel+bounces-808922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E067B50694
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DAE164B4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39B30506E;
	Tue,  9 Sep 2025 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WL43k4ig"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676EC21A449;
	Tue,  9 Sep 2025 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447340; cv=none; b=Jsq4HelwInxjKab3lGkhunv4FTnsyDVjRTLE/ZHn2dUwO8mXKExwIiskEbiyZxQmcYS5EkXPLB07KSuaF0ARjuWl4jHIWgWwitQ+FOBKp40HiMDv+w/LkzhgFZWvHAcVO0UiP0SmXv/bc7+BIgXlO4c8DVDBO9GvXn6RLz7Oeio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447340; c=relaxed/simple;
	bh=yNY8fw4InteYSdfY936nfhJAqT+/k/kI/FOINfsRh9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XWMQF1gN0Huvdk+sQt7VaPrMIZhTwJY5V90z5S9u7PtsJq72q8kRetxR9pHgpux6oI1At71vUFPxhmhjCdG1xtsTTkgm+DWAEC3OhsCn82+NsLq83V3+NIyz3zAPKazqbgXjcz2tNF4uyp1YWVGU1OLKuyPN3sMLplBJIx1sNIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WL43k4ig; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CB3F340AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757447338; bh=Yk4GVvae709BxdaTQt9abGt3/TDd6Rj6IquHgMT/iyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WL43k4igNDhSRW3kd+7mVLUSAKN6nv5TFnPzx8unABiikQ/dewnWtuXnBefvbgsNg
	 rMWcqVoudeOb1jSLdodIXoIj+cExNbYN7rVVd9ID7BAz8MLeFqgAEvi11R6Ce/uGen
	 Lz9C2FOaJ8no+be7bKrLhzBARqO/qJwf9AptM7Z/fbauNSJcCpfIjZJY5rc0fgWERG
	 ElsJaurKjMzCfDcPhSEtdqYMnzHeDurqJdHaYVbh2NybpqJK3AW5j2MuN+eLWfhUk8
	 B/5jUpurfhaC6RVE/YZeRK0WuFiFfEyXRseE8EJxNcgz+ZoNGq7ZJUP0xjX5G6iqQj
	 HIN/3sctKRB/Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CB3F340AF9;
	Tue,  9 Sep 2025 19:48:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux GFS2 <gfs2@lists.linux.dev>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Bagas
 Sanjaya <bagasdotme@gmail.com>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Jan Kara <jack@suse.cz>, Bernd Schubert
 <bschubert@ddn.com>, Jeff Layton <jlayton@kernel.org>, James Morse
 <james.morse@arm.com>, Chen Linxuan <chenlinxuan@uniontech.com>, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
In-Reply-To: <20250909014606.15043-1-bagasdotme@gmail.com>
References: <20250909014606.15043-1-bagasdotme@gmail.com>
Date: Tue, 09 Sep 2025 13:48:56 -0600
Message-ID: <874itbv23b.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Documentation for GFS2 is scattered in three docs that are in
> Documentation/filesystems/ directory. As these docs are standing out as
> a group, move them into separate gfs2/ subdirectory.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v2 [1]:
>
>   * Do not use wildcard on MAINTAINERS file entry and add review tag (Randy)
>
> [1]: https://lore.kernel.org/linux-doc/20250827022122.12132-1-bagasdotme@gmail.com/
>
>  .../filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} |  0
>  Documentation/filesystems/gfs2/index.rst             | 12 ++++++++++++
>  .../filesystems/{gfs2.rst => gfs2/overview.rst}      |  6 +++---
>  .../{gfs2-uevents.rst => gfs2/uevents.rst}           |  0
>  Documentation/filesystems/index.rst                  |  4 +---
>  MAINTAINERS                                          |  2 +-
>  6 files changed, 17 insertions(+), 7 deletions(-)
>  rename Documentation/filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} (100%)
>  create mode 100644 Documentation/filesystems/gfs2/index.rst
>  rename Documentation/filesystems/{gfs2.rst => gfs2/overview.rst} (96%)
>  rename Documentation/filesystems/{gfs2-uevents.rst => gfs2/uevents.rst} (100%)

I'm not sure which tree this is meant to go through ...

I do have one suggestion: the changes seem good as far as I go, but I
would have made gfs2.rst into the new index.rst and avoided creating an
essentially no-content file there.

Thanks,

jon

