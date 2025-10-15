Return-Path: <linux-kernel+bounces-854887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759E4BDFAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA05119C71C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF22D593B;
	Wed, 15 Oct 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0oNVvXQ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C5337685
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546167; cv=none; b=snWPpT5oVUE2pF43z5K6JCJAcEKdA8oc1W/5VqjNfBmo2Pxoqdg2Rk5BATSO2GyUv1uJWSReDLWqm2bC9LSRi8MKPCYcWXlHDaf5Io3Nl8SgTFCWnizF3tTU805+z2ou0kfOktYgglc2iZZVMcfP6Lyp9BU/Pbc0m1I70zkU/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546167; c=relaxed/simple;
	bh=xH40ds73k+2XlYhTO+MkHbE0jGwPWYCtKVwxkuUpaVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeTuwScb+RjBQw4RHLIvv9jjEzJ494eovbCBy8fqoXdvDrJbFdTlJCKWp82BPgSOcBl0xF3vT1czyU5GEH41klU23ZBo+Rx/Rrii8MyXedEJDaJlO7Gw0lTZ80rDUAR83Zx+8BkNnso0k/gmH4b6UFt+J9QUHwPM6mnzI0Ox+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0oNVvXQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so9466989a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760546165; x=1761150965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkn+CqkssDx8H+vXeI6R3v2XcqWE9l2NOxynVDwDTlI=;
        b=k0oNVvXQLiHvQYjLFNQ87ElZq4C42/eyoPEuxcBR6dYuYolDFxM06MmV7EzetI92aE
         bduTm/PHLuBaHgPlua9d3yPKLt16KuGqSWDm4nCP929mIcpdAXHPD5crAZ2/PHtEhi66
         5AZXsaiLceqBPmWP1/oYB+yWpFGNQIZ+pTHasR+RUrWKBi/FTqF/gu/V02NBmVrRI24w
         7a9PguXhUpV0tCtjxfCHqSj9NXD1J1U2QG19S4FPvaVDAAmBX+ahJPX5BSpNrNiZ2ShN
         Wf0AZMy56hDiAQKR6xMbc+bTWn8MxQEBkM3Io1UiXL6Bp4nA7anwF9bGScAlf3ewLcaz
         h/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546165; x=1761150965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pkn+CqkssDx8H+vXeI6R3v2XcqWE9l2NOxynVDwDTlI=;
        b=lkNq6/DWDUs0Ek3MAjxvs+6PQkK3KL0YXxrh5PooQnquV6iK5ONco0tPe1SoGQuNMe
         90KhiUTKWadZpBdy4CphwmPFlGsNtEPNnJS2amKdC6pzkw+MxKr6mKXcDnMv5foEKjYQ
         3f26/JKh1GdNj+N1Ed/rL5Mugfe1NL1fLPt0Eme10z5aqQZKCGfboeWJtakxBjEBKJvP
         qYlpfZZWhU81nFSqCv9aVNdy9MQw4eZe4PovFVTRX82QKGIhSLkcLVxls6N7gmC5P6id
         vTzQ5AOQL4ku+/u481Li3qiDZlOkRRhsN1mRyEdSNd4kvt57w+USbSJ95OmWB0njzz5M
         2PkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1yFkhqJ2wQ90JlWQQ0rxCzMw0v7w0ZM0All46YXJ+fi44dykJBfkwdNwScBnmwViPYFcMBJSpRxMmtW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6Uxl0rFliD4FK4P5ZXNZ/qtnDwxLrcILeTM9sKByJteiT34E
	rES+o9Xdmm6/eBFO6BKJua7r5pqHbVwLa/NBKr+T0HpsSxJKfXCUVphMKeHO1c93n61svmG0ACE
	udIrT1f7CbSE5uL5YG0RhpWaND1rc6X4=
X-Gm-Gg: ASbGncvd/XcftKMOsLVongWV39kf4QC/LFNDJMgF3hh8Zhh697OLT42SIpVkFNDcX0g
	asLCJcVLKngvtFOh8+V9Kmp1tZZRPazaKAP2WTfu3znZWp9HQwvzCtc7i25qoGmsbA038/d8KvM
	DTM9qlqmJ3aLfr6XVPQlxhtQrg0EcXcMebAWZtm9oXeiS/vptQYJfiGhjPsTdA6s4wExpfET11w
	isiOMzsx0A+w7Nhy41ssZ+n5shlxoXtsQ8AdnpP1AqqQGbYgdNDlKPEh5TrjYc=
X-Google-Smtp-Source: AGHT+IFGNrAI2dq3NSrRL0OcSYM4Z5okAFYQKhuh27ccqKymPLtZeC7L6zTwS+qJQzu1LIvsGty8JwB7F48ezlC7tv0=
X-Received: by 2002:a17:90b:3ec6:b0:339:ec9c:b26d with SMTP id
 98e67ed59e1d1-33b510f8488mr41389554a91.8.1760546165323; Wed, 15 Oct 2025
 09:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015141716.887-1-laoar.shao@gmail.com> <20251015141716.887-7-laoar.shao@gmail.com>
In-Reply-To: <20251015141716.887-7-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 15 Oct 2025 09:35:52 -0700
X-Gm-Features: AS18NWADyZQhCWHApHI8yY-s9dj0g7hVHDNjJ__LLzs5iWjWLcNDNGLGYWesqlU
Message-ID: <CAEf4BzZYk+LyR0WTQ+TinEqC0Av8MuO-tKxqhEFbOw=Gu+D_gQ@mail.gmail.com>
Subject: Re: [RFC PATCH v10 mm-new 6/9] bpf: mark mm->owner as __safe_rcu_or_null
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	rdunlap@infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 7:18=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. The
> owner can be NULL. With this change, BPF helpers can safely access
> mm->owner to retrieve the associated task from the mm. We can then make
> policy decision based on the task attribute.
>
> The typical use case is as follows,
>
>   bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted field
>   @owner =3D @mm->owner; // mm_struct::owner is rcu trusted or null
>   if (!@owner)
>       goto out;
>
>   /* Do something based on the task attribute */
>
> out:
>   bpf_rcu_read_unlock();
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
>

I thought you were going to send this and next patches outside of your
thp patch set to land them sooner, as they don't have dependency on
the rest of the patches and are useful on their own?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c4f69a9e9af6..d400e18ee31e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7123,6 +7123,9 @@ BTF_TYPE_SAFE_RCU(struct cgroup_subsys_state) {
>  /* RCU trusted: these fields are trusted in RCU CS and can be NULL */
>  BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct) {
>         struct file __rcu *exe_file;
> +#ifdef CONFIG_MEMCG
> +       struct task_struct __rcu *owner;
> +#endif
>  };
>
>  /* skb->sk, req->sk are not RCU protected, but we mark them as such
> --
> 2.47.3
>

