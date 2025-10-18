Return-Path: <linux-kernel+bounces-859001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2FCBEC732
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6576718920F9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB9E288C2F;
	Sat, 18 Oct 2025 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW4OQ5KK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AA2512DE;
	Sat, 18 Oct 2025 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760761583; cv=none; b=gvU3srwTF77Jtz7LB5/KcafjMWKQqf64KppOZuMc9jw68x1HqQWdkeXSehwP1gJGKsE93AUDvWcjEcLU5MfA2sa8brnYpWyBjE4nU7oeF16vglnNoQ1sJ16q6gMMUA/GRMKntxPBJUpGOyQvOh2dbpC7e4wv87vd18ZEZSNYlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760761583; c=relaxed/simple;
	bh=MEgE0QRPhEEuk7tndh1iLlixQzBm8L9kEqydt7lrUeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKq27Ks3mdXmnc2VEWBT/pemG++7FgrAP33e6YX8BTgINjFUXW4oXvJBWOC2junVPit+gM+2QYGtYuExgApPqSj+mBuB5PTjWJIMP3LEGOW1Z30Oo+zZdw49tYidu+ZwVw1AHehxfXbzKI5nbBYKwmL3BAK6SfzaA5IBa2RhQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW4OQ5KK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04702C4CEF8;
	Sat, 18 Oct 2025 04:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760761583;
	bh=MEgE0QRPhEEuk7tndh1iLlixQzBm8L9kEqydt7lrUeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WW4OQ5KKq/YUAx14hKAI1n6M84ZVfX7iqRTeZxivffvfBhaEKvGsHOzXsd81bxgwx
	 wsYxP4LAg9+QiY7xRo74GmxKOi1O0edebdmFhxb/Iw2HYC+LqNMQC/MM4AmZCsP59h
	 ADdGIV6f+SeLwqeWgGlaC9pQCzTaT3mIiGkJ1+dE3t9/pDBgiyNBY5R/nUTDMGXVSK
	 5+5bVQiCGCcnZxHhEAbWWz8abifKYN/GTIYYH5xjWKVT2p9yedgtdfN1Leu3bP/d6a
	 uvoKC/Gz03/2mKhg5TZhcyLUjLyJPbdhfv1PGTzD3x4/+uYEMajSkDerulS+OeNtLG
	 f5zlfIAEvYVRw==
Date: Fri, 17 Oct 2025 21:26:21 -0700
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
Subject: Re: [PATCH v2 0/3] riscv: dts: thead: add more th1520 isa extension
 support
Message-ID: <aPMW7ZNjVjy/8Izk@x1>
References: <cover.1758228055.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758228055.git.rabenda.cn@gmail.com>

On Fri, Sep 19, 2025 at 04:44:46AM +0800, Han Gao wrote:
> Add xtheadvector & ziccrse & zfh for th1520
> 
> Updated the commit message for the patchset
> 
> Thanks,
> Han
> 
> ---
> v1: https://lore.kernel.org/all/20250911184528.1512543-1-rabenda.cn@gmail.com/
> 
> Han Gao (3):
>   riscv: dts: thead: add xtheadvector to the th1520 devicetree
>   riscv: dts: thead: add ziccrse for th1520
>   riscv: dts: thead: add zfh for th1520
> 
>  arch/riscv/boot/dts/thead/th1520.dtsi | 28 +++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> -- 
> 2.47.3
> 

Applied to thead-dt-for-next, thanks!

[1/3] riscv: dts: thead: add xtheadvector to the th1520 devicetree
      commit aef6dc006696c20ccc58c4c0235a14e7b4b317a0
[2/3] riscv: dts: thead: add ziccrse for th1520
      commit bcc3b9c5de5e2a03ede1a8133c05255927d744d6
[3/3] riscv: dts: thead: add zfh for th1520
      commit fac4be7b3d49ae7e32d8ae523343d7fe790772f9


-Drew

