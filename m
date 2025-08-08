Return-Path: <linux-kernel+bounces-760513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F07B1EC46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FC5A012A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D37F283C9C;
	Fri,  8 Aug 2025 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8UKlRNJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C42820D1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754667635; cv=none; b=tyezXAEev1uYW/GUdAH6rPQKDjO3IQ4LRJITnL0Ec3jMZk+HYSsPYzadtogONMHhbWw09MUR3AiHlzCVRpzybdtbIUL3oq7IrmJK18uLo3oxsV23GUbtMJhDDmRN9xw92adMKlOCG6xeFg0GjOXn3auk/XdMorRwbDvQsaJ0JFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754667635; c=relaxed/simple;
	bh=KAYm5kEGfZAD53g1Vmi3FWm1tyyNkUkP4NurVrjrxHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaY4G1V6CZp+ViPLx66i71mKBlEbJ67hArSIPjJ5y2/hK3WB0+VGIOMa1Ve3PWpYFOcVsZT6KRIqxMhe0m9PTeu8eOBV09diA+ju64UffSeGN5pDaoMBGvyr7I4lEsD/y87SttwC3TKvQ/2+D48SFtsgOfS6LtpNsseKenlu8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8UKlRNJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754667632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nV2THAhy31Q+K4giF8sVO2GD93KEd5+dTPyv2cww754=;
	b=f8UKlRNJI4SLtU3Qy6Uky585Gz9oJYgriAjKVb6uBFMabJoPYRjXxRq7StRAD19mlaoPy2
	am7Pp6jZ2uf/Y9EucD+wwq8JXX5EXTpxACAc3BpIm7HZJ2LFwEQAOHQ+0PCuhsJNnbqi58
	zwDly+yl5pju+gQygasucDhxnCfnePY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-JndLSVZ6PkCKs80o5UuX7w-1; Fri, 08 Aug 2025 11:40:31 -0400
X-MC-Unique: JndLSVZ6PkCKs80o5UuX7w-1
X-Mimecast-MFC-AGG-ID: JndLSVZ6PkCKs80o5UuX7w_1754667630
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7886bfc16so1372214f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754667630; x=1755272430;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nV2THAhy31Q+K4giF8sVO2GD93KEd5+dTPyv2cww754=;
        b=vcsoQTwV2qR5hzjTRJCQIEdJssME72vrU3cZrSsJFB2LMZX83t3Kh+K1XBhSDFXoVz
         jKgzrllbpIrR5ZqAuzQRWjuZ110xmmRe/qNO9KwhI5XmtVnJDKFV+jsw5JGy2947JhKK
         Cj38SKAX5UD3UxKBJgMgApwa/PWZyTWzt5Wp4KD0nyUxXXq30n+a7h7wSe1HoF11+OiH
         UBST/azebPY02iBOjCHvnozMw5IugoPWPA4TfAW6+HbfH06Coh9GEpsAzi5uwHrLz3lD
         a/MzhiHD2M38pT50z/ENADpONX3In2E4PpmdxhiJJ6F9bWSSg44UqtInMlKEmUZ4ScxT
         2glA==
X-Forwarded-Encrypted: i=1; AJvYcCWJeu+9KbiILLMh459lR2KhxGBVY0UXEWBSWIZUdeL1cPBF8G9/YTguwPdQINucrYodA0a1MZXAq8/FagQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZHOSgJ0qJb0BppwOwP8PO0HbKpvPkbxlYokzaKFESJF1gdZEM
	KNrj5MJFpwfZsUV3alYJugVMxZRrApoW/j51x8x1/Nc4DS8bLgq5/hhtiYtDzfNQZYomPAXcQXa
	gsa9NPb69ci3wI+htvDYgNV1URokwkAMjT2iuIiDSIoqPYXS7vt5xkN//SF5/pnYgcg==
X-Gm-Gg: ASbGncuEnmCKPob2xOuqDZgOH9AAs4jNd8pInpTRE0VHg9ZByl2I+03+Wbh2fu25/vT
	mUhY1vm0JOTlpeeJhjk0+UiS726EPASwbrn5ZiZhWLXvgMkCP4RfSgdQwL0e2RjnZxh9cRRa5QH
	Gs60ZfHiOZIiK4nWjN6NgtcIEtCZ1Gr7aCS6v/E/SJFCWjdYohkgpoqfj75UyqwbTZoCoStreCe
	BzjhgwQoYRJHg+SbentZe76ir3T16/u4MA7fEJKS7AV+cX5BkuONky+ip857h5Yw0IljdjK9+nr
	32YY3+E0kQY4Eui+BEtTogIcOfBheSbAfN+V7fnmpLQsLk04TOjsZZZ1wWtnsWi2JVj3rYAg5Ca
	AYbPs0ZvwA7auCXB0aUdEdexi7URFo28COL0sVLZZDSd8AVc/gT3qoD3kMN3NBn13
X-Received: by 2002:a05:6000:1445:b0:3b7:8412:4540 with SMTP id ffacd0b85a97d-3b900b72d33mr2337799f8f.27.1754667630461;
        Fri, 08 Aug 2025 08:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKTxiJV2FPuPGMFcDLKL8AQfqKKwG29vC2FbgES/WiGrUMMRdjd3ayWesLeL8KISsx4PxMEQ==
X-Received: by 2002:a05:6000:1445:b0:3b7:8412:4540 with SMTP id ffacd0b85a97d-3b900b72d33mr2337775f8f.27.1754667630025;
        Fri, 08 Aug 2025 08:40:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:900:2e1e:d717:2543:c4d6? (p200300d82f2509002e1ed7172543c4d6.dip0.t-ipconnect.de. [2003:d8:2f25:900:2e1e:d717:2543:c4d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm137942595e9.11.2025.08.08.08.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 08:40:29 -0700 (PDT)
Message-ID: <311404a6-d0d5-4b5b-8e6c-be284abbf319@redhat.com>
Date: Fri, 8 Aug 2025 17:40:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD
 is a migration entry
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: peterx@redhat.com, aarcange@redhat.com, lokeshgidra@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20250807200418.1963585-1-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250807200418.1963585-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 22:04, Suren Baghdasaryan wrote:
> When UFFDIO_MOVE encounters a migration PMD entry, it proceeds with
> obtaining a folio and accessing it even though the entry is swp_entry_t.
> Add the missing check and let split_huge_pmd() handle migration entries.
> While at it also remove unnecessary folio check.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: stable@vger.kernel.org
> ---
> Applies to mm-unstable after reverting older v4 [1] version.
> 
> Changes since v4 [1]
> - Removed extra folio check, per David Hildenbrand
> 
> [1] https://lore.kernel.org/all/20250806220022.926763-1-surenb@google.com/
> 
>   mm/userfaultfd.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 5431c9dd7fd7..aefdf3a812a1 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>   			/* Check if we can move the pmd without splitting it. */
>   			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
>   			    !pmd_none(dst_pmdval)) {
> -				struct folio *folio = pmd_folio(*src_pmd);
> -
> -				if (!folio || (!is_huge_zero_folio(folio) &&
> -					       !PageAnonExclusive(&folio->page))) {
> -					spin_unlock(ptl);
> -					err = -EBUSY;
> -					break;
> +				/* Can be a migration entry */
> +				if (pmd_present(*src_pmd)) {
> +					struct folio *folio = pmd_folio(*src_pmd);
> +
> +					if (!is_huge_zero_folio(folio) &&
> +					    !PageAnonExclusive(&folio->page)) {
> +						spin_unlock(ptl);
> +						err = -EBUSY;
> +						break;
> +					}

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


