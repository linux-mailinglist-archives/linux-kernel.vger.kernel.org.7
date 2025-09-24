Return-Path: <linux-kernel+bounces-829931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5841B98433
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52CE94E1E36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BD122156A;
	Wed, 24 Sep 2025 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rnkriZIn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70F522F;
	Wed, 24 Sep 2025 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758690316; cv=none; b=IF1IHYCCSG/gyd8rbAC+wemtKkg0XuD6yQ2R7m8e+0QqJx3f7DnMjOaFdqL0tKRvnBCKW+bzwoMxy8v9mZyTU5rXR/dT7nDIFyWybk1gzGyt9aPZd2afOc9amk2MAQ6Nc5TZ9UUosidW2Wlh7IlaaEARQTzQdAQHjMjAZ8Mdqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758690316; c=relaxed/simple;
	bh=sLmhtRQP7GQDhCWl7UZ6oi03sg5FgjiKwA6kol8YD7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1MWLghvZ1XmBj9Vs+ETSdikCOOSarYONokYHkDEQK6DTWEGItIcL5gRGXWZgzQnP1ix1ktUhGl2V5eQLBER1G2sP2/TyrEXHcVm9RoTpxdB9CI3hvInXYPcyOrCYJO+e7JpwyAJTOh/qMxygMX6x+EW8EJXiJgJ0EcelkryqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rnkriZIn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=urtHR0z1VzQlpKReQ1o/C+ijhSas54nWI+6GsBrYqFI=; b=rnkriZIn+Ras1aPuOvTzZYKsBN
	vcBukWawVPPq6CSWVED5o56MVfKkMi/XW9rrxvzq7irLKtX2AzEBE12JKIiEhOVxJmUiFJaJjy5uv
	kGTnVYUsvVJGhqbyYIBoweRx0flsDHIlAst9/nqIZnlw9lQJEeslkcbz6Y2G0HjBoUjKHFwgBL1jK
	MGvwvnFG+Zl7y49wTfGHPQGwP+aM1lNjUQJZIXQFUFRRyhxTfRsqgy83UKIKhfm1sotPzTkRdkcLN
	fncQcKwmBMp4IFw2rPx36xRdBvaP3Gmz76LRI28UYcjeLrDgPzdvLcjtAct2KqO/86tzFdGGcVfvV
	3TZ1Owcw==;
Received: from [50.53.25.54] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Hgo-0000000FXuv-2XtN;
	Wed, 24 Sep 2025 05:05:14 +0000
Message-ID: <4d5757ff-5d63-4bb2-84e9-fb5618a696b3@infradead.org>
Date: Tue, 23 Sep 2025 22:05:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tools/docs: sphinx-build-wrapper: fix compat with
 recent Tumbleweed
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <cover.1758539031.git.mchehab+huawei@kernel.org>
 <8917f862e0b8484c68408c274129c9f37a7aefb4.1758539031.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8917f862e0b8484c68408c274129c9f37a7aefb4.1758539031.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mauro,


On 9/22/25 4:27 AM, Mauro Carvalho Chehab wrote:
> On recent versions of openSUSE Tumbleweed, sphinx-buildis is no longer
> a Python script, but something else. Such change is due to how
> it now handles alternatives:
> 
>      https://en.opensuse.org/openSUSE:Migrating_to_libalternatives_with_alts
> 
> The most common approach that distros use for alternatives is via
> symlinks:
> 
>      lrwxrwxrwx 1 root root 22 out 31  2024 /usr/bin/java -> /etc/alternatives/java
>      lrwxrwxrwx 1 root root 37 mar  5  2025 /etc/alternatives/java -> /usr/lib/jvm/java-21-openjdk/bin/java
> 
> With such approach, one can sun the script with either:
> 
>      <sphinx>
>      python3 <script>
> 
> However, openSUSE's implementation uses an ELF binary (/usr/bin/alts),
> which breaks the latter format.
> 
> It is needed to allow users to specify the Python version to be
> used while building docs, as some distros like Leap 15.x are
> shipped with:
> 
> - older, unsupported python3/python3-sphinx packages;
> - more modern python3xx/python3xx-sphinx packages that work
>    properly.
> 
> On such distros, building docs require running make with:
> 
>      make PYTHON3=python3.11 htmldocs
> 
> Heh, even on more moderen distros where python3-sphinx
> is supported, one may still want to use a newer package,
> for instance, due to performance issues, as:
> 
>      - with Python < 3.11, kernel-doc is 3 times slower;
>      - while building htmldocs with Python 3.13/Sphinx 8.x
>        takes about 3 minutes on a modern machine, using
>        Sphinx < 8.0 can take up to 16 minutes to build docs
>        (7.x are the worse ones and require lots of RAM).
> 
> So, even with not too old distros, one still may want to use
> for instance PYTHON3=python3.11.
> 
> To acommodate using PYTHON3 without breaking on Tumbleweed,
> add a workaround that will only use:
> 
>      $(PYTHON3) sphinx-build
> 
> if PYTHON3 env var is not default.
> 
> While here, drop the special check for venv, as, with venv,
> we can just call sphinx-build directly without any extra
> checks.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/all/883df949-0281-4a39-8745-bcdcce3a5594@infradead.org/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   tools/docs/sphinx-build-wrapper | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)

Works for me. Thanks.

Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy


