Return-Path: <linux-kernel+bounces-881087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E09B8C276CF
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 04:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63CA24E3D64
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 03:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5046F25A34B;
	Sat,  1 Nov 2025 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2ozUdWu"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115CA1D618E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761967730; cv=none; b=UqtLQq87SEJXq8Ye/5dZ6noi8Glm8PFydEPyjduQhHmAh11oacQzGVt0o9A7asUyFYK2hwpf6IhV5d0du/PG5qw+nrXVAyVjmxCwWRXXxb3fxRirzvN7EddwCmn/zsQ+IlhS5KwNaOw61gSWaesvRoPAao0chhR0csGra4Pq+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761967730; c=relaxed/simple;
	bh=wjnNkEV6LUs78Y+5OZbnzxMl17pcnxKfgCEpP4WCa1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCbQv5wNNDx6gD79PYBmDxmiVza/2tG+C2V6BldbpqcNQcDU7/VnBHInzk8yM8HVeLcEjllJeq2JUPMhXMA0X/gGWTCIGmoZ/4wF5PpdzhujHjQRnfTsiB+LanBcMvN8MHHF+HNJ19BkWDJcVQhwHriTjqc/649Kxjh8XZso760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2ozUdWu; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-292fd52d527so30594295ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761967728; x=1762572528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjnNkEV6LUs78Y+5OZbnzxMl17pcnxKfgCEpP4WCa1s=;
        b=m2ozUdWu2M/KATEC6ioNMaU0OpyeXNDytFm0q825ZlsDNsdguk0rj6QqPO0F1kPexW
         OnKco0o9+l8FEMUzP/qaCHFtIxCsWjSeUoHFcHAoQZe7jKZViRSq1cHDbEYcbkIoB6iA
         TxuIqAyFflfpMt5Vq9cR/w2ObnTq4ZR2hcMUvEx0xEtquqWurbiqAuQY7brcvXZ+YJmn
         oA8IHK0IF1v+CNBafE9678k8LgJ4YVWyHErLPFDShuLIg9EttisKtRkWsHJzhWPm3wGa
         /Zh3N27KMHRcnuRJb887K9AGH8Cjpxh4gniP9mRqbdfLcSYafgmLoekqUkmOc/Qd0jXt
         ZNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761967728; x=1762572528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjnNkEV6LUs78Y+5OZbnzxMl17pcnxKfgCEpP4WCa1s=;
        b=pxIGsAx2Tw6l2R0cvBp0o0c94CTPKW6x54/5oY2TSaykQBzw7JIObgv3nyv789VoUK
         Tvw5Sf6cEW4ct5VHZTHbvRdrrST7MyDCDj+/s2iJrqOv7SW7LDPxVMauGO7+w8BZeOx7
         TcTakAtPICrinGT17+GYlEo+vmyEXrRNQPI5zVFzxnxttLfTV3brvvWmS5farj2ffh6t
         XMqHn1+ZAMfkOBpMXZj2kJXdNvRiA3zkRwy58JCHnnIBseu9628iSVnluZ/Y6IeR3ZSb
         2UpmdIpVM7xLURHIpkzbxtpAowf8YJHIQntp1MWx4nkr4lXn1PqD5ob5uWQvPL/AIt5B
         cxvw==
X-Forwarded-Encrypted: i=1; AJvYcCXtyoWfNXM6gmNCeD8SwtZN7eKvFr5U2zWvf8aKzbe/4JP9UZaUwTySEGLeMrNGsZ3mi2DWb+ikJ2mxwps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3fHLIy+UFb4q72u72KEtK2AxZcIlCh5GmWh7brOuUctw10hv5
	AACgYDW5r1jyyan3U3u4Hs0tGbY80UgqwS7RmQpvvZGUIRr1b1xDkiXm9lk2nLdaZOG0X+G6MYu
	xyHQ876nCkcCLgg6NeiiHMvhQ3g5IMuZcEV4FGN6P6g==
X-Gm-Gg: ASbGncuXD/J9qVffdZwoGY6It75XHnkN/LPijaCjk+vrlImPcHQ5/71ZXSNqnkNtmrz
	2MvB7iVj8eOR61A+HYHD21ZmrLKT9uCdgmpJSnoQOWkeUVmUsovNn+V2iZtxdzoS99bAIFQodff
	YVYr7g711BOMcKbZMkeoXTR5RNQzoB60bmg59SZuuUoxHXHXognZhIp+sQFBjBGjVmxAyERnRlu
	kC50ASf6oQvwxeHGwqfxlfnUi9XJKBVoB2dLoZJOSYeDTZc2owGQKdALiyXqN1tbKWBRBe3M7uP
	yErmdA==
X-Google-Smtp-Source: AGHT+IGWgaD4PX5lKseZPf0pThlXZ/JawYKt97AqtJa/6i0YIuP8oftmS/jTEcFBxmHyFCuk5eCcQemB2BsQUDEOdms=
X-Received: by 2002:a17:902:cec4:b0:294:f70d:5e33 with SMTP id
 d9443c01a7336-2951a3a6503mr78206555ad.12.1761967728338; Fri, 31 Oct 2025
 20:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031032627.1414462-1-jianyungao89@gmail.com> <CAADnVQKzF=jrJ84es2=Ko-WdcNxQnBWErb06huFyZs6-HuhowA@mail.gmail.com>
In-Reply-To: <CAADnVQKzF=jrJ84es2=Ko-WdcNxQnBWErb06huFyZs6-HuhowA@mail.gmail.com>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Sat, 1 Nov 2025 11:28:37 +0800
X-Gm-Features: AWmQ_bmCdOpwYJv6p5xTcj_08DXLN3HgDmDTP-aMN7MVR_ZSgQKsBIGPN31PcsM
Message-ID: <CAHP3+4AwtFNF_RifNw5XrpsFpBZ_dssZPLPqc_264y0G4OksFA@mail.gmail.com>
Subject: Re: [PATCH 0/5] libbpf: add Doxygen docs for public LIBBPF_API APIs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm not an AI !

Although the Doxygen docs added in this patch series were assisted by
AI, they were still checked by myself.
You know, this is also a tedious task. The reason why I wanted to do
this job is that I think adding these documentation-style comments is
meaningful and can help some beginners.

However, if you don't like it, I will stop.

Anyway, thank you for your prompt reply.

Thanks
Jianyun

On Fri, Oct 31, 2025 at 10:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 30, 2025 at 8:26=E2=80=AFPM Jianyun Gao <jianyungao89@gmail.c=
om> wrote:
> >
> > Hi,
> >
> > Background:
> > While consulting libbpf's online documentation at https://libbpf.readth=
edocs.io/
> > I noticed that many public LIBBPF_API helpers in tools/lib/bpf/bpf.h ei=
ther
>
> You or AI ?
> The whole thing looks like AI generated garbage.
> Sorry, but no.
>
> pw-bot: cr

