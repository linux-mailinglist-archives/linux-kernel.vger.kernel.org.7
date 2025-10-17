Return-Path: <linux-kernel+bounces-858739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E78E5BEBA26
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DBB1AE13DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1859F233155;
	Fri, 17 Oct 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="h32wcaXo"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F004A266B64;
	Fri, 17 Oct 2025 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732647; cv=none; b=LtOb+Hgos9CDy84P0R51czT8z9FlwxRBxleN4Zk2DNbpOq3x6n2/yxIUDIxJQSROWCZIpZIgHQd6uVq9SfJJYKZFRyut2uYax1Xn9vn+SdS2DiMl4p4x8e3+CaJygp55rHeeSLK/AxNdL+xvuBq7UwMIrhn5hCeSOi0xvdBMDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732647; c=relaxed/simple;
	bh=fsPsUjjkUujeuTdhLIxwXe3cFQrfnlewqh5RwRlKnPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PvrNku/eecUqkaPci3gmVzFMMD3Elro/zYzJQX+n1dXt/tpp4J1qTPYGrolR1FnbiMviDtLVyoDxBicuJ7TLmcPFCQY9ttEr4GzBUovS8GJc8lzE38QmWOGZJMRreQj3f+O2CYOzymcr14mpXAejrbLDaQgrr6hhgHD/2Bu/Vkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=h32wcaXo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C60D740B1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760732643; bh=fsPsUjjkUujeuTdhLIxwXe3cFQrfnlewqh5RwRlKnPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h32wcaXouiAWS/W55OSffUxoAagyz4ByNZSEGxf3JiiZwZGUksNRWFz/1ZQg9+3SF
	 bnIPwfQNzq+pLibi1mX0hEVjvXGuVXCyRuueHZE00ZQnUFor3PJn1Nwes6+J5kJpnv
	 X/GllEtsQ7Ou0yU8Y+qRslRO0TG9Dh9iXRaYTfyxjJFzTA7w742K32bqLoKq4LC+Pf
	 5yqap1tEBKkiPZKL1gKSH5LDgA7DDKnT+tqS/U333kBMGCMLLdGJae9wvcDD6fWAKQ
	 K2OwO9kwJM/IkEbcDrJ6oKq47IklAjGDTho9OXHcnjbvwuhZYE1/iw6r+80mR561lM
	 NPbnvqausDyNQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C60D740B1D;
	Fri, 17 Oct 2025 20:24:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Will Deacon <will@kernel.org>,
 Markus Heiser <markus.heiser@darmarit.de>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Silvio Fricke <silvio.fricke@gmail.com>
Subject: Re: [PATCH v2 0/2] Associative arrays documentation formatting
 cleanups
In-Reply-To: <20251013095630.34235-2-bagasdotme@gmail.com>
References: <20251013095630.34235-2-bagasdotme@gmail.com>
Date: Fri, 17 Oct 2025 14:24:02 -0600
Message-ID: <874irx1dlp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> Here's two-patch formatting cleanup series for generic associative array
> implementation docs. The shortlog below should be self-explanatory.
>
> Enjoy!

Applied, thanks.

jon

