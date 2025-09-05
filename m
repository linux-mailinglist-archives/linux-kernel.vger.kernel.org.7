Return-Path: <linux-kernel+bounces-803100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA9B45A88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331D77C3EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D5E36CE14;
	Fri,  5 Sep 2025 14:30:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C54B661
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082645; cv=none; b=WqEBIucVrJeL4T9sY7fX3UTV4pz41xxObnLuhPKRwkNhPgsg4jmvfB691kEKcxzVIsz4psF8Npk8z2AKNzyK1n/36dWCl/W3TZqyCZjcXFxh8femMoAqZlgnrCjSeeiBjr3t11UZVq+ZYtREC2LrtzI6xCzqGbBektX6/GsVpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082645; c=relaxed/simple;
	bh=bp7jfPlhfqWV5KygpcPcj7AHilzNFkOJ0PC1mt21yBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvDB9z4X5LNF3xsDVLHgHIAnezn+Zc8x9Kjj/FcUmm7aaTkfhzeomgOyS00B8AbvLdi0/B4dBkEQsrp5rdUkRVCo/FsLPd7SZv7q38hWz+wsKBgFpY7T9owRMiW+FmiKvAgql1LZPuZoQiD7gJEVqyKMucxfDwNZAaoxYvLP4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80D56152B;
	Fri,  5 Sep 2025 07:30:33 -0700 (PDT)
Received: from [10.57.57.155] (unknown [10.57.57.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3823F63F;
	Fri,  5 Sep 2025 07:30:39 -0700 (PDT)
Message-ID: <cc9b8e02-e287-40c8-ad9c-34efd5e5e3f6@arm.com>
Date: Fri, 5 Sep 2025 15:30:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] arm64: KASAN + KASLR may cause reserved page to be released
 during module loading
To: =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 =?UTF-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
 =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
 <chinwen.chang@mediatek.com>, =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?=
 <casper.li@mediatek.com>, "andreyknvl@google.com" <andreyknvl@google.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "dvyukov@google.com" <dvyukov@google.com>,
 "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <6065525d47bf338646d53182b9bbc4a25ccfda82.camel@mediatek.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <6065525d47bf338646d53182b9bbc4a25ccfda82.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 04/08/2025 15:03, Qun-wei Lin (林群崴) wrote:
> Hi,
>   
> We have encountered a kernel panic on arm64 when loading modules with
> both KASAN and KASLR enabled.
>   
> Kernel version:
> 6.12
> (also reproducible on 6.6-based Android common kernel)
>   
> Config:
> CONFIG_KASAN=y
> CONFIG_KASAN_GENERIC=y
> CONFIG_KASAN_VMALLOC=y
> CONFIG_RANDOMIZE_BASE=y
> # CONFIG_RANDOMIZE_MODULE_REGION_FULL is not set
>   
> Reproducible:
> ~50% of the time, when loading any module with Generic KASAN + KASLR
> enabled.
>   
> The kernel panic log is as follows:
> [...]
> Comm:kworker/4:1 Tainted: G          OE      6.12.23-android16-5-
> g1e57f0e5996f-4k #1 eee834a579887c0f97d696d30c786233f4fbfcdf
> [...]
>
> If I disable KASLR, the issue does not occur.
With the context provided I was not able to reproduce the issue
when testing defconfig + generic KASAN on the following kernels :
- v6.17-rc4
- v6.12.23 Upstream
- v6.12.23 Android[0]
- v6.12.23 Upstream, compiled with LLVM
- v6.12.23 Android[0], compiled with LLVM

(I tried to match the version that appears in your trace)

I tested on both QEMU/KVM and hardware (AMD Seattle), by loading
and unloading an out-of-tree kernel module repeatedly (an APFS driver[1]),
with no issues on either for all tested kernels.
>   
> We are not certain which specific patch introduced this issue, but we
> have confirmed that it does not occur on the Android common kernel 6.1
> The problem was first observed after upgrading to 6.6-based kernels.
>   
> Any suggestions or guidance would be appreciated.
> Thank you.
There's not much information to go off of here, my questions would be :
- Are you able to reproduce on an upstream kernel ?
   (Be it from kernel.org or a "base" Android kernel, like [0])
- Are you able to reproduce under publicly available emulators ?
- Are you able to reproduce with specific, public modules ?
   (Something available in Debian[2] for example)
- Which compiler and version are you using ?

It is a bit of work, I'm aware, but given I didn't manage to reproduce
the issue, it would be useful to have as much info on the context
so either we might be able to reproduce, or you might be able to
pinpoint the source on your side a bit better !

I have not seen any other reports since yours, nor did I see any patch/fix
that seemed relevant, so I don't have much more to suggest sadly ;
others might.
> Best Regards,
>   
>   
> 林群崴 (Qun-wei Lin)
> Qun-wei.Lin@mediatek.com
Thanks in advance,
Best regards
Ada


[0]: 
https://android.googlesource.com/kernel/common/+/refs/tags/android16-6.12-2025-06_r5
[1]: https://github.com/linux-apfs/linux-apfs-rw/
[2]: 
https://packages.debian.org/search?keywords=-dkms&searchon=names&suite=trixie&section=all


