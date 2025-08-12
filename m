Return-Path: <linux-kernel+bounces-765666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5A7B23C43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A27C37B8EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750252DCBFE;
	Tue, 12 Aug 2025 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YbtkuwuG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69E2D73BB;
	Tue, 12 Aug 2025 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755040960; cv=none; b=LDdLFgZmPJadBzfOZDlIikOopXlLV3pYMvhzZBYEgvbtBfso/v1Y6RJ5zPIuF7vNmr/4Ao0kDVDh8L6+lSgRY7uOjgQRNKvZcdQC3nh0GreAqaAXXwDMHjhoC2Eonrv6cRz/44x/HfbyRtpbP1mQXNqkbTRxaYUoRxIkTqdd6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755040960; c=relaxed/simple;
	bh=VZCeSKCgvFZTc9SceevbALssOXtfdK1uOxwL6xKmg0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BLYtFCyL6ZbPiddnkF0632llZgJyr0UoCNt1PhudzjjqO3mEtO68ikNnCpC1HlCoesIVNls9kpTyPpylFkCUOJDZhqByV7Pjp1JRso3mS3y8v++5Zqy/vZ7ORwW3HxSPJTsQ714yJU8gbP9yC3Zk6W8M2dgpDqGY4tnv4v/xxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YbtkuwuG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1FCD240AD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755040956; bh=jXs483sSKu9onFLo1zR6NzTI/OyK8T/T9lspwcBMlTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YbtkuwuGyqpnmgKEExkkEIcHrhosb2HqezEPfGQUdro8T54q8gn7oUAmnem0YOUXW
	 zTNeg8XNLC+FngL80n8Fnq+N9r3k3uuo74naoWuJ7/5d30GZb9avSK6yMJXZJZAb8V
	 B936rgVgexHFoaHRruK9H/dX3OdYRwoA+ZJ/+osmBNX5LEggEfaqw4BF2Lq1AzNGX+
	 5qMurC8yjd4TXD1YtxHf+lxjK1UV79FXy07S8oYUOTV0UHjjhfcwMnviGTKUCntu1t
	 0jDplMdgq7icvSLe1eExEjdVoqq6LzqaN9uuRf447hNda9vB7dYeGhnhN7QmtaoU00
	 y/cN/O2t7k9yA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1FCD240AD3;
	Tue, 12 Aug 2025 23:22:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 6/7] docs: kdoc: tighten up the pointer-to-function case
In-Reply-To: <20250813003902.2fc82b54@foz.lan>
References: <20250812195748.124402-1-corbet@lwn.net>
 <20250812195748.124402-7-corbet@lwn.net> <20250813003902.2fc82b54@foz.lan>
Date: Tue, 12 Aug 2025 17:22:35 -0600
Message-ID: <87a544ceh0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> On Tue, 12 Aug 2025 13:57:47 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
>
>> -                r = KernRe(r'[^\(]+\(\*?\s*([\w\[\].]*)\s*\)')
>> +                r = KernRe(r'[^\(]+\(\*?\s*' r'([\w\[\].]*)' r'\s*\)')
>
> Heh, it took me a couple of seconds to understand this concat, as I haven't
> seem concat pattern like that before (maybe except for some old C book
> I read a millennium ago that I barely remember).  So, IMO, it became harder
> to understand this way. I would either remove the extra two ' r' from the
> string or write it as:
>
>                r = KernRe(r'[^\(]+\(\*?\s*' 
> 			  r'([\w\[\].]*)'
> 			  r'\s*\)')

By remove the " r" you mean glom the pieces back together into a single
string?  These long regexes are hard to make sense of, I do think it
helps to break them into logical chunks.

Certainly I can split it across multiple lines if that helps.

Thanks,

jon

