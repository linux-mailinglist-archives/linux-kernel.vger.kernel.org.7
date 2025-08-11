Return-Path: <linux-kernel+bounces-761667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CBBB1FD2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98ED07A8A18
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E74A01;
	Mon, 11 Aug 2025 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EdmzTgpN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6710E3;
	Mon, 11 Aug 2025 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754870803; cv=none; b=PMB7LK7BNzCSM+siIZED+riMsBYaKg2IwEytJkflg5a72xRlsug9IIebiGEtMb01EnlVQ9zz224Ky00S9RGBM6obkJ+Nk10bPXUQZcqChf/5A+pdqo0QFm+cpQlqOPfAw2CPLrh372+ipZv+sZZCFIbyfxt1twsi08N4+dC6wAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754870803; c=relaxed/simple;
	bh=Me7BXIULbu1PawKNGprkMGr4nSJpa4jxmK8qND4zjJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSwP7dEys8GVptr1V4xa6O5RPXkC1dcHdZ5rQTKQVuLNiMwbzc50IXiFTPNHGYGJdIhi29KovQOsmfI4mDkNYuxQVtW6jZP/CC0ziEXUJ3mLBRuTt9IMiRudsKK5Qpy66RP+LWNmSch4rsO8Lsjnac/njjKr9UCMsmuon5ikxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EdmzTgpN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CR3qZ/ks8Hd4Zktc0AhYsQ6iQmLURrornNBY9WHJxvM=; b=EdmzTgpNbfCrrd+IPUy5ZMl8iI
	gR2w4Mevz/KBzkapvgjfwdswOfgY4OpOxdxq9SG2damYfsx4p7c8jHil8bLBCLkIH4oH21RuD2T4K
	PPc9h4ohJdMOUC9gWE1jiqyPU2bOhDMW/L9u2PKDyBVAYEr0UhWqgdTDLHhewCtAAk7q0nA6lcFxy
	zQTSmT8nh3vSvM7Ej/8GVIkF/V7hK1v+EmdknFLKmSC5xevpZr2aufzLF1eHx8OIice8Q2LK+wGm+
	wEvaR/4pBI9oKF2wGBT072u4SXJtP+NTEtt67ZdmC1bwELUyf0koBT+iW4HvcrlddSzqLfPT6YNNv
	6IkIkjKQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulG3f-00000006DDA-3Afm;
	Mon, 11 Aug 2025 00:06:35 +0000
Message-ID: <ea997753-510e-4d9f-af53-8943dad822c0@infradead.org>
Date: Sun, 10 Aug 2025 17:06:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] README: restructure with role-based documentation
 and guidelines
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, josh@joshtriplett.org, kees@kernel.org,
 konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, workflows@vger.kernel.org
References: <20250809234008.1540324-1-sashal@kernel.org>
 <20250809234008.1540324-2-sashal@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250809234008.1540324-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/9/25 4:40 PM, Sasha Levin wrote:
> Reorganize README to provide targeted documentation paths for different
> user roles including developers, researchers, security experts,
> maintainers, and AI coding assistants. Add quick start section and
> essential docs links.
> 
> Include proper attribution requirements for AI-assisted contributions
> using Assisted-by tags with agent details and tools used.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  README | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 173 insertions(+), 11 deletions(-)
> 

I like it. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

