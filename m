Return-Path: <linux-kernel+bounces-885558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7BAC33523
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F36B426938
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB22D248B;
	Tue,  4 Nov 2025 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mPWqKod2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430AC257423
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297579; cv=none; b=KcgmY3fNdZDnVH80wRAyCFGY1XSI+EY/Tl4pUPuW6Qe6zQc740HgSodgfHWBt8j6F676XqJWFCSVXgBV7SO5PK1ppg6P29nmrxL8IG3dHuJghFfst3Zc6Q/APtxSH91a0jZNBOrkVFOMUSQGSytBpUfwRWeq6yGYszymhAG7wJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297579; c=relaxed/simple;
	bh=uLlzqy6Di4edIrRuTOYeMvLFCeJz31ipYGrsi9YXoJY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZVY9nbjkR8Jjvw+aMa0lrXZLxt9nHptJtMiShPZy6vVHwQ6pubNwNZkS6V6dzSGTcDkivo2e8Ed/vfVz/vWmJkUoSky6MFe6G9ZclgelUHmUlwCLWHI3nizUv9TDZgp5mGZUjyjci48r5D1aSeQlTvDQ5SqG4h/L8IdEpI0CJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mPWqKod2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C045AC4CEF8;
	Tue,  4 Nov 2025 23:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762297579;
	bh=uLlzqy6Di4edIrRuTOYeMvLFCeJz31ipYGrsi9YXoJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mPWqKod2jrlekRtHGXeG3Gnh3TUStcLighZEWMMedLEFdPOG/FqegW5btR7SSCpLJ
	 /nm9vrhmvWxDG/1ipojDnSGoO+sF8EbJgNMwY7sfTWkh9gyjHk/1WMMyf3TXBlxIZV
	 Gloznr7TPUNHasBbkm+Ns/scx6H3uukXsWKlRGg0=
Date: Tue, 4 Nov 2025 15:06:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH v3 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
Message-Id: <20251104150618.0606afefb2a9e226aaa6ce77@linux-foundation.org>
In-Reply-To: <cover.1762245157.git.zhuhui@kylinos.cn>
References: <cover.1762245157.git.zhuhui@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Nov 2025 16:37:41 +0800 Hui Zhu <hui.zhu@linux.dev> wrote:

> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> The hugetlb.c file has grown significantly and become difficult to
> maintain. This patch series extracts the sysfs and sysctl interface
> code into separate dedicated files to improve code organization.
> 
> The refactoring includes:
> - Patch 1: Extract sysfs interface into mm/hugetlb_sysfs.c
> - Patch 2: Extract sysctl interface into mm/hugetlb_sysctl.c
> 
> No functional changes are introduced in this series. The code is moved
> as-is, with only minor formatting adjustments for code style
> consistency. This should make future maintenance and enhancements to
> the hugetlb subsystem easier.
> 
> Testing: The patch series has been compile-tested and maintains the
> same functionality as the original code.

Thanks.

>  MAINTAINERS           |   2 +
>  mm/Makefile           |   2 +-
>  mm/hugetlb.c          | 852 +-----------------------------------------
>  mm/hugetlb_internal.h | 113 ++++++
>  mm/hugetlb_sysctl.c   | 133 +++++++
>  mm/hugetlb_sysfs.c    | 629 +++++++++++++++++++++++++++++++
>  6 files changed, 887 insertions(+), 844 deletions(-)
>  create mode 100644 mm/hugetlb_internal.h
>  create mode 100644 mm/hugetlb_sysctl.c
>  create mode 100644 mm/hugetlb_sysfs.c

Seems a reasonable thing to do, although those who work on this code
should have the final call.

This amount of code motion might cause some (easily resolved) merge
issues during the rest of the -rc window - we'll see how it goes.


