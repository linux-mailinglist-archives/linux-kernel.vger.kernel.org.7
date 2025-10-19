Return-Path: <linux-kernel+bounces-859874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D5BEED91
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB741895E3A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724A8230BFD;
	Sun, 19 Oct 2025 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cb0RkHD8"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14A1A23AC;
	Sun, 19 Oct 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909454; cv=none; b=WcEPdlb1wFJf+v+TfV/nWsWMSccEzcT3S/qqZz6n3JVxXepCFHDWt1hsLNTUN2BEQPXDMmgI3j0gz4bZiTUrQWdat2hmT5U2SY7OsEowwVHnBCu8Y2nvXkHiDJxMoVFXwAOZayZCrfUVU17CGceo5ZbI9eOId346pAoNgeps7KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909454; c=relaxed/simple;
	bh=m0vXu58JOKSuo9W/oLeUSC+huzWMxxj//eOu9kjvm0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzjR3jbvggDENF24O4EVhv4wrypnYNhO8t8fBggWt1h5PpW9cd0k0GNIICX89TgB4IrNjWv6EJRmW6vAi4C8MF93lPq5/j2O3OT+tPOZ87wnVrUWxNhCwW2/EPcJbbK4iH2eMPYArWhCCNr9OSqqcK3AUVLne2pwNb7OIus9dB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cb0RkHD8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=U4SNFq6tMm7n2I4cn3XDh+JH8DxlPT8XDtklL//DXuo=; b=Cb0RkHD8WsowqdjTkBTyv0KEP7
	Eo8PQQvckC9exKYK9MFEmAGmNixSr8W7J0rWZq7vip3DPHf5WO+21Eg+U/f7YaOX7rdvefqgkx7sA
	9pBCzkDtHAWw5lCDOzhvp/tBlUintL2VcqIQ1QkZxlL48Xwegvy/kIkkKlu2aPbbLOFuXygwFAwsP
	UKbyi6omyb/Yq5m19GXBsoTaewmwhFE67fH67qG5hq+ox5BqlmPPa4RiSE9CFy4ekdSukLm3Soafx
	Tzl63cX6n74BWKw/78/rJ7MZQT0sNprO//aBeCFDb7vRkWC7hjywuRF0AYjkte1FCk2LuK4CAoZqR
	Rg4Pe7oA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAazJ-0000000BSnE-3k2P;
	Sun, 19 Oct 2025 21:30:49 +0000
Message-ID: <ba148c36-8778-425e-8c94-35ebd708fc80@infradead.org>
Date: Sun, 19 Oct 2025 14:30:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ktap: fix minor typos in ktap.rst file
To: Clint George <clintbgeorge@gmail.com>, corbet@lwn.net
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251019202053.285723-1-clintbgeorge@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251019202053.285723-1-clintbgeorge@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/19/25 1:20 PM, Clint George wrote:
> Fix couple of grammar and spelling issues such as:
> diagnosic -> diagnostic
> Cuurently accepted directives -> The currently accepted directives
> It's website and specification -> Its website and specification

Is that last comment backwards?

> 
> This patch aims to correct these issue and enhance the existing
> documentation.
> 
> Signed-off-by: Clint George <clintbgeorge@gmail.com>
> ---
>  Documentation/dev-tools/ktap.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index a9810bed5..155d792cf 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -5,7 +5,7 @@ The Kernel Test Anything Protocol (KTAP), version 1
>  ===================================================
>  
>  TAP, or the Test Anything Protocol is a format for specifying test results used
> -by a number of projects. Its website and specification are found at this `link
> +by a number of projects. It's website and specification are found at this `link

The '-' original line is correct.

>  <https://testanything.org/>`_. The Linux Kernel largely uses TAP output for test
>  results. However, Kernel testing frameworks have special needs for test results
>  which don't align with the original TAP specification. Thus, a "Kernel TAP"

The other changes are OK.

-- 
~Randy


