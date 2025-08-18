Return-Path: <linux-kernel+bounces-774413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B295AB2B1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFCD18845E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B0E1F4C84;
	Mon, 18 Aug 2025 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+One8Ag"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774D2741CB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546876; cv=none; b=gLvSMMjnwXgeimPHo/+akzLXw6CC06d43jFZsra3uQ0VB4ESNAdLgCtzAJkX1r7yOVojKJu/brlCXOJTPlN/CVCA0In/yi/ENdwFV3jejRWRTFn5c34nNkJ1bOIZH1GKEiPbOWEM0SyAm5VF36VlygW/6poczFzrWChPFza/p7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546876; c=relaxed/simple;
	bh=6Us6Mk7U8lUxlYJwLwrAqk8HYmG3DXp6p3hJvhkWkU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJgspnnkO67k6rzQpb2jvgZX+eSOGXa9KVA9LQwrEYK12Rizi+eqO6IzdD8oFaBPN2SJZOiEEKQPiYRNN1OBRLehs3qqhdQiK1JtMrS3kh8kfzpw8gpk9QU7yxNui6y3LO+m71oJwH/MekdB72clViQ4c42HCSQ+BM4v91dnoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+One8Ag; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-242d1e9c6b4so53425ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755546874; x=1756151674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Us6Mk7U8lUxlYJwLwrAqk8HYmG3DXp6p3hJvhkWkU8=;
        b=N+One8Agx3viSq3c+Rh1yqmuOMDknTzFYKTmFk8nENT34u0qi3JwmUB2sfMU7dcIJa
         sUDJ3A1RnePYUdtHDRE4pRp9gon2Xga89v2xxc3huH6DK0lXD5nkRJGgqZ3neJ5iVhj6
         kUbDypcOW49XCmDX/GqcvejiS3kJLfo/K7R2z3iA8GyPELtDC/j3jjP2+1JX+KkaerCw
         mC7PQXQ616KiYPqFi0zTryVdnrnrv5j5zj5yWS+QX1wA4vDfT/ZFh4fCOaBMfqjT42S6
         hJUrBR29wjeNKsdKrkgCJhiizyEl0LMwtPArbEQs1Bu9PeN5jnyNdKMGFvnTvv1WyHNc
         ES8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755546874; x=1756151674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Us6Mk7U8lUxlYJwLwrAqk8HYmG3DXp6p3hJvhkWkU8=;
        b=XRDdJo/a0XUBJbJEDN7LoSoFl1nQE4Mw9R96mq5OgeB0EdPgiijcprb49f9uHrKVd6
         DA1zp1sXDIxiynM3WFiKq8F6YbdvYFmDo0BVoDnvIukzyQ2l3fnN1Qx5zZ8NytJ5SDGE
         K+d/UQkFK88EKG7TzmsKbQXagSwr0K+92Xuil3wnkH4LbZ519+/hdgBes3PwQ8S1t8ru
         Wsg/yu0qQGnAYNC/az9bEY91MByA1UJ9zS8kNELSCmbIwlyqxfxdULwEfcTMUR6eo7Mu
         SJBbVDickoDd5xjT3PeDNsFndjbpNFlLS5EYW0FvyYG+SK/rulZ2ZskplJVsQk7hG9hy
         mMTA==
X-Forwarded-Encrypted: i=1; AJvYcCWREbewEN+yWfbGyO7t/nCebR6OI4GTM5hklcMb72hnjV02mz5pFNKdZ+sK4ZLKzt35dHxxkQxoZPBy+DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcScQilrV4NL67J7aMhHG2nOpVRXxEFPUIU3jjKrnallGQt+mk
	LMD/hYlA97PNhnoB+Cb4l0kPdl2/xAa7nFCiYWRu0SNer5Zu/DVkyp3QRu/UIK5Rzte0/DaMe1v
	tyIpELBvEDjZwb7j0VnwvqWWY0rnAjamdgobJWaIz
X-Gm-Gg: ASbGncvBsIa5hor822Ms4/ZVbmZ64ifzdDKxEorNPzE43FLV7b2W2t0SpLSAeXIXsc0
	9FDQGBwl+zvcnXHeYf/ioT1kcXinSi2GR8f8HQFhpkREvm4+vGlZK4EXU9wszFq0HP2b1cE9df3
	R3+aDQIoXL4+r4GtdWs3uwFxJo5O8H0FzIT0DDk4sZHH94wt3fFPstybJmEE/ctb4uXPlXys2F6
	zG35IAjddOK60UWSAM6RSoedMIkWOxETtHWZCeEsNM=
X-Google-Smtp-Source: AGHT+IFuy2ueueA60iAACaiLvkHJOf9fo01NfQC1Be/3M/GCiEVFkWElihAlyBuh3i6jDNohU+RejPdzZkCse0Gmee4=
X-Received: by 2002:a17:902:c408:b0:240:127:85ed with SMTP id
 d9443c01a7336-245bd9cb684mr7555ad.4.1755546874225; Mon, 18 Aug 2025 12:54:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805063209.3678359-1-linmq006@gmail.com> <aJ-aDh8RG4CXcnI4@google.com>
In-Reply-To: <aJ-aDh8RG4CXcnI4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 12:54:23 -0700
X-Gm-Features: Ac12FXzxR3h5HmBo_HOoyJRmDDOm9y1ebSZ80B8L0A3D_sEGoPVbbOddIXELL-U
Message-ID: <CAP-5=fWgaj_UZ6H_VbEzPyr-dLnbgdFVPOO5FuoZA+18jVHKkg@mail.gmail.com>
Subject: Re: [PATCH] perf: pmu: Fix IS_ERR() vs NULL check bug in perf_pmu__init
To: Namhyung Kim <namhyung@kernel.org>
Cc: Miaoqian Lin <linmq006@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:35=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Tue, Aug 05, 2025 at 10:32:07AM +0400, Miaoqian Lin wrote:
> > Replace NULL check with IS_ERR() check after calling
> > hashmap__new() since this function return error pointers (ERR_PTR).
> > Using NULL check could lead to invalid pointer dereference.
> >
> > Fixes: 754baf426e09 ("perf pmu: Change aliases from list to hashmap")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

