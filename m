Return-Path: <linux-kernel+bounces-745328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F02AB1187D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF5D1CC558C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B91D2882CB;
	Fri, 25 Jul 2025 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IWugx4X+"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935732877F9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424808; cv=none; b=BByqM0XRMjyi9E9AuFur8W5TybYlHBszid3I9b5Z517siKqUq9JLmdPjbZ7dKnSHg+A9q+XQY0hQvHtRsqUBE+D5EspEi1WTX6Y+6eayCo3fSz03BHVOXg1uKNxFdJ1xNYIeegIlkL2vcxXPehjUuaYeGl4o2Bu6lHMXglaTOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424808; c=relaxed/simple;
	bh=2si2snLINEkjaC7gF7x3f6zLZxI8VdibGsVfnQtcyl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AafYNWRSS9C1B6CP4ZceS6eO4zO5Q6mS8gca+j37G19KC2jgSAOHRtZ4Cu0hV2fYaSwSTR34FUoOsWFhmL/5nftb1snGkelyt8G+lxG0Mb99oA8A7mbZqeOPxd/8Ab4cmzbSX4OfpOCX8GO5nEm7BUVpExlqK8c4dI4BpDZO2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=IWugx4X+; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 87A1D40308
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1753424804;
	bh=i7Z45Di1DKvPrIvb2/CHdBXTyeDYviINQxq/IZOTBeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=IWugx4X+bTsW+tLBhJVw7GOYeoC59am65WCy0KgCsDi+PYktPZHpiLqCthurKR+rA
	 ghChtgIetvXu0gOUcL9NRsVZamJpZNA70B2aQYGDnKH6g38ZG0eWlbICoGXJ2l2v3i
	 GHd0j4MDN29cWl4TDaXgQ2PNp/vmRR4BTHtzmcEp77tK2jxWIZJwdlfG+UpIYekDdk
	 LXXNbPUjzYcg3QXOjopn6EEbaXCQ6rNcY/k4kRrXQfUe8jg6oWT40Qgcsl8TApLtdR
	 kyv29YdXWv6cOxv5wlkdOgnWg2uHvPTAJKTdq8Gk/H5Vriz8HrT4crIQMj/wNfBgna
	 sYReZIYQB34lQ==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so902542f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753424803; x=1754029603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7Z45Di1DKvPrIvb2/CHdBXTyeDYviINQxq/IZOTBeg=;
        b=UujVcUhG47nvqZJF+kgRzK0BSybVB7xVjduaBSXojWGAzMBWJ0gQi5koMRFQG+kBf4
         MB5/3vEIdBD57XEAfkArSN8rAdSALtq151zubCgJUDULPFZ3apzgQnTiJ/FheTxF+GVD
         k3YcKtG6uA+RwNNmHGIA3wshQVlIOpUOW3f8cqMX2BbUv5VlDHAp3hO5PbU7etgm4jTe
         h8zyjrfIx2XYfFu184lVg3RSKGzEzEwGsIkgiGeEHwxG1aVLPBKArukefnuwL/kt+Cpf
         bOfI07oujhxRM0ulvxw0j4aY8LZHAXDr8xD9L2EkCRbTnUqJh3vWzFtwjjU16XfcUt/m
         FOCA==
X-Forwarded-Encrypted: i=1; AJvYcCXvYfqLk7mtF4oFgS6vCS01rJevMDH98auD53I01nKpRmMuO5jJUW9keHsxUYj1NEOxrq1ab/bzCmNB9VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCF4MV4JzQZNrbtZHkjOzHdNHuAFXHoSzN6UGRAXGViwJmhoQ/
	xofzQSxbef/H6I8VXeUoGFaxmwJ06IRXrKgXBaFUhgPtDrAtWDqFnT4nUJHdDY2iltHiL8k/JEM
	QSj/QYXej98YyLBOb2ePRTisgRP5wMMKrXCuLsOeqsL+mCKaJQ+4kwg0PKt5IPRDrrsy8VJ9TKT
	2rXc+yCw==
X-Gm-Gg: ASbGncuLb/MvcHYJJSrXIpo8Wo+vsW8BHxAvmB1/0EYNXTpBhi9KBZbtYQX2tm0GD70
	07XGFrEB1k3Afz6J+xAZwYGWi0Tin0hZz/vU1EQgb81mw8O8L1OV7pQhKe8sd0JeS5TVXi/YDSx
	zutiK9JsQZZZoPvkjF/pQj61GTu1zq5J/j8LWCT50/AmF42ooF5rPu0sGKwQsXB7R4c2IyCZ3Wj
	gDTBBxRmqNQhy7WjXKH+0UsbmxRPevn/iEzYy2SHMWHNmRHTVf6UC8XGKteOqOt54pLJsnLEb8s
	VzT9JcuMKBRuacvVJeG01MoZpwxXQPKue8sSSCxX9YAultV01V0Lzf9yTllH6DIy1zmHqqHvBKI
	BhjCABujJ081WNmMEHNCBipRhlOuUIP1q0VmX
X-Received: by 2002:a05:6000:1a88:b0:3a4:fb7e:5fa6 with SMTP id ffacd0b85a97d-3b77671592amr538371f8f.1.1753424802564;
        Thu, 24 Jul 2025 23:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTcbhP+qpBUFcpUqfk2Wp/N8FXB7Xsc01E0wuMcV6UBfsne+SnFue51uathOre6C5p/D/OcQ==
X-Received: by 2002:a05:6000:1a88:b0:3a4:fb7e:5fa6 with SMTP id ffacd0b85a97d-3b77671592amr538323f8f.1.1753424802160;
        Thu, 24 Jul 2025 23:26:42 -0700 (PDT)
Received: from [192.168.123.154] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcacf0bsm4109538f8f.38.2025.07.24.23.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 23:26:41 -0700 (PDT)
Message-ID: <0532c555-1876-449b-89cb-36ce5394433f@canonical.com>
Date: Fri, 25 Jul 2025 08:26:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] riscv: indirect jmp in asm that's static in nature
 to use sw guarded jump
To: Deepak Gupta <debug@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>,
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev,
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com,
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com,
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com,
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com,
 andrew@sifive.com, ved@rivosinc.com
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-3-04b8fa44c98c@rivosinc.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250724-riscv_kcfi-v1-3-04b8fa44c98c@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 01:36, Deepak Gupta wrote:
> Handwritten `__memset` asm routine perform static jumps within
> function and uses `a5` to do that. This would require a landing pad
> instruction at the target. Since its static jump and no memory load is
> involved, use `t2` instead which is exempt from requiring a landing pad.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   arch/riscv/lib/memset.S | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
> index da23b8347e2d..c4a318d8eef3 100644
> --- a/arch/riscv/lib/memset.S
> +++ b/arch/riscv/lib/memset.S
> @@ -56,12 +56,12 @@ SYM_FUNC_START(__memset)
>   
>   	/* Jump into loop body */
>   	/* Assumes 32-bit instruction lengths */
> -	la a5, 3f
> +	la t2, 3f
>   #ifdef CONFIG_64BIT
>   	srli a4, a4, 1
>   #endif
> -	add a5, a5, a4
> -	jr a5
> +	add t2, t2, a4
> +	jr t2
>   3:
>   	REG_S a1,        0(t0)
>   	REG_S a1,    SZREG(t0)
> 


