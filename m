Return-Path: <linux-kernel+bounces-739308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A9EB0C4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EE13A7910
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3C2D877F;
	Mon, 21 Jul 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="jxC2utf4"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553B2D780A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102907; cv=none; b=t4IYt6zpYoz9AoSs5pCYamuT2ezNw5k29ch7UdJ1AXKxiEw98bGeEl4o1iNI9D5PJzWkXdubiEljEMHJxXtAKJK+xSi6gViKqOTvESuk2/FxhLMq6NlxMeqdFJkA1vjYXCrgLTlJBA/Q4JLVaR9tA1/y2G3kU+uOv+FR9WQstOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102907; c=relaxed/simple;
	bh=lObe4xQq7y7sV9eXXp3dYC3/nrQJ+ma8WyXvYw9iWKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX6KGamHXWDs4lRmUFveAZ5fZC7KOqREKP9NE2Fb/L41T98UlPf+wOPZTZOnTNc7dneb5+Eq8XMcPBzb28AcEcLVOwouhyDBFS+T4BfOOl5/PkDWDqnVtfosszazXJlotqFj5vjEC00GU7s9fh/H/eg0SyghPKQgf+/agPkFAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=jxC2utf4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so3516520a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1753102905; x=1753707705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxRzWZ3OiN4FOr/n1+PHB32FHELlvgJzpX0WolbMnx0=;
        b=jxC2utf42a6g7aCyFmrDQyWxPDj6WeqAKU5QsUEk9rzK0HlcY5z/SEQ+MBtHf1XZoy
         lRWgDPwZiAsl+w+3wPF5c7QrPcXZq5mmx6k2WE+V9ADipCAMoCgXPjzKFdqvSuOTMus8
         KvgkYfWlz47j98/AZ+vcxA4mlPkMK/cNeOEtRhA1Si0ytX5CBBSrYt6WtaQOR+nfL1ZY
         YISlEu6f+bMWHHo8lzWDgiQcaKJmst8gyp80/oab+XKQ8lLvEAuKft5cbYlRGLgQm4Na
         7nxMLJNhZ00T264XJQbsbC5CAAoswgy7ozDFNCiixhHaFGKOj+IlBc+GXAqSgSihfFLp
         ilSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102905; x=1753707705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxRzWZ3OiN4FOr/n1+PHB32FHELlvgJzpX0WolbMnx0=;
        b=IArIp67Om24Hv+phb9azEBPbuTL1EGqUqMLVhQbFa6kOVU051Fk8hfeVv1+q8M2oz6
         584fYzGxcPWWyqOPpQbPz231BsWrkXM+HlwFJ2jDzq5tDqLM+zuaN4GIPW+yeD/fpTCY
         Sz+2HF2PUGPyVsfMYwqHlK9SiRRVie03QEchie15fnFC4+sqo7ljkg9O5LpYNk6Turoh
         g1/8cekHQWv6KWx3KzBvuIgrng6l925+xNaCOtgEKR5JaaRPLdAQLFPQGDOc4Mwm1MdP
         oROo7mRhBuYrjJPm8G9/XKCSgeWpseDqcD2QCfqijDavACq2WXTt6R6k9axKUPkhgKde
         cxAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4GUl4NmprdIJWpKkBv8mwv3H3U5VduHIsVXxm4aIySbU3x9LZeXShlRt7TQKE/sbf4Yu+0N9CcOu87vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtOvO0mJH/1K9JPMwEd0S4E0gXfJk+afNVSeQypT1pt+d1FHQ
	gMoZT4uTYQQ74P2zKssluyhGlHjcwZNOwZ03EiZski/Cnb8vh3LilixV9wtajU3FR/wqegD6PiB
	pPzURngr8PU3Va5TaMFmI8pg6lNVqJpZf/BY/TX2e8g==
X-Gm-Gg: ASbGncuWwMZhZUmU1Ihd92Qq7xobIEkrcwK7xTyIQ8uI+UIKO4iZtkGlZWkyFZ7vOek
	LUIX2bAUqoIToMINTTGBaXPWBvW7d2mDA8B0fUARjHJhLC1FCL63Ed79eNuOIkB3tdah7VNfdNU
	ekmolBKxjt6YfMZHsRUdAq094fLYFI4tGCSxiPnA0+fY5K8lo/0Du8Hmmxk2uxLzs/WMYtkVNFk
	1REzQtq93O2umOMaB9Nus4=
X-Google-Smtp-Source: AGHT+IGzAppY+Mxy5qmnlvBrX3tf7sTF4dGXTD7KnY/IuDlf5WJgBbAFdO38e7rnT91cKVn/9FtpLq3NJZ1TQj3C21g=
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-31c9f44bc2dmr32037532a91.10.1753102903531; Mon, 21 Jul 2025
 06:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718150554.48210-1-matt@readmodwrite.com> <81cd8749-6212-4fcf-8e1a-5eba5a8e2a73@kernel.org>
In-Reply-To: <81cd8749-6212-4fcf-8e1a-5eba5a8e2a73@kernel.org>
From: Matt Fleming <matt@readmodwrite.com>
Date: Mon, 21 Jul 2025 14:01:32 +0100
X-Gm-Features: Ac12FXzd0fWwBUJ6czP3EpQRC9Pxf3NK5Ala9zRsgvMp5hrQxZvDDxiuCtMHrac
Message-ID: <CAENh_ST_8XN2+QT8xz1gcKyovwEGwO-j2-YHbMj6GrWuZcgRag@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add LPM trie microbenchmarks
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@cloudflare.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Matt Fleming <mfleming@cloudflare.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 2:15=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> On 18/07/2025 17.05, Matt Fleming wrote:
>
> > [...]
> > diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools=
/testing/selftests/bpf/progs/lpm_trie_bench.c
> > new file mode 100644
> > index 000000000000..c335718cc240
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
> > @@ -0,0 +1,175 @@
> [...]
> > +
> > +static __always_inline void atomic_inc(long *cnt)
> > +{
> > +     __atomic_add_fetch(cnt, 1, __ATOMIC_SEQ_CST);
> > +}
> > +
> > +static __always_inline long atomic_swap(long *cnt, long val)
> > +{
> > +     return __atomic_exchange_n(cnt, val, __ATOMIC_SEQ_CST);
> > +}
>
> For userspace includes we have similar defines in bench.h.
> Except they use __ATOMIC_RELAXED and here __ATOMIC_SEQ_CST.
> Which is the correct to use?
>
> For BPF kernel-side do selftests have another header file that define
> these `atomic_inc` and `atomic_swap` ?

Actually, we can side step this problem completely by consistently
using __sync_fetch_and_add() for duration_ns and hits and removing the
atomic operations for DELETE, which doesn't need atomicity anyway
since only a single producer can run.

I'll send a v2.

