Return-Path: <linux-kernel+bounces-774524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BCAB2B38A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88813B8D72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB121C16A;
	Mon, 18 Aug 2025 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="120B0Mcs"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78B212B2B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553106; cv=none; b=p7g1QlJI+Zzies5I/I+VX5oNDOWs2N/u8U55ElGJka39gnscqFZKcB8byL5YwFM/kxbXBYU3XVFJu3s69OWxio7Eur/padz8xqKDXIlZVCgIykYpjYtkIYP6L0xVFbZRE76TYnTxOCKKP+Axs87R/5I/DD3CIPMAppgyen3gE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553106; c=relaxed/simple;
	bh=LYW0ZhtipP8/Xrm5uhsXRZP/OVbkLl1LZ2Jg3g4P1H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEnEVRAr/Xj/XXsdtqRSM+kGsrgxC51bnFq1GJ6UOClWZvVWqhn4BMXO6inI038YZSioXMtDUhbd1Q6ExR3qGlwus299ydOlQDkbiwTM+pVN1WlEXKUysZKpEqVzD1CCrcv3DGWQW+ql59FeP5fIlFjjm+Lz8m3tc7h6cTwuGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=120B0Mcs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-242d1e9c6b4so73535ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755553104; x=1756157904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhcnYV/5AHS3NB+DMqIzrtFHNwBfjNUqELn1LyD2twE=;
        b=120B0McstSfrZBgMI/1zm9sZY2sbjRe3unZc0WJxNDvkmGRGgaJFCr3sYk/2yANnfr
         YnqFboVG1Fvu9fuFANJ/r6kzW9btNSssDmEN747yRTLDTFLBOZfJs4/QL+xGp0qu3wdX
         g7sIilOzI17ouC5x9poh2sIygagfNjV+aT4gxltXh2tnlMF2InmKpzXLY09snGlMBGxD
         JxSAqfTAv4k57/sp/oZ2X5RBoX8goz1JaVY4OqsscC5PZKYxE7u6woATWPQnCVODEX3T
         WMNOb9lSv648xA6KBz4qcJJkjHXxRUn14X/gJIsC0A48Jv/Wo0UlyGZ3/JGpdNDm+4u3
         qEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755553104; x=1756157904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhcnYV/5AHS3NB+DMqIzrtFHNwBfjNUqELn1LyD2twE=;
        b=F543b68FzUd1G6tUUd0vwIokqtPqG/ZsNglWtjYOdJXAAP5OQueKQGn0a6to1FHqFc
         78GuuZ3PUybYVmHROT3V9koJqXADx3Mp7C4v+5tUXh2f72+gNKIBDmlFfnQ5g0WFctJS
         VxGvXG8dFEpx5+6n+Nv5+av09Kp6MzDQ0N47JrpZ1ZXwgX6Uqf3b7fE1l56WXV6KxELF
         IEwcJr84oAhCZjV1jSYH/WxK49VSBWAdNtaZ9iGob7aLqdmQ9nZPu21K4rMhu747Yycg
         mGZhW/ZRY0wgUoMk9bD8jXynbp/kPqgzS52QyiOLW9IhFufApSMZCeDFoBfmpQK2b88c
         7abw==
X-Forwarded-Encrypted: i=1; AJvYcCXhiF6kfhvu9fyp40RB/FcQHgLwDL2oLBAv6Iocg2kq5EF2DYaqqqZwB3+ju+rpoLqvlNdNTF0AlOQ6y3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyEHulrJhW3xE6xgCajbuOf+NoiJwGDVQmSAWSrWJgJWL1hwCm
	URulP1Hgndus50rxZ2lpBdS9tKKgOScOCELMi3+hv5KJtX+oB4x+mmZXLze9AkG5/1vSm2dmQj5
	dQnPb+Nik2u90WWb1QN5ZNDJD6xRtvM1shTx/SAU/
X-Gm-Gg: ASbGncttSdcZurbFIhVGQVxlTdtFEAemyzHgv22iGnt7H/e9XboLyZVsG5y7QRlZ4yp
	MS1KbebdWYCsvuTcE7AxM08hM9o22co5+pkWX2v8mgFYVudtOMhHAznRLFDnRWgZOdE71+BxL8O
	Hb8dXbTMH4c5614STzbGby11I4SofQkL+sAQ+iC0hsRPydJ6rgljkG4jmoG4XDUFwUx5/YHuJJe
	5YhhlwsuftPc6eIPWBq5EUqMHGGujS1J7U/OdSe36TGcFFjKAcYegpsup/44XTf
X-Google-Smtp-Source: AGHT+IFaPStKx7Mcyop16UEyKf81Np/31IArgVU8rjtYukefbi25th3TnORg7zv7GIxSUmdTI4omVi8T7VE7JEU+ue4=
X-Received: by 2002:a17:902:e54a:b0:234:afcf:d9e8 with SMTP id
 d9443c01a7336-245e063558dmr255405ad.7.1755553103628; Mon, 18 Aug 2025
 14:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
In-Reply-To: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 14:38:10 -0700
X-Gm-Features: Ac12FXxBq0slTx-nhWhlPHvSkVKp7BttdmbVWzZNF5teiKp6roW3gq1-CISAxIc
Message-ID: <CAP-5=fXdFQCgeF5DRH=-cUErz2opU98H6u1cTTO3ZPJ7SMQfMw@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf test: Extend branch stack sampling test for
 arm64 BRBE
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Adam Young <admiyo@os.amperecomputing.com>, 
	Will Deacon <will@kernel.org>, German Gomez <german.gomez@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:39=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Refactor and add some extra tests for all platforms which were useful
> when developing and testing the BRBE (Branch Buffer Extension) driver
> [1]. Then lastly extend the test for new features which are BRBE
> specific.
>
> Tested on the Arm FVP RevC model [2] and Intel Raptor Lake.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D58074a0fce66
> [2]: https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20P=
latforms
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> James Clark (3):
>       perf test: Refactor brstack test
>       perf test: Add syscall and address tests to brstack test
>       perf test: Extend branch stack sampling test for Arm64 BRBE
>
>  tools/perf/tests/builtin-test.c        |   1 +
>  tools/perf/tests/shell/test_brstack.sh | 106 +++++++++++++++++++++++++++=
+++---
>  tools/perf/tests/tests.h               |   1 +
>  tools/perf/tests/workloads/Build       |   2 +
>  tools/perf/tests/workloads/traploop.c  |  31 ++++++++++
>  5 files changed, 132 insertions(+), 9 deletions(-)
> ---
> base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
> change-id: 20250811-james-brbe-test-f5a20dffd734
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>

