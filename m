Return-Path: <linux-kernel+bounces-807144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5576B4A0B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A48B3BAD9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077F82E8E11;
	Tue,  9 Sep 2025 04:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chMg5T3M"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807E2E7BBB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757392183; cv=none; b=NtvxadmOhWMepZ+3zShlaBl0jC9TkzRe29mbALIuwVbw4o9zmpCf7XTmtET3vZO+ql5+TSS4nAIMRQwV6N13QLMIvIYdl9XZe3G9h0HZrayFXkL77ndUDYn9iLb0Zdl1nCaFAvnu35KRcBtW1rHtEAbhnrq3xv6aebHgDi/qmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757392183; c=relaxed/simple;
	bh=wlDl/z3Wfe7oY/Za0TV8ehzNWlmcKUKYyOV2KwWV2g8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:Date:References:
	 MIME-version:Content-type; b=ZvtHdbdA85Liyydin+zlGWaU4d6GIIOJa1EzPQ3hkHt1cndtUswvvJx8lF9fyHIPhbGV+PjYmTZ2r0OdQuqtJIlpGYhIIho8ynodiIp7HUM2yEcfTXWnaFQ4bmbE+oSKGsVyn/lkvRgDJ6Bue6ihjWNVuoTaUZ9jwwAdhFwiWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chMg5T3M; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32d3e17d925so2637034a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757392181; x=1757996981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:date:in-reply-to
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7D2bi71vwp5Z+uAz0dSLBbl6cdWmIMR937pxBRWdSck=;
        b=chMg5T3MahrU8SYX03GcrbFn5JEnZyAqnHSKOUzYKvQJv3s2LgBv3TeJSL+9/CByc9
         VUhleoe8205076oInpRT/+4nMRO6BCaTZuyg8S8Q5sQCh752Gjr/a5xZVuknJLv+hdXf
         uQdh+Hz0Y44NyYqEvbkj+0r68d+7YzqWVEtCq/N/cM12HN4F1zkSQ+PXj8rL4ArQxcnE
         h5JFAa1p801a+9UOqPrjK6zYNsO77NNkdlHH1ULIi0spOtvD86PzDbCqKmGbnAT9QK6Y
         C0P+0ZT5I8RBmtuu8IhXnjP06ZljQTm22SNouVFy0qUF0oGfZEfztqLsr/0dhR/kVB19
         7Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757392181; x=1757996981;
        h=content-transfer-encoding:mime-version:references:date:in-reply-to
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7D2bi71vwp5Z+uAz0dSLBbl6cdWmIMR937pxBRWdSck=;
        b=r8FUBiyBJRswtT9ZPcWoRCoVHiBQ2hMRgjWumAMG8uasdUSgS8LqlgjRbM48HUT6tR
         +x1poyktVfbwDJ2WapRXIsN+fgNj9hZ7wRgvysW7afkbdytazddf7jwG1ImzQ3qS6sz0
         qIb1bUqCLWZiZ6AkH+A5CdIyMtpDvk4o7v6iBMOLqY2NAw9SfGlGYmFMRJLgSoIWYF7f
         0KKQMhk2DAiZVk9+reUultZsbgS8JwYta2P1giVMyb+WJbIC+RsfcpKGD/I5UycX5uXO
         HUufdbUuvxMMnNQ1BPZ1lHN/slwDNC6bS9jfykPqq1+zTclf0tlsdPrzWfXOWUhPr/wi
         SqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4m7JbCRYb3Ll7Znl2kHVvlqYI0sMIuhwcxBmC1YRlxkRj9xwLMGDjw85k13qU/MpF/zWtpvt3kYDUiTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+IBxSMBCowA1J1A1eYJBpg1qwZWawyZbDR6Si23u17z7amuZ
	BcJnfqqmwg6g9l5/DE3HnPKHw60LFYcYraHcRs2IL2EyCsM8UzvKL1N/
X-Gm-Gg: ASbGncvXVKu0blT3tTE6Hfpour4MEPs7N/sq7mSISCLIJv6JKddaPfFixAlSgGBPSwC
	9p22mEykV5ZppcP0mR5kiKNwJnqYZRlL4r+LhwL7QBMMwGP92Z76TQ2szPYOo85fX9oFz+qWXqg
	0GlgexiKOX/7t3OjQknv27NuKEKgGYzO1QDml/3MWLYWkFMzRRaD+AIpEPgVfwvA9w151MY0wnl
	GN4DFTwJal8ulZJ2UF1ABOVAa9QY4PmJLc0pWME4vPlC+CK2SWZzMBg18RYOTulG08mn1vEj79n
	NTUiYaJScCYAjRHZgDipgGkUTqMh378jwsn6CQUgK4AKj/sTjnPiFfF5W6I1rAqruPuJSS56GcF
	dTzp50IYodSut0QS/Cw9qDXQ=
X-Google-Smtp-Source: AGHT+IFdK6fLaLgogFPfbeB2d8GqAvdbQiFLhXyzpb13yaxe1K8FG8K0ORFErBwLC+GrYHsNikFjaw==
X-Received: by 2002:a17:90a:c110:b0:32d:3e1a:79e1 with SMTP id 98e67ed59e1d1-32d43f05670mr12836787a91.8.1757392180794;
        Mon, 08 Sep 2025 21:29:40 -0700 (PDT)
Received: from dw-tp ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466290ac3sm584666b3a.59.2025.09.08.21.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:29:40 -0700 (PDT)
Message-ID: <68bfad34.050a0220.11f3f7.19c5@mx.google.com>
X-Google-Original-Message-ID: <87o6rke2ja.fsf@ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com
Cc: npiggin@gmail.com, rostedt@goodmis.org, ardb@kernel.org, Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH RFC] powerpc: Panic on jump label code patching failure
In-Reply-To: <1b4cc6d5-5f5b-4b39-8fdf-ac02c94cd5e2@csgroup.eu>
Date: Tue, 09 Sep 2025 08:49:05 +0530
References: <20250905061135.1451362-1-ajd@linux.ibm.com> <87qzwki6fv.fsf@ritesh.list@gmail.com> <1b4cc6d5-5f5b-4b39-8fdf-ac02c94cd5e2@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 06/09/2025 à 05:52, Ritesh Harjani a écrit :
>> [Vous ne recevez pas souvent de courriers de riteshh@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>> 
>> Andrew Donnellan <ajd@linux.ibm.com> writes:
>> 
>>> If patch_branch() or patch_instruction() fails while updating a jump
>>> label, we presently fail silently, leading to unpredictable behaviour
>>> later on.
>>>
>>> Change arch_jump_label_transform() to panic on a code patching failure,
>>> matching the existing behaviour of arch_static_call_transform().
>>>
>>> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>>> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>>>
>>> ---
>>>
>>> Ran into this while debugging an issue that Erhard reported to me about my
>>> PAGE_TABLE_CHECK series on a G4, where updating a static key failed
>>> silently, but only for one call site, leading to an incorrect reference
>>> count later on. This looks to be due to the issue fixed in [0]. A loud
>>> failure would have saved us all considerable debugging time.
>>>
>>> Should I change the return type of arch_jump_label_transform() and handle
>>> this in an arch-independent way? Are there other users of code patching
>>> in powerpc that ought to be hardened?
>>>
>>> Or is this excessive?
>>>
>>> [0] https://patchwork.ozlabs.org/project/linuxppc-dev/patch/4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu/
>>> ---
>>>   arch/powerpc/kernel/jump_label.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/jump_label.c b/arch/powerpc/kernel/jump_label.c
>>> index 2659e1ac8604..80d41ed7ac50 100644
>>> --- a/arch/powerpc/kernel/jump_label.c
>>> +++ b/arch/powerpc/kernel/jump_label.c
>>> @@ -12,9 +12,14 @@ void arch_jump_label_transform(struct jump_entry *entry,
>>>                               enum jump_label_type type)
>>>   {
>>>        u32 *addr = (u32 *)jump_entry_code(entry);
>>> +     int err;
>>>
>>>        if (type == JUMP_LABEL_JMP)
>>> -             patch_branch(addr, jump_entry_target(entry), 0);
>>> +             err = patch_branch(addr, jump_entry_target(entry), 0);
>>>        else
>>> -             patch_instruction(addr, ppc_inst(PPC_RAW_NOP()));
>>> +             err = patch_instruction(addr, ppc_inst(PPC_RAW_NOP()));
>>> +
>>> +     if (err)
>>> +             panic("%s: patching failed, err %d, type %d, addr %pS, target %pS\n",
>>> +                   __func__, err, type, addr, (void *)jump_entry_target(entry));
>>>   }
>> 
>> arch_jump_label_transform() is mainly getting called from
>> __jump_level_update() and it's used for enabling or updating static keys / branch.
>> 
>> But static keys can also be used by drivers / module subsystem whose
>> initialization happens late. Although I understand that if the above
>> fails, it might fail much before, from the arch setup code itself, but
>> panic() still feels like a big hammer.
>
> But not being able to patch the kernel as required means that you get a 
> kernel behaving differently from what is expected.
>
> Imagine a kernel running on a board that is controlling a saw. There is 
> a patch_instruction() to activate the safety feature which detects when 
> your hands are too close to the blade. Do you want the kernel to 
> continue running seamlessly when that patch_instruction() fails ? I'm 
> sure you don't !
>

;) Sure. Not a fan of playing with blades or saws. :) 

>> 
>> Would pr_err() print with WARN_ON_ONCE(1) would suffice in case of an
>> err?
>
> No, that's not enough, you can't rely on a kernel that will no behave as 
> expected.
>

Sure, Christophe. Thanks for the clarification.

My main concern was that during module load time we should not bring the
system down. But as I see the behavior in arch_static_call_transform()
is also the same.
And as you said, maybe it's good to panic if an important functionality
like patch_instruction() itself fails which means the kernel may not be
doing what we are expecting it to.


>> 
>> Also you said you ran into a problem at just one call site where above
>> was silently failing. With the above change are you able to hit the
>> panic() now? Because from what I see in patch_instruction(), it mainly
>> will boil down to calling __patch_mem() which always returns 0.
>
> As far as I can see, __patch_mem() returns -EPERM when 
> __put_kernel_nofault() fails:
>
> static int __patch_mem(void *exec_addr, unsigned long val, void 
> *patch_addr, bool is_dword)
> {
> 	if (!IS_ENABLED(CONFIG_PPC64) || likely(!is_dword)) {
> 		/* For big endian correctness: plain address would use the wrong half */
> 		u32 val32 = val;
>
> 		__put_kernel_nofault(patch_addr, &val32, u32, failed);
> 	} else {
> 		__put_kernel_nofault(patch_addr, &val, u64, failed);
> 	}
>
> 	asm ("dcbst 0, %0; sync; icbi 0,%1; sync; isync" :: "r" (patch_addr),
> 							    "r" (exec_addr));
>
> 	return 0;
>
> failed:
> 	mb();  /* sync */
> 	return -EPERM;
> }
>

Right, I somehow missed that "_nofault" part.

>
>> Although there are other places where there can be an error returned,
>> so I was wondering if that is what you were hitting or something else?
>
> Andrew was hitting the -EPERM because the memory area was read-only.

yes, that make sense.


>
> Christophe

Thanks for the comments!

-ritesh

