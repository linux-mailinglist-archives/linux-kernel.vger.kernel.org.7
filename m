Return-Path: <linux-kernel+bounces-727634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23DB01D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8A61CA5981
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6012D3EC6;
	Fri, 11 Jul 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NpyoOwXt"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867A225409;
	Fri, 11 Jul 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240314; cv=none; b=t6M8UAnaItxyJL4D+PbmhMwM3GwePMrzbZ2LHJWjj5Ic/jbJjPEFmx1K5bDx9rfwdalwuhE2r9soAVTXb2SYtHG0xRb8jVbPja7uA6fAJMXT5rCREGmdIqhpr+wSYoPoS1bv0mA9lt/7243OxUGkG8it8T5F6ausvuiHzCTVlxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240314; c=relaxed/simple;
	bh=c/mG9SSDZguggaVasIycj0BIPKUFyr2RkpfM5U+bhTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QLJaYHDyQhCxbHqwuHNB3tYIzTiHwXP2YRNIj9XLN+Rmvf4XXDzU+qAj6N91Q8vgoplT3qX4uJr9vVl3TW5fD8urddhFdCsE9QnBU/QXxgukKT9IFIzfXNGGYKfyKm1DZzYn/YeH4zmtJckXUUnsU2iJ8mnK7uCack6yuzavB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NpyoOwXt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4B4C640AAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752240312; bh=bcH52IwI/64NCRPvhe5rtnCycJpgH2HmWtKETDxiAH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NpyoOwXtpfTzD9Bo0SeeP+5mfTXd//+h2y7ggE4Yz1Z5E/SZiyNJ822bdw3Rt/r2j
	 A3FLmTRta+79M0xmoR4jqdoxvOjibVHvXbY2yIM8SXWdqH3Y+2LfNbDcu8vSyQGIEF
	 Wn5ekz4Kz4poJzAJHzMK/icc0dQMaZAhHFj6Gq+3//H98qF4m94Bmt8EkrlVcGNEB2
	 c1xxoYtIVp3U6xSwJr1KuMNnJF5jzvssmJZRHbIDCIA2NIW8XtvOBrZa/5zQ6WLoxX
	 zfAqxYh7wvKp3EnCTEQ/f7zbIqbZtbosNcKvTyGL+3G/mciDejKlEgQKvrw0d+oW2J
	 Nya9H/q2MF+Iw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4B4C640AAD;
	Fri, 11 Jul 2025 13:25:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: kernel-doc: emit warnings for ancient
 versions of Python
In-Reply-To: <7d7fa3a3aa1fafa0cc9ea29c889de4c7d377dca6.1752218291.git.mchehab+huawei@kernel.org>
References: <cover.1752218291.git.mchehab+huawei@kernel.org>
 <7d7fa3a3aa1fafa0cc9ea29c889de4c7d377dca6.1752218291.git.mchehab+huawei@kernel.org>
Date: Fri, 11 Jul 2025 07:25:11 -0600
Message-ID: <87ikjyx3k8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Kernel-doc requires at least version 3.6 to run, as it uses f-string.
> Yet, Kernel build currently calls kernel-doc with -none on some places.
> Better not to bail out when older versions are found.
>
> Versions of Python prior to 3.7 do not guarantee to remember the insertion
> order of dicts; since kernel-doc depends on that guarantee, running with
> such older versions could result in output with reordered sections.
>
> Check Python version when called via command line.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/kernel-doc.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
> index 12ae66f40bd7..fc3d46ef519f 100755
> --- a/scripts/kernel-doc.py
> +++ b/scripts/kernel-doc.py
> @@ -271,6 +271,16 @@ def main():
>  
>      logger.addHandler(handler)
>  
> +    python_ver = sys.version_info[:2]
> +    if python_ver < (3,6):
> +        logger.warning("Python 3.6 or later is required by kernel-doc")

Does this really work on truly old Python versions?  I don't have an
easy way to try it, but I would expect things to fail with a syntax
error (due to the f-strings) at the import stage...?

Thanks,

jon

