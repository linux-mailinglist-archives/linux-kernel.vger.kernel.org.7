Return-Path: <linux-kernel+bounces-787607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6A2B37887
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E373649DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799B307ADC;
	Wed, 27 Aug 2025 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CAyCF73v"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600A1D9346;
	Wed, 27 Aug 2025 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756264742; cv=none; b=kTw3LOg7uMkbDn1r1S2bvWz+qsGYdDXmOpUTD9J0yIFwQw05KUwDaUdnEQVWNslhgiGYW4nfIDJ2VXpkfAl0WklVzqcwccJdQq5CSCas8OgmI0/VkyCzZ9cEzn4q5qFkAEmiQV9pJd4CJiiH+jfcKakvjMwUG4H8stziSW01e60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756264742; c=relaxed/simple;
	bh=WUWwy5nccQxrS8HQfczhlbKuioAv23XjXIVasA3CJQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1+71Qt8ncQoeJIoNiCYdy63ydFpjE7ZvF3YeKwdKmUlmkp6/XzUtZiSBN64LljzjDNLSOkIODjsrx0pJmaott0kGIAkGaTG4nDqYKBOb9jzkBNuWibvETMRBm7NXHIb5t1dWoLHlkTZz3zDG+qRdb5Ag2Jsg/IOtEGvfHczenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CAyCF73v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=A+VnN3ce19ePBWAKL69GvyEbLz34iHfiJ7S4nl+bquc=; b=CAyCF73vjin/UU8OsCA3Ysf206
	48hv7838JxCqoFmQuyqmmkSHuIxoQj2ehVeg/TDFlUZKyLXouyYX9zCcL+kfYJGGHfE/GQpPXQzMW
	gqjw2wz4OexYYa8engqNDwwpqabINISV2wvYXpcN7mLcjTOxBWpFiykL4k+gt4nEt0j77WbGnKCz3
	s9ZktHD8g1481fGBhWLkQ2uvo6iMRV9m6OwPZMmjyW4OQ+Fk9Q2ScLgn/cJNJDbfR9qw7QMoNAsID
	+xnBktlOpl/zQMgv4/Hi0O5Yq8AzC62sbUwxJ4N6AMXKmJke+GkfiUgubsBsSin//5QspdpBJBKuM
	OIVfJQuQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur6gc-0000000DowB-0HmH;
	Wed, 27 Aug 2025 03:18:58 +0000
Message-ID: <8696a6c8-c555-4523-b8dc-b41ab14b4380@infradead.org>
Date: Tue, 26 Aug 2025 20:18:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux GFS2 <gfs2@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>,
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>,
 Bernd Schubert <bschubert@ddn.com>, Matthew Wilcox <willy@infradead.org>
References: <20250827022122.12132-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250827022122.12132-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 7:21 PM, Bagas Sanjaya wrote:
> Documentation for GFS2 is scattered in three docs that are in
> Documentation/filesystems/ directory. As these docs are standing out as
> a group, move them into separate gfs2/ subdirectory.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v1 [1]:
> 
>    * Strip gfs2- prefix (Matthew)
> 
>  [1]: https://lore.kernel.org/linux-doc/20250826023913.14888-1-bagasdotme@gmail.com/
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
> 
> diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2/glocks.rst
> similarity index 100%
> rename from Documentation/filesystems/gfs2-glocks.rst
> rename to Documentation/filesystems/gfs2/glocks.rst
> diff --git a/Documentation/filesystems/gfs2/index.rst b/Documentation/filesystems/gfs2/index.rst
> new file mode 100644
> index 00000000000000..9d9ca84d45a7ae
> --- /dev/null
> +++ b/Documentation/filesystems/gfs2/index.rst
> @@ -0,0 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +Global File System 2
> +====================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   overview
> +   glocks
> +   uevents
> diff --git a/Documentation/filesystems/gfs2.rst b/Documentation/filesystems/gfs2/overview.rst
> similarity index 96%
> rename from Documentation/filesystems/gfs2.rst
> rename to Documentation/filesystems/gfs2/overview.rst
> index 1bc48a13430c1c..f971353d23611c 100644
> --- a/Documentation/filesystems/gfs2.rst
> +++ b/Documentation/filesystems/gfs2/overview.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -====================
> -Global File System 2
> -====================
> +=============
> +GFS2 Overview
> +=============
>  
>  GFS2 is a cluster file system. It allows a cluster of computers to
>  simultaneously use a block device that is shared between them (with FC,
> diff --git a/Documentation/filesystems/gfs2-uevents.rst b/Documentation/filesystems/gfs2/uevents.rst
> similarity index 100%
> rename from Documentation/filesystems/gfs2-uevents.rst
> rename to Documentation/filesystems/gfs2/uevents.rst
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 11a599387266a4..897eabaa30d65d 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -90,9 +90,7 @@ Documentation for filesystem implementations.
>     ext3
>     ext4/index
>     f2fs
> -   gfs2
> -   gfs2-uevents
> -   gfs2-glocks
> +   gfs2/index
>     hfs
>     hfsplus
>     hpfs
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dafc1171254406..c685140f78c4e9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10335,7 +10335,7 @@ L:	gfs2@lists.linux.dev
>  S:	Supported
>  B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=gfs2
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
> -F:	Documentation/filesystems/gfs2*
> +F:	Documentation/filesystems/gfs2/*

I think this should be:

F:	Documentation/filesystems/gfs2/

without the trailing '*'.

See the explanation for F: near the top of the MAINTAINERS file.

>  F:	fs/gfs2/
>  F:	include/uapi/linux/gfs2_ondisk.h
>  
> 
> base-commit: ee9a6691935490dc39605882b41b9452844d5e4e


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

-- 
~Randy

