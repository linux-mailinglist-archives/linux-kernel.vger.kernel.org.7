Return-Path: <linux-kernel+bounces-799828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08778B430B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E70564496
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051F1227B95;
	Thu,  4 Sep 2025 03:58:02 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D501225408;
	Thu,  4 Sep 2025 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958281; cv=none; b=kAo9L4DdmsbFZxWKW6Uraskt5Jw0w/BTsWsxBeCcD29CSG4M3XRmNpz0ysQ21pfuYn7NXDbx2cCnRNOTH9tmseKfHPtN7f9cRBlieXyWkU4WrSri5Q+Q4q43xayS8KDx9w6yaxMkiCJ+QNVLpneQV4K99zeH44t9Kpg7IUBL62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958281; c=relaxed/simple;
	bh=LskN02oGF6K9NkRXt9/egMAiW7/vq5nT6pjQu7Rh3q4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z97fv0AOQeAVToUCVkc+EptWre+InbV6DzunpCUJ3qCb+zqrsMDpb0sUB0hjYrlW2QcRS51uhFuXyyNqRuyFTF4aRDVgpTgkC2lLwAWstYjk5uxjs/U+suSis3gegmW3LkUXGJMSzW+ggWgeFWb/6HMW/CefEF3jADEqI0/EaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxLvBFDrloqoEGAA--.13764S3;
	Thu, 04 Sep 2025 11:57:57 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxjcFDDrloIAd9AA--.12932S3;
	Thu, 04 Sep 2025 11:57:56 +0800 (CST)
Subject: Re: [RFC PATCH 3/3] LoongArch: Handle table jump option for RUST
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250903095315.15057-1-yangtiezhu@loongson.cn>
 <20250903095315.15057-4-yangtiezhu@loongson.cn>
 <CANiq72n5hg-ZyGV4oEca9iCbmQByanFUpNTkS=QmE1k8MUBR8w@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e9e9b127-3237-92d1-891c-84fc5e6bfcdd@loongson.cn>
Date: Thu, 4 Sep 2025 11:57:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANiq72n5hg-ZyGV4oEca9iCbmQByanFUpNTkS=QmE1k8MUBR8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxjcFDDrloIAd9AA--.12932S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW3XF15GrW5Ww47Wr1xJFc_yoW8CF4Dpa
	yUJasrGrs8JFyktFZrG3yjgayftrZxG3WIqw4rG34rAay5Zr1FqFWjqF43uFZxZw4kJayY
	va18tryUuayjyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8QJ57UU
	UUU==

On 2025/9/3 下午6:28, Miguel Ojeda wrote:
> On Wed, Sep 3, 2025 at 11:53 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> When compiling with LLVM and CONFIG_RUST is set, there exist objtool
>> warnings "sibling call from callable instruction with modified stack
>> frame" in rust/core.o and rust/kernel.o.
> 
> Thanks for fixing this! I have seen it for a long time in my CI:
> 
> I think this is:
> 
>      Reported-by: Miguel Ojeda <ojeda@kernel.org>
>      Closes: https://lore.kernel.org/rust-for-linux/CANiq72mNeCuPkCDrG2db3w=AX+O-zYrfprisDPmRac_qh65Dmg@mail.gmail.com/
> 
> Perhaps consider adding an example of the warning in the log for
> future Lore searches:
> 
>      rust/core.o: warning: objtool:
> _RNvXs1_NtNtCs5QSdWC790r4_4core5ascii10ascii_charNtB5_9AsciiCharNtNtB9_3fmt5Debug3fmt+0x54:
> sibling call from callable instruction with modified stack frame

OK, will update the commit message in the next version.

>> (1) Please install rustc 1.78.0 (without annotate-tablejump option) or
>> 1.87.0 (with annotate-tablejump option), do not use the latest version
>> for now, otherwise there may be build error:
> 
> Nightly is not a released version, and it is expected that it breaks
> from time to time. Even beta may break. We are ~2 months away from
> that release.
> 
> In any case, I don't think this information is related to this commit.

OK, I will remove the above info in the commit message.

>> +config RUSTC_HAS_ANNOTATE_TABLEJUMP
>> +       depends on RUST
>> +       def_bool $(rustc-option,-Cllvm-args=--loongarch-annotate-tablejump)
> 
> I think this may be fine given it is `-Cllvm-args` and anyway
> LoongArch doesn't use a `target.json` (which is great!), but please
> double-check reading what I wrote in 46e24a545cdb ("rust:
> kasan/kbuild: fix missing flags on first build") just in case.

OK, will do.

Thanks,
Tiezhu


