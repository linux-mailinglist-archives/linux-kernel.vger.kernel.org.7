Return-Path: <linux-kernel+bounces-816942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E90B57B09
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46D2163553
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F00530C376;
	Mon, 15 Sep 2025 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CL5yr0f3"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F930BF62
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939251; cv=none; b=JZKLJMmWfsiggSrU3yE0hDDdOr03i/DCgxaUpuz9sJbuD7DWQInVz1UvQZ9DQQl/3kffbwYkQNZYaLyWY72tsxLmiOLwRM7LDT1v0UXAcSgPVQfPgbu6593tXdG1c+IOEiFCe1c2QO0n1ZkHL6ZJF0dAEoNaUS+vAiUrjVWEEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939251; c=relaxed/simple;
	bh=n9uuvVNemWP/nnePqEPO8AzPn782l+E5xvqUDW7XiWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzwoNTcUYuvioLL855nLu2X3ZlhciqCiYTxTErffVZC9OYLMHOweai+v1VnbW4/5Tu3DWdJqlvuSDBEYHzqvYuq56ljKvSQd0Lp0qJIPByrFKxu8M9NgeTStzL7jRXQ/6BULmzAsleMq7pMbbyH6FI6GrhpaRuqU5jiyjjLOI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CL5yr0f3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45f2f7ae386so4647675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757939248; x=1758544048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTTV3lOOCC8LWXe1yf0im4BY+B9hZENZ9/KZrM1QxrM=;
        b=CL5yr0f3iPQk/qDziM04yUsENN70vJTdSiv9AKxmVwoobRVa3wT83syIvXsEaHbc1f
         3BCcfZvm00qJb+r2O/MmooGkL/9CKOkfpVy5Lsy1Ry7ZBzzM3rVKIyQR5tE6SHuhv6rA
         6X2JIFU6sUVZ+UfOmsr4x2JbUb5pb0mjfPThEQBUoLN6w7zRBk74VLkxXD9x2cd5flVk
         oBfJc0XkyRFHEqAwgipqya7BRhfmNjQ9kIJttgjML+5NUoWzhXVl3wwmzB2LlOOpTvzh
         Gl0KHU92CmWQl2ihFK1g4lkp4AIbkzZB95KXJljRjVtcgswSX6YgZr/tNPiviHMAS/qX
         T9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757939248; x=1758544048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTTV3lOOCC8LWXe1yf0im4BY+B9hZENZ9/KZrM1QxrM=;
        b=QlX/Eg5fuuUBr9m6FiqEkAvfOFq2Y9IhztIbs3Jk3kST0b98riN1sPF3rML+r0Vr8w
         1e2IX25ZoM/tHqGCTqsMrn1tTAHkLOeo0gq/TC7zCkCU5pb+pHeFi03ElY7fXCxdBi+u
         hzfOyc34FO6WBHVq9I0Xf8z+fLXE3870oWoL4MGaTidDsOSxz++bDq700nu2ed9Bb0NB
         YewjUqppH56IHs8TLpKw2MfMQn/5i+7pN5/19VAMr3k5H0MbLkgTZGxcjZ04JT23X6Dq
         npMJTHBdk16SoxuDu/B11IwHYMYlaS8sDnYNmHYPqYSLuua1RfZB2uNRrOKmcQHutomh
         Z4iA==
X-Forwarded-Encrypted: i=1; AJvYcCWPyyGb+u+0r0VxZtj1Eh8D8Mi3A3kMp2l2J1KtdAXgCfI0+jgPAPc/pB9L09og9GZT+GAHgz5I344d/84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVL3fAmgfU3PPxaxkhFxwssf0MjT5Wv9iOhw6NUpREhveJ2ErN
	54BdsahURfMgE7nHtntw/T9NBp47zqU2LgBdOcX9iwRpbBYTYnKJctVdLJ88zil8CBs=
X-Gm-Gg: ASbGncuN8Hk2kEerSigzCJD/Zc781NA0NZuDrO7DOQy3IksS8IYzoMfGqPmSSuOzybl
	EXqLek+4J4aNb7Xxhepv9YEX0k2cOHITKrw0ehO5F9+EXBNXTdNtQDQkqfjaywcz3CFNYiMgbH8
	Pj4R8W/l+1Op4QGB/Cuz8v1LUFRlZ7/9W2dUr/VBuVMoGJMtCiC5CjJ3JSG9Nucx9CRgwGvs8TA
	byJgOtKjoYpo6y+3V1lSz2jMnEs1vGKUziiycewX+lAMXXLr+9UDNqnc9WLF/PW3QcHgK+YW3YP
	NwqzrIAPih2cXB9C0W7+Cl1IiWkpk0rFME09b5JmHEmTBElm7YOuWPh0b6vDGfZdhLhR3/TztTI
	ujQtXl+axyDsZazLyuG2JF3oeGnZCB6APu/xv11t5MHy7Iq/3m0F+Vw==
X-Google-Smtp-Source: AGHT+IEmd2cpMcS6oRE+scJTXial6SxNeRrSLZ4DeDi2CYPkqm2mme+B2lk4RnXTIecqO20t6XFiag==
X-Received: by 2002:a05:6000:2c06:b0:3e2:da00:44c0 with SMTP id ffacd0b85a97d-3e7659d3a9cmr9313035f8f.37.1757939247771;
        Mon, 15 Sep 2025 05:27:27 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9996f384bsm7082529f8f.56.2025.09.15.05.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 05:27:27 -0700 (PDT)
Message-ID: <70f81863-2972-47da-a7c4-486a0d6062e8@suse.com>
Date: Mon, 15 Sep 2025 14:27:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kernel/module: avoid panic when loading corrupt module
To: "Daniel v. Kirschten" <danielkirschten@gmail.com>
Cc: mcgrof@kernel.org, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <d1d1756a-2f6d-4b81-bd6d-50ddf7f39996@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <d1d1756a-2f6d-4b81-bd6d-50ddf7f39996@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 6:46 PM, Daniel v. Kirschten wrote:
> If the kernel attempts loading a corrupted module where the
> .gnu.linkonce.this_module section is not marked as WRITE,
> the corresponding this_module struct will be remapped read-only
> in the module loading process. This causes a kernel panic later -
> specifically the first time that struct is being written to after the remap.
> (Currently, this happens in complete_formation at kernel/module/main.c:3265,
> when the module state is set to COMING,
> but this doesn't really matter and of course might also change in the future.)
> 
> This panic also causes problems down the line:
> after this panic has occurred, all further attempts
> to add or remove modules will freeze the process attempting to do so.
> I did not investigate this further.
> 
> The kernel's module building toolchain will not produce such module files.
> However, there's only a single bit difference on-disk
> between a correct module file and one which triggers this panic.
> Also, there are modules which aren't produced by the kernel's module toolchain.
> (Yes, we don't necessarily need to fully support such modules,
> but we shouldn't panic when loading them either.)
> 
> Note that from a security point of view, this bug is irrelevant:
> the problematic remap of this_module as readonly
> only happens after all security checks have already passed.
> If an attacker is in the position to insert arbitrary modules into the kernel,
> then it doesn't matter anymore that it's possible to cause a panic too.
> And even in the hypothetical scenario where an attacker
> can trigger this panic but can't insert custom modules,
> the worst that could happen is a DoS
> caused by future module insertion / removal attempts.
> 
> Signed-off-by: Daniel Kirschten <danielkirschten@gmail.com>

Nits:

I suggest making the subject of the patch more specific to avoid
potential confusion. For instance:

module: Check that .gnu.linkonce.this_module is writable

I think the description could also be a bit more straightforward and the
text should ideally be reflown to a 75-column boundary (see
Documentation/process/submitting-patches.rst).

> ---
> 
> I hope that the wording is clear enough now about this not being a security bug.
> What do you think?
> 
> In my first submisison of this patch (on 06/06/2024),
> I was told to add this check to userspace kmod too.
> If I find the time, I will do so, but I think that won't help as much
> because there are of course other ways for userspace to load a module,
> such as any alternative insmod implementation (for example busybox).
> 
> Regarding your "next-level university assignment":
> I feel knowing whether the kernel toolchain can or cannot produce such modules
> is a bit beside the point: _if_ such a module is encountered,
> the kernel's going to panic, and it's not going to care where the module came from.
> Also I'm a bit stumped by your wording "university assignment" here.
> Still, I recognize that it would be goot to be certain
> that the official tools don't produce broken modules.
> So, I debugged the module build system a bit and found out the following:
> 
> add_header in scripts/mod/modpost.c:1834-1843 is responsible
> for arranging for the .gnu.linkonce.this_module section to exist:
> The C code this function emits defines the symbol __this_module
> with two attributes: `visibility("default")` and `section(".gnu.linkonce.this_module")`.
> In particular, __this_module is not marked const or anything similar,
> and there definitely is no (supported) way
> for the user to add custom modifiers to this symbol.
> When gcc compiles that file, the resulting section is marked WRITE and ALLOC.
> This seems to be default behaviour of gcc / ld,
> but I couldn't find explicit documentation about this.
> I even tried digging in gcc's source code to find hard proof,
> but as expected gcc turns out to be quite convoluted, so eventually I gave up.
> 
>  kernel/module/main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b26184936..c415c58b9462 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2092,6 +2092,12 @@ static int elf_validity_cache_index_mod(struct load_info *info)
>          return -ENOEXEC;
>      }
>  
> +    if (!(shdr->sh_flags & SHF_WRITE)) {
> +        pr_err("module %s: .gnu.linkonce.this_module must be writable\n",
> +               info->name ?: "(missing .modinfo section or name field)");
> +        return -ENOEXEC;
> +    }
> +
>      if (shdr->sh_size != sizeof(struct module)) {
>          pr_err("module %s: .gnu.linkonce.this_module section size must match the kernel's built struct module size at run time\n",
>                 info->name ?: "(missing .modinfo section or name field)");

This looks ok to me and in line with other checks in
elf_validity_cache_index_mod(), although we should be careful about the
number of ELF sanity checks performed by the module loader.

I think the important part is that the module loader should always at
least get through the signature and blacklist checks without crashing
due to a corrupted ELF file. After that point, the module content is
to be trusted, but we try to error out for most issues that would cause
problems later on. The added check is useful for the latter.

-- 
Thanks,
Petr

