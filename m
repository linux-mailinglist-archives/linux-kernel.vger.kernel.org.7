Return-Path: <linux-kernel+bounces-765437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7DBB234F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B5F16E0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A332FE58F;
	Tue, 12 Aug 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="jM8TtxRy"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB731A5BB1;
	Tue, 12 Aug 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024309; cv=none; b=B4iDgJy/GZB31zNhx9pAKchgPDRjxMOC5AA76T2TNUFkFdnXuEc/GJL8P4gV+mnOU8cYt4MSfJyhOeXbaqykOtIMyAaoul5DzPmC094jbzibXEfS2y8aZYj32DloeYzNLG1rWCUrXiYpEsQPvmyGZsBmM6wDBL8PAYDGbQHSieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024309; c=relaxed/simple;
	bh=PouVdmi7c8pRTBB3qzQUkLlcwhcCrjXiVreqI0Kj088=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hLt6i2XGXjdxvLe/HPwzpprJSKvLrl+qsRp66f8KicXVxXfzAjokHciLlVBKGz7H/+tTzZpTpREPsk9gdjLLBsAs0sZomzHG9qhiM9Fc6v61ghzUxmXEHIchNA9tDSbnxxQzN3ZRmVXt44p2L0tEbScmoK6wQga8SDf4uWzw/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=jM8TtxRy; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A42CD40AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755024307; bh=A+TJa+1YAL3xL4DQkHf32bWqzxeCnDN+wkm0l10neeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jM8TtxRyOctibvek6JqZctFVAABA7VURS2ihCWUfF47+Qb3GDZwrh1qs8QiaRWi3l
	 KhF8LjFwA7Vxgcpju8bmUR79KQdqVHBRdOm/DP2zL5+dNg5HP8CPtNsDL9q9xXT5c1
	 BYLuNjP0yrZ9apv536rH0/ZCgwX8QEpzkwQUK0dODsVbwxGPAH4/vOmf80L33qa+rU
	 0qIOU2WiwQreeFzTkIiG5xUa8NrmmosMi/1SH2pdyQwzNQ4tvLgQCrA3tYCLEPOEbB
	 pwu52N0ltFMDCP6rOMzYJHFRikgSYX8FBd0KJ9kEQNVBKiXzIFS5lO/Rnc/pOOnU1O
	 jyxtMhrOEpQ9w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A42CD40AD9;
	Tue, 12 Aug 2025 18:45:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akshaykumar Gunari <akshaygunari@gmail.com>, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com
Cc: linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Akshaykumar Gunari <akshaygunari@gmail.com>
Subject: Re: [PATCH RESEND] docs: arm: stm32: fix typo "busses" -> "buses"
In-Reply-To: <20250807145119.2214-1-akshaygunari@gmail.com>
References: <20250807145119.2214-1-akshaygunari@gmail.com>
Date: Tue, 12 Aug 2025 12:45:06 -0600
Message-ID: <87v7mse5vx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akshaykumar Gunari <akshaygunari@gmail.com> writes:

> Fix the spelling of "busses" to the preferred form "buses" in STM32 ARM
> architecture documentation.
>
> Signed-off-by: Akshaykumar Gunari <akshaygunari@gmail.com>
> ---
>  Documentation/arch/arm/stm32/stm32f746-overview.rst  | 2 +-
>  Documentation/arch/arm/stm32/stm32f769-overview.rst  | 2 +-
>  Documentation/arch/arm/stm32/stm32h743-overview.rst  | 2 +-
>  Documentation/arch/arm/stm32/stm32h750-overview.rst  | 2 +-
>  Documentation/arch/arm/stm32/stm32mp13-overview.rst  | 2 +-
>  Documentation/arch/arm/stm32/stm32mp151-overview.rst | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

jon

