Return-Path: <linux-kernel+bounces-864508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56493BFAEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 390604E2C64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E04830BF79;
	Wed, 22 Oct 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtU5Xkae"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3EA309F1C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122244; cv=none; b=QuG+m29Q6U0ZwP3+lUReZ8mv4ZpjQsvWWnnAYagzKP71QtLcrP9SqZLUkg28BvyjTaZ0B9ebDwm+LniABWyb5KCaX0KVQl6opA/pU6hXZ40DcpcAyiqTrTwtWKCB/PnZal8v25GND9tYEwoo1ohgz3oCBJ2IrCnDOGigOp1e1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122244; c=relaxed/simple;
	bh=LIuEa7IrtIjTbuvKFncNKMq/xw9BCVt+ziiLlCM2pQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fa5QvJXe1I0Mi3wvdkOVYv3XHLdTLc0laAjOBjfQ+KZbgwTVZzkzeWnXIm+WnL9Eka4BBni/9IG8bI+pvCZKDJj9gGe5p8ONMR6XM/c+ASeKhwZfnSAzD+eZmKH0kkOhwTs0PJUj0oAWAoiVYfRHcPaiXKbi15XCJQilsIqbuUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtU5Xkae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761122241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PowtbTWFPJpvinHpTKYrok9CuCgmG5go5XaSSmfJb6o=;
	b=FtU5XkaeAcjnLZdR94lu1NRNyINDfjxxlJ9/yWsXVB52I+mR0SN9w/mdlMwdACqjjJUYdA
	zCmKuc2J34r6U7yD5uwZS9mW2/35ARC2P0fX7xT2O6DiXvLIINQHRhorZKz8aYcHUs61P0
	ivet16WysLelO0cUzK3VG/kc8RZtTqw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-BpcjuT3EOAqJQw2QM-9gKw-1; Wed, 22 Oct 2025 04:37:20 -0400
X-MC-Unique: BpcjuT3EOAqJQw2QM-9gKw-1
X-Mimecast-MFC-AGG-ID: BpcjuT3EOAqJQw2QM-9gKw_1761122239
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47107fcb257so91112695e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122239; x=1761727039;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PowtbTWFPJpvinHpTKYrok9CuCgmG5go5XaSSmfJb6o=;
        b=N2G3xOGVUJOGm5rHKvaS9+WjBc9RNuoBfNQ8PBOgeG/plD1eWZK7TlbY/gpvF235JD
         BYuZgOiHZxOMrzuJHNaUMd+j/R27uaamWXeFjhC0rIosUQqxyNhFa8UMVj4Ri16g7fN4
         dKWbbn/W9YNNlv/9KeaE3srocOtpFID2Fh6IcU8HBng4XUIrRm/swl2ZKnxJH+Sc2xql
         o5eoOiG1dufPPUxdeHMUmq8Ps07kgYEqX6w4pBf0pgcFv6XC5sLcgoGB/jrntzWl4CZ9
         AOeSke/+gOklUZEcvhWRIzCapZU9hDL5Bp0yv3JJMVGxCSH1f3ALYPzLU54DX1gwHAoN
         nerA==
X-Gm-Message-State: AOJu0Yx3WEHViRdQxegJB5pbmccraB4WWOArxkLuL7e6ekiCPLYPn/3D
	PI+4gKWnRI1VUPqaBu6zWAubsZxcPU2CkeIjXMJk1f7gIZFFAFgOkOgD2P3itTxdoclXBK9ljAP
	leVzSV+pljAE/nLijYUhtd/tI0ClS2b0rxWpOuZEB24X2fNxPyIKZ5wUohgfjcMP0VwrihbTXQg
	==
X-Gm-Gg: ASbGncuwfOkZSs2dKfn0hiIiqG57F3OoYev+cqw0CK7x484Kj49uF0F84IFzdk3k9GW
	5zv7XTC3idCv94haTiQIiOh2K9XnO3CiXzXCw2//WklIfBpSVw3UpqYCu4/9fEzwg9HNfwX5dCp
	vL645pUqAvvnyfjF7bfqcg/S46jMxvV9qKb4jrEshVyRNG0Lh3tLc6Dg1JfpOBNQTw2HnVKL6P3
	5ANJ8eUB8yCnp3IzbTwt4jI5Z/lw18+4QmZ1/p2atcaWn7PNTXiiFoU0+kHP3WntfqSE7J34Ome
	hbTWU1VLAXwlEpO5Ba5V2IpEYv1/mbh/w8M/kfp8zwQkB7rPD/oYD65NDywabYdylX5IQv9V7kt
	HChbwLRhJuRJFyy+F7CzL3U9CL3HDxi64XUPxX85wtCeFNxtW4H+qPy2f0xe7+Q9ySmOSmgKbkT
	7GN1gLs8YxIAZJL6DxlrfaxBnfFYU=
X-Received: by 2002:a05:600c:64cf:b0:471:12ed:f698 with SMTP id 5b1f17b1804b1-4711786c793mr157782585e9.8.1761122239144;
        Wed, 22 Oct 2025 01:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFItCI5iZhW1a4GMCfGAtG97A/+uLrq+f4lTV3/dPOqU9C5XR4W+DY4bimzCkihYZ5ekVZbVw==
X-Received: by 2002:a05:600c:64cf:b0:471:12ed:f698 with SMTP id 5b1f17b1804b1-4711786c793mr157782285e9.8.1761122238693;
        Wed, 22 Oct 2025 01:37:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427c3bfsm37040815e9.3.2025.10.22.01.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:37:18 -0700 (PDT)
Message-ID: <5be0d531-aa15-4852-b29d-cc3d71334894@redhat.com>
Date: Wed, 22 Oct 2025 10:37:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/23] powerpc/pseries/cmm: remove
 cmm_balloon_compaction_init()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Zi Yan <ziy@nvidia.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-4-david@redhat.com>
 <20251021164220-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251021164220-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 22:43, Michael S. Tsirkin wrote:
> On Tue, Oct 21, 2025 at 02:59:08PM +0200, David Hildenbrand wrote:
>> Now that there is not a lot of logic left, let's just inline setting up
>> the migration function.
>>
>> To avoid #ifdef in the caller we can instead use IS_ENABLED() and make
>> the compiler happy by only providing the function declaration.
>>
>> Now that the function is gone, drop the "out_balloon_compaction" label.
>> Note that before commit 68f2736a8583 ("mm: Convert all PageMovable users
>> to movable_operations"), now not anymore.
> 
> What does this sentence mean?

Should have been "... we actually had to undo something, now not anymore."

Thanks!

-- 
Cheers

David / dhildenb


