Return-Path: <linux-kernel+bounces-884101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A9C2F5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 302AF4E4DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455D2C027D;
	Tue,  4 Nov 2025 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jG7xhEhR"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83EB1A295
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762233736; cv=none; b=p3l4I1WDmkEbJ+1qBazkduq6YyL/f4aL+CgQ09DIvloxQQ1vMp8FKVT92kb5b/a3/+I/RaUYdj+GqcoBkNvruTK84I7D3nBlp7QsS74Wx58wKSHHLpDWluF2fcVCJwUSQbGDqppXXcROS8Qgb59hx6kWda/jDX0mQIA+aHKpUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762233736; c=relaxed/simple;
	bh=EQtEfaT8jWOsm7wKZ5f5ZTU1pGn7YcMN4yN1uRAnYDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsfsDksgiC4BsPEaocJxEb3X4+o0KYTLfZI+q1SQsKpOuvZHsZCdPXreVs1JcQSsmzJzt9XV7dXGoV/L6KGg0CYPLupcy5PulpOwCC6HagRgTx++BvqLMpLZK/0DBpGfo3Ld/Q5wsdS3g2GZcppQIQUobXTpBJaewT8cx2Pp97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jG7xhEhR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d67abd215so131075ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 21:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762233732; x=1762838532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iWuZp/u/mfWjJb+qRvHHS+nP6g5jcfye1Xv3bDfsrk=;
        b=jG7xhEhR2+mAwIk6InxPVa25XjeB5Ova0F/RsOP+yHlZuqPPqpsAER9N/MPyeL89ls
         +4KxOIBt0KBl7ySfPlMQf0LePKFkoClI/eFzIM/DtwIEBjA171OZAAeWgDCzzNsyS7pm
         vS7UOB3S8TxsnauTO12+aoSVF50d+r4sUSkxH3KbsRHeg9qIGhFhG/ETFjV3Gbe3gc5c
         2s6XI6xeNxORYWpGaTQPLhHZMdmTbtRQqt0d/eonHl1RxoOqPgLWrW4Mzu1kfkfObfQX
         DNEh0zIES3M+hzvS0atLtws3qlMnhF28dJFXSzMIzkixTm+cd+RcUzDmyIoV68CFbuFT
         5tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762233732; x=1762838532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iWuZp/u/mfWjJb+qRvHHS+nP6g5jcfye1Xv3bDfsrk=;
        b=CNSWOccuoU7/tYqU9m+EvncZiA6pMbFspPO2/RA/IeHUWPpIfym5XucGJ6sHpzTCkL
         n30wnpoBjwFll7FB80d9YZRz3e+uuDJ3sid+MnPDt/sGkRm2vOuDI9K7SRPI9AkJblBz
         RGIvqCLCXFjr4fhVQCO4fjceLTfKx/SO2SXycc2DXhzT77XyhIXjTO0mqrqDq0Pdsjaa
         ZUkX+V9x8Hw06G63rbjLSqSPf8YT3O35jCfX3DkECS1yxToVXAR53/SkUTN8bZ0tIOE7
         +iv1L+ZxsuM1/cFCby/udr+ZEdcQnPyEekg3OBcUysgKjfCYAT+e0TsS62lZCphbmICv
         S97g==
X-Forwarded-Encrypted: i=1; AJvYcCUag2QHDMKR6Rg4VqUHCxT7y/TjUxsZ5zqaNOZOnG0wpgIUhfynV2D8Z3SxS8Lv+/6rCMZvDPSkMW+xmbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwplXGUVJk9aiMtbXtUUzOE2o8+umYqXHQpBTcIV4Sy23+2UmWC
	/ue2Ab0TZdbU750fkpuAsjn8Mt84/pYXAbj2H7UnRsK2PwLvaq2R3ltoR/RzuPwG8vcXoTzR9Hp
	2ettLyio9PkovYiwdAVvm0LUIBslge4gbYrbn94dS
X-Gm-Gg: ASbGncvXhqU3iSp7NNAWEpT0IRS43tAasZK9tsg02NzMkuRTm6mqu/ZaAmweQB5W4OI
	jIGcPmMDdtaQpfPvurW5EE+De+pzeKagglArXKGzsleOZwooiFLeGDWMeA1rTK/c8BmRfr+aSpL
	CF+rg4ag8bsE4N5kQHV1plxwPVO3qQEYbtCMqGSCdJOFaN/ZiXBwt2PrR2+/RqNllegLYyRWBkL
	Hv6RjQ6LVEvvGcTGxqXLub5fRd3rs+TMm/K9nLwRqHamchC7U6JPy+WGdCM0vFNxnV8iwZU0gbd
	9xlbug==
X-Google-Smtp-Source: AGHT+IHoO5B2Si9Uvj0pP5tXFzvTxPU2wofFdFmzQUxanzus5YC7y31dOXnSLrjqetrJGZPvwaPQwJ7jeWIjxbhbbx8=
X-Received: by 2002:a17:902:dac3:b0:295:1351:f63e with SMTP id
 d9443c01a7336-295fd8dc5femr3809625ad.10.1762233731612; Mon, 03 Nov 2025
 21:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029222638.816100-1-irogers@google.com> <20251029222638.816100-2-irogers@google.com>
 <aQl06yRnXvdBEkJ4@google.com>
In-Reply-To: <aQl06yRnXvdBEkJ4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Nov 2025 21:22:00 -0800
X-Gm-Features: AWmQ_bmHLbtCHrzs1FpF4_OhpunwaomuhfoSJpPqL5oNe8-GhWH_bbT0vKCZFPY
Message-ID: <CAP-5=fWtixi8ykDp_BO1nz_yj_1wZfUUWrCVb+6WbVE7vON6Eg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test: Add test that command line period
 overrides sysfs/json values
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 7:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Oct 29, 2025 at 03:26:38PM -0700, Ian Rogers wrote:
> > The behavior of weak terms is subtle, add a test that they aren't
> > accidentally broken.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/record_weak_term.sh | 25 ++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/record_weak_term.sh
> >
> > diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/te=
sts/shell/record_weak_term.sh
> > new file mode 100755
> > index 000000000000..7b747b383796
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/record_weak_term.sh
> > @@ -0,0 +1,25 @@
> > +#!/bin/bash
> > +# record weak terms
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Test that command line options override weak terms from sysfs or inb=
uilt json.
> > +set -e
> > +
> > +shelldir=3D$(dirname "$0")
> > +# shellcheck source=3Dlib/setup_python.sh
> > +. "${shelldir}"/lib/setup_python.sh
> > +
> > +
> > +event=3D$(perf list --json | $PYTHON -c "import json,sys; next((print(=
e['EventName']) for e in json.load(sys.stdin) if e.get('Encoding') and 'per=
iod=3D' in e.get('Encoding')))")
>
> This line is too long

Is there a good way to split such a line?

> and needs some explanation like what's like the original text and what it=
 does.

I thought that was covered in the "if" below:

> > +if [[ "$?" !=3D "0" ]]
> > +then
> > +  echo "No sysfs/json events with inbuilt period."
> > +  exit 2
> > +fi

Thanks,
Ian

> > +
> > +if ! perf record -c 1000 -vv -e "$event" -o /dev/null true 2>&1 | \
> > +  grep -q -F '{ sample_period, sample_freq }   1000'
> > +then
> > +  echo "Unexpected verbose output and sample period"
> > +  exit 1
> > +fi
> > +exit 0
> > --
> > 2.51.1.851.g4ebd6896fd-goog
> >

