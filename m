Return-Path: <linux-kernel+bounces-873666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C061DC14626
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C9525006BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DC630C373;
	Tue, 28 Oct 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5gZQ4j0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2393090E8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651037; cv=none; b=o1aNoQ6xB2OANHK5K0B9PkbxDYWscS5yT7T/ktvp7U6ynwndPun5oiHZerOxaa8f0a/Q9cNfQgJSWzDFrUUGpQEqNKGr5QKng6mvE0LwCqhwJ2DHaYNdVYvCESx4tT7U6jyJiQmiPfqQKTzo6VTH3XXD5UqxTKkyAF6V2C/fZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651037; c=relaxed/simple;
	bh=uLz1nCOc13P72Z9cLqgJATuBA1im88R9TxqI9YQCXBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tH80ljcZKVaLyvk5nyajbYdC0tuf8FIK13VHPTuvyv6A5AjBNXfzhrFvi4Daxta4D7TJEkzjZyACcvGVmNbkyeRoieMxubICBkuNEJFUT0kZgqZJEvLgXol8MLCz44H4LOCiO2bZgoHbw3bUlePvV6tidMz0fr3BKvKSPJ58WYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5gZQ4j0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761651034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wj7YAztZrM6wj1+S+3q5JHWOPj4KIXwKeK9N2bqLfU=;
	b=A5gZQ4j0xLIsGcgO2HUNkY0U3Ui72riAn6/pLfsfJd7vhw4IgnyBoh2JVae9HT6iOgOwoJ
	uVgnFuqWFL97Ame9GmTrOYjQ87bSePLcY3PN9MgPT014WDkm7JiVKr7Uh4Lx3s00auQPUV
	rOJPnxtTyj+5Q5dRTbHvP5VcPmJ8v5M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-JJSED9FCOHmaY4sL7LLmzQ-1; Tue, 28 Oct 2025 07:30:32 -0400
X-MC-Unique: JJSED9FCOHmaY4sL7LLmzQ-1
X-Mimecast-MFC-AGG-ID: JJSED9FCOHmaY4sL7LLmzQ_1761651032
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475db4369b1so25258445e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651031; x=1762255831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wj7YAztZrM6wj1+S+3q5JHWOPj4KIXwKeK9N2bqLfU=;
        b=l7bL+pbuJAakLSlWkhVD9T2xGN0GU5YGGnshxPVMuVWN+G4bHSgVSznNRAEKHE1hOP
         bPfNN9pc7iG1F9Db/h2h7R2NuKVCQzlukaVpVwhu1xwk7iRffrzWa69XS7/o5K1fqXeg
         dAFMZcUdvOXejYZ8UN71/SCwwVXthEMA06MQEtVIO/GoYeGMu2xGdv3e7nGe2LNxbP4S
         3vH58Bok13OXVG4XDI4fPlP+Yf3YstpbFxHAGPWzpsJPx7al77OyjGfzAOj/yLwY2rps
         AE1dV/0oPOgpefjRc8P+tBd3O8MVr6iE+k+eOONKpgw+F1RAV67caB+1L5zOpwR6D1EF
         tOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqJF7VRQYVu8UvFPXPzzVOx9fd+k9W3P9NtiWk+yHL173mXuYxhoSg/TZyDqsezU7nXnZFTDkS+q0vVdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKHARIQl9p6PuDJaIWc0eTwXgjb99ACuBnlq09YWH7ZqmDlZi
	avWEhg5eGMPC9u5PkNS0JrTxNInB7x+w0jo6Xzt168z4dyQ4qhK5QqW++uhAQVRniAY5ACXFOud
	NrFmcw3A3uODdKE9Q3S07TY//yqSVPQd2D7N8KzpnP13FCq6992KCvMafJQp5WI4kfg==
X-Gm-Gg: ASbGncvF5u9CVuWo+StlWcquTw7aDjO0ApmT0M/+LWaos6Jr40aX/VSbM0eTiruVT9N
	4oXrgLoPnY9YWdI9L3+djkYSO38P7OLbYYJYIGgylOwwL9O2M/kXaZMU8TZL97jhOlZim4aRrVo
	Tu9wqm79uSeEDt7/9R/sp4xjvm4G1Jy2lXxR1ECdSEMAS2TI8nWbo0Dj4qN9hOtY7M7vEl8tQJI
	PcKDFhxenSAHbcmSoli0m2QWSFXJFxO0luTE2PNI+haKYBd9HMEhNoMQ05C/sRK181+2g3wPa5f
	ExzPKk1mWSPP8bWaHp72HKHAsjJmFXn8EJiX+BYJCeF9+byJ693WsBkEXCov1S5c4kMUdzbqrh5
	evn+Uk7JUN7ydrK7k0V5mBs1mxdEDvLqImDxwZgykVnVzEpA=
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr25034685e9.35.1761651031639;
        Tue, 28 Oct 2025 04:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1UoWkDkAxEnPYbIqlYF36LNiS1od7f4r/oylsQ8lGjLYMkIaaEI5SdiPojR2VWZlNQPGbIA==
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr25034235e9.35.1761651031148;
        Tue, 28 Oct 2025 04:30:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd489fa4sm187152685e9.16.2025.10.28.04.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:30:30 -0700 (PDT)
Message-ID: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Date: Tue, 28 Oct 2025 12:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023125450.105859-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 2:54 PM, Jiayuan Chen wrote:
> When the server has MPTCP enabled but receives a non-MP-capable request
> from a client, it calls mptcp_fallback_tcp_ops().
> 
> Since non-MPTCP connections are allowed to use sockmap, which replaces
> sk->sk_prot, using sk->sk_prot to determine the IP version in
> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
> incorrect ops to sk->sk_socket->ops.

I don't see how sockmap could modify the to-be-accepted socket sk_prot
before mptcp_fallback_tcp_ops(), as such call happens before the fd is
installed, and AFAICS sockmap can only fetch sockets via fds.

Is this patch needed?

/P


