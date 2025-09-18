Return-Path: <linux-kernel+bounces-773085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD01B29B44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1166C5E82CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A00E286D4C;
	Mon, 18 Aug 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHBHMuDJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69111B7F4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503420; cv=none; b=Wqa864dySJAXQMueL9xNZ95iis14ZFjzc17qWBDQFo/qG9iy4eJ8cRQpsRIRr9LD8X2J9am+6yQyOTB0dxNkPujLK00MpphjC3IwmiCFaZOgTllyxbxk6IPkTpnxUIA1FkbpmSjQ7yhNQ0dikTj6fHSgZjwGplWXO+z+8qTCusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503420; c=relaxed/simple;
	bh=k9+hDeWD9Hbr/1wBHooX99uQD5Vq1LMkmWOrNFz5pPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDIc9imQwgMRjBPVcPetm+5s/Lb/55kMrnThHB9ivTwbqzSSrAgX1mytumi7Va/p/wVB/KZs0OB7Zxc0x/8FhwUnB4NsR9znUvH/YrpQC3ytLZJ1t+HQi7/64HSr4jmZLvBGDAGkw19RIDfiob1HJ6TZvwWBxET7iC/lMRKLzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHBHMuDJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755503417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bFkLpPVTfDfXaiDMBc53qFxi+JxlXWFzy90aTQ3R3F8=;
	b=NHBHMuDJSw9HZlpE3ojFqeRAk8YXof6nhOhXWmBoqzXLikpxWbnyAk2MaBbisKLoxzmTW0
	IqOw6Sh+M9JFomtzRry19xSPSBZU/63HNr1xnymzOpByCP2tuA+hykTKkM6nx1HVNYeB/n
	cLvihmGdMq1ZrBXuM7H3fIV+p8pSCjw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-r58ETnnbMFKhQ5ex4lEptA-1; Mon, 18 Aug 2025 03:50:16 -0400
X-MC-Unique: r58ETnnbMFKhQ5ex4lEptA-1
X-Mimecast-MFC-AGG-ID: r58ETnnbMFKhQ5ex4lEptA_1755503415
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so16201095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503415; x=1756108215;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFkLpPVTfDfXaiDMBc53qFxi+JxlXWFzy90aTQ3R3F8=;
        b=md6Ey6ySqAmAYqTD/S5/q0Fwyboe1Me8dKKJWh5AOeyxnu63C3IsYuAnxreb7YOMkI
         Hm3bppFpIH0crnMNHOTqZtgIc6oUkNaG4liGVRL1GhcAclElsvI0t5TI9MvgR716m7yB
         z9wxf7nZ5QISDwTgvNRTy/RXX/gIcycA/5LHzbk3IzWDS2fMaLjHK4ICZ0xEWGmmxLrK
         sD61U61cpy9WpRznpvTY804/LnrqlhUdHHyE/JzMALe9avPLgWt8BzBeoHVDZxn0Mq9y
         CKGoEukz2Dl2r9DkvDqILE+5RU6MwWk8TiOxEP8yQLgmHkeodTbqmt9Ri8xoVvRvOjL4
         lmYA==
X-Forwarded-Encrypted: i=1; AJvYcCXehh0Z9/y6DxImDZ1lRvZuavrfm78cQzO1uv+hfQ/epozjgGj9MT8Zg3+qCCXciPfpwviW4BryDtQqJWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMVq/MQdji/vkivhUVMp6LNkjX/++w39psk6s0cRiCvSVJmaf
	q2GpeLJKuNoVFwpkE69KByyMay4rApVXJmhtAhThlLka2w43cTbp+fCtgW3EuJQDHgL4M6O36L7
	UCZrJ+0JcwlsQGZ1t0U7Tr+OsFQZojWqjg/F0wyCBdFZ993SbPIzJU/EeVQYXEDZJZQ==
X-Gm-Gg: ASbGncvdSeeg8WxTe6Iuh65klyV5jyBzjCNm4qOu/nWG2psJIKL5KwAZVrGVWQRSWqP
	TwbFrLVY2EnP28rtLkNdnT0p1naVDbqN/04737V5Osa8F5K4u8Shv2+Kj0+VljLWWmciGCvRrFh
	urCYy0L+FKCGmTtlQVw85kDkoUtEh7yEOwJ5vgak5mrpoOdD5D9EYeAcuQqR/05DIqdIxm8x+XP
	eK7DyHzOWKRxdzIFFWHBmDxVdVLtfKLfzp7hmtW0p1MVe6eyGL4s/ifgzz8VqDMxoJ//wbsiUqv
	T3HkvmKPuA8B4be5bVGWpr39nzH7jjSfuzdAo1iEEbOOU5r/Zucn9Pl37ilDf80cvMdPp2Wpdlg
	MXBnpWyx66VjG8VgBn+/sxBCAcmKXOUmQ/QmB+p53C9O1E9/v/zJf9bhWbac/wCOM
X-Received: by 2002:a05:600c:4ecb:b0:459:d3d0:6507 with SMTP id 5b1f17b1804b1-45a2679f1f3mr53181245e9.32.1755503414629;
        Mon, 18 Aug 2025 00:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5/ZkYd40NXxBUsenlW4nvTNivFh4cXL5D6Uw+nYUzKzPp0UEOmyZASZ3TdBetNcyeNoqKUQ==
X-Received: by 2002:a05:600c:4ecb:b0:459:d3d0:6507 with SMTP id 5b1f17b1804b1-45a2679f1f3mr53180835e9.32.1755503414096;
        Mon, 18 Aug 2025 00:50:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64d33340sm11975742f8f.21.2025.08.18.00.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:50:13 -0700 (PDT)
Message-ID: <72704edf-7b6d-4953-8d78-c998362acd0e@redhat.com>
Date: Mon, 18 Aug 2025 09:50:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 mm-hotfixes 0/3] mm, x86: fix crash due to missing page
 table sync and make it harder to miss
To: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "H . Peter Anvin" <hpa@zyccr.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Juergen Gross
 <jgross@suse.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Oscar Salvador <osalvador@suse.de>, Joao Martins
 <joao.m.martins@oracle.com>, Lorenzo Sccakes <lorenzo.stoakes@oracle.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Gwan-gyeong Mun
 <gwan-gyeong.mun@intel.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, Uladzislau Rezki <urezki@gmail.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Ard Biesheuvel <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Peter Xu <peterx@redhat.com>, Dev Jain <dev.jain@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20250818020206.4517-1-harry.yoo@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250818020206.4517-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.25 04:02, Harry Yoo wrote:
> To x86 folks:
> It's not clear whether this should go through the MM tree or the x86
> tree as it changes both. We could send it to the MM tree with Acks
> from the x86 folks, or we could send it through the x86 tree instead.
> What do you think?

I think this should go through the MM tree with ACKs on the x86 parts 
from respective maintainers.

-- 
Cheers

David / dhildenb


