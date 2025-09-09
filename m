Return-Path: <linux-kernel+bounces-808218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F7DB4FC02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDFD3A1B05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960A833EAF1;
	Tue,  9 Sep 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="us3y1m1H"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDC33CEBF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423098; cv=none; b=r3eKLtOdcBEZZM4H4ReCrXaEAiKR8cTevuDlt3JjR0Zy7JvRllRL5bNRGsstOoznSCOO3yWHDfTregg3x2mniN9SGEffvKGPiSIjRV1glHoRICM67U6gZD92jAV3+FO5K+Wr49bJ5p4F/7std/0CWsoqvwZUJqhkFT2zPIqHG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423098; c=relaxed/simple;
	bh=wuEDhAn7VE4XCDJgxxXZUeG3h59v9HM1l7I/5wkYj2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuYkx4KnLzenWbdugOqOq0nvok8XNS83v1/3Y1KRc5kvjWxeCbCfqXOF4ROEd7UPjP7e79G6b7u48GPMqYh1GJb/MOBomMOcjWgXv9GnBRwsy9Ik15qKVdsXJjh85vj2MI/q7txLIxmbJJyRo6VwFhbG8rZVXZNUFCb8XvQFm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=us3y1m1H; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24cf5bcfb60so479465ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757423096; x=1758027896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FegmOUf8bYexzRzeJYKOCwFad+h+PFSGJuRgZi24g9o=;
        b=us3y1m1H5gNeKGbjB3usftbiEidaWlIoFHSMULr97z2j0QcsQO0YAO/F1nddFXdsnY
         2NACCT6TApoXWi6cJZ6V1cHOTscSKP/zsFOgS6dZyVjsQkjQe3tnLB0BJoKkEedwIWW8
         5IX1UlK8tfE+1OHw8us2/LhTfB7bkooMkKDA9NTVnFka4hXrGQ9T7+Sw6dhU0KynNacJ
         VkIThxUtKW6QaJGl15h22kL7TMFCsZUR/7g0v3kBHgv6RvjCDfwRPchqdnsbhFpp6yy1
         ajtEFRPFDZVq0bpHYMnWg55FZs8+2iPrLWCm7nujpfesO+D2BeBxwTjtxEr38x/ybdD6
         da2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423096; x=1758027896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FegmOUf8bYexzRzeJYKOCwFad+h+PFSGJuRgZi24g9o=;
        b=HDYuyi65rGpfyFwq13p6EmqVKu0zxrcYJc7BOZO05cqUs8lOvuqb3fDZcKFijtCD+y
         Ddf9bFAiOaBm78SWxWynHKKl6pTyDScUJSPobP2DvviLRf9Duv75LHftNu/5ziP1qv9Y
         unXAOZa0pFEJzaIQsX48Pr1Gybx3mt+N8KmBpOFixWN15KCP6YD3KEFwh06biypk5if8
         NEgXlRvOpx0XBc6gVPS2gAWKx2sEm0cyw2dINj5GEJ6mV+mk5/NBefARCwE3tkfmccPu
         IeVgDsW2PGVfkRio+8OkwnbZiKb1jkvUjdMnCPwJyGVGVHpqSt93GLIZdILWLwBWmNbw
         Aw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXk1HLTq98/JuK1Xoi1P+IcqEFCQpk3ieSAOIhxqC+/Cc9/Zi5cODjD1qi7NulOphMBt5qW8BAlKRu2/BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJFswjilUQyVNddjJbp2wdqidmlUovWUZMe6XWeBXer0UWC74
	ucw8Q1urHPdBcv6GNd39idejKNGhhD0brzs5kjI2opp6suy3ThZK5kKwToE007TIBvNFcXel568
	XRUcusGUbKxcvcvh01XIg4aCVAWwzM4RiNYVOZBHJ
X-Gm-Gg: ASbGncv4w6/Qx5dFUFzUHIa7/7idgoJ4PgrgxeYSqnP9faQjNBYZybsdGh3uO9j2rgj
	ugdixNZUojqGwNJc9UDd20sIXZUkN/6RnvUIpsK7lmeYaAjKOBve9sKXU8rpoAkYXWIumVoQyMV
	0sP3wki5V7LoQIyCqLj9DCSSERPg62Ed2ZjL4jZTapMeMn+A6Ubg++y3xmOQHfED6r/lVxrgVPr
	UbAev6qL8vqyZR6XGLaJyI2IQ==
X-Google-Smtp-Source: AGHT+IGxkBlp/AxP5ezcb05alMwdQQBJpkLO6kD0GQc8Jn7qJD8riHbmJuzzdb3s0/Uf/T4BuVR0E8LEVn45d8u0sWM=
X-Received: by 2002:a17:902:ee55:b0:240:4464:d486 with SMTP id
 d9443c01a7336-251753ddba7mr9427785ad.13.1757423095381; Tue, 09 Sep 2025
 06:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMACaOmneDrG8_pQ@gentoo.org>
In-Reply-To: <aMACaOmneDrG8_pQ@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Sep 2025 06:04:42 -0700
X-Gm-Features: Ac12FXzybYii8a916p3tX2nAHNuT8iSupwAVo96d7tCCsAUhIZreC8qrC8yg8m4
Message-ID: <CAP-5=fVA_Cduf9NvFAJezcNcg0JDNGa5q7m_mRBWNAYGEUo8bw@mail.gmail.com>
Subject: Re: Problem with perf report --gtk
To: Guilherme Amadio <amadio@gentoo.org>
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 3:33=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org>=
 wrote:
>
> Hi Arnaldo, Namhyung,
>
> Since sometime we have a bug in Gentoo's bugzilla about perf report --gtk=
 not
> working=C2=B9: https://bugs.gentoo.org/937869
>
> I know this feature is not used very much, but I thought I'd report in
> any case. The problem is easily reproducible as shown below:
>
>
> $ perf record -a -g -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.818 MB perf.data (6648 samples) ]
> $ LD_DEBUG=3Dsymbols perf report --gtk 2>&1 | grep '(fatal)'
>     288067:     /usr/libexec/perf-core/libperf-gtk.so: error: symbol look=
up error: undefined symbol: hashmap_find (fatal)
> $ perf report --gtk
> GTK browser requested but could not find libperf-gtk.so
>
> I tried this with perf 6.16, but this bug seems to have been there since
> at least 6.12.
>
> Please let me know if it's better to file problems at https://bugzilla.ke=
rnel.org/.

Thanks for letting us know Guilherme! I suspect I broke things when
trying to fix python things. The code linking libperf-gtk.so is:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n809
The hashmap symbols are part of the perf-util library:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/Build?h=3Dperf-tools-next#n197
So maybe there needs to be a libbpf -lbpf for your case? Alternatively
we may need to reorder the libraries here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n464
like:
PERFLIBS +=3D $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPERF_UTIL=
)
becomes:
PERFLIBS +=3D $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UTIL) $(LIBPERF_UI=
)

Thanks,
Ian

