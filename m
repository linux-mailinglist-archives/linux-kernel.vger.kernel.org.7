Return-Path: <linux-kernel+bounces-782966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7D8B327BA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629DB1702ED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C065F23BCE2;
	Sat, 23 Aug 2025 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhftKTsh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0223909F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755939161; cv=none; b=i2ApM3dxE82k4i/E2q0YDaZJjoR64Vk+EkmnkvHsuuoIm5sS8CSrqkHBCoT+82k7RnaGWj/ai218agSRMHr6K5qkgOCU4JMtNvUIPcg36ysJOwUlQNsjRJsnWiab+oPiBxdp6u2WVlMCqJGP42DUMCeMxzfFqNoSGKfpuXvXKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755939161; c=relaxed/simple;
	bh=B4v78I/wXcwG7mSxHdwZw1PWswfHbe23WN9HawZD7VI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WlY/nL1sN0xJb/ockLHD7SCDSXzE7tdP+g3js2qNXvuy0N+tJ/fzyiwvCgGiUsYio/bLOF52pyC5O3zIPW3STYap5lYRADbThv4OYuwmUCH/DJmyyYv10QqnRfvVJHydsI1XR8pbgLNdnPClsPqz174P1VzMLFMzq2AJTWEgN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhftKTsh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b51bafcc1so961345e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755939158; x=1756543958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PP5wLYO2zlvHpx8ruISXTqTGXsZ44eUfMj/9ZfnRZE=;
        b=ZhftKTshd3++XaCbMFT9rt6G1dvJwe0DkgndUxMxplo9Y6ol6aMrTQaI2vqEgImmQB
         8nnCjXhXSmJpgwlfLHcU3Ea2Xb4fTDnwuComt5MEB62uz4yS2wzoLHWVxT4hBB3tYG+4
         R8Sdc63YIytjltL2BcniRKAn4Vj96EraEPJrr7lLPV9554xUKWj99ksCYUz7ZD0/TYYG
         vW3gnJwPrDkBkJQIOynZhxMBtDAeifNW9Zv/QrlcM9W7spmp4o2EyHq0uL01yAQPE42l
         GTBjHxb5qjHe+cQeLeEmPHaaq5bRaX5h/VwyDa9Uo/27+620N65NKCIPKq0tsKKPaytQ
         FX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755939158; x=1756543958;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PP5wLYO2zlvHpx8ruISXTqTGXsZ44eUfMj/9ZfnRZE=;
        b=dgXcvT4/3+ygl5n0rxrLZYl+jdHcMUpPbmlTjl0QgcaIJAg3v/lOuj1LZbiUYlKSgg
         dB7ZDZoor97N6FrdtrOR9sm7J2PFuZWZ8WiX7W3Waf3BKL398M3svpOr7eDiEa2K/AGq
         b+xOBlLA4y+5K5LV+Ab8J5fdgqzLZyNJkQyuGlEzLNvkzL89D5SiaDe6ra4pFbyzgLP1
         H/w566Jiy7rlyUtKzFj77HGIN5MKXWdskkM1nHFdrtpmRfXayK3vFah3P3KQcnPpewnk
         T4oNr0/b60JwP9cRN3r1JliuoEvZX3B031QHOWmIuiTVJNqVa0wdye/9Omg0Wjg494PM
         CY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaxapXnY0EK+NM3JexntwdO5QVlgKa/DxugDFPz20XPnpEll9aYYk2qX/dP5tsS4cfYI+H7tqViSClmw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDbxXJHPZ/ga3Kk09tOSYJHB79XHaCUIGOSWZ6hM2491JO42ZZ
	kqYDDkubJXeTweVat6IB8gXOpEK+rRaK3AMbOYToibDFqUabA6g2tGVLlkt+oHtfrIc=
X-Gm-Gg: ASbGncu5Kd/vvt5qf6+P9Cg+g2SKaQFOmwM5BnESMaCMFhUUTIxwMPQxQB+lgg8KJt0
	aSxSJUj9XaSeYkc9G0yZuJry4BTmC61qR6XvkjFPS+eYOzvhQx+qbAVyRP3ecXaDGJ4hlzRFqgE
	wPkM8NwYV1hF4xfp9GFINbNdUxFW/krKP+mF9qhcWz9aPn5hOIged+EvRcN9Qoi5Iz7X0csJX9e
	phAJ7/X1y4+wroQZQsFKfPbkbDzAGzpHQu1148qOQB28jVuP4qDOy1QSARggH/MmKo1y0BTABYR
	asQpFqyZPUQmfgw61nHJ2wqoO4yLTcgApxI+6uMFp//uvC1WVhdBGs9sgLY3q3bukDc1SfRkYpK
	49s9iYrf1hAmo/3HjIS4Pa6nfMqkyNGLP0THZHopXWsQDIk3rgbPK
X-Google-Smtp-Source: AGHT+IHodoiT3tBSjX0hwuDcLRmhYNw6cAIJpzxg7LcK2D4rgZHgimwZ/kdkV0/kf5RKPnxladSDAw==
X-Received: by 2002:a05:600c:8b26:b0:456:1823:f10 with SMTP id 5b1f17b1804b1-45b552eb575mr18571825e9.8.1755939158114;
        Sat, 23 Aug 2025 01:52:38 -0700 (PDT)
Received: from [192.168.100.6] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7116e1397sm2714908f8f.49.2025.08.23.01.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 01:52:37 -0700 (PDT)
Message-ID: <1757f780-0228-476c-a5a0-ed980209852d@gmail.com>
Date: Sat, 23 Aug 2025 12:52:34 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: akpm@linux-foundation.org
Cc: aha310510@gmail.com, david@redhat.com, leitao@debian.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev,
 osalvador@suse.de, syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
References: <20250822180708.86e79941d7e47e3bb759b193@linux-foundation.org>
Subject: Re: [PATCH] mm/hugetlb: add missing hugetlb_lock in
 __unmap_hugepage_range()
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <20250822180708.86e79941d7e47e3bb759b193@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+		/*
+		 * Check surplus_huge_pages without taking hugetlb_lock.
+		 * A race here is okay:
+		 *   - If surplus goes 0 -> nonzero, we skip restore.
+		 *   - If surplus goes nonzero -> 0, we also skip.
+		 * In both cases we just miss a restore, which is safe.
+		 */
+		{
+			unsigned long surplus = READ_ONCE(h->surplus_huge_pages);
+
+			if (!surplus &&
+			    __vma_private_lock(vma) &&
+			    folio_test_anon(folio) &&
+			    READ_ONCE(h->surplus_huge_pages) == surplus) {
+				folio_set_hugetlb_restore_reserve(folio);
+				adjust_reservation = true;
+			}
+		}

  		spin_unlock(ptl);




On 8/23/2025 5:07 AM, Andrew Morton wrote:
> On Fri, 22 Aug 2025 14:58:57 +0900 Jeongjun Park <aha310510@gmail.com> wrote:
> 
>> When restoring a reservation for an anonymous page, we need to check to > freeing a surplus. However, __unmap_hugepage_range() causes data 
> race > because it reads h->surplus_huge_pages without the protection of 
>  > hugetlb_lock. > > Therefore, we need to add missing hugetlb_lock. > 
>  > ... > > --- a/mm/hugetlb.c > +++ b/mm/hugetlb.c > @@ -5951,6 +5951,8 
> @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct 
> vm_area_struct *vma, > * If there we are freeing a surplus, do not set 
> the restore > * reservation bit. > */ > + spin_lock_irq(&hugetlb_lock); 
>  > + > if (!h->surplus_huge_pages && __vma_private_lock(vma) && > 
> folio_test_anon(folio)) { > folio_set_hugetlb_restore_reserve(folio); > 
> @@ -5958,6 +5960,7 @@ void __unmap_hugepage_range(struct mmu_gather 
> *tlb, struct vm_area_struct *vma, > adjust_reservation = true; > } > > + 
> spin_unlock_irq(&hugetlb_lock); > spin_unlock(ptl); >
> Does hugetlb_lock nest inside page_table_lock?
> 
> It's a bit sad to be taking a global lock just to defend against some
> alleged data race which probably never happens.  Doing it once per
> hugepage probably won't matter but still, is there something more
> proportionate that we can do here?
> 



