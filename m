Return-Path: <linux-kernel+bounces-898119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97AC5465A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B5AE3441E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3EB2C0294;
	Wed, 12 Nov 2025 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T730cRJI"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6843C28468E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978611; cv=none; b=fyUD4Bo3f3sVmtQQOhWHsarVoNriIM3yuwIQv8PmTkTBwWNtCpJCCNfpIHmqZYfqlb8srUW8mxWWv8uwqG/XGbdip1R4Zx3k6GSr2p7m1nQcJFNq1o1kxPXHdhYymi+l+LGF7fqI8GFA97ldJOi6vlbUtmlRmDrYDA7YF5pd5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978611; c=relaxed/simple;
	bh=gPFd5y0rR8p21X+3l9xdR7CUDfAx+2Mt5Sfjeix2bIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ip2E3BAtvCZl8UY/MNcletrso5P7tyjoYNg9MyXkY3R5p33KkUrcgJZelI22+svb+W75yAlNJOGQTmjDZ3ngHQHteFIf4BxK+Br0MGXnELzNv0TUmk+ZJVvtOg7hDvAWaLelNpOmnNuaQD7ZsVAPTUsvrAMK56l1QrV01lAMaWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T730cRJI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3434700be69so67562a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978609; x=1763583409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iy9QvFMHYMC0PPM0G9nClDSW+eIfFhvEVPmCMvOH2bQ=;
        b=T730cRJIVCoveDDyvJsa0KCNTZ+y3j/zaGwV/2dwfVnOB0MZQjO2aFprPO2zno3hjz
         0+YXOQhBfBCGZi2kZloyHSIY5eu2ejrHZ8kv+BB1PuVbJCu0R43CWsGGTEuo/Zpox2se
         heLiJsa3BOWgOW/7ndnx4B2IEj15/l9QUj3tKr5HnFa+1CiGI6rCr1KZDXqUrWQLbu3l
         xaqh2QMvvrlbddPgNHKaOX423zXnB+L5Qpu2qnOyaA9zPVpbmK8O3/Mk/HIATU8uFb7o
         BjMkzGeRu2L6lnhRrLnoah+n1uaZcLYviZSz1Ev4UypfyhShJJvhl0K/HJk1tZ+vYFE7
         VD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978609; x=1763583409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iy9QvFMHYMC0PPM0G9nClDSW+eIfFhvEVPmCMvOH2bQ=;
        b=Mz1YJa/v4Qmn1fx4Z2BVK+Mp6e3KYQBQ0gRhFbQEcq6q9qOotLBsmHthtFYx9alrHT
         Y80vHEqDrzdOJNsOC4ZrAxACkh1H3bjEoD1+5gDWCOdOgDkXURKiu2YM1ahOAzU+b8Fc
         XlADH45WbBQV14AzhoEg9ALw45WWhvpQwlMV2E8pjqBH+942YiNv/DPglxZM0eb+CiZD
         CWrZMFrifoEjP7iKSQutjo5Psfmd/j8s94Ayj6W08MLGnUbowKAN/mZAqaNN4jUBffNf
         7QCYw6FQMrCpPtnTvVcpdLB1/ZRW/H0NJPMiZXWLqf6e/0AefB51Z3B0NKJjG5lYuts2
         Keig==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6HXXHZhvcMKUNmbusf9fqkU+VmKcOp7ZLXcmmvBJZ7owfsFN2wUO70a2/QeGbG+2PZOWE+NX+SFvHJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+3pDJRfK8T9tW/5yVQtHQFGxkWvUPHvhRtFFuHJqdelw+WuT
	Qoqy7Wx9i2/lpR6mQfBoD3K7SxU0ZWCNl13EXyL14Cp0jee/VrabWWJv
X-Gm-Gg: ASbGnctnuABKaniBkeUwzuVU065bwHEob+Tj/cjjzoYAvBRwvKoaAbJ3+GL3oIQ5Miy
	kVGit0hitHrZ87DQudiNNKEJFPd59VHAcftpx00O9LN8VQ6w+ERhADSEVo2kyAk1f+JZD/DdNu/
	DyKoBKOFJh5WOBNO08x8/Jqeyr/wCSduWMESZ9m/eJb+aKTs1wP88UJVK1DbirnLyOjfJXsoMpE
	XJhBqMn5eeS5kPN+oeFIShLQ6z/ticjhS0yKC6ns8/utGRlotEA7k+vo5ltMAWplzDo5NQ2/GwG
	7CY2Ft86fxvG1Dg86UNyxkidHIhxxCxV0wkvodV34RFSWoEefb/+4eYuDBgejBU52uLHkY+vP9h
	LGrN3IMSl0+5hoiLzt078v4yGENT+ZjviRJEsuGj4BOT2A2Es7QzFKqAMSDCNSSqa8GQ6sKn/3z
	oyFC0PFa/M97rc1HbkuznGzxICXrUGNtoMQecW
X-Google-Smtp-Source: AGHT+IFT2kSJitShWf+rBUmQwnvP/sUF7RjsGACgdyKqifAKv6G5C/wsXFal3/hzc9Gwi+9nzTbYqg==
X-Received: by 2002:a17:90b:3a92:b0:341:3ea2:b615 with SMTP id 98e67ed59e1d1-343dde29c37mr5533570a91.15.1762978608682;
        Wed, 12 Nov 2025 12:16:48 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3e6d:747b:3d83:10e8? ([2620:10d:c090:500::6:aa7e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e072580dsm3532839a91.8.2025.11.12.12.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:16:48 -0800 (PST)
Message-ID: <31a5fcc60535d93b8b8ab7e9ca38487038fc38f7.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] libbpf: fix BTF dedup to support recursive
 typedef definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>, Ouail Derghal	
 <ouail.derghal@imt-atlantique.fr>, Guilhem Jazeron
 <guilhem.jazeron@inria.fr>,  Ludovic Paillat <ludovic.paillat@inria.fr>,
 Robin Theveniaut <robin.theveniaut@irit.fr>, Tristan d'Audibert	
 <tristan.daudibert@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Paul Houssel
 <paul.houssel@orange.com>
Date: Wed, 12 Nov 2025 12:16:45 -0800
In-Reply-To: <c1b79b23c2a20964792961f23348970ebaee14b8.1762956565.git.paul.houssel@orange.com>
References: <cover.1762956564.git.paul.houssel@orange.com>
	 <c1b79b23c2a20964792961f23348970ebaee14b8.1762956565.git.paul.houssel@orange.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 15:11 +0100, Paul Houssel wrote:
> Handle recursive typedefs in BTF deduplication
>=20
> Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
> Podman) due to recursive type definitions that create reference loops
> not representable in C. These recursive typedefs trigger a failure in
> the BTF deduplication algorithm.
>=20
> This patch extends btf_dedup_ref_type() to properly handle potential
> recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
> handled for BTF_KIND_STRUCT. This allows pahole to successfully
> generate BTF for Go binaries using recursive types without impacting
> existing C-based workflows.
>=20
> Co-developed-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> Signed-off-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> Co-developed-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> Signed-off-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> Co-developed-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> Signed-off-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> Co-developed-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> Signed-off-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> Co-developed-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> Signed-off-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> Suggested-by: Tristan d'Audibert <tristan.daudibert@gmail.com>
> Signed-off-by: Paul Houssel <paul.houssel@orange.com>
>=20
> ---

No differences in BTF generated for kernel when using pahole built
against libbpf with and without this patch.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -4939,7 +4979,7 @@ static int btf_dedup_struct_types(struct btf_dedup =
*d)
>  /*
>   * Deduplicate reference type.
>   *
> - * Once all primitive and struct/union types got deduplicated, we can ea=
sily
> + * Once all primitive, struct/union and typedef types got deduplicated, =
we can easily
>   * deduplicate all other (reference) BTF types. This is done in two step=
s:
>   *
>   * 1. Resolve all referenced type IDs into their canonical type IDs. Thi=
s

Nit: this passage continues as:

      * There is no danger of encountering cycles because in C type
      * system the only way to form type cycle is through struct/union, so =
any chain
      * of reference types, even those taking part in a type cycle, will in=
evitably
      * reach struct/union at some point.

     I think it needs adjustment to refer to typedef as well.

[...]

