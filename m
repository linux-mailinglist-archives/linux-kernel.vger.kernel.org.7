Return-Path: <linux-kernel+bounces-794298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8ECB3DFC3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD022013D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323C930F543;
	Mon,  1 Sep 2025 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6/4NwX/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB620DD48
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721228; cv=none; b=FlGkk4cgJlZ5xH94svLTaDhUflWticYIEZa/9bSrZ/U0D84ojPNBJUFI1yhls0w2qTZ3H2NVM8YA4mAXw8BF5rL07xRuY2++hCaRXMjePy1WfG8oq4nvVFogPiUadYs+PzJsQ+M2cRrLWejwd+QN8D0XCMf0+h1BEDtZ/p0QvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721228; c=relaxed/simple;
	bh=o487DNZtIlMWsOkJTDgtLzA5N4UTPqzL1RUP4sQ8A50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vmu/VUTd0OGuTf/v+NEha8eITMYgHszYmekRn9z4XkR4RfsZEbpqi1VtIdgciUQKkOsNQ4vneI9frt1KRknfHKuBHRaflCFPCXgyFwGgtJMDKHAUzoG9yUi7C0N/Og/68p6Cr1TDqgkJifyw+mTam6OXq5R7D7huMbzP+FbPWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6/4NwX/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n3WDWNbwtSza/5trI3hgmn3FzMAdNJKYUYMemf9ADJE=;
	b=F6/4NwX/Nn/Q7JKwmlqQZ0qxZOQWO9R2BRugppzXsn+ebCnJUMbnh0ZUVITSBXE/uM1IGy
	RSKn49sr1oHzkljZbbyg9LvS6qSW3GQ5g4RccJ0foOi+lAv5OemuzGTTNllugA456E/7mF
	mKZyzbzsNsACtBi9CV1H4FoPi8DoLwQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345--M5IbzO1MWOzASskMbnYKg-1; Mon, 01 Sep 2025 06:07:04 -0400
X-MC-Unique: -M5IbzO1MWOzASskMbnYKg-1
X-Mimecast-MFC-AGG-ID: -M5IbzO1MWOzASskMbnYKg_1756721223
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b8a307c12so5158215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 03:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756721223; x=1757326023;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3WDWNbwtSza/5trI3hgmn3FzMAdNJKYUYMemf9ADJE=;
        b=XtAhizYo9ft9fLM4ERw3ALJmFN/VWx1kIZzRRbsxjulRiTrvKfSoPrMADMS+eAyWsi
         rSFswH4AnoYMXAtm9/OSGtYdLHCXWyp7w4FW8gSdQm9TGpG9hRNv4E5R/IO580or3xDy
         SLVa5rpW6rPRQDaRMr8GubBidNdA3tNaHwn6jduhQIJd+Acg31OiuDz+0Rz9rJ32Artn
         S6bi+xOZq2JFCFgWIEghE6zE8H/BCYsw6gm6ZEToL6GKrs7Ts1j/uV4AMOPQASZvnv2s
         yNJA1I+3YbmIlQ30dDE8ImiWeGXv5MDbth0AC3t1eQCGaLZcR8KZbV9ohZ006+fgTsDx
         NlSA==
X-Forwarded-Encrypted: i=1; AJvYcCX9zlQNMf/slaRnSfjYps8yOKaIRLeCDT9fP8Wb0pylyJl5yf4KGisMWH9jjwJSbLMZq6XtDfuM5Ljpf/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4MyE9kx5uyCwnUKEPZ1+XBcedwx2hX9KTSgF199OcMeWEY/M
	x8FuaWCPMYPCZnI95oKmYqGYh0U4vBcFbVOW1RBRb2yCZvq6hf1II77dT1YJhz6vZKcvu53ye5G
	tIjzf1Khs7jigIjBJ66b5um8kczktkZ09U8N0j8SDJmo74NhuUXU/gGeN3/yuGVdYtw==
X-Gm-Gg: ASbGnctSYeUxZoDCjjff3XL3pl6tXUczE7aanIjHhMxHY+/odm8ORz6vg0J0jtRrUIt
	DU3+NYT6ODgl0Kv9/m/IY11YyQ5DB5v2tArNMH9YP+LRNunjn90XDlWcTwxUv9rZGXzOumGUwTZ
	8zWwnIcbahZv4wHsLnrj1+SQTOeW4g6p9okLND4sllAaeR1sknpg9V/OJU1xu6DUSlLmnzVlai4
	dd2k5q2vqssbciVnsS/gyd3FFba4OJJ6tPG9ugsYicGrWLNRjcU43AUyGQRCZulAeK1tf382SyF
	36k8rnVdix5Bcl2SiK27Am6naRHOAuj5DfGjXuTcrQcYGOK6OzoNtBVo24KEM2YzoY8cSeEzvVs
	f+ggLYqIhB/1zzMPy0pyP9v6dWxhjV56Vcxvz0EMojzI2xnvZ9jKlT8JBeGLBxmOUVx0=
X-Received: by 2002:a05:600c:35c8:b0:45b:8939:8b1c with SMTP id 5b1f17b1804b1-45b89398f5emr38759065e9.27.1756721223349;
        Mon, 01 Sep 2025 03:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6UmaPJbqekrYHbPiCSusYsWRbU13/tRqePxX5ScicjcJWbOlbRWMhiO0B6BAD75QT22G5cw==
X-Received: by 2002:a05:600c:35c8:b0:45b:8939:8b1c with SMTP id 5b1f17b1804b1-45b89398f5emr38758725e9.27.1756721222935;
        Mon, 01 Sep 2025 03:07:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0f85c287fsm12752042f8f.52.2025.09.01.03.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 03:07:02 -0700 (PDT)
Message-ID: <5636a473-2a0a-4d25-95a4-1db48a1752ec@redhat.com>
Date: Mon, 1 Sep 2025 12:07:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer
 parameters
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com>
 <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
 <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com>
 <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
 <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com>
 <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
 <661e6140-572b-4480-9ca2-6a127730f32b@redhat.com>
 <CAKPOu+_KbBRdtB-WiZuiva7Fqsus4x7zBOPkqdhwfYFkdS-doA@mail.gmail.com>
 <25f468d2-8474-4d27-9013-d4cac7675897@redhat.com>
 <CAKPOu+8YMLrtqbhhQ0SgfQN2xErVhZCLEoStRL-YJy-SeHE8ng@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+8YMLrtqbhhQ0SgfQN2xErVhZCLEoStRL-YJy-SeHE8ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 12:00, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 11:53 AM David Hildenbrand <david@redhat.com> wrote:
>> I'm sorry, I have no time to argue about the basics of writing a patch
>> description. I even proposed a simple example of what we (multiple
>> reviewers) would expect as a bare minimum.
> 
> But Lorenzo Stoakes and Mike Rappoport wanted much more than that.

Sure, if it's not a simple "test" function as the one I commented on, it 
might make sense to explain more why it is okay.

> 
>> If you feel like you need other rules than everybody else here
> 
> What other rules? I get confused by different requirements by different people.
> 
> Quite contrary - I want the same rules as everybody else. For example,
> the same rules as Matthew Wilcox who already submitted similar patches
> (with similar commit messages) that were merged without pushing him
> around.

In my example I literally took the beginning of Willy's patch 
description and modified it, extending it by the const-correctnes.

And before I get seriously annoyed and behave differently than I usually 
would here on this list, like ever,

this is my suggestion for that one patch:

"Constify shmem related test functions for improved const-correctness."

and this is the beginning of Willy's patch

"Constify the flag tests ..."

And now I am wondering why on earth I am wasting my time here on 
something that trivial.

-- 
Cheers

David / dhildenb


