Return-Path: <linux-kernel+bounces-838905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954FEBB065C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EFE3A644D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D379E2EC0B0;
	Wed,  1 Oct 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DbZExWKP"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7A2D2381;
	Wed,  1 Oct 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323528; cv=none; b=OZzYb7TWPCK2TnupZcohzi49iVH7ytNkRyyan9bN4EBnR4aINAt1uBxu19cjNiUZ5HcW5pQel27ZplK/9bVcw7IPxTR/xN+56c648UfI1K0+uvCSYxmp7DOL7HhDDLBILnOHPnEBtc1SaChLl+FH59BJaEYIrEw66LHv0d0m+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323528; c=relaxed/simple;
	bh=wAQSpr61j9oSw4NK0J2PDg66NdlnizHZCpo1H/Er8BI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fNdXsvmA+6HSHxggNuY8XN1JyBGbLJGEH5VjCRXkkHL+8eAON1ZKA6KfYlG5FXLqyK/hjI6vqbA4fI+Dbh8T1oKqZNkTuiPDMiT+iQi5BVNC7OdC6QcIK8re9+SMYtZdjp0rbEdEje5D8GbaI4NUm6+KNAnLI+kWYZTJxNZSwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DbZExWKP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1948A406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1759323526; bh=tezH4wRgkK/jkrCY/BhOU34yY2hmFkMYyrlnKcM0dWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DbZExWKPdla2RaN37dtchYn2p4tOTxJ6psHEtxzFiiMdnIMfu7SiZrqtvgMRbj+j+
	 E3D/z217vsI/fR+BNjPDlvJQIH4pywRuWn+joSKJTNPl8gaHRH7q55juJoCXaMrWxy
	 UFN1GGkj5IzFUEe101RK8Yf4DGCASt3zmYgASiMhPGyllhvzXH4sEDRtfeIaEFVYuT
	 XaovMmwBZVskaOd+Lal05b9+HMSyp1wteQgYe/KWKJ0IntssuvUqtDURCj4dyEeFq2
	 aYWgd8pnKZ2iiNvxJaQ8j39Keo5/GLV+gAM7T7YWs41+VkF5XW0cb8/TxVW1MB8C/P
	 Q4b+D2ld8mANg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1948A406FB;
	Wed,  1 Oct 2025 12:58:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH 0/2] some fixes for docs Makefile
In-Reply-To: <cover.1758881658.git.mchehab+huawei@kernel.org>
References: <cover.1758881658.git.mchehab+huawei@kernel.org>
Date: Wed, 01 Oct 2025 06:58:41 -0600
Message-ID: <875xcyvkvy.fsf@trenco.lwn.net>
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
> Another small series against build-script branch with fixes.
>
> The first one removes bogus warnings when latex is not installed.
> The second one has a small fix to avoid writing *.pyc cache at the
> source dir.
>
> Mauro Carvalho Chehab (2):
>   tools/docs/sphinx-build-wrapper: allow skipping sphinx-build step
>   docs: Makefile: avoid a warning when using without texlive
>
>  Documentation/Makefile          | 13 ++++---------
>  tools/docs/sphinx-build-wrapper | 18 ++++++++++++------
>  2 files changed, 16 insertions(+), 15 deletions(-)

I've kind of lost the plot with all of these patches but, in any case,
this one doesn't apply here.  If it's still needed, can I request a
resend?

Thanks,

jon

