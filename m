Return-Path: <linux-kernel+bounces-843748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5ABC0225
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 06:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CFDD4F0863
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 04:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AAA218ADD;
	Tue,  7 Oct 2025 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhTqT8nk"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D791A9F8D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759810143; cv=none; b=n478R81L99Fvk+pGPp5GNSBflQnxSLoYpZ33Q4TFkYaCkFlB+75Vr/CRk1jD3dqKBkn9Ebj5dMUWQcbTY+BXf8fTiVrtIUskHQZPsaHHtYJ4GISwFR9FQErKoQ5RbEeLIg/Bwl782X1u2rSC5HQgwzpEOm1ELAEtx1TKNK50AZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759810143; c=relaxed/simple;
	bh=432QvHvOj19tKWGrDdk4erAr4nKhVAMEK3WbFkC/IRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMOTvSQNizZQxwvvAu95WLWKyyUkxh8QhGb9gVLpxmgxlzpcp0WNPwAVUJKiywyVkMzTvD/Pf3eJo00fzV/b5C3aDn72jrsyr4VFu3ZxEOEeOChW9G5UiHUX1niOUEvSN755n4Jg8cmc6Dk5fR9MPHRNvgFqNkOL5LX4HbCKRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhTqT8nk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so34900265e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759810140; x=1760414940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK04lQWKr2DjWtJceprl3zo5tRNApv5guaFqKP5j6NI=;
        b=YhTqT8nk2g/L01i/OaUJ8+4bKkVsbeTIxroy6/QXn6yXZjlnyHFktbGs3ef6/FXWAz
         f1G6wiirRsDMVVyVhqUyIoXvJXp/7wHif4GPFxJDe+V4Qn2tCkBjyR09EZuN4XTh0a7n
         vLfCIWmVU36f0XTWlKoai9+jIwwNse36wv+2K9421mSjoTx0b2dNYk9H3LQfc+V2wK2R
         iwegy6d4dZGBMP5E7m52Ec4MdNIGKtsEklg5Hg2D0KOLKqEpWGkQG+TuuMfCLtklhcdW
         IurDnPcR8AsaeRaPnuSlaa2v+yudDtoo6AA/Nn8hi3Ur7FLzlBajTC4sZP6x6LQriJOJ
         MBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759810140; x=1760414940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK04lQWKr2DjWtJceprl3zo5tRNApv5guaFqKP5j6NI=;
        b=I4OHk5kREgqrmRMb0DM24xGxxbe0gYczjnvF2CFo0SlkRJTywIvrrRjFBLBneaMuwb
         gEN+a4I/TGmICM0bU7/zFY9OVu+dnX1lLSj7LBRAaEhjzIvzag4Olz/t8/nxiaJb4MuH
         s28Y+M5JMANr9rmNkjJ1iWcJmjJYbh2N+l5wIgPnNU8BZuK1m579uwfPFp5pMzxU6svO
         2Bb43T6olw4WSKhktyinUeNQ/sy9SNd6XN579mMMTagQifekNXprAmFd/wwD3Fs1MoFZ
         FYlOQE2hcnXRD94gFLfFn0CoUqktFlafz2c7qJUcoFLSyeH07zLlPr0Cu1LdWSMRHY/8
         eUdA==
X-Forwarded-Encrypted: i=1; AJvYcCU1ufjn9KZEidjDm1bdGSe9jX81MVQriug+RbF2uXqJJjVdStmQ48lvI/eHk/PKPnXdwY4OQxRUgy8TnNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvt/yrKXcFOh0DNiCe1kU0GzVpuef8WyNNpcA1nlvRnVC4ONK
	YvpyVaKAVux89p3saXrmtWkJ2wvGpGqx0A5HtsyvOqKoUAlWD4WXeYsHMqH1KM9EgpbC4DqdukV
	ajl+/klfnhSiCh+ymgwuIPdPB3va7QaE=
X-Gm-Gg: ASbGncugOnukyDQIk1guMSZEdrtbF5bUTjHPLuNVO/r9JlKmZWFwk/LHNpaAM6NdCbR
	/+RZ5/xAIPgh0/hfVMvEAs5lhHnfieywE0J806ZnaRiPOkYIP1X6v94UbXuopQssguvlRwP6eLZ
	EdV+8BYpjjUBjjMpnvqMW3AJdw0KP5nBrb3rDG61Wdo7KkNDkNIr5ueUrHwE8krpj8DURYpETqH
	AAvcsPwtP/0XYWkaoOxRQzBqPDUcmQwaL/uARi/LmFweWydRXyOePHPnkROtBh1Pd6S+nmHDg==
X-Google-Smtp-Source: AGHT+IHYHh6bEmYuCmFai3v43g5P6gr1pDPCY9ygDD4iuTvWaHhchyjoP1nQ92EQruT44rG7ohu+X4LwmhENyChZTvU=
X-Received: by 2002:a05:600c:4e94:b0:46e:394b:4991 with SMTP id
 5b1f17b1804b1-46e71105457mr96964855e9.11.1759810140454; Mon, 06 Oct 2025
 21:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759804822.git.rongtao@cestc.cn> <tencent_6E59062E4249590597452A06AFCDA3098808@qq.com>
In-Reply-To: <tencent_6E59062E4249590597452A06AFCDA3098808@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Oct 2025 21:08:49 -0700
X-Gm-Features: AS18NWBUCpOWw8ZMVB20Bk2k82iz0iF-_IQG_RoaZfjQrcbZ-AoUhVqW_uV4EFY
Message-ID: <CAADnVQJFBR5ecewWdDhTqyXTMWH_QVEPCm2PXxV_3j1wa+tWMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
To: Rong Tao <rtoax@foxmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 8:00=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote:
>
> +/**
> + * bpf_strnstr - Find the first substring in a length-limited string, ig=
noring
> + *               the case of the characters
> + * @s1__ign: The string to be searched
> + * @s2__ign: The string to search for
> + * @len: the maximum number of characters to search
> + *
> + * Return:
> + * * >=3D0      - Index of the first character of the first occurrence o=
f @s2__ign
> + *              within the first @len characters of @s1__ign
> + * * %-ENOENT - @s2__ign not found in the first @len characters of @s1__=
ign
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of the strings is too large
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign=
,
> +                                                               size_t le=
n)

See AI review for the above part.

pw-bot: cr

