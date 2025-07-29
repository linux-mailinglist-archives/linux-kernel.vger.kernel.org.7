Return-Path: <linux-kernel+bounces-748727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD1B14563
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884071AA00E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AB5158DA3;
	Tue, 29 Jul 2025 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JGENw+0t"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C43C26
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753749375; cv=none; b=ZKeEbM5p+vvhZ5m4GDP1Va9gx1Kya24F/w5n4btGuVjRicj+2jdeFCrLNmoWEdX6TrJ3yymJrqSYhTXguU+Q3qcL1AGW1MhH7+nF5pzj1MXQYTh87CiR0PkHeP2Q6oY8zkJeXTJ66GWH126ArO3a2VYYjePhvgPQR3JipyKwmp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753749375; c=relaxed/simple;
	bh=1Gh39IFfwy1kYqEDRMn11elvC4t891W5yj/F7WcLcE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCzgBQ01RClvzMHNGkz/m+0IMIQyvwGlxNQEsTIhpWeY5OHtF6RTHou0PhaEeJFFNP3zDuCM9HvYtvJd568OPIh3z/KGHmMOpR8huoPwGPHw8o6oaX9gXWX5wNMZfqYJj+vnpE+co7IzKTVzd3I/qtEUirE25HjaYQQ3xhMuXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JGENw+0t; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso4101892a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753749373; x=1754354173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ETbDJbyMnJcJth9NSQ1EqJE54cIcDMP4wIxlGlnYcw=;
        b=JGENw+0t8A4Jk2QiIOw3Q+GaoCn4twyoAsJqkQlZ4b/iVaoC9Ndo5raodg9sK2qS4S
         dH0YReyEKSJyoUgDE+ZOaFD9hBJxQ78BQeeu7j+1z/x2jMP4fdh/QzNWXzIn9RrTuuXG
         CMdjrR2toGRqV/FqFDTvM786chShiihMr3+EdTm7FfhJifQMkxpnOI1HtWjX6+tLkBGI
         1r0jixCbSJNyTdLB7r7O0UZ9VjDBxB0egqyj9Wa5MVQGGAIOGbLl9CyEBRqGukNdjwKW
         XRF+LG0DOqalG5jlV5DgAdTf08i8SDI6J+6mfQF2RldP91P6u4vw5QDaoAW+8QMs/YAh
         vANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753749373; x=1754354173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ETbDJbyMnJcJth9NSQ1EqJE54cIcDMP4wIxlGlnYcw=;
        b=hNuacDzX1xZxZM7e346yIdeeTZ1uHefDVykV5MkRpLwpCrvRMNeWmGklJ2+Puldez6
         NBTjG5V++HcG7DCvvdMNyMHRsMKOQ8EWVOAczaK+CI01Ssun0I+QCFotiT8g8CtM4kC5
         aHVMlPVwUaAOZVaGugV2VS76e9NKOqt0PQd6BRbv34YaoLLFp7mdO3WxGgx+vOIMJ2x9
         I1xZ75bv0TV9YwcAyjKQvZylyYrCm+rdyNbK9mZqrhOcPtHJDZmn4R2i7SmMdVdns+EN
         Gy12zSfMCDIaK16sRcB0xNw+rE6m88xgyf2eJrcJYUFbRxGtWeqmbKpP/mo33XVipYVO
         bO1w==
X-Forwarded-Encrypted: i=1; AJvYcCXye+tNXuv2Z6n2cWSrbMBmptTDiFmexdl3xU2xgkAgDZ25yqdoMdCNE/oejjw1Ie5U4E9epUyl12owANE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlkDFDnak+BuaPrFsI+H3UmZArt9CVBpKb029/egG6065a5iy
	UiFcEhDz+NOkv4sDFCXM/kSS4EHXAstYpONHMXwJIvfH2CXfURaTapMaIMg550pmEcw=
X-Gm-Gg: ASbGnctvWj7d4zT64CAXw7grerJYTN1GdtTOf0pjDFddzAbpCJGAFSUNO7Zz8OfqBtJ
	R+sMjtzB72vFi/yq7AJ8/PpQo/fclCFlCnh4WcrMmulYmZZ6sycw8i5VYftqiFCv4fYFLg9DuXV
	J4lcqGs2ciTj4tdcjmybwpBYthyFxzuAFla1r4dwoNZA9RTM9wPGE7ui5iW+rHV8VeJC+7dWFzz
	G6nhmHzx51WSm9aKfZlqIH2JlcYERt/VRY30ikzvtKGuhHDPjI1UZLJ0Fl4KQBmR8cwln3rtEUs
	2VN3lZmeGdH9sK/Pej8rHWhVaIK0Hhx8FzF71HSKenIzexWf32Brlv19HBc8+LWhmQQ+5gwv2wz
	kPYnGeG1NE4T0GSqRdbjwPrYchnfkQUrC
X-Google-Smtp-Source: AGHT+IEDJXqhf7DRrajAJZBJ8vJ6pYcfACWj1AXTIy+3dQeFkQYCW4S8o7ad1lMROev+GL8TvcTWBw==
X-Received: by 2002:a17:90b:1b45:b0:311:f30b:c18 with SMTP id 98e67ed59e1d1-31e7785ee72mr17793124a91.4.1753749373373;
        Mon, 28 Jul 2025 17:36:13 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31ecd1f0e80sm4264442a91.18.2025.07.28.17.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 17:36:12 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:36:09 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Monk Chiang <monk.chiang@sifive.com>,
	Kito Cheng <kito.cheng@sifive.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-mm@kvack.org,
	llvm@lists.linux.dev, rick.p.edgecombe@intel.com,
	broonie@kernel.org, cleger@rivosinc.com, samitolvanen@google.com,
	apatel@ventanamicro.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, charlie@rivosinc.com,
	samuel.holland@sifive.com, bjorn@rivosinc.com, fweimer@redhat.com,
	jeffreyalaw@gmail.com, heinrich.schuchardt@canonical.com,
	andrew@sifive.com, ved@rivosinc.com
Subject: Re: [PATCH 06/11] mm: Introduce ARCH_HAS_KERNEL_SHADOW_STACK
Message-ID: <aIgXeRDXNmOozRWp@debug.ba.rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-6-04b8fa44c98c@rivosinc.com>
 <aISGypOAaDGaUZgd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aISGypOAaDGaUZgd@kernel.org>

On Sat, Jul 26, 2025 at 10:42:02AM +0300, Mike Rapoport wrote:
>On Thu, Jul 24, 2025 at 04:36:59PM -0700, Deepak Gupta wrote:
>> commit bcc9d04e74 ("mm: Introduce ARCH_HAS_USER_SHADOW_STACK") introduced
>> `ARCH_HAS_USER_SHADOW_STACK`. Introducing `ARCH_HAS_KERNEL_SHADOW_STACK`
>> so that arches can enable hardware assistance for kernel shadow stack.
>>
>> If `CONFIG_DYNAMIC_SCS` or `CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK` are
>> selected, skip compiler flag `-fsanitizer=shadow-call-stack`.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  Makefile   | 2 +-
>>  mm/Kconfig | 6 ++++++
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 35e6e5240c61..7e3ecca9353d 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -987,7 +987,7 @@ LDFLAGS_vmlinux += --gc-sections
>>  endif
>>
>>  ifdef CONFIG_SHADOW_CALL_STACK
>> -ifndef CONFIG_DYNAMIC_SCS
>> +ifeq ($(or $(CONFIG_DYNAMIC_SCS),$(CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK)),false)
>>  CC_FLAGS_SCS	:= -fsanitize=shadow-call-stack
>>  KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
>>  KBUILD_RUSTFLAGS += -Zsanitizer=shadow-call-stack
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 781be3240e21..f295ea611cdb 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1367,6 +1367,12 @@ config ARCH_HAS_USER_SHADOW_STACK
>>  	  The architecture has hardware support for userspace shadow call
>>            stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>
>> +config ARCH_HAS_KERNEL_SHADOW_STACK
>> +	bool
>> +	help
>> +	  The architecture has hardware support for kernel shadow call
>> +          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>
>nit: tab and two space for indentation of the help text

Will fix it.

>
>> +
>
>I think both ARCH_HAS_USER_SHADOW_STACK and ARCH_HAS_KERNEL_SHADOW_STACK
>belong to arch/Kconfig rather than mm/Kconfig

Do you want me to move it?
This basically means that hardware shadow stack is supported or not.
It needs mm support. I think thats why user one landed here. I followed.

If it impacts mm, it should be here, right?

>
>>  config ARCH_SUPPORTS_PT_RECLAIM
>>  	def_bool n
>>
>>
>> --
>> 2.43.0
>>
>
>-- 
>Sincerely yours,
>Mike.

