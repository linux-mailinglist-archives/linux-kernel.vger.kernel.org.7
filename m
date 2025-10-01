Return-Path: <linux-kernel+bounces-839304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3035BB14DE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B169F1790CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54352D028A;
	Wed,  1 Oct 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N31tAgfP"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D22C11C9
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337739; cv=none; b=VyQPnZQOtXkQM6AJnvXEyu3Sk0mcsiVLGZbMlRTgOwcop/O00dMQlV2BB5CDVPN3Nge5s5XwD5KXO2A9rPccqGQADXEwrEd54paUp8JCfpPkvt7WNdTMOmssnpHAL9sDQhWIeiLJYbQoCBWFfYba6rL1hWJWB+p/KN/IOjA/b7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337739; c=relaxed/simple;
	bh=bdSNQRu0ZgmvA7NkEFIbkz4EwPs8ZTXoQe6ijtPHeIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMSGlnpBz29A6kAD0R5n9Q7o/dm55a67GeKrxC4SqFtnT+VFPX3ZXg5qgfvcrHeeIZB24EX1TtIQP/7Kr1xzrq+UPVMAICl21JfIPEIBrQHsEaPHFki/F9QrLKOSgsoMumIcyOFEjj237JgAduUJLaNPFXTc4yWvR+Ujb4vV9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N31tAgfP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46b303f755aso178415e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759337736; x=1759942536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HZmASq5Qqy3LTI2jCynB7v9iQGn0idqV2xlDJ/yI6Q=;
        b=N31tAgfPRu8V5sI9Gs7IXaTE7s8lPV1RgR33hb+OnzqD2TJmAXFpFjZrVNfDIr2Vab
         3uLlG0ZEdpu0Cm6elg95QndFZE1YZeZ9kvJJL8K/KyTvb+K+1wYMA3Sc32tUPkXiSyRF
         Dz/LCGicUxsrVRgO9gxekPlwu4vDSC+E9P4+WhogQ8WuhlliSxdOS4pmtTDxLrWyEfrM
         3qujzlhP0q0oGWMlLm+QMZlajt9WHX87J03eJVoEhT0zVM0Z84yt9pvTu25ZTd4P5XEs
         JfThsMeFUPivocsnIe6ar3ikLeoT7bKiSKHxN10tsGaEVqh7lYCY9wvOZ38CKbFcyzOL
         wVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759337736; x=1759942536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HZmASq5Qqy3LTI2jCynB7v9iQGn0idqV2xlDJ/yI6Q=;
        b=HSHB8RyvNrYvwZiv1YCs9AKwOy90sE52gCG/FQuSdvaaOHAViduYxQIJWAiSjQqRd8
         z5NFrJZBZ2vBl1MCk9dGlV0Tpr8m9dosrHakBY6TluHgXBBQvuXJEAwsD5+YqEHFy6wP
         elLTty6sZeLvHVWEpsHFgGeE1Q59axaMAYgQqXJFSeWmbbUnDtGvHgIWpm0i948hLzoa
         1VXNgn2nidk+NRh9EaI5/r0RSK54zLv9XwuNH1e+aNsAqP+HKGqkVr4mxR5VCTYqWvme
         4Wv2rckLrXxQv62/CQarZXd6oHAus1xSb5+/xVenZPpDGnJhP1h1TEI1WQTajzuoOHn/
         Wj/g==
X-Forwarded-Encrypted: i=1; AJvYcCVbog5WS+bWywVXgQLJHrlH71NdlRrlLtkhxE/UicbbS4qa3Ur/ub1NNHqYZYWmRQNwfJhS3lqNh7ojmlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyodJ35Nkg3Srv2YmU+kpyOBmUWR6NC8EPiuRj0DWdLqMvlTvc2
	r/GnubMSB71+1FNvY6wj9VwGsJm6Y+yHlhJ0a3gNyendDpnLHas4W7+3lFWR636b+cXaj1W9SPs
	62WiKmVuphMzjOlery9BJWkm6UvXpE6c=
X-Gm-Gg: ASbGncvD878ZK3yKqXL05/iGb+UGInmF3M8UkfbkWPA+JeVV4ClL3vAS0vdV10OVHs2
	5AeWDzuOAKDeHtcwGlRWuePuQnXIwhywVhEc66eTCbI+jLz42TxctPJNoTPO7jhfh/Eel31vFwo
	HpkNwOlI/GBM4c5/CBm8qMMkQYHFQTddbrhX6Os6/Op9XNx5AWA9RbBWUor1gVcmWxRKsr9JcTI
	KC6ARRvAxNPUWIiblWx4lZIREPe2+JaxwHPb697KYV3Qk/aSi2uSAA4R5Ss
X-Google-Smtp-Source: AGHT+IG/8VgsbJKipB++ALs7Ce1OTPDpby4knmF53KfWJc4jMZsIo2710eOnaosoB+gz+8sS+Y8rg15uWXHo8yWUtuA=
X-Received: by 2002:a05:6000:2c0e:b0:406:5e66:ae65 with SMTP id
 ffacd0b85a97d-4255782015emr3184877f8f.60.1759337735480; Wed, 01 Oct 2025
 09:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com> <20251001095613.267475-1-listout@listout.xyz>
 <20251001095613.267475-2-listout@listout.xyz>
In-Reply-To: <20251001095613.267475-2-listout@listout.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 09:55:24 -0700
X-Gm-Features: AS18NWCWIJFE0RsLIgx7XI0N3IWWUd7fh23q62J3S9e27OHJLKuUzhWeJaFnFmM
Message-ID: <CAADnVQLWjSA9W0Hr2QsQo=L38fyg5r3q4BE799KuJYPGhGinqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst is
 a pointer
To: Brahmajit Das <listout@listout.xyz>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KaFai Wan <kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 2:56=E2=80=AFAM Brahmajit Das <listout@listout.xyz> =
wrote:
>
> In check_alu_op(), the verifier currently calls check_reg_arg() and
> adjust_scalar_min_max_vals() unconditionally for BPF_NEG operations.
> However, if the destination register holds a pointer, these scalar
> adjustments are unnecessary and potentially incorrect.
>
> This patch adds a check to skip the adjustment logic when the destination
> register contains a pointer.
>
> Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd36d5ae81e1b0a53ef58
> Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")
> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  kernel/bpf/verifier.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e892df386eed..4b0924c38657 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15645,7 +15645,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>                 }
>
>                 /* check dest operand */
> -               if (opcode =3D=3D BPF_NEG) {
> +               if (opcode =3D=3D BPF_NEG &&
> +                   !__is_pointer_value(false, &regs[insn->dst_reg])) {
>                         err =3D check_reg_arg(env, insn->dst_reg, DST_OP_=
NO_MARK);


The fix makes sense.

Song,
Eduard,

please take a look.

