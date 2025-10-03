Return-Path: <linux-kernel+bounces-840927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C80BB5BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D812B4E3321
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C182836BD;
	Fri,  3 Oct 2025 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbR7WYX1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96932273D9F;
	Fri,  3 Oct 2025 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455331; cv=none; b=jr/h4aTrcvHK/UtEU6NaaoqvCeb/x3Kp7hIRHOayaDfKDwoWLnCkeJ/+mPZ6oyFRFkguRf4GZI3oDppsIyqlvulqlfTAHb0dH8Wm5W1WAKstfUT55rS/iGOs7v3TIrhax4cRiw96brsYuH3/20FSjmUMmWkJ516Q1lat3KhVdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455331; c=relaxed/simple;
	bh=Rc0jCyqhwITy1zb5mT2jrVxBrzj0eHN3SwcodYrb+vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgugfSWHIH/qGKy+p/TUaufl4+mOGYWdnsbtMMSVGWh82j6aEfwV5uO5EJj2L1U5pWvSihAW8UechRvSbasO7DcIUL68s+ON3wNGZ/eHtxQ6V9LnGEEr+6vefnFU2fwX1INVdBAlMjgMTCFN1tAXGePz9jY0XRPhxwL0vu9qGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbR7WYX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE84EC4CEF4;
	Fri,  3 Oct 2025 01:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759455330;
	bh=Rc0jCyqhwITy1zb5mT2jrVxBrzj0eHN3SwcodYrb+vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbR7WYX1w2sUsckCNEoeEsZXkzBgJmehVfrS5tks3VGq4KaG+52S/lNVMkU7kuIz3
	 021EVPz9SfUanKh/B7g5xLntFBdNDgUhZc2kjY/KyL0uZSY4iYoE/Cdedo9HN3+jX3
	 ahtbNMsYWzapeWKRHx27ZaPm04hGmAvB2qxhFx4Fq4OEH4PewNqd3SZpO3h+u927V0
	 SwThOzyBloUR1/vo/Tw8bRhZ4cH+FpYO1qADmwEripz8KfKCNe6xRmvA3ufmhPntSm
	 7oJGuLdXAx4od24nbP6dRHyw19okWFENXxgwzrFjyp648mclb9yqObWQPuLLtNgHg2
	 FxAJFc6DGTahQ==
Date: Thu, 2 Oct 2025 18:35:28 -0700
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
Subject: Re: [PATCH v2 1/3] riscv: dts: thead: add xtheadvector to the th1520
 devicetree
Message-ID: <aN8oYBGfd9Y0vp0O@x1>
References: <cover.1758228055.git.rabenda.cn@gmail.com>
 <1ff3fb07b24fb375fcf9d3067aa50583f47c35fe.1758228055.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff3fb07b24fb375fcf9d3067aa50583f47c35fe.1758228055.git.rabenda.cn@gmail.com>

On Fri, Sep 19, 2025 at 04:44:47AM +0800, Han Gao wrote:
> The th1520 support xtheadvector [1] so it can be included in the
> devicetree. Also include vlenb for the cpu. And set vlenb=16 [2].
> 
> This can be tested by passing the "mitigations=off" kernel parameter.
> 
> Link: https://lore.kernel.org/linux-riscv/20241113-xtheadvector-v11-4-236c22791ef9@rivosinc.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/aCO44SAoS2kIP61r@ghost/ [2]
> 
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>

Reviewed-by: Drew Fustini <fustini@kernel.org>

