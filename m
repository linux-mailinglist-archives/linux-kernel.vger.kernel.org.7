Return-Path: <linux-kernel+bounces-803321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B7EB45D76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67E31BC0EB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D60B2FB092;
	Fri,  5 Sep 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XrwoeG1R"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D82FB088;
	Fri,  5 Sep 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088474; cv=none; b=QrqOsud9CI7STAU9DiQ3X33txsS0IiqFAWBb/QmXGgrfid2eFtGi/ECF3oVUMs5TtiMzfh+nBVTohYN79AYsoxyzKoM71saMlqwtA7CFEi6PiNckuNWvAp5Z0HC4+R4QZerOsfA7bs5iQD6Gb3zergX3LVrhTv+qXTvqoKHnBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088474; c=relaxed/simple;
	bh=CrEGoLHeKAa/3bmAVgUctG+2h2cqCuQQe1zAIfhKWqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OBjruHy6MNbeoOQUGg2/PCtU28v+PK5W4cJD4qDrOSVexyjOwsoEphnsr7nGOKpKdHehaprH2finyH5znQEUTRoG1MpVW54e04xIPm43GGJL5EPcOV4r6TV+e1uy/YATG+8fL1RNas7FZ7ekSSxQWl4gwmU068j2QRlQ7S34MgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XrwoeG1R; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D0A1E406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757088472; bh=MhRcSq3uykxG80tiXwZXUen4ZgycreTBqZrOfDqe0xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XrwoeG1RSZCyE5u1ygzy0XN4Cirxf27I0ZcOBq0idckEOPIGZ+G+L+cJhp2UwN1Fi
	 TA3tNPTspJjek4CdXARqwT1CtU4Ju2l9NJcwjtzT6iokSjLam/VkBZi2IbC6gyIjZ9
	 2DRadNz9Cr2347Ssk6yJ1DOkGmZKKkrFe3VIvGoDG884HvoHPDGLrUe5xFp7faMX58
	 zHlyItpDFIDgDdzXF+fNw0VPh/675+KTzE2Al4+HBhCNgmTcp1wZ7CywE3M3e8ipQn
	 kAPfC3W2WN7Cdqm4w8myyItvQtNgkOoKCTjchQ94FDoQeb5dkn9Rhp+sCz/Egi7IjX
	 UTXUYIhImmYEQ==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D0A1E406FA;
	Fri,  5 Sep 2025 16:07:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox
 <willy@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 00/19] Split sphinx call logic from docs Makefile
In-Reply-To: <cover.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
Date: Fri, 05 Sep 2025 10:07:51 -0600
Message-ID: <87y0qskhm0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This series does a major cleanup at docs Makefile by moving the
> actual doc build logic to a helper script (scripts/sphinx-build-wrapper).
>
> Such script was written in a way that it can be called either
> directly or via a makefile. When running via makefile, it will
> use GNU jobserver to ensure that, when sphinx-build is
> called, the number of jobs will match at most what it is
> specified by the "-j" parameter.

I will try to make another pass over this stuff later today.  I would
really appreciate some more eyes on it, though, and perhaps even some
reports of testing.  This is a significant change, and the presence of
surprised would not be ... surprising ...

Thanks,

jon

