Return-Path: <linux-kernel+bounces-876336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4730FC1B388
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E407189F1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5908F26E719;
	Wed, 29 Oct 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHgCxoCf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356241BC41
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747828; cv=none; b=p8lRhwesZh01rgg/l0POrd7w8KtsVIOCdsPdDgnk4K3ftk9OaA/StBcfM7Gk/HNTekNZ6YyxLNdqPUwFI8RBLrY0oGZrVXFm+LLXzYmotFVDlBK9qkahULZHbyGT1ckRa8SXdFK/hUnHsR0Ry+350LD2wtTGsjizBS4BcPP30UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747828; c=relaxed/simple;
	bh=DNo1hgqNvRCyVfNHnBGy4JS7DKjy9pyFK/LBe0nXLBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVofE108+WAwFlbVu1qsd76wkoWsDVQy+kpcoyQzTdjuXxV0sL8YFK6giMdCafA4Z4YKuokP7nnuZNavpe8P7qT7Zf768SGMkpuaYs49ltc9ZHwsepE5hhxs7i/5S9As61ufoogLyZQH9eZyWeSP19YgGtqnUYWWnj5XJlfBNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHgCxoCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761747826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRvYYOi3Wkd2PUfDCfc7B7Ic5qwV5aXr9YzsvzLTMYY=;
	b=bHgCxoCf4d9LJxnIPUH3f1j8P3Gz8uOhK/xcrMwVTfDGgemL0cfjV/rjeUkd6eu7PFlbCj
	OiHAfN1d9vt/fwJHmKWvk2/MRJ5zPWMyl1ShRQIXRNfM/55Z7wr4drHVQy2PG2I0wOpbY8
	vKdlOGoKJz3SIXUsyglLuacgqEgHc1E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-sL-eGKieMs28B54T7H_vEA-1; Wed, 29 Oct 2025 10:23:42 -0400
X-MC-Unique: sL-eGKieMs28B54T7H_vEA-1
X-Mimecast-MFC-AGG-ID: sL-eGKieMs28B54T7H_vEA_1761747821
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b5c4d76589aso608276666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747821; x=1762352621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRvYYOi3Wkd2PUfDCfc7B7Ic5qwV5aXr9YzsvzLTMYY=;
        b=I6JD9iEn57wkWkDKL6T+9c9nzWhHv8g3nZq+tiJ6Cmp+9v2IVeA0aeNEtjeBgulafs
         YP3i1WV1lnMZO+lnVG7uoyaXjYBdYs+R8dlxz6PgKphf0nHTCOCbvEUchcNyuM9DlUcc
         XnXV3jMh/bZartTFP/a65ifoe00UZ5Rzickt/It3SoZD5pwF+AR0xnjHeGfnHZNb8MUI
         hUHXA/0/Q8mOXSw9kNpa9cmZT8qKxxcQP3BHpuY9vzPR+ogGeuGnq9IvI0thUnQy6FLT
         yF5EEAE2+/BkwArV7NnJGyJn2Kvkg5h5GVPbtbKcO6h5V8wDTzH+039uy5HPQAVAZOTA
         h4nA==
X-Forwarded-Encrypted: i=1; AJvYcCUAmc4BKCxIEDibh9JHkVBhbUwYfhPXL/t3j42ygqi7cn9p3ZY4xyaPZzGcZFrj40KznwhP68oDCsIbJpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyrsb/wJOJZG/v1wWxwFvSWgXwl0GHg184Z1i61Lx/lfJSLzE6
	u4EVt9b1pbpRtQqCMB0UoEnY1oXAmwQhrA3chQhahFCEIgoEiPH8+5NssfIcFHOBsMmcL6KEG5m
	01IMiQMpoQt2ugH5olh61Ndvx2HDviF8C3+1nAK3C4C1U3dqJqoMEjCpI30h1MlnFkBrQtxYbaS
	v0GYsGQomXCHRRrXwoEr9uzFUAnOpj4pRkxKCnNau5
X-Gm-Gg: ASbGnct9gXnAR8e38zv2VArJdSBA5Hm45jmmxp6umK7frgEi3+KJlm9NKU0L313oEfF
	mudUAUYcDjIKBLW6LTkhN8rj/G77ZnXT/PTVMIxZp4EbPW3T1zyUI5/P7NbP7ylnAhS6FqbQOqJ
	0iSGk2AC1AZc6tZMh/bwVpXofQBq4UfNCecfpGHCAF69+rYE9yBRkCm6hEWnX2oL4APMXYxlrmm
	l769xQVf1j8Lw==
X-Received: by 2002:a17:906:f5a9:b0:b6d:c3b8:8611 with SMTP id a640c23a62f3a-b703d5b4967mr287115266b.61.1761747821453;
        Wed, 29 Oct 2025 07:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExh0b3u6BWRWoAABr1Huy6PhU+hinwtnzc675AfZTC2+zrSaIIz72xAgHbBa56QuCvP02Fk/rwvNoJCpS7CqU=
X-Received: by 2002:a17:906:f5a9:b0:b6d:c3b8:8611 with SMTP id
 a640c23a62f3a-b703d5b4967mr287110666b.61.1761747820414; Wed, 29 Oct 2025
 07:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011082738.173670-1-costa.shul@redhat.com>
In-Reply-To: <20251011082738.173670-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 29 Oct 2025 15:23:29 +0100
X-Gm-Features: AWmQ_bne8eATCgcz-kIZPYttDtQkP6BK84Xmqvl3A-YIoIrM1rI1wUSAK_U5m4o
Message-ID: <CAP4=nvT_MUKx5JzsLBg1XoFMmku3z9NZ4NjY1WFc2QKaGnPZVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] tools/rtla: Improve argument processing
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 11. 10. 2025 v 10:28 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> The long-term goal of this patch series is to reduce code duplication
> and unify argument display and parsing across all four tools.
>
> Costa Shulyupin (5):
>   tools/rtla: Add fatal() and replace error handling pattern
>   tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
>   tools/rtla: Replace timerlat_hist_usage("...") with fatal("...")
>   tools/rtla: Replace osnoise_top_usage("...") with fatal("...")
>   tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")

It's perhaps unnecessary to do one commit per <tool>_usage() change.
On the other hand, separating changes like this helps backporting (not
much relevant here but relevant in other case).

>
>  tools/tracing/rtla/src/osnoise_hist.c  | 74 +++++++++--------------
>  tools/tracing/rtla/src/osnoise_top.c   | 68 ++++++++-------------
>  tools/tracing/rtla/src/timerlat_hist.c | 82 ++++++++++----------------
>  tools/tracing/rtla/src/timerlat_top.c  | 76 +++++++++---------------
>  tools/tracing/rtla/src/timerlat_u.c    | 12 ++--
>  tools/tracing/rtla/src/utils.c         | 15 +++++
>  tools/tracing/rtla/src/utils.h         |  1 +
>  7 files changed, 128 insertions(+), 200 deletions(-)
>
> --
> 2.51.0
>

Otherwise, I agree. Especially the timerlat tools have so many
arguments that for a typical terminal size, you won't even see the
error message, as it will be pushed outside the view. I was not even
aware RTLA prints error messages in some of those cases, I thought it
just prints the help for some time.

For entire patchset:

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


