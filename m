Return-Path: <linux-kernel+bounces-706932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2003AAEBDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC854A5F11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F802EA727;
	Fri, 27 Jun 2025 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fC0QAzTV"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F52D9787
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043329; cv=none; b=MVDT3stAW/zI/dVkkauYbf35ZroQCsYTENpK1IxOtIGFl4RbFRKRpZMXBpI8hDwzIVCYPZQpi7kv9NFIh8abXZWmHl0Wx475cMMQGH4I5yTsYQMivCXHuWsZ+67pVxQQ3IhPLwCdPHq+mDREvrzseO9MoMCWrAd14QBtAMrZnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043329; c=relaxed/simple;
	bh=WzuNp8fggmNQSdOMdCp9Rv2L2qJowlPOrqD/MfoEN2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw0KOrTPcv59Xbph0mYRKSqDXyWychfzBI0CMk9b5s88m5oy4w/elicNTnXTbInNo1wtiq1rHNPdPs/esKqFOh20Mh18CM2NZZqM5lLladCjEKPsIGgw1UVKe6sGONpd5M4uvyLyiyU8Iu9/1J6FFqB9aK16OoWHfmRhb/65w1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fC0QAzTV; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so14705ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751043327; x=1751648127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzuNp8fggmNQSdOMdCp9Rv2L2qJowlPOrqD/MfoEN2o=;
        b=fC0QAzTV4BP9BuVx6X1bN1S8/6V96d6Sj1VrZxXcCwMt3yWeZOYYGeb8RECeI26GXz
         z+TTdkbnGwBxAmgNLsbDrY8/a9qmNvELI/N+xPUoiczG7FmUX2Sn5lwlK2oV/3Jl70wG
         ATxc5/3Smsib9NcsZHZvDuxLDXfrEx9LgIxlUkE5sxB8xo3OHGH9iZyrrHxZzeXkNdva
         kEjM0PsUoqdncJljllR/fOyFQZgcNAoUlffvYwSi1eLqCbhxEFFNP/v8doUjmfTqhZcG
         xvirimfP7co7Dr3GI9EmBxxMg15iYaHr5uEKC0rYPA1pkeoJBD6MXBq9XKIJgOQReu19
         e1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751043327; x=1751648127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzuNp8fggmNQSdOMdCp9Rv2L2qJowlPOrqD/MfoEN2o=;
        b=iANbH6k3IeT/e5zz91E5LisxCa1+I00oc1646HsWHxcGq5df5E02XUYwACiarVNaLx
         /0c50KDifQIrp957pwobJvqmMGfC2gk7xdeBUPPbx+blS5i0RiGAiEsR9AG8oU42I9mm
         gLJ1/0Fz5AauPDj+gpNRd2iDRAXXi12LQ+Vg2rXyITCFwyj26CbE4xLbzbASbM8Moyxd
         2jM7+r3v41V6nkeMGjDyvRW8QT9q4N7TorbPaJfgnEIdTL01lZhhS97j5VmEeiQnEwAA
         +3oWZH2yda1/8KOxYZzu2W+WhF7CV30Q67zG+WgBDSVRSM4wdn/2QHcZB7INQSDfH7r1
         X3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZzIadKjszpYKdOHrQRZtMe5t3NkG6ZyC0FIlfoUk/77qwk4wDzLw6sSnLpQhjcRGV09SklTFwQEW8JSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56eAEe+LpiPb9855N0CA0pdghbXNxDGfoeoVSntfirGvTc5NB
	g8wNvtZPFAWm6S0RdusW+Ng57NbifnUoxJCbCYA2IYLVc4evBmmFXsY/Wni732NQMYk8G0dGC1C
	Nn1e9NwtB8T76h2IPofTEKyrYqVBb1T+S8GDPsPxK
X-Gm-Gg: ASbGncsAF+IH62rdCobMY6+74rBXdeJzjXWSlJgTmgrIkoQ4dPmYr0QYugBJAj6CxcJ
	7ja9P0U9rwPPWTnnLSlzO2hieV6bRu7DLKKlSTAEMLIwNpCiVZrn6JOTFSm4j+1TX1JGWY/w34P
	jTRTxpJOhcBnih0N0RQlDGf0QegoUyIbgi7FEvXlncpiVF
X-Google-Smtp-Source: AGHT+IE5bGgRxFzXmQ/GK/K2hDeu4kZV1vxh0NaCBm134jFcoqYIxFe7n/gmLkBp4tcqZHW1FSxbKy0H3FhyJhjAvAs=
X-Received: by 2002:a05:6e02:4719:b0:3dd:a562:ce54 with SMTP id
 e9e14a558f8ab-3df53c25bacmr505685ab.15.1751043326954; Fri, 27 Jun 2025
 09:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623132731.899525-1-tmricht@linux.ibm.com>
 <CAP-5=fV_hXzq0A-91NakejcQGnvPp+uJGGe=vccwM+47JVCmtA@mail.gmail.com>
 <ad905a68-a89b-458d-8a8b-2081a6656b91@linux.ibm.com> <283e109b-9eb5-4e7d-b7df-215f54496503@linux.ibm.com>
In-Reply-To: <283e109b-9eb5-4e7d-b7df-215f54496503@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Jun 2025 09:55:14 -0700
X-Gm-Features: Ac12FXzYMDHRBdMmNG-uDcOa6V7yaYqEFMkI9NCQ5NDul3g-e1u9_oRedp0lZFU
Message-ID: <CAP-5=fVcNqE9txXQgO+EUV6xz3Mvsqin9FP8FNUztPp35LW2Ng@mail.gmail.com>
Subject: Re: [Ping][PATCH] perf list: Add IBM z17 event descriptions
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 1:13=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 6/24/25 08:35, Thomas Richter wrote:
>
> Gently Ping
>
> Ian, I have responded to your comments some days ago.

Thanks Thomas, minor nit in your explanation the events must exist as
they are in json, but the json events are only exposed if the PMU is
present, so the has_event is more of a has_pmu test. Maybe we should
add a function like this to the metrics to make this kind of case
clearer. Maybe `perf list` should test the events of a metric and hide
metrics when the events aren't available to avoid the have_event
logic. I'm a bit uncomfortable with that as the events may not be
available because of permission issues, but it'd still be useful to
know the metrics are around. Anyway I'm digressing.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

