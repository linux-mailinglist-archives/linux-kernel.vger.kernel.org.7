Return-Path: <linux-kernel+bounces-840928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8388ABB5BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5738343A53
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F24283CBD;
	Fri,  3 Oct 2025 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4kKW0mH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A7281530;
	Fri,  3 Oct 2025 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455344; cv=none; b=jtGad1CjM84u6psSIyBTRkQ07JzGPkKLRw1JaiVUsPfbBxRwWuO9g63i2Iq86tQ6X0HvszMVtW1Pb/sqdfvEfRhYhc0sR21Y8OxN1bnJ/CrjwrDV0kGpX8NeNk8EdZJ5zcHRK6oLxuP+55hMGB/eYIWarZmYvzwpcIAvWAmnijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455344; c=relaxed/simple;
	bh=rf1er9a4lReCT/NehrRHLXkGnEVIVFBXkdHlXO9+QZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFSpYr1yLZG1nos+7xuvGYZD/roDz6HhPQe/xPjoW6GJfTMEg29PygEXTYTuOnfIFH4va+d+fIaqDbGxncrPpgqL/X/26b11hMMSEjEgS54aE5+bFU49ysd2JI8zb9OLlFTVkFJePm2ICtYS79wYjgzgJ9fVWW8EnXjiMePOSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4kKW0mH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A577C4CEF4;
	Fri,  3 Oct 2025 01:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759455344;
	bh=rf1er9a4lReCT/NehrRHLXkGnEVIVFBXkdHlXO9+QZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4kKW0mHQPFPHhmpNE0b6fwkBcc7TE61EriU4uKvhaypsTBE9FNmEnwaYKfUlFqRH
	 XzZLXWLO9Njmfyl2FIPvfs48XcP9Xe3aDTailo/hWPS/HH3/8D1ALbq0D5YJfVIu5c
	 8vwsKQTxzD4fv4iM7GEbYgPc/p+r4AKXv6uQzJRSvtXcdPUCjo/8E3aQ72g1gADcJZ
	 Htzcyt6GxlfZfAqCSaKmCsavlQyZ/mA0qSEymI09a9r5bDa94PFt2GVXjwxHwOaS4Z
	 SYHQaMaQA8hXZZUoXI+YImH7P+wxMFN6p8F3K2xgdKSEkKnY4TZUvV8bcdZP9P4Y70
	 swBRfIlJ86S5w==
Date: Thu, 2 Oct 2025 18:35:43 -0700
From: Drew Fustini <fustini@kernel.org>
To: Han Gao <rabenda.cn@gmail.com>
Cc: devicetree@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] riscv: dts: thead: add ziccrse for th1520
Message-ID: <aN8ob0mIu85m0nGO@x1>
References: <cover.1758228055.git.rabenda.cn@gmail.com>
 <71ac2ff73a63bd8674c4bc91fd287390d5339609.1758228055.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ac2ff73a63bd8674c4bc91fd287390d5339609.1758228055.git.rabenda.cn@gmail.com>

On Fri, Sep 19, 2025 at 04:44:48AM +0800, Han Gao wrote:
> Existing rv64 hardware conforms to the rva20 profile.
> 
> Ziccrse is an additional extension required by the rva20 profile, so
> th1520 has this extension.
> 
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>

Reviewed-by: Drew Fustini <fustini@kernel.org>

