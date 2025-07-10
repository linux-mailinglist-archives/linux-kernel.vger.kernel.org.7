Return-Path: <linux-kernel+bounces-725307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B17DCAFFD64
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B7C7B0C54
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E62C325D;
	Thu, 10 Jul 2025 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8udDjTn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1C928F947
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137915; cv=none; b=BYZDqPdgPF5drsFmHoE4Px+oh0Of1TvPfIOg5nmnUNJmfRF+Tq5+++YOTF67Kag7Oq7IqAGBnzV7TQSQdm9CVKARbAXrle+t6ieiY2SyxU+aYB19tC8o2ovOEJcO8gj7CcRHgZjIxTQRKn6/U/JVcSHdP2IDxiJxovleZaAijIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137915; c=relaxed/simple;
	bh=2IT9MY1RATVHLm7ZV+H0oG+4vlbv4+B1KFHHRv+w5+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8z6kScVPRTjMP1mbkWw1tNbLeg9zrwr76slcXBRPecxsHnx2ZKtuJN4HQw5EkTZ2Vaansz8OgaQhF+r/Uz0J4lCWDS79FmszKOxQ16M14cA+Rzq0RDmUXiDqH41zhlQbIHk1ajk9692SjnMumgO8hsY5GHMB/HWxZ9y6mYUMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8udDjTn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752137912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2jflg3WATaKBBDi6HmSHGxR6uEGPyyU47GcZAKSr9w=;
	b=F8udDjTnsFeofwruYD7QoeRwHHWCtMETp8RssXOo4dXpFK36j/uIdOa+S7yxG2EzQI1PhV
	l/gvHVe91A+KkenuXtV/AO92Pd+UG7eE+5zeqkgKr1P1gMHhQLsW1ZBh7gCJ9rQutdnzMQ
	H+GIRKGv1nPYlgvTBK2e6kH2ejJed/M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-wLqliaQmNNGqT9GMZAXJQA-1; Thu, 10 Jul 2025 04:58:31 -0400
X-MC-Unique: wLqliaQmNNGqT9GMZAXJQA-1
X-Mimecast-MFC-AGG-ID: wLqliaQmNNGqT9GMZAXJQA_1752137910
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so511793f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137910; x=1752742710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2jflg3WATaKBBDi6HmSHGxR6uEGPyyU47GcZAKSr9w=;
        b=Dr7VgzeWN3aMQSVFgvsf8Cj+ykJKwKgk3rtvybZ+70Pyhwh1DFMJX9vo6XNrrf+TjV
         f9VIgMg/d/NWUlclcwMaovRjSNu2JHznTOY0WoY+tzz1zKF1+aMjYRg9i+94EBMyG0Ja
         goym45fyTQZn+ZDs5sNd3iZu2OiK5F5ia0UPsA7OCWGh8h8dzGNxU1plCgwzujL3l653
         On+34WP9vcIgsnVg63RZTN5BJ03MqxaEgHWrHsBXfCVVTvfRCWzyQXM3gx7s41gmw38C
         bH+5fDc/k3nSPNBAF7Ou4xA7JPhtcqr59GFa6PsLjYaoJruEkqOYfMs/IJ03HvNWISqV
         fFiw==
X-Gm-Message-State: AOJu0YyOE/DBtkvJHbfPzxboiLpk48L4io4x50cMrNET0673B7I69PWJ
	iCwwLxRq8Kpf16+oADq4PcAzbonF8kDhDpA4wIGufOWgN8pvQ9vQ/yghY8iXdowoJNmRo+chql0
	5C5u9EhwgGjc0g1hK1BqsBF2PaQ8ZjiVDqL/cZr5SZk+0Qc9e39g4odakl0yLptMIZA==
X-Gm-Gg: ASbGnctAP3bb75D/xhr1iOTyCmi8S+8kHHHlTGVKH88f6Iz0NHRYrl8Uwou+jrph/wK
	pN1NMe+GgEJ6hz47dnVfncIOpCdUIyiC5bOXOiblawu0PnnVfov5cPu920NKFjQDZU6OwpXWCO4
	uE6PaitlZxxi7PlfGISJlyFJDEQ51RhDFU1pMDtixup0jKyQty0NVtjefciIxSXMCnKJr6uFp8E
	3GvSLuuNPU5Qv9yt4YTbffP/iySK//M6cllPv0fYovkhqvxuBhj4KHBm+WM6OdB37VGq0PEzmLU
	0OjUdmxHYxiD6RzGO4huUtofqGfwS+4fFA7QjF8T74WrN2E3YtZIayFUS0EVB2jM+GqVtg==
X-Received: by 2002:a05:6000:4703:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3b5e86fd876mr1548691f8f.59.1752137910137;
        Thu, 10 Jul 2025 01:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSnNdMaTPqEf+Unk95Crd5eDsF8pipQDUbGam/OEzbuYLLgpwArK1puRfQ0V2wgOSSfOwGDw==
X-Received: by 2002:a05:6000:4703:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3b5e86fd876mr1548662f8f.59.1752137909676;
        Thu, 10 Jul 2025 01:58:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e135sm1294564f8f.72.2025.07.10.01.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 01:58:29 -0700 (PDT)
Message-ID: <47e7fb60-9e61-419f-ba22-8f3c5337627b@redhat.com>
Date: Thu, 10 Jul 2025 10:58:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix segmentation after TCP/UDP fraglist GRO
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Richard Gobert <richardbgobert@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20250705150622.10699-1-nbd@nbd.name>
 <686a7e07728fc_3aa654294f9@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <686a7e07728fc_3aa654294f9@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/25 3:45 PM, Willem de Bruijn wrote:
> Felix Fietkau wrote:
>> Since "net: gro: use cb instead of skb->network_header", the skb network
>> header is no longer set in the GRO path.
>> This breaks fraglist segmentation, which relies on ip_hdr()/tcp_hdr()
> 
> Only ip_hdr is in scope.
> 
> Reviewing TCP and UDP GSO, tcp_hdr/transport header is used also
> outside segment list. Non segment list GSO also uses ip_hdr in case
> pseudo checksum needs to be set.
> 
> The GSO code is called with skb->data at the relevant header, so L4
> helpers are not strictly needed. The main issue is that data will be
> at the L4 header, and some GSO code also needs to see the IP header
> (e.g., for aforementioned pseudo checksum calculation).
> 
>> to check for address/port changes.
> 
> If in GSO, then the headers are probably more correctly set at the end
> of GRO, in gro_complete.

+1 on setting the headers at GSO time.

> The blamed commit was added to support tunneling. It's not obvious
> that unconditionally setting network header again, instead of inner
> network header, will break that.

I think this actually breaks tunneled use-case, when the aggregated
packet is forwarded to an output device before traversing the relevant
tunnel.

/P


