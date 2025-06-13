Return-Path: <linux-kernel+bounces-684989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE5AD82B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 07:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E2B1895A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 05:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B624DD19;
	Fri, 13 Jun 2025 05:50:38 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2912F4311;
	Fri, 13 Jun 2025 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749793838; cv=none; b=MVre9djN1M1bYYDew/ZP69j2H0jlW+fWz1z/jqcNGjgQVibgEhZ7/SgsuoiPSa2FGpZomTXOQaAng1dFiEEiQvQiKzmWizVTuJIN774hOYXGvRWTdjMYRgxt68JxiAHGNoCwUyPIEad/WMHVd0m/RjQGPRGzOtwsEqE8L1qyfKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749793838; c=relaxed/simple;
	bh=PLXV5ThJae5rpotMvP30DQ6gK0ULxmZ8RCmVFST+fQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKOernF+CnpI8QFiOrvBj+bz1scFmWh8sQrTGhIvDMad2XjzU6MZs1WFohawQtEssikwbH7jf9EZ5unIeAwRUkR+aDucN1rnStW1Ar+FSssEZsRjhpKdKJCtBEWjcAsHiMHrxeiCOoP1Hgp188zXa1N06iZyjmaU3X+krk+d66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bJSWh2cG0z9sr6;
	Fri, 13 Jun 2025 07:24:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i2R_EYZAecGn; Fri, 13 Jun 2025 07:24:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bJSWh1b2mz9s9J;
	Fri, 13 Jun 2025 07:24:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2717A8B77B;
	Fri, 13 Jun 2025 07:24:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kX2jN5-6A6AJ; Fri, 13 Jun 2025 07:24:48 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7DDBA8B769;
	Fri, 13 Jun 2025 07:24:47 +0200 (CEST)
Message-ID: <fa8c0bca-a127-410e-9b13-3fa5ea7d8110@csgroup.eu>
Date: Fri, 13 Jun 2025 07:24:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: pcm: Convert snd_pcm_ioctl_sync_ptr_{compat/x32} to
 user_access_begin/user_access_end()
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, Herve Codina <herve.codina@bootlin.com>,
 Mark Brown <broonie@kernel.org>
References: <8df11af98033e4cb4d9b0f16d6e9d5b69110b036.1749724057.git.christophe.leroy@csgroup.eu>
 <87wm9hte77.wl-tiwai@suse.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <87wm9hte77.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/06/2025 à 13:02, Takashi Iwai a écrit :
> On Thu, 12 Jun 2025 12:39:39 +0200,
> Christophe Leroy wrote:
>>
>> With user access protection (Called SMAP on x86 or KUAP on powerpc)
>> each and every call to get_user() or put_user() performs heavy
>> operations to unlock and lock kernel access to userspace.
>>
>> SNDRV_PCM_IOCTL_SYNC_PTR ioctl is a hot path that needs to be
>> optimised. To do that, perform user accesses by blocks using
>> user_access_begin/user_access_end() and unsafe_get_user()/
>> unsafe_put_user() and alike.
>>
>> Before the patch the 9 calls to put_user() at the
>> end of snd_pcm_ioctl_sync_ptr_compat() imply the following set of
>> instructions about 9 times (access_ok - enable user - write - disable
>> user):
>>      0.00 :   c057f858:       3d 20 7f ff     lis     r9,32767
>>      0.29 :   c057f85c:       39 5e 00 14     addi    r10,r30,20
>>      0.77 :   c057f860:       61 29 ff fc     ori     r9,r9,65532
>>      0.32 :   c057f864:       7c 0a 48 40     cmplw   r10,r9
>>      0.36 :   c057f868:       41 a1 fb 58     bgt     c057f3c0 <snd_pcm_ioctl+0xbb0>
>>      0.30 :   c057f86c:       3d 20 dc 00     lis     r9,-9216
>>      1.95 :   c057f870:       7d 3a c3 a6     mtspr   794,r9
>>      0.33 :   c057f874:       92 8a 00 00     stw     r20,0(r10)
>>      0.27 :   c057f878:       3d 20 de 00     lis     r9,-8704
>>      0.28 :   c057f87c:       7d 3a c3 a6     mtspr   794,r9
>> ...
>>
>> A perf profile shows that in total the 9 put_user() represent 36% of
>> the time spent in snd_pcm_ioctl() and about 80 instructions.
>>
>> With this patch everything is done in 13 instructions and represent
>> only 15% of the time spent in snd_pcm_ioctl():
>>
>>      0.57 :   c057f5dc:       3d 20 dc 00     lis     r9,-9216
>>      0.98 :   c057f5e0:       7d 3a c3 a6     mtspr   794,r9
>>      0.16 :   c057f5e4:       92 7f 00 04     stw     r19,4(r31)
>>      0.63 :   c057f5e8:       93 df 00 0c     stw     r30,12(r31)
>>      0.16 :   c057f5ec:       93 9f 00 10     stw     r28,16(r31)
>>      4.95 :   c057f5f0:       92 9f 00 14     stw     r20,20(r31)
>>      0.19 :   c057f5f4:       92 5f 00 18     stw     r18,24(r31)
>>      0.49 :   c057f5f8:       92 bf 00 1c     stw     r21,28(r31)
>>      0.27 :   c057f5fc:       93 7f 00 20     stw     r27,32(r31)
>>      5.88 :   c057f600:       93 36 00 00     stw     r25,0(r22)
>>      0.11 :   c057f604:       93 17 00 00     stw     r24,0(r23)
>>      0.00 :   c057f608:       3d 20 de 00     lis     r9,-8704
>>      0.79 :   c057f60c:       7d 3a c3 a6     mtspr   794,r9
>>
>> Note that here the access_ok() in user_write_access_begin() is skipped
>> because the exact same verification has already been performed at the
>> beginning of the fonction with the call to user_read_access_begin().
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> This is a lighter version of previous patch "[PATCH v2] ALSA: pcm: Convert multiple {get/put}_user to user_access_begin/user_access_end()" focussing on identified hot path.
>> Moved and nested the failure labels closer in order to increase readability
> 
> Thanks for the revised patch!
> 
> Although it's now much lighter, I still believe that we can reduce
> get_user() / put_user() calls significantly by adjusting the struct
> usage.
> 
> Could you check whether the patch below can improve?
> (Zero-ing of sstatus can be an overhead here, but there are some
> holes, and these need to be initialized before copying back...)
> 

Thanks for the proposed patch. Unfortunately it doesn't improve the 
situation. The problem with copy_from_user() and copy_to_user() is that 
they perform quite bad on small regions. And for the from_user side we 
still get two user access enable/disable instead 3 and for the to_user 
side we still get two as well (Allthough we had 7 previously). Those 4 
user access enable/disable still have a cost.

Nowadays the tendency is really to go for the unsafe_put/get_user style, 
see some significant exemples below. And as mentioned in those commits, 
behind the performance improvement it also lead to much cleaner code 
generation.
- 38ebcf5096a8 ("scm: optimize put_cmsg()")
- 9f79b78ef744 ("Convert filldir[64]() from __put_user() to 
unsafe_put_user()")
- ef0ba0553829 ("poll: fix performance regression due to out-of-line 
__put_user()")

Commit 38ebcf5096a8 is explicit about copy_to_user() being bad for small 
regions.

Here below is some comparison between the three way of doing 
snd_pcm_ioctl_sync_ptr_compat(), output is from 'perf top':

Initially I got the following. That 12%+ is the reason why I started 
investigating.

     14.20%  test_perf           [.] engine_main
==> 12.86%  [kernel]            [k] snd_pcm_ioctl
     11.91%  [kernel]            [k] finish_task_switch.isra.0
      4.15%  [kernel]            [k] snd_pcm_group_unlock_irq.part.0
      4.07%  libc.so.6           [.] __ioctl_time64
      3.58%  libasound.so.2.0.0  [.] __snd_pcm_mmap_begin_generic
      3.37%  [kernel]            [k] sys_ioctl
      2.96%  libasound.so.2.0.0  [.] snd_pcm_hw_avail_update
      2.73%  libasound.so.2.0.0  [.] __snd_pcm_mmap_begin
      2.58%  [kernel]            [k] system_call_exception
      1.93%  libasound.so.2.0.0  [.] sync_ptr1
      1.85%  libasound.so.2.0.0  [.] snd_pcm_unlock
      1.84%  libasound.so.2.0.0  [.] snd_pcm_mmap_begin
      1.83%  libasound.so.2.0.0  [.] bad_pcm_state
      1.68%  libasound.so.2.0.0  [.] snd_pcm_mmap_avail
      1.67%  libasound.so.2.0.0  [.] snd_pcm_avail_update

With _your_ patch I get the following. copy_from_user() calls 
_copy_from_user() and copy_to_user() calls _copy_to_user(). Both then 
call __copy_tofrom_user(). In total it is 16.4% so it is worse than before.

     14.47%  test_perf           [.] engine_main
     12.00%  [kernel]            [k] finish_task_switch.isra.0
==>  8.37%  [kernel]            [k] snd_pcm_ioctl
      5.44%  libc.so.6           [.] __ioctl_time64
      5.03%  [kernel]            [k] snd_pcm_group_unlock_irq.part.0
==>  4.86%  [kernel]            [k] __copy_tofrom_user
      4.62%  [kernel]            [k] sys_ioctl
      3.22%  [kernel]            [k] system_call_exception
      2.42%  libasound.so.2.0.0  [.] snd_pcm_mmap_begin
      2.31%  [kernel]            [k] fdget
      2.23%  libasound.so.2.0.0  [.] __snd_pcm_mmap_begin_generic
      2.19%  [kernel]            [k] syscall_exit_prepare
      1.92%  libasound.so.2.0.0  [.] snd_pcm_mmap_avail
      1.86%  libasound.so.2.0.0  [.] __snd_pcm_mmap_begin
      1.68%  libasound.so.2.0.0  [.] snd_pcm_hw_avail_update
==>  1.67%  [kernel]            [k] _copy_from_user
      1.66%  libasound.so.2.0.0  [.] bad_pcm_state
==>  1.53%  [kernel]            [k] _copy_to_user
      1.40%  libasound.so.2.0.0  [.] sync_ptr1

With my patch I get the following:

     17.46%  test_perf           [.] engine_main
      9.14%  [kernel]            [k] finish_task_switch.isra.0
==>  4.92%  [kernel]            [k] snd_pcm_ioctl
      3.99%  [kernel]            [k] snd_pcm_group_unlock_irq.part.0
      3.71%  libc.so.6           [.] __ioctl_time64
      3.61%  libasound.so.2.0.0  [.] __snd_pcm_mmap_begin_generic
      2.72%  libasound.so.2.0.0  [.] sync_ptr1
      2.65%  [kernel]            [k] system_call_exception
      2.46%  [kernel]            [k] sys_ioctl
      2.43%  [kernel]            [k] __rseq_handle_notify_resume
      2.34%  [kernel]            [k] do_epoll_wait
      2.30%  libasound.so.2.0.0  [.] __snd_pcm_mmap_commit
      2.14%  libasound.so.2.0.0  [.] __snd_pcm_avail
      2.04%  libasound.so.2.0.0  [.] snd_pcm_hw_avail_update
      1.89%  libasound.so.2.0.0  [.] snd_pcm_lock
      1.84%  libasound.so.2.0.0  [.] snd_pcm_mmap_avail
      1.76%  libasound.so.2.0.0  [.] __snd_pcm_avail_update
      1.61%  libasound.so.2.0.0  [.] bad_pcm_state
      1.60%  libasound.so.2.0.0  [.] __snd_pcm_mmap_begin
      1.49%  libasound.so.2.0.0  [.] query_status_data

Christophe


