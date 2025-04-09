Return-Path: <linux-kernel+bounces-596487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749A8A82CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD28189FF4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D33526FA7E;
	Wed,  9 Apr 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="flbivy0e"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E392267B6B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216872; cv=none; b=mNiSgtEOP5oKxbDNRCkEuhGcBi/a0xaMP7S76+5cnYImmp5p7LbRKurBoNs5Ph+vm62F1jv7lARiNkykLJW8rbi6SNB6+4uZA4oiq8XTjpBMszsB7Ro56gGpQ32T9KGoivRKePi0zbExEQilIaY/FJC1RTtY+t7SADOpjkFwpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216872; c=relaxed/simple;
	bh=fHtzsqyFXqsqKFMN9o9Jg6YNOCKqxpR3FTSVZ+RDgH0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=G3djfxHDcUr311Rh9fi29cgPlZx9Id+ZuoZNyj6uuqvxzvDXLVidw/wGLPfymA2Sez+bmEDsGPPVnblc+jKKctprq1FDEEsVVd6a98WRyNbL6lvv77haRec3jSgtKWdyBbd5jYVNphNP+eESSo8F0LMkmoUDeRa/7Ed5DFfTNdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=flbivy0e; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744216857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uGpDWEkSr9vFQIbcnhzKP72TVIYwsPwOclwYbiHadg=;
	b=flbivy0eFa+1D3pp6XHzZXXaM/vyuD5kjKwpfeicfcJahclQRmqKai7pLKfClVn6NcPBQC
	odIONTf6B+d8QdgqeOfH3lULncL5hgF3qn7uCwEK0WVJQ9LLe9Vdz+hHiSn0MtHIhGIkfE
	Ou1Ya23bcILo4UFR8vebqPRdjlCCe4M=
Date: Wed, 09 Apr 2025 16:40:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <c292a4c4daa4d27f5062a23bd871ac58285ec406@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Introduce tracing capability
 for sockmap
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, mrpre@163.com, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin  KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP  Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu  Desnoyers"
 <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20250409121125.48510acb@gandalf.local.home>
References: <20250409102937.15632-1-jiayuan.chen@linux.dev>
 <20250409121125.48510acb@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

April 10, 2025 at 24:11, "Steven Rostedt" <rostedt@goodmis.org> wrote:

>=20
>=20On Wed, 9 Apr 2025 18:29:33 +0800
>=20
>=20Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>=20
>=20>=20
>=20> +#define trace_sockmap_skmsg_redirect(sk, prog, msg, act) \
> >  + trace_sockmap_redirect((sk), "msg", (prog), (msg)->sg.size, (act))
> >  +
> >  +#define trace_sockmap_skb_redirect(sk, prog, skb, act) \
> >  + trace_sockmap_redirect((sk), "skb", (prog), (skb)->len, (act))
> >  +
> >  +TRACE_EVENT(sockmap_redirect,
> >  + TP_PROTO(const struct sock *sk, const char *type,
> >  + const struct bpf_prog *prog, int length, int act),
> >  + TP_ARGS(sk, type, prog, length, act),
> >  +
> >  + TP_STRUCT__entry(
> >  + __field(const void *, sk)
> >  + __field(const char *, type)
> >=20
>=20
> On 64bit, const char * is 8 bytes, and you are pointing it to a string =
of
> size 4 bytes (3 chars and '\0'). Why not just make it a constant string=
, or
> better yet, an enum?
>=20
>=20-- Steve
>
Using an enum is indeed more appropriate in TRACE.

Thank you for the suggestion.

