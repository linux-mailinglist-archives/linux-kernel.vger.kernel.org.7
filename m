Return-Path: <linux-kernel+bounces-771953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98894B28D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401F6B0683A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7F26CE2F;
	Sat, 16 Aug 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjxPuWaO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AFF29A9E1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341707; cv=none; b=jG7IWGtkG65dqTSjREqwXWkEBBkNrNoJvxnZ+y0JQ5pNKt+BLK+wzksT3mpo7q1rwhg13TAVC271NiiHeDL8fUkEto2YVUvscYGno/ImcYc6j2UqQ/+o/9prDDcu0V0EaFA+EwVwz9bBtHhn5/6s5MLRPt4p0761Nv2zUd6wEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341707; c=relaxed/simple;
	bh=Fl7Ecu4tq5egINuRPlsAenNkko8C11TRO33jGTCBRmA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZE50HCg70SckM1Rc3Wk99ja60q6JchTi9H7T9sVhzY7r8aiezFaKxf4yimaXtbAY0iEHF0/XdUHNdlf41J2LG0f18mqgOqchn2ZbEDbfQjehyXBO6Q0mHw/PG0L+SNWzBft8EiuChoi+WizuPqc7ShGt2h/tq/1DnQkYsGjNo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjxPuWaO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755341697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6ZH0BQKmTRqhky0GTh74OwMstz3trn3Zg/lANlIaP7s=;
	b=IjxPuWaOmdVNvO+8ZJy4PhRTPOymb1wC+2SE0dy5z/6BMIqsg8JSA5732sVA6jUuEFUEWK
	koiWqVaqyUYUs71cOAm49dQMTr6kA0qUrMPi7PVjlISLbzyX8h58H8qnIwvB9/QN2Dl1Sr
	aue2Wx2ygvl1VBkWKWTeYCbgffv/8k8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-8kMm5FlcP2eFrAi-zOt-lw-1; Sat, 16 Aug 2025 06:54:55 -0400
X-MC-Unique: 8kMm5FlcP2eFrAi-zOt-lw-1
X-Mimecast-MFC-AGG-ID: 8kMm5FlcP2eFrAi-zOt-lw_1755341695
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afcb7377e95so189207366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755341694; x=1755946494;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZH0BQKmTRqhky0GTh74OwMstz3trn3Zg/lANlIaP7s=;
        b=jM0bQQRB6kHhUdFXetvSFlT1HS1DY0NxomO17HsDV/tohwL9UW7LGaPgzMKf823Qk6
         7zrsRMc5ezTCKithfh0p7EBCerWNYvk6D1/5kX++W5gCiTVAOs9mXtpLgUlroHd0J23I
         hnhKD/nW1OfJAJni/2yJfkZu2jaGrTe/cbKiucKBGslSiRCXTzTH8i9rlHvrSLhv12SE
         ji8uFte98NPoCqFRU7yg8GuAhPV4gTwALjFjKA8dHDCK52NawGbO9kdvDWnJH8dPbKml
         mL36MaITNokF9u1hl/ox2RORNoqjAz2cSagDsulUp5iBWVXtoL5xTmeaLB+9Fp1eYiLc
         8yhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVEIJ6Bv6LDwQf1fLfTHIK8wwhF+c2z0wsB8HCGmNjDhUVN7MbElpvmFHWh7jx/UM9/N4b9k/9vAg0V3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrnyYuj2aleDHGpd4PIUcOpULcCRuFf62IZ2ImdWSCYP6/Ei4
	IdI8ORihBZZDjlSQxGTpXp847fnQD7HGcaNqOEJzSGXNw/IRkVSLT++sIZloUNewI5db655iqKN
	JDYgnHvcUO6yYZ4PhIaj4BhIfIFUWN5mrMLjK/QRcccricJH8tSwL9YZhfnUq4MwEdw==
X-Gm-Gg: ASbGncvrSznFQiJ4OX6K5MsJZonUAeOWUfygcgwLg0GW6IdrLR20zfn6JFNH6pJV+yQ
	eYHukcFzEb3e1XB/ugvJzjFns6X+dBaPzb1VBJSmxQI9an/bu1tmWN1RGwGqH7S9Dy7AtHPar9/
	u3+iqSwO2kBBhpeRZ5m4/rMXVZ/zGUDwwsMOH6ODdpf7NnMDB9ev2fBX5KmaZc3HG5wHcfT8KNF
	yp3bgbSmejXueK5dQviNZtcH20NnFwMCKST4LS5Pq88jL/7u1P9DDZYkmGrhsT+oruWf7rJ5xQt
	W7ugbAbWVi+o8yWb6lREtrOAzQrWA4i1+x5AVzlh/ZZ0M19BttiGTxUJRTmQ0IKi4SdEUenB0LM
	sA6xFOfA+gljsaw5blJ0GXC4OlqZ1h6AArWRvKQgSu7Y3hUF76y9qxUAHqt+f9/lSNrY=
X-Received: by 2002:a17:907:7fa9:b0:af9:d705:9f19 with SMTP id a640c23a62f3a-afcdc28bb9fmr506253566b.17.1755341694468;
        Sat, 16 Aug 2025 03:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6ozjGD/S/nhj1VM/Ur/6pJGOrZahQiMasXYPdrBY42V24LwVXORInLQLCcUNrc13VhcJAHg==
X-Received: by 2002:a17:907:7fa9:b0:af9:d705:9f19 with SMTP id a640c23a62f3a-afcdc28bb9fmr506250866b.17.1755341693930;
        Sat, 16 Aug 2025 03:54:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfcacb7sm354291866b.75.2025.08.16.03.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 03:54:53 -0700 (PDT)
Message-ID: <9db98f7f-b90f-464b-ae7f-e94ac523bc28@redhat.com>
Date: Sat, 16 Aug 2025 12:54:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
From: David Hildenbrand <david@redhat.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250815090539.1578484-1-chenhuacai@loongson.cn>
 <a20d605c-79a0-4d89-985b-9512a990b492@redhat.com>
 <CAAhV-H470h2HDEN_NY2qNBxUqQrSRQhLzwqZe9PB8GjnNsZVFQ@mail.gmail.com>
 <66ebc632-6704-4637-b62d-1cb11e5a4782@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <66ebc632-6704-4637-b62d-1cb11e5a4782@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.08.25 11:01, David Hildenbrand wrote:
> On 16.08.25 10:57, Huacai Chen wrote:
>> Hi, David,
>>
>> On Sat, Aug 16, 2025 at 3:22 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 15.08.25 11:05, Huacai Chen wrote:
>>>
>>> Hi,
>>>
>>> please CC the appropriate maintainers next time. You missed (some)
>>> balloon and zsmalloc maintainers.
>> OK, thanks.
>>
>>>
>>>> After commit 84caf98838a3e5f4bdb34 ("mm: stop storing migration_ops in
>>>> page->mapping") we get such an error message if CONFIG_ZSMALLOC=m:
>>>>
>>>>     WARNING: CPU: 3 PID: 42 at mm/migrate.c:142 isolate_movable_ops_page+0xa8/0x1c0
>>>>     CPU: 3 UID: 0 PID: 42 Comm: kcompactd0 Not tainted 6.16.0-rc5+ #2133 PREEMPT
>>>>     pc 9000000000540bd8 ra 9000000000540b84 tp 9000000100420000 sp 9000000100423a60
>>>>     a0 9000000100193a80 a1 000000000000000c a2 000000000000001b a3 ffffffffffffffff
>>>>     a4 ffffffffffffffff a5 0000000000000267 a6 0000000000000000 a7 9000000100423ae0
>>>>     t0 00000000000000f1 t1 00000000000000f6 t2 0000000000000000 t3 0000000000000001
>>>>     t4 ffffff00010eb834 t5 0000000000000040 t6 900000010c89d380 t7 90000000023fcc70
>>>>     t8 0000000000000018 u0 0000000000000000 s9 ffffff00010eb800 s0 ffffff00010eb800
>>>>     s1 000000000000000c s2 0000000000043ae0 s3 0000800000000000 s4 900000000219cc40
>>>>     s5 0000000000000000 s6 ffffff00010eb800 s7 0000000000000001 s8 90000000025b4000
>>>>        ra: 9000000000540b84 isolate_movable_ops_page+0x54/0x1c0
>>>>       ERA: 9000000000540bd8 isolate_movable_ops_page+0xa8/0x1c0
>>>>      CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
>>>>      PRMD: 00000004 (PPLV0 +PIE -PWE)
>>>>      EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
>>>>      ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
>>>>     ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
>>>>      PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
>>>>     CPU: 3 UID: 0 PID: 42 Comm: kcompactd0 Not tainted 6.16.0-rc5+ #2133 PREEMPT
>>>>     Stack : 90000000021fd000 0000000000000000 9000000000247720 9000000100420000
>>>>             90000001004236a0 90000001004236a8 0000000000000000 90000001004237e8
>>>>             90000001004237e0 90000001004237e0 9000000100423550 0000000000000001
>>>>             0000000000000001 90000001004236a8 725a84864a19e2d9 90000000023fcc58
>>>>             9000000100420000 90000000024c6848 9000000002416848 0000000000000001
>>>>             0000000000000000 000000000000000a 0000000007fe0000 ffffff00010eb800
>>>>             0000000000000000 90000000021fd000 0000000000000000 900000000205cf30
>>>>             000000000000008e 0000000000000009 ffffff00010eb800 0000000000000001
>>>>             90000000025b4000 0000000000000000 900000000024773c 00007ffff103d748
>>>>             00000000000000b0 0000000000000004 0000000000000000 0000000000071c1d
>>>>             ...
>>>>     Call Trace:
>>>>     [<900000000024773c>] show_stack+0x5c/0x190
>>>>     [<90000000002415e0>] dump_stack_lvl+0x70/0x9c
>>>>     [<90000000004abe6c>] isolate_migratepages_block+0x3bc/0x16e0
>>>>     [<90000000004af408>] compact_zone+0x558/0x1000
>>>>     [<90000000004b0068>] compact_node+0xa8/0x1e0
>>>>     [<90000000004b0aa4>] kcompactd+0x394/0x410
>>>>     [<90000000002b3c98>] kthread+0x128/0x140
>>>>     [<9000000001779148>] ret_from_kernel_thread+0x28/0xc0
>>>>     [<9000000000245528>] ret_from_kernel_thread_asm+0x10/0x88
>>>>
>>>> The reason is that defined(CONFIG_ZSMALLOC) evaluates to 1 only when
>>>> CONFIG_ZSMALLOC=y, we should use IS_ENABLED(CONFIG_ZSMALLOC) instead.
>>>
>>> Ouch, I missed that CONFIG_ZSMALLOC can be configured like that. I
>>> thought it would always be builtin.
>> Make CONFIG_ZSMALLOC be bool can solve this, if you think it is reasonable.
>>
>>>
>>>> But when I use IS_ENABLED(CONFIG_ZSMALLOC), page_movable_ops() cannot
>>>> access zsmalloc_mops because zsmalloc_mops is in a module.
>>>>
>>>> To solve this problem, we define a movable_ops[] array in mm/migrate.c,
>>>> initialise its elements at mm/balloon_compaction.c & mm/zsmalloc.c, and
>>>> let the page_movable_ops() function return elements from movable_ops[].
>>>
>>> Before I took that easy route to just get it working quickly, I
>>> envisioned a proper registration interface. See below.
>> When I found I cannot access zsmalloc_mops in a module I considered
>> the registration interface. But in this case I think that is an
>> over-design and not straight forward.
>>
>> Moreover, a registration interface looks like a redesign and not
>> suitable for hot-fix.
> 
> I think you misread my message: This is not debatable.
> 
> If you don't want to fix it properly, I can send a fix.

FWIW, something like that on top of your patch.

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 58fac171e4d50..4c9b5bcb63ba9 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -57,12 +57,6 @@ struct movable_operations {
  	void (*putback_page)(struct page *);
  };
  
-#define MOVABLE_BALLOON		0
-#define MOVABLE_ZSMALLOC	1
-#define MOVABLE_MAX		2
-
-extern const struct movable_operations *movable_ops[MOVABLE_MAX];
-
  /* Defined in mm/debug.c: */
  extern const char *migrate_reason_names[MR_TYPES];
  
@@ -85,6 +79,10 @@ void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
  void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
  int folio_migrate_mapping(struct address_space *mapping,
  		struct folio *newfolio, struct folio *folio, int extra_count);
+int register_movable_ops(const struct movable_operations *ops,
+		enum pagetype type);
+void unregister_movable_ops(const struct movable_operations *ops,
+		enum pagetype type);
  
  #else
  
@@ -106,6 +104,16 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
  {
  	return -ENOSYS;
  }
+static inline int register_movable_ops(const struct movable_operations *ops,
+		enum pagetype type)
+{
+	return -ENOSYS;
+}
+static inline void unregister_movable_ops(const struct movable_operations *ops,
+		enum pagetype type)
+{
+	return -ENOSYS;
+}
  
  #endif /* CONFIG_MIGRATION */
  
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index a1d2625b5c391..c391435ce9942 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -256,8 +256,10 @@ const struct movable_operations balloon_mops = {
  
  static int __init balloon_init(void)
  {
-	movable_ops[MOVABLE_BALLOON] = &balloon_mops;
-	return 0;
+	int rc;
+
+	rc = register_movable_ops(&balloon_mops, PGTY_offline);
+	return rc;
  }
  core_initcall(balloon_init);
  
diff --git a/mm/migrate.c b/mm/migrate.c
index ee65d8787e95b..d69c9f7c27800 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -43,8 +43,6 @@
  #include <linux/sched/sysctl.h>
  #include <linux/memory-tiers.h>
  #include <linux/pagewalk.h>
-#include <linux/balloon_compaction.h>
-#include <linux/zsmalloc.h>
  
  #include <asm/tlbflush.h>
  
@@ -53,9 +51,49 @@
  #include "internal.h"
  #include "swap.h"
  
-const struct movable_operations *movable_ops[MOVABLE_MAX];
+static const struct movable_operations *offline_movable_ops;
+static const struct movable_operations *zsmalloc_movable_ops;
  
-EXPORT_SYMBOL_GPL_FOR_MODULES(movable_ops);
+int register_movable_ops(const struct movable_operations *ops, enum pagetype type)
+{
+	/*
+	 * We only allow for selected types and don't handle concurrent
+	 * registration attempts yet.
+	 */
+	switch (type) {
+	case PGTY_offline:
+		if (offline_movable_ops)
+			return -EBUSY;
+		offline_movable_ops = ops;
+		break;
+	case PGTY_zsmalloc:
+		if (zsmalloc_movable_ops)
+			return -EBUSY;
+		zsmalloc_movable_ops = ops;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_movable_ops);
+
+void unregister_movable_ops(const struct movable_operations *ops, enum pagetype type)
+{
+	switch (type) {
+	case PGTY_offline:
+		WARN_ON_ONCE(offline_movable_ops != ops);
+		offline_movable_ops = NULL;
+		break;
+	case PGTY_zsmalloc:
+		WARN_ON_ONCE(zsmalloc_movable_ops != ops);
+		zsmalloc_movable_ops = NULL;
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(unregister_movable_ops);
  
  static const struct movable_operations *page_movable_ops(struct page *page)
  {
@@ -66,15 +104,10 @@ static const struct movable_operations *page_movable_ops(struct page *page)
  	 * it as movable, the page type must be sticky until the page gets freed
  	 * back to the buddy.
  	 */
-#if IS_ENABLED(CONFIG_BALLOON_COMPACTION)
  	if (PageOffline(page))
-		/* Only balloon compaction sets PageOffline pages movable. */
-		return movable_ops[MOVABLE_BALLOON];
-#endif /* IS_ENABLED(CONFIG_BALLOON_COMPACTION) */
-#if IS_ENABLED(CONFIG_ZSMALLOC) && IS_ENABLED(CONFIG_COMPACTION)
+		return offline_movable_ops;
  	if (PageZsmalloc(page))
-		return movable_ops[MOVABLE_ZSMALLOC];
-#endif /* IS_ENABLED(CONFIG_ZSMALLOC) && IS_ENABLED(CONFIG_COMPACTION) */
+		return zsmalloc_movable_ops;
  	return NULL;
  }
  
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index ef95cf8c6af90..fcb4f2c599708 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2246,8 +2246,12 @@ EXPORT_SYMBOL_GPL(zs_destroy_pool);
  
  static int __init zs_init(void)
  {
+	int rc;
+
  #ifdef CONFIG_COMPACTION
-	movable_ops[MOVABLE_ZSMALLOC] = &zsmalloc_mops;
+	rc = register_movable_ops(&zsmalloc_mops, PGTY_zsmalloc);
+	if (rc)
+		return rc;
  #endif
  #ifdef CONFIG_ZPOOL
  	zpool_register_driver(&zs_zpool_driver);
@@ -2259,7 +2263,7 @@ static int __init zs_init(void)
  static void __exit zs_exit(void)
  {
  #ifdef CONFIG_COMPACTION
-	movable_ops[MOVABLE_ZSMALLOC] = NULL;
+	unregister_movable_ops(&zsmalloc_mops, PGTY_zsmalloc);
  #endif
  #ifdef CONFIG_ZPOOL
  	zpool_unregister_driver(&zs_zpool_driver);
-- 
2.50.1


-- 
Cheers

David / dhildenb


