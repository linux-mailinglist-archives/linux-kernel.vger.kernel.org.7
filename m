Return-Path: <linux-kernel+bounces-879748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7A1C23E86
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D9054E36C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0930FC36;
	Fri, 31 Oct 2025 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hQSuJfq/"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6FE30274A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900604; cv=none; b=VwNCJuUcYfw6NOrBD2Tk36dCqzRM70P3OsnPIsYsUSB8DYTRTIQqDF353tCQwHAODAcwiPzp04MajY5Iq12x+KJyHby5fVb0EMFDDqGwgAQ/k+8xwTMK2AdtddcWSVk8Kl8dt60+7Ut2IoAWbfQOgGfettt4cuhvngWKAJZfrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900604; c=relaxed/simple;
	bh=ZYe0Qqwf/a7Fx/6/VGvQAQDoZ1jItZm5YknbzUOFHUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sg2wRnCc7NoKJEIIUV2+4ZBk1KjmFWBQ92ZTmRRBhASP4/kg+6b8EYzbVjJw3LJWoNYROgBEdXaoGrTQAl/ByrKtd76bKjj3ozIboDKc91Xblfhebxfzpbl5BfoRGofKzf7lLoGG+1qPpbe89egNMRy1EhQn8OVFARVkDoF99gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hQSuJfq/; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761900554;
	bh=gA7ZdMOFUrwORlyoHCw1cLLJwSTvXr7E+PswkD5pAyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hQSuJfq/E7xJCmOAXgX3QEXQI/aHSxghQITfUQK8c0Ij3/Bcpve/zedGbm/2gTMAY
	 K5xFcvkUHI6w89MCWpXmt03SSpyQVDZ52yr8+a8MjmWmVsbj4pMbsxtcKpWac+vUg4
	 iG/fTnTiOCLdI0feNd8bffszQIJqWKQk3yaZDzTI=
X-QQ-mid: esmtpsz19t1761900551ta93a4bd0
X-QQ-Originating-IP: R2zG6nYcmdELVDw2wE22vU78I3APWYCsFEEuPMuR4OU=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Oct 2025 16:49:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9559098418288472384
Message-ID: <2D19268A448AA783+4e165a7d-fdf1-48e8-a651-63d9a77dc823@uniontech.com>
Date: Fri, 31 Oct 2025 16:49:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251030073316.529106-1-maqianga@uniontech.com>
 <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
 <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
 <aQNvHdZcVzletjdi@MiWiFi-R3L-srv>
 <9362A6495165FCC0+d659800e-6751-4d26-a8b8-183705798e96@uniontech.com>
 <aQRv1JCoeYY4u7OX@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQRv1JCoeYY4u7OX@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NkLA2q2LD229Gp9FXUJXSXupBecfS9rlTzgIInxy/g2WKvt/h0WCE8+E
	KgBVZVUZYA/ezIQTY24XqxP5At+ejZQqWaU88ZaArKlx4gb1ctlviJYAC876lgGqm/7rznF
	87zKmCa+kjxXxS5WUCQNbuEMEz0LzBEBrTNosLEaLsPDu5IpwUaWNdoTUzSslU7TIo4i6B9
	9edEWJOLQLLoJv1o1Gw5i9IYReH3TDeR2iZgF9tXtgzw5o/6NMpdviT4fcOfHEeW4vPLbH6
	BGzfHjNy0ccKGaxosqr1MjYuGri3ifwnIgBVWMhCX/I05ZoCZp4cRwK/yjeGVrfXj0+Mlwl
	Jgl0cosouc4ECCp4Cq5Ps/NNvyrB5v9x5/YvwI5neda+eCwSMYUfrHE35Hlv8aOqmxN547R
	V3spI5WknAN5VOeawGrVWvmcgRuKtIzLXYh6HPOWDvfU4gMvQUozEh7w6PP2iwJtIkART66
	RyINkQL05BvL4i7EtFPu7lJIJKsvVFSX1X5CIfAkyHFQizHbhXEVoqslboGa9nfzBDVwyMi
	9znMU3TvuP1b+enZxQCta9kaWXjtvNIdyYfprg6qPHmiHp1x+NzDq4H/zzAEPB5oTJRJ53e
	wgxCkd1cFk44ZZxtxD8cHGl5sIBLe2G/eH7j9QwEvz1cqXcoedRH2cO7QvCarfZ5nFSt3mA
	ljEHUR9OXIku1NR3O+VK6lRD/GmyLbaXPVumYfwfx+MLIM/RfagKZaR0LvDp0Vhw2a9sAOu
	+FMnfwU/MIcWH1B9ZKyKz0D8Ml8xc0fy1jJrZETs6DDPw+8AxGBpjewwOZ3nr73eRCa/CsZ
	/mIvUKT9szRKFjjUj6AwI9nGDojMUcRYHFHU1cVGtf1ny48VimG6YI9lH7RFM+8nMVVcI7n
	Xs9WT6UZrNainrVM5cFuGXvaflkcC5SrO3Czj/yI4662U8y9xwPa+5blHxUKBtulSqF5BV0
	BZdT971QxvpobykcZxvqoeVMxuWDWD0bavKX22/KuA9BVURp6VchwscW+CDmX7x3/hBMOns
	BSGl43em2hQd+V6uSb
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0


在 2025/10/31 16:14, Baoquan He 写道:
> On 10/31/25 at 10:40am, Qiang Ma wrote:
>> 在 2025/10/30 21:58, Baoquan He 写道:
>>> On 10/30/25 at 07:41pm, Qiang Ma wrote:
>>>> 在 2025/10/30 17:42, Baoquan He 写道:
>>>>> On 10/30/25 at 03:33pm, Qiang Ma wrote:
>>>>>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>>>>>> if required") has added general code printing in kexec_file_load(),
>>>>>> but not in kexec_load().
>>>>>>
>>>>>> Especially in the RISC-V architecture, kexec_image_info() has been
>>>>>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>>>>>> message if required")). As a result, when using '-d' for the kexec_load
>>>>>> interface, print nothing in the kernel space. This might be helpful for
>>>>>> verifying the accuracy of the data passed to the kernel. Therefore, refer to
>>>>>> this commit a85ee18c7900 ("kexec_file: print out debugging message
>>>>>> if required"), debug print information has been added.
>>>>> kexec_file_dbg_print setting when CONFIG_KEXEC_FILE is set. I doubt it
>>>>> doesn't work when you unset CONFIG_KEXEC_FILE.
>>>> Yes, I just actually tested it and it really doesn't work when unset
>>>> CONFIG_KEXEC_FILE.
>>>>
>>>> In the next version, I can add a KEXEC_DEBUG for the kernel and kexec-tools.
>>> Hold on please, it may not need that highweight change. I will reply to
>>> you tomorrow if I have other idea.
>> Ok. My current idea is to refer to kexec_file, define a kexec_dbg_print,
>> initialize it in the kimage_alloc_init(), modify KEXEC_FLAGS and
>> kexec_dprintk,
>> and add the judgment of kexec_debug.
> Maybe we can unify it because kexec_file_dbg_print is declared and
> defined in CONFIG_KEXEC_CORE scope. Rename it to kexec_core_dbg_print
> and initialize it in do_kimage_alloc_init() for both, or in
> kimage_alloc_init() for kexec, and kimage_file_alloc_init() for
> kexec_file. It needs a new flag for kexec. What do you think?
I think it's okay.

I had also considered unifying a flag before, but I thought there was a 
possibility that
kexec_load and kexec_file_load could be executed simultaneously, so I 
gave up.
Later, after looking at the kexec-tools code, I found that 
kexec_file_load would be executed first.
So, it would be better to unify them into one flag.
>
> Please feel free to take it as reference, or you can go in other ways
> you have better one.
OK.
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ff7e231b0485..df33a0dd5780 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -525,10 +525,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>   #endif
>   
> -extern bool kexec_file_dbg_print;
> +extern bool kexec_core_dbg_print;
>   
>   #define kexec_dprintk(fmt, arg...) \
> -        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
> +        do { if (kexec_core_dbg_print) pr_info(fmt, ##arg); } while (0)
>   
>   extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
>   extern void kimage_unmap_segment(void *buffer);
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 28008e3d462e..570adb845662 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -42,6 +42,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
>   	if (!image)
>   		return -ENOMEM;
>   
> +	kexec_core_dbg_print = !!(flags & KEXEC_DEBUG);
>   	image->start = entry;
>   	image->nr_segments = nr_segments;
>   	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index fa00b239c5d9..3af3ba77a3bd 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -619,6 +619,7 @@ void kimage_free(struct kimage *image)
>   	if (image->file_mode)
>   		kimage_file_post_load_cleanup(image);
>   
> +	kexec_core_dbg_print = false;
>   	kfree(image);
>   }
>   
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index eb62a9794242..4a24aadbad02 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -138,8 +138,6 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>   	 */
>   	kfree(image->image_loader_data);
>   	image->image_loader_data = NULL;
> -
> -	kexec_file_dbg_print = false;
>   }
>   
>   #ifdef CONFIG_KEXEC_SIG
> @@ -314,7 +312,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
>   	if (!image)
>   		return -ENOMEM;
>   
> -	kexec_file_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
> +	kexec_core_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
>   	image->file_mode = 1;
>   
>   #ifdef CONFIG_CRASH_DUMP
>
>

