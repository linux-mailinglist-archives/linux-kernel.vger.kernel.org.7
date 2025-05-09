Return-Path: <linux-kernel+bounces-642179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49675AB1B6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 19:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18AC523B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8850239E6E;
	Fri,  9 May 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q66q71F4"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B021A455
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810822; cv=none; b=Z1dcekSyWy7hEcOasrq5ivw4VmV/IGTc8ihZDoD47gTdItOCEirKKcNo6RdeX8DFxen4yuK9ztwrBZDcTAxMQAafamKVR/lc6IfajZ76B85YZbtGCmUvQItEXSDtvKdtgyNH5SnmhRCEhEECEXdTOR7CGzoG4V4p+PnkeWPytM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810822; c=relaxed/simple;
	bh=q0i9baUv6Smn9AiNhymhI2ACXAdYEVlp2to7dVDGUeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVUZKj4Lb/wewRp3tyh04sPmWSI1KhjPQQ2cTEeyAaO598s4+TkxilsXQqMxBghzG+bJluyHMN/NyihAIR7mpgvvluyNkcyKdVsUUGXqQ71+07oEJCTtNX6YZIs59JnDwIRIa+EB+MVe9HCf0n0dF3rW0IaddcD7TpCMMQcvLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q66q71F4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe808908so2745e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746810818; x=1747415618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VaVuUlmTBwUGFLDmqnTpZ1Y04NZbtvxnB5A69BImEI=;
        b=q66q71F4RcSQjpNT1a9ouNk/Gu9qAuo4hZC53/XyXcv1qxrZq5h+SIUdxx/742e9+z
         36LgGCiy5hwbMvvB4JkksuwSds3R84DVqW747Wra10Cx8TDx5JoqEhizM37ODMibzNsi
         QxIWeNzMjdWRwzKws89AcCQyfV/YBrFBbutklmk8DdpIximhIMdIitxDUoXHLlkEs+fD
         tKSed+TF/QBkngSJmPwDAsr/YeOk+k+FxgSW8LAGahBOHrutV4u/PJc73Oi5dD3xJbaE
         wWoU0XgYwNokOnBbFuQCNZ19RMlPxFCGSJiQe0VQoGiQ2if2MGhezJfJTz69qQqEQ81t
         jBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810818; x=1747415618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VaVuUlmTBwUGFLDmqnTpZ1Y04NZbtvxnB5A69BImEI=;
        b=v664QeuwkKG7C6xihlRzZWxjN6VCy5qrp83rg1dWmOQlfO7CWG0PJBnu6bcaHIJYm2
         MU7cNUJ7anmpLurzaPCoQvDOPoDKIuyaFDRgaBbwo9FHL3oVjqQk+IlGJ7KMyc76u2/V
         lnwKJTmYkFgcjc5F2AP0k/gJtvSeoHsLMGfhbmuYNJpElWRbrkXiG2Xv6qBU7XyR1inf
         qmaEkdCtICfdKiiypyVdX5pxg7T11iVQ11Sb9Mi2jJneAwjBtmCiA9ngpAh5WM4h9Yhg
         qbKgSu/iEtbKSGE2g8hIao8fsr6Ip8i2bFK2TzBL1SlYFOBsaSrunfG+ZC1fYj47BLo9
         IT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXuVCA6lExryJilLO+72Q5PutfEl9ilwdjthGvX8fkc4MSJX+Fc51JDkV6XQo7qO2o8vMXHCSfMUg286U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJG9+05w4wp++Tldd2RGErW64JXCWnHWYTUDRCKQRC9JR4GiSX
	sxss7SkhCmS/1egI2Cy6NvfS67xaymIL1tkP0mRhOgOdHxt/9wiNVx35w2dvZmuoL2q9aRE78BN
	CX4Z2PK9oLHroRrnVKB/YkAqEfAI9CqVzud7/
X-Gm-Gg: ASbGncuafJhLfB/NO8es1snHwESPRlX2zCjU70fL4tPP2PpqHavYxRF12FrY4enMFqu
	8mVIco7C+NfzEedJZYWxaOECFvgVm6aSbNBF71ZL0jF9O6vYZkK+uEargvx/I2u9oK5VuYVzeId
	CM536fS9YJGVB/0hDFA/eT
X-Google-Smtp-Source: AGHT+IGT/ZF46/GjI2YJV8SislyLWmjgR7bh1R7xJkwAOUVe7U8oq9t1ZWPW+aXIicMtdoBOVsn4uE7XK6SJT8ETH7c=
X-Received: by 2002:a05:600c:3789:b0:439:9434:1b6c with SMTP id
 5b1f17b1804b1-442d7c2cb4dmr1036775e9.3.1746810817854; Fri, 09 May 2025
 10:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
 <20250508182025.2961555-4-tjmercier@google.com> <CAPhsuW613T4biUPER9zR9DdQA_wscN4-i3vV4efoOKUZ7pkTeA@mail.gmail.com>
In-Reply-To: <CAPhsuW613T4biUPER9zR9DdQA_wscN4-i3vV4efoOKUZ7pkTeA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 9 May 2025 10:13:26 -0700
X-Gm-Features: AX0GCFsAmjlDFEArBqLUnLS1jyLR63E5yA91kW0eDQ-Z7yMddq7EqrFUgFenMYg
Message-ID: <CABdmKX0t-ng2WJPUdjXUgtbyNks4vcp3rVNbQOGPNFRF5kTQGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/5] bpf: Add open coded dmabuf iterator
To: Song Liu <song@kernel.org>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 5:28=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, May 8, 2025 at 11:20=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > This open coded iterator allows for more flexibility when creating BPF
> > programs. It can support output in formats other than text. With an ope=
n
> > coded iterator, a single BPF program can traverse multiple kernel data
> > structures (now including dmabufs), allowing for more efficient analysi=
s
> > of kernel data compared to multiple reads from procfs, sysfs, or
> > multiple traditional BPF iterator invocations.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Acked-by: Song Liu <song@kernel.org>
>
> With one nitpick below:
>
> > ---
> >  kernel/bpf/dmabuf_iter.c | 47 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/bpf/helpers.c     |  5 +++++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> > index 96b4ba7f0b2c..8049bdbc9efc 100644
> > --- a/kernel/bpf/dmabuf_iter.c
> > +++ b/kernel/bpf/dmabuf_iter.c
> > @@ -100,3 +100,50 @@ static int __init dmabuf_iter_init(void)
> >  }
> >
> >  late_initcall(dmabuf_iter_init);
> > +
> > +struct bpf_iter_dmabuf {
> > +       /* opaque iterator state; having __u64 here allows to preserve =
correct
> > +        * alignment requirements in vmlinux.h, generated from BTF
> > +        */
>
> nit: comment style.

Added a leading /*

(This is copied from task_iter.c, which currently has the same style.)


> > +       __u64 __opaque[1];
> > +} __aligned(8);
> > +
> > +/* Non-opaque version of bpf_iter_dmabuf */
> > +struct bpf_iter_dmabuf_kern {
> > +       struct dma_buf *dmabuf;
> > +} __aligned(8);
> > +
> [...]

