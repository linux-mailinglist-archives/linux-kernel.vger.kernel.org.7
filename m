Return-Path: <linux-kernel+bounces-829541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3AB974E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659D31AE0182
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA23302CDF;
	Tue, 23 Sep 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0fSWwDHz"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73027EFEF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654700; cv=none; b=fn4/PEesfJDLJX0qDfvuQ/rk7gOR+gKHAAv+in6dVj3XJEr0Olv3IB2CUsG0Y9S9V6m9ffKIbIesGqZN7G46wTOJzaLN6loerLmMpdCSqrLULtoqsomwkgPIoqaKjSyCVnezl4Qqn4lOT59GzijkaD9EiqqH37ziOog9xkA1Pco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654700; c=relaxed/simple;
	bh=v2u3DDN1vJUVWkyENZTFaLudE3ZJMgsmiptpJTv/vfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIhHt22ZkhWs+GLFjlTUQdm6GnDd2XyDKwFy0le8E1Yx9x1C4xlGJ0db4fg7sqAmc9dF0hGCk2Ph4mSE+wE5s3X8Vdp77eqAiWQUGWc3LEsdFvhf/5fm/5hvTERrI7TMOLcIFIOY5DKJAzpJ3JK36P6rg2tqd4SxK1I2FiDIfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0fSWwDHz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2699ed6d473so40455ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758654698; x=1759259498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0aRp23onmuK1YI16vYV3557ffQNsqGxBUdhV7enEBI=;
        b=0fSWwDHz0oIyjDBSo4CDVQuFl9xJlDzuTlUvj/68pPHCpLQwxgoQ8EXIvSIEftQi6I
         wOogkB5BhbnuQV7sWlLgXmHJs3jDQ56uatQcsVK1Vh8tsSXVVQmBGoIHylLK929zNfAT
         xx/Q6dtJHbphNKUWzZ4cSWHK8P1/l4I01Us6qK6i3/35R0KDH6hbzgnit0TGtIrkQYS5
         Lue/8TH/JqY+KIE7DHHoeEK1fPunMJmaoR+4pUVqC6dPtmQ4X3Ig6DBTQ376t2E51azc
         KiaVJe6jnsrAhdkI4zqvFsg60LRQ9XjczEPyL8/YgEgYcMyq7J+Y1ozH0C71GK7e+HCS
         rtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654698; x=1759259498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0aRp23onmuK1YI16vYV3557ffQNsqGxBUdhV7enEBI=;
        b=fz+GcL20mYmldOxNTokvWLuy2d0VWIfvRne1yu3hL4BaK67FcPr4uwEnZiIWFbOjTN
         MrHzqZpV2tq9BsBSEBi6bsYZY9+/M92MI9QDm5ytcl0GQ3rHmTduywYzAB/QZSIUgBZy
         KFoMYyyWRH30XxVhwQOjwCY2OUv5rH9c39wRwyuewhdBOz8tg2fKyu9mTqFgNDmd8dwG
         wIMDD4J9XdqrUln2RC/50Y+LtJVKt1CD3ezDlkrJAlGdrKVA5YpSnEIohBahfwYcNosA
         WZ9Gct0ydeL7/d1UXIK3pGwEv1+B/nLG4mQaqzbcUWzoVBFRHreptmiOAA8CmPZf8O5r
         XfZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXjgQMF1HU/Ww/dZyEC2Si7cWjEVI4fl7NiJI4gYiyIl/5qZblVNDRJqp0u77++e2HMNbMTVJ/n01NFjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFE3mt3M6DhGhDqBLFPKdGvbsQ2vKrDAQIu6Nxr69A0IWcUQcD
	7YStoui7+deV4mc3lmIhMijc27kvYwngsotUV4NbBh61jMmMugaz/yEqoow//wbQgRXks1/eQdj
	V4Bp0AwpXL9CMsaNWy52QjWld2tT6C8VCn9Q/FWwe
X-Gm-Gg: ASbGnctTpjUoa4+zR3vJX0poTa/1Q19Ocszwd0F4annuU9fK9ep7DaWxP8lKGeO4aGg
	OYpvlWzO5eymt6+XHAQcr1NsfabqePLH50niw8oQFmWDPne48ilcdIEyCS60QNeeIhfla5Xg1K0
	aeUodk0YjJyq/WPjiJ/LOwQBYL8cTUf+tXwqWi/PA8arQlr0JWKVD62sEF5TTup9g2e00SnkOlG
	PExB/OYJDr7hyaTOCTsoSFv4Mtrkz4y7I4U0MUkir/w
X-Google-Smtp-Source: AGHT+IEpvMZS9o5jaVovIxZDwZ9QySAPJBblw7ubBZWZX7nsSiZOYR0nqp7c69ovmbFdYEiy+CLg6p+NRQ35tylvJe4=
X-Received: by 2002:a17:903:1a2b:b0:26a:8171:daf8 with SMTP id
 d9443c01a7336-27ebe65b3b6mr791355ad.8.1758654698276; Tue, 23 Sep 2025
 12:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923174236.12372-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250923174236.12372-1-suchitkarunakaran@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Sep 2025 12:11:27 -0700
X-Gm-Features: AS18NWD5fQaeN06M8Yt6DM0g4l5r_sCqXJfp2FqaVb5LfSYPs2ldnjrBFJ--oqY
Message-ID: <CAP-5=fXVFBewYhSmjVCGTbzEN82apECRLRnSeit8rqydCBJ1bg@mail.gmail.com>
Subject: Re: [PATCH] perf/annotate: Use architecture-agnostic register limit
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:43=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> Remove the arch-specific guard around TYPE_STATE_MAX_REGS and define it
> as 32 for all architectures. The architecture that perf is built on may
> not match the architecture that produced the perf.data file, so relying
> on __powerpc__ or similar is fragile. Using 32 as a fixed upper bound is
> safe since it is greater than the previous maximum of 16.
> Add a comment to clarify that TYPE_STATE_MAX_REGS is an arch-independent
> maximum rather than a build-time choice.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate-data.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-d=
ata.h
> index 541fee1a5f0a..1f76885facb0 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -189,12 +189,15 @@ struct type_state_stack {
>         u8 kind;
>  };
>
> -/* FIXME: This should be arch-dependent */
> -#ifdef __powerpc__
> +/*
> + * Maximum number of registers tracked in type_state.
> + *
> + * This limit must cover all supported architectures, since perf
> + * may analyze perf.data files generated on systems with a different
> + * register set. Use 32 as a safe upper bound instead of relying on
> + * build-arch specific values.
> + */
>  #define TYPE_STATE_MAX_REGS  32
> -#else
> -#define TYPE_STATE_MAX_REGS  16
> -#endif
>
>  /*
>   * State table to maintain type info in each register and stack location=
.
> --
> 2.51.0
>

