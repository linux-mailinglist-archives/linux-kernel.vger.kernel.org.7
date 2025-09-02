Return-Path: <linux-kernel+bounces-796509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCCB401BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73A7189AD2E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AC22DCF75;
	Tue,  2 Sep 2025 12:56:27 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69632DC341;
	Tue,  2 Sep 2025 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817787; cv=none; b=dkxVy2BoDa8SVq0RAOkmW3M79y1DD2IkP3qMsQhI88V/MVmnsBvAk2ioSdMCI+iCzdBCpBA1CYIZE/w8F2RoasoXiopUCJy+nfPA+L+by20s+mzzC27ydn8DuCkhx+Sx/G+8MtNlrF/PUBsFwJHId+dMfqdxCq32xicJhdCUOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817787; c=relaxed/simple;
	bh=zGRm1e38+MeEY4LTBUqYwnefUDpCHsdS90DbkrgN4W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJZu3HTtkC+MWVmUEg9M6CgICVTyWA5iKS6B9nfP9BXl+0ggqVyFYrTUXDUKKp+AW6OqsK0YwFpfVC/oAJG20a7snpUgCX/uWOaZMoaCu3VP/nj0eSLX3BmKhc7C0QZtlUCv1qacAI8XrHiqdJFSuAkHRZC429rh51YpGgFazpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.104] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowAAnf19E6bZoJf+7EA--.3611S2;
	Tue, 02 Sep 2025 20:55:32 +0800 (CST)
Message-ID: <680534b4-27e7-4506-885a-1c3dc9d12b8b@iscas.ac.cn>
Date: Tue, 2 Sep 2025 20:55:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: dts: spacemit: uart: remove sec_uart1 device
 node
To: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250902-02-k1-uart-clock-v2-1-f146918d44f6@gentoo.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250902-02-k1-uart-clock-v2-1-f146918d44f6@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAAnf19E6bZoJf+7EA--.3611S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1rKFWUGFyfGw1DGry8Zrb_yoW8GF18pa
	y7urZ3ArWfAF109FsrXw12krWrtrZYgFyS9F1UCr15GanIqayxKrZ3tr18ZF18Zwn5Aw1j
	gws5Xwn7WF4Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07betCcUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 9/2/25 20:26, Yixun Lan wrote:
> [...]
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index abde8bb07c95c5a745736a2dd6f0c0e0d7c696e4..3094f75ed13badfc3db333be2b3195c61f57fddf 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -777,16 +777,7 @@ uart9: serial@d4017800 {
>  				status = "disabled";
>  			};
>  
> -			sec_uart1: serial@f0612000 {
> -				compatible = "spacemit,k1-uart",
> -					     "intel,xscale-uart";
> -				reg = <0x0 0xf0612000 0x0 0x100>;
> -				interrupts = <43>;
> -				clock-frequency = <14857000>;
> -				reg-shift = <2>;
> -				reg-io-width = <4>;
> -				status = "reserved"; /* for TEE usage */
> -			};
> +			/* sec_uart1: 0xf0612000, not available from Linux */

I know this is going back and forth a lot but I don't think that's a
good description of what's going on.

My preference is that we just drop this node altogether, just forgetting
that this thing even exists. But if you do think we want to keep the
information we can drop the clock-frequency property too and change its
status to something like:

  status = "disabled"; /* No clock defined */

Which also silences the warning - disabled nodes are allowed to be
incomplete.

My personal opinion is that I think sec_uart1 and TEE support feels too
theoretical to be worth caring about.

Vivian "dramforever" Wang


