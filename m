Return-Path: <linux-kernel+bounces-636862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7FEAAD0FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 00:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621405025E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF89021ABA3;
	Tue,  6 May 2025 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GcniIrYL"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379ED218EBA
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570602; cv=none; b=E70Tmbc8rob6Li67DebvRFhGSaxOy/4yzjOZO2O/gFfwS2ruhLajQ3WOlFVtyH7yoZsX33kO4qwihXtEgUZuVMXai5+NamWiA9lHCdiBHS4Oy+KzvyNgYlH/ds1Fg5X2sbARd7iAN8Ao3dpzmQCxnkN9RDm0PTOLT7rLwtWwpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570602; c=relaxed/simple;
	bh=sY3HCEY/YvG1ev6qEX0TiGwg9Gb2koaP6fZh+iKpfO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=megkUucVZIgk1DGig9BaVprQm4fEdgDCXXVO0Oap3fxhtycv2UyltoIQ7Tj5O+gjHgDm5hD/XThqesroaTw0C1oFzdplKpnPi0PAcjScqfn1uG3GmyB0BiLrOBrIYyxUskANIuWIkFensVtjo1whbYxk8l6mntMes7O/77sBook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GcniIrYL; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d813c1c39eso55092915ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1746570599; x=1747175399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCwGjdwjpKLNM5KZLRpAtXiKYebm5Y/Ythf2Zq+Ja2M=;
        b=GcniIrYLaEYhK9prlayRJdJbnLCkdbm2B64dTcShiOW8eYBLKfNRKXa7RcUllKRbSX
         ai7StmhWAizZ6TeQYEL2ICzS65+1dJRn3SsGDuyRBGg0WXLQcmFCnFqEbovVfBO3Smlt
         PEgDm5Tp1jdeBLub+Da9ImlJZeibfJRhrelwZMShNwwLwjFcR8DLhkwutgCsyOuV0p0W
         iEfl9V+Ej9jgg5cz5S6FQEmqzVdVEh0YglNSmmKSBtSyCjezaXmfBVXzm3+ClXjW8AVS
         WfFkKAdTIuzXh7NElk2CJX1f7uWTGLsCJDPwcDWvTcN/++lRDI3fW3zk71oI8ubUwdUV
         OS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746570599; x=1747175399;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCwGjdwjpKLNM5KZLRpAtXiKYebm5Y/Ythf2Zq+Ja2M=;
        b=Cq67MTIJGSNmnoN+AuusuEdv/dga3imFiYRaCl+iggt8cjKqFYcTCJyZA9GYdYe1gP
         l7WYFH7sNtepIa5Q7RWJFG04MiDKB3vbNbjk+YAetIq0HMRSHwb8Fe71sEx8/zpd4X26
         Iibqvproi48NkCaij72EFLv0cb5oxhehgc5bsY3qtJh2fhNw0aP6ZE7VYwPavGW1KjaL
         Kh9Y8Aaziom58tNC877nfaUWOKLsYrNrd5RNjveoAtt45Q+DfnmR1d54qlinoNYLyFBR
         JTyE7K50SfjPPafIC5mI5131dDUD5V6RgOtsisv+CVsG4to/arrWePhFH+EqEj/whymO
         IYAg==
X-Forwarded-Encrypted: i=1; AJvYcCX7onjjjQUeXGYLQlLg4ggJxOb2qfIlnpH3zEAo5LJdnoGXr1Y11QvlGZHPCN4npzrBvRqEUk1+wU8iVRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ykZWysiytnTdjmI69lVcvfv4hMcuvmMg+TYAMNDAfZCmQ+ur
	UYoci9A//PngBQVWIk8G66dP/8NdicpbOdun9knmLYmYQ5LgKTivxZLoWkZgsVU=
X-Gm-Gg: ASbGnctyqzVgzfuLXXTbXnwUMnpKHtjhG6UqEc+rr6HZPkpn0kdJeuPvbZ+cXYalm6g
	VquWRUn7McAA0YhfWihxQz/MKQKLa/rNjKQXb3Ify7vEx1nFqs4i+UnLDC23QUrSYquwsMHA0xu
	jHcjg2CtbFjQkVxqum/MMdNpwE4SXpoMbX80DhJE9xNWr2kCwSNgWzf5FAJQJoSWzK+zLRE3mK7
	/OnbL9crvY/+Z4d5ogL57AnYrVkQUr0c6oJ++KIiD/pJSWsBNtLRjZRgKKmjhOqCRtQ+e1GcTUv
	zKzLlvaj345FDYO4H0wPvkJ8yVdySeQ7yGBolTGgGFgfPqGXo48KzbE6M0M=
X-Google-Smtp-Source: AGHT+IEih0KzXWXM0XtCUjjjzNoININkRib/BptoTLpxhmPB23ixs92kuTJei7p+NLVoydHjeMBtvA==
X-Received: by 2002:a05:6e02:258c:b0:3d4:2409:ce6 with SMTP id e9e14a558f8ab-3da738ed7a5mr10084615ab.5.1746570599214;
        Tue, 06 May 2025 15:29:59 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.12.183])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975ec99b7sm26935555ab.36.2025.05.06.15.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 15:29:58 -0700 (PDT)
Message-ID: <49897822-76c4-45c5-87ff-085c3f6fb318@sifive.com>
Date: Tue, 6 May 2025 17:29:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
To: Alexandre Ghiti <alex@ghiti.fr>, Nam Cao <namcao@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250504101920.3393053-1-namcao@linutronix.de>
 <c59f2632-d96f-43c6-869d-5e5f743f2dbd@ghiti.fr>
 <20250505160722.s_w3u1pd@linutronix.de>
 <d7232e99-e899-4e50-b60f-2527be709d2c@ghiti.fr>
 <570ce61a-00ca-446f-ae89-7ab7c340828f@ghiti.fr>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <570ce61a-00ca-446f-ae89-7ab7c340828f@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-05-06 11:31 AM, Alexandre Ghiti wrote:
> On 05/05/2025 21:27, Alexandre Ghiti wrote:
>> On 05/05/2025 18:07, Nam Cao wrote:
>>> Hi Alex,
>>>
>>> On Mon, May 05, 2025 at 06:02:26PM +0200, Alexandre Ghiti wrote:
>>>> On 04/05/2025 12:19, Nam Cao wrote:
>>>>> When userspace does PR_SET_TAGGED_ADDR_CTRL, but Supm extension is not
>>>>> available, the kernel crashes:
>>>>>
>>>>> Oops - illegal instruction [#1]
>>>>>       [snip]
>>>>> epc : set_tagged_addr_ctrl+0x112/0x15a
>>>>>    ra : set_tagged_addr_ctrl+0x74/0x15a
>>>>> epc : ffffffff80011ace ra : ffffffff80011a30 sp : ffffffc60039be10
>>>>>       [snip]
>>>>> status: 0000000200000120 badaddr: 0000000010a79073 cause: 0000000000000002
>>>>>       set_tagged_addr_ctrl+0x112/0x15a
>>>>>       __riscv_sys_prctl+0x352/0x73c
>>>>>       do_trap_ecall_u+0x17c/0x20c
>>>>>       andle_exception+0x150/0x15c
>>>>
>>>> It seems like the csr write is triggering this illegal instruction, can you
>>>> confirm it is?
>>> Yes, it is the "csr_write(CSR_ENVCFG, envcfg);" in envcfg_update_bits().
>>>
>>>> If so, I can't find in the specification that an implementation should do
>>>> that when writing envcfg and I can't reproduce it on qemu. Where did you
>>>> see this oops?
>>> I can't find it in the spec either. I think it is up to the implementation.
>>
>>
>> The reserved fields of senvcfg are WPRI and contrary to WLRL, it does not
>> explicitly "permit" to raise an illegal instruction so I'd say it is not up to
>> the implementation, I'll ask around.
> 
> 
> So I had confirmation that WPRI should not raise an illegal instruction so
> that's an issue with the platform. Your patch is not wrong but I'd rather have
> an explicit errata, what do you think?

There is no erratum here. Allwinner D1 / T-HEAD C906 implements Ss1p11, which
was before senvcfg was added to the privileged architecture, and does not
implement any of the extensions which would imply senvcfg's existence, so the
CSR is reserved. We could check for Xlinuxenvcfg to determine if the CSR access
will raise an exception, but that does not gain anything over checking for Supm
specifically. So the fix is correct.

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

That said, I wonder if set_tagged_addr_ctrl(task, 0) should succeed when Supm is
not implemented, matching get_tagged_addr_ctrl(). Without Supm, we know that
have_user_pmlen_7 and have_user_pmlen_16 will both be false, so pmlen == 0 is
the only case where we would call envcfg_update_bits(). And we know it would be
a no-op. So an alternative fix would be to return 0 below the pmlen checks:

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 7c244de77180..536da9aa690e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -309,6 +309,9 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned
long arg)
 	if (!(arg & PR_TAGGED_ADDR_ENABLE))
 		pmlen = PMLEN_0;

+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
+		return 0;
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;


But I don't know if this better matches what userspace would expect.

Regards,
Samuel

>>> I got this crash on the MangoPI board:
>>> https://mangopi.org/mqpro
>>>
>>> Best regards,
>>> Nam


