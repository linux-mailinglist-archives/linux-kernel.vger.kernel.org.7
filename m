Return-Path: <linux-kernel+bounces-720864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7978CAFC154
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A486F427A05
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE6230BEB;
	Tue,  8 Jul 2025 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="F8l1Io3q"
Received: from sg-3-17.ptr.tlmpb.com (sg-3-17.ptr.tlmpb.com [101.45.255.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273951799F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944821; cv=none; b=reYiUeOlP1WvYNoJygkkPJxBlXY4n8LNUjG461XCoM23dX7qjIAPtvU0e/e0E3J2W1VHK2xJcG2OqbaNJ4tGdzNnqP9ZxXvhK4H94Vs7oqVe5mFI4/swXMNAzpP5n67Q26TNW+Z/IFpvJ1yrYfuTBzPuBbpS+sbPQyqIEwJ6Qvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944821; c=relaxed/simple;
	bh=j1RTrnYngJeTHQKf0Lv2BhKqbai3RWXEE2qbuRvO5m0=;
	h=References:To:Content-Type:Mime-Version:In-Reply-To:From:Subject:
	 Date:Message-Id:Cc; b=uVQ2AbaLKlEQmFCjxMksilDellbSHJfQOD2kFFqCbh4i9LjToeWrcnXhwEeFVywWID7t3iwvlVzb+49AAivFEHjo8SNu+Apw5Ed6iBwPQ4T3toE8Vm8+SvrKRk5Gof56bx5tTMIw5uHHiDjf65yGHtiHWZyF1Ws1pxF+bbBOHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=F8l1Io3q; arc=none smtp.client-ip=101.45.255.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751944806;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=TLZ8CnNVVNYk7z6/eI8XM8/3wLApU3IS8ygqho0AvIU=;
 b=F8l1Io3qOwowEYs/BA0IqkFaZ5N5okrZ661D2ERtWOBeHtOg9xUvisqTLiFSW+1XvEIZgU
 a547Mtg1bRUVE5KwI/n0FQZ3Ah3NG519GWbPpEyuy44MK1RvXqX8sdRh0IWa4eLaqAgP94
 v7xtpJ6ItToy84IcvYEagqE6vDeA9REbjM1xVNGp+zQ03QvJF0d0hw54tz8qAZWt/ni/vU
 6oCZdh816l8uE1s7DVMhlBRPYl/zZ530EWWyrd6iMCBlTz9WaV10w7mt7jxsI7KSfRXLNC
 19mmStWwpEnHYmCKSBIW78TvgjuWTp/VF9j+7QOe6QNALATi+6NMjvmOP8CMsg==
References: <cover.1751698574.git.rabenda.cn@gmail.com> <bcaf5684c614959f49a9770bf3cd41096cee5fe6.1751698574.git.rabenda.cn@gmail.com>
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Tue, 08 Jul 2025 11:20:03 +0800
X-Lms-Return-Path: <lba+2686c8e64+2f4e56+vger.kernel.org+liujingqi@lanxincomputing.com>
To: "Han Gao" <rabenda.cn@gmail.com>, <devicetree@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
In-Reply-To: <bcaf5684c614959f49a9770bf3cd41096cee5fe6.1751698574.git.rabenda.cn@gmail.com>
Content-Transfer-Encoding: 7bit
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Subject: Re: [PATCH v3 3/3] riscv: dts: sophgo: add zfh for sg2042
Date: Tue, 8 Jul 2025 11:20:00 +0800
Message-Id: <8468f53a-6fcf-48aa-9ed9-4ccbf82759a4@lanxincomputing.com>
Cc: "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	"Chen Wang" <unicorn_wang@outlook.com>, 
	"Inochi Amaoto" <inochiama@gmail.com>, <linux-riscv@lists.infradead.org>, 
	<sophgo@lists.linux.dev>, <linux-kernel@vger.kernel.org>

On 7/5/2025 3:00 PM, Han Gao wrote:
> sg2042 support Zfh ISA extension [1].
>
> Link: https://occ-oss-prod.oss-cn-hangzhou.aliyuncs.com/resource//1737721869472/%E7%8E%84%E9%93%81C910%E4%B8%8EC920R1S6%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C%28xrvm%29_20250124.pdf [1]
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

> ---
>   arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 128 ++++++++++----------
>   1 file changed, 64 insertions(+), 64 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> index f483f62ab0c4..77ded5304272 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> @@ -260,7 +260,7 @@ cpu0: cpu@0 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <0>;
> @@ -287,7 +287,7 @@ cpu1: cpu@1 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <1>;
> @@ -314,7 +314,7 @@ cpu2: cpu@2 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <2>;
> @@ -341,7 +341,7 @@ cpu3: cpu@3 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <3>;
> @@ -368,7 +368,7 @@ cpu4: cpu@4 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <4>;
> @@ -395,7 +395,7 @@ cpu5: cpu@5 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <5>;
> @@ -422,7 +422,7 @@ cpu6: cpu@6 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <6>;
> @@ -449,7 +449,7 @@ cpu7: cpu@7 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <7>;
> @@ -476,7 +476,7 @@ cpu8: cpu@8 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <8>;
> @@ -503,7 +503,7 @@ cpu9: cpu@9 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <9>;
> @@ -530,7 +530,7 @@ cpu10: cpu@10 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <10>;
> @@ -557,7 +557,7 @@ cpu11: cpu@11 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <11>;
> @@ -584,7 +584,7 @@ cpu12: cpu@12 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <12>;
> @@ -611,7 +611,7 @@ cpu13: cpu@13 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <13>;
> @@ -638,7 +638,7 @@ cpu14: cpu@14 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <14>;
> @@ -665,7 +665,7 @@ cpu15: cpu@15 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <15>;
> @@ -692,7 +692,7 @@ cpu16: cpu@16 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <16>;
> @@ -719,7 +719,7 @@ cpu17: cpu@17 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <17>;
> @@ -746,7 +746,7 @@ cpu18: cpu@18 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <18>;
> @@ -773,7 +773,7 @@ cpu19: cpu@19 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <19>;
> @@ -800,7 +800,7 @@ cpu20: cpu@20 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <20>;
> @@ -827,7 +827,7 @@ cpu21: cpu@21 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <21>;
> @@ -854,7 +854,7 @@ cpu22: cpu@22 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <22>;
> @@ -881,7 +881,7 @@ cpu23: cpu@23 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <23>;
> @@ -908,7 +908,7 @@ cpu24: cpu@24 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <24>;
> @@ -935,7 +935,7 @@ cpu25: cpu@25 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <25>;
> @@ -962,7 +962,7 @@ cpu26: cpu@26 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <26>;
> @@ -989,7 +989,7 @@ cpu27: cpu@27 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <27>;
> @@ -1016,7 +1016,7 @@ cpu28: cpu@28 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <28>;
> @@ -1043,7 +1043,7 @@ cpu29: cpu@29 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <29>;
> @@ -1070,7 +1070,7 @@ cpu30: cpu@30 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <30>;
> @@ -1097,7 +1097,7 @@ cpu31: cpu@31 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <31>;
> @@ -1124,7 +1124,7 @@ cpu32: cpu@32 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <32>;
> @@ -1151,7 +1151,7 @@ cpu33: cpu@33 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <33>;
> @@ -1178,7 +1178,7 @@ cpu34: cpu@34 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <34>;
> @@ -1205,7 +1205,7 @@ cpu35: cpu@35 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <35>;
> @@ -1232,7 +1232,7 @@ cpu36: cpu@36 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <36>;
> @@ -1259,7 +1259,7 @@ cpu37: cpu@37 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <37>;
> @@ -1286,7 +1286,7 @@ cpu38: cpu@38 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <38>;
> @@ -1313,7 +1313,7 @@ cpu39: cpu@39 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <39>;
> @@ -1340,7 +1340,7 @@ cpu40: cpu@40 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <40>;
> @@ -1367,7 +1367,7 @@ cpu41: cpu@41 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <41>;
> @@ -1394,7 +1394,7 @@ cpu42: cpu@42 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <42>;
> @@ -1421,7 +1421,7 @@ cpu43: cpu@43 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <43>;
> @@ -1448,7 +1448,7 @@ cpu44: cpu@44 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <44>;
> @@ -1475,7 +1475,7 @@ cpu45: cpu@45 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <45>;
> @@ -1502,7 +1502,7 @@ cpu46: cpu@46 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <46>;
> @@ -1529,7 +1529,7 @@ cpu47: cpu@47 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <47>;
> @@ -1556,7 +1556,7 @@ cpu48: cpu@48 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <48>;
> @@ -1583,7 +1583,7 @@ cpu49: cpu@49 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <49>;
> @@ -1610,7 +1610,7 @@ cpu50: cpu@50 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <50>;
> @@ -1637,7 +1637,7 @@ cpu51: cpu@51 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <51>;
> @@ -1664,7 +1664,7 @@ cpu52: cpu@52 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <52>;
> @@ -1691,7 +1691,7 @@ cpu53: cpu@53 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <53>;
> @@ -1718,7 +1718,7 @@ cpu54: cpu@54 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <54>;
> @@ -1745,7 +1745,7 @@ cpu55: cpu@55 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <55>;
> @@ -1772,7 +1772,7 @@ cpu56: cpu@56 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <56>;
> @@ -1799,7 +1799,7 @@ cpu57: cpu@57 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <57>;
> @@ -1826,7 +1826,7 @@ cpu58: cpu@58 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <58>;
> @@ -1853,7 +1853,7 @@ cpu59: cpu@59 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <59>;
> @@ -1880,7 +1880,7 @@ cpu60: cpu@60 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <60>;
> @@ -1907,7 +1907,7 @@ cpu61: cpu@61 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <61>;
> @@ -1934,7 +1934,7 @@ cpu62: cpu@62 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <62>;
> @@ -1961,7 +1961,7 @@ cpu63: cpu@63 {
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
>   					       "ziccrse", "zicntr", "zicsr",
> -					       "zifencei", "zihpm",
> +					       "zifencei", "zihpm", "zfh",
>   					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <63>;

