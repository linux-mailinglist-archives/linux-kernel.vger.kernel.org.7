Return-Path: <linux-kernel+bounces-789115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049A9B3915D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D642035F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6B81F5619;
	Thu, 28 Aug 2025 02:01:22 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E446FC5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346481; cv=none; b=FSrLSukjyhVT7ftKcFKRo65rPcTe3ODYfeSk3D7S2YpZy3UHradnm8NjGBk2mB2sWxskw2Ye9tV1R6o8EDE0RY/DaxmKPDRdcAvusDl2962/lOYWt2NPlPEHFepJ9W+kMgSh6Lr9dNKpLIBH4NrXcb6e1s0VuT5Cd7zL1P72tQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346481; c=relaxed/simple;
	bh=TigdDZ2vjd5XAmkE43dn0B8bK1m3zMpqhjPGZHh0N1g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aSINb96vA8aBPHPZyIncxUoxmzIOyapAXNOw3nI18fCM7dLFBM+55VHtR7BxfJWSQRnxhvSZOLXGLejO0z6NX48GY8oAhvG3sr7WTKAjWVyw7i2G0Y+7ZpgPs1hyk4/oXme07I7cmVDJSHyLn+gMVDajPP97Mj5FmneO6ADUBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxJ9FpuK9o8QEEAA--.7986S3;
	Thu, 28 Aug 2025 10:01:13 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxZORouK9ov3ttAA--.12568S3;
	Thu, 28 Aug 2025 10:01:13 +0800 (CST)
Subject: Re: [RFC PATCH 1/2] objtool/LoongArch: Fix fall through warning about
 efi_boot_kernel()
To: Josh Poimboeuf <jpoimboe@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250826064631.9617-1-yangtiezhu@loongson.cn>
 <20250826064631.9617-2-yangtiezhu@loongson.cn>
 <CAAhV-H5wW_04NHQ7z+SCPb6-T5Hc__n+x=ykg-u9vn4b4GXuww@mail.gmail.com>
 <487a8149-6cbe-46a7-6771-66aef0045f07@loongson.cn>
 <CAAhV-H7m-BSqajDiDNMNEq4FY9uoCd9LZySOe0VQ+2Sv1wZZVg@mail.gmail.com>
 <xyrcgkl7ud5pgh4h5yjyejz646bc22fnnwxahaoafqvnqintf3@mdhtfaybai67>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f2604180-3416-9ee4-9617-6939199879e4@loongson.cn>
Date: Thu, 28 Aug 2025 10:01:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xyrcgkl7ud5pgh4h5yjyejz646bc22fnnwxahaoafqvnqintf3@mdhtfaybai67>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxZORouK9ov3ttAA--.12568S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZFWxuw1rGryUtr45GF1rGrX_yoWDZrbE9F
	ZruF47Kw4fWrZ09w43Gr4rtF98tryUGr98ZrWDXrs0kF15XFZ8Kan7Kr1kZw1Yqa98A3WD
	Krs5AasFqFW29osvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==

On 2025/8/27 上午7:39, Josh Poimboeuf wrote:
> On Tue, Aug 26, 2025 at 09:03:34PM +0800, Huacai Chen wrote:

...

>> Then I think objtool needs to be improved to handle this case, this
>> problem is not arch specific.
> 
> Yeah, objtool should really be ignoring this code altogether.  On x86,
> that's not a problem because the EFI stub code isn't linked into
> vmlinux.o.  It gets linked in separately:
> 
>    $ git grep vmlinux-libs
>    arch/x86/boot/compressed/Makefile:vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>    arch/x86/boot/compressed/Makefile:vmlinux-libs-$(CONFIG_X86_64) += $(objtree)/arch/x86/boot/startup/lib.a
>    arch/x86/boot/compressed/Makefile:$(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
> 
> IMO, the proper fix is to change the loongarch build to do the same.
> vmlinux.o is intended to be proper kernel code.

Thank you very much, that is to say, these EFISTUB functions can be
ignored by objtool, I will do it.

Thanks,
Tiezhu


