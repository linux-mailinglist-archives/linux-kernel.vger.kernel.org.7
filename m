Return-Path: <linux-kernel+bounces-894523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15FFC4B3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8923B32FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA4734888D;
	Tue, 11 Nov 2025 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfjB0TpC"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D8348460
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828881; cv=none; b=qCWfk+6ka585ovREma7HEiGPvQ2KhM83AC8z7U9LJ+RIQxyaAgjkXp3KVBG9oKombqulVIYjynpIZmnf97OeLcVFK3NLI7RnfD6IjhC1D5kZkRcs0cncNmI7kNQFnuSGiYx0TMJ0f8b4Qqk2xJD+1Q/XFr4f44UBSHjEh6GWt+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828881; c=relaxed/simple;
	bh=j8POPbpxSpPL02DZDm+FAXFDTPUlIreAK08ihYfV5Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MstJhlrkFy0I4BO54lRMY59M/8WrNrsTd6ZvEjC1C6P6b9qUOrHbIiokwzMjr3L4uuYhve9hhHirFdYDslmfUQCQ2jWciLIyuxf7e1UwjaqBn0k0QSxXVI4nnW/TcADIGCOqgtZr4bpG7T/YmU+GDNhF71uy3ZzyIa32fjvkquk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfjB0TpC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b31c610fcso1788519f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762828878; x=1763433678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8POPbpxSpPL02DZDm+FAXFDTPUlIreAK08ihYfV5Ow=;
        b=hfjB0TpCEo3kYg32fFZRXiDrqBOPHYThtITRucPce04EEJWoONjsFKUNUzBq95diT7
         CfKhJtMwnQUpPZXpTtfyZc/32etUp2hn7fQve40uCOcuWqIZXHGFXzLKqrlT6qxZVvCL
         IL7hGx5ndeRMW6F9XkNPTsFoO3mvfuZaNdAYAR9e3ecb1mvaj/Mdst5I52cRHOpOq2uD
         JdCKWXCYtRcS3nukn0tP3kIvhEwONNpo0EJ8V2+d5Dpl0YBaCajptpp+pZiTZ8eFFg1t
         8puP+SUzVlM8Y6hzRVtnwMGnuusohkOSkR/Vt5lQLg7KlM4hD2HVazQ3jBiq24BYuOM5
         nXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762828878; x=1763433678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8POPbpxSpPL02DZDm+FAXFDTPUlIreAK08ihYfV5Ow=;
        b=nsQxOIUczqfOuKkJHKzzfECnJzFwFHi16RBuTa0QYhPkuheqmEzrAEjCvVIka+tPus
         Z1jOp7UHovg9CHeY0vjQ8fg0MI0IAE+isGXNQBbea1uAfTiYECdsevEtiBFDN2K5gNqd
         Ku3ezIqT2qkTHQNFZpnQ6+/k5kktfoy3AF+qwv7gwMuXcjPct2X5P0cKVNqHiqAV/Ma1
         y4tAcJdZWAxO3JmszhZZQx7kHb9IKzvDoXbO+QIXlamXxgY4/XMgtrrRVp/6P8qnDaTN
         c91A4c47LswBTUqFmcpAR8TNTa36ISsvBnGs8LI3LLiTkW00GbZflWerEDa2phXwW+PX
         uO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVD87PvzYcRLDrQIwL0787AscqnCjJ3u+midWdBE+56/I4kgZYm/M9oO0e6ov+Wu6agxKp0Xr+g+xFDjI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0evAKQxrlZkdSkdt9XQ5JL9P5dEbgmAxFvaHxaMb7sXAhb3p6
	/E8/BLJRyk+adUkfH/eo6MtHSx1bNYiXl0FCG19Yc+D19qN9cJyuE+K87CG1R+FVD12IhQaPsSd
	187xB6OsvVm2IA9F5qPY1GjCo4RWk9oM=
X-Gm-Gg: ASbGncsu0jzXbtZzEZyYETw05+BLznF1tj06GFIS7zsiN8fgvsUMuU6T1waMhMq5bXs
	nqUBmNfUHA+Myn83Fu6ZbOfi6qCnemsMU87o75R/IDaifoOOlwC4L8qttGST4an/4OTUQIHu7eT
	IZl5vQQ8JXj8AmlTO58om5UaEY0jLLmHVV/34uen9b8+fSz6doXCsBN8+YzkIMd9yuThDCMD51s
	kYCa/2pxkswE+RwnkeDxnrqxTRp9R8Az85oux9LhVmqDVmdyqZzx+oK5x8qhKWxTKJeV39PAetB
	4/K0ZHfhcyPFPh5QAg==
X-Google-Smtp-Source: AGHT+IH25QaUjzLpQ0O3CRwITusfe6pCAMVCPN6AMnU+eDbCy0CGb6riE7azc0Q1GIAoescCF4JMVu/lrJ4ie5xkUk4=
X-Received: by 2002:adf:9d83:0:b0:42b:3083:55a2 with SMTP id
 ffacd0b85a97d-42b308356e2mr6235388f8f.63.1762828878146; Mon, 10 Nov 2025
 18:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <13884259.uLZWGnKmhe@7950hx> <CAADnVQKQ2Pqhb9wNjRuEP5AoGc6-MfLhQLD++gQPf3VB_rV+fQ@mail.gmail.com>
 <5025905.GXAFRqVoOG@7950hx>
In-Reply-To: <5025905.GXAFRqVoOG@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Nov 2025 18:41:07 -0800
X-Gm-Features: AWmQ_blf7ZxJz9aQNYoTKPbgJ8K03XqCzzaO2O8UCyW_1T8GZg-hL2D_ArTOHB4
Message-ID: <CAADnVQKxV7cvwvCMD29sqs8yt0-xQ2XVb-e6bxkTFZ2EzS4DMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: sjenning@redhat.com, Peter Zijlstra <peterz@infradead.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 5:28=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
>
> Some kind. According to my testing, the performance of bpf
> trampoline is much better than ftrace trampoline, so if we
> can implement it with bpf trampoline, the performance can be
> improved. Of course, the bpf trampoline need to offer a API
> to the livepatch for this propose.

Sure, then improve ftrace trampoline by doing the same tricks
as bpf trampoline.

> Any way, let me finish the work in this patch first. After that,
> I can send a RFC of the proposal.

Don't. livepathcing is not a job of bpf trampoline.
Song recently fixed interaction between livepatch and
fexit. We will not be adding another dimension
of complexity here where bpf trampoline is used for
livepatching and for bpf progs.

