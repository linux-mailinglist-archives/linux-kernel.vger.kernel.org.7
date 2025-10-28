Return-Path: <linux-kernel+bounces-874530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EAAC16858
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D3284EB41B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223EB34F465;
	Tue, 28 Oct 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPCuih3M"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518D34EEF2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676819; cv=none; b=Gm4MgeVw2Ff1qZb6mex1+Z68drF7fqdKKGknvA7TAb4cFJvM98yE46JkNUzBSh7/cVZ3XmmfCiEl47AnIPChWPnT0iQJdq8kmFGJzpL66vH9y7QefziExTnpDJOkwstlNB9jI+IkJx8ujef59xjO7rWLD5RCXxDNRYmOtV+6Vzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676819; c=relaxed/simple;
	bh=YHUyqG9og7JRiLqH4LyIAka56ptv6pdodMSXVssNBPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIhoGRbsRXGdplMNyn5Unw5eD1HBS1GTu6rKICL/zG1eaeRUoMqLX02HxC3GDFrOOPmRA74+1HUtMs2ijqW+DdQQEFpT5HVfOiOimB4u9kAAA1x2GT3DLmTuKxL/IMgrmZP3gqC8ah0w1iovi99eu62ZHsMwwCTHwBroQ2oYvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPCuih3M; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so6438750a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761676817; x=1762281617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReHRtTE3vpAbKBdAM1gtLmprCAAoAlRTRkSZ/pbLtpY=;
        b=aPCuih3M3sTZfq26ff42uHYNlimbbmyUp3u23K6QobQWTGpkbinrzLU4m/AktGHdyK
         VL9WaD9M6O+cDDHkWqvVKOzV8MMmjAwMI72Apv9VkMuv4qnN9V/0Ozp3YCh/dCgGqlPV
         NHUBxLWwEefvlwe7woasAGFljrukNZ/1LfIoEkJScYLLknghxntRn+mpMLAT37ZSQ7fy
         ug1kXzeKtFr3yy9N5xnRNbv440mEv6OCKvxrXWneMwyqK0kYoQqEOVf5JeNCiBQggm11
         LFfLFAGZ6ad6BRVu97IqlO3Dk5OHhu7VPdMVXPPlilVhOuXZDXw9Hq9xUflJBEmaA8tb
         JbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676817; x=1762281617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReHRtTE3vpAbKBdAM1gtLmprCAAoAlRTRkSZ/pbLtpY=;
        b=qWgnUxHTzGZIQuMNUoKDVT1hzk5VwhSgYbv1PJU0zoriKAdSkNJPEXHL00RwGBfUyD
         sXBkk2SnF7tipe5m+hilsGWh/rosGssu4hW8cNMmjGHyTj4RK++7/0wzUwUbBSwUer4j
         HAv2+huNeI0aeLXdPjtuiXqemdTI07SCC+8Q3i9fKOkulZmy5o95VZCcqbEaeQAoLHbW
         XMQ+21QyR7OkUBgBVDRuCOBUbqB654wfkZzrpTYRDKGeSwX7p3ZNoWLZ7WBMP9BMCmiS
         bWKfvRr5SAC9hVENJZf54T5Cc42Nd1+Vv4CJ1HMfCer9ZycrSfJXctqf/5yJOvRytgi3
         pr1w==
X-Forwarded-Encrypted: i=1; AJvYcCWXuBfyiLdpECGwgneEgfqmqSomY7NHxbPWykwJUqcLilZYA9eNIZxW+nkOWeOKG8v+PbzEo1Swuv+c8CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLw9Ctym6T64hHSXkLJmOIklFgJeJHs8aPZnGeCp3TzEPKHdTx
	aYfOM2Dg0VjnGS0nRfJsY1dSzQsmBbHGiAQs76HU1hDDwn3fWFYd4M/EboNZNFrgxyRnPfMQMg2
	NFQBQbDEUt9Fx8SpoBXs8quOiPTifOn0q1A==
X-Gm-Gg: ASbGncuzK6IkxL9dp89awXHOoGEKppTlzUugV5mKgcnmWCiQNC6q/HF8PZi+F/EIIyM
	m5dtNUE0l/HyCK4cz8Or2DyLPMZ09YematBGcdD8YFxoTYiQeCjDt1y0VR61Mb92lCPrEAbJXdy
	L/K8b+uNN+qyArQYi+S1yp5/NTKWMpxyuUa3t6/Mgs3fhGmJPkjW1djmnoaz/m/IYEeBHovxeCE
	j2qimb5zQRPVVls8kHs7fFA9Wd/QuoqRLsTtqcWR8pioul0u7nwDLz4R7+L3ok8N1qOc++cm6MX
X-Google-Smtp-Source: AGHT+IFpi9zDAw8H+uPYXYR7N1r5jRqU5Ai68jkqn3uM+9psX8uQczEPz/AgjranWwgbURI8mlaG82WgPadfnvyMFso=
X-Received: by 2002:a17:90b:4c4d:b0:31e:d4e3:4002 with SMTP id
 98e67ed59e1d1-3403a14377emr52330a91.2.1761676817234; Tue, 28 Oct 2025
 11:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com> <20251027135423.3098490-4-dolinux.peng@gmail.com>
In-Reply-To: <20251027135423.3098490-4-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 11:40:03 -0700
X-Gm-Features: AWmQ_bkfehzA6_mDWthS_m9oyAgVFVGQGAttnEawAXl4ZiOgz-ClG0bQjogRbQ0
Message-ID: <CAEf4BzZ+tpT2ViD_zc8mwz260spriYDiPymw3MFsEibRcuqbqg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting
 verification and binary search
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:54=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> The previous commit implemented BTF sorting verification and binary
> search algorithm in libbpf. This patch enables this functionality in
> the kernel.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
> v2->v3:
> - Include btf_sort.c directly in btf.c to reduce function call overhead
> ---
>  kernel/bpf/btf.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0de8fc8a0e0b..df258815a6ca 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -33,6 +33,7 @@
>  #include <net/sock.h>
>  #include <net/xdp.h>
>  #include "../tools/lib/bpf/relo_core.h"
> +#include "../tools/lib/bpf/btf_sort.h"

I don't believe in code reuse for the sake of code reuse. This code
sharing just makes everything more entangled and complicated.
Reimplementing binary search is totally fine, IMO.

[...]

