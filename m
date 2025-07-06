Return-Path: <linux-kernel+bounces-714480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C10AF6871
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 05:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B268A7B2E68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 03:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213021FF58;
	Thu,  3 Jul 2025 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jU/A2UP7"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE520E005
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511803; cv=none; b=Dnng6GX1Sz0O9NWFIDJcJiy62i0duj2ie2NlVr6fonSLqyZuHAMDOjEnGi5BHeC2+C5Gq/hmG3rYKShDmyrC33Jl5e8CCb5BS3ojEqSd97vzHLRU2OJrvCYvaMSPO2u0m94j/owtOkfOnwxGiGMao44cN121TNV1gdAbKXletd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511803; c=relaxed/simple;
	bh=siETa+2e1hOdMU82cx4KWvXM2JZUaIlZEqNGoM92INM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODEaX2fMcGLD0rlNAGYyITZZYWpkg+mxcFuM5lYjcZP5BMHnr8kjfJstGM5uIPa3lf0iFWTOL2QiL9+OfeQ6hKxjBebJqGuMLCK1Y2HCA57qfiqNhK15Zm/+U+9OnWLzfwYVjvdh+8SVkHidBpPHGnKWColW/jSjCRKwhUVyplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jU/A2UP7; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so118205ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751511801; x=1752116601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN6BFe6om2nPVx4QJftK5Q9oWduRYdtLEf6yX06DzrQ=;
        b=jU/A2UP73fegIvd8e5veGRm/tkhDYhKkn6uscl/EXNdSNL+VXJAq8y3WSACq6/PmDb
         WfKMfP+sKuWhE/a9BlPpmsNmrSn6EjYOfk6k8VpTpJv7uY59bbpfN42WQxoKypFUogf+
         3xKULgTANQ3OkHkNJGSqyl/EumewKXyCIljR1Atdli91JWVs8tq5hshO4YgEE+VL3RUC
         OjcOxlN1kG4nS0PMY/rLyX5wy6AZVrSrTd0C6Gb1P/A4+KxZ72gLDmsEcpI10EiVld3J
         ORY3N5PQmNP+dn7RnpSePCMTXUajDiP1iveRHcS1p6DdFC9svPgDVC2d8a65n9AUcCM0
         ggnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751511801; x=1752116601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN6BFe6om2nPVx4QJftK5Q9oWduRYdtLEf6yX06DzrQ=;
        b=LcS+CIZCgrtp0ryMjZQJYbVO1gw6FUFeiDCVgQamfJUg6XBpMZe5Z2JbXkF4jqYTz4
         bcFARKvTY32Hm4g9DpYqALPe0ROy6idIMXVIrQe29GzyDn2zPnPE81hLgmj65m/6bcn2
         AW67bxC39uv1QcmXgbLKq5d40pXyxClHQ5BNlq/KdUh3kEw+/KcYecsceE/d2rcfKP3D
         QbGeQ5k+Nvg5PdYCRRSQg3K3JOZhxlkEHewAdqujs3+XLY9OgSKqQblo8Nmdd6D6M4Nl
         r0o4q9ZiwWDvQ+S2KaIVEtc2seMIjgaGHoGWB1IrEAeo31Z8Gb/j2mGXp4LHZaxZ5tAn
         oD6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEI0+GITVdZs/vUcUgt5CFOoEdFHG4kyfQtbOey8xSdFUeUFePcxGxEiKb8QYGoQcUjExBC/WYrDJKIgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDR05KNXEgXVgcSykRzXzDCdIyO41X6gKFj7F0ZlEapYyFTarg
	Tl7eidsN6RojkwPs9rDA0Oe6NVPCGmKtDkiC2rbZ2caVDwdWBvpVmvo5CHKASLwt7RS7uNqpp8Y
	fFR2cJpA5OPKW0BrDNdMvvi9d54ihTjxQmJOcD0y1
X-Gm-Gg: ASbGncvosynGxYkvZsfBE8RZ4IAR6zob7QVaizAOsCURwgAginkGGgx/4qcQ3GQdh+y
	Rin1ttrr8INrH3WZFPlp53VDFU0p10HyJAFzxyJDsYx+PAqZz34WFVLaPysEHCdVDKCGJ6Xf2Us
	LS5DGdEODowJAPpLXhBAI38tfLPfXe6WRILMpBn/jdkFLc
X-Google-Smtp-Source: AGHT+IFLzfwbbAe9TXepqAxi+5+4w7o4DGYkqu1IIC17NV3P1HcrgHSuWhS9kEzFIeDPvBnQn6Ua8ovkxxpAU5q+i7M=
X-Received: by 2002:a05:6e02:339e:b0:3dd:a7a1:9ee8 with SMTP id
 e9e14a558f8ab-3e05c82b91dmr2179905ab.24.1751511800459; Wed, 02 Jul 2025
 20:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624190326.2038704-1-irogers@google.com> <aGXo7Hp31qZOTx9S@google.com>
In-Reply-To: <aGXo7Hp31qZOTx9S@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Jul 2025 20:03:08 -0700
X-Gm-Features: Ac12FXyS3_6QZzQsAPBLsuDlhh9SuoLA_S6ft4g5FSEjzHuElk55okBYTQ77q6Y
Message-ID: <CAP-5=fV4mSjxJBSScYu1XFqFMMT0vO+jJDwq57kUB+cEkxQqMQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] perf test: Sanity check file descriptors are
 cleaned up
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 7:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Jun 24, 2025 at 12:03:20PM -0700, Ian Rogers wrote:
> > Some recent patches showed we were leaking file descriptors:
> > https://lore.kernel.org/lkml/20250617223356.2752099-2-irogers@google.co=
m/
> >
> > When a test is forked the file descriptors >3 can be closed and then
> > any file descriptors >3 left after the test are leaks. Add this
> > checking to the forked test code. Prior to that clean up some file
> > descriptor usage so we can assert that only file descriptors are
> > cleaned up. Sometimes the file descriptor being held open is the
> > result of a memory leak, so fix those.
>
> Interesting, I can see a few more tests are failing with this.  But we
> can figure it out later.

That's cool. I was a little disappointed that just the dso kcore leak
was found by this. I was also surprised that the dso kcore memory leak
hadn't shown up with leak sanitizer and reference count checking. Let
me know if there is anything more I need to do to the patch series.

Thanks,
Ian

