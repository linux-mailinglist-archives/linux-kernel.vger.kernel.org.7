Return-Path: <linux-kernel+bounces-899927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69508C59323
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8150B4261FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF66B364020;
	Thu, 13 Nov 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGSoGuvz"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB00D363C41
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053074; cv=none; b=Qb9GP00TrvAF7eYTYAceJzC7O2MU/0teqIBQyO4hkamzy8FsVgmTcbBS2IcueuT42Wreyopcd/UK/Ka25SjSPbqgxxdkOiSG+okea2fbQX1y211HUc2dNlNEa8u/WbpvrvytEjX28tdY4hvaKMUaMcnnuK7lCW71+D20kKrEW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053074; c=relaxed/simple;
	bh=jhroVY/HWo/R4pzbpVqafKrGYgd85FkipZ8zyk+lGCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/3un1n/W82OeA8KZaN7wqM4DcqBm63GD66RIqJwfC6nC9Berm+ssm4qLUJDMepoK4vkHHkEqW1ypRHuD4DoMyubCQw59J3eqOG7rvOu/vuqriY5vtYvlY6Atfw/1bp+hxG7bxu+8W6VqRB13fh/DliKKERIMV+/CbT5jwmUBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGSoGuvz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295c64cb951so240335ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763053072; x=1763657872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLxkFc80eg4XlOBCdafQkFgvYgVVVTnJl4OY+3IwY9I=;
        b=SGSoGuvzW5zrTMTrEI7n9r6bgiOz9dGiJALl/9H4gmrwhfqe1uLGD3H+GSq7MQx5km
         JCREYWbHR0g0hojNvRhChAeu9F2iXhka2k0MoGkNaIdQHfnAC4b47p7RujbY3GkgNSqs
         nfbQWvp8ZPq/6Ce7+4Pxz07L9jUhdnFYyeceRNamHg22/gS0hvyUWC5i7EFFW8rM+MDT
         qP78oRH8yea98kXQttD410atjOrzheEzS5H20a1KY6vHzaLtZQtxPQ5ukQavf+v5JO9e
         RyRm8G44qVSOSIVsbT5YEYQ4yTAvU3Lljl6iXhvzjLuBckFozWQI4jKrmvx2JGnlPo/o
         mCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053072; x=1763657872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLxkFc80eg4XlOBCdafQkFgvYgVVVTnJl4OY+3IwY9I=;
        b=kFlChFD+O1mfghadwlJg++/s36jkj6iQd66Q3pX5IFBq9qbXKc1pQj+HhRGiRDH+Bw
         3yGJkqaohWyvTGkMTGCYl101iKrBKFRAEs3Scz47vfEFa1GBxhT8g17cx+rImM5tzKP6
         oetHQFIRzoCQWpzPOC/AP8R2l0IE9yQ9g572rl2eCZ8j6e0T/M6iFifYO9fHixlYTAp6
         1FbJCMvB0SipI3inroOGWrOuswbyNIp6HdhJ7tInULfb6jzp9ERaPPeQwp/gXMQ5l0U9
         p3bcj/ahPas0WRQV89fh1DOFT9eSU4VpbyGoaA5JXxw6dseqSgzs76C/F1g7kIsjn/n+
         JsMg==
X-Forwarded-Encrypted: i=1; AJvYcCVNdyTefq5GKLOp9HGMDasvdVYTkB4tvXXd3qJB97bmQF+hczfRNJVI/eIzT6+4f95Axi3+a5O0xA8Btrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrV+o5NqfLjhh29u+lRd9OKKtPtunG+d1/YBkMiVGMv6EarBiF
	0noSWRt0xFtbCetoGhKm+vjlpfJ09ZzMuQdBClThAvReobkp24t0L8hmDkMrPmzke5yudIyl8GU
	f1CBxA5klUuuu1zu0EXn4SEaMnESjYLI7NSaNFmIcxtLlYU0rZ4BAWeMD
X-Gm-Gg: ASbGncsfVjhhXv5DTN/nt4xNTc0qcX4JW+k6EKTWiY2DZ8VOLcBiuAfV1LZcYzEfftk
	iaSJIawcr2lbAUhOFsvW+ETR+NE8GYl6EomvjL/4iKojRf0aZSjt21LEyfltfbAZMZ8ZdHnNgfy
	O26gMKVrQ9VIaLKDq1BTutAAJjOGCyfDDwbxdaIxiXPCbDAa/ADAxBu8dRS/m9r7qxN9WZzbfN7
	5xiEw/dHObb1UA2f09b/n8KoFncoIkTnJxE9+L5XF9BKP8jx7BGaCbsirdLR236s/uBwDiDnjAE
	VJZBxsSKnToPu/FcPZ41Aaj03g==
X-Google-Smtp-Source: AGHT+IFGM2UC9cv0Rb69qLMLBN2AHbSi8XjPf1Y8jV3cTVxKSlzeyDyFNonfq8lFV0Khqb3WDzq3f3llEYINITYq5HM=
X-Received: by 2002:a17:902:cec4:b0:290:cd63:e922 with SMTP id
 d9443c01a7336-2985c444baamr4595265ad.15.1763053071802; Thu, 13 Nov 2025
 08:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113160124.2695-1-ravi.bangoria@amd.com>
In-Reply-To: <20251113160124.2695-1-ravi.bangoria@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Nov 2025 08:57:40 -0800
X-Gm-Features: AWmQ_bnYR4cOVJLHr78WOaem9eSbY6OuN58PYrF1LrkuBmsPOHOG067Ywkfi0go
Message-ID: <CAP-5=fVNZW5EvpX+MCQOU1WJ0BeyDudk+nMp8-cAH6CfF9cE+g@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf lock contention: Assorted fixes
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Tycho Andersen <tycho@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:03=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> o Patch 1 resolves a segmentation fault in both "perf lock report"
>   and "perf lock contention".
> o Patch 2 repairs the perf-lock unit test.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> Ravi Bangoria (2):
>   perf lock: Fix segfault due to missing kernel map
>   perf test: Fix lock contention test
>
>  tools/perf/builtin-lock.c                 |  2 ++
>  tools/perf/tests/shell/lock_contention.sh | 14 +++++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> --
> 2.51.0
>

