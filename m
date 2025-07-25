Return-Path: <linux-kernel+bounces-745325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3959DB11872
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6464B587550
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E202882C3;
	Fri, 25 Jul 2025 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aYf/m7Zl"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA12882B7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424633; cv=none; b=oVIt3k2LpfxRMICuNCJmR8mskUBoe1wuGwZtDhvzdrEJlM4ipSGyOmgajbbOKowXtIXFTGk7/1U2DoLQVYujcDLwCzd0mrrowgEt/8KUNlH8IyWsixcC3pFGKDScIKCay0sFU9i9D73alyaoW3CENjwY+QxcV1Z0vE5BisTNFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424633; c=relaxed/simple;
	bh=wKx1blxbu5QSpaikoCUeh78SpjOHM3ezwW4MOGKYpB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG9qO3x3TstJnHAUSMAV2T4lJeTcbIKiTBN3PJGcCcOVJ1jSlcwtS/LHYaBEfbH37G3g4DMw+wzzYSIr3zFxo/dQLkvjV2FlViYivIB8E/Sj2quyCIl7lV+32qAwjFTgwikzHV8xwYJ/41wno+Jxb4eARpkrjnoGjrd8flUjRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aYf/m7Zl; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 131694032F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1753424630;
	bh=yY/SYQrNWX8OlVsdlpiMi286zoK+AXS6J+gjgGy9bGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=aYf/m7ZlKTECsal4r7Ag3deUgqjBb7A4zrQi3oqCmtIcJtJTl3rrp3RJMKfciJ0Uz
	 SIoUOT2sIMijGc+IdeFF/oTW7QVxIbuY3k1v7j62KX0zbbo1NEKDEBPplHZ+x6j381
	 zciEBRVThqlzZB98dc4ZDIvtO+eWPnyZpptSD1YQtHcJfuDidlZ+Ae7ED3zgcAVCgi
	 sEMHJ9Xtp7g4t+dG8YdGV6uvx25MnB4/zhhpLZx6EzovozyDIU8yQtOIZ+AyqTmdby
	 dRPijpIwwllTke7ubA61ZJKx82aS7NowFqShyjw8c23mNKIDdBlYWKpLfcGbx9StMt
	 OadFhnPgLgX4A==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455e9daab1cso3359535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753424628; x=1754029428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yY/SYQrNWX8OlVsdlpiMi286zoK+AXS6J+gjgGy9bGo=;
        b=G7cFQFEudKZFyrD+L+JFOOAA0DAiFvfG824WIsxacBKEDMfOw7ipYsql1x2aE+nI/j
         bu8qt3soWsJyUXfxI00OmLRmO+hxUtj05NfYORzNO1jOm9b/PwExOVtH51jvXknxt004
         OvytlM63RGEBTeygCVmjOe1/idPfab19I860RNqDqBfUSw85WOPFaCgVYG/lHDYGN8O4
         6C4VUwtlF0azXOoWoEVY8OjjuGd80jmhJ3vuLQB63taF+C+Wh4LbrDGslqIJCPwXP995
         XVITlLddQ/cUFMv2mtxN0ExEsXDNxeM58Zso0CaYit/7XI4Q/V4Y0QemqqNl8JO8sO8i
         17UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAxqJe1wj+lxPUip9Ef4Y99NVQMANLi0vkn3C2SAvxLbfz3kHghJNEK6646BUoFX1CQyg3vfIVb82aYUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALMqIBJN4Ghxb4COSO9ih1LZIe7GHQ1KHO8lgEBU1z56ioWRJ
	iKpgIHDZJuyqS9gccokNW38XdGh37jnPsmlaWq446zy2eodopPmSX8QG3lUalKlAkoQKHYrDThT
	1ixm7HNfA5TFwsSSzj0af79lMBFR2YCEDvUwdTumGbRZmImoIqHsSai8tClvsBP3YIDGPqiqfts
	mOPjXM7A==
X-Gm-Gg: ASbGncv9Sqk0W1hYn/KwroLEYGw5TChg6MFu1pGcWD8jXtsUzCSiffW2an/EWZu6ERN
	1jgH4b3l9WFFAbuKJOWLS2THq2L5Jte5/tAE/exRBgxJrk49edKpCTOooALEEK5rJnlQXaom9hK
	uHPk7X4BprO3IzfIDHgc1tsmWE8Mejwtivkl03xruzXuq5H/tHgZj6UkSzyI2TMzE3OD4u/k1wP
	WL2TqNq9N4tBeFeQlUlNmO2zM4DZsDVzq/BkevKo4yMp/ZTqp5nfire0h4TXKyRqc6rWiHblOag
	0LgAdNpSWDlXDJ5lytc+BGGvFu/aey31iHdMBcAYtu/f8FdVrWHa8n2jOOarbKKM0j0/hZuEejj
	kVqGrCOoV1MVH5ilWlQPhVjdCFiSUIIuAe4Dn
X-Received: by 2002:a05:6000:2306:b0:3a5:527b:64c6 with SMTP id ffacd0b85a97d-3b7765e57c8mr626007f8f.1.1753424627750;
        Thu, 24 Jul 2025 23:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1tfqV/uoCrIpUQ7zCYW6YsO9mWdhr+kRfUXgDIjxIPForORsIR9T6UJpoi3QB0+gQ5qNtNA==
X-Received: by 2002:a05:6000:2306:b0:3a5:527b:64c6 with SMTP id ffacd0b85a97d-3b7765e57c8mr625975f8f.1.1753424627337;
        Thu, 24 Jul 2025 23:23:47 -0700 (PDT)
Received: from [192.168.123.154] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcace8csm4135036f8f.54.2025.07.24.23.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 23:23:46 -0700 (PDT)
Message-ID: <4ad699fc-a89d-4740-bdec-ecb9a2134c90@canonical.com>
Date: Fri, 25 Jul 2025 08:23:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] riscv: update asm call site in `call_on_irq_stack`
 to setup correct label
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev,
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com,
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com,
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com,
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com,
 andrew@sifive.com, ved@rivosinc.com, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>,
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-2-04b8fa44c98c@rivosinc.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250724-riscv_kcfi-v1-2-04b8fa44c98c@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 01:36, Deepak Gupta wrote:
> Call sites written in asm performing indirect call, they need to setup
> label register (t2/x7) with correct label.
> 
> Currently first kernel was compiled with `-save-temps` option and
> normalized function signature string is captured and then placed at the
> asm callsite.
> 
> TODO: to write a macro wrapper with toolchain support.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/kernel/entry.S | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 2660faf52232..598e17e800ae 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -389,6 +389,7 @@ SYM_FUNC_START(call_on_irq_stack)
>   	load_per_cpu t0, irq_stack_ptr, t1
>   	li	t1, IRQ_STACK_SIZE
>   	add	sp, t0, t1
> +	lui t2, %lpad_hash("FvP7pt_regsE")

In patch 1 you use lpad 0 due to missing tool support for signature hashing.

Wouldn't it be preferable to have a first patch series introducing 
landing pad support with lpad 0 and once tool support for signature 
hashing has landed create a second patch series using tags?

Such a first patch series would not have to be an RFC but might be 
merged soon.

Best regards

Heinrich

>   	jalr	a1
>   
>   	/* Switch back to the thread shadow call stack */
> 


