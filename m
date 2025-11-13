Return-Path: <linux-kernel+bounces-899795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A63C5935C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CA445084E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C3F35A15E;
	Thu, 13 Nov 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hun49MKa"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C133BBCD;
	Thu, 13 Nov 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050895; cv=none; b=kpnwh794dSnkcfRWjbkRCTqk9J/cA3yylf+ix1rxgQ4n8NoJNHVbY9+ub42waSc6VkeaKoJAgBar7GmBnfCSo6d7m+XaHEPBUNjxJcJ2diW4GaAqgC3ywSZjD5EUvAyXkqW+tMHixsowfWdbbk1BT8daSSHmaklwf9VNGh1vDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050895; c=relaxed/simple;
	bh=7uhu/pLWd+F97Z+w3BbjWPzQIaaOEZSzkyPvqd5zIAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhhSJIeWy1WHXqrw0wjovCQk9WY7+WFfTN5GjCcR/3FwYn7JwABHiCofXMOCn/ZudnKIFvG4fsxsgj1aj9Kr70Pkqi2IMn2N0IeX6UV53UaxTb/uD9+5ik3gkDwCMbkDpUpSW613t525h5/J/TxJGnnHY0vrhACcBxw8mEbSp78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hun49MKa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EE02F40AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1763050887; bh=SlAQDJAOXlrWJhedTGfN6JTiehPZlu/xl6BqOj8VYps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hun49MKahbD7cwqTDRRcO6EtQS15AXctzaXUiT1lik+ahspqIhkgKy8NwggRIpU3j
	 IM/xOf6hUe4GgdM6EG8gj58TKqc8Bbi4bpgYNmfyXqBzFj9DO5/tKmQvDvOKKND2if
	 mGkN6jrFyYZ7L6G+SY29uJ05tzk7N6rGRv3kn12gWRP1QGeVZnl5eQSlbJhinxBLae
	 +5fZzg2dIC1GbRPT3fn1+hpkWivqZm6wZYIGtb6s8/+V9f48MaZ9bSUplR3Djcoztr
	 prhwtM8uiERzq3I6SveA5UUJ80JFIIt6Qw1r28o2LV32kS53osl3lmkcFIGc/PSQPS
	 tVZvQS400lbAA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EE02F40AFB;
	Thu, 13 Nov 2025 16:21:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] scripts: docs: kdoc_files.py: don't consider symlinks
 as directories
In-Reply-To: <73c3450f34e2a4b42ef2ef279d7487c47d22e3bd.1763027622.git.mchehab+huawei@kernel.org>
References: <73c3450f34e2a4b42ef2ef279d7487c47d22e3bd.1763027622.git.mchehab+huawei@kernel.org>
Date: Thu, 13 Nov 2025 09:21:26 -0700
Message-ID: <878qg9ucmx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As reported by Randy, currently kdoc_files can go into endless
> looks when symlinks are used:
>
> 	$ ln -s . Documentation/peci/foo
> 	$ ./scripts/kernel-doc Documentation/peci/
> 	...
> 	  File "/new_devel/docs/scripts/lib/kdoc/kdoc_files.py", line 52, in _parse_dir
> 	    if entry.is_dir():
> 	       ~~~~~~~~~~~~^^
> 	OSError: [Errno 40] Too many levels of symbolic links: 'Documentation/peci/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo'
>
> Prevent that by not considering symlinks as directories.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-doc/80701524-09fd-4d68-8715-331f47c969f2@infradead.org/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This looks the same as yesterday's version?

Applied, anyway, thanks.

jon

