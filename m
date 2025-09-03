Return-Path: <linux-kernel+bounces-799491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB6B42C83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F86B485FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1BC2ECD14;
	Wed,  3 Sep 2025 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EKtv0c+v"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000842EC081;
	Wed,  3 Sep 2025 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756937145; cv=none; b=jifDaF2Z+faQ3PaCFk+2yptjQ99e9IVtDrZPYs+qAvyN8OJkuX3vs6GE6xw19o1fpERTT9Gw0xDk3lSNQZ/CXDlLzO3kxBM4JSziF65Uhl+0AFwyeqlFYesySobEZ2uSZgXh669aBOz01V91ex3aR9rbI3jJL/wlMWnYwl8RSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756937145; c=relaxed/simple;
	bh=HNBIccmfGFoDop+biLBwd00oaJFfIZd9vYmyh7u3MUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DYlEceyNZ51gotSMU+RB8AIruLMvNI67XUU5lnUfeUQ5NR7NGWlJryOABpEWXKo2WUjKY7cQ3CNtY5E33jjc+U3Zecd0eq+EPg0h6Vh0PDBBnyuqmVYvP0paAMdoZJ1xNPsr5KvcUGjSHz6PtIOFY8RWTNII7h8kWHeFN1XiQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EKtv0c+v; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E9F2940AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756937143; bh=njql8TB2ZvWulJYRGHAS4pFfMer8bhPtqvBWQVe+nQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EKtv0c+vlmf+gfEthyCgcKkvSCLHKe3Zf0970KPcSEY3uHurDiDrKv6FgVz3KKnSE
	 iBlU7OrEGkU0d+6Z8+SAgSIROL/SDj5LyUjIto56imxR10Bo1a88iixo+dU5afdA0v
	 dsA0/de9Rs+T7X11H58UgJd9ibzQKA38wAPDKmfPeCsw+kO0518EFVBcr4iWUdo/dw
	 HjNgIZrsW/nT0iKm2hy7+WA9u6m4NilWCni0935xjGoQ2Fe5zghiOkMor/qjn73/tr
	 viybjll5kp6V+VQSl/uFE+PrKrDHC/sx9Tt9BsPZBj0zRVOeC22SryK/Ygg/tQ7ERb
	 UrKWCpIZEFkuw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E9F2940AE3;
	Wed,  3 Sep 2025 22:05:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Baruch Siach <baruch@tkos.co.il>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Baruch Siach
 <baruch@tkos.co.il>
Subject: Re: [PATCH] doc: filesystems: proc: remove stale information from
 intro
In-Reply-To: <cb4987a16ed96ee86841aec921d914bd44249d0b.1756294647.git.baruch@tkos.co.il>
References: <cb4987a16ed96ee86841aec921d914bd44249d0b.1756294647.git.baruch@tkos.co.il>
Date: Wed, 03 Sep 2025 16:05:42 -0600
Message-ID: <87bjnrp4y1.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baruch Siach <baruch@tkos.co.il> writes:

> Most of the information in the first paragraph of the
> Introduction/Credits section is outdated.
>
> Documentation update suggestions should go to documentation maintainers
> listed in MAINTAINERS. Remove misleading contact information.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  Documentation/filesystems/proc.rst | 21 ---------------------
>  1 file changed, 21 deletions(-)

I think this poor document needs a lot more love than this ... but it's
a start, I guess, so I've applied it, thanks.

jon

