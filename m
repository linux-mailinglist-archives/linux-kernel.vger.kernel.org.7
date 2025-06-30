Return-Path: <linux-kernel+bounces-709821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4CAEE2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA11178C02
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E2B28FAB5;
	Mon, 30 Jun 2025 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z9f+3YiX"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577228FAA5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298137; cv=none; b=jNITPYidFG5+u3GbhRbqaVP3WrcrE5xlBFDmIuiFb6tAw3PsaIieAe0S60kVj/3jqYwLeOM+muSgQPqhX5GLcCB5F3/s4tw1BQfr+LOCc6UfTU+7rtAFc0gGksafhuV/FbyE1G5OZR/Dtd9OaZh7lYQxOmLCsCLnpLMlYpcG/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298137; c=relaxed/simple;
	bh=4OwvVcEXN+UWNsFrOml/tG+qm85cKbHt02d2ltcoNYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blRl0E7a4HbWbNwW0bBGU3K0UzlRm31qcmU5e8ZPBfJp24rsEVXjX06hewza4rya+v7bkP7scm9Byag3qcjtvEWdluIocgjA4jWkLoIt2mmfRkWQNWOhyv+aBUyvdiDl1aKyCS+gB2mT6AZtqfcu90Z7fR60MqKFyYpglhQg2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z9f+3YiX; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so490015ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751298135; x=1751902935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4GR1A3VoneV+NpZxt5J9kbL5U526gB3aS4wwAL+DY4=;
        b=z9f+3YiXNUR2dTC6Nt7PO2pgvJhxMZeL6pjgzwdN+07izTpZr3cYKnzbpMQEDXShGu
         EWV5Q3AXNsxhwtMLZIAS83qoUvfSeOnyZHni+eIC6NZlfZTYOYJRCFzFb18QiTEh/YCi
         3fsvypAzjupewu7ZPvCEKaBsCSyHdTdTSf6Fb5Pc7iP66moTg9h/sh7/KwWYuYTOmEbR
         L69cpPpbna4PBnZOAjsrwky9cNFvAYmEsbJhoUW5UTrrHTbQHGwvaX4veRHVuX3d+C2F
         caFVu9fDzf0ZZoQMEVLBpAPzsVHJu3pUXmtHHZ/tXez62GnY3PagLHcG03oFD2+KzwAn
         Skfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751298135; x=1751902935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4GR1A3VoneV+NpZxt5J9kbL5U526gB3aS4wwAL+DY4=;
        b=ID9GZhqYoCqihKyPc9vwaQb84qE23icuADDKr1NIQ4fIeKNRS3b7otjScxTVDQ69CA
         49b57DCTxAMBTIjA+Z2AxheKeI4qwgH2y6RkRZm/JrdVlxBT5pBRwQSu4EzvdSXjQgbj
         RqritfJU4tpCSuB/4Pg7yAN546A17yeIZZVNiXWh93XaKYiFN5EVl4t/dZJPVUm06890
         vfvdy9qhbtd2xlj0aqTz+aje9O81T5xCkD4Rdylu9JbBRcfwiky00GQWluH1jP41t+Df
         jKoBdOdz9y0DGliDnQA2vNrFINDFnupaDQAWqYVpQ+WLkKxFjAxxupSiYFcNx10S9IDw
         DEjw==
X-Gm-Message-State: AOJu0YwGEtsW4itkWevJySTrCkxAqSrqq7D8cQ58Qzd8xBRmxn+UaYN4
	/Aep2kKNFMFTJWzyfYdNfaeV89YC86lSWJQqLGqSJb2DwDQRKZGM+PsN/l0RRWlBdFHxMgIQcJI
	MvBaMPYkp3YnIIOzaq1VavH7SJaOKHEIj55WotymG
X-Gm-Gg: ASbGncvMWF/Z9bsRR8FSx3Zz267gPqdl7jrCilw7U+tApYkFCUeDxhAxiLP0z4BOYTS
	jKDjaqxycdjFaAeall/U04dU9iCyKv3VJQwjuoxn6qg60aE8anXEAqvPro3uJUB0Q4IJ5/S0Piw
	4c6DYzmqlsqyaschsFCCFRmFE5CqTw/7jpMU/cObkggfuvo/ruKDgbV6KfUerbmdyF7Q0VNvD5H
	DVTcO7vLw==
X-Google-Smtp-Source: AGHT+IHFpDWiLyNLndY1f7Cyt5ObXxyBXFCg52HYgsqNuPCsfO0EOo/myycOnJfLYwJhrCK5SJR/bRMqve/jwdbkZ5U=
X-Received: by 2002:a05:6e02:b49:b0:3dd:f699:b167 with SMTP id
 e9e14a558f8ab-3df56ce74a8mr7082115ab.15.1751298134991; Mon, 30 Jun 2025
 08:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630091613.3061664-1-tmricht@linux.ibm.com>
In-Reply-To: <20250630091613.3061664-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Jun 2025 08:42:01 -0700
X-Gm-Features: Ac12FXxVHD2CMy2yiygOJ78LkGhzZ7nqL-Yfiv0I5XZjPSnN6PvAtkY_EllkwgA
Message-ID: <CAP-5=fWGiitgromQRTxEsU3cY99gFAU6WPLnmiS7-Q8vQNGbYw@mail.gmail.com>
Subject: Re: [PATCH] perf test: perf header test fails on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 2:16=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> commit 2d584688643fa ("perf test: Add header shell test")
> introduced a new test case for perf header. It fails on s390
> because call graph option -g is not supported on s390.
> Also the option --call-graph dwarf is only supported for
> the event cpu-clock.
>
> Remove this option and the test succeeds.
>
> Output after:
>  # ./perf test 76
>  76: perf header tests                           : Ok
>
> Fixes: 2d584688643fa ("perf test: Add header shell test")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>

Thanks Thomas! Given the s390 restriction to require dwarf, should we
switch the default "-g" meaning on s390 to mean use dwarf? James Clark
proposed this previously. It doesn't affect the change here so:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/header.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/header.sh b/tools/perf/tests/shell/he=
ader.sh
> index 813831cff0bd..412263de6ed7 100755
> --- a/tools/perf/tests/shell/header.sh
> +++ b/tools/perf/tests/shell/header.sh
> @@ -51,7 +51,7 @@ check_header_output() {
>  test_file() {
>    echo "Test perf header file"
>
> -  perf record -o "${perfdata}" -g -- perf test -w noploop
> +  perf record -o "${perfdata}" -- perf test -w noploop
>    perf report --header-only -I -i "${perfdata}" > "${script_output}"
>    check_header_output
>
> @@ -61,7 +61,7 @@ test_file() {
>  test_pipe() {
>    echo "Test perf header pipe"
>
> -  perf record -o - -g -- perf test -w noploop | perf report --header-onl=
y -I -i - > "${script_output}"
> +  perf record -o - -- perf test -w noploop | perf report --header-only -=
I -i - > "${script_output}"
>    check_header_output
>
>    echo "Test perf header pipe [Done]"
> --
> 2.50.0
>

