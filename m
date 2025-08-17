Return-Path: <linux-kernel+bounces-772593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF88BB29499
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 19:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A357B201B44
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B28D1DEFD2;
	Sun, 17 Aug 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNgfIcsG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3027453
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755452102; cv=none; b=hAgEQ7D32TKh3CtVL7ww33WklB9SRlEwhXlCyqySUtBAbTBHxbc6Tio+VP0ghPaPBgYjhrlrEZoY/95Lwj81uEdxfLV1GQxbiQp7gtJ7ZQx93fqeZomlJDH2nHQ6XvKo5GBWnzuXHA8lcssLt66T6oDnlMH3OyoKf5aLeQu3zl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755452102; c=relaxed/simple;
	bh=Tfq/pwEkfVCpt7H6BEOKeMYuLfhtyR6K3Q23D1x7Fkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mL2xXBvcLIEHwWpQT3rstJBwaQNMYp3KNNudUM6kTGkILCVkLG4/XzsK1Z4jANGs8ujYRBjqKYb8cfdio//k2NVpIo6s9U41b60Q0nxHYn59oshuCDS30d4IDHHmKt7E6TRxn9Atwnlb8qtRe/Ik7MWPw4yWT9IoK08T1eQtxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNgfIcsG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755452098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QArQznwqkL7/U2m7o6ccA5eQVjfRBrnYkN5ken8DFYI=;
	b=HNgfIcsGyt3/NFDNdutNgZXGKGyCSMQWM8AB9pNTQwab0XaZYHG27gjrQoIB+HtckXJGzG
	jGRM/RoCV2tYjvvb5v9EaD7iFGM36/JOwhYDMrzMH3DmijPzMax7rZrLmR8Ri2wGRVY2qb
	wwpJ5G9C0ysoBus0/B6ADcRLDM16Ui0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-i7gCULe5M7uT4maAZSI2VQ-1; Sun, 17 Aug 2025 13:34:56 -0400
X-MC-Unique: i7gCULe5M7uT4maAZSI2VQ-1
X-Mimecast-MFC-AGG-ID: i7gCULe5M7uT4maAZSI2VQ_1755452096
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9d41cec2cso2889529f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 10:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755452095; x=1756056895;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QArQznwqkL7/U2m7o6ccA5eQVjfRBrnYkN5ken8DFYI=;
        b=Bcy78O2ZowadOdgNuiTQeF6Spe6YvvLKUwlYgPk6YBArIQqAl3kwawO5FnNoL7vd95
         su8KLmRIlaDH1WdwXpeD3/QZgJUGuz273op37oEQU3gO9XACs01t3zG/li5DVTvniwyb
         XKFQcw/Ps8dQqJEiU1fPMei9Szzg7Yatoz/SCJVSX1z9tlgzoxzQw+301ffJIIChvo+a
         +x3+bExjbIpdWbCWRa0kX5DKS7U5mMcayiCve16q/DfS56WPMkE3D5dtCWd+tSkKQri2
         C67ryF9JO9AKkzXZVq/LkYJuJWhk9eo/sTR29kf98+CEhc/S5ImBel1Q4ykP6eOxXpi+
         dGiw==
X-Forwarded-Encrypted: i=1; AJvYcCWpqS93S8xMgWQsZZfc41f4X/ieFnRAZzU71IfA8Bo0SGnmOximha2EM+3UE/fh+gOczgjTRrBUkiQJObU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrI2iXnaykuK8ZgYx5zDWwg+g7gh03vsAkHcOabN/S4pJAUh+i
	ehw9wg+AQnG3/hUixKA0RDeMZoz0cS4pwaXd/pgQTCglATtK1vg39gCOad1GFXALJHmp0gNpyaz
	PEEo5EVWM4weHsF3ZbocgBYvu8pqwaO04IZEexoSTKePzP6jaoDSFHCkyNewMeg8+BA==
X-Gm-Gg: ASbGnctGAim2hZMkycEUHLLoa8W3ItvbGevKM1juFQncMTDvHUQaBLj+o/kFCnah3/N
	e500PRK8X84cDLfFdjFc7J7mYDxVdCfTUOWvR7yfp3IodlXfxYtHsI+agDptiI+GMEtSrLs6n5v
	lhqQ2hjSn5i+BwfNHsKfa47gcs0o9ZAW1VZeze9sapqhzGRlBgX/vCP8Kog5lAJRjnlJU4IQTfe
	3MjMpbrY0SsBUowgYvt8sCKeoeoAGS0VJPKzsgKNGYyOfpLnKeFjtCJVRqMraq3UWieSVcqA5eX
	RddWRPjRROFGaKUvt6uIFn4jcEKo/kdeVGIj3mDROnNqABelyPCJ7d18eA+psNkPx08pyhaAZ8h
	iAc1q96zZoF10liR5fpZpk/aF8YbHV6Iq9nVg43pTfk2ATVYvhxB1MrR56/zlf90IGeM=
X-Received: by 2002:a05:6000:4009:b0:3b8:ffd2:22ca with SMTP id ffacd0b85a97d-3bb68ee712cmr6518859f8f.40.1755452095650;
        Sun, 17 Aug 2025 10:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETGYW5NPXtpi8+O85uXCdY38+LRC4p9pbYMPyAkJw62EI1OsnIbkbAZjQENeuOlWOERnSuHg==
X-Received: by 2002:a05:6000:4009:b0:3b8:ffd2:22ca with SMTP id ffacd0b85a97d-3bb68ee712cmr6518832f8f.40.1755452095139;
        Sun, 17 Aug 2025 10:34:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0b:a400:87b2:80d2:3e99:1b85? (p200300d82f0ba40087b280d23e991b85.dip0.t-ipconnect.de. [2003:d8:2f0b:a400:87b2:80d2:3e99:1b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a221bbadfsm98679335e9.0.2025.08.17.10.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 10:34:54 -0700 (PDT)
Message-ID: <7a10a5bf-95d9-463c-bbea-50f96920ee73@redhat.com>
Date: Sun, 17 Aug 2025 19:34:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20250817151759.2525174-1-chenhuacai@loongson.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250817151759.2525174-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.08.25 17:17, Huacai Chen wrote:
> After commit 84caf98838a3e5f4bdb34 ("mm: stop storing migration_ops in
> page->mapping") we get such an error message if CONFIG_ZSMALLOC=m:
> 
>   WARNING: CPU: 3 PID: 42 at mm/migrate.c:142 isolate_movable_ops_page+0xa8/0x1c0
>   CPU: 3 UID: 0 PID: 42 Comm: kcompactd0 Not tainted 6.16.0-rc5+ #2133 PREEMPT
>   pc 9000000000540bd8 ra 9000000000540b84 tp 9000000100420000 sp 9000000100423a60
>   a0 9000000100193a80 a1 000000000000000c a2 000000000000001b a3 ffffffffffffffff
>   a4 ffffffffffffffff a5 0000000000000267 a6 0000000000000000 a7 9000000100423ae0
>   t0 00000000000000f1 t1 00000000000000f6 t2 0000000000000000 t3 0000000000000001
>   t4 ffffff00010eb834 t5 0000000000000040 t6 900000010c89d380 t7 90000000023fcc70
>   t8 0000000000000018 u0 0000000000000000 s9 ffffff00010eb800 s0 ffffff00010eb800
>   s1 000000000000000c s2 0000000000043ae0 s3 0000800000000000 s4 900000000219cc40
>   s5 0000000000000000 s6 ffffff00010eb800 s7 0000000000000001 s8 90000000025b4000
>      ra: 9000000000540b84 isolate_movable_ops_page+0x54/0x1c0
>     ERA: 9000000000540bd8 isolate_movable_ops_page+0xa8/0x1c0
>    CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
>    PRMD: 00000004 (PPLV0 +PIE -PWE)
>    EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
>    ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
>   ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
>    PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
>   CPU: 3 UID: 0 PID: 42 Comm: kcompactd0 Not tainted 6.16.0-rc5+ #2133 PREEMPT
>   Stack : 90000000021fd000 0000000000000000 9000000000247720 9000000100420000
>           90000001004236a0 90000001004236a8 0000000000000000 90000001004237e8
>           90000001004237e0 90000001004237e0 9000000100423550 0000000000000001
>           0000000000000001 90000001004236a8 725a84864a19e2d9 90000000023fcc58
>           9000000100420000 90000000024c6848 9000000002416848 0000000000000001
>           0000000000000000 000000000000000a 0000000007fe0000 ffffff00010eb800
>           0000000000000000 90000000021fd000 0000000000000000 900000000205cf30
>           000000000000008e 0000000000000009 ffffff00010eb800 0000000000000001
>           90000000025b4000 0000000000000000 900000000024773c 00007ffff103d748
>           00000000000000b0 0000000000000004 0000000000000000 0000000000071c1d
>           ...
>   Call Trace:
>   [<900000000024773c>] show_stack+0x5c/0x190
>   [<90000000002415e0>] dump_stack_lvl+0x70/0x9c
>   [<90000000004abe6c>] isolate_migratepages_block+0x3bc/0x16e0
>   [<90000000004af408>] compact_zone+0x558/0x1000
>   [<90000000004b0068>] compact_node+0xa8/0x1e0
>   [<90000000004b0aa4>] kcompactd+0x394/0x410
>   [<90000000002b3c98>] kthread+0x128/0x140
>   [<9000000001779148>] ret_from_kernel_thread+0x28/0xc0
>   [<9000000000245528>] ret_from_kernel_thread_asm+0x10/0x88
> 
> The reason is that defined(CONFIG_ZSMALLOC) evaluates to 1 only when
> CONFIG_ZSMALLOC=y, we should use IS_ENABLED(CONFIG_ZSMALLOC) instead.
> But when I use IS_ENABLED(CONFIG_ZSMALLOC), page_movable_ops() cannot
> access zsmalloc_mops because zsmalloc_mops is in a module.
> 
> To solve this problem, we define a set_movable_ops() interface to
> register and unregister offline_movable_ops / zsmalloc_movable_ops in
> mm/migrate.c, and call them at mm/balloon_compaction.c & mm/zsmalloc.c.
> Since offline_movable_ops / zsmalloc_movable_ops are always accessible,
> all #ifdef / #endif are removed in page_movable_ops().
> 
> Fixes: 84caf98838a3e5f ("mm: stop storing migration_ops in page->mapping")
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


