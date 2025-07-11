Return-Path: <linux-kernel+bounces-727831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9386B0204D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A63168595
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9969F283140;
	Fri, 11 Jul 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feoqx0+M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2E18B47E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247184; cv=none; b=ZY3eV6jMmvdaKpMUhrr8FfoVL7NGyE0oh6dADca4RfW4b42P/b/lwChHtc3B+KP0Ajftyo6h8AHCqPFeX4VU4nKBUOcSbuuqcxDptoq8RuKW9kSnk1K0nWWHzeI769+cZ8+PrhnL3eeW+9OCdxameompJuzYPaDcchJEuMpsU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247184; c=relaxed/simple;
	bh=pqrm32islkh4Y2vJ8ehOBHXPAu6/bVZjFZ3KkoHZHx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MePofBEHT43jNg4sl9ZcLFR/nwOVGtrvV6KBB+b2FAfn9/OtP4aROT+QGExnhAzD5+t4EY47uxW6oneK7bDxy0FbFJjZCNo4h6Jtw32JwsqpIDklCOwbK/ztLvY95UPEpGeFr9tzGOiYc56Pv/afbl5nkPf9K/pzsQMHnHuV05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feoqx0+M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752247181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=00niZRA42QozTn1VVi8RS9c50/np/J5zd59pq/4irQ0=;
	b=feoqx0+MUN+wVgTiuTQh/QONprMdLCfeHji3e9ymyCGKP+j9JKrJIz5tBMuob4oDwlOO0l
	z2X3gaqAI80qdLWy0P6Sgl5OZC7AtXbw1Z4ZXZgY1MPQ2wq4Ako87QvkE6DDVJDU1EO4O9
	YJaNm3jjEkzPg3BAQK8enwMhJKn1KLw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-UjWhEwB7M5SAap6g_IjW3A-1; Fri, 11 Jul 2025 11:19:39 -0400
X-MC-Unique: UjWhEwB7M5SAap6g_IjW3A-1
X-Mimecast-MFC-AGG-ID: UjWhEwB7M5SAap6g_IjW3A_1752247179
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so1092830f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752247178; x=1752851978;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=00niZRA42QozTn1VVi8RS9c50/np/J5zd59pq/4irQ0=;
        b=hYDynu+05lSX3dzylYOfCg5zjJp4tvd94+pZ3gneZCUY9g6jnLxa66Iq5n+nFAQgbI
         ptawfmO4svHqmAbq4FcMLtSu28qAn2RfGCYal8u3Ri310yxgdaF9cG6huvjJmy2NasBq
         cNrE54mOOBlnaBKtr0Q8pZA5L9dIX7y9vx0kuveIdoQRC3veo/Q+Zn9dD/wY9Tgr1j2V
         h/Mi4oenSVl6iBGbs/AYM0BpWLSh0UekZuR7Vh1NFXM+7eFxNMJ9VSqFN/IljhtDXyA6
         t4U2S1f0Mj+EDWoVE1AlEB2YL7zzfsTFmYS2adS5JWBt9MYhSnjhvGjhLFfdvHgRshmI
         WeEg==
X-Forwarded-Encrypted: i=1; AJvYcCWqFvWb55he2XcmtD5UM1DC+8HqmBANP1vcrihT8v8rcitFXly6iMv4Eacl0sLiHYe/8uGp7m5BpNZ5Lr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwipcM2deNYfYCEWrOw+7buVlZiZdl437SUHGOMO+V3J4JJsMYH
	f2PuG9G/gAwA7p0gyYp9Lw51SnTXtcj0Fb1SX8W5akkqE+GIk47oj8Zfgao2T0Y41xZ5sjag5Mj
	TQI0S2g0tPFOQG9W3z08bMWdXBd4RTHEdyeNsdhjiKJ8EzYrStN6c9V/BNCDLT1TU2Q==
X-Gm-Gg: ASbGncvz719AgFl/HlEe1xBwb6HIduFwbp1ETtcBF383BysBiH40qYFOj2isoIe1lTB
	fowJfKx2pd/DCyp7HH22F+rwr/yDP5F3Ytx8BTxhrAtbmTKkyV5ZabJXCRUPLCRN88U5FBrsHnQ
	YlLUxaX3kz2gqSz+4UUrMOkVhP4dG92iRV0AVG8FwqacYvst3hlUaQATuyUxz+fidq7PQUeZ1hf
	DhguFbeFdD6HWey4ISYhLCOGwFnfTVzJZKWxLAYoC2Ut0q6jRE0jYQah25ffLhmAJ50TUMYGp6N
	u+0YPoKXrvqVjulF9P7Xh6YMd+3Q1cSvA7cIkKN31xv9LevreNJZl7b98Hiaz7zYo/dRsJX3ih2
	vbjyaSkkCh9Mn5R06AQXbveqApLsiO/CsvtvxR4ELEi8eo3IcFBELFxMb84u4ib5mSjs=
X-Received: by 2002:adf:9dc1:0:b0:3a5:25e0:ab53 with SMTP id ffacd0b85a97d-3b5f2dfd725mr2510224f8f.32.1752247178528;
        Fri, 11 Jul 2025 08:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7S9JKeeKNNYphsrKWaudZSKODItxMUx/IDkhuFl55aF46Hho8OcqsAyD48XHyymEVyekDdw==
X-Received: by 2002:adf:9dc1:0:b0:3a5:25e0:ab53 with SMTP id ffacd0b85a97d-3b5f2dfd725mr2510187f8f.32.1752247178054;
        Fri, 11 Jul 2025 08:19:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455f7b86bfasm5867215e9.9.2025.07.11.08.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 08:19:37 -0700 (PDT)
Message-ID: <da3c6039-c7e6-4282-961f-7140e3f53dea@redhat.com>
Date: Fri, 11 Jul 2025 17:19:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_owner: convert set_page_owner_migrate_reason() to
 folios
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
 muchun.song@linux.dev, osalvador@suse.de, ziy@nvidia.com, vbabka@suse.cz
References: <20250711145910.90135-1-sidhartha.kumar@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250711145910.90135-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.25 16:59, Sidhartha Kumar wrote:
> Both callers of set_page_owner_migrate_reason() use folios. Convert the
> function to take a folio directly and move the &folio->page conversion
> inside __set_page_owner_migrate_reason().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


