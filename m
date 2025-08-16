Return-Path: <linux-kernel+bounces-771773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF5B28B69
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778405C7910
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4362264DB;
	Sat, 16 Aug 2025 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5OgIavS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23C317700
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329310; cv=none; b=kO0H2SuOju5gOEvM2tPdS9y2ZDYCPwwqbhkeE4OkogV91OSfOhED+ULU/SPulWjxjiBPLPtYOO9US/14Z0fL5PgpmPoMhumEj4D/i/nWUpBZIsQL4oG5p7NX6DA4vDmg2lLt4IWk0cZIUUL4ys48JPFS5QQEIYD2Ahf51kGYYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329310; c=relaxed/simple;
	bh=E1sGfDIIVSfgwW9IyFc/PA4m4CjK0V88gzsMVlzHAwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxL4yphAqHvVP9aDmdFD4vSrxpGVSurISQeCpeH1qN62FJp0q0mg0VS1Qq4+ZYymWe+6HbKbIJGCB2nJ7ypr1EhMXkhnInzVzSypJ/dbre8h3XuFUZl+ijC+tsyCjma7mlJE3a+DE5wa+qbRGFPiQIPjVVUBYQxCmra+56LiNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5OgIavS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755329308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YhPBBF+Lw3fN55KB6kEc1nX5uVTLUAuKYqprPicOOvE=;
	b=O5OgIavShQtnmwke+OZRVE67vpCYmK+d4fbgf1P6RROJ1Yq+ibJ+Kr/QZW//gGO+AgI1JR
	7gqMYWMK/ByMsCBpJVpYSnzXr0M6Dul7Wi7cAiDV8Qf0CNWA+OGTj99rzFgmUVcR6nm5m+
	5oTawVmxWvoNpIeGoDjlYskO6D8OIsM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-3GrqMQwuPHutzGrYMpKLMA-1; Sat, 16 Aug 2025 03:28:26 -0400
X-MC-Unique: 3GrqMQwuPHutzGrYMpKLMA-1
X-Mimecast-MFC-AGG-ID: 3GrqMQwuPHutzGrYMpKLMA_1755329305
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9a3471121so1592763f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755329305; x=1755934105;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhPBBF+Lw3fN55KB6kEc1nX5uVTLUAuKYqprPicOOvE=;
        b=WmdXsbPh6tvM/TkMOGvS5WIr5V0lOuYET9UAHuYfqU9mnYWEtYGzFY/R26M0B8hijl
         MPMc/PfGE81JHznpMQV2E6o4+njA/GOl0J/jJbY8uRqlmercKMJFXg27Oi5g0fiD9Nrs
         40f8/u4rr9Fh6iWIr2ymjtsO/yUN2gTP6dJVPxuXiXQi1O6QeKjSLrjuOShWbw3pU8hH
         hWxwmODL1odQqLABvFP9RUY8KocSw4SeZh5DNdwihS7immdTf503qQnkBU2Mku/+99Gc
         tHLRF2lAf1hVGQ2KzHp/YdPe0Dc+kQ5pAEg9c0caBNMKpDixtefJHnC3MYZAyfe3QZ0r
         5L2g==
X-Forwarded-Encrypted: i=1; AJvYcCXvUuHNo3Nr19mdFj4lN9vZ2D2RXZkwLt/+oHpB2okPEP42llVAFfJIihT9S+c9HErHD9OOLkBTA7IYcK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM96XeegE9vewYIqP49cfJSZX7bplFMwyZK7OUTbrquKqU4MEo
	4F9+aOCNS6e1BfVmjsiXasyCE4ZiHJqSMZYTRTQZ1ipkbtgUhp5xLh9byCRPynJ+fY4QIBrB9N5
	ZsFxEDrRnGG5BRvgtAtu41woOc3UotE54erEj01OV2lJfTuN2Uyq3hH/57gg5O2i+9g==
X-Gm-Gg: ASbGncvSlhuO2iw2nHo1B4m2vFO/sQn9Em+P6YsF0HqNmIunmRYgu/6M2nxmjiY9LiA
	yww1cm8WZkT2xcIgpnOTD/Bg6WI21gVCzHgsMfDgCAtuJdKYyyhCb/Jd5JzDnVmoF8tbBF/oZL3
	pfCtlv7qq0UnHRBc+aNmbp1t14urK4i6vWwboIkgxjZQjaXB4mOXUG5rV1m3++PFFRhWR7UTk8b
	wvG4Kxie/3f1eAOJjakvQypFn57b6XgRfmOuXXtWDqfWc1mmSadBtfIiQURM5b3+paYkmxnejyS
	eAIW2q9WDMpXarsZ50QrTGfyp0v2nQNm76VQED/+91IZJ61wJkB2bKpvKH5dI4Os1ewXF0vuU79
	910kruZnMUsJw2zSBixgxwbXXxJmn08VF6unv30v2pFkXjlqAcMuyTB/fjzTbiB2H9V8=
X-Received: by 2002:a05:6000:2004:b0:3b7:9d87:9808 with SMTP id ffacd0b85a97d-3ba508ec549mr7047288f8f.15.1755329305450;
        Sat, 16 Aug 2025 00:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfT/JVGrQ0wyU/tULsCTxXAJ+wzvrVInddAWjSvaAhkc628zpO4SSRGf/+hfZY/W0REnvctA==
X-Received: by 2002:a05:6000:2004:b0:3b7:9d87:9808 with SMTP id ffacd0b85a97d-3ba508ec549mr7047274f8f.15.1755329305028;
        Sat, 16 Aug 2025 00:28:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6475857dsm4748985f8f.2.2025.08.16.00.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 00:28:24 -0700 (PDT)
Message-ID: <c324c1fe-7a64-4da1-9641-fb1b9756ba2f@redhat.com>
Date: Sat, 16 Aug 2025 09:28:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org
References: <20250816072149.1952348-1-chenhuacai@loongson.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250816072149.1952348-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.25 09:21, Huacai Chen wrote:
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
> To solve this problem, we define a movable_ops[] array in mm/migrate.c,
> initialise its elements at mm/balloon_compaction.c & mm/zsmalloc.c, and
> let the page_movable_ops() function return elements from movable_ops[].
> 
> Fixes: 84caf98838a3e5f ("mm: stop storing migration_ops in page->mapping")
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Use EXPORT_SYMBOL_GPL_FOR_MODULES instead of EXPORT_SYMBOL and fix build.

See my review.

Please wait longer for a resend, so we don't have to do this weird 
review dance.

-- 
Cheers

David / dhildenb


