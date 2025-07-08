Return-Path: <linux-kernel+bounces-720863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2D1AFC151
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555E74278B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471272356C7;
	Tue,  8 Jul 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="gk2cw/kq"
Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E81799F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944802; cv=none; b=Ciy6bu4JJAbpnWXfukrXk0neyPTDmmuSrxTmH7/yUipTx3jVNGBTmMuBJCD3Oh25lVf3/z1uhENgXZ9QGcu9znCdoce68NVR9oaZ46ujgUvTiiumSN3UCF+fmL+2Hd3B0KQkg5bz4KBiaDiD2GcWTwRIpxZqe3fhzw7P+Evl+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944802; c=relaxed/simple;
	bh=6NA7S6fqZ9zPKFPc2k4u0Jz7SC3yCRu7gBywOX2TBNM=;
	h=To:Cc:In-Reply-To:From:Message-Id:Mime-Version:References:
	 Content-Type:Subject:Date; b=GLHZ5x+tXKN5/jqxjQxXOUc0f8T0fso4nLSdbtkAcumGLhFWpXoSlnPpKxUmdbSpWuL+bHThRfOldsN9+z4F2Zjb0VkR95A0oakXKY2eOiBFdyQioYIUGZpoHqEGlxdXgeqeJLEn+6VL4/20qUhn06BBwBGd9CNqUrx+1F9VOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=gk2cw/kq; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751944788;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Wt/isTt95OjPGANBUDETE7Yb4EqAdrBoIPfqvEbwUds=;
 b=gk2cw/kqop5QztPCHZICnFBwlzRcJnIJhLjPEMXjecBjoyJAdYuBQwJQ5U0gZQXk8Wl+5D
 LwoELgpUqQVgEDwhsl3sU6l0rS2sGVaMRRhaB32GMEgpH5iUVquYZ/VorAd9V2q2lkI+0r
 i4S6E1zTiZLc7ZCFqzVYuA0wporugKKZgRAsCcXWkP8yIajVdY6QZj5si+IbvyjXUZ9syq
 +B/HWq5xEDYtT4BZoxiZuDGAzEe6ZppYquXvCI3yNZCN8xSkozZ38OZTlTrphEM2O8mwi4
 vYtVje44mOdqsGlJYSSM0vt2YM/FxJNgSLwpUSKi7w2EODYBa7YZvo/tKzthEQ==
Content-Transfer-Encoding: 7bit
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
To: "Han Gao" <rabenda.cn@gmail.com>, <devicetree@vger.kernel.org>
Cc: "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	"Chen Wang" <unicorn_wang@outlook.com>, 
	"Inochi Amaoto" <inochiama@gmail.com>, <linux-riscv@lists.infradead.org>, 
	<sophgo@lists.linux.dev>, <linux-kernel@vger.kernel.org>
In-Reply-To: <859df9a05e1693fec9bd2c7dcf14415bb15230bd.1751698574.git.rabenda.cn@gmail.com>
User-Agent: Mozilla Thunderbird
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Message-Id: <bfd5bb2f-906d-4ebf-b3c1-d1022c5821c3@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Tue, 08 Jul 2025 11:19:45 +0800
References: <cover.1751698574.git.rabenda.cn@gmail.com> <859df9a05e1693fec9bd2c7dcf14415bb15230bd.1751698574.git.rabenda.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v3 2/3] riscv: dts: sophgo: add ziccrse for sg2042
Date: Tue, 8 Jul 2025 11:19:43 +0800
X-Lms-Return-Path: <lba+2686c8e52+f5cea4+vger.kernel.org+liujingqi@lanxincomputing.com>
Content-Language: en-US

On 7/5/2025 3:00 PM, Han Gao wrote:
> sg2042 support Ziccrse ISA extension [1].
>
> Link: https://lore.kernel.org/all/20241103145153.105097-12-alexghiti@rivosinc.com/ [1]
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

> ---
>   arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 320 ++++++++++++--------
>   1 file changed, 192 insertions(+), 128 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> index dcc984965b6b..f483f62ab0c4 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> @@ -259,8 +259,9 @@ cpu0: cpu@0 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <0>;
>   			i-cache-block-size = <64>;
> @@ -285,8 +286,9 @@ cpu1: cpu@1 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <1>;
>   			i-cache-block-size = <64>;
> @@ -311,8 +313,9 @@ cpu2: cpu@2 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <2>;
>   			i-cache-block-size = <64>;
> @@ -337,8 +340,9 @@ cpu3: cpu@3 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <3>;
>   			i-cache-block-size = <64>;
> @@ -363,8 +367,9 @@ cpu4: cpu@4 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <4>;
>   			i-cache-block-size = <64>;
> @@ -389,8 +394,9 @@ cpu5: cpu@5 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <5>;
>   			i-cache-block-size = <64>;
> @@ -415,8 +421,9 @@ cpu6: cpu@6 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <6>;
>   			i-cache-block-size = <64>;
> @@ -441,8 +448,9 @@ cpu7: cpu@7 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <7>;
>   			i-cache-block-size = <64>;
> @@ -467,8 +475,9 @@ cpu8: cpu@8 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <8>;
>   			i-cache-block-size = <64>;
> @@ -493,8 +502,9 @@ cpu9: cpu@9 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <9>;
>   			i-cache-block-size = <64>;
> @@ -519,8 +529,9 @@ cpu10: cpu@10 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <10>;
>   			i-cache-block-size = <64>;
> @@ -545,8 +556,9 @@ cpu11: cpu@11 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <11>;
>   			i-cache-block-size = <64>;
> @@ -571,8 +583,9 @@ cpu12: cpu@12 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <12>;
>   			i-cache-block-size = <64>;
> @@ -597,8 +610,9 @@ cpu13: cpu@13 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <13>;
>   			i-cache-block-size = <64>;
> @@ -623,8 +637,9 @@ cpu14: cpu@14 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <14>;
>   			i-cache-block-size = <64>;
> @@ -649,8 +664,9 @@ cpu15: cpu@15 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <15>;
>   			i-cache-block-size = <64>;
> @@ -675,8 +691,9 @@ cpu16: cpu@16 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <16>;
>   			i-cache-block-size = <64>;
> @@ -701,8 +718,9 @@ cpu17: cpu@17 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <17>;
>   			i-cache-block-size = <64>;
> @@ -727,8 +745,9 @@ cpu18: cpu@18 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <18>;
>   			i-cache-block-size = <64>;
> @@ -753,8 +772,9 @@ cpu19: cpu@19 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <19>;
>   			i-cache-block-size = <64>;
> @@ -779,8 +799,9 @@ cpu20: cpu@20 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <20>;
>   			i-cache-block-size = <64>;
> @@ -805,8 +826,9 @@ cpu21: cpu@21 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <21>;
>   			i-cache-block-size = <64>;
> @@ -831,8 +853,9 @@ cpu22: cpu@22 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <22>;
>   			i-cache-block-size = <64>;
> @@ -857,8 +880,9 @@ cpu23: cpu@23 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <23>;
>   			i-cache-block-size = <64>;
> @@ -883,8 +907,9 @@ cpu24: cpu@24 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <24>;
>   			i-cache-block-size = <64>;
> @@ -909,8 +934,9 @@ cpu25: cpu@25 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <25>;
>   			i-cache-block-size = <64>;
> @@ -935,8 +961,9 @@ cpu26: cpu@26 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <26>;
>   			i-cache-block-size = <64>;
> @@ -961,8 +988,9 @@ cpu27: cpu@27 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <27>;
>   			i-cache-block-size = <64>;
> @@ -987,8 +1015,9 @@ cpu28: cpu@28 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <28>;
>   			i-cache-block-size = <64>;
> @@ -1013,8 +1042,9 @@ cpu29: cpu@29 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <29>;
>   			i-cache-block-size = <64>;
> @@ -1039,8 +1069,9 @@ cpu30: cpu@30 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <30>;
>   			i-cache-block-size = <64>;
> @@ -1065,8 +1096,9 @@ cpu31: cpu@31 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <31>;
>   			i-cache-block-size = <64>;
> @@ -1091,8 +1123,9 @@ cpu32: cpu@32 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <32>;
>   			i-cache-block-size = <64>;
> @@ -1117,8 +1150,9 @@ cpu33: cpu@33 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <33>;
>   			i-cache-block-size = <64>;
> @@ -1143,8 +1177,9 @@ cpu34: cpu@34 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <34>;
>   			i-cache-block-size = <64>;
> @@ -1169,8 +1204,9 @@ cpu35: cpu@35 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <35>;
>   			i-cache-block-size = <64>;
> @@ -1195,8 +1231,9 @@ cpu36: cpu@36 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <36>;
>   			i-cache-block-size = <64>;
> @@ -1221,8 +1258,9 @@ cpu37: cpu@37 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <37>;
>   			i-cache-block-size = <64>;
> @@ -1247,8 +1285,9 @@ cpu38: cpu@38 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <38>;
>   			i-cache-block-size = <64>;
> @@ -1273,8 +1312,9 @@ cpu39: cpu@39 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <39>;
>   			i-cache-block-size = <64>;
> @@ -1299,8 +1339,9 @@ cpu40: cpu@40 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <40>;
>   			i-cache-block-size = <64>;
> @@ -1325,8 +1366,9 @@ cpu41: cpu@41 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <41>;
>   			i-cache-block-size = <64>;
> @@ -1351,8 +1393,9 @@ cpu42: cpu@42 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <42>;
>   			i-cache-block-size = <64>;
> @@ -1377,8 +1420,9 @@ cpu43: cpu@43 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <43>;
>   			i-cache-block-size = <64>;
> @@ -1403,8 +1447,9 @@ cpu44: cpu@44 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <44>;
>   			i-cache-block-size = <64>;
> @@ -1429,8 +1474,9 @@ cpu45: cpu@45 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <45>;
>   			i-cache-block-size = <64>;
> @@ -1455,8 +1501,9 @@ cpu46: cpu@46 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <46>;
>   			i-cache-block-size = <64>;
> @@ -1481,8 +1528,9 @@ cpu47: cpu@47 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <47>;
>   			i-cache-block-size = <64>;
> @@ -1507,8 +1555,9 @@ cpu48: cpu@48 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <48>;
>   			i-cache-block-size = <64>;
> @@ -1533,8 +1582,9 @@ cpu49: cpu@49 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <49>;
>   			i-cache-block-size = <64>;
> @@ -1559,8 +1609,9 @@ cpu50: cpu@50 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <50>;
>   			i-cache-block-size = <64>;
> @@ -1585,8 +1636,9 @@ cpu51: cpu@51 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <51>;
>   			i-cache-block-size = <64>;
> @@ -1611,8 +1663,9 @@ cpu52: cpu@52 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <52>;
>   			i-cache-block-size = <64>;
> @@ -1637,8 +1690,9 @@ cpu53: cpu@53 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <53>;
>   			i-cache-block-size = <64>;
> @@ -1663,8 +1717,9 @@ cpu54: cpu@54 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <54>;
>   			i-cache-block-size = <64>;
> @@ -1689,8 +1744,9 @@ cpu55: cpu@55 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <55>;
>   			i-cache-block-size = <64>;
> @@ -1715,8 +1771,9 @@ cpu56: cpu@56 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <56>;
>   			i-cache-block-size = <64>;
> @@ -1741,8 +1798,9 @@ cpu57: cpu@57 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <57>;
>   			i-cache-block-size = <64>;
> @@ -1767,8 +1825,9 @@ cpu58: cpu@58 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <58>;
>   			i-cache-block-size = <64>;
> @@ -1793,8 +1852,9 @@ cpu59: cpu@59 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <59>;
>   			i-cache-block-size = <64>;
> @@ -1819,8 +1879,9 @@ cpu60: cpu@60 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <60>;
>   			i-cache-block-size = <64>;
> @@ -1845,8 +1906,9 @@ cpu61: cpu@61 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <61>;
>   			i-cache-block-size = <64>;
> @@ -1871,8 +1933,9 @@ cpu62: cpu@62 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <62>;
>   			i-cache-block-size = <64>;
> @@ -1897,8 +1960,9 @@ cpu63: cpu@63 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <63>;
>   			i-cache-block-size = <64>;

