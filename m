Return-Path: <linux-kernel+bounces-873720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE319C14837
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319251A244B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C5E329C79;
	Tue, 28 Oct 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZUujFpr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C35303A23
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653047; cv=none; b=CSRdHEnY6cqsjzleRnabW2nHlKa7t/1wyYP4Ygi75FZQ5q2Tlgk4s6tcn5l7VS+IYI8KobXzNcPjvso1pijBB0ITS4pSwh3tXMUR5OmgdLFYjqeWDoTb+4QEqUh73L3ScJ5EE47BVQ6UuuxQqos3fpapGwZAn6/6DnciyWkFIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653047; c=relaxed/simple;
	bh=WskojuOBnwIjjigUBWEDMhf7Assmbp3QvliKc3R2txY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAVQMw9jVMvdcZ//RtooLm8OsybeoMve9SXfGXHrJsb6+5/6a0ifyBAMWqb59RSp/ZRsLkSmMH2w7lw0z6paafEUv8z+fvSf9DGeMF5UC+9tj4BrvkMWCv+8xBNoPuga+0q8VEYsfnAFuxA/6X69twHWYXaJNG6F8NBgo7MblI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZUujFpr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761653045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xM3wpdALZDN/yyL3dIoanvrY9zgAvQNamISjAjH9Xc=;
	b=WZUujFprFltBAHWa/3RUOrFpHOGs5hftJAQhOX+RXUTrm9SWj2PoB6OtQTaDtVaKZcRLfo
	4euzIHSFpJ6PH5dm0wxnu9RJ+yyKUW2+UpHGDtaYRLj/IX9p9JRWwh9V5IsSJafzwdZFPi
	m0HvcFAmK8v4tn+NbShXss/u1xumthk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-eZMyYxhKOjirfwoEqthwRQ-1; Tue, 28 Oct 2025 08:04:03 -0400
X-MC-Unique: eZMyYxhKOjirfwoEqthwRQ-1
X-Mimecast-MFC-AGG-ID: eZMyYxhKOjirfwoEqthwRQ_1761653043
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee888281c3so4146719f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761653042; x=1762257842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xM3wpdALZDN/yyL3dIoanvrY9zgAvQNamISjAjH9Xc=;
        b=RH8L94d9g6eyOFrgW1A5DcXqWUlCTgJfOVOQPC84o+tatYj5jM7U9BzZY2gZDvYDti
         tERylcgZ0+65rVAmHnNPJshtmm11FFHZmB1CYsRL3FPPeFDFiPecXrCXM09lDOlIBOTJ
         7d6QtEzsAW2HsWPQHaKQ8Jvwci+bvUhFBzgoh+wVlqvB0u/FlDa/nuRgYDtT4DREejeq
         WGPXe6kIzRwQlXPA7bbQrQGxAK3uIVD6oMsQ5YlUsgCbWyTAqemcJ/DuPk+T7bMoztou
         +ownN+TPlAR1Sl+4OZviPPsU1uska2srdEbwQsylkcRxDHPDwpgxEO5+CyeLVOyis0u+
         iN9A==
X-Forwarded-Encrypted: i=1; AJvYcCUSJh25EklvmzjKjzwOTauYILqnA8LGtsvHZXDZuwItdV2FzR9Lhna5HeVqKbnDivbAHFCqo43A8ushL7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzyZR30yw4fWPSjr3z21JhqVRdnyAVo4twnxThxlhK2qlBVJpy
	zx5yEnKNGsN7P85hWCsQlQoa1sdcumt+i7nu+0c3wf6CFay46c5sBxFd7mQPbtWQ3WNNAmZJZye
	0t4JI/w3POCJVUXM5B2d7pe6yrWqCa8txrPWzVDm2i/6Avak3Nl+hEdATNVQrgPe7+A==
X-Gm-Gg: ASbGnct/8FaLytyYU9fw+KPaB6IMkERHJHaaPNTjIPOBshgCtXWDb0yGFfi5ifvv5f9
	E6E2BThs345wSB7opvPHl+Alkwt1g/4q6GaMGm8bTo0dtedizz1SoGkPie7bC2PdBlKSfGl5+b6
	tiDbml8fr4aPzLMxErjg9v4J8KsGIaRZvKXkXO2/7488H8H4cXNxtaqY6KELuhoHbHxL0+DD3Sf
	QcC0faUZzE7LypFVP4k9qc/R2VDL7tOhA+ZyikoMJG5vJTItv1+TP6trjnHxnOxpWyJkelmAchp
	ini2SZQySD7kzxHk2PTzgvzY2tRC5g5JvsZpuj4abGY8vsYtKY8CLH25sCjBZaEsvHOXBx85WqD
	LDbLNwIMEZOJISijjk+veeC9gAafTNXMpcWLgY6Fl8SnczuA=
X-Received: by 2002:a05:600c:45d1:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47717df9d11mr30659245e9.4.1761653042557;
        Tue, 28 Oct 2025 05:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6BMjF+yCSS1WwGmhw2kl9y9f0ddjV6c/A0RrHdROCvFXSSyoxTUbY0rSmrFqSolRY/cH10g==
X-Received: by 2002:a05:600c:45d1:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47717df9d11mr30658905e9.4.1761653042071;
        Tue, 28 Oct 2025 05:04:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd035dc2sm196120995e9.5.2025.10.28.05.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:04:01 -0700 (PDT)
Message-ID: <c5021188-593c-431c-bf01-6775f5b2b2ed@redhat.com>
Date: Tue, 28 Oct 2025 13:03:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] bpf,sockmap: disallow MPTCP sockets from
 sockmap
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
 <20251023125450.105859-3-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023125450.105859-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 2:54 PM, Jiayuan Chen wrote:
> MPTCP creates subflows for data transmission, and these sockets should not
> be added to sockmap because MPTCP sets specialized data_ready handlers
> that would be overridden by sockmap.
> 
> Additionally, for the parent socket of MPTCP subflows (plain TCP socket),
> MPTCP sk requires specific protocol handling that conflicts with sockmap's
> operation(mptcp_prot).
> 
> This patch adds proper checks to reject MPTCP subflows and their parent
> sockets from being added to sockmap, while preserving compatibility with
> reuseport functionality for listening MPTCP sockets.

It's unclear to me why that is safe. sockmap is going to change the
listener msk proto ops.

The listener could disconnect and create an egress connection, still
using the wrong ops.

I think sockmap should always be prevented for mptcp socket, or at least
a solid explanation of why such exception is safe should be included in
the commit message.

Note that the first option allows for solving the issue entirely in the
mptcp code, setting dummy/noop psock_update_sk_prot for mptcp sockets
and mptcp subflows.

/P


