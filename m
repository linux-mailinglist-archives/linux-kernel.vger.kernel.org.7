Return-Path: <linux-kernel+bounces-746477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44950B12727
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D3E7B3B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED34025C81F;
	Fri, 25 Jul 2025 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1TTlpMh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214D24E4A8;
	Fri, 25 Jul 2025 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485230; cv=none; b=ra1D1T1e+plD2jhL42CTI+sKCrP2umK/Y/gM7CfEKzv+llh+IB70PUFG4lkTvGfEylBjKhDBAUyseJB7e0BDDXJyskJrwblKagIRNHmAvURsNTED8zqdl8kh1/HzzymLrQIwGxv/4NQ2wC7kbwPN8GI+fRItNRoo8fIXpuZEeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485230; c=relaxed/simple;
	bh=05M8ulyHYJtjgB5a3mkfnq2IXUnP0UHQyHaCLEi3P+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk9zJhXMx/zW/WObdaoqKHGuFV2XLSmVmN4+GmTr/zN49hifPfXpz6SydpC+MhN4rkPKv3JDteHCkyJSJlc4s8M017W8j6CUFcZ7DSRcxVa2Mr+0cCCRnR0zGdOExDsneNrEt12KDqYy20116z7mvSF1GDq4z3EnQYZZVYE2N08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1TTlpMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C281FC4CEE7;
	Fri, 25 Jul 2025 23:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485229;
	bh=05M8ulyHYJtjgB5a3mkfnq2IXUnP0UHQyHaCLEi3P+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1TTlpMhxsTkfiWNsXSXIsAlQ2LaMwbz0d0OP35IbvKH88v4CFLxRis05Zc4X2KVa
	 BPq2Q8rtU1iaMWz8fFtQsYRqV0MoaE3HaHvCRrFnOteTtQkN+eT0o3U99yTq+nodRp
	 dCc00z6T3/uw0JxmYKidhHtJij0SzUd4M28MHlL7JlBkJ9xOL25hurQ8pjjm6Y81VO
	 nJFptqVBfmioqkTki5OvWCe65VBxtETW2Jn2GZ8ThdZcyW7ltxYCbVmAZ9dhJQKYs7
	 1rxustsyztBUezz9uMv+mo48OsLDXuDEAkc6zLrpQQ5lPJC5WzNFeoM2LY7dfwYMS6
	 7Jbd2m2w7fNJw==
Date: Fri, 25 Jul 2025 18:13:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v1 3/4] dt-bindings: riscv: starfive: add
 milkv,marscm-lite
Message-ID: <175348522862.2010612.3490734950499726337.robh@kernel.org>
References: <20250724094912.253723-1-e@freeshell.de>
 <20250724094912.253723-4-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724094912.253723-4-e@freeshell.de>


On Thu, 24 Jul 2025 02:48:46 -0700, E Shattow wrote:
> Add "milkv,marscm-lite" as a StarFive JH7110 SoC-based system-on-module.
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


