Return-Path: <linux-kernel+bounces-891840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D6DC43A21
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 09:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543AF3AF3ED
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF38426FD9D;
	Sun,  9 Nov 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3QdJTty"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9FA18FDDB
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762676498; cv=none; b=LjY4nqgklON7bPnSpitqh2a0hDjvMkyNpghrdpv0dTH6IaqVtntusHU4UgCDyPDoc6Q4UNvx5qAFZESuPc1hf6j2u015jJfZZqtUfNY7F/RasD3fnSUrWkslKbzCrZtQiZx6mNkkSlhmJW+OK3PBOXWhxfV6rnaG/+Qs/frXGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762676498; c=relaxed/simple;
	bh=blBxIzHVxMDkVOYTtn6sgPlXbPeUDm01RifRQqnXCR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMX84JcBa5RbqqmuKaK8fL73sca6lfL5rOrhskq1aVkFGTIgSTeNRGtsUA7oVhTupKbXZfPDAY7yDed9c02eGQCTIHg5x7hTzXyvjYgkKv68/bQX2zRTfGCVEc73YmcaGNluWQU0ixeUjjz5WJIfDH/QDVAnTvYKtje1+dLO798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3QdJTty; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787da30c50fso6396987b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 00:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762676496; x=1763281296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+G16wY2Uy0RV+AHrXQMNikD/m9lQ1yJj0Gcep7twG4=;
        b=S3QdJTty/L11BVtLiwPOBbzCAagOfkD+f0DsIARoixGNax9XxDN0k8JA4UxXfahKNH
         KLQJRcrqy/SbuWaYIzVPbcfBhodpb4zJbO0D4vjW8nqG8RiV1lvF8mHSFtfJeBifO6TQ
         SJ/ytDBmSLz7w2g4A58x9PMARyddh0L5y682OrDDrozFTts0o4s2FwWy2yzrQ8aYkPyT
         rCVt7Ux4Z2pknCmY/XoisWadoNXizg11SS00GoKluU+g+JSKRLU2yJ7bIDAFBLa+3Kv0
         SrhZt5aFAv4SgFWJgY3rj5t7zgRKXJtfqN50v6lwsXnP20a+X1aeGwREbFLze+cd1sRB
         1qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762676496; x=1763281296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+G16wY2Uy0RV+AHrXQMNikD/m9lQ1yJj0Gcep7twG4=;
        b=KMkzbNno2iIcn/xAPObQHJqpNNe5ycziRnlTX0ZkqrKEiGydgFRBRWzRSI2PIHb0Q+
         wob3/4Kvs9Rd0LFr8+5p2URD4YWx1bKbFsaEQLfNjWBfh5eMH9AuE98my4tRjHPdVYbx
         oFmf/hUygRu33midT3/ulLHhrxWVPx8rfRKTZS2i24ly4sd5JbWrnn2UqmT0cmErBOhi
         Y7SaGuLl6gtlIpzB2cPegt+cndH2DB1hUji9oyG/mc1K8gq4AW7p7optBl5/xYg6BUnd
         RjeAtxiPF7nA/ibIXDff6QLTZG7rA78Iha99VS0g/3vFPQWVAHhgOlDZV8jtio02Ipz0
         Mnpw==
X-Forwarded-Encrypted: i=1; AJvYcCXpRSL6R60OxThyNhSAwQpJ7SRgJLwh2DFx+d0S2/AaMmGR/puXpFJavwymlYV/C3YE8J2N2HiNTZSex4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdRAARHt2voVb2f/6+DMnODrfXHFHWrksTPmWzXTxQLkIVkEB8
	o5GXvhZ6fZSdzL3QJPc/pBjvDDuArmH7j92l6wB0Jxgl6YDetYD9dLNpm5MLD2nMd79SSUnjDQQ
	vprqYzndpXHtcLtZwaEypAsyJYDRXRIA=
X-Gm-Gg: ASbGnctVDDZGkG/6XBnaJsLxn6zXXC7j47zaVOTLIz7zcheAck4jk3osDalBgEs/f/i
	0KhNpARxIFpVQzILCqTUngFQ7N8W5f5ztYePAaAIx92YOkgr6xub2NzzfjTJMuT+dN+laHMzlbi
	syMoEllLWYiEJ1mk1oqjc7GXy3qHWXIxm/0UN3B3vq7SGB97Vn3Mvfbbl4CWWgMGCBYFQIFZ5rH
	xnYtIIEoQqFmtpp2wqR8CMuCH8MiArOlp0vnp9tPSvRc5AqVBlOZwHlFcTwo+sFKxs42u4l
X-Google-Smtp-Source: AGHT+IEaqIye4DtDHgikTrookKOjzbjgSvwfAg40yRgSxZD6MgtC7CaLSpR7r2YAQlHytf/EZLr37UyRk0xdeDBmYNI=
X-Received: by 2002:a05:690c:610d:b0:787:ea39:6656 with SMTP id
 00721157ae682-787ea397030mr7757287b3.22.1762676495801; Sun, 09 Nov 2025
 00:21:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107100310.61478-1-a.safin@rosa.ru> <20251107114127.4e130fb2@pumpkin>
 <CALOAHbB1cJ3EAmOOQ6oYM4ZJZn-eA7pP07=sDeG3naOM2G9Aew@mail.gmail.com>
In-Reply-To: <CALOAHbB1cJ3EAmOOQ6oYM4ZJZn-eA7pP07=sDeG3naOM2G9Aew@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Nov 2025 16:20:59 +0800
X-Gm-Features: AWmQ_bnJ-vvvsH1qxIwP2kkBXgkqUH_eUTNwEZRz0N4xm2likEq83gy42ECpYgE
Message-ID: <CALOAHbCz+9T349GCmyMkork=Nc_08OnXCoVCz+WO0kdXgx3MDA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: David Laight <david.laight.linux@gmail.com>, Alexei Safin <a.safin@rosa.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 11:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Fri, Nov 7, 2025 at 7:41=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri,  7 Nov 2025 13:03:05 +0300
> > Alexei Safin <a.safin@rosa.ru> wrote:
> >
> > > The intermediate product value_size * num_possible_cpus() is evaluate=
d
> > > in 32-bit arithmetic and only then promoted to 64 bits. On systems wi=
th
> > > large value_size and many possible CPUs this can overflow and lead to
> > > an underestimated memory usage.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > That code is insane.
> > The size being calculated looks like a kernel memory size.
> > You really don't want to be allocating single structures that exceed 4G=
B.
>
> I failed to get your point.
> The calculation `value_size * num_possible_cpus() * num_entries` can
> overflow. While the creation of a hashmap limits `value_size *
> num_entries` to U32_MAX, this new formula can easily exceed that
> limit. For example, on my test server with just 64 CPUs, the following
> operation will trigger an overflow:
>
>           map_fd =3D bpf_map_create(BPF_MAP_TYPE_PERCPU_HASH, "count_map"=
, 4, 4,
>                                                      1 << 27, &map_opts)

Upon reviewing the code, I see that `num_entries` is declared as u64,
which prevents overflow in the calculation `value_size *
num_possible_cpus() * num_entries`. Therefore, this change is
unnecessary.

It seems that the Linux Verification Center (linuxtesting.org) needs
to be improved ;-)

--=20
Regards
Yafang

