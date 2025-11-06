Return-Path: <linux-kernel+bounces-889215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF04C3CFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF61899038
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9F3502A5;
	Thu,  6 Nov 2025 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSa0AzFx"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE8350298
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451882; cv=none; b=ZCLP0x8anqBy0ekUN4uxBgzeW/AWcWijUyR91ZiRBzabrJ5QIXe+gDxkcfp0uomj3pHuTynSFPAyptWdDacNyvlRcVIKyTGRG0eYp4GHijmjun7aPSK2kGErWXJ//D8NHSaAGH2qV2/qWZ5ZxS2Day9F2xHgbcS1Wga+4ZNShSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451882; c=relaxed/simple;
	bh=glDJwADkOumTnv2wh0y8hasj3tQrqspeLBN3EP/hPeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnqWRLST1Z0OtU+3lu9ylPpQI5THcF4LCuR8AqdbdkS4lZBOIPhRTktNKJibr28ij2vEnBxoWnpJ3U4vKnZ7viJG4G8lwVI0EdL8bHXCgyd8Bcg7nJWwuaI+KGb6SAZhcLmr1QUQBVgrVDerekvZQrJymHCKkHAR+YxINksmPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSa0AzFx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ba2450aba80so752271a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762451880; x=1763056680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq2BG8wI9bIT4TcMCE4faFvSiiQMg+JzNyI7cyMI09g=;
        b=HSa0AzFxYv7Eywl+uuTcMiBDZCL4x61QFtqaeTalq9vAF+EBARPsAutYojSSzBXY/j
         HgyJE+Kczrqr/XsUX9wkUO0jm1ekeMQxNjTWYQ6aEfcry9/BrWxs2nxG2C0CZZwngyWL
         e5a/dtezsaRTnUneG7iAnR4TA4jqBL436pwIqVwc0XmggagxM2jLRTNHmxO0bwUDFeqL
         VXeGMsQiMuCmT8DtKZlDXcb3Y+BA2LPLPjArZzaRcjwENq4uzZLV/vkRTZWuBlrbphIw
         KGAUq++7NbOMwv5wnOBWVWpeRTz7duDVEwPCmRbIp5Jp9ksCqL6qiG2Lxy4kRjRzKtom
         Omvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762451880; x=1763056680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qq2BG8wI9bIT4TcMCE4faFvSiiQMg+JzNyI7cyMI09g=;
        b=tzUV7+2DnI/qQRUeyy80oAhtzOTQ3h1lY4mSNM/1h2URTOIsnOBlalYFuq/YYCSK94
         mPAk1luTXES1KX+O3H/Jil5vF/u9e+iXltclIztW6mct7fPMyav+r4tLVu5sGOSkm+lf
         pyQ00NLP6Bq/FkPJ/1P30GTftFRKXVfyhCS6T15miSqsqr/Em68xirCtJRi26RrFaI2M
         mBUMcR7F1NX4AmC/vvcrlQVgk0ZV3KCv8f85aT8j/VZpdJf1giT3u4XM838EMVz0Bndj
         nJQ6TtdnLuptUf0/YxPdTu7HLTGHSctsk6itk34KUjuxfEFxzB4CBoPqESnGKhGpW+TC
         KG5w==
X-Forwarded-Encrypted: i=1; AJvYcCX2qsfQCGBTHwCyvXnT+UA/xO9uj8NLbosHfo0SGQXiSvtaDKcmS4UUiiFUeif1HXhMOIgALMjDbBZBXbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo4bMMbOKosBkoLkrwMBBmrU3B/qwrMXo8Cg0BOrCjUNoBJR3J
	Kj34/+qRkTYGRYmmcjbhYuIGE75LYL2KuZP1cko9A5TqwewmTZlxw22tTF/vHBRu6q4WeVi97Ic
	sk2wvT+aUdMNQ48QPlvbWBwlTxAdVN+0=
X-Gm-Gg: ASbGnctLMWjUB041NnDqeY7MDd9/l91Xw4QW49yG/FsvY+wwgfFFWWCdmB/KiIStAcm
	rgDMGm1v5z4sa4alupK7kwvYXrZ9ykgmZo6yLpWf/Zcmn5szgQTEjCc4x0Hze9oD/3/vIhXWbor
	oc2GSqlu4IZaQM/7bVI768YkdRAXvbxLiLEOTJElh2V4FTII8MBmEhe4vndkUz++PCaX0gziIh5
	kA+su+MdZPbwx8T3fmBvq9Wke82zMVlAlldRIcMx2sNW/Ui29jl+APVSuv8HpKcniIor2fDBz5O
	75VUo67pjGc=
X-Google-Smtp-Source: AGHT+IEo2c3LTKhoAWPaU5mA29bYX/vQ3YlDfexEaLKPDZKxloUHe6GGY5t624x7bqLaqtKa75S0FMw4WhtkQE0EKKo=
X-Received: by 2002:a17:902:db0b:b0:297:c048:fb60 with SMTP id
 d9443c01a7336-297c048fb72mr3932805ad.25.1762451880461; Thu, 06 Nov 2025
 09:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106113519.544d147d@canb.auug.org.au>
In-Reply-To: <20251106113519.544d147d@canb.auug.org.au>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Nov 2025 09:57:46 -0800
X-Gm-Features: AWmQ_bm8E-PozACS9d1X9w71i5ba0KKhj-9cPqMEYJ2xotNsfTlmXkti2aB73FA
Message-ID: <CAEf4BzbDyeMG4KdgryqFTTT3t5EQWRsKf8n1W6AHL_VOW0SC7A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:35=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/helpers.c
>
> between commits:
>
>   ea0714d61dea ("bpf:add _impl suffix for bpf_task_work_schedule* kfuncs"=
)
>   137cc92ffe2e ("bpf: add _impl suffix for bpf_stream_vprintk() kfunc")
>
> from the bpf tree and commit:
>
>   8d8771dc03e4 ("bpf: add plumbing for file-backed dynptr")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc kernel/bpf/helpers.c
> index e4007fea4909,865b0dae38d1..000000000000
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@@ -4380,9 -4531,11 +4535,11 @@@ BTF_ID_FLAGS(func, bpf_strncasestr)
>   #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>   BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>   #endif
>  -BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
>  -BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
>  -BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
>  +BTF_ID_FLAGS(func, bpf_stream_vprintk_impl, KF_TRUSTED_ARGS)
>  +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl, KF_TRUSTED_ARGS)
>  +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl, KF_TRUSTED_ARGS)
> + BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
> + BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
>   BTF_KFUNCS_END(common_btf_ids)

LGTM, thanks

>
>   static const struct btf_kfunc_id_set common_kfunc_set =3D {

