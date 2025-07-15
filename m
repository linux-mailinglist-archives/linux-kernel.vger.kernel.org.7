Return-Path: <linux-kernel+bounces-731043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311EB04DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DEB3B6E14
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6E2C08B3;
	Tue, 15 Jul 2025 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST84jJ2E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477123278D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547017; cv=none; b=OeoZ4zhrKtW6tTRsLtoHWKLizqmtVGx0jTxLjOAcebqikAdUGgoumrZiE0NIu0SFVLVvNRowrBSHiO240SIL6aKXX5OjkLpWRSiFH4IYsMzQ6EN2obPQdgsAkRaCKoL89asgSUNIIPevheYmtKVw3+g9TNBfZGfXM3V5X7INaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547017; c=relaxed/simple;
	bh=KRgeF7wD/feJDZX13wASjrkKxr7mSsP2tkO3lDVNsIY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qbeFHc9SiSmYNcnNUWj9aAnJEVWPNWkHsqLn/o7dB3ahv0hObVObnm+VjbHMSTkcm6hP7Ek/bxmqDI4Iry2yrupPFI1S163xI14StWjyDeaUwLlDPM7nZsOgQLJ6wtfGslqj+kzeslisukwQV8N++IgGNMctLCI6na4ziC9Dvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST84jJ2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055F6C4CEED;
	Tue, 15 Jul 2025 02:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752547016;
	bh=KRgeF7wD/feJDZX13wASjrkKxr7mSsP2tkO3lDVNsIY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ST84jJ2E0VrrhM1RGegBuPswbGnUshbWFe9DEgzeTQl7f/7qHkyNoYxlNGc3xiZPm
	 YCe7sJ4KxL022JM19LzgGvQJtiWTME7cfW7+H6BVoEftzfIp6dnI9uaSwBTG7O6Sfe
	 sNmHA47PGfk9cOrP+4qN8ohelyViQMoJDg/94xBD99n2m3vCr2IvMrKvApQ8gThcuF
	 k/R47P2eHhiDIp5vOavcR4+bmuslbxN/MjBYiMwgSkJgJguBABQldpkFIePvFtfNAT
	 qqjeoGxcz4KZ8jpqk3WZ6fhSp+ouPAVJIsK7HXoCo+om5Dv8QJG/XW4EoAczKA2ENC
	 ERk6QuPjT5IFQ==
Message-ID: <10a23be8-ae70-47ba-88e6-9e0bd07b9b1f@kernel.org>
Date: Tue, 15 Jul 2025 10:36:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] erofs: remove need_kmap in erofs_read_metabuf()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250714090907.4095645-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250714090907.4095645-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 17:09, Gao Xiang wrote:
>  - need_kmap is always true except for a ztailpacking case; thus, just
>    open-code that one;
> 
>  - The upcoming metadata compression will add a new boolean, so simplify
>    this first.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

