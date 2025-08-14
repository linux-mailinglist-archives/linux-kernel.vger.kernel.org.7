Return-Path: <linux-kernel+bounces-768360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF58FB26043
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FE7169B22
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666C2FC867;
	Thu, 14 Aug 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALbZyzmF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9A2FB987
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162048; cv=none; b=NRjUzJ8Z4hDLVsJdVn4tmw3/V7dmUQ/y/83SKr5A4LXYQJK3ZLJ7Go4KBlzDQdYVTOv4q7rqRRIo0CsqQdq7KfIG3tV5zzRBtm7wPTyYITpw1rtPCgvjXn9trJ1BhRNIMojJDFeHguh+TxvbJdZw2r+m10lp3xC5k5NDqBJCDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162048; c=relaxed/simple;
	bh=jXHTrctaRUJ+rNdL5R+fKUrnGy7zCy3LLz/mJWb0zkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCMRN7aKfzgGoviGv1Qm+zb85QVfsfxThRFuGLoqLhQicyN1OdaqFtkHkOE5OrGzrSyxnuHYfaL/Qikdg91JiNObPcrE43N8oi6qUppDv6Ui0pVWyVObXQ3JS801PYFzpzgGEEOhoChvdIPvusyyGeN6SDJIe6aYIeoVZfhFrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALbZyzmF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755162046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5trfn4iHxRO1zMl4s9FM80236skcBNbVF5zMFumNqQ=;
	b=ALbZyzmFuBTp/3DEhkP6zGcLMEm1Gk5pzZ1YtXrAEkfQzI8G9b44kMacgXbwdmd0w7Najq
	MacYceInJYmMsCuNrWNTB0lrpNnlOd0nrsi6WKfEPam0cVabOFDKLihKkVgD1eWCT8XPaG
	foS99Sj0ZrbIn/vzdgdnnw/MMgDWUNE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-RuGrjJ5rNDCGeJPMQBx0CA-1; Thu, 14 Aug 2025 05:00:42 -0400
X-MC-Unique: RuGrjJ5rNDCGeJPMQBx0CA-1
X-Mimecast-MFC-AGG-ID: RuGrjJ5rNDCGeJPMQBx0CA_1755162041
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05d31cso2672365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162041; x=1755766841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5trfn4iHxRO1zMl4s9FM80236skcBNbVF5zMFumNqQ=;
        b=UlX0Z2KC4qUgVv6X1HT2YwTsALixv5nPS8BhO80JuIDDVwVPptnawrJpOIGnfP2sQG
         o6a8HQEwooAtgfXqxsw2auUn6WS0GGDIuqgusojK79wYK7jvvQXOs55u+Si3HtqHqmVn
         zmDvqqRJK+r+Mfgmq/S1B+s3L0Oe0Yf8xwjVioGuIvILUaueE3jxLhh0kBtGZAD1CkcG
         Zl6IZsXxA76ex2glVJSmGP3lmlOlHofSfCNvfWws3fMfNfQ7lRWdkv7NGozM9bD9r16z
         pSlWPjyCSjZTUsBX30TQzv7MFKgdtEkoF8rFvJ01oRfioEjGz3n6el+NCwKbsI1fZz0F
         fYPA==
X-Gm-Message-State: AOJu0YyYhXOj7mX/0U/fsVEe41XYdNHibrCtpywETGixEFirBayUD/Dc
	qPZ3u8uA8gHgxf3y2QQKpANVPdyTFA7OfoH1Yl/aQRsKWBLSC/YnWSG1yPLzHRFc1Bv3KY30yCA
	KRmeu7BR5y+m/T4mETrGknIYl4t4YoseMtshJAgcEEc+kICBEu0wTdx8wJCYbPsjpYA==
X-Gm-Gg: ASbGncvmR6GLopwPVfJxFhvE2AA129cWykzuDF9Mx7P7Lg1i7Wpee++VEcNS0WAGn5b
	jrUnZNs7TE2SzfMbrebbo1+1u/OpXN+Xvl0V+U2owatrqhX19jY6IBzB23K2f4UPJURyFJr3nX4
	rZpuBUDoLqPvosP4IbAZnrubh+oEV2OOD+rqkbCM1hjo1zpcWt0ukVZDgkaVsFd8IK1g2gW5zbb
	FVBBeqiV+7LaEyPdB7NM0GMFdYgZO7mH9lY0/YHcdZjwx1PkKXbfAf7LZjc6RZ74OQA8uJP3dAx
	NQjDBDTC0hRZwq4T7wpfwzYDur17gQ6yPEA3tEuCWVlKaAe8e1CFcqlWWDldKg8Z5YVvoIZthC/
	4LjZYTzugngc=
X-Received: by 2002:a05:600c:3507:b0:458:ba04:fe6d with SMTP id 5b1f17b1804b1-45a1b60ce04mr16322775e9.14.1755162041190;
        Thu, 14 Aug 2025 02:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVVy9am9/UlgY43tmw9UZzdvnaAXe/8fLqN2816UAATsJnujlFSJXt8PJWd7UcchekR92kBg==
X-Received: by 2002:a05:600c:3507:b0:458:ba04:fe6d with SMTP id 5b1f17b1804b1-45a1b60ce04mr16322435e9.14.1755162040749;
        Thu, 14 Aug 2025 02:00:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cd044sm13924075e9.9.2025.08.14.02.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:00:40 -0700 (PDT)
Message-ID: <706bb6df-7cf9-41d1-8041-4248252404dd@redhat.com>
Date: Thu, 14 Aug 2025 11:00:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: pppoe: implement GRO/GSO support
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250811095734.71019-1-nbd@nbd.name>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250811095734.71019-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/25 11:57 AM, Felix Fietkau wrote:
> @@ -1173,6 +1174,161 @@ static struct pernet_operations pppoe_net_ops = {
>  	.size = sizeof(struct pppoe_net),
>  };
>  
> +static u16
> +compare_pppoe_header(struct pppoe_hdr *phdr, struct pppoe_hdr *phdr2)
> +{
> +	return (__force __u16)((phdr->sid ^ phdr2->sid) |
> +			       (phdr->tag[0].tag_type ^ phdr2->tag[0].tag_type));

I'm sorry for the late feedback.

I see that the pppoe rcv() code ignores the type and ver fields, but I
guess it should be better to match them here, to ensure that the
segmented packet sequence matches the pre-aggregation one.

You could cast the phdr* to u32* and compare such integer.

> +}
> +
> +static __be16 pppoe_hdr_proto(struct pppoe_hdr *phdr)
> +{
> +	switch (phdr->tag[0].tag_type) {
> +	case cpu_to_be16(PPP_IP):
> +		return cpu_to_be16(ETH_P_IP);
> +	case cpu_to_be16(PPP_IPV6):
> +		return cpu_to_be16(ETH_P_IPV6);
> +	default:
> +		return 0;
> +	}
> +

Minor nit: unneeded empty line above

> +}
> +
> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
> +					 struct sk_buff *skb)
> +{
> +	const struct packet_offload *ptype;
> +	unsigned int hlen, off_pppoe;
> +	struct sk_buff *pp = NULL;
> +	struct pppoe_hdr *phdr;
> +	struct sk_buff *p;
> +	int flush = 1;
> +	__be16 type;
> +
> +	off_pppoe = skb_gro_offset(skb);
> +	hlen = off_pppoe + sizeof(*phdr);
> +	phdr = skb_gro_header(skb, hlen + 2, off_pppoe);
> +	if (unlikely(!phdr))
> +		goto out;
> +
> +	/* ignore packets with padding or invalid length */
> +	if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen)
> +		goto out;

What about filtering for phdr->code == 0 (session data) to avoid useless
late processing?

Thanks,

Paolo


