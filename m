Return-Path: <linux-kernel+bounces-826460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE740B8E949
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724473BEC49
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A022C11DD;
	Sun, 21 Sep 2025 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="E3Un81n/"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2D2580CF;
	Sun, 21 Sep 2025 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758495349; cv=none; b=Y9SB/jQ+E0m/cT17FH5MrpiLbhy1qs5ONPNaNU8AlMGBMU958F4DJeD6jUKSN9xqay0qSz3KyYBMGw9hHQ8rUp5Qz8cy88nMADYmSdtFhbEdUTyPRXufRkX4XL/aC/iV/DsNXcBV6y14GMlDc7bb90ZdeF5ZmKvDFOeYjIJ7uV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758495349; c=relaxed/simple;
	bh=URIwaATUK+NdLnPeTmJDkZQV8VmgwLiZzwQtjRLdXck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B3KWev9fWJhxjyxQyU8tcGWVR67i4Hpsa5+WOmJRQjNA8+KAZqd3hGMBksYX1ScJiA1P24jWlXTTbHhOWlBKVlnaypFD9ZSlAz5opDDRKn5NgpHQCKuSmvv5lWpHWmLdEXiSstRfk8Kc4KJlIMu117odFM52c6KB7LOTXJ0D9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=E3Un81n/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6D58F40B16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758495347; bh=5zyaBbyPh7EAwE+GJ+JBL35RaUvfL2VQKPWUoi7fTG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=E3Un81n/xEDKYy2uBwz3En1h09LckqOYXnfMk8JVtPZ/Hz9csC9i2K3Pbf+N129FP
	 9eoTmK1/K0nINGt8LqE+I3nflW4PWN7YFMZPD9Jm+CXNKORSeWHWPaj0aUfQ3TaUr4
	 BhYYwiobQ8Duy7JUx2JPQV+HAaJ4Pl1AKDkWSem162f/QC/rfP6wnQXfZjmpaYMmjw
	 79k2Tyiia0OopG0ZHZMTV+0csxXDCE1k13k1L8MP90wmXLJ/YfUWCdy4ZOMbBRLkBg
	 f71aLHo8Yt5rgP19vy2vQBToxezz62rnb/XS86qOuc+OUpCMgbo7+SgG4sGNIrRfjq
	 KiU6hCu9WM7GA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::824])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6D58F40B16;
	Sun, 21 Sep 2025 22:55:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] A couple of patches for sphinx-build-wrapper
In-Reply-To: <cover.1758361087.git.mchehab+huawei@kernel.org>
References: <cover.1758361087.git.mchehab+huawei@kernel.org>
Date: Sun, 21 Sep 2025 16:55:46 -0600
Message-ID: <87plbj8lfx.fsf@trenco.lwn.net>
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
> This small series is against docs/build-script branch.
>
> The first patch addresses the lack of a check after running
> sphinx-build to see if it returned some error code.
>
> The second patch is a partial revert: we wneded including
> sphinx-build-wrapper twice due to a badly-solved rebase from
> my side.
>
> The third patch is a bonus cleanup: it get rids with
> load_config.py, replacing it by a single line at conf.py,
> simplifying even further docs Makefile and docs build system.
>
> Mauro Carvalho Chehab (3):
>   tools/docs: sphinx-build-wrapper: handle sphinx-build errors
>   scripts: remove sphinx-build-wrapper from scripts/
>   docs: conf.py: get rid of load_config.py

OK, I've put these onto the build-script branch.

Thanks,

jon

