Return-Path: <linux-kernel+bounces-801297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA92B44359
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B09B94E4A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0562306D26;
	Thu,  4 Sep 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="f9aM0l70"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941EC1D554;
	Thu,  4 Sep 2025 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004182; cv=none; b=DtR7opAoxSOk0cjhGBf7VS9a9pU7K2sPbWxDM+KrHXS6m8w1FGCyU8eeR/dVWzbWvGbWHPgVRxYqWCVSd5cTI1VOZqv++K4tjX98Z3x5sqHa0PwctIK/TsIKWJnsk7D2FLe/MVPbA8MNQtDaRhM3FQ6E5k+phqi9CxE4Wgtuytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004182; c=relaxed/simple;
	bh=VclGNSTasmoyTyQtliq2S2zIA/MChid17egfEOlk83c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kVdbjG9NFtXMXrERue9i7aY6l/woFe58UCuMIW1e6vD2xaVy9Ib6QRePfXR7he7b851FwwA1dNbj89LLQaGoSeGwTRbxtjx0bPmovg8t9BBhxmItO/mYhPL1LDdmbMVQc2O9x/+YZYboGQcz9fcjE7RO78jBR6GTOE65IF0aq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=f9aM0l70; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 71F59406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757004177; bh=3Pkh2sB0VtPl6+kb9/0x9oQQp35VYh+YFPxsQo/WNrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f9aM0l70YnB/LZDpI3Af5UHc+ihAxPADLoFi04ZJaLcbB08LKyexr6OGamC05kzt6
	 oxEaG3xVJC7INBpza9lOW/GRDg4KECuiWppyxdZFgQ1dzYlxoc5XAyvOgW6XlJ2ibL
	 lHVVkKKOWEKZS3PrBFx6Ad3rcZpSjY5tbFdONM2M8JRM22IpImfR8RUpr61GvKwDcK
	 8+XkBhsuiUBggvNodWBLSsnkNqPj1+k8kaWOtaNABGjAILG+tC08oleCih5gxS/Qd6
	 sNPvOdJlwPqHgnGE/BFOzLYR2wzs9sC0Pk0lmQmdx6bO6SUFpHuPZeCXW8p6J5JUx+
	 LwYbcOQ21vI7Q==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 71F59406FA;
	Thu,  4 Sep 2025 16:42:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>, Alex Shi <mchehab+huawei@kernel.org>, Dongliang Mu
 <dzm91@hust.edu.cn>, Federico Vaga <federico.vaga@vaga.pv.it>, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Yanteng Si <si.yanteng@linux.dev>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/19] scripts: sphinx-pre-install: move it to
 tools/docs
In-Reply-To: <68810fc1065bbe8ef1305041fb10fa632bb64dd3.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <68810fc1065bbe8ef1305041fb10fa632bb64dd3.1756969623.git.mchehab+huawei@kernel.org>
Date: Thu, 04 Sep 2025 10:42:56 -0600
Message-ID: <87ms7amanj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As we're reorganizing the place where doc scripts are located,
> move this one to tools/docs.
>
> No functional changes.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile                             | 14 +++++++-------
>  Documentation/doc-guide/sphinx.rst                 |  4 ++--
>  Documentation/sphinx/kerneldoc-preamble.sty        |  2 +-
>  .../translations/it_IT/doc-guide/sphinx.rst        |  4 ++--
>  .../translations/zh_CN/doc-guide/sphinx.rst        |  4 ++--
>  Documentation/translations/zh_CN/how-to.rst        |  2 +-

This one fails to apply to the translations - it looks like some sort of
encoding problem...?

Thanks,

jon

