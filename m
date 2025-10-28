Return-Path: <linux-kernel+bounces-873693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28809C1475F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78FF1982F64
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97530EF7B;
	Tue, 28 Oct 2025 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PofIAvSJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308C2D8365
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652057; cv=none; b=pkQr9tVRb3Vm3NF4KX0KVA9qZhI9xy/att7ZckfGM4LO7CfPn38bWzeAIOZkAJ5rxA0VHdPYn5yapxcRKD54cQmXW5lsti+TeDhQv3Svt5NY2ftv/07x4Zn4827McHGx8tFBOMOl4rPbGSpuPATYYZKlbCsb/VOiVmKOfxKW56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652057; c=relaxed/simple;
	bh=hTHSTmvO2gcuI9bvffQRykt0y1SGaZooIAbSqmRKxWY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HQRfdmlgliUB8h0Ehrt1XyMQUmqM4nk/NaWJiAPk4XXddJLdnNRIFyeL6oGXAKKC80VbuM6PXsfS38THCdV1pz+AVKT4+rpA4HWc0KUjjl5E5oIvTRtHFRbBkLZXhrG/yZ8d4S4u+Zj0NmWzPAIlGlQISHF1AAyhhvYt78aiUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PofIAvSJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761652054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ej5v2AhyT2+gsUph5VSZWo0mYhFvGVyUF+E1rpDGkYk=;
	b=PofIAvSJgeR/fy7VL/h8jfUtzIsDey3J9Pofm3VFwPCwnK3FLeJWaKYSeqEM0zwT5N9I72
	bnRkYOyEaELrHNrbksq5KUaTpZSN0vxM3uJOEZVkJL7fhZ91XiUVkPUeuUFcgvFDDwd9qc
	Dmd0y8j1+b00cZ/zzc1Re93EbfqxkfM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Qx9kwDpqPIWzwi2amJgDKg-1; Tue, 28 Oct 2025 07:47:32 -0400
X-MC-Unique: Qx9kwDpqPIWzwi2amJgDKg-1
X-Mimecast-MFC-AGG-ID: Qx9kwDpqPIWzwi2amJgDKg_1761652050
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42855d6875fso4902814f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652050; x=1762256850;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej5v2AhyT2+gsUph5VSZWo0mYhFvGVyUF+E1rpDGkYk=;
        b=mYyDwcIomMxoc0GLEn/SFsiZTb51s+dKIBELC4Ht8gngar1sdlxdNkD1Rfljufa9HR
         5YxPBudVjH1ViJ9Y1RgzLYWn4m9hDUiUW5VBFUq71GE7ME9Ff9874pZ5Z3yDGdVdCkh3
         Hp013JQ/O++MNuGKL2KqaaBnpRdx2nVxlOVYk00N5HDq3H3L1uMop+5ADx6CeQZQK6aM
         0Qnbkpj1FXpx0/MVCBd15PtBdQ+sKK/Hd5o/WJfKHyf/bpyfOrLALOL/AnNIeQRaGVXK
         RvQnG7bzopITizJl5Nar3eaL+zkYWES51SYhQzCEXir1BdxnTALNJGk0nKKkU+UIT9A+
         g94w==
X-Forwarded-Encrypted: i=1; AJvYcCWDBgGIV4sudG4K3Le6pcYt/okP0Nm6sFsng+16cSqKaHwCe7waHRWjoWinMf/jNl1ohSEf95Q6z8ggcvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXeGcO6LxPlREI/HaQTqITDzE2I+akugLvIWK0Kb6CFSOVWOL
	XErFPHgihM7CRPEMGVLzv4vvOG7QDrzHlaxAQSRvO+CCfEpRZXh9NB79FP9QOD8n98K7Ulpr4ZD
	/SURAcUsIkqngD3uqANuOm4gCjve5N+X26OHDdn5KgwCdRVStcy9uko/MIS93sMBehg==
X-Gm-Gg: ASbGncvi9OEWIrKSWwspWU2yw0MXa07Y2LdMgtbFhCBjAc1WrBzfJMENmY4NXPgiHvy
	9wNeFzGBK5yGBsld52F1HvmwmB1QaPgTcqw5PVISb6tN7oKhR8fXJF6NvYbwdiMDoxpPDbWnlW5
	iUkn7QGig8HfVpiU1eNi5VCP156YDfpgiAbziig0WkApbs4Tte3YOd8hA15jpvlSLVubSV+x5fT
	bUjyivcERWUOmjoyxTmMYlyNxUqmNzCAep9Tk72hsOzVjVEIQ4INxLCYEGfSGB4uMA+GE29BVnE
	/JOZB57iC9aOtVHiMEZOf2njwjtVG9Q5bqgLNDggjWICk3NHkTROUCwf+WjiVVpefD+8Mlf65CS
	Zb9tIQ8YOJGLTvfHIkgttYk1E4OEkIJz5KxRbIhFj28O0Lpc=
X-Received: by 2002:a05:600c:b90:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-47717e04c2bmr26366815e9.18.1761652049810;
        Tue, 28 Oct 2025 04:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYsmPrnr2n5dOG2TMddpHesTATKrRY3s7taqm1slxtVNIFUzWMD6kXpI/krQ6+LdMW9yh+6A==
X-Received: by 2002:a05:600c:b90:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-47717e04c2bmr26366375e9.18.1761652049184;
        Tue, 28 Oct 2025 04:47:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47793fsm194874245e9.3.2025.10.28.04.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:47:28 -0700 (PDT)
Message-ID: <7dfda5bb-665c-4068-acd4-795972da63e8@redhat.com>
Date: Tue, 28 Oct 2025 12:47:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
From: Paolo Abeni <pabeni@redhat.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
 <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Content-Language: en-US
In-Reply-To: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 12:30 PM, Paolo Abeni wrote:
> On 10/23/25 2:54 PM, Jiayuan Chen wrote:
>> When the server has MPTCP enabled but receives a non-MP-capable request
>> from a client, it calls mptcp_fallback_tcp_ops().
>>
>> Since non-MPTCP connections are allowed to use sockmap, which replaces
>> sk->sk_prot, using sk->sk_prot to determine the IP version in
>> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
>> incorrect ops to sk->sk_socket->ops.
> 
> I don't see how sockmap could modify the to-be-accepted socket sk_prot
> before mptcp_fallback_tcp_ops(), as such call happens before the fd is
> installed, and AFAICS sockmap can only fetch sockets via fds.
> 
> Is this patch needed?

Matttbe explained off-list the details of how that could happen. I think
the commit message here must be more verbose to explain clearly the
whys, even to those non proficient in sockmap like me.

Thanks,

Paolo


