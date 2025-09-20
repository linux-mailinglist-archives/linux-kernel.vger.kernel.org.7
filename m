Return-Path: <linux-kernel+bounces-825742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5897B8CB4F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C595A1BC262A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5132690D1;
	Sat, 20 Sep 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyidlSsg"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331B1531C8
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758381717; cv=none; b=frjcAH/zBAaJ/n1TTeSqAGzCjra7nlXY5f7pzdG5pvT8k9SivZLn+JG6+cP6N7igAJOiuMjDBeju/AHmPWYBFaPd/BKuRBfAVsmjiErFRGTbNOGMiALzW3hbNb6d6SJvFtsNozltVihA5TxhzCnS1lupSWl3wMby2/byL97aCvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758381717; c=relaxed/simple;
	bh=h0efYwyS1D9GFBtrlwzfjgxaYyPsK2aqGzprSfxOlnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGNj+eYrj8Rp2Mk9JNPI5MKzend2yqbHtXVhoJdIISy78y/DmmgPhcfQy0yrOdEsy5kp96UG5jHa91ih7TduSE+WriNnzxtE2X4GAZMNBxHGjx7n7AN1bCOK/2JBHcXnQSZo6L0Io7e72ctUtRLsGz6nMx+N0NjEKjH5Ws4Y1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyidlSsg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2681645b7b6so93575ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758381715; x=1758986515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzSfuN4ySsQ+PKnoyw+8j2RW5W6RFIOOb6AK4pRniuk=;
        b=lyidlSsgCfzbjhoTCDIlX5zJ8espl6AqDv2pSpvVdBMtlNYmzFagScHxsOk4yYnTQt
         1nfSdwuklYBDT8WhEj5rK/1wt5rDVImgScW9xFR1eiDGDO8VlKt8GJXFlU89lDQkJXo1
         HkBWnts4UF2NR6gLziZzqmRbVum1e1pJBdVsGjvrLYBYPe07VqMVGGAoJTppWazAIggb
         CwJD7rpv7m/7y1pG5rx97c8pUOwMr3ryyTtv/TTY47JxepZjEV5vysnHFnWx2zhHwXLQ
         C6x3e4Jwbhh7AYjoq7ymUacmlZNeYdZJXdfnQEW/AbkAkd3sllhdQrWfCUxcoPfbfRDL
         RDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758381715; x=1758986515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzSfuN4ySsQ+PKnoyw+8j2RW5W6RFIOOb6AK4pRniuk=;
        b=YkRApGpuztW44p2GpaOwLnRXfJ1BYzgNmLHV+FgLes5thZ+42+QYhelNLckGhQ9eKy
         2LOTP3h92shLO6L87pSYxs2W0wCdHV++BkC5P4u6seQ6BzZAvrs+wy8hERNXTiE0Agpl
         HKfSBG8G05z0RNQ5SYtLNUPJIlATVdNxIwXzFr8xma4I+A3u6a/IX1A0y3VUIQPqXlwh
         2T+hk6DTVQ4uWGn2gmIl+HRUAGswQVSPePokyYED6ql+5fPKSDgxMqGI8PWP6U10PG3B
         G96EFp3H7YpMyJ/0/c9PGIbAU8W/cGzOpMndiVCNk1jq9zoYYdggwUFMVeyb7/iww4GN
         mIVw==
X-Forwarded-Encrypted: i=1; AJvYcCXdJG72drLKwN8nFwSeGI0r7+Tu76Dj0Hl+oxztgcXObG3hEoWuj08s1UaYHW8aWZlK7FGuAtHvmz+s0qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2yvSbqAE174m3pRcQL8K/ny10897vo76QSyxiE7i2+RoZ/40d
	yclpe5yMtob4IAHD79SPRHzlemUGRVBlOCQIfKcEP8E7Yc1i67kP2+xIIxiYlU3tH35w8d2R+Qw
	iLuQwXhH3ktZfm0K9pYcBTdSW03xmrAeKDXDXQJRf
X-Gm-Gg: ASbGnctKRGLjEoi4tlLp6WR9dzEW8DQSq97PRkX3t0BpcLdDjpVwIh9OGX8ZIMc9kc1
	ZlXZHIHWXWiAfYpAg7xBO8SZs2xcfbFyqxLdjSUr6zzqqUJvDNKph3Aw3VzyAFaotjghSAmQlnN
	uzoflR0pIvBOZy7CZQIZqeuFYEDUZiAG+XI6O22SFn2NYdeJh8JGOIMTXVfBTAgKQz0C0J8d40x
	ZYNS2EHtJpthOH9t98=
X-Google-Smtp-Source: AGHT+IEr1FIc/Nik60TRugyW5gXEwBcRlDr2YkbHBuRoSn1HZFneVz18uNgmFQQbl+4SXTtxbEw3W8ZkU5use8iFF0Y=
X-Received: by 2002:a17:902:d48c:b0:26d:a02f:b046 with SMTP id
 d9443c01a7336-26da02fb6bdmr4759615ad.11.1758381715073; Sat, 20 Sep 2025
 08:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914182900.1960567-1-irogers@google.com> <aM3BCr9DbBxnL5rV@x1>
In-Reply-To: <aM3BCr9DbBxnL5rV@x1>
From: Ian Rogers <irogers@google.com>
Date: Sat, 20 Sep 2025 08:21:43 -0700
X-Gm-Features: AS18NWDtI_oOLHkLFF04XHuxlAZBdaoDT_OrbL1bV8YQ9TRtspsJbnXhNRPxs4k
Message-ID: <CAP-5=fXOMLLFmn_06nBGjzbeD4=TLGPExP+K8x_pNRqKO-z-KQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Test fixes and debug logging
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Chun-Tse Shao <ctshao@google.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:46=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sun, Sep 14, 2025 at 11:28:56AM -0700, Ian Rogers wrote:
> > Testing in a hypervisor guest showed some issues that these patches
> > try to address, or improve the debug situation upon.
> >
> > Ian Rogers (4):
> >   perf test: Be tolerant of missing json metric none value
> >   perf parse-events: Add debug logging to perf_event
> >   perf test: Don't fail if user rdpmc returns 0 when disabled
> >   perf stat-shadow: Display metric-only for 0 counters
>
> Thanks, applied to perf-tools-next,

Thanks Arnaldo,

there was some follow up in:
https://lore.kernel.org/lkml/20250914182140.1958530-1-irogers@google.com/
I think I've also noticed that logging introducing newlines that
impacts the tests column counts. I'll take a further look as we tried
to harden against that with an output file option.

Thanks,
Ian

