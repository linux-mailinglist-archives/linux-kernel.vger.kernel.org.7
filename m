Return-Path: <linux-kernel+bounces-874383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC6C16314
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93B68561AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865A134B1A7;
	Tue, 28 Oct 2025 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L73CMJGd"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B79346E67
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672669; cv=none; b=q9FvaXa0lZmvJEnvkU7rS1Je7hBeax3j25j5aFSz9QKx6t7Qc4mivY1+AEQVaWey1qAHJN7PUsWLdAq/uK1kZoemsOkU3pphaHyBlV2SYr7hZf3b6mpgF8ukRx/+iXWENPGlmHtWbPVlWFYr/c6cuD5lip3Y38DRmtKEWmFs9SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672669; c=relaxed/simple;
	bh=Y/HraECilJ6AC28sJfuKJUG/ZZQHHv7RJd84ADtEYwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBVEIkEDbegzTKpRys1iDLpp+1SFF2BwwdXzuwqUoraBhlDi71WQ4Gty1aXRknz/voyngnUaDRCdlsaeBFpIQyGb3lmHsreMoZODgUkGMMgm9rbMXNaca4A/V71SZn9vpi5OzNIFQtyU0PTKen2EKnZyu16JiSs2nhokepkKweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L73CMJGd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42701b29a7eso73383f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672664; x=1762277464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSwI/dovbxHZsefyXJPKSjPbHaJhS6KhhKTTIMoQyd8=;
        b=L73CMJGdPMLoHlam960O2IrklWCFAkzn8odieEGnKZ4aH1earhZPjK7lGDhqE5C16l
         yBRZTZQtcXb0sA7cRMbPqhsHau6WqqqVhOiwx/3ZY8Ym8HbX9ZXsCG3tg3C7Anyeqndk
         oTK2lYvKgazg1Zrc/7E35FNOISzGbEIro916pr1wERgZRmS9EGGXWFgeUJDja1yGmHhZ
         ry3PVt8AFsEj7WOqYQueLXAq508VrvjflxMj9obEQ9WRqEv1mIHvS1mFzUuhk3wPA0oJ
         XDd3o5sSXv8dYfkmEaprV5fbzJ5xjxxE2sQuP2I/f6IxnCdCc0rTC7SHwhFLqHZvkOBq
         AlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672664; x=1762277464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSwI/dovbxHZsefyXJPKSjPbHaJhS6KhhKTTIMoQyd8=;
        b=VSUL5N1xUmpxct7notuthrD+GD0sX0HzYaYoBB5abT+tDD55uHFgZWTY9IlZp/DjYb
         jDkX0WT+p/WM8ypwnJ6RlOm7DZigcYQiOjWN4I4+3Lp31e2U7Jc9+Jo21N7xcOpDN+WT
         UEGMc0us4gJxw/R71JfoDaYOpziwOyLhxAc048NNsgZtGPoSNbkxxOqCjSx2L0Q4/sxD
         7esWEx3cChmKpTIyPGim1tZeXiw2+e6rMlfuEu0bQJtnrM2k5UbwJ6/yCp7fSdGZFVjc
         AILCwVOGSl4mv1KC15b5RHgf8aw/lRoOTSYIuTtairNayTkl2l6iy9Caf3yANpO1bDbA
         1HNg==
X-Forwarded-Encrypted: i=1; AJvYcCVd3qQAyUlNr1dKD5Ipwb3vw8AxgtOgLEufN0SYOUEwKL9wzSPTXK5YA0Ab6yjO/1UmXZMEldR8hHxeVSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1HvO2mOWaae0NLDcsjTuEH3r1dR4RUbSWUIxfW3F8Nat42If
	UCOXeVYlPMvkEvlIUxZYMSBCjLtvlA3aSVe8aRBT2h8e9wAR9XyGK7g3cUab1I0dkQ8/IP9vJqq
	Wt09DO31zgNOAVxtjHnQScEx3ObZ+WbbLYA==
X-Gm-Gg: ASbGncuQT2Grt27Zn2JHnl3mhNd0x3TJzKOXxYwXDQdeHCpXJW6vDgwtj+PN9RIvh1K
	HDJ6RohVDPVTS8+USCxzpepV4P+q18h8XVyyADnjnh7Jht9ZH2iiB+Oo/uJfm+k3o5fAq/J6s8x
	/LGrGqFwL0tH3QRi+8Z/Z91iSG39KPOBTeownxL24BjTeZLDCCsomE3FtmTj5neerol5cBzF7qv
	FjO3utm6cAqXtuDSwPKqAHZEY+VjR20gXBaJ4Pchpk7gnlZP8OxjfrckT55GgQW3JEYOQ1n0hg/
X-Google-Smtp-Source: AGHT+IHTdDJ7W91+X0Lit2Jf9Ol9397LLqUf9gynWpswTVO1GNQdk1TYiUTC6R125faMYDU49nZxa0ZLkOYh93L+Thc=
X-Received: by 2002:a5d:5888:0:b0:426:dbed:28c1 with SMTP id
 ffacd0b85a97d-429aeb04dbfmr49732f8f.14.1761672664362; Tue, 28 Oct 2025
 10:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027232206.473085-13-roman.gushchin@linux.dev>
 <ab8c7bf2f312e150c22d83e5ebe91e17f3c4be42b3ff0825623caf3aac4086af@mail.kernel.org>
 <87ikfzuezd.fsf@linux.dev>
In-Reply-To: <87ikfzuezd.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Oct 2025 10:30:50 -0700
X-Gm-Features: AWmQ_bmmzQlUp9ca5HlQPxn2I7vrph6AvsljwavTyuNEOnR6T4XT912-2Ipx8hs
Message-ID: <CAADnVQLcmJ3X7X6oW_v0KgQCPtgjmYNtgfqXqH5tFrQ+Q+5v+A@mail.gmail.com>
Subject: Re: [PATCH v2 23/23] bpf: selftests: PSI struct ops test
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bot+bpf-ci@kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, inwardvessel <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:13=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
> >> +
> >> +/* cgroup which will be deleted */
> >> +u64 deleted_cgroup_id;
> >> +
> >> +/* cgroup which will be created */
> >> +u64 new_cgroup_id;
> >> +
> >> +/* cgroup which was deleted */
> >> +u64 deleted_cgroup_id;
> >>    ^^^^^^^^^^^^^^^^^^
> >
> > Is deleted_cgroup_id intentionally declared twice here? This appears
> > to be a duplicate global variable declaration - the same variable is
> > declared at line 13 with comment "cgroup which will be deleted" and
> > again at line 19 with comment "cgroup which was deleted".
>
> Correct, fixed.

wow. TIL.

I didn't know that C allows such double variable definition
outside of function bodies.
Even with -Wall gcc/clang don't warn about it.

