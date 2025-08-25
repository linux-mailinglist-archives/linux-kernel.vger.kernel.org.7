Return-Path: <linux-kernel+bounces-783880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB15B333CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355443A7DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441222B8C5;
	Mon, 25 Aug 2025 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDkVhNn8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F121FF4C;
	Mon, 25 Aug 2025 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087190; cv=none; b=FJnYVBHeSH7S+VtCA/cxnnuGJpQL/cqUiwpJWthV9oWj7Z7T7yXn8bVnQzRFCzim20aVQBG+jyou+i6YvOtHX87Iog7S/qiDOYTIm9DruSUz6IjF9jm/PTbDu4GAPIQT43D7EV1TVt82R9renqyy00VrQ7fdVOmYqUM3aKWCt/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087190; c=relaxed/simple;
	bh=K2xls5tsl3uvGfN17VTxAjlWiKi8UM9kbMKxwJEde1g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C8spG/wNBo8fFZcSc6lTyjduTneZistOr6v+t6spF1N67h8zd3QClVSqTQlghC1F4fOHqOMWmFAXHRKq0ICMU2xIGYhPF/f/EOBhtnIIjWomnE4HYz1RIh/8Oin9i49I611YqBoR4RwlPgbDWlFGqxtlKmfenaCbBnirctADvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDkVhNn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30F9C4CEEB;
	Mon, 25 Aug 2025 01:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756087189;
	bh=K2xls5tsl3uvGfN17VTxAjlWiKi8UM9kbMKxwJEde1g=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XDkVhNn8PVa/Toqm4iQdiX1h7bhMcJAr7iUxKb7W9ovg8zjGsoqesJQkaRX52PITU
	 sW0QFJqKYgnshtm94qUzNDaWIcN75DGLSezjaC/JWoiaPw0vqEPC0DEJwiNaMMBxue
	 sqyQk3bUUbKfe1uoNRLSAKXNuWZ16TXQiMUue6YWFX0XtA8ZNi1KQY23Wh/0lEIhSj
	 O9pWtQtwPcU7FSHTuKxbUJFxLDeSjFcIbRQCKt6wSpftgCwU7+uRkew4oZ2Iv6RJQC
	 LvMaqZWaonCbxQwUCa7Pw/djsrfvYVwdtYNj2RiYizvESPUs7ukJUavPMtVYOP89ao
	 8MqoJPj560U6Q==
Message-ID: <d980d51c-1075-41f2-8416-64c097d3eeec@kernel.org>
Date: Mon, 25 Aug 2025 09:59:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Daeho Jeong <daehojeong@google.com>,
 Yuanye Ma <yuanye.ma20@gmail.com>, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 0/6] f2fs: documentation formatting cleanup and
 improvements
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux F2FS <linux-f2fs-devel@lists.sourceforge.net>
References: <20250820043432.22509-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250820043432.22509-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 12:34, Bagas Sanjaya wrote:
> Hi,
> 
> Here are documentation formatting cleanup for f2fs. This also includes
> docs retitle at the end of series ([6/6]) as a bonus.
> 
> This series is based on docs-next tree.

This patchset looks good to me, thanks for your work.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Enjoy!
> 
> Bagas Sanjaya (6):
>   Documentation: f2fs: Separate errors mode subtable
>   Documentation: f2fs: Format compression level subtable
>   Documentation: f2fs: Span write hint table section rows
>   Documentation: f2fs: Wrap snippets in literal code blocks
>   Documentation: f2fs: Indent compression_mode option list
>   Documentation: f2fs: Reword title
> 
>  Documentation/filesystems/f2fs.rst | 88 +++++++++++++++++-------------
>  1 file changed, 50 insertions(+), 38 deletions(-)
> 
> 
> base-commit: 37c52167b007d9d0bb8c5ed53dd6efc4969a1356


