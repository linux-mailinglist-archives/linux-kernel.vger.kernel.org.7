Return-Path: <linux-kernel+bounces-861345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A29BF2794
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A28F3A2925
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94248298CA6;
	Mon, 20 Oct 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg1aC1aW"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50A28A705
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978278; cv=none; b=sh21cf2SB6nMKFeHt2MwKTgBIAqnCzJQNVKoqNNBcyDY7ACgf4zS+HHH0mfRArAmGCiBsgt9dnQcbnPPt3xR5OlSyoR56Wk4YuY37XgO3HnXhnrlmzX/s2OxfLIiJhIAXP8gdAGcbuTjuijATNWRso4TeNVc76gWnZBdUFIYOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978278; c=relaxed/simple;
	bh=YEG62/zWI7JUwRcU7/VbqYXkIBeekZs85fRYRhzN+08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPSfsVewX2SUvNj8NodKGEG0wMXnjqHSqSDRmNgor9r8BBqo4v0/6UcpEnxbLm32VYuMT3+noTgpaaeOuvFvu83TUEoV+4cA5FcbJwHmmSJ2O0e2pZ6jgH0mXJfxmbpt8+QUl80aVHJF0P+qJ8SKek+eDLDw8NyVgIPWRbq41lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg1aC1aW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee130237a8so2984475f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760978275; x=1761583075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8de+GbhMdW9I2uk7I+p7HUkd98yL0Pf24fRr/KS7HxY=;
        b=hg1aC1aWprRIR8snmgGxTdg5fXCGTABKkv63PYtDTqvGfsnhX+ei/4HsttKZD26ZyC
         nTMUSoWjQlb2Js2wk3fhQlHgcbYy8WoL4zRslNvCVqcx+CFl6Gcewy2WwyaUXsyemuCD
         Fqt2epiJ+BmmEShUwf9t/IAKhWhOpRF7oobDzSftBUvw3HBXKYvjLGAn6hNUlCNNJi03
         Th0fjpi4DZ/7OplpgLdj31Y/nAB3R7tGjbsFZ3ehcSrXOHx5xz58wMAC4E1YJ0Hut3V2
         3zFNHjJAYv7F84MWvHOUureNKQDhWi6bXbcY7Yl0ytGhdIR++JF5HBPHW4LKKMVb+qhl
         tK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978275; x=1761583075;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8de+GbhMdW9I2uk7I+p7HUkd98yL0Pf24fRr/KS7HxY=;
        b=KkFr0Fol69pcM6YTrd1EKm4bh2P1KeTviixqtjF2qsLUjSRUUcgzkMrvTJ35sI1zYH
         PcDBmvJEwGJg9JurcPaI0h6AmCnwVl5xeaH8I0myA3W+d1PToipzuVN6ny8MvUVqT8QJ
         wMHcZ4CguD5pv8RHG8rHP/DZYKeYohxoutzFLMoCpV3v62BraIFfnSdegzNuR+8sor8w
         g1k8DmJykk9skBJRA3oxL9Qh2ZZzl3xFaXhIc6ujpD8w5KOpPBgbBGUOVwTO36n4jR5y
         a5y8j1TK31zyxZ9F1P8DHM3YGTnwubfH+HLqn9xW4/fHu2+f3aefl7Zg1Myb5cjqaff1
         k62g==
X-Gm-Message-State: AOJu0Yx/KXLwDi/aAI77aoHtIp2E/zqLRcPY0m/B4Oo4FPymoPmRz0iJ
	xv6Iw+XXHromZ2zCTDAm0i4SXURDOP7adyTb7G3SYQNibyX16Lez/N0S
X-Gm-Gg: ASbGncsguPwYp6q5OnHc8oFqVoltT5uyxYQmZ3ikECY+vBGyDTHdA3jXLeE8pM+6gn3
	sG1q8ObNOP/Yc/r2Azke9UeKVVTMOHJgyOr8G+nWHApF/NgWP5ufRKHKRuwvm9v86LPROrhIyHh
	3gSPU+YGBIFcEqOFxS9BeK3/fxGQNFY4zkeIcIGAm/IjrwzT3ArdzK1dXQHrb8IMpbPLfCN6QBn
	P1NO1LNyvqiT8BKIA2ebWVV3IadVEEa3uYYJeBsWYELzstLV9H7UB5miP5CTZG8gxtk1ZLN1ErE
	VTrV1SQkG+lQxzQ+gpGfjPx06xJbP4NzRQ58B0hjZRL90JBSGgcFjvhbqE5Y3s+ETes34zwyo20
	fh7prAW8zlYXCfCBN/kjgyqDPS7htNdi/2DrYd07bQO/9Dg09wFvXmFGsLlUvYcnRMd5HrfZXbu
	QQbzE+tWCeevpYidKRbrBpZZkTQhLI5U9b58QMJ8eo
X-Google-Smtp-Source: AGHT+IFz8nt5lSaN1IZMi/HsyQiO/U2toGtsPJ9LocnUEVg7UoKo9HQ8SO2vu6OgO8y7PKk852qrzQ==
X-Received: by 2002:a05:6000:2405:b0:426:d5ac:8660 with SMTP id ffacd0b85a97d-42704e0eed1mr9832421f8f.58.1760978275077;
        Mon, 20 Oct 2025 09:37:55 -0700 (PDT)
Received: from [192.168.0.100] ([188.27.132.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a993sm16100829f8f.24.2025.10.20.09.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 09:37:54 -0700 (PDT)
Message-ID: <0d8d7420-8a39-457f-a5a5-980a40809527@gmail.com>
Date: Mon, 20 Oct 2025 19:37:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/63] kbuild: Remove 'kmod_' prefix from
 __KBUILD_MODNAME
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Joe Lawrence <joe.lawrence@redhat.com>,
 live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
 laokz <laokz@foxmail.com>, Jiri Kosina <jikos@kernel.org>,
 Marcos Paulo de Souza <mpdesouza@suse.com>, Weinan Liu <wnliu@google.com>,
 Fazla Mehrab <a.mehrab@bytedance.com>,
 Chen Zhongjin <chenzhongjin@huawei.com>, Puranjay Mohan
 <puranjay@kernel.org>, Dylan Hatch <dylanbhatch@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>
References: <cover.1758067942.git.jpoimboe@kernel.org>
 <f382dddad4b7c8079ce3dd91e5eaea921b03af72.1758067942.git.jpoimboe@kernel.org>
From: Cosmin Tanislav <demonsingur@gmail.com>
Content-Language: en-US
In-Reply-To: <f382dddad4b7c8079ce3dd91e5eaea921b03af72.1758067942.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/25 7:03 PM, Josh Poimboeuf wrote:
> In preparation for the objtool klp diff subcommand, remove the arbitrary
> 'kmod_' prefix from __KBUILD_MODNAME and instead add it explicitly in
> the __initcall_id() macro.
> 
> This change supports the standardization of "unique" symbol naming by
> ensuring the non-unique portion of the name comes before the unique
> part.  That will enable objtool to properly correlate symbols across
> builds.
> 
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   include/linux/init.h | 3 ++-
>   scripts/Makefile.lib | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 17c1bc712e234..40331923b9f4a 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -200,12 +200,13 @@ extern struct module __this_module;
>   
>   /* Format: <modname>__<counter>_<line>_<fn> */
>   #define __initcall_id(fn)					\
> +	__PASTE(kmod_,						\
>   	__PASTE(__KBUILD_MODNAME,				\
>   	__PASTE(__,						\
>   	__PASTE(__COUNTER__,					\
>   	__PASTE(_,						\
>   	__PASTE(__LINE__,					\
> -	__PASTE(_, fn))))))
> +	__PASTE(_, fn)))))))
>   
>   /* Format: __<prefix>__<iid><id> */
>   #define __initcall_name(prefix, __iid, id)			\
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1d581ba5df66f..b955602661240 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -20,7 +20,7 @@ name-fix-token = $(subst $(comma),_,$(subst -,_,$1))
>   name-fix = $(call stringify,$(call name-fix-token,$1))
>   basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
>   modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname)) \
> -		 -D__KBUILD_MODNAME=kmod_$(call name-fix-token,$(modname))
> +		 -D__KBUILD_MODNAME=$(call name-fix-token,$(modname))

As others have mentioned, this breaks modules.alias generation.

The following diff seems to fix it, although in introduces a slight
functional change if symbols do not actually follow the naming scheme.

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index b3333560b95e..c3c06b944c69 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1489,14 +1489,11 @@ void handle_moddevtable(struct module *mod, 
struct elf_info *info,
  	if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
  		return;

-	/* All our symbols are of form 
__mod_device_table__kmod_<modname>__<type>__<name>. */
+	/* All our symbols are of form 
__mod_device_table__<modname>__<type>__<name>. */
  	if (!strstarts(symname, prefix))
  		return;

-	modname = strstr(symname, "__kmod_");
-	if (!modname)
-		return;
-	modname += strlen("__kmod_");
+	modname = symname + strlen(prefix);

  	type = strstr(modname, "__");
  	if (!type)

It would seem like rust generated symbols don't follow it exactly?

See module_device_table macro in rust/kernel/device_id.rs.

>   modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile))
>   
>   _c_flags       = $(filter-out $(CFLAGS_REMOVE_$(target-stem).o), \


