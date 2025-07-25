Return-Path: <linux-kernel+bounces-745876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547ACB11FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE7C3ABDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0141CF5C6;
	Fri, 25 Jul 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mQVbtuol"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6C1DF26B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452982; cv=none; b=RmtHKU2uIR8+QX15ur2aAJgPDegeIcDaqXrj7MR5OdGfoA+Pqta7FihAF0TkrG1KVyMa7ftMuo90UDCRyeqqrxF/dFocvHizXR7rg3Rviap3LSBsQ1/FyzONpT6CB2gCPZPAQWPqNlqnCQhnaTPlrBlYgmq6qfB3dmyZN+UeOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452982; c=relaxed/simple;
	bh=rXtgRj8Lg0EC5NCvL7q1D/HDUV15yXcudNMgmUup6uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSkjdfD7ubWVG/WGTMoyeaYxsl5UN+6wQyksdNHjfbjNkiZ1t9w//Ae10fwr4oVLBMjxpG/6axjI5P93qkJJRzQ/VKwMrRCzI8eZBQ3D3phqLMuAGggvA6Zg9uNC8p5s/Th6rcdKZ4Rzy8QS3BvA5YDkYH6elmTSwOXoGWjz5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mQVbtuol; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235d6de331fso27476105ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753452980; x=1754057780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4zb8NrY5OXi5r9Et0ByFU2sSCQJb+4fxBPaABm8ZNI=;
        b=mQVbtuolCEOh2lPmJOrlV7afcvjoSBSwkRIIisU/arrSrF9E8dawZBdQk+O3Q6X58Q
         +ad88T+dQQrWQFyGK3+tsc+cn8iqy2WuPInsPsNM7oqn6saqI2ZinyB47rtUVjnBewqu
         C+5JHCZCLhOR1eI/WhOGXNVvJogmJBlL5L/D0oBp50/BQ0ToBVc/EQyaH56Ui1+d0a+R
         o1oEnswqRl7sn3ZEyPOEIR+mHCCbuNsuoDNvofuaW37LXmTCY9B1m9iUwo4XW640ZD8W
         JhzG6gEmYEJaXinM8C5UQ0IqCqYRtXpxbwkFI66EIoXN1QG0/0dV8r8QeTP5kPn+hlRx
         FAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452980; x=1754057780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4zb8NrY5OXi5r9Et0ByFU2sSCQJb+4fxBPaABm8ZNI=;
        b=WpawfXCqAkaF367pebZoYdSqlbltqjqa0FiDnTErVgYqdf+SUKcP608bheLRsT/i5L
         XVpgyX+u8U2PHuo+JTd7fYIa6Mv5BsiHKyIzpQOot/Dif+cH844FgyzWVIwwTI3zsXrQ
         4k5CF3gqPk5cH4QyvOHJky5V7MWEytmVawSnb7ErFBMXicg/2xnc/6Fh5x24piX+OYUA
         7EJ2cj4EEXiMUZnhIMH+i/BW5tTZzeRcLhaxSkmlmire+S1k1oS8YexJanWXXBBWlY92
         pJxjaAyXYF8AURltyR+fPUn7TBqyloHvCwoYt7Je6TC3KbcjnTml3LaeoXaVyGHw8JOT
         2K1g==
X-Forwarded-Encrypted: i=1; AJvYcCWS5dfWNRZT7jFyppDBSmbSt1GSm2aoCAjV3eGIWmrAKORut1dR9Mepe26VyDdRcFHB9tj++abdnbIumJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/eJRBfnZsXSdVv1lJeN8L3fHhdQu4f3ruBbXS+UAXr6Wvym6H
	84k/t7N0epVq3Jbe9CdUu03ZF+8fvGl9RDZfRialsuHePvKlOyZLHEdJBQtCu2koQTQ=
X-Gm-Gg: ASbGncujEkM+HdOLZbZepnlr/ebK+ap5xTZO8MJ59yo3eMx5Hiy4G2+J9/wvAzCGlg4
	HCbuUiGzx6hIQjuuW9/WQC5Wu5eR1abb/6DjjFWN9bI0/AJRQf7JlEHaA9bQ3Qj397HK19xkiRi
	eKe5n2Zyc8J/srZLAzvc/0jzBSY2i+iNcEz1T4nNrRcz5Cmk9H4I0kHucgN3qS+QUYFCwNh3J/4
	5vmR7UE8ECFVw/q0Xref86xvyW2lFg+HPLorXSH9POsGpogAwllm0RCD6dlf9U5S/zKFoT1+9qU
	SkP93Y5BSXu/x5Lcn7H/S1HqHov6VWzO9T1ZFDBBCUBN+Ho4TyFLSCKiiG8DCycIsc7l5lvls61
	s3sMgcT1kO3dtn7MlC6Sfy41gsZVRwvMH
X-Google-Smtp-Source: AGHT+IE9XuwrXVXrIfvlI3DBKUdukDNvmbxm+Ndq+/QyLjAd0FPi4mKe09kh/NBw/3BKfUdqYZtXMQ==
X-Received: by 2002:a17:902:e5cc:b0:234:eb6:a35d with SMTP id d9443c01a7336-23fb30acdedmr35114765ad.27.1753452979529;
        Fri, 25 Jul 2025 07:16:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa491bb2asm38450025ad.213.2025.07.25.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 07:16:19 -0700 (PDT)
Date: Fri, 25 Jul 2025 07:16:15 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-mm@kvack.org,
	llvm@lists.linux.dev, rick.p.edgecombe@intel.com,
	broonie@kernel.org, cleger@rivosinc.com, samitolvanen@google.com,
	apatel@ventanamicro.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, charlie@rivosinc.com,
	samuel.holland@sifive.com, bjorn@rivosinc.com, fweimer@redhat.com,
	jeffreyalaw@gmail.com, andrew@sifive.com, ved@rivosinc.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Monk Chiang <monk.chiang@sifive.com>,
	Kito Cheng <kito.cheng@sifive.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH 02/11] riscv: update asm call site in `call_on_irq_stack`
 to setup correct label
Message-ID: <aIORr7mQSbV8QMCq@debug.ba.rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-2-04b8fa44c98c@rivosinc.com>
 <4ad699fc-a89d-4740-bdec-ecb9a2134c90@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4ad699fc-a89d-4740-bdec-ecb9a2134c90@canonical.com>

On Fri, Jul 25, 2025 at 08:23:44AM +0200, Heinrich Schuchardt wrote:
>On 25.07.25 01:36, Deepak Gupta wrote:
>>Call sites written in asm performing indirect call, they need to setup
>>label register (t2/x7) with correct label.
>>
>>Currently first kernel was compiled with `-save-temps` option and
>>normalized function signature string is captured and then placed at the
>>asm callsite.
>>
>>TODO: to write a macro wrapper with toolchain support.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/kernel/entry.S | 1 +
>>  1 file changed, 1 insertion(+)
>>
>>diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>index 2660faf52232..598e17e800ae 100644
>>--- a/arch/riscv/kernel/entry.S
>>+++ b/arch/riscv/kernel/entry.S
>>@@ -389,6 +389,7 @@ SYM_FUNC_START(call_on_irq_stack)
>>  	load_per_cpu t0, irq_stack_ptr, t1
>>  	li	t1, IRQ_STACK_SIZE
>>  	add	sp, t0, t1
>>+	lui t2, %lpad_hash("FvP7pt_regsE")
>
>In patch 1 you use lpad 0 due to missing tool support for signature hashing.
>
>Wouldn't it be preferable to have a first patch series introducing 
>landing pad support with lpad 0 and once tool support for signature 
>hashing has landed create a second patch series using tags?
>
>Such a first patch series would not have to be an RFC but might be 
>merged soon.

It's mostly about security guarantees. Coarser grained cfi (only landing pad)
has been proved many times not that effective. Kernel is a monolithic piece of
code. If there is a good chance of adoption anywhere for labeled landing pads,
its kernel. If it becomes a long pole, it's a possible direction to go back to
unlabeled landing pad.

>
>Best regards
>
>Heinrich
>
>>  	jalr	a1
>>  	/* Switch back to the thread shadow call stack */
>>
>

