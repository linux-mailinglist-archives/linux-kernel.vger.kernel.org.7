Return-Path: <linux-kernel+bounces-839180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B200ABB0FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C6819C23FA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6C82EA74D;
	Wed,  1 Oct 2025 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lVMs+Me3"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346A1DA0E1;
	Wed,  1 Oct 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331187; cv=none; b=gF8Sy2Vn5A+rOpfcDfDeII0w59LqLlICH8VeopaNKvJiId6Bx20cagcO8sc20JTpZl6/EJvUNT+NjtGctnU/0ztyGa33uO6dOchfMM7SFxRWUrX9rfgsyab7O0AEn13XkHVzfPyvgmxdatcUoh1i2/S1yuucPS7t0FTn91bRDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331187; c=relaxed/simple;
	bh=b6vAQ1FtAnfPnlXQpyz+vdXh0Kp0ZFtWdja1h0GhmjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aeRu12jBza8Sbi0gphv5U3UU+dVpV96Q5lvi5pD2wK2aOC9lEeQvVFK0zt1/2ADuI6GprR19spnIss4N7xO7O+oldp//aV+ykikzVX9X1BMreQ01FfcVcEkHB+YTtifN0oRPp0htJ9GR3XIwJCw4kQYGRLOTP0XOMBAg/li8+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lVMs+Me3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0FE1040B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1759331184; bh=rKkntVTZcXmHgKsb2ftAB0mpkxsuRFuIV97ltCrdJ7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lVMs+Me3ytHmJXjvBCR0q9mvHzKYlbNJ8K521TthilrmjY8lnDOmn6QH2VZgI7xYk
	 YUOU3kjE2eqrkVCVLj82Fr6EwQNZs+daXqauPKvUq9Ycu8U2nS8Y7TQfzl054uHBW/
	 MwvOEaoWWJ/wjaIhQnj25nbcjR3l9bOtnLSLa22aQNuSjpW7OxA5sykKrLEXW5rh/y
	 aDV3/fkQhvV/dIOFkVNt9OtVQkHNLeKY7s1lS+BPfNn9YJiqJYsWpUGUZIwDib362d
	 gD6SNIQIjy1ZAu2Kefgznq1bHiBKXt38ykE/f4tmQK1L/qr3oRawOmQZ8i4KjOu48K
	 JDwWZm+e0Mo1g==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0FE1040B1B;
	Wed,  1 Oct 2025 15:06:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] man pages: Add a SEE ALSO pointing to Kernel source
In-Reply-To: <cover.1759327966.git.mchehab+huawei@kernel.org>
References: <cover.1759327966.git.mchehab+huawei@kernel.org>
Date: Wed, 01 Oct 2025 09:06:20 -0600
Message-ID: <87o6qqu0er.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> It is interesting to point to what Kernel file contains documented
> item at kernel-doc man pages.
>
> Mauro Carvalho Chehab (1):
>   kernel-doc: output source file name at SEE ALSO
>
>  scripts/lib/kdoc/kdoc_item.py   | 3 ++-
>  scripts/lib/kdoc/kdoc_output.py | 3 ++-
>  scripts/lib/kdoc/kdoc_parser.py | 8 +++++---
>  3 files changed, 9 insertions(+), 5 deletions(-)

Applied (to build-script), thanks.

jon

