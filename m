Return-Path: <linux-kernel+bounces-720862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0F7AFC14E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C884278B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C0236A7C;
	Tue,  8 Jul 2025 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="X+5/RJAw"
Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA62367DC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944758; cv=none; b=nRiJID/egzE6EolNgCMjoCkUtrmXrGKzNFHPNnNzDB28mjKS6C1r8czEPv9g+e9YPOmgSgGdyfeVy1KvTjdg+mEj+wHUe18/AoMZxhiDEXkJNs1jL1wFSy6fBUMMYgLOgc4dds8vgVMQwm/R0oCA3aeAu+Cj2zu2w78O4M2KExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944758; c=relaxed/simple;
	bh=uOLGQwozY0JBa84PoYVyx88pZLy6AzPrOR5hT1igWcg=;
	h=In-Reply-To:To:Date:Content-Type:References:Mime-Version:
	 Message-Id:Cc:From:Subject; b=dHDFqOkWdJNjUsCAXe3eiL46DCTnpO/QjqfjFKRpDVs7KY5uaIrBTB9m67f7KtTkXdWzLUs/8Vz3YP7gW0ZlPPYOOMJwZBj9v3K33C9y1Wq1EDPKabRXvNB1GJNgzGQTBFhk/qjjo5epi9twYFcwhth7kTno5+Z3D/62ousPJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=X+5/RJAw; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751944747;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=v7xxPby9ALMOMg798Mawic9TVy+9UEXIg4abmY1scKw=;
 b=X+5/RJAwAkw4WhaO4dBSCz+Yhe9csYoar4GpZYx7pqNxYKV0FcKZyiGB0BCYArv3JDZE6I
 9dDmWE0vfvfjiLnvrL+FJcUKLIFGRMmIQ783Pr+Px17P+OaLQVR6opYM+s+xk4Khx3BXmv
 Qqaszg5IUBOo88k3i5T6dKLAN3HZmNZedFYtEZH34F13PgXij8yaqUTlQhomp28HzhplyZ
 eKwKmRp7edxdiKNpQe6R80NSZPYM/W3aka8HMhertiAkZC+YdwBm85ALKfSMGKhAj269jx
 yTUPR3YvQd4xM1uUn2ADsOpMN69XcKBkgztqMZ+WUpK/lHWgcVw1mFX7Z9au1w==
In-Reply-To: <915bef0530dee6c8bc0ae473837a4bd6786fa4fb.1751698574.git.rabenda.cn@gmail.com>
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
To: "Han Gao" <rabenda.cn@gmail.com>, <devicetree@vger.kernel.org>
Date: Tue, 8 Jul 2025 11:19:01 +0800
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Tue, 08 Jul 2025 11:19:04 +0800
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
References: <cover.1751698574.git.rabenda.cn@gmail.com> <915bef0530dee6c8bc0ae473837a4bd6786fa4fb.1751698574.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
Message-Id: <26fdb706-62b0-4726-8d51-c4664b61ee64@lanxincomputing.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+2686c8e29+279a16+vger.kernel.org+liujingqi@lanxincomputing.com>
Cc: "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	"Chen Wang" <unicorn_wang@outlook.com>, 
	"Inochi Amaoto" <inochiama@gmail.com>, <linux-riscv@lists.infradead.org>, 
	<sophgo@lists.linux.dev>, <linux-kernel@vger.kernel.org>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Subject: Re: [PATCH v3 1/3] riscv: dts: sophgo: Add xtheadvector to the sg2042 devicetree

On 7/5/2025 3:00 PM, Han Gao wrote:
> The sg2042 SoCs support xtheadvector [1] so it can be included in the
> devicetree. Also include vlenb for the cpu. And set vlenb=16 [2].
>
> This can be tested by passing the "mitigations=off" kernel parameter.
>
> Link: https://lore.kernel.org/linux-riscv/20241113-xtheadvector-v11-4-236c22791ef9@rivosinc.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/aCO44SAoS2kIP61r@ghost/ [2]
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

> ---
>   arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 192 +++++++++++++-------
>   1 file changed, 128 insertions(+), 64 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> index b136b6c4128c..dcc984965b6b 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> @@ -260,7 +260,8 @@ cpu0: cpu@0 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <0>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -285,7 +286,8 @@ cpu1: cpu@1 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <1>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -310,7 +312,8 @@ cpu2: cpu@2 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <2>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -335,7 +338,8 @@ cpu3: cpu@3 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <3>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -360,7 +364,8 @@ cpu4: cpu@4 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <4>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -385,7 +390,8 @@ cpu5: cpu@5 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <5>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -410,7 +416,8 @@ cpu6: cpu@6 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <6>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -435,7 +442,8 @@ cpu7: cpu@7 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <7>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -460,7 +468,8 @@ cpu8: cpu@8 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <8>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -485,7 +494,8 @@ cpu9: cpu@9 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <9>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -510,7 +520,8 @@ cpu10: cpu@10 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <10>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -535,7 +546,8 @@ cpu11: cpu@11 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <11>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -560,7 +572,8 @@ cpu12: cpu@12 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <12>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -585,7 +598,8 @@ cpu13: cpu@13 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <13>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -610,7 +624,8 @@ cpu14: cpu@14 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <14>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -635,7 +650,8 @@ cpu15: cpu@15 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <15>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -660,7 +676,8 @@ cpu16: cpu@16 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <16>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -685,7 +702,8 @@ cpu17: cpu@17 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <17>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -710,7 +728,8 @@ cpu18: cpu@18 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <18>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -735,7 +754,8 @@ cpu19: cpu@19 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <19>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -760,7 +780,8 @@ cpu20: cpu@20 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <20>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -785,7 +806,8 @@ cpu21: cpu@21 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <21>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -810,7 +832,8 @@ cpu22: cpu@22 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <22>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -835,7 +858,8 @@ cpu23: cpu@23 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <23>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -860,7 +884,8 @@ cpu24: cpu@24 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <24>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -885,7 +910,8 @@ cpu25: cpu@25 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <25>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -910,7 +936,8 @@ cpu26: cpu@26 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <26>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -935,7 +962,8 @@ cpu27: cpu@27 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <27>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -960,7 +988,8 @@ cpu28: cpu@28 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <28>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -985,7 +1014,8 @@ cpu29: cpu@29 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <29>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1010,7 +1040,8 @@ cpu30: cpu@30 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <30>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1035,7 +1066,8 @@ cpu31: cpu@31 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <31>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1060,7 +1092,8 @@ cpu32: cpu@32 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <32>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1085,7 +1118,8 @@ cpu33: cpu@33 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <33>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1110,7 +1144,8 @@ cpu34: cpu@34 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <34>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1135,7 +1170,8 @@ cpu35: cpu@35 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <35>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1160,7 +1196,8 @@ cpu36: cpu@36 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <36>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1185,7 +1222,8 @@ cpu37: cpu@37 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <37>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1210,7 +1248,8 @@ cpu38: cpu@38 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <38>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1235,7 +1274,8 @@ cpu39: cpu@39 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <39>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1260,7 +1300,8 @@ cpu40: cpu@40 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <40>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1285,7 +1326,8 @@ cpu41: cpu@41 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <41>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1310,7 +1352,8 @@ cpu42: cpu@42 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <42>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1335,7 +1378,8 @@ cpu43: cpu@43 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <43>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1360,7 +1404,8 @@ cpu44: cpu@44 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <44>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1385,7 +1430,8 @@ cpu45: cpu@45 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <45>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1410,7 +1456,8 @@ cpu46: cpu@46 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <46>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1435,7 +1482,8 @@ cpu47: cpu@47 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <47>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1460,7 +1508,8 @@ cpu48: cpu@48 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <48>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1485,7 +1534,8 @@ cpu49: cpu@49 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <49>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1510,7 +1560,8 @@ cpu50: cpu@50 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <50>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1535,7 +1586,8 @@ cpu51: cpu@51 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <51>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1560,7 +1612,8 @@ cpu52: cpu@52 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <52>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1585,7 +1638,8 @@ cpu53: cpu@53 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <53>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1610,7 +1664,8 @@ cpu54: cpu@54 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <54>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1635,7 +1690,8 @@ cpu55: cpu@55 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <55>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1660,7 +1716,8 @@ cpu56: cpu@56 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <56>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1685,7 +1742,8 @@ cpu57: cpu@57 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <57>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1710,7 +1768,8 @@ cpu58: cpu@58 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <58>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1735,7 +1794,8 @@ cpu59: cpu@59 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <59>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1760,7 +1820,8 @@ cpu60: cpu@60 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <60>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1785,7 +1846,8 @@ cpu61: cpu@61 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <61>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1810,7 +1872,8 @@ cpu62: cpu@62 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <62>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;
> @@ -1835,7 +1898,8 @@ cpu63: cpu@63 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm";
> +					       "zihpm", "xtheadvector";
> +			thead,vlenb = <16>;
>   			reg = <63>;
>   			i-cache-block-size = <64>;
>   			i-cache-size = <65536>;

