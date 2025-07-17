Return-Path: <linux-kernel+bounces-735510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C1B09054
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163793AEE70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F11E8322;
	Thu, 17 Jul 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ZqIrr+PF"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6E7E107
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765322; cv=none; b=o1fEJkf+1DAz+NVN03ja3zUc9Kz6uhqmFHdeo8kcYcFPmLi+uXplBuGvOm4xUgwCsSKxhDDak79vCje+M6QVoRmgcsim7OIaZJSm3f+J07od2m+RP9ISJsL/+ugQQ0AKpXZ+kvAFYMrYKCHBSN93Q/d6x8xzIocIzilwzp3yZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765322; c=relaxed/simple;
	bh=uYKefjG3jk2C3YLsqcotNnT24i2I/xBuxxVY0arOB/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJoiNBF/KgEpcQ7taERoU2Xu9r8fwgVa1J12W5azypG1lGyAmG7VKbOL1TKzoWgM40X0ygCbL6GXMBgBQCMDCMoPY3krLSrTBbEuz049euLNFEwgOK1tGh7IzbpFJt8Auk+jnNy4MlMToBOfJkIHDTKV7EH/nbM50SDiRwtDcMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=ZqIrr+PF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so1023387f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1752765320; x=1753370120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJMJTA83WH07DjPioIXnI5GHGg29vRTdXy8ees4Pv1s=;
        b=ZqIrr+PFzKN31PldRkheEEhTCXz8PcjQzVlwEyUr/+8PivtPDSYctC1thKgNJblxq9
         J2i8Vgj50Qtwt3QRCYofwIwJRSnD3D1U+N+GdjYzbB8ETmDaPhDEr0oEkq96zPYyD351
         tjerzJTLpt8UfKW5vM5VJliwEqD1A1+7whs54ls/0SjwnG1u1E1uJk7bjfwV2Pc6Y5Hg
         9POPNXfNb3z/okBUA3TgZ3N+wSQaqy4l4jpDAzhywpwbNjLltVN/nclpM9EPmyjZ1N8f
         LJIdrihd9B8sUTm4LuP86p2jS/IPOwXK/2Vr/+PpH/tcu0DGJOBLCbgW6/4+yVWBpDdY
         JlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765320; x=1753370120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJMJTA83WH07DjPioIXnI5GHGg29vRTdXy8ees4Pv1s=;
        b=o70PDIQGVaf/K6uPAam0KMDMXLpXeJIBkGabpzkxF09crac1HckCHE/xdSRMhlP5eZ
         Y9rW/paQkSbaf52IKW+VHD0lEsbH7jn2JZC1CvBjFt33h0wwia5rATigQJqCsDBMmc4G
         lkfrnBPzSPtWni+RNXs6n80fe9JgBz7zjl2r11B1Zzz14BQ+RNRjGqYxRzxWpFNQDXFE
         1lcQLCAujQ9rZLW6up7RMTrI6O+gRgvrzt1PlJLYH4loxp1hEx8kQeoj6hiHDWv9VsJJ
         CW6k48P2aQECXqjDrjJQF2cOWgTfPB6P/sJ4w0oxl3WynLA/4diAL9AGEhf1whLmlojR
         8Gdw==
X-Forwarded-Encrypted: i=1; AJvYcCWsnrSnxHLGyqoD8wOeK99/oAnr0O1WlMK3rZyqE6GwloCto1KjWKmlerHW7aWpzhDuNx19uue4AM7i5bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwggociGONpQkVMvkdLLooelwpXyM7GzJhoVlh6dHdJ7Uv95hj1
	uPD69ewAHPXGx2bbHFfDBW01lGLpUchA/wDL4ccZ9g2JesQQBLPylj4gXqB7W+zqGVnI/IlE0Lw
	ZClUG12cb0XMoa56kb5Bhmq7RD1/Ga7QRCjvv/1aL/w==
X-Gm-Gg: ASbGncuT+fT9SrvSCKPW0pcN41xvM/fhZBrbpq9caiBfsk3mDz9TyfNdrZITLOhHpTe
	ReBSK08wo2N3c69Rwl0eovL2zlcah+7OuzEc07lYOU64lIe/RwRnqk+Fl9oJaIjUP5Igcu9Y6+f
	vUvP4poowCyAO439g/t5MUN+EsUWo+c7k9LSxYrGW4Q51jPeXkYHUP2Lb4eULmfALrZVK1M9JdV
	NAvYg==
X-Google-Smtp-Source: AGHT+IH3RQURYv6RUsyjhfCjPnbq76Yt1tIeE/r4l/zRFxghwDcy4thWAtjf1Qmjm4sX2AEpW3WUl8KV2Dpd0p1Xyr0=
X-Received: by 2002:a05:6000:658:b0:3a4:eeb5:58c0 with SMTP id
 ffacd0b85a97d-3b60dd4f752mr7612559f8f.20.1752765319635; Thu, 17 Jul 2025
 08:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
 <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com> <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
 <CAN+4W8hsK6FMBon0-J6mAYk1yVsamYL=cHqFkj3syepxiv16Ug@mail.gmail.com> <CAADnVQ+WZsaDS-Vuc9AN7P3=xvX8TG=rY65A8wYdOARLtkt6Mw@mail.gmail.com>
In-Reply-To: <CAADnVQ+WZsaDS-Vuc9AN7P3=xvX8TG=rY65A8wYdOARLtkt6Mw@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 17 Jul 2025 16:15:07 +0100
X-Gm-Features: Ac12FXx5_43sdjKCTtLw8gtm46jTfSh3joljtt9boX2xFAkNZRIJX-9H7H7z2co
Message-ID: <CAN+4W8i+PqYDcJjWk+g63W4kdKvhFKSad61q-T=JJky5m7j79w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> __pa_symbol() should work for start_BTF, but would be good
> to double check with Ard that the rest stays linear.

Alexei,

This code in the arm64 setup does make me think we'll be OK.

kernel_code.start   =3D __pa_symbol(_stext);
kernel_code.end     =3D __pa_symbol(__init_begin - 1);
kernel_data.start   =3D __pa_symbol(_sdata);
kernel_data.end     =3D __pa_symbol(_end - 1);

Using these as start and end only makes sense to me if the addresses
are linear? See
https://elixir.bootlin.com/linux/v6.15.6/source/arch/arm64/kernel/setup.c#L=
217

Let me know if you want me to double check with Ard regardless.

Best
Lorenz

