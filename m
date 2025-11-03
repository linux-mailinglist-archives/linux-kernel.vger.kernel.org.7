Return-Path: <linux-kernel+bounces-883775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110DBC2E63D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9DA188812A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0D2FDC4B;
	Mon,  3 Nov 2025 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="mrCBe199"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090719DF6A;
	Mon,  3 Nov 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211995; cv=none; b=n0fnvF03BOLxLKYX3my9o75m1gCPB3k89yaSXlsO/qPaNLrqbhKS24VIxULhfjK48MaNv4qRBYNm5JaFZ0ShZPpgOg2xBPAGZpkSaf/rLuZr2XRKraEo5GYEf15vYYQhajIqwHNC7HiY96mF7WW+uN9Fydc06xZQwcfnmQNvufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211995; c=relaxed/simple;
	bh=jQ4BS96WpnCqZ8yMQu9OiWZG4tSyc3T6/W3hS4aV8ys=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pa68KIXsSI8fHck9vJtAVZ9WKhBWdDUoaVKJAGKH1ryATtxhI4XwTr/jfYb7W7+blWzoQGzW4i2fk9nTiyawv86ROFAcZiVHbEI5hUTKBQXkiR7cg2V7YDKZik4RkjpvhO7Na0yI7NR0r3Y50pZP4gJuvG1tKu2011XOG63N1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=mrCBe199; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 28B9440AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762211993; bh=BGwsk1zAMqN7vjrmOd5deVThA6svDd8H5pqB119acV4=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=mrCBe199pKBJFyiENmaiB807Erbcp8EWgXA3qeMMUgP5r9moHrfUMoQ5B3ixqP1o5
	 9q1SfMqX/K+WlFEkP6ynotPScNdXcWX8EpROKtWSdQBlsInCx+GNyBrx9GQvRZFWRf
	 hIduYW4rssf0FGGSxZtGzGXjjW+g3PQueOchkhxBU9OgtLJLwVDF1UHs6bMgH1QgGz
	 eILBl8PQZk8LCFrzY3yyWXDnJa/hworeQmgK42LhcO3hutM6/CbOGJM3liBRwbMxhk
	 oCW+qe0HYSortKVDvcPvCT4DVQ6bvpuBJ0HIZNxhAs0wUkMoKEVgZOnBfT79qSXh/b
	 /ILnauHxEFQuA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 28B9440AED;
	Mon,  3 Nov 2025 23:19:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Alex Shi <seakeel@gmail.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Yanteng Si <si.yanteng@linux.dev>, LKML
 <linux-kernel@vger.kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [GIT PULL] Chinese-docs changs for v6.18
In-Reply-To: <CAJy-Am=qL9xYM-q+ciYfhj2ez-8Go8W19mNxXwOxZT=4=wT_4g@mail.gmail.com>
References: <CAJy-Am=qL9xYM-q+ciYfhj2ez-8Go8W19mNxXwOxZT=4=wT_4g@mail.gmail.com>
Date: Mon, 03 Nov 2025 16:19:52 -0700
Message-ID: <87seeubt5z.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alex Shi <seakeel@gmail.com> writes:

> The following changes since commit f44a29784f685804d9970cfb0d3439c9e30981d7:
>
>   Documentation: update maintainer-pgp-guide for latest best practices
> (2025-09-09 13:43:55 -0600)
>
> are available in the Git repository at:
>
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/alexs/linux.git
> tags/Chinese-docs-6.18
>
> for you to fetch changes up to 6fc05a144c12305a54f1707edc407d4137fef742:
>
>   Revert "Docs/zh_CN: Translate skbuff.rst to Simplified Chinese"
> (2025-10-31 14:01:35 +0800)
>
> ----------------------------------------------------------------
> Chinese translation docs for 6.18
>
> This is the Chinese translation subtree for 6.18. It includes
> the following changes:
>         - docs/zh_CN: Add rust Chinese translations
>         - docs/zh_CN: Add scsi Chinese translations
>         - docs/zh_CN: Add gfs2 Chinese translations
>         - Add some other Chinese translations and fixes
>
> Above patches are tested by 'make htmldocs'
>
> Signed-off-by: Alex Shi <alexs@kernel.org>

OK, looks like we're good this time ... pulled, thanks.

jon

