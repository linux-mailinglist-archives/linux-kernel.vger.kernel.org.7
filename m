Return-Path: <linux-kernel+bounces-798275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0AAB41BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384097AC125
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2302E8E01;
	Wed,  3 Sep 2025 10:19:50 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5C27056A;
	Wed,  3 Sep 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894789; cv=none; b=qr/ABzE3VPbhCwQENnGRuigVsYxWxVV+3J9LXPbW9ppSriNWX5UCsTyGyRjT2V/hsvKYVKhV4k5Yx+y7uhsZIBbacD6zLZf6DCNcaz+BbAHq3b0FeX4grSQAj7BRjPgbMYsBK6GRgMjB1lZdxvYUox1ChE1U9MMtCiPKuV/xkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894789; c=relaxed/simple;
	bh=PLR5CEMrnGUffbfzrN013g8lieSo4iNkmltjgQs9v9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elCqMyaF3aUj8SwXemkE82fkUuKCP3lBx3wDPzqHPVKTapwh8vRbRiElydG5dMQmRfOadS1JxGgPDKsuy8xnmDCSwGy+NRhmojnbg22J0G/nMfiyxXuWPhvX3WeSl+2jLHyiB+aEXBTtOnDxAtah0rfxJ/OB/Cv6yGgvxCdiHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 85E50B22027F;
	Wed,  3 Sep 2025 12:19:44 +0200 (CEST)
Message-ID: <067174f5-32ea-45df-9a48-96222850e813@freeshell.de>
Date: Wed, 3 Sep 2025 03:19:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: jh7110-common: drop no-mmc
 and power-on-delay-ms from mmc interfaces
To: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org
References: <20250903101346.861076-1-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250903101346.861076-1-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/3/25 03:13, E Shattow wrote:
> Drop no-mmc and power-on-delay-ms properties.
> 
> The committer cannot be reached for comment and per discussion [1] and
> testing there is not any observable problem that is being solved by
> having these properties for the VisionFive 2 or similar variant boards
> through the jh7110-common.dtsi include.
> 
> E Shattow (2):
>   riscv: dts: starfive: jh7110-common: drop no-mmc property from mmc1
>   riscv: dts: starfive: jh7110-common: drop mmc post-power-on-delay-ms
> 
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
> 
> 
> base-commit: f66eb149b87677da3171a0ed51c77c3599ad55d6

P.S. missed the URL for reference [1] in this cover letter. It is:

1:
https://lore.kernel.org/lkml/NT0PR01MB1312E0D9EE9F158A57B77700E63D2@NT0PR01MB1312.CHNPR01.prod.partner.outlook.cn/

