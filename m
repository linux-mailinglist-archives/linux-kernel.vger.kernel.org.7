Return-Path: <linux-kernel+bounces-741053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C2BB0DF82
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B681892657
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52D2DEA7C;
	Tue, 22 Jul 2025 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpFeNFoG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358892EACF9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195659; cv=none; b=aMCdhiMUIIaE6Lh/GlkXuqYOOTSMxZmk/WBWhCGhSIdSN7fCqDvdoPkoj5/3MuP7u2OiY0UWADk2LaV+472iWRKyMCRW+WzlkvInGgswd18slXHbZ8OV78J+UiXRnLgkFDXdWbH5BZg1rZciDEu0jBtlIrOlLv0lc823f/gE+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195659; c=relaxed/simple;
	bh=yid3Pf8JVy5PVhiRX1APcX67usBd0s//BwR5DPx2DGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b92uBY1Lk8ATn1NKws9rBkTCcG+GO4FkiJrpp/54wWistT+x2lQGRT1wppDXeb2BRwgHs6mpjYlmiKl6dxfSmw0gEM//U2FAzMTGV8+sYVioVx39pR6iH1cCrYmULLAVIMF4TsO0jeAQWkHLFXZhF82snOMyrnyYk1TJkKbFuUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpFeNFoG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753195653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJ8vXE+Vczyk3Kx59J7cCpTx7+wsx7aT9hfzBy8n4pk=;
	b=bpFeNFoGP8WdTYwwrUu7/G2tHF2+87y3QOK8Db9PQ6a6YhiMyQQUf3YxKKEgFQ8AYt0JTD
	sKUSUS1GaXvw/gpnS+Ud23owOCYmNmPn/8nlhZN6almsMMuLj017wxwdQgjC1NgMpnBkax
	r6cvyiGnPqf1TPQBktFELsinQ3zAlug=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-PwRQourfNxmdHeGA4rD7Vg-1; Tue, 22 Jul 2025 10:47:30 -0400
X-MC-Unique: PwRQourfNxmdHeGA4rD7Vg-1
X-Mimecast-MFC-AGG-ID: PwRQourfNxmdHeGA4rD7Vg_1753195648
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso3715718f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195648; x=1753800448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ8vXE+Vczyk3Kx59J7cCpTx7+wsx7aT9hfzBy8n4pk=;
        b=JpkEVnw3RhXElCBTXNX7qRrq5AQVIPiPdZ7umFHqhaZpR9w4IJU/ayIiRFndqaG5+v
         7F2hYuDi+RWpKGPHhmAccy1crH0VogBQJDg5zQophgRBBvBA6u7haIe8vg9tLASH3NfE
         1IDnphYGk7t7w+nAUJ+hGJxZiA2dZafNAZ90Md8wwtT6mxw73i/pQap1cgYiFCrXCXA+
         SzYAxmSqZxuCcjwZeAOmL96po4SQBdIIO1+LbEAytQ01HPGiTPngcrLuIa3NjLX9Pf+u
         AAJ8IHvR1hGssYodUxao0SgmZXtmgJKGo0h6RA+ml76jAavfbk5yWe5560LZLDYimUf5
         gL4A==
X-Forwarded-Encrypted: i=1; AJvYcCUnpSwkKUyTCjP03YYdRokcaP0i+8TOaO112V7KEZivb/NRI/NlJlQFmCFZc+1uzhTHpiYt6eCOisqdYE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynjeMXV8HKtwyu4g1k1Vc3JolVlOmTziT6AXpp5pZFEFJ2ftJd
	W4HtjnCH0QyzWwTG9eY0NsY9KqD97lDG/tyX2TcEGx4cNwY2JtQ2rlybyUO+QvKMIv2CuED1bda
	VjWG+fixECYK8VO6fdQhukbp5dUHlxs/wjJciO8HiyoJq7T6UHcB0sp2xk15FFQ9PnA==
X-Gm-Gg: ASbGnctnwXSy43StfAV+P+Z9cXIhX3ZOvDBdF+1uCLk9Bttm0t9U/qK7To1IwfF5cXi
	bo0l6qU4Hy+P/8J8edzCFiW/WCUx3Gcg3mPWbew8vAHzfR3Uq3yEPE49rtislx2zXDD2FRSrrtW
	vEl5YMN2RvFTIFKsju/l1WvbMwUubD7k4j6NAI/NYupwK8OKvU2fU6k/16dLFzaujLiR3yQMz53
	tWj0pkoa2iTkkZxyV/Qgd7avxurbQvyjRMZU7wz+LZ2PGSapHsDyMvPPSwTEzaW5lMquz1RWIJ0
	IFF8dPBIMK94ZF04rUm6LhlA4cS11bvje4sbMLhKa++Nqfet/fV/1lYldJ1sW6IrH3mwr24Eq/z
	R7BP3bSjqYC4=
X-Received: by 2002:adf:9d83:0:b0:3a4:f7af:db9c with SMTP id ffacd0b85a97d-3b60dd8d273mr17104752f8f.59.1753195648522;
        Tue, 22 Jul 2025 07:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8epZG9iPVbWXB6bK+gM/AgDezTa6OD5QuPw/xFJsVYHane6m8Wt3ZuB+vNEcUojz/bvJE8A==
X-Received: by 2002:adf:9d83:0:b0:3a4:f7af:db9c with SMTP id ffacd0b85a97d-3b60dd8d273mr17104731f8f.59.1753195648084;
        Tue, 22 Jul 2025 07:47:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c8dfsm13644741f8f.82.2025.07.22.07.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:47:27 -0700 (PDT)
Message-ID: <d1bc6357-9bdd-444e-86f8-9e6955f46624@redhat.com>
Date: Tue, 22 Jul 2025 16:47:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250716081441.93088-1-nbd@nbd.name>
 <CANn89i+SHNfG3UxTOwr9kE26hbF-0_E7YJpt=3OHriMGLG7PeQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+SHNfG3UxTOwr9kE26hbF-0_E7YJpt=3OHriMGLG7PeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/22/25 4:04 PM, Eric Dumazet wrote:
> On Wed, Jul 16, 2025 at 1:14 AM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> Only handles packets where the pppoe header length field matches the exact
>> packet length. Significantly improves rx throughput.
>>
>> When running NAT traffic through a MediaTek MT7621 devices from a host
>> behind PPPoE to a host directly connected via ethernet, the TCP throughput
>> that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/s,
>> using fraglist GRO.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
> 
> Shouldn't we first add GSO support ?

I *think* the current __skb_gso_segment() should be able to segment a
pppoe GSO packet, as the pppoe header is static/constant, skb->mac_len
will include both eth/pppoe and skb->protocol should be the actual L3.

/P


