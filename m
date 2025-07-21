Return-Path: <linux-kernel+bounces-739365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D1BB0C564
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D3E1AA0595
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E606F43AB7;
	Mon, 21 Jul 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrRB0sKc"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB312576
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105275; cv=none; b=h96SrjGSi88Eh91qio+CJsreA6WeaV0hYtCkO5c1kt/T8e/sIdfiPpkNLKRAunTpq+s5KCb40jJJjNO6zT70PVg/CWTA6i8D3+6a8rhd3DcaFas1QnU8i63Ddvg2COJ1Z/xOAmj5ZxOxRM8Yzpnfylih4fpesNxQ/14pca634/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105275; c=relaxed/simple;
	bh=X/CMxu+Wcc1BLZ6yTXXEuwdplxLvqklxHi3I0HvZ1sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifM5YhghJ0ESVQ9T7nOORsUmH3F76dWjD8YKCtkEzlbOVLPscVamJH6U8iRsoAxVrusoD/b2MfAsecJ9Q8qhxfJVQjFJXc/fKiVWcGTPvrt9iB2EJ74eSRSVJeUon6Z1ud6qreQ24kW+t1Y+dyJk39741uAHk/Kvg9+H0hl2C/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrRB0sKc; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so290985ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753105273; x=1753710073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/CMxu+Wcc1BLZ6yTXXEuwdplxLvqklxHi3I0HvZ1sc=;
        b=wrRB0sKcLt8ItuXNGEuBC4QUphJS4jnezVcosHeEGddWYOgiFYpJ6KawlZ8YT70xWU
         CPViz5NSK3ZBtupsi8FvTw9+TqsxEOkls0KKzxrFYBVvvj03gl+DJRO6rKinT+qlJ8+n
         3V3IAkqRrlZbQJal1I/+4tNxGoDL0MCS3EMHScMABix0MawjkzBaTwz5NqvruGC04ZEc
         QFA/Uf6GmYWuiZQIEd+6Kr6Cci7R50DKiZmtgV85zXjFoAqMVKcunXIj/R9UIbMziFQ9
         9KK3Rw3aOz0oVen8pwOb6A4IWp/3MtZD1rJldRhnrAS5RRW/EZxVH1+EhZiX8W8mkpps
         56TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753105273; x=1753710073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/CMxu+Wcc1BLZ6yTXXEuwdplxLvqklxHi3I0HvZ1sc=;
        b=RfDGwZAUyUjOHQ0wjE9VrvGo2Y4cXuNTwB47ZgUSx4WYGZHxziwX5mHxZvsYjI5IG7
         0XmmzMjLLC5U5vSe4HBuyet14fM1bW+mKLXNBi9b53yuCRraeV0rUmlsejLPZX8Cg9bP
         O717E8V/t1h2rVMP6ja0GJkiOfTvbCgmJ8052k+BXgF4Hlp+7+fm4yjhS3LkYmiOVCRt
         a6x/uCIg97MQ9B8SQARR1HE8lZUeDZdT8iNruP+YTEz4sy9w7Als0GS0S8DkEcUia5n1
         ydW4VUBp4aLyyz8sqn3uTyjvUBgWcw108Bflq5zPBdYpRNaTDzGLZSP3sApQh+mzY9zb
         Khug==
X-Forwarded-Encrypted: i=1; AJvYcCW0N/33Wr/9a5hmByfsld+EkKC/giG8JZWfugzbXltObhgzocpPsoQCyeJ7rws15YCzbhpTGN1ynNqjG+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZnrbJWvrN78qlqR0DQ1uM97XPy+tJy3sCSQ2T8w36rVL6/ED
	fRJggajBrnMqSF1N57tV0soxEn2xMxIUfcNOWltngRuDKplb3MqFz1jlJYtAp1q2V0V/p9ERwq3
	8zhc5FSarNAT3Imw+07xdR96aPBQjhe7osRUTFPHg
X-Gm-Gg: ASbGncsQwLGFpd74uGVCTCwKjC/Jo/MOdijojrzR/j0afPzZyX7bDA3dEvk+QxKbhDX
	3intLsYysuFqWBleYeM5fLUy+GPTXI7WbZ312F9ImxTmYefLKJVLK7ahjFhiXk5H60vLUQjFhf3
	qBDqrsLa/9oHPpWLXfltVmbMVxqMTx6ixmm0l+xdL8A2+7lUeVuZYbMuWbDdEjQC84ncd0MjhoT
	tUIXovy
X-Google-Smtp-Source: AGHT+IHV83LP0tfjFwhzfm+LStb9AHAjPM8BS0BOqo7MAWn3Qp4XExy+AH9x4hJvY+P5EHS3w8P7pBTIRquISuawbZ4=
X-Received: by 2002:a05:6e02:3c8a:b0:3e0:58e6:d8a3 with SMTP id
 e9e14a558f8ab-3e2a18446a6mr5536615ab.27.1753105272688; Mon, 21 Jul 2025
 06:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com> <20250714164405.111477-12-irogers@google.com>
 <inu4jmw3jpnbhpaqjou27sn7m5zlzu3ksiuhir42wz4yxj2nvz@xpekkgpqldo7>
In-Reply-To: <inu4jmw3jpnbhpaqjou27sn7m5zlzu3ksiuhir42wz4yxj2nvz@xpekkgpqldo7>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Jul 2025 06:41:00 -0700
X-Gm-Features: Ac12FXwC2QRBmn2fy99vXH91ei2LVIiaugmsdPaTLby6WW6k-lmNtGPaGk-2Xf0
Message-ID: <CAP-5=fWKKtETkDX48KomxZZa4YiRwhOr5oAOHxkb=a3i5rTmyg@mail.gmail.com>
Subject: Re: [PATCH v7 11/16] perf ilist: Add new python ilist command
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 12:32=E2=80=AFAM Gautam Menghani <gautam@linux.ibm.=
com> wrote:
>
> Hi Ian,
>
> Thanks for this. I tested this on both x86 and IBM pseries machine, the
> entire series LGTM
>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>

Many thanks,
Ian

