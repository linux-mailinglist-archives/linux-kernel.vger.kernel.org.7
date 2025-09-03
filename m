Return-Path: <linux-kernel+bounces-799420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5732B42B66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119823A3B95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DFD292B44;
	Wed,  3 Sep 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5yAoGCK"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC92C2AA2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932896; cv=none; b=fLScshbOHviO0oFeaG9spEACWHtnH8DXkAK4n7mFcy91GMKZOt/0HaryBaaZRLKdG2TFsZbmGW8Sbc7zx1hiQ+uo3ncjukcCq/KArMxM5EOGtjhLJ4QEZpsYtERPrmCxYW5iKPmppbYZohNcTUrFyMRrYwqjDWFsHn8nnbBJ1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932896; c=relaxed/simple;
	bh=L/f3EFrAw09+O/f4UEAO4Ok+aRzLY87xvNEocmB8skg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVE3ipAqOOmhzGzx/dQcpRAz0P6E4uTphSYtENf4lkgRIgPa8hDxNCPAePothwB78sturmTqvxZbbYdcaIngoWO6VvlLHRcgXWEqOEmXgGXt3S1ZTv5vCf9FdwKlkVjkG4EEBnqQN1SrKo6VxHNU2hEx+zH+vnl9xivKXOBGao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5yAoGCK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b042cc3962aso51221366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756932892; x=1757537692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PlibY4hkoznhQk7xjmUe2E9ZHsCDSlVQQXjHQI0tNM=;
        b=W5yAoGCKlj7HqPeuf87FhchKXM3cqQhJ6uc6ErGiJgiZ4ZsVNfh7zQxm/nimUI3ouI
         k4kxzzMN9gGFbMJ1S64FK/MmVGM3y1LK+6leOZpExiLuEVQqd0ktLISeyE0Cp2r1H4Vj
         jxsorNk/h4daW2urbax2e7Lxn4G7pj+46xWL53mTxNsEiOeVaYZiJhg/7pD8CwF6CaXx
         uGNJu2Ky1qT8Anv8dtj7G9LqPaA52/s/BG5Pu8cwZKHd71UdaOUf/5LR7fulfDK5/io5
         azlDkQZUUAfAQm3DW0SpZG9CsgwjMURuVQWPuApBsauPH43/Tx48ZmkL2KaSDFOeLrP8
         hYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932892; x=1757537692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PlibY4hkoznhQk7xjmUe2E9ZHsCDSlVQQXjHQI0tNM=;
        b=RTgJkRKrv1Gc2VoFqKm2UbEZWyMV7oXHvxhfTtV9s7gd9UgywDAqR/oVwkEmJw7RWA
         qYLbIntkUHOqAegnarKHbv/Frv0mEX/VcAQX3fPmHjK85zkqf//f63g4Owmf3l05Y/8f
         3Otx/qzimbsM5IWeOCJ/xjz3BOB1MFfQ/XxCaHExNrUX+v1fhvjwdLLtAz/B8Sq4SHJ6
         ePgh2KOI6QriWm1aDeWjK8znIkjUAhHZG9+UF/Pqwyag8tBYRW0o/H+ffw7CKvnNB7TY
         uibOeN5egYZf5ntX2TPhNEb/1OE0bKri1VrXN0hAlt9BIOawxFNvnlDd8+EQc76TylvH
         8yuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrl1PKcxMx8NFl3IAClWJAswvANwwwXNjUOyPtQrVAtHRs9t8QSQGK/jSmyB68Zc1BWBJrusbygeJ8VBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ZZmgQPYVYYeSJndBvLKp+cltS9s85/9An+BfQ5Mk5/X8X5YX
	j2up2NQk3iuMO2fml5dT+LWv/AEbtbmrLf44C3m5POXam9whYRDgNsam81/k2ZeDhdtMz0uozQ9
	XUzhQY0plyudHbcwRuWWDJzRUKF/riNWj7Dwjrint
X-Gm-Gg: ASbGncveHe4k0QL1QEKsBqLxPdI2/NI6I9Ah2yrIGqGoMxMuNb3YDfVgYltaxq7L36F
	KAAjHbjdEhpeDV8wuJPfGUBZQeBZbiVEmhua3IJTGnKhXcwit0o9Lgp5XnhcKjoNKOHz8HKT4vK
	4XQhhPcUJqODYwoLESDvc1w8wWB7Pt+ruBO3sjwBwyEGWtbAw119yocfJWHyJTgB61si81OyAy6
	c+vSQg1hiiu1I7ULlqIumkNCAiDmgg34RS/LgNjrrkRjLKGXWlqUTqQw8e3csgOgg==
X-Google-Smtp-Source: AGHT+IEI3Fx1TfPdtSP8cwFaLXhRsPNeMgppWmLkffm7Gt3QDYT8AObIIGU4tWbRSXgwRcjJ5KAuwFicXR3sHmkFDLk=
X-Received: by 2002:a17:906:1856:b0:b04:f5a:8c13 with SMTP id
 a640c23a62f3a-b040f5a91a1mr1274086366b.15.1756932891853; Wed, 03 Sep 2025
 13:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195748.226052-1-zecheng@google.com> <aLKlDp6bl9Qjiziy@google.com>
In-Reply-To: <aLKlDp6bl9Qjiziy@google.com>
From: Zecheng Li <zecheng@google.com>
Date: Wed, 3 Sep 2025 16:54:39 -0400
X-Gm-Features: Ac12FXznFlkbSdTQajUShoNbD3chK6JOxofiRzlUCxDs4xSkJ3lGUBJ5KvdObxo
Message-ID: <CAJUgMy++zvbgcuzyQUiVHdaTZMa8o=LtSUzy9PXe_sqXHqK7nQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] perf annotate: Invalidate register states for
 unsupported instructions
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:15=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Aug 25, 2025 at 07:57:48PM +0000, Zecheng Li wrote:
> > Invalidate register states when encountering unsupported instructions
> > that modify pointers, to prevent propagating incorrect pointer types.
> >
> > On x86, the 'xor' instruction may appear in a predecessor basic block
> > and zero out a register that invalidates the target register state. Thi=
s
> > sometimes relates to tagged pointers and normal programs should not
> > dereference NULL pointers, so we assume such execution paths are invali=
d
> > and do not invalidate states for 'xor' instructions.
>
> Probably we can set it to 0 with TSR_KIND_CONST.
>
It seems TSR_KIND_CONST doesn't relate to a type. Although the value
was set to 0, it still has the pointer type. I see regressions that
has this pattern

xorl    %rax, %rax
mov    %rax, (%rsp)

and sometimes

xorl    %rax, %rax
... (some branches)
mov    (%rax), %rbx

Normally NULL pointer dereference should not happen, so I assume such
execution paths are invalid.

