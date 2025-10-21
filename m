Return-Path: <linux-kernel+bounces-863312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D6EBF784F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBBE73556BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7043446DC;
	Tue, 21 Oct 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtmxI4bO"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4E328633
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062167; cv=none; b=uirnlM95BokRMT/c618RavglNf9/VWM3IQtTBiJj1MGTbGSZlw/EkcnGXKesAapSH67WNPFthxqF3mTUtMa2LJVj4iv7pLMRk/Zzyi/m9SCuTXJmGCxJr2uR4OG6mqJN4I5TMArSAzj/Erap2aRjdBsUQKfSgotCU2fzugWEWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062167; c=relaxed/simple;
	bh=JYR7iP2GeSeObGGEO8s2n6ldhfxp1AJFvfmViXYS6m4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GfRlgpGJyI+DzCTLziXdD9xHQzs3ZgugfUazKXbCGtf0hwbbDNUSw5QTztgm8y/jQYQAdKdXWSoay52ZfqRIFMMK+ESlslWITgmmSqwGddb0PqXEULA7ouwdc9Ot8R9Z1z38fDuXBUU8TfGXgutifaC3hxmioBlb12Yvo+j93R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtmxI4bO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-793021f348fso5140811b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761062163; x=1761666963; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9NuM9NxvrAaUomQK+eU5/GRUQ/IUXPFsKBqtif+2vUc=;
        b=RtmxI4bOGjVyU49EtUsnhPHnNL0N6Mgl52kDSNLWSM27h1vRoI7WSo3U6INXoTBRzl
         iULl9FVhBSPOV/4c3cNxXkvTJ/tptOsPYB+wTBIAfvpwLSrSH7RjqHviW5EcuxGzH66U
         KTDwM3RvUhH/Hmsjd7yA8JkhGmgdHw3Hvw9eqSsIWtdawAckTNiIwjTdAfSgRtJJVtb+
         C2A4/eAkpYqJv94AFa8ac9ezEv/p9cauDvX+INy0r9gnwx5nvn2SoApQX976qkSpbzhI
         WI1lNFf+14nwE4KX6fVJWCoVHp+12JNTvTUezk7TJi/wQiGGI6/fsPZac32BlbVShTLc
         j6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062163; x=1761666963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NuM9NxvrAaUomQK+eU5/GRUQ/IUXPFsKBqtif+2vUc=;
        b=wMXL7k8eZS0SnDPYkwvJxbLVhPDGaFUlwEzxVQQYmc3MqFkhgvzU5hZzWBfLlb8ivv
         /L1bHaY8pOHLXSwLSATzZFn5TKu7GzQpK6ggPjM7cY1fu8BEQM88fpQtiqAuubfTVk+z
         rYb9nI9B3IxnwqL1ooEi4AOqys4cSS0UvH+b/1EMdy/yIwWP+rJ3/8y+NHKhTYFEfmgv
         xDqFjMqFfVmFyJ+EiUrgI/AXZIwDJ6HTn0n7wbuPYhP3fKB9NKvxEiMwf/afbygAWw5Y
         9RL4dZTu/n+1iX5fHgSmuFMasDm9LSJowNKbXKVW6QhP5OgWNmEFduv2zM8uZaazu4Vp
         V5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWbrvaBeho+U1nz15BgBx76nirDioGS7eB8MbHpe5ufrEn0+mmeF32iD0kILdf7LUU7HREKHRsubyu8+/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMqpVrH+r2gUuaK7/A7SJsrJ/Hqz82EJWTZmd7UvdUrhLkWsm
	A5Hud8zlv3IPdagFhKa52ZLLSZVySWgkUY/IAz4lXRd9t2PEhKmr2Eey
X-Gm-Gg: ASbGncuA6lHNIeEqOutQpW5W4gBpMXWE0Jzs922xrQ5EeWVgzzdpYZz904GNu8DMG5L
	GyZuomtMRt1hcH2YqQ//3EvFGT0ww26bqEW87vYV4XxWFgR2Y1sF6mdO418xX3RfgDw9QEwZsCy
	RYxnxrK3SAGptuLg2l3SshIqJgrW/NpKVZCwUKp+vai4od7750Fq0u4rYd0v1wnYRn+RpkNuNUm
	9pj70MCkolFWjahlqb1oKGEhO10norokYgHCc7A+d12C2X0Fkw1tuGc87lIW9bb89tBx8QCLLpB
	RTAUM3sYRDkOXWFgQM91JIVczTN0iQxvCeIOizW0pdNLlvPFe1Li3xj9Sky5sAh/8oNlTxGfhGD
	vLBmSrOL5WKH6KjJ1oGNua+Cx3vKdi6IxA73zIAo5KTXGPExCqdeKY0vw3ltD2sQmpll7pGu0DD
	MkMt0kZZ6v1+3RskyYfLs+EDCpJglJ5hofiafD
X-Google-Smtp-Source: AGHT+IHcYUVZInwV5j7HGErIAKOBZtcl/ZY5ioU8jv8MIcJcezR92mWzNOgV5n7d5cG/GiuW4mdsKQ==
X-Received: by 2002:a05:6a00:3696:b0:784:27cb:a2df with SMTP id d2e1a72fcca58-7a220a61ac4mr19382489b3a.1.1761062163287;
        Tue, 21 Oct 2025 08:56:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5f45:f3d3:dde4:d0ab? ([2620:10d:c090:500::6:82c0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f252csm11638614b3a.38.2025.10.21.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:56:02 -0700 (PDT)
Message-ID: <dacb24230861da2eb8fb5bd7168bdca571727b62.camel@gmail.com>
Subject: Re: [RFC PATCH v2 1/5] btf: search local BTF before base BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu	 <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Tue, 21 Oct 2025 08:56:01 -0700
In-Reply-To: <CAErzpmvLR8tc0bfYg6mG82gqMSXHq_qXeMsssSDuzirxkSt-Rg@mail.gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-2-dolinux.peng@gmail.com>
	 <76e2860403e1bed66f76688132ffe71316f28445.camel@gmail.com>
	 <CAErzpmvLR8tc0bfYg6mG82gqMSXHq_qXeMsssSDuzirxkSt-Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 16:31 +0800, Donglin Peng wrote:
> On Tue, Oct 21, 2025 at 9:06=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > Change btf_find_by_name_kind() to search the local BTF first,
> > > then fall back to the base BTF. This can skip traversing the large
> > > vmlinux BTF when the target type resides in a kernel module's BTF,
> > > thereby significantly improving lookup performance.
> > >=20
> > > In a test searching for the btf_type of function ext2_new_inode
> > > located in the ext2 kernel module:
> > >=20
> > > Before: 408631 ns
> > > After:     499 ns
> > >=20
> > > Performance improvement: ~819x faster
> >=20
> > [...]
> >=20
> > > ---
> >=20
> > The flip makes sense, but are we sure that there are no implicit
> > expectations to return base type in case of a name conflict?
> >=20
> > E.g. kernel/bpf/btf.c:btf_parse_struct_metas() takes a pointer to
> > `btf` instance and looks for types in alloc_obj_fields array by name
> > (e.g. "bpf_spin_lock"). This will get confused if module declares a
> > type with the same name. Probably not a problem in this particular
> > case, but did you inspect other uses?
>=20
> Thank you for pointing this out. I haven't checked other use cases yet,
> and you're right that this could indeed become a real issue if there are
> name conflicts between local and base types. It seems difficult to
> prevent this behavior entirely. Do you have any suggestions on how we
> should handle such potential conflicts?

What are the results of the above benchmark after sorting?
If things are fast enough we might not need to do this change.
Otherwise, each call to btf_find_by_name_kind() should be
inspected. If necessary new APIs can be added to search only in
vmlinux, or only in program, or only in module BTF.

