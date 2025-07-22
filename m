Return-Path: <linux-kernel+bounces-740485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566CBB0D4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B39547139
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA0D2D8790;
	Tue, 22 Jul 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFlJYYOu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236592D63F3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173404; cv=none; b=GXJon/W/PlCGcw2DNIcBPxA/+0EOG61I2/hrs33b0CoHWmmgbjPuHb677uJLKXukgZtZBubkFv1bdm11z6NmT+3Gsnvg8WLMIwxlk24WhbAAnlBAQc7ZTGACMWp7uQ6DvVNOp3x1c9+TZ4LusYt54cWRDQ57S4+FJ/ybN5kUApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173404; c=relaxed/simple;
	bh=wNliSoTcua4ZI5Uh3yJ1tul76CVVgm+R8c7tgQHEW0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q38OsCcbgUqa4nCVsISsCRBj5H1FBtRBS69tAQutdPE5Xe+YvBij9t52NbDmqvvlt74AOC/U8cid8NKjIqMQf+fPc7E5DXJicuTqW9QRCil/nbkoUkEmWWm0KTTGiY14UnxEDymLSk7xFo45iS1dxSEG4hVBWaPMU1LWyse8CPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFlJYYOu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753173401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7XQEQoPcNWIcIvp9Ofoqco5TAp1Io1j1Kf8hikrefc=;
	b=YFlJYYOubKnEkvArwxluWIHqAMA9ILp8LysEmB2wscrKXU3Iwe3ffa6IeBRlZWtWdqF6XB
	QGZwFv5sDAAWP09TPJYzRcOZ8w7zPo1lK22m9O19O9yI5B9Zny1qsfhulbvTK9VmP/2SyJ
	3Cn7GysysWxU0mVV0DFFlNo2oxlgUm0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-QiYJG5jNOLqPhfGBNYq_Bw-1; Tue, 22 Jul 2025 04:36:35 -0400
X-MC-Unique: QiYJG5jNOLqPhfGBNYq_Bw-1
X-Mimecast-MFC-AGG-ID: QiYJG5jNOLqPhfGBNYq_Bw_1753173394
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so44189055e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173394; x=1753778194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7XQEQoPcNWIcIvp9Ofoqco5TAp1Io1j1Kf8hikrefc=;
        b=ak7kUfhFFAVf1nZ9ccih3XXBGyP0T98aZsIn6f4PwBAg3iypDwAFGEWwR9y6E59LW5
         K+RhXkcaxOkq9BWTZtRb3pxRp+nIL5ECSRYR+m9Lz7fHlKaIcqsZRSmmUT9cgDxamKbR
         vZ/VSKy1H9lhm7oTlM+sGeIq6KNySt2lzUrzQWUj9Eg+q+Jx33o1qKkbqjeb2mdAna6p
         H58uDrC+m2atGYxFloin0mf+GyFFHMD4gXG37OZYmWWt9v5MV5Ol65bN1w6pxQCtxj/S
         nSzT1KjIvXV+amKhN2gk0q3uW2Hmzn7ozLgt89XQRhHwIFjrQ5XEft/++0+RbYBkSOAq
         K6bQ==
X-Gm-Message-State: AOJu0Yys0MfeQI6p8h4SYXk//qZbYrfVjxaqkCD6py5qD0vX2aGNp7Y5
	PDLeBzuetGPKIvPBGC1bAHj1rqrxyL/XV/QxpBgBxE3I4YJi2ZOjk+lAtqU0RggD98JXoiIRNg/
	62fTj4PusBL3/5uMWpNuS13g9JY1dhRdWBdRTZ7qsC8oC6c1EPzFT/KsmPKY0sBiLVQ==
X-Gm-Gg: ASbGncuQ0qybsEvi3Hra8s+z8ff38Ptjtk2Hqs0RRNvexiwk8ER59qlmmBCPOgsBi68
	IJSzHtWUILSupa1C5JdfRJymU/Rrzvhv5aRXgvNMOGvEE9mTCCsIWopIdTVaIlv3I7iv7e+tqqY
	YFDZrDWEByXASEbZSnnWfuY9e4o5yp9B8ho+067vQxfYC+r2R9VNRn0SP641/m3XwxJuI75IwQT
	NDUv7ZgKSOHoNrb9flWQFJeWni/GLjwkAqhY3aFAP33xlZOcx0uv9DWhLY0TeK+01I1TRuGnw2m
	OG7vVQRKQAquatCdt3bggEVXjWaMIsodjs4xaPV0RX/8GZysbKW/NxkT1oM9r98h0vmYHVrZhKs
	8xPR3lcL7j2s=
X-Received: by 2002:a05:600c:45ce:b0:456:2397:817 with SMTP id 5b1f17b1804b1-4562e2380b9mr237690775e9.13.1753173393902;
        Tue, 22 Jul 2025 01:36:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH74FWVoogxQd474DB1B8BF7hhbdi5L1dIVdTms3cbtnlf23yWty5IyX9qpejKuhm6BtyG6+Q==
X-Received: by 2002:a05:600c:45ce:b0:456:2397:817 with SMTP id 5b1f17b1804b1-4562e2380b9mr237690365e9.13.1753173393376;
        Tue, 22 Jul 2025 01:36:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm186536825e9.23.2025.07.22.01.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 01:36:32 -0700 (PDT)
Message-ID: <5f250beb-6a81-42b2-bf6f-da02c04cbf15@redhat.com>
Date: Tue, 22 Jul 2025 10:36:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250716081441.93088-1-nbd@nbd.name>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250716081441.93088-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/25 10:14 AM, Felix Fietkau wrote:
> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
> +					 struct sk_buff *skb)
> +{
> +	const struct packet_offload *ptype;
> +	unsigned int hlen, off_pppoe;
> +	struct sk_buff *pp = NULL;
> +	struct pppoe_hdr *phdr;
> +	struct sk_buff *p;
> +	__be16 type;
> +	int flush = 1;

Minor nit: please respect the reverse christmas tree order above

> +	off_pppoe = skb_gro_offset(skb);
> +	hlen = off_pppoe + sizeof(*phdr) + 2;
> +	phdr = skb_gro_header(skb, hlen, off_pppoe);
> +	if (unlikely(!phdr))
> +		goto out;
> +
> +	/* ignore packets with padding or invalid length */
> +	if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen - 2)
> +		goto out;
> +
> +	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
> +
> +	type = pppoe_hdr_proto(phdr);
> +	if (!type)
> +		goto out;
> +
> +	ptype = gro_find_receive_by_type(type);
> +	if (!ptype)
> +		goto out;
> +
> +	flush = 0;
> +
> +	list_for_each_entry(p, head, list) {
> +		struct pppoe_hdr *phdr2;
> +
> +		if (!NAPI_GRO_CB(p)->same_flow)
> +			continue;
> +
> +		phdr2 = (struct pppoe_hdr *)(p->data + off_pppoe);
> +		if (compare_pppoe_header(phdr, phdr2))
> +			NAPI_GRO_CB(p)->same_flow = 0;
> +	}
> +
> +	skb_gro_pull(skb, sizeof(*phdr) + 2);
> +	skb_gro_postpull_rcsum(skb, phdr, sizeof(*phdr) + 2);
> +
> +	pp = ptype->callbacks.gro_receive(head, skb);

Here you can use INDIRECT_CALL_INET()

> +
> +out:
> +	skb_gro_flush_final(skb, pp, flush);
> +
> +	return pp;
> +}
> +
> +static int pppoe_gro_complete(struct sk_buff *skb, int nhoff)
> +{
> +	struct pppoe_hdr *phdr = (struct pppoe_hdr *)(skb->data + nhoff);
> +	__be16 type = pppoe_hdr_proto(phdr);
> +	struct packet_offload *ptype;
> +	int err = -ENOENT;
> +
> +	ptype = gro_find_complete_by_type(type);
> +	if (ptype)
> +		err = ptype->callbacks.gro_complete(skb, nhoff +
> +						    sizeof(*phdr) + 2);

Possibly even here but it's less relevant.

> +
> +	return err;
> +}
> +
> +static struct packet_offload pppoe_packet_offload __read_mostly = {
> +	.type = cpu_to_be16(ETH_P_PPP_SES),
> +	.priority = 10,

The priority value should be IMHO greater then the exiting ones to avoid
possible regressions on other protocols. i.e. 20 should do.

Thanks,

Paolo


