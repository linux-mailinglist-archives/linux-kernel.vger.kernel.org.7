Return-Path: <linux-kernel+bounces-843988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF2BC0C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF743ABD9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C82D6E71;
	Tue,  7 Oct 2025 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqUflKvv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3F2D5412
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826870; cv=none; b=gP1VcceXIrRv9npS6Juzgweb1aAN/6FYrt77HtwALruufn1/jNn5Z6E49N9fsw0N94LTTvfOyhgAX/coBblynH9caRweQ3a4ZUxZ/FnjdMoh0ivpexOCu7M81w6LGRAHifjAMU/TUp/8sYMjGS34A+uGO84gW+GISc8BVv0cTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826870; c=relaxed/simple;
	bh=UKaOmYja6GWpkgqvre/t04wN3dIImSsvquV2d+dVLSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqPmHehHl15S+ea90UB3VB8+vDd/Piv9MXsEsEX3J7GPF69uhuNX6y7W/iGh/gYpCxmbcSR3HUxIZcDuMKO/F5Pada30Ln58lm7V4e74qqw3zy2SwxFxJyGnv199cmdb+nToJgVc5c9hETAD8pP62QyVIYuro0tptaBa6fw12Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqUflKvv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759826867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TMvEcaAUNKWeuUDEQRfj/CMnuKj7mf5VRb/CtKax4GI=;
	b=RqUflKvv5+gU/qM4KxAa/XudWcUB44zfSmcbJGGAlIC2kQvz125QwpzYy6eskM1kzZbUlN
	87LsHyphj5xc2OlNf6G2afjcq/muoJQy/HHHhi4Jrm4id4uly29jJ8SCG+u/WF8IxpTgRt
	+DTdQ/aGG8bAcD04gIORK/VP/4wALWw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-T6tSB0NIO2OYpQIZV9dwFg-1; Tue, 07 Oct 2025 04:47:44 -0400
X-MC-Unique: T6tSB0NIO2OYpQIZV9dwFg-1
X-Mimecast-MFC-AGG-ID: T6tSB0NIO2OYpQIZV9dwFg_1759826863
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so30991795e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826863; x=1760431663;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMvEcaAUNKWeuUDEQRfj/CMnuKj7mf5VRb/CtKax4GI=;
        b=DCVLxPSoWo+ofPTfahRh7NpRSug0JfV1ysqknVV/FtYV1EHjmjmf46pHCH6zx1Ihjg
         RNjMGZw+xlbRvW9Ln7VKUOmGrWBmwcjVbmm+thBhb+euA4iGiiq1aNCdOzZz2ojmQc6z
         ApL9WIx3Hb2n2o2h2k6LQLmP+DewY6BhY9Hgpb/nW4RwgWsDP5W1HxbD0TkKQneAmrf9
         WjWIGUvEaw43p/saukP5Kj9MDBh3DUpSarV3C7pyJrZ09talh+pjfDTEah+WTRzaneQ+
         yGZF7z5h/Xp521C966slpyQZutA9c0eDB0omNG9thlgkOGv+ztN/FxslLEcDLqMTsadJ
         BUlg==
X-Forwarded-Encrypted: i=1; AJvYcCXBP50dvlSqNepN45lgXaGJBgg0SVEuU06RE3w6xoYhxjgRocSyZnwLbLwTszUzRKnJmo0lHXS+Xrjql6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfInYmii816OhNbOA/m31d641Q/ZLrj9lr1vVeRowHGR+hCXR
	VoxhysxsOa2hRJO9y7I3LxG7R+LLtuDHqznC0GgpYb1zAGKahqGDev2VrrjqlxPYpcgAz72z+H3
	6zjKN19V03JfH5wt5jAvZh/2xFu0JmGCt3EHLhAAr679ldMZXYGPPlIB74wBTglAWqg==
X-Gm-Gg: ASbGncuwMQnvsXLah34Z/8AhiYBJiUUW+fXrVTPkdxJg9+Oq1npBIVPvfGsnDxHgPtC
	rbsB6ZITkCpFx9/Q8sF3Sz+uCtYYGQKExKQZ2x5L6YbywpiB8ILCfDmod54YNOSCjGPtZ0EGL1F
	UYvJihrsw/hBChnbR51wJLlcO6GxGAId7E3nus8x+h2qxlbCZnSWQ3hIb46UAnMwP2fRzmCzGDS
	uTMriil6Ty+RtVF6KQliO8mUU3jzbdCI/E7WX4HfPIZcIAR8KP4/YyBUvZf//nkUwz0MPLRJcau
	WYC51MXd3Vv3zoTOVm1eAzOjgJPyVy4lSf3QNTl1sTaUB7bUUVOku0jrYjzPgiMcWPl/wgoNtNF
	VmkGyO8ax
X-Received: by 2002:a05:600c:c4a8:b0:46e:4372:5395 with SMTP id 5b1f17b1804b1-46e711525b0mr99755245e9.25.1759826863348;
        Tue, 07 Oct 2025 01:47:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6E08SlQ39Ofng71i7oQxAmRBZ2Or1fpuhgdUCreDtV6AJiPLu8VnxLfgqcMNCI0Ol3Lrr1Q==
X-Received: by 2002:a05:600c:c4a8:b0:46e:4372:5395 with SMTP id 5b1f17b1804b1-46e711525b0mr99755105e9.25.1759826862923;
        Tue, 07 Oct 2025 01:47:42 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a265f6sm292260605e9.20.2025.10.07.01.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 01:47:42 -0700 (PDT)
Message-ID: <804acafc-2de9-484a-990e-0338fc525862@redhat.com>
Date: Tue, 7 Oct 2025 10:47:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Replace READ_ONCE() with standard page table
 accessors
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20251007063100.2396936-1-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251007063100.2396936-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.10.25 08:31, Anshuman Khandual wrote:
> Replace all READ_ONCE() with a standard page table accessors i.e pxdp_get()
> that defaults into READ_ONCE() in cases where platform does not override.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


