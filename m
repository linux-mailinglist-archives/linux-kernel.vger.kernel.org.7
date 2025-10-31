Return-Path: <linux-kernel+bounces-879554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1658DC236B6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355B93A5D98
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3692848B4;
	Fri, 31 Oct 2025 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWgZxD2e"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07325A659
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892639; cv=none; b=rjM68EJHCCfd8k0ZboAk921zY8amQ8C5vieHJKMaJ1cUzkUBU+fxlcJ+YqTU7fhoD+5MZTrvtujfk44VX/I1vvyor3BsA99YbeboWeuqACGfg979RLelFDCJ8x8Itne9HaPUX1pCEV1ATiCFCdIv6kGVzH38QTDyWybnhOS03hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892639; c=relaxed/simple;
	bh=vaP9tFVHrd+h3H4hUZXdcXreKNUI8n2Fq+c1yV7Q2Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WevDn5VFYNVD4FGEps15UDiDB1xEHZ2UiuzHLuDQV2WECNZHQDjvhyNt87jefKLC/N0R9B5CY8IOscKZx9ODtlpsoY1gQdPkZd/NHD/YvyEcPsO+5Xr3DJAEAIuMMeujIcyuthVsCXT4dYdO9jT/cGXFsanR8eWB2NoJqrMJ2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWgZxD2e; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2907948c1d2so20050775ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761892637; x=1762497437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDYWddzEhzy192wOWLvawa5saRjQOm029FdqACvNNZ0=;
        b=IWgZxD2eGivcA7Ep0azk2qGv2ZQW48r8NdRJQHR+uZNsuIbNPxzFK4+ZheG3oBm2Mb
         5X7lqgLPOQ1wnMx06hCwTiIcetlDfLowvreowL6sFDgytI3YeOiKfM5m8wmLmDe3VHh3
         5iug/vDpOR6flztM+rcYk46dBHfe3fBCZAp7mD7k4Cc6SGA57bNhyWQS2FmBBElYX2e5
         F2KHCMcMOPez2INS8vgHQrAlvWFy+pBXaM8KPSCSeDn2V+iHuyb4+Nzg9hZkjGONjhqN
         vyvWC/NC6o1KAR2wAJbPgEz04qdgMHTcxG8VbUJnNzdktQCNk2Dh26F3uaME5ltDIsf0
         rZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761892637; x=1762497437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDYWddzEhzy192wOWLvawa5saRjQOm029FdqACvNNZ0=;
        b=wmKSAOSdZlg4rwnenDMAzMhSl/iCuKWKh5gNNn4496yE4GqOoI9qXg9ikM1kHzXvOn
         JuQbiP5cSl0rjUSPVUWjRRFmVblO2ouE9SQujnzJ5FEZ0tHeGgq6OVOvS7wMiON7RUrJ
         Krh7YiNR3RwEEJSl4kESmTTtyDylTPL10J6z2tMX/xHa5rwmcrEI47Cxi2oSyyjRaOll
         sCGrAq/sd3wISc+r119BWus2A/fXqheYxo7Udzv+53hVIKAu5YZLyZxXMOe1siyAmECk
         a/eTWy3LtVKLObfkZE9y5ciP6olG+nAI5J2spCjKSkmgSiG2OeDlT0UBxYfhCrlIcOiF
         w7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsr/TBewOYHEKXD6O9c0XTOQHmw2bLMUBKvGthbZZ+8ppOTBzjCxs2EasjaObrxxD2d0XlVyxnNAs72+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpHkHa1uxwnmyfwuPvehRuxGOCJEwuBKqmX0EBpP1w/v6cfGKz
	EjjwHZ04sr9owSCmrtg57HKduUYvb15M30OUc0nydKh+CKQyme61JZyUVowDUUWMdN8PJ7jEgjX
	WNc506uSDqgyBPyccA+WjsVQ99bkIuXY=
X-Gm-Gg: ASbGncuhTOx7bACrH6piWZJWJF8O/oqyX9fJzQZ8oL34vRbvJXTxkETtbAU5lz8XN8u
	7uTTkdqSJzGC0n6vcmIB0qqFyrXhxJFMLKGmHSLiRzfqPFsXgcC+4HiArngPfF985qWmWuhL+1x
	q8jnJYA7yzUz4/sd1T6e/wFY8j8BF1fWo5YoHDQeRtF+Wh0O7SYizfqFy7WQj0HpRY5miVmtg88
	LTRUnfLX5ckY/ICwS5yoU6QB5N2WEV+gCzXDblT3Z+P4SoVDXnizcY0FcD96as3EFCZtqw=
X-Google-Smtp-Source: AGHT+IHKvlwTT+v4lVp0g7UewFcEqQtoC0e/Rzm6EFfiRLL8K/1VBKeXr7TztP+Jn70agztCGIOlvZiTJHMPQ3Dj4hs=
X-Received: by 2002:a17:903:1ce:b0:27e:ec72:f6d with SMTP id
 d9443c01a7336-2951a36e6f8mr40862445ad.11.1761892636677; Thu, 30 Oct 2025
 23:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031032627.1414462-2-jianyungao89@gmail.com> <554b5b314ffd7eb00be58d5997d44c7c4986895ad28776a87a9d6a2bf1c0765c@mail.kernel.org>
In-Reply-To: <554b5b314ffd7eb00be58d5997d44c7c4986895ad28776a87a9d6a2bf1c0765c@mail.kernel.org>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Fri, 31 Oct 2025 14:37:05 +0800
X-Gm-Features: AWmQ_bkDa-Yulfkw8NVn1sKXKelgLuaoZX3bACDt0cDA73N01wPRBODLyGsfRxI
Message-ID: <CAHP3+4CWSbZdNjSdoQhsB9Cvc9vp7V3qzJ=EVMO5+By9ZeAr3A@mail.gmail.com>
Subject: Re: [PATCH 1/5] libbpf: Add doxygen documentation for bpf_map_* APIs
 in bpf.h
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will fix it in the next version.

On Fri, Oct 31, 2025 at 12:01=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> ```
> commit 4da02b18e2168885350f3935b5ce2f1f52c850ba
> Author: Jianyun Gao <jianyungao89@gmail.com>
>
> libbpf: Add doxygen documentation for bpf_map_* APIs in bpf.h
>
> This commit adds Doxygen documentation for 13 bpf_map_* API functions in
> the libbpf user-space library header.
>
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index e983a3e40..bcb303d95 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
>
> [ ... ]
>
> > @@ -151,19 +202,452 @@ struct bpf_btf_load_opts {
> >  LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
> >                           struct bpf_btf_load_opts *opts);
> >
> > +/**
> > + * @brief Update or insert an element in a BPF map.
> > + *
> > + * Attempts to store the value referenced by @p value into the BPF map
> > + * identified by @p fd under the key referenced by @p key. The semanti=
cs
> > + * of the operation are controlled by @p flags:
>
> [ ... ]
>
> > + * @return 0 on success; -1 on failure with errno set appropriately.
> > + *
> > + * Possible errno values include (not exhaustive):
> > + *   - E2BIG:      Key or value size exceeds map definition.
> > + *   - EINVAL:     Invalid map fd, flags, or unsupported operation for=
 map type.
> > + *   - EBADF:      @p fd is not a valid BPF map descriptor.
> > + *   - ENOENT:     Key does not exist (with BPF_EXIST).
> > + *   - EEXIST:     Key already exists (with BPF_NOEXIST).
> > + *   - ENOMEM:     Kernel memory allocation failure.
> > + *   - EPERM/EACCES: Insufficient privileges or rejected by security p=
olicy.
> > + *   - ENOSPC:     Map at capacity (for maps with a max entries limit)=
.
> > + *
> > + */
> >  LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void=
 *value,
> >                                  __u64 flags);
>
> Is the documented return value correct? The implementation uses
> libbpf_err_errno() which returns negative errno values directly on
> failure (e.g., -EINVAL, -ENOENT), not -1 with errno set. Looking at
> bpf_map_update_elem() in bpf.c:
>
>   int bpf_map_update_elem(int fd, const void *key, const void *value,
>                           __u64 flags)
>   {
>       ...
>       ret =3D sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
>       return libbpf_err_errno(ret);
>   }
>
> And libbpf_err_errno() in libbpf_internal.h:
>
>   static inline int libbpf_err_errno(int ret)
>   {
>       return ret < 0 ? -errno : ret;
>   }
>
> So when syscall() returns -1, libbpf_err_errno() converts this to
> -errno. Should the documentation state "negative error code on failure"
> instead of "-1 on failure with errno set"?
>
> For comparison, the existing batch operation docs in the same file
> correctly document: "@return 0, on success; negative error code,
> otherwise (errno is also set to..."
>
> > +/**
> > + * @brief Look up an element in a BPF map by key.
>
> [ ... ]
>
> > + * @return 0 on success (value populated),
> > + *         -1 on failure with errno set appropriately:
> > + *         - ENOENT: The key does not exist in the map.
>
> The same return value documentation issue appears in
> bpf_map_lookup_elem(). The implementation uses libbpf_err_errno() so it
> returns negative errno, not -1.
>
> > +/**
> > + * @brief Look up (read) a value stored in a BPF map.
>
> [ ... ]
>
> > + * @return 0 on success; -1 on failure with errno set appropriately:
> > + *         - ENOENT: No element with the specified key exists.
>
> Same issue in bpf_map_lookup_elem_flags() - should document negative
> errno return, not -1.
>
> > +/**
> > + * @brief Atomically look up and delete a single element from a BPF ma=
p.
>
> [ ... ]
>
> > + * @return 0 on success (value copied and element deleted);
> > + *         -1 on failure with errno set:
> > + *         - ENOENT: Key not found in the map.
>
> Same issue in bpf_map_lookup_and_delete_elem() - returns negative errno.
>
> > +/**
> > + * @brief Atomically look up and delete an element from a BPF map with=
 extra flags.
>
> [ ... ]
>
> > + * @return 0 on success; -1 on failure with errno set:
> > + *         - ENOENT: Key not found.
>
> Same issue in bpf_map_lookup_and_delete_elem_flags().
>
> > +/**
> > + * @brief Delete (remove) a single element from a BPF map.
>
> [ ... ]
>
> > + * @return 0 on success; -1 on failure with errno set appropriately.
> > + *
> > + */
> >  LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
>
> Same issue in bpf_map_delete_elem().
>
> > +/**
> > + * @brief Delete an element from a BPF map with optional flags.
>
> [ ... ]
>
> > + * @return 0 on success; -1 on failure with errno set:
> > + *         - ENOENT: Key not found.
>
> Same issue in bpf_map_delete_elem_flags().
>
> > +/**
> > + * @brief Iterate over keys in a BPF map by retrieving the key that fo=
llows a given key.
>
> [ ... ]
>
> > + * @return 0 on success (next key stored in @p next_key);
> > + *         -1 on failure with errno set:
> > + *           - ENOENT: No further keys (end of iteration) or map is em=
pty (when @p key is NULL).
>
> Same issue in bpf_map_get_next_key().
>
> All eight of these functions consistently return negative errno values
> via libbpf_err_errno(), but the documentation states they return -1 with
> errno set (the traditional C API pattern). This creates inconsistency
> with the existing batch operation documentation and could mislead users
> about proper error handling.
>
>
> ```
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> In-Reply-To-Subject: `libbpf: Add doxygen documentation for bpf_map_* API=
s in bpf.h`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/189619=
81609

