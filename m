Return-Path: <linux-kernel+bounces-838121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9ABAE7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F961925275
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB6028934D;
	Tue, 30 Sep 2025 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jb18FxTH"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1628643E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262589; cv=none; b=N0mVY9modJGQPk1ezpV9BbglWqTpJRgeVQsYRpswXavTPE8SZ3NGY7VrIcgdoQVghOpa5jjZERpYWv/7sGzWnUo7dgLTxbbuU0vGjlQLJuvLUfdHkwxgWZfsQ03nQcpumIHfCF7VMM40YEIV2VadLaXfk4PridDMqMPEGbP6A98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262589; c=relaxed/simple;
	bh=Z9NHbEqAoo94vhfduf5skwK10qz90lPKQlXG0FCrBLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ex+sng1GETBcwuFVD0/QBuWKE0414qVMluI6+hsWNBb/WqtwmNT9ZITsdBmaXj0GhykVKUufiXHpdGLksld5e3SkO8abB1wV/Gw5XGQqAljwmpQjUq1hQ9llnuqIe8w5vQ2EnqvNxPTNWigo9/kR34RIbgmeeLEvPfo4+Mf8/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jb18FxTH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d67abd215so52565ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759262587; x=1759867387; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0cT1RAs6oKsEjGjLNXsHeYyU8Or78p3qoc3PSshpCM=;
        b=Jb18FxTHLaYpEN1s7P5WAfEO5aH53W0v31Dt4ty5vYscZpWNtk8DSIEsnyCX9nJOUG
         z9iZ4wO34buTmCgq7nxNvzLXS0PoZS9h48xWcLqa4MetqK3YUzVc54GK60m3NxJop5T7
         VH4o1vxrho5NreqoJya/4NKfZZIG6LP8i4bJT+2dvcZIAlH/cQ97fqenLy2GvMyUx74x
         6QoKaoZRtnOzvAsoEXDuH90GLg5L4u7EcZv4b9CxvGW1KIv345WhYdX4QOyjCIq2hOqu
         kYgLEf+a8AkE5e8YOC54QpKqTKb9OpXK0MEB215aMixBxuGi1uw7baQBTz/31ujoxurY
         SCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262587; x=1759867387;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0cT1RAs6oKsEjGjLNXsHeYyU8Or78p3qoc3PSshpCM=;
        b=RB1N/2SQYUmqxbAbYc0iS7WCj4tT7znE72f185HpF2RKkksPKinfFEbS3YLl63Nqzx
         IfsRUXf6f2GQQxA9WtyFifUTQm91t37iAG33HV1QPcKS1ABlvZ1+WS14QYyXbxjpU9DR
         AxX7lSDwrt5nz66w4Dgw5wj9t4nIUR8TqrAX/8xyUa7tQdRGUaEW2uPVQMnYBu052Tiv
         JlkZzoU0K51R1zCRp6wLUQ0nuTx0bnfCfhXNBXjPcZ4mKE6EYKz7HRKsSnzwxcJH/vnY
         067QcX3TZiATaUYaQ5zCsAfGknUmKF0ryq/YoNE+e7QI1eIHv6rSQfHxruJyPJ64xIMr
         v9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV1W3jeFMmmUw65zW9edEf/5zL+OoytS1xq26uDNFpdV3yKyaosm1qYl6Ja+7QmwKvqzKlChLR6XzhiLL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztP8TanD768HXhEWbANrCnRBmkNo5kdvefLGLOuHbz3iHs7k3i
	KX/lvrBz9cO1vdf1VejjAjoZ4Up+0rgnpZifepAYobhkWNqmJKBA7MHtokR7o8d4/NbwJk0eglv
	53SVuD9/qXRZyKFsB4HqQDad3JN5oRpYo8NoWBixj
X-Gm-Gg: ASbGncuX4mdWQngMtMafHTWqCYG/hQuCtg7scQBUabs07xmqlognWBOjixm9b27gyoK
	d5WcvU3U7fx9XsPcTviS6U26H/0C0YUvOJr0Yzf3dHvfRloURyJI/fX7YqP+VylpbkzS5MH1Yh7
	fAOpX/+OACJxyD0ulv8ZQkizow+5MNcpm1cXrj9Ftn9Q4Sag+tOmsSz/34BtNKot+J2YlJDkM9p
	wZfmd7DE4j1wGUSbxRlEQZ0A+VW8+BXpQfnCPjG9hwrh5yN9yArDroFJwbqgJb2xxpR
X-Google-Smtp-Source: AGHT+IFa4zuETd9i+m/UdKS6kqS6S1OjhAGhOjt5CRjx+tasF9kSrsO82VkEwg6Zmh0mEdptxRvU9NQQwtYqO3qzab0=
X-Received: by 2002:a17:903:4b0c:b0:248:7b22:dfb4 with SMTP id
 d9443c01a7336-28e80054ba7mr983905ad.16.1759262587055; Tue, 30 Sep 2025
 13:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903184248.695267-1-irogers@google.com>
In-Reply-To: <20250903184248.695267-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 13:02:55 -0700
X-Gm-Features: AS18NWB7QPcjHfrAVgePWCrCMWuylVtQSOkipi84bsIK402pvy6HcqR_3pBSwRE
Message-ID: <CAP-5=fV-3d1EzYfZq6s9M2NrLFFVOrWOTx_k5tByScA4Sfqq-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf test: Add an 'import perf' test shell script
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:42=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> The 'import perf' test needs to set up a path to the python module as
> well as to know the python command to invoke. These are hard coded at
> build time to be build a directory and the python used in the build,
> which is less than desirable. Avoid the hard coded values by reusing
> the existing shell script python setup and determine a potential built
> python module via the path of the perf executable.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/python-use.sh | 36 ++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100755 tools/perf/tests/shell/python-use.sh
>
> diff --git a/tools/perf/tests/shell/python-use.sh b/tools/perf/tests/shel=
l/python-use.sh
> new file mode 100755
> index 000000000000..fd2ee5390060
> --- /dev/null
> +++ b/tools/perf/tests/shell/python-use.sh
> @@ -0,0 +1,36 @@
> +#!/bin/bash
> +# 'import perf' in python
> +# SPDX-License-Identifier: GPL-2.0
> +# Just test if we can load the python binding.
> +set -e
> +
> +shelldir=3D$(dirname "$0")
> +# shellcheck source=3Dlib/setup_python.sh
> +. "${shelldir}"/lib/setup_python.sh
> +
> +MODULE_DIR=3D$(dirname "$(which perf)")/python
> +
> +if [ -d "$MODULE_DIR" ]
> +then
> +    CMD=3D$(cat <<EOF
> +import sys
> +sys.path.insert(0, '$MODULE_DIR')
> +import perf
> +print('success!')
> +EOF
> +    )
> +else
> +    CMD=3D$(cat <<EOF
> +import perf
> +print('success!')
> +EOF
> +    )
> +fi
> +
> +echo -e "Testing 'import perf' with:\n$CMD"
> +
> +if ! echo "$CMD" | $PYTHON | grep -q "success!"
> +then
> +  exit 1
> +fi
> +exit 0
> --
> 2.51.0.338.gd7d06c2dae-goog
>

