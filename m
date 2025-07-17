Return-Path: <linux-kernel+bounces-735373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DC0B08E67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E031A67F65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF3E2EBDD3;
	Thu, 17 Jul 2025 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="tMsPNcXH"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399622EBB9C;
	Thu, 17 Jul 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759524; cv=none; b=BQdWhX7dBnGINL66I8wABed/KO1ZM/Mzxoa0a1C0hyyem/X1316M8HqcF/c7k1x2oB2Ime/gDy2sW0VFLHqF8vV4smH4ON7BRKzqhk2M8bKfGVvgIL41jc9xxFsgtHGQYzA8CFQWb2mLzJNpE+9axt4U6gDvQYxPKYpNlKu0q/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759524; c=relaxed/simple;
	bh=uQfSNFlNg98YFrMdP5gFMZ5p5OhiQXKb/LaDDdUua6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sR1OPzfxfI7yj0kX+UXvV8kgKItLwv2MrcB/jS/KQoxxUMVQsvboaV1ROuCRotVyvUNHhUzydpRN8QjJCn6aF07Ix/T6tGgRyRatyoANm14w9GYbivQAErkRl/YH4QsZuCXpLhXFb4PmunmoTqb5Sl9HDVO80KSKTIC8GLTLR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=tMsPNcXH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7E6E6403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752759522; bh=S/PZcD3Zl7lYlVPPjGPO1OpsE0GIe47JfzpR5Bdpu+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tMsPNcXHt3ec5z8as+zeYuIwWyVlKvqrvjV0pDt5DTo2IGyPONxC6OZodicf/ccGZ
	 hxqPv1URGZHBMV6j1nS3JnB52s3E2jW1GXwf7HeR95Jn3LiaGVQIiBNWjdIqFpyMEm
	 1dAzSsEYQogvgdaTQwYtQhL7lvgKPEt67/0RSxe8OhEzsWG+zifqyG1XU6GvaQ+wzL
	 qLZrMQS885cos9VcpCS74uw3B62KQpbxxMsSXHapwr2ONYzhdX6lWVU/1LgIUBEZre
	 d85vtGBSpd2IUz5yvhL4pisdZbaZHCeZwEoXCbZ5us5cuSIfwKcIVTu0kYckY6bvcK
	 sPyy0tct5u0Sg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7E6E6403E1;
	Thu, 17 Jul 2025 13:38:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ignacio =?utf-8?Q?Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Ignacio Pena
 <ignacio.pena87@gmail.com>
Subject: Re: [PATCH] Documentation: Add patch-validator to dev-tools
In-Reply-To: <20250717074745.8333-1-ignacio.pena87@gmail.com>
References: <20250717074745.8333-1-ignacio.pena87@gmail.com>
Date: Thu, 17 Jul 2025 07:38:41 -0600
Message-ID: <874ivbc4ym.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ignacio Pe=C3=B1a <ignacio.pena87@gmail.com> writes:

> From: Ignacio Pena <ignacio.pena87@gmail.com>
>
> Add documentation for patch-validator, a comprehensive tool that helps
> kernel contributors validate their patches before submission. This tool
> catches common mistakes that frequently lead to patch rejections,
> improving the quality of submissions and reducing maintainer workload.
>
> The validator performs 21+ automated checks including:
> - Patch format validation (subject line, changelog placement)
> - DCO compliance and licensing verification=20=20
> - checkpatch.pl integration with enhanced reporting
> - Build impact analysis and testing recommendations
> - Common novice pattern detection
> - Git configuration validation
>
> Also includes companion tools for finding first contributions,
> testing patches safely, and validating patch series.
>
> Link: https://github.com/ipenas-cl/kernel-patch-validator
> Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
> ---
>  Documentation/dev-tools/index.rst           |   1 +
>  Documentation/dev-tools/patch-validator.rst | 287 +++++++++++++++++++
>  2 files changed, 288 insertions(+)
>  create mode 100644 Documentation/dev-tools/patch-validator.rst

Interesting ... overall, we don't generally have detailed documentation
for out-of-tree utilities, though there isn't necessarily any reason why
we couldn't.  But I'm curious as to why you haven't submitted the tool
itself?

Thanks,

jon

