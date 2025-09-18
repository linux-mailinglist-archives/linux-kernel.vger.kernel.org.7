Return-Path: <linux-kernel+bounces-823511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B64DB86B26
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B646B60AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5382D8383;
	Thu, 18 Sep 2025 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="e221ZQ3l"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C221B9E7;
	Thu, 18 Sep 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224037; cv=none; b=oeFZ9GTEVuLb+eV3PCOw2qf6XAq4+j4Wh5/GOfXy1GgBqHGT+yGOaUuRr6ohDMpNtveeuAL9sUTx/ZadUQuQdTS8Rb6uU4sAnt7jng6a7X8Sp+QLlOQatybx0GQ1iHANODpk0SEh97gBmdK3gsnstnKP8Ft9wqfsige/W6p+Z/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224037; c=relaxed/simple;
	bh=0xjo9fkK7DpmsHAXVDsYVKEngdRGenWIYBnyikRtFTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HT2tPjm4AMQYh/8dZFS6i/FGVxM7U9h/uks5RFYVvT59SsoS2tD/FyiS6BOZ1QnN9VOsHqYVKzIGrrdaKyOdUDIQxigyI10vpPRtoJ6jsVDX7oySnfjuTLuYUlqe9msqhlHe5FQ0bkv4YofLyrXxPAVzRvNyHW8iTFp3MbUhGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=e221ZQ3l; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B5841406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758224034; bh=tRDeUu42jMKESLNYB4KBds+rjvAyh449yxaAl0t+RjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=e221ZQ3lzNRUqH+3QWOtnp2URBiMHuqI0vXtEtk2Rmz63ZjDOLwcb0G94JeePj9i9
	 ytqM8fMEN2pWbBjqDJU2QoQewyKrrlTQHgJOL6rBZnoC/immpcO8WHkWAWxSgCNa8A
	 juQ9+vP7l65Jic99kYEPiXRItn786FXJhoIJqHJmTNLn93hjsjAZJvbl9iBAIaZDUS
	 UnDLiLASE8zIUJZAjc543TEPuXn1PdcsqRvJh+Pklf4ugRriBn4pTEBbA/UKsjJh0q
	 zyv2r77pMOiws+jEjAvPZYWd0uPk3Zc0CzmifxzTJ0G9ff0N6SLUom54fIvhmpfC2W
	 R/2KtX2DfdhKQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B5841406FA;
	Thu, 18 Sep 2025 19:33:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v8 00/24] Split sphinx call logic from docs Makefile
In-Reply-To: <20250918212304.0efa2847@foz.lan>
References: <cover.1758196090.git.mchehab+huawei@kernel.org>
 <87ldmb7iuo.fsf@trenco.lwn.net> <20250918212304.0efa2847@foz.lan>
Date: Thu, 18 Sep 2025 13:33:53 -0600
Message-ID: <878qib7dy6.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

>> I haven't
>> had the time to figure it out.
>
> I don't remember anymore what "subproject" really means inside
> ".. only::", block, but I guess it is meant to be used when one
> passes SPHINXDIRS.

I found myself in a similar position...  it is set in
Documentation/sphinx/load_config.py, it seems a certain Mauro added that
in 2019 :)  Since then, it has seemingly been cargo-culted all over the
place; I wonder if we really need it.

jo

