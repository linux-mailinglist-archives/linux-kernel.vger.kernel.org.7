Return-Path: <linux-kernel+bounces-814921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71594B55A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FE37B54FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21C28469B;
	Fri, 12 Sep 2025 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oUtkmqhD"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E789220F24
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720292; cv=none; b=evNTeqhtgB85EYG6c9s1MSHUYBPvyIYeAGpjTaZ88AQ4ZY6939HJerxpdGqytNfm0lClF8XuvEWaYiPPxaRGKwQxzIJBNlzWeJqam5a3p3HlkBbCsaFL3SYQcRfpU3t0pOATqr3PlC3HtiMAU2wt4NKGzaDHEZdHvPr5OL6jjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720292; c=relaxed/simple;
	bh=I+IeUdWxiLjTU2csSrANPnlDmQ68oXdaxJe8wwbFp/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJlg+ua1AKLpBIR6eMd+P4LA8TYYIFpHSxTgqIZ3sDTDGdJxLCe9mbTUw9KQ+TNC6LJoGr932BWYd24zEhKxt05ybzIieG059my/qJ/uTTkWT/huCCcLZqnKTm8tGogypP75SGDEnwB5j048Br7KxjVM9TTHMz7CfxPnPrtEwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oUtkmqhD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24b2d018f92so37025ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757720290; x=1758325090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+IeUdWxiLjTU2csSrANPnlDmQ68oXdaxJe8wwbFp/U=;
        b=oUtkmqhDnzLh8ZEjitx0XX1WNxdndlBaUozAnfeQ8qcovk3Ibq+ZMRwm2tmL1I3G7M
         GwCjE2tDuAv5mmJqWEUBLfODsc3ldaHp7O6rNgYLMpVlS9hrYIXou/FpueyVJ0rkqjpC
         mBTMAOx91LyKEfcDM+dz+GWs+WM8EOE38Gat4DO3uKxn6t/TxLBwjStFqAx9/Yu1+0fV
         u4cGVjxQi5Nk53bsfXcZe1qPwd94eheeRiqkZhSkPeBBIjIAFJRGye/bBoJhwNALSmTx
         Pp+dWg9l065dlvfBJ94RxmTcJ1CM87C0X41wdwzWsbJLUnY5LhgcFE+q/xBjs8IQqhrY
         TE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757720290; x=1758325090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+IeUdWxiLjTU2csSrANPnlDmQ68oXdaxJe8wwbFp/U=;
        b=GDkHof05rH/IONmTj6ghnocyjIqWX/wzulHF2z6MA9aNANS9gevddERYQVN5sXs0Kq
         nmIJ7GVpvSEIBeRiz0uD2M6X3/4+w2pBh9SlxffyOk+KbQipfiuAbkx6cDf1looJzXcj
         wYtzAvD9R2oeGWbKMmYjmm8navoeG4RA/NYTRYa6cDAxC5fcZ0aAyvElPG6a6/0CTin5
         pY3x8vn/aDINR6SzgidqFXZ8HPCd6FfwmhzeXKTrW9uOayNKzxp8g7yQd8dq8rD/Nbor
         QJZyZ+i1Jv+3AxNkKFCk9fUnazHhDbo0N4qpHksPVB1qE/q7kls6XhKXxjWBCQ8Td1Oz
         CsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXobZ5nxlWrIFlODWcixdn4WvNfQ3G0e9JgV8skiFYO1Lmbxvar4UCp18WjmiAzJAJ3+xWlZYZ+prRzJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MDxllF6sDG6WDpHsdAOTevSQ/zX5arFVDH4zB00PpDN9+WJD
	ej2N01lzlTh+4wFDnnOIfuQClqhVgDyva7Bhd4So1SAqyHDBmzbU65cS9z5msyNtfio21KQ406T
	L29puG7/YIjYQvKTjdrcK78glN/O+80BZ4F6f1xVH
X-Gm-Gg: ASbGncsl1hGn0IACxvwTwlO3q7ozjC7X0aTzBfLcsyOO4qP4cQzTfqlg/AlyWYja0wh
	JC5EwPyiozxFJz6qNc+ufYzLffx3QNlAM4FeEyYWgyNhaFou0UfuWBf0IJIXUz9RvQexRss2kjg
	ER579syVrYh+bUjdTo+pLc9QcveC/7qeeH8N0wS9HmFD1roUoHDqTWNjFWrziDvvZkziZKjb+aJ
	bwroD7uTJ1Qp7QE0JqGLBiq4Q==
X-Google-Smtp-Source: AGHT+IFXZpKmsBxNh/q0fzirmyD/w1U2dM9umZvCp77k9wnf3KmFys6i1BPz4WTLGTUOjHzqhU7Z7y4G4ImJlUVDVQo=
X-Received: by 2002:a17:902:e548:b0:24c:7be9:85b9 with SMTP id
 d9443c01a7336-260e5f75787mr1104205ad.14.1757720290078; Fri, 12 Sep 2025
 16:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908221727.3635572-1-irogers@google.com> <aL9oL8aAMam676Ra@google.com>
 <aMSWbjo-qY7JYAoY@x1>
In-Reply-To: <aMSWbjo-qY7JYAoY@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 12 Sep 2025 16:37:59 -0700
X-Gm-Features: Ac12FXyLvWrzlQdYTNqU0M2z-GvSe0s21WQqEMk6u9-FCWExAloYLbzvnl48ack
Message-ID: <CAP-5=fWQUE4YxbAK4-qV44WFXYjo_EPy1XcVSrOYVP=rTspKnQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: AMD IBS swfilt skip kernel tests if
 paranoia is >1
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Collin Funk <collin.funk1@gmail.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 2:53=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Sep 08, 2025 at 04:35:11PM -0700, Namhyung Kim wrote:
> > Hi Ian,
> >
> > On Mon, Sep 08, 2025 at 03:17:27PM -0700, Ian Rogers wrote:
> > > If not root and the perf_event_paranoid is set >1 swfilt will fail to
> > > open the event failing the test. Add check to skip the test in that
> > > case.
> >
> > Thanks for the fix!
>
> I'm taking this as an Acked-by, ok?

I have a new version but I'm discovering quite a few other issues on
the way. There are 7 patches on top of this here:
https://github.com/googleprodkernel/linux-perf/commits/google_tools_master/
I'll send the new version now, but I'd been tardy as it wasn't clear I
was done with fixes yet.

Thanks,
Ian

