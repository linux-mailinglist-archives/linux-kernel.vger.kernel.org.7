Return-Path: <linux-kernel+bounces-864519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53970BFAF58
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA87A1893F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1456D30E83E;
	Wed, 22 Oct 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/niiM1Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC430B505
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122633; cv=none; b=Wp547B/j9WtUdq8rFUNrAlx1y1U9AajJed6cJIBDB22A0a2e5AVkrDbM2rn/bob9T7A4hz7cf6HoFJZPD7MiXxLpDmbwjQ2jTWXF2X4Xd9POcMHgVF6nGoahveiU9/h3OGHrCzQZmmnYnauqZHHIBIs8c+eepgdHAKi6RNEC13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122633; c=relaxed/simple;
	bh=MQFGP/GdT+B0HEH10HMoHyNYcc8pQAd8Ff5+/hU6YTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWU1EcXOqoqcgrA6Rpy+HUHIg3Wp52Dl1//5FdXQMzX/sn5IoUMTu+D/3Fj7ZMQ/jtN15sWeFEkXJeXBLj45CfdRh725BvAJFX2vSUN1TSUuFlQi8aXGql4hrM9v9C2yyksM63IZry8jwKkG7H7haz5XaD0e7YeMjI5r3CVjNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/niiM1Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761122630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jkHMky5mCobEjmAGe9TQAKstGmetuf8oWgBGBX4vP2s=;
	b=H/niiM1ZYtr2S+9WmRrcF46HDQfkHsy8/yrHnRJv/2TKhLJ0X8uI3YID9tQbee74pY+9wN
	URlvDypR2oHnCN1PLorZ25wzjXtDGftplHM1p1A9LhxIxQC96hCbsxSE1yEIFGoPn0Ip+T
	1Pf23WJgjsNffshc7ARHgghWNcHJCmU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-7iqmedRyOzWhyt-DQAtZ2w-1; Wed, 22 Oct 2025 04:43:49 -0400
X-MC-Unique: 7iqmedRyOzWhyt-DQAtZ2w-1
X-Mimecast-MFC-AGG-ID: 7iqmedRyOzWhyt-DQAtZ2w_1761122628
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-427015f63faso3297050f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122628; x=1761727428;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkHMky5mCobEjmAGe9TQAKstGmetuf8oWgBGBX4vP2s=;
        b=CAuIM5Y+g2AR/dRFVG4aOUYsBTbwUeRJKZKgX+nOBykDbo1gF65O2dCsgq/NI5H+Wj
         c9qUKwvtgrfBISnRwYVqLZ8+RGs6vgeeGux61k9tQbtCwyfkrzHsRdGGN+Bi4JOEsLm2
         0IghtuRKPONMnUKhNAdXTHTZjP6iiicn/FZGgos4UOnVi1HFlRuQSROPxrizZOqAOZng
         aBGvlKALxYo23EMQxLWIVFaMUmX+5APD/XhThWb17nKRHoZu1zq7AlU3U1bjf/AkDWdZ
         5j06xKWmlp1AbVfNRQQ0LvRIBmvgqALc+7ee6aNcVRIjf6Au2unmwFHkvgeiO5E7QP+e
         TJEg==
X-Gm-Message-State: AOJu0YxFY1bqE8ms8x+d7yQB7PiQuh5lWhamAPn4lRGVSuVuefWQlQ14
	4B3XlPjKWafHY+ISoJ4ilMirdd4i5MGkzpqhDjAxPd5fdyDhxw9hmK6Nyk+EddFE59g7++ntxdN
	j3ZG5eo3TzVz0+nnSDhqYjji/dq+/BEBw41u8bcBgWKaV63tL8wuitxyWql/LR6kamg==
X-Gm-Gg: ASbGncvqM8YmBgUsLQ5XF6fvf3ekJkFjdocAG5eBscB/JiSfUD5vTs1iZP5nQGG4Dff
	w0LuoNNJeYOdqD6Pn0lZ2ZGFtaH4tyhiRACk1MxTpd0SvOYygUsBAEFvGiTZQMCZ/PY9p5gheAT
	uxaLL1bZT6zaK7gDpXK13zpOpO9oIFPN7ZCuHqPOFqedtaYdR8PhJgXV6X1OVHRstFWOImjVf+k
	W7U2hWdnJY1lP4efJ/R8dvVxXT9haSZvRVAMfczB4gmKilqJ0wEx77ZAoaSZ7ZwCObEfo9l5olg
	FznhDiyaxK5EjszbnO0bhkZN/g5ugA0wohojF9m+K+Wwa8Q2+W+8KLcfegxciLnEOPwm2S4WHl+
	9jMs03LM1jeYSXpNPJwUEuzx0phe98oBAxLGTvBFS76/zs7IzPAEFl0Ro5yiX3oBMXINi2JGs/z
	pRZ0zr+aS1OdbXCFIfeN0o6XiiTAQ=
X-Received: by 2002:a05:6000:25c5:b0:428:55c3:ced7 with SMTP id ffacd0b85a97d-42855c3d35amr870760f8f.28.1761122628115;
        Wed, 22 Oct 2025 01:43:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwoT3C4h+2nYRtAEAp4gukXLbzQesuywB6jEq9IZ/b7/4k/4nUiirxc9OucZncsYgrM1Y8ag==
X-Received: by 2002:a05:6000:25c5:b0:428:55c3:ced7 with SMTP id ffacd0b85a97d-42855c3d35amr870716f8f.28.1761122627657;
        Wed, 22 Oct 2025 01:43:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-428566a7906sm1313560f8f.38.2025.10.22.01.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:43:47 -0700 (PDT)
Message-ID: <4b280f08-7ed3-416e-8f8a-d30cf0b34c01@redhat.com>
Date: Wed, 22 Oct 2025 10:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/23] drivers/virtio/virtio_balloon: stop using
 balloon_page_push/pop()
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
 <20251021125929.377194-12-david@redhat.com>
 <20251021165854-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251021165854-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 22:59, Michael S. Tsirkin wrote:
> On Tue, Oct 21, 2025 at 02:59:16PM +0200, David Hildenbrand wrote:
>> Let's stop using these function
> 
> these functions

Fixed, thanks!

-- 
Cheers

David / dhildenb


