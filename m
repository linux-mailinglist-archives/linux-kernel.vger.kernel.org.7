Return-Path: <linux-kernel+bounces-883946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD4C2EE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 02:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403101893984
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 01:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9662356C7;
	Tue,  4 Nov 2025 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b="Z8/gLooX"
Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DE1E1E1E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221083; cv=none; b=LGXxoijGa+oJ+cFWdHbKhETBzVY6WHUUUrvxxTCy94Xt+YTnkh/lR3XlOAr8LYELPPhQ0cxpuLHkpjDW+k6aFAZUoWtXy85TFsiOMkwE9eNNu1bWdvgwBhxoxy+hMupk2i9ytfzau243hthQyUnzVGpyzttOuBwq8MsuVazrauk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221083; c=relaxed/simple;
	bh=/8xAdxlBcogZXXx8ThXWlUK/WVp0noGZQ7cMVZBio1s=;
	h=Date:From:Mime-Version:Content-Type:To:Cc:Subject:Message-Id; b=KC5N9RzkJOxj4GrTI1sVVSCAvbYsaw8Fp0AtEiNYkADeyNUW2+W240gJ2IHEtksLWlUdhexjRrWvUPFQwfg9W982jVDSfsbtxudFA/0yji+CzA0oMLG/B+5+BGxkIm90Cey80exQfCIZGMPZfv+zYu1WdJ96ohggiQsIXPvDP4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club; spf=pass smtp.mailfrom=openatom.club; dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b=Z8/gLooX; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openatom.club
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1762221066;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MeVylSFPK4ZB0TSQFof8l5v0htYYA51u3t6gmx5/nUc=;
 b=Z8/gLooX89VPVTa6P//iasLsyf3vn/y83WxsntCfhdkdIbL1D/miZjJLL84RbUEkw0yWSw
 hZFUJYhIYsbDZ1y4EvvF3ifODOpv35G0pOY0yzk9pdphAWJAuQETVR0we9pOc1sWbdQ9dq
 5pJrB/jNXvj04TwMfIAhjOmLSyp/FzeH9m69cXMeoV8ZuWRQAOOzWLPOWwZkTd9464CjlB
 y3mH856S35U2mh+t/yCmXkrbCV6Mgas78JvuNkHhdajo08p0TLXmdjxMXuUMYD1UvgBQWv
 5JmmKyH8G5naRmlkMo13rmiYIiwv7B1NCVQz5GV5sIRKgaVxf/rVDuFB5JsupQ==
Date: Tue, 4 Nov 2025 09:51:02 +0800
X-Original-From: Chen Miao <chenmiao@openatom.club>
Content-Transfer-Encoding: 7bit
From: "Chen Miao" <chenmiao@openatom.club>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.5] ([114.249.49.233]) by smtp.feishu.cn with ESMTPS; Tue, 04 Nov 2025 09:51:03 +0800
Content-Type: text/plain; charset=UTF-8
To: <miguel.ojeda.sandonis@gmail.com>, <tamird@gmail.com>, 
	<da.gomez@samsung.com>
Cc: <hust-os-kernel-patches@googlegroups.com>, 
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] Makefile: Remove the product of pin_init cleanly in mrporper
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+269095c08+cb6d43+vger.kernel.org+chenmiao@openatom.club>
Message-Id: <d438be26-9156-4604-b96c-34e11118be0c@openatom.club>

PING.

On 10/31/2025 10:32 AM, chenmiao wrote:
> When I enabled Rust compilation, I wanted to clean up its output, so I
> used make clean and make mrproper. However, I was still able to find that
> libpin_init_internal.so in the rust directory was not deleted, while
> all other corresponding outputs were cleared.
>
> Dongliang Mu <dzm91@hust.edu.cn>
> Signed-off-by: chenmiao <chenmiao@openatom.club>
> ---
> Changes in V2:
> 	- Add the `.dylib` to mrproper files.
> ---
>   Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index b34a1f4c03967..b38b2895e1e4a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1590,7 +1590,8 @@ MRPROPER_FILES += include/config include/generated          \
>   		  certs/x509.genkey \
>   		  vmlinux-gdb.py \
>   		  rpmbuild \
> -		  rust/libmacros.so rust/libmacros.dylib
> +		  rust/libmacros.so rust/libmacros.dylib \
> +		  rust/libpin_init_internal.so rust/libpin_init_internal.dylib
>   
>   # clean - Delete most, but leave enough to build external modules
>   #

