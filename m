Return-Path: <linux-kernel+bounces-664452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 665ECAC5BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 22:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A22A1BA5BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 20:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA8C20C029;
	Tue, 27 May 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xFYJ5V8D"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3911207A27
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379232; cv=none; b=NFnjwja9fgi99pZAKbhA+2PXzNiDZFsqnxgT2Wbrk9O5FuXrKDJUrB1gEwngJ4fV1gJFCgb9gZnM/ZSZ/e6PsrOtInqV0sWMWPDwOH/yvDIZV/5K6QDCt9h9JpgHT63hFuTsqF1CtZUEmie4IhLlPTT1LLdtzyP0znBCmNQIovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379232; c=relaxed/simple;
	bh=JaBoPuh2liKuEzkZUaMd4QOoDMraI9AIn2xSl35QZug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1iHpWFc8uNAaACLpO+DHs2sG9udlD+BB0vCJn0K0RIp/2DI53Gdl/1htqJQ8X7l3i3di735lA2f/mcn81ZL4+5kZ2jKHQ8dZKNc42ufAnuUppmKJSp3YQ5lcTaLFygg15yUCDsdIY71kx4kUlktIPuitgOUdDDZXe7Jck4pmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xFYJ5V8D; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3dd745f8839so42265ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748379230; x=1748984030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/Egbckowtg4mbFDRc5WWolxnK85TNH/cSEuse5tMFA=;
        b=xFYJ5V8DCthIwEX0goXf/X7clM8/PfUG/mG0GKJUsVDic3upZLfkn5/R5iEQ2/Kiv2
         +qO2wKOYTS5Mtk0GNPaLDBTcJpefE0BwntmfCyeptISA0Pe1+/E+0fXpjEu6c7eOvyb9
         nQ77UGOF84m7YjmJlY28D3jtHCs8hgj1o1ljx3XPsPqSnhazA+OyaS7q4BzDIAEw9B2o
         wheOuqFAtuQUzF0WV8EMx7CrkoIniulyKZMZQBchdBiyhJCQDeo4jEGvEvY2YiaRwius
         KTKdjFIKFQIALrZVGhGnI9+gBegq+EHPTZOsOmD4bJNWz++u8yWQcNGRIf6fDOLhiAMD
         Cfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748379230; x=1748984030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/Egbckowtg4mbFDRc5WWolxnK85TNH/cSEuse5tMFA=;
        b=jdqWlb+GBzFnd1DEgeCW7052I/LhFOjtgabZp1aYOS3Gh8ujXUB6PQc8w+J87nzjoC
         H1tWnuCVN/fDqoUq1DnMXjgbnL5ds/0AIxmhePgjg5WrXFEiiQO2/s6rMOg/B6+LNw3h
         amQM1dANmn3auPl5m2dpV80tyQ3k2QLynYlubQNsvnBookedT7Vi1fTdTNZOmltlDWPi
         F9fS0RLJOEp2EolJ8ZzHfNnNj4PxpU6whhVAjCZZ5enKyT0t3WN5EhckKvpyJPIV5l4v
         UcHpe7eqgzPp9T6c9RyWWOaGH8awDG4pY6BRAjq2vs7V7lV9INY2CrNZSOkLp3WJaVkd
         JXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3VBr/syu12dDypSOabMuc/9p7XBY+efMujznsWf/xPkxZ0aOT9q1D0W/kYh9NmhIGOOvGhVflOdzZDSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxqpCWLw2nWUHCraiowKfnZh3gmJKOFUpd0ZnYbabP51TtQVc
	LSbLAIT6CdVEjadRGcMtvUkW69gQy4c2cJ+Ne+0YcMv6z4jXE2RgNAD6d1TRADp46ARLsgufsZK
	6DJmTVEYApbGamlCsghNeilzKvWJnNHugLhg8YLXQ
X-Gm-Gg: ASbGnctDlmRpmAZEivZ0InK2QewE6UlaryGeZhNtONN5BaCS9BMVvZLQ0bnX8NO/bme
	DzZF7xWRFLmxaCGc/L51LLwOb0e/K5UGWir6lfQgIHG0YSKDqF7nAFDKUAmL7Ap/VTMHG9dOUK8
	BDhhr/z4S5UZr+k80IHv//UqG9DxLEQq4SVDRJtIZ3veqcl5is4Qw2rvUtftgP6y07yxaYRCyh
X-Google-Smtp-Source: AGHT+IESjRqa86xXrwB+JfdoCQTKoc8siZWxd5KbuYCWZODADNacqM+YyPkxeS1QKg4kEDphf++qtuTPxynb4aPotNM=
X-Received: by 2002:a05:6e02:3c83:b0:3d9:6cb3:d6d2 with SMTP id
 e9e14a558f8ab-3dd88f513d8mr1055455ab.4.1748379229766; Tue, 27 May 2025
 13:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410202647.1899125-1-irogers@google.com> <Z_mK9BVv16MT7shL@z2>
 <CAP-5=fWykL-01S=35zz-6JASbM_cQkx6PHdKS7pJAX0=JBTuNQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWykL-01S=35zz-6JASbM_cQkx6PHdKS7pJAX0=JBTuNQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 13:53:37 -0700
X-Gm-Features: AX0GCFvRnFp7k6lOspw7S4fvZcaUmElbp5d1cVmzFvqBlHbjQ_Qi2gmEKTa9M94
Message-ID: <CAP-5=fWFYS7-FcbyJ5Z5U2rqA7eYwwJ4dMf90TUzwJ0Shh2yxA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf build: Fix build for clang's -Wunreachable-code
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 3:14=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Apr 11, 2025 at 2:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hi Ian,
> >
> > On Thu, Apr 10, 2025 at 01:26:47PM -0700, Ian Rogers wrote:
> > > Clang's unreachable code warning is able to catch bugs like the famou=
s
> > > "goto fail" which gcc's unreachable code warning fails to warn about
> > > (it will complain about misleading indent). The changes here are
> > > sufficient to get perf building with clang with -Wunreachable code,
> > > but they don't really fix any bugs. Posting as an RFC to see if anyon=
e
> > > things this is worth pursuing.
> >
> > I'm not sure if it's useful and don't see what kind of bugs it can
> > address.  The proposed changes don't look like an improvement.
>
> The goto fail case was in OpenSSL the code from a bad merge:
> ```
> if (...)
>   goto fail;
>   goto fail;
> ```
> Meaning the fail path was always taken and checking on the non-fail
> code never executed. Newer GCCs will warn of this because of the
> "misleading indent" but  clang won't. It is easy to imagine similar
> mistakes creeping in, so using compiler warnings to avoid the bug
> could be useful.

Ping. Thanks,
Ian

