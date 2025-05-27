Return-Path: <linux-kernel+bounces-664356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A87AC5A77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 21:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A4A1BA30CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34CF28033F;
	Tue, 27 May 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+OV7zk2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F627FD6B
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748373148; cv=none; b=AIDyh14I5X8EZQLDSxJBC4Fh4iqsUjkceYlUvhjhG1nOi+axBf0ccKbWEATw8RfgJvvFww4GMy4NTimu3iuK4IuXwuPyO73E91GK3ygUjYC63I5E123GyOCAWkpIX+WmLQykm0Dx61Cq/bz6Fw0hJGXvFgXpRYucjvHddl9JV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748373148; c=relaxed/simple;
	bh=6avoUZvlvHD3gtfiVQXttqsdDpoEdcKgnK6Kc3dqTfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A373Ey55com8II3iaveBE667Gmd7RxXEVVAmst0foxSDtdUToA6lHuEWT03+JecuBXIuvN0e8KKtEW+GTJWo9daiJyypp/mTyDEhEnGQC/4F5NXF3rrnghaq91TjAgP2RfRVfWcR3Zu/95VF/cBD77j8oKrpbb7vRgRWFJI27rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+OV7zk2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748373145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+yzRPA7WGWxpTi0N6uRQz/NKAbHwqw9GHtmULWCwiTw=;
	b=J+OV7zk2PiHVANh0PjNd74I2zxRlGCAqI5UXYwav6Ycgjvr0EqBg3RL2/vgU/9Tr7ayeVh
	+U0Jk/qUe6cG08Sdihy8NxsZH2Ywfb+4lzw9l10jdHhRDDbXgS0G8bH+GNBk+kPc9G17Wp
	GNoDilJ04TE6+8BmTW3fDn0W8rxn6SY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-2rQ2oxpkMqqS81QVk3oRzw-1; Tue, 27 May 2025 15:12:24 -0400
X-MC-Unique: 2rQ2oxpkMqqS81QVk3oRzw-1
X-Mimecast-MFC-AGG-ID: 2rQ2oxpkMqqS81QVk3oRzw_1748373143
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-44059976a1fso18298285e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 12:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748373143; x=1748977943;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+yzRPA7WGWxpTi0N6uRQz/NKAbHwqw9GHtmULWCwiTw=;
        b=jpB6ax7+NsCaYnNMFuQovLNd9Q5ojtx/sIWmqqASmNPwdjyINsrHDURHaXc+QfHl45
         RQo2JjbmNb13VmQcTwykAIG6PpvEHrZgi4i5clv339839KVqMW5M8sCbMKMfQPOaq/qF
         kOD49gkECLHQJue8LUJFWgAGAB4+95iSKJcQNfR3qs+RCl7lhHe31Tovz+p684dtCWqu
         5Rn5FgqfAVfTK+cH04siN4M4Abo8qWjCmb+uUiPrriOyi2D4sxNkQX3U5H1I3AlsnC6h
         sJ3q9+ZobP5qPjx6u4sxBf2ZKKktMQ0Psz+SqBg1GqNF1thjGSwyRtLy8Wct/oLtYVf7
         uXgA==
X-Gm-Message-State: AOJu0Yxl2o09ldeu9IzfykcOT5mcFnOxzzEVEcXF72jk7c+8fs1He+Fk
	eRdFnIfv4LC/iWZe/pGl5Vfv9KUUfuE5WrQ64YCv4GmKO5lTV3iBMlv3LDPXjeA6p3nZXJkyBf8
	aTsd1MScasAj7t4/ofaSVsDNZ2QXlART73ft/lBHOeMpWGiSpPhdfZQBJmGG+XVFwRw==
X-Gm-Gg: ASbGncu1lUT1tbHZktObKrx0E8lsMKYKg+s0nf5pD4tOGTUOHzyq3eIcFmaUIlKqOh6
	uj2BBl1geHHSy+Hm2xJVGQxPIpbe7KwjylyV/ZmewOexwkejn9c0wUT+LfrPv4O5VK9sRc3cd53
	ze5OrgF7GG7+D3cu4EkxW4v5nV/OClCBODdXEEF2k4ORxlQCsCOwXJ0EJ67AMFyhrkMo/s0jDDJ
	xzWKmuVAg3BxdjeZ3hhCag6reDg3His/p5jistLOD7+gjJ4rjh6gH3/QhdKTaEEArHSQWNd+Uyq
	vFjV4Ag5vlGcmIqD9C1PZo1wgTYr/p1RwiwP84FHtrQ=
X-Received: by 2002:a05:6000:238a:b0:3a4:d367:c5aa with SMTP id ffacd0b85a97d-3a4d367c798mr10033094f8f.20.1748373142946;
        Tue, 27 May 2025 12:12:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs5gl4BTAMxGWz0mlLC65/j4BMupbFF1nR6wFj41PP6uhuPqzv1+v82lHTM8x1DbNuCwnIwQ==
X-Received: by 2002:a05:6000:238a:b0:3a4:d367:c5aa with SMTP id ffacd0b85a97d-3a4d367c798mr10033071f8f.20.1748373142549;
        Tue, 27 May 2025 12:12:22 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1f997.dip0.t-ipconnect.de. [79.241.249.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4e6dd09d6sm555911f8f.40.2025.05.27.12.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 12:12:22 -0700 (PDT)
Message-ID: <ad77ace7-89e6-4b26-bd11-9b7ce176dde9@redhat.com>
Date: Tue, 27 May 2025 21:12:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] virtio-mem: fix multiple typos in struct comments and
 function docs
To: Alok Tiwari <alok.a.tiwari@oracle.com>, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250527183407.2093374-1-alok.a.tiwari@oracle.com>
 <20250527183407.2093374-2-alok.a.tiwari@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250527183407.2093374-2-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>   /*
>    * Test if we could add memory without creating too much offline memory -
> - * to avoid running OOM if memory is getting onlined deferred.
> + * to avoid running OOM if memory is getting online deferred.

The system/user is onlining the memory, so the memory is getting "onlined"?

If it would be "getting online", wouldn't the memory start using the 
internet or sth. like that? :D

>    */
>   static bool virtio_mem_could_add_memory(struct virtio_mem *vm, uint64_t size)
>   {


-- 
Cheers,

David / dhildenb


