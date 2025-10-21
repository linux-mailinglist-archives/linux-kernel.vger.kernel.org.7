Return-Path: <linux-kernel+bounces-862622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45E0BF5C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6951484310
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9497B32C93D;
	Tue, 21 Oct 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fYONXq4X"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFE32B98A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042279; cv=none; b=qXBCPoAandW9qZZQH7o1rnNtrY3O7PhCX+TDG1JhfkPNTbXhd/0COlZA+lWCmWvBgKvRabppoD5Nat1pktl6DaQtmq6SBGhnWX9oajMp1ANSTBOpuu0gKX2HA7/+DclZmsOlBg+kK2bU+o8wtn4Eu3S0Bk7e7ru4tJc5F3cSPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042279; c=relaxed/simple;
	bh=B3s7ZSl86JD4ZLrcy7v2rLerojZVW4rI6JyJqxX2Opw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzB8YTPdi5JoC3NyZ0fgW3w3GX5pd14U50QcK9aKlXvVHSjqVHrZTap2Sg8Ho6lGi04oi3ASZAeXIEQHHL54j2ZT2XlwkxuAVuY+yN3X6MPgtoRfmOVyJ6RjjKZ84AeVJD9mNj1zOoH6MmhDDKCFyuEHlvffIl1ZkWVV827UqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fYONXq4X; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so6197414a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761042276; x=1761647076; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JcFCzEhSLG+mhX1K/VGxSMuzwAex5vT0vkcdh5aIy+o=;
        b=fYONXq4XOeRd1D/VeQ7wsDVll2QuE+S7FML5Na0kk+LYWI/nIdZdFTu9k0PZVRjE4s
         92e4nR9nrGjLdbusoffg0QSwppIFAKW6ezo3ZMb0WKlrr33Fe84KNw4EM7fSOFhkGwqa
         kvkeZrIOQg5rKdhy5zyYjK5LZhj34CTJ4Y32dHqYndbWdbLZwFZNW+8d9mrTTXwac+wc
         kp7AFDiW+PwU0LilUiucbxX4GoGNyvvHWBovqNb1UFzDgZiWRFRnjuZHOupIwFhVlK4Z
         4DjzM9bLAOkez+aunzkwB01uEGaJBTyxl86/mMVhLaBjCPdHph4DCDigvfp9yEHn82dV
         /kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761042276; x=1761647076;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcFCzEhSLG+mhX1K/VGxSMuzwAex5vT0vkcdh5aIy+o=;
        b=wYN7gwM7SWPQh23YEzj56plObnGsJG7mCydrEdXcWUkA2yGRuvPyni4HQZi794WB/e
         SdhXz6wnKQ7ee+piKackWxAxieONciSme/2KV5IbOrfoQuxw5M9044XwGygFzzr0cGq2
         E7R+mC6B9yoUy0MJK3esnwccp3zzywKyZ0t25h98rEWy6vBOC2NGQsjD1QlWho9atjW/
         p0IOlmhjhOLOlBfcg3j3yRDtoaLCCCY8FWnU5sO7Rc39IDaI4VQf9o017ui2C/07wEKl
         8j0N1w66tJ41fRMyyO6w2sCjVK07hodXK+VtGlg3Iwrl9aKvw5PpJfXph9Ed8Yne0nMW
         3cTA==
X-Forwarded-Encrypted: i=1; AJvYcCXCCS3muBkhYj+R2XopM++++KXwm8UZC4kGfJP2DeAgvrFJLOIlMf/RpzWsJiwktcWHZ3LSWb/AVt67WI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9AV0uJavROQVk4xC3n+UwdNN1CDWEUxAhqcNfpo7jDZYzTt2
	YjZGXurOS/MEpL+B/cIEbGMURqDvBwYYaDnSY0cBg97yWNXWokfDepkJtuhfPGmRGbM=
X-Gm-Gg: ASbGncu9jES6m4PzuJ7XeLfUg1MTiM5Ij1AU+1BuhLg2eUhtjF1OyMPFkOeORvzpwxt
	zV6ZmfJWxE0tZXS3odws3kF84wsSyzDALsXsOG1fW0itXZ2tF1bso9e0CAvRI9RRlL6oUnBwLS1
	mAUU7IRsMci70Uv8MzCUTeJ69u9ClyBsasR39lH8ahkeNHRl4/JWf4cFmsSTpNEhXfv72zwMP0e
	ZHb09zozjSsTZp69MxgbLKSFQG+R74UzPdeSNKIdwpZfM/lMDnxPA4l46AKXmDIZlDoTT+KLIeT
	TR1Mz2XPAqMjU+I4Fv8oAcPgxbHUgYinYwNnl96AzO5c8oj1fDQujpeWJCpwqbH0OotpUzr0VbL
	MaMvEMPyE/J6U/nyEEEwnlRB6K9V4KdV5B9dc3B1LL6WIFPez6g6+PvYwpI9q/cILdQ7DmDs+Dy
	QkAJg=
X-Google-Smtp-Source: AGHT+IHkXRt1bvA2nq78V9v3smCUF/mdE6nd/jsrFec9VaW89MGSq10bqEG5Bj4znCDYslvVrucVQw==
X-Received: by 2002:a05:6402:254b:b0:634:9121:7a2d with SMTP id 4fb4d7f45d1cf-63c1f6e5309mr17096839a12.26.1761042276183;
        Tue, 21 Oct 2025 03:24:36 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945efebsm8971783a12.32.2025.10.21.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:24:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  John Fastabend <john.fastabend@gmail.com>,  Eric Dumazet
 <edumazet@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,  "David
 S. Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
  Simon Horman <horms@kernel.org>,  Matthieu Baerts <matttbe@kernel.org>,
  Mat Martineau <martineau@kernel.org>,  Geliang Tang <geliang@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Florian Westphal <fw@strlen.de>,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net,mptcp: fix incorrect IPv4/IPv6 fallback
 detection with BPF Sockmap
In-Reply-To: <20251020060503.325369-2-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Mon, 20 Oct 2025 14:04:46 +0800")
References: <20251020060503.325369-1-jiayuan.chen@linux.dev>
	<20251020060503.325369-2-jiayuan.chen@linux.dev>
Date: Tue, 21 Oct 2025 12:24:34 +0200
Message-ID: <87h5vswo0t.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20, 2025 at 02:04 PM +08, Jiayuan Chen wrote:
> When the server has MPTCP enabled but receives a non-MP-capable request
> from a client, it calls mptcp_fallback_tcp_ops().
>
> Since non-MPTCP connections are allowed to use sockmap, which replaces
> sk->sk_prot, using sk->sk_prot to determine the IP version in
> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
> incorrect ops to sk->sk_socket->ops.
>
> Additionally, when BPF Sockmap modifies the protocol handlers, the
> original WARN_ON_ONCE(sk->sk_prot != &tcp_prot) check would falsely
> trigger warnings.
>
> Fix this by using the more stable sk_family to distinguish between IPv4
> and IPv6 connections, ensuring correct fallback protocol operations are
> selected even when BPF Sockmap has modified the socket protocol handlers.
>
> Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/mptcp/protocol.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0292162a14ee..c2d1513615ae 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -61,11 +61,14 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
>  
>  static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
>  {
> +	/* When BPF Sockmap is used, it replaces sk->sk_prot.
> +	 * Using sk_family is a reliable way to determine the IP version.
> +	 */
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	if (sk->sk_prot == &tcpv6_prot)
> +	if (sk->sk_family == AF_INET6)
>  		return &inet6_stream_ops;
>  #endif
> -	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
> +	WARN_ON_ONCE(sk->sk_family != AF_INET);
>  	return &inet_stream_ops;
>  }

Should probably be a READ_ONCE(sk->sk_family) based on what I see in
IPV6_ADDRFORM:

https://elixir.bootlin.com/linux/v6.18-rc1/source/net/ipv6/ipv6_sockglue.c#L607

Nit: It's BPF sockmap, cpumap, etc. We don't treat it as a proper noun.

Other than that:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

