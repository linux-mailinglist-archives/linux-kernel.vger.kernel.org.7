Return-Path: <linux-kernel+bounces-875785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCB2C19D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561B61AA7DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE17331A7E;
	Wed, 29 Oct 2025 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bg2j4d8B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424A253F07
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733807; cv=none; b=VVS7r6Pxt0JLHAXxDPYqKB7xmD5GLZTTyajAVfJ66CL2KJ3bsZ5b8Rl3ec3vrv1xikF7bZ6epCMTkB06HvtRKcWRs5jdN6i2XlVEQMaddBziKvb25ZZcHOioacbbx4tGs3kmgu34x7R1fHj1Hcul6BJeP/Ebe7dzMM89cgjaxUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733807; c=relaxed/simple;
	bh=1xvw6jnS9dphQU0A+xYtPnJM0bu8KsBQ5+TFi+aJW9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fov5hSJkBB6l4ebkDTT49yv0GfLiUl69pilP/1fYs/k5bSvpldDTVMBcoVVw+2ZL+pM4zCMNiYOZ1olAvMUWloefSfl1HuX607MthireYl0hHbWSKyGDNbrL6xuf92HSzUB7jwYXx6sXc3kvRAOT2y+RuVJpwll5GVtuYsaD5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bg2j4d8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761733800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOr0TIPF44tJyJqYfe12OzLBv1F0AjLtcIhaWVvzF8I=;
	b=bg2j4d8BwlIJ7hz2S7ZGWCDqje5f8Uylf5BHjCzcsFDW1PAXPIzDd3MXJp4yd1pRtzcqnQ
	+lgEFW4YkSyRU0+vcJyONW1vhGNDQthRwGeTO/v2vD+BgfjFECX9/qZJSG6tjqb3VSvqbN
	dwmAvj/vK6TGIFi2pOj7GlNIiRWSUZc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199--kpaMqTvOKGeapelDXMIeQ-1; Wed, 29 Oct 2025 06:29:59 -0400
X-MC-Unique: -kpaMqTvOKGeapelDXMIeQ-1
X-Mimecast-MFC-AGG-ID: -kpaMqTvOKGeapelDXMIeQ_1761733797
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-333f8f1d00aso35876531fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733797; x=1762338597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOr0TIPF44tJyJqYfe12OzLBv1F0AjLtcIhaWVvzF8I=;
        b=p2futo27Uhuzl5MLwuFH4jw3kwEBoBUfTShaIYDyF5beKE1DLqYCM9Jl0Gb8niE0lV
         TtjcH0MaQuvTDFD4Uzdy58r9GkmF6jdysmSlFkL4gOrZ3EwgpbS+fgy/DoAGKNML9x5R
         rrHpNH0iL8P2pgoNszFXo1oQVrqTDDJdiXzOzjBJHUKL2qHO5IWRdrLA1LlIPFjShMKK
         SQD7Ou7E7oXiPiDe8CjyVsqtUyTikEPuf6VxChEUKvfnMGPt51G5lyx3UpFHOBR1Lw1z
         ok/HLCkpsz8yJUhpaxc02KY4vhAuZ6OSlR/5ALRXvND/2WZPPV4rQygQt0g/zv8X03TY
         33Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXeUfGCzYIVRCh5QIPYrAv0epiSe6JfF6wN3INyo3iWauKabcjAu8OqnFEE/xKfWnGaihaKSMNPFB07d1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZVbv4VXCSESkxMkHSQ3KHn1TdsHcVanOggOnQRiES5PKe7Sb
	IXsuP8iwsX27B8+2RQUxlXxe2kybTIrjvNpAtI9df6sCEY4UoNreD6EhWQp57OS+IXgnSa2dmzt
	OM2IUyjiLq3n060TJ7cAqM0kEBSbRbAq/GJvY8khRJ4p6OTldXn9OukUFhwrvxRcrq/BkQOdrP2
	3ENCOvtgsEco4xDqJ4OhF+YpOHJeVR4678LDJxQAFA
X-Gm-Gg: ASbGncu3eQVXins73zfikfSOH+kIi6KQT9fN9/RYX896jHfXaKMrWlahhfr+RZO9R/z
	U+viGxm/VO5n8Otd/4b+gxF6cgPlwTXmDXZ1T/gk8c6QHmfgv0wNjxbpArlxZ6M9fFz52QINeBt
	WN7f+iKzJxPrehL6+LBcDbh90GSI+HN+3NbpRoq4yLL/ozEzXmTGVAAict1ti+sVUJbCN/N7gHU
	9OXKo8Yc8kckg==
X-Received: by 2002:a2e:a912:0:b0:372:88fa:b680 with SMTP id 38308e7fff4ca-37a023fe4dbmr7196311fa.29.1761733797419;
        Wed, 29 Oct 2025 03:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEmI7OhiZ1DaoF0/cxs1ZCK1+ak753Z2dzk11glrhPicvhcrDjwhlHyltg40JzvHXiomdTvuMbjo4fn2pfDVs=
X-Received: by 2002:a2e:a912:0:b0:372:88fa:b680 with SMTP id
 38308e7fff4ca-37a023fe4dbmr7196171fa.29.1761733796930; Wed, 29 Oct 2025
 03:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002123553.389467-1-costa.shul@redhat.com>
In-Reply-To: <20251002123553.389467-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 29 Oct 2025 11:29:45 +0100
X-Gm-Features: AWmQ_bmTMI8Oo-s2wgCfKYhoIUrQHQvFY47fFfRRzWpWMdM4FSdSOWEtRJKcdR0
Message-ID: <CAP4=nvQbr5Adrk6_TDLge0TfqOwOhE9Q4iRzCqQKpwx29d_QHA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] tools/rtla: Add for_each_monitored_cpu() helper
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 2. 10. 2025 v 14:36 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> The rtla tools have many instances of iterating over CPUs while
> checking if they are monitored.
>
> Add a for_each_monitored_cpu() helper macro to make the code
> more readable and reduce code duplication.
>

Yeah this iteration is repeated many times.

> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/common.h        |  4 ++++
>  tools/tracing/rtla/src/osnoise_hist.c  | 28 ++++++----------------
>  tools/tracing/rtla/src/osnoise_top.c   |  4 +---
>  tools/tracing/rtla/src/timerlat.c      |  9 ++------
>  tools/tracing/rtla/src/timerlat_hist.c | 32 +++++++-------------------
>  tools/tracing/rtla/src/timerlat_top.c  |  4 +---
>  6 files changed, 23 insertions(+), 58 deletions(-)
>

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


