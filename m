Return-Path: <linux-kernel+bounces-767139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8874BB24FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020651B61D16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA1285CA4;
	Wed, 13 Aug 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kX0CZn3B"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AF281352;
	Wed, 13 Aug 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102192; cv=none; b=RGzUD4YpDS/I/EyMqkBe3cOuTrvN+TRmQOQsaGJg+1QC+wnmLVwMFhI2PGJ5N0ckCAk7hcmDfQgYrFPOw5EURJ9JpJ4Egp+iFakBN2uvsCrZ1cFM+4end+WBZW2N3wurhIuqkXVM1ArKawpV9bcOKe4ml99KaO9ah+UgMoxsE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102192; c=relaxed/simple;
	bh=13f2keJxvJEimaoE5trgN6Ua6rt8eRGW+nq4oRTHFBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cazm1yhBlkjk9KOQEg9XaA7MCZulcEBb22JgwYC1NOB1sr/2t0Ui6AQ3Mc4YtZRZzAWZBHzdkzXHOws9t9xTb6kskpa+cl91aeuRq8/MLR4Yj/DuoVuoFBk6RHDEZsSLFul7gyX4NAZjtlIuXZ/KR67ARx5PcH5qATOSyzwiGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kX0CZn3B; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 72E6240AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755102190; bh=13f2keJxvJEimaoE5trgN6Ua6rt8eRGW+nq4oRTHFBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kX0CZn3B+MwNYr9RQxyTADSpNAb4qAp8kFMM4UYErrKa1tAWz+XCylrOstwUbbNQM
	 8bpIOtHnmGjE+NAasQ9X8uC4wn6c6e98g6uTWH9fBLwVWZyfj11OL1LW69SPaCK3kN
	 E9WXEbNRqfemtD/2+ZFQxGhNwykTkGt7iIGLpwMegMMX1HDoeVHplRFxCjRfGqyml/
	 ztkwq51wTraNJnPSPV6aVkMAEf6ZDTKwAKp/VfPg9V/DNQhuVJDMQnNZ81dkBvFi6+
	 eOM+GH53nPwvGUuEz5XU+NLeUEUy7iA4gLB/1ly8mFReyhZRCsBJK2J83sUnomx3vE
	 txHArCauT6olw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 72E6240AD5;
	Wed, 13 Aug 2025 16:23:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Nathan
 Chancellor <mchehab+huawei@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 00/39] Translate sphinx-pre-install to Python
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Date: Wed, 13 Aug 2025 10:23:09 -0600
Message-ID: <87jz37b382.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> that's the second version of the patch series which converts
> sphinx-pre-install to Python.
>
> The core patches are basically the same as on v1, but it has lots of
> fixes over the original script after testing sphinx-install on 22
> distros.

Whee ... I've applied the set, thanks.

jon

