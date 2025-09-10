Return-Path: <linux-kernel+bounces-809795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C17B51224
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69CC169BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1605306B33;
	Wed, 10 Sep 2025 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLrEom9C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE52D0C78
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495190; cv=none; b=FXExEta1H9tuSFsP9q6xhg3ZMQvyiA+GYfrgRfwMvsD5IYzcBBryqFt5nVeAWhtRcR8VoHMt20mhqg/AVkliy4Kb3jTRyGUjrNHYe12fYYySO5o4pPpgWizzRKM/MpJcUMJB5OKHiWNQrv9mC6PrQcJHvURtbfdDDI1Qr4yqfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495190; c=relaxed/simple;
	bh=/U1Sm6pWN7N60ObpacZqs5Kp021Uw5seGjNYIKJoUj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ix1u/xum8balvEZg3nlV6T7PrQHrcYAOzgWidFzNZwcy2UIGaq8PncvpGEvzEPZBs+c982rmo2sFfaahNJuG/06yMOij4ImLVVwx7a8Jii9m1nPxvul1fFBiDbrFAvuMCm5jHKE9x1zeOxzo8IcLn/AQdOxJ9g72HSTiLpCb8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLrEom9C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757495187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uJ0vl81zWTULU7/TV/0KZekw1CnLSGSEeoa8VD8/OBo=;
	b=VLrEom9CKHJOxkn1giDOPm4RVuYcjmKLHubq3puqPkLt4rAMgrXe1qc6Cta269dq6da8jd
	pF22OYmYI1OtdjU4/vFFto34x0Nhk7E5muWEIhm2dlr5xuI3knTtosI7cWZS0ymPbDlOKz
	q1djiuJ07bHU44DCBItuWr0o2S/aYPA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-YANepiIrNfWYO6kWzXbmyg-1; Wed, 10 Sep 2025 05:06:26 -0400
X-MC-Unique: YANepiIrNfWYO6kWzXbmyg-1
X-Mimecast-MFC-AGG-ID: YANepiIrNfWYO6kWzXbmyg_1757495185
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e403b84456so3388083f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757495185; x=1758099985;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJ0vl81zWTULU7/TV/0KZekw1CnLSGSEeoa8VD8/OBo=;
        b=HKAStguLMxl7WO8XDR/eO9nXcUG1gQmU4RU8F7csiiTST51oQEqBN+FtGbIEucei1m
         ltt8d543na0+ykqahYOQGNle2NREai0Pk2hP8lRbY8YzjleQvglOYvNFV3MUAM8md5S0
         Rfh3sav4/j9E4wNWcrXBmhSG0CTD1QRoNe20ckkGGEcIjJuYwnoIq+7+sHH/NHqQYuct
         0oEfRe9fefPIbUM32mi5e0D9xTBR7+B83nndhinHqM0P0WlqE59np471Z4y73nXo15e0
         H8ln0iWim6DG0+dl6QujmGk8FZur6DnAolnBn1B5isfKduU3XiP07oRz1OEvGaiUHrSQ
         +Jfg==
X-Forwarded-Encrypted: i=1; AJvYcCXIK53Hc6+vXcbIZhovedUYEfUOsoEf3sPcLUpRb74BzjL9mZNOxGgWdGSHEgWtRp/DyYhGYiOHvXp+yqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNI64rHF+LTDJg4efiBEKuJbv7eNgT5IUDzLNIlvdOBVPyfMs8
	wgcmbD52z/ajpq+Q7+bjp3pe7p+/yPi2Z6MxK3lz6mRksvpnVQW+kFDAiZmN0NPd7LdmMRH7sTx
	wKkOChmwr62I9X5eSUzAzsvEpK+3vPrI8lC+oFqb1PvFfDyH9zdD/b1EwSHAbDbWoug==
X-Gm-Gg: ASbGnctW6bRfvUSyzOO61jPy2PS/CU9uO3tMwKpeeid4/vp5P/9NaLCkyIGGMGr+KAh
	Nb73140sF4XbASCsHgXaPLPKLJKtx2RpoDXot7q0AuyCiruvo2NUwkziYGGV8ysjcXofADBioY7
	7qzHh77t0LxgPlzWRE8H9Wr7RvlUD0HeUSMmyxgzHSxVGflsVjCsKRN9/Qvapa0eHbuLt5y7cT4
	q3zzX0viONus64aAJ4pnA/KhRL9IMJwW23qSlZCztX5rPccsB3oHUksf/PyXQ7VIh3PJJ0ipUaw
	kKYNFlu7jmMCxgon/5z0cMD8lAuVGBt8aIWXT6hDZkr89YO/Z6CzKhEjZKU4nF5X3xD7p9rhf54
	RXW9IumfyXhXkodUTzu8Uy7imihoMD4suKecFMTruCAynj21f3AeumjEqO0lGMMaSRFU=
X-Received: by 2002:a05:6000:2383:b0:3e7:438e:cddb with SMTP id ffacd0b85a97d-3e7438ed1c0mr12322881f8f.45.1757495184904;
        Wed, 10 Sep 2025 02:06:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnDIjwgs/dbDJSod7IKxf2efZ1VuMA7eS98hMQupMuU8zTPuVh14Fi6ijNaBLIti3R2ACoYA==
X-Received: by 2002:a05:6000:2383:b0:3e7:438e:cddb with SMTP id ffacd0b85a97d-3e7438ed1c0mr12322848f8f.45.1757495184480;
        Wed, 10 Sep 2025 02:06:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238760sm5929620f8f.34.2025.09.10.02.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:06:24 -0700 (PDT)
Message-ID: <1d5aa773-89ac-452d-999e-6a0c8ebce994@redhat.com>
Date: Wed, 10 Sep 2025 11:06:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slub: Removing unnecessary variable accesses in the
 get_freelist()
To: JaeJoon Jung <rgbi3307@gmail.com>, Harry Yoo <harry.yoo@oracle.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rgbi3307@naver.com
References: <20250910005957.54108-1-rgbi3307@gmail.com>
 <aMDW1urp03myzZFi@hyeyoo>
 <CAHOvCC695c3fBphYvVz0Gk3H2hR9O2GaQLPvOVSZbUyv5C5rwg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAHOvCC695c3fBphYvVz0Gk3H2hR9O2GaQLPvOVSZbUyv5C5rwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 04:31, JaeJoon Jung wrote:
> Hi, Harry Hyeonggon Yoo,
> 
> Thank you for your kind and detailed reply.
> 
> I hadn't thought of the union data type.
> 
> Since the counters, inuse, and frozen members are unioned within the
> slab structure,
> there is the problem that the above values are not applied to
> __slab_update_freelist() and try_cmpxchg_freelist() if the existing
> code is not followed.
> 
> I canceled my patch request.
> I apologized for my inconvenience.

For the future, please

(1) Don't clean up code you don't fully understand

(2) Test your patches before submission

-- 
Cheers

David / dhildenb


