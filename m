Return-Path: <linux-kernel+bounces-789994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C155B39DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5597E468034
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F42652AF;
	Thu, 28 Aug 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAOiYiNM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407EE30F7FD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386052; cv=none; b=OP0j0O7SiDUK81VJ2lJPT3hrBG4kqxF6Rf94N5erEg1n7WoPgfk1lef5yRqYB4mwkkllxnd+Mp+zHTkrdSHAh4audPURRdC2EfOM3bAvbFFpMp+iP3U545LhEw3keGCXFZbC1lfyrgPswYCyzSf0jcE1/sWCQ1OnxdRD08wP4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386052; c=relaxed/simple;
	bh=fZ7mCy712jwkqJCbUdWZcjEV/0foxoNgu8cEaz4nlXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uK4tzBS7cCgLeSsXIQZdz9EzAs6/V7yzEyVC5X8s1xiY+CHw0rRKZnjlGKWpCCxPYHW++42on60bCUNxuXF7q7RnYyn49dn8qIkOFQpXisUveB92eVk+Rs1mah0Hc6l6POgxGjrEcmyTNunVk3You959tsLWzPM+a4olgU+0sEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAOiYiNM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756386050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RtQBeUdd3HNd9DtMHvMDfjzQLSWWJUcAxmafvmO5El0=;
	b=dAOiYiNM7euzQhflrBYErHk6IfPKXIl9vzHSz7YccGF2Jx7PkDD+214vLsFhXtZ3icoOQc
	6Z7E4D1PMydxMC7zJQ6nWy5V8l0WZvfLNXLwKXBGRvnvqcF2ImwY90L63bH3l1WOJFeLFO
	83wTxgl3Z1Z55aeBYaOKpGyA27RG+cY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-B79y-52MPr-hV1QFkV95zA-1; Thu, 28 Aug 2025 09:00:44 -0400
X-MC-Unique: B79y-52MPr-hV1QFkV95zA-1
X-Mimecast-MFC-AGG-ID: B79y-52MPr-hV1QFkV95zA_1756386042
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b71fe31ffso5502085e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386042; x=1756990842;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtQBeUdd3HNd9DtMHvMDfjzQLSWWJUcAxmafvmO5El0=;
        b=eS8RCFqjbyJiHiYJMHwCA4qmH6AHtWH8cWRkD/aMppRCDTLAnDhrOt0uzGyZbpfifc
         wIZpDcfBDd19mgQC8KEvbrsf7aXvhI9rGjTDgMnPr8nSauz/JcZwjaOWabn6Iz/F17PI
         fOPA4KooEzcdqIBUsYm+msYeQNP7bg0SCd/pUjw+F2KHCE1UuIgkx3ZG1k1lXVNbiDzC
         cQ7sP6lCfx8sANEPN7+UBdXiTB4D6We1L1dxfW/B88hTzYOYwghxBRA/jZCk5rAuGLza
         GAHKc/F+6J6aZLQnGGzidqVE4nW9vDF5j6xT/G27n7IjlPOhzJ6JNnQ2OD8jlNMLadw3
         R1vg==
X-Forwarded-Encrypted: i=1; AJvYcCVX/JsKYEKULu1uRcTvCWaKfmakFjNq0utZwKZGgoQk+sQi+OD8ZwiYHEw4Sx+Wxjz3II6cuH19Zh08vS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye1T52RjpZGiX569WCsXPGedltaEjGzPr7lH25h+cvgWtKpjto
	7wg1C/8En33G8nxNWZ3W2bbOniAd9Swk3RIOtdTvXfMi12fUYbJqXio2HxKUwG+hl2LOm83eW3t
	owXniiCyGoczU9qugHb2EM6OknhDPDyCAV03ht1T64+tUWGc6SFxeejeWG/L6qBaNpA==
X-Gm-Gg: ASbGncsR2/EcnZVl2EvNn3CBEixdOmflhvJ16qt9Wc5/OX97B334pYK8TZwIX0FXgki
	OsOZqs9xI5bMLGN1JYaEzhLkNnGgkWTBs+aNFMG4KSzxBXBpsHZ3P9Ip8v35KTSfwnNeH7VUUFz
	pdY8mM+4e/RnrmjiftNOmx6Z3s5n0WnuyxmaBqH5R93CElDKzQ7p0EHb3EQ9vqbV3zDRW2AA6pY
	4EJxQ7VM4AMMYe31XwTiAA9JWDDCth95gx8IdxlRkOUuOpXt32AncMXWyL8v+LrIllSPIfUuNsU
	THgK+daFB43bFxsK1HzYMzp+oXojV1k/TFaGHrJIUf4pGwt+VcC4nSTy+T7PHs1q8FR0HLdoC2z
	0/zGYB/iYUnvNamZz++rLE3TAqEdngH/DaKh1Y3wqv6kJi0C3jTyOGEa06sjCuFa8qFI=
X-Received: by 2002:a05:600c:1f12:b0:45b:71ac:b45a with SMTP id 5b1f17b1804b1-45b72e0ed54mr51406205e9.11.1756386041782;
        Thu, 28 Aug 2025 06:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE26qeewFDxQ026gPUPF2qLNE0dfV9EswHCMTuAl5GAtqJt7GqVuP0lwbU7SsJNaF5e4hbArA==
X-Received: by 2002:a05:600c:1f12:b0:45b:71ac:b45a with SMTP id 5b1f17b1804b1-45b72e0ed54mr51405925e9.11.1756386041301;
        Thu, 28 Aug 2025 06:00:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b71c10e3csm73690915e9.20.2025.08.28.06.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:00:40 -0700 (PDT)
Message-ID: <832e89d4-fc7c-47ad-b375-6af0ce796d42@redhat.com>
Date: Thu, 28 Aug 2025 15:00:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add `const` to lots of pointer parameters
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250827192233.447920-1-max.kellermann@ionos.com>
 <c688a2f6-375e-4a00-8d44-6a833e3d30ef@lucifer.local>
 <27a21510-e9e8-4eb2-9e26-618c103d49c6@redhat.com>
 <CAKPOu+8DbXY6wT_8gcqLDpyZEg0=En6wOYtHX_VkUvZ_oOLHSg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+8DbXY6wT_8gcqLDpyZEg0=En6wOYtHX_VkUvZ_oOLHSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.08.25 14:40, Max Kellermann wrote:
>> On 28.08.25 14:24, Lorenzo Stoakes wrote:
>>> On Wed, Aug 27, 2025 at 09:22:33PM +0200, Max Kellermann wrote:
>>>> For improved const-correctness.
>>>
>>> 'const-correctness' in C is extremely weak.
> 
> "const correctness" is a commonly used term for this concept, and I
> find your arguments against const-correctness "extremely weak". I
> don't think discussing the benefits of const-correctness is worth the
> time; the concept is trivial enough, and if you don't already agree,
> there is no way I can convince you. Let's agree to disagree.
> 
> On Thu, Aug 28, 2025 at 2:29 PM David Hildenbrand <david@redhat.com> wrote:
>> I recall that Willy did some more targeted conversions of that kind in the past regarding folios.
> 
> And I found many more commits adding "const" to pointer parameters.
> That shows this kind of patch is acceptable in the Linux kernel.
> 
>> I would appreciate similarly doing it in logical chunks.
> 
> So you suggest splitting the patch into many?

Yes, for example focusing on a specific class of functions like Willy did.

That makes my life as a maintainer and reviewer easier, and allows for 
holding back some of these patches if we expect conflicts in that area soon.

/me stares helplessly at his overflowing inbox where #submitters is 
significantly larger than #reviewers, and the majority of patches are 
not in a form that would allow for any kinds of easy review.

-- 
Cheers

David / dhildenb


