Return-Path: <linux-kernel+bounces-710160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962EAEE7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 22:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E8F17EA8E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 20:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F6200112;
	Mon, 30 Jun 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaSH5KIJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9761E1DF75C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751314127; cv=none; b=XgN/f21+RAFREBfmpixtpPUDB12+Kk5RT+c7aXI0FtfDgDTp0ZA5FNo+m0cSwpHdNIEsPaC9wGMGt6QXF6+/IXxKnbX6V9K0j2WNxlxagBFttvniznoupVEzGjHhQsoxa7Pp/oroagff81ZDj69DJ5MkvAfrPJhPhTkSJglP/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751314127; c=relaxed/simple;
	bh=KmUjQyKG1EKv1z0YlFN7C1fRfVuFoQo62eoX9d60CMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=irj3tn/dwXhwicPTSUHGdyCsQ6Yj28X9R0FEg34CJDpN2xexgjYm2fAmOY5ty5lYj33OmFHontQPEIpdsqbIFq+tK+TE4Qs80GRB1KVofHvoRdOFnFiuKWEzgrJhAJmY/PutYFdseEOQPTIjMhEgQSaXzEb775hYnaNlVYUiL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NaSH5KIJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751314123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZI7qwlP52j77UJ8Ch3hjHDow/WyRUqAXdMz4s4OH3C4=;
	b=NaSH5KIJ94IN0vDoH7l3IcNCABJ/pXRI11A1JVs3GeUm6hR9j88m91b6m0I8Uxxbkuwsbk
	aESm3xnNYrVdDjYTshvvdenB8i6vmeLDIsRUQQahwdNcSdGOwYTaTLP0L7tVIU+UVSF89Z
	QYhxaIiZExeRdeGAODNylZi3zfcmf10=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-LfVik0_JPke4x5BbrZeCiQ-1; Mon, 30 Jun 2025 16:08:42 -0400
X-MC-Unique: LfVik0_JPke4x5BbrZeCiQ-1
X-Mimecast-MFC-AGG-ID: LfVik0_JPke4x5BbrZeCiQ_1751314121
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so26123f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 13:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751314121; x=1751918921;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI7qwlP52j77UJ8Ch3hjHDow/WyRUqAXdMz4s4OH3C4=;
        b=aPgAHMCIo6V51vsto2eAsRuhHSzMSJqDkGsrYo3UncDpPHfXYFg3zj0/rWqdlew2wT
         Q/kAXo7i2W8InvzXWrnr2oKN+jyXH7WGPKr+G6gtIWT8/al5pp4EDqq+jZ9RMS/C9qCa
         I2SKJQNI0ltZIY7EamNW5EjoZscMvDmufBAmboknvShrMNRwH9m6/kFUYZckQ3gv96+I
         W7jLog0IGfFxXWNqTr4o/y6MJNjSbtSYqI56OPbmENbzNz6BT0Vn8khB3Pnw5rSSKBSJ
         /kxRdsngm2FHqLgeaN2fRaLdC8c2fopXA2HUkeTw3q6ZFyFlyioYoO1IDh5e0Mcgn1AM
         LaXA==
X-Forwarded-Encrypted: i=1; AJvYcCVIyos+W141VMFnfW47KIlewd3TZrIUpLdT2fRFifI8sXhy/lGZTfkYPpVEvhVLBKOQDelxMSyYow9E3SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAkiCZqFlkn0RAIClQi6nbBsB0n2kh0oaxu91OkqLXMGPAQRC
	bS8do+Z3LQBvcyKoKvqA0YsNOUhiB14jqPNQMokgzq2pjTSaPb5poU9FjSSg2xkaOWA6hJzJI0P
	JLxVlI4XhwB0eJewOmd+bEVeaUoVoYFk70IzqU/4/Dh0iOS8tJk7zTOf5FRc3cTJ53Q==
X-Gm-Gg: ASbGncv9W96rWlVqqIR8eRywqjwCT6Elm0ZdXMSfr1WZjJpzDXMTiNxC46IMPjNFSsR
	B+saay+MSbZ3J5L2QF/wSIx2HHU2PBQECrSy0tDGlPT1mtuXXpO2TBwGb3pc1r0ldYXXz7YpP3A
	IWbxvWajHJBcFzdMO0E1M4rtb29N1ohJwP39QcDKM+/UI1DMUepua+WlV0Q7tJsseAP0JXxTwyO
	Ub6dGxbyrzPli78oKdQwtLN7JxTHB5IYmsPFcOJsinDZNxfSaHDgtJL2MMk/vGBN+1ai9Yxy1LM
	EmsY6Wz2dUZA6rXvIhHw3rCiuRUC1dyHjTdhrgsh5bZBK7Ha/gA4HsC3fJYznT0247jwkEOlZCV
	UP0q4pMHkTH+vDzlhR4mCa3HyBVE15DZoRkjxaRtGQuID6eDGtA==
X-Received: by 2002:adf:9d91:0:b0:3a5:25e0:ab53 with SMTP id ffacd0b85a97d-3a8ff51fd35mr9949852f8f.32.1751314120547;
        Mon, 30 Jun 2025 13:08:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5KXP0+Vv3MytidPKTNF7GuYRxxT9Lal7R9MTzKs2v32UXFEIwEQLd+FN892K113soBsSyxg==
X-Received: by 2002:adf:9d91:0:b0:3a5:25e0:ab53 with SMTP id ffacd0b85a97d-3a8ff51fd35mr9949841f8f.32.1751314120097;
        Mon, 30 Jun 2025 13:08:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f40:b300:53f7:d260:aff4:7256? (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7098sm11043720f8f.4.2025.06.30.13.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:08:39 -0700 (PDT)
Message-ID: <a3b24ee4-b2bc-4245-a560-afe4813843ff@redhat.com>
Date: Mon, 30 Jun 2025 22:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] WARNING in get_pat_info
To: syzbot <syzbot+16b1da89309a06cd0e3a@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, bhelgaas@google.com, bp@alien8.de,
 dave.hansen@linux.intel.com, guohui.study@gmail.com, hpa@zytor.com,
 jannh@google.com, kirill.shutemov@linux.intel.com, liam.howlett@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, luto@kernel.org, mingo@redhat.com,
 peterz@infradead.org, seanjc@google.com, syzkaller-bugs@googlegroups.com,
 tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org
References: <6862ee2e.a70a0220.2f4de1.002d.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6862ee2e.a70a0220.2f4de1.002d.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 22:06, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit f8e97613fed25758ddf52159b87e1c66e619a23a
> Author: David Hildenbrand <david@redhat.com>
> Date:   Mon May 12 12:34:17 2025 +0000
> 
>      mm: convert VM_PFNMAP tracking to pfnmap_track() + pfnmap_untrack()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f1448c580000
> start commit:   fac04efc5c79 Linux 6.13-rc2
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
> dashboard link: https://syzkaller.appspot.com/bug?extid=16b1da89309a06cd0e3a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e2ab30580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d113e8580000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: mm: convert VM_PFNMAP tracking to pfnmap_track() + pfnmap_untrack()

Yes, that should be correct. I didnt't remember that we had a syzbot complaint
about that one, otherwise I would have tagged it.

#syz fix: mm: convert VM_PFNMAP tracking to pfnmap_track() + pfnmap_untrack()

-- 
Cheers,

David / dhildenb


