Return-Path: <linux-kernel+bounces-767211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC83B25109
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76298847AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03D028D8C1;
	Wed, 13 Aug 2025 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRCXdXAR"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC517284686
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104456; cv=none; b=oSnzTyj4km9UtzauWPW1TT/mY/X36qB6Oem3EsLBJcHFEdfWU3slQI8+dhdVRHxGDET+BkoaREYOT0n7BssJ1Y8+JA5Kvinivo3HLwc9WSEEG6v2dZcSqdkR87xJqLti2XoF2b/CkM8dyLOhEcbL7xshoR9cOncAStshREavthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104456; c=relaxed/simple;
	bh=tW8l2auqnZCodEsgXMoZRbvUTLJdEClzNYtQylHae+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0p89O+VjfLg0XWGUTF3Igo6JdUemdLlf2nhpNVWL8OELE9MsdPktqHZ7UKefSugjvCUIaf2JtinrpHRbMq0wrCW2yePTKJTGrZRK8La8P7vhRSlg7ZLckWB0utXfaYoiQNDhWt0NIkCDDX54LqZL1Zp8YWlnCWDTe2q/UuAzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRCXdXAR; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-50f890eadb9so15642137.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755104454; x=1755709254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW8l2auqnZCodEsgXMoZRbvUTLJdEClzNYtQylHae+s=;
        b=FRCXdXARxzFKaOWi7VMohZcgMjcvAM0DJVZfXAje9Sh6z2v5QJWJc/HQjXd1JFyYyg
         KJkoJQXaNWyUfTUZ+0sFNNAnlwKhfjJ7xcDhOj9jm92fjEw6wtAi1KTpkS4q0n5PBZYT
         QNvCZnb5vBcDTzygmf9SJ6Y+aHdllcBGjaMlbdgbyaKIoJcRbFa7QqvCOFZHObx7vHfI
         FhvVapTJqO02rtrv0H+lxOzLzhTpONNBHuMryAEbL4NcoccRejk1O/QIK6za9C4HrIFS
         5Rzq8As0rR6y4YYmi22MlB0TsbmtJAwsikkIJBzBVY6O5uiOHerBwKox63kLWzYsx68o
         50zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104454; x=1755709254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW8l2auqnZCodEsgXMoZRbvUTLJdEClzNYtQylHae+s=;
        b=AyjwJcFh2ySQ74r7ri908hRcovLE64IBDMOjqmM/4n69QFZoN05K4ejfVoOrGJpZZL
         nuw5GpM/zz7teRvg2KurClxC9tRQMI5O0B0cV628DJvQhZvhmDBMF1lgx6V3n7+g7xEK
         4hxcIJTX23SmeE4riwDAVlj7trdv7a70iQEAQjfUu0ByKFrXhhGxJYfoSqxt6zmjbnlw
         xeQIjIT/oByn6tzuT4lUNG44d+tHdDjSPHD2ke72f7afd4Zslym9Xc59pELI3Auesf3l
         QgfwoMkqZS99k/h3SN2dC53m+R1B6fdmbVwi1zpMp2RjiAQAIm+H0j+2Fo2xNA+ronfk
         OyxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW22o2+vez5ohxhfrVV/a9RMYspJURP23csSlD2n4YWDYiyZA+zvFAb97KbYHsX2U+RcnM0VvWUympVpwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVmUHQEcGjXIQn0IDVpLl9AfMYP/NOl9rYwVhxm+BnfjHOYrH1
	45cP4YRO8Wur638nt1ivs8ECAlTQuM+liZVAQK8bDWiOKnbfZE4g5c7qjMHIg7vKspQoGRN8j/j
	5yFzfB6HfbFnJqKUIk3YDVv/qj4rxIb1Ym8xvfaZA
X-Gm-Gg: ASbGnctVrgQqBsAEOSPHgC6A3ZAYP9mTjuJXIpaj+XKXzGCN+Wlo06GgrW4pkTqYJGS
	ZCcG27gTGziXsSJW0iiKx0kI3iKRG9o/iIdDCh4E4bCf+ans9cKnJD2AEPg9vfYJLnBWyYDls/z
	S1GPT41BA/GYUXsnOCkfqOxD+BCMGLOPUmUtstKkg9z+xvlWJmYDNB4k1W3zlrfRUT3RVodTPSs
	nknGhN6
X-Google-Smtp-Source: AGHT+IE5fbyIzT284wp/v2J+M3dQ+I1vuddfrUjl31bhg67u9zcoMswV8ISEJJ1Qkrss4MRf70TqEslGpnMA5YZt2fc=
X-Received: by 2002:a05:6102:548f:b0:4da:fc9d:f0c with SMTP id
 ada2fe7eead31-50e4f1e17e0mr1597142137.12.1755104452818; Wed, 13 Aug 2025
 10:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730205644.2595052-1-blakejones@google.com> <affdc6b1-9980-44d1-89db-d90730c1e384@linux.ibm.com>
In-Reply-To: <affdc6b1-9980-44d1-89db-d90730c1e384@linux.ibm.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 13 Aug 2025 10:00:40 -0700
X-Gm-Features: Ac12FXxVXY0vdLIS2h0XVhDSsDR-mQWhlgxzNUG9OR18JmqBChTlwWM2X7kdrYE
Message-ID: <CAP_z_CgoG73txYYVgyCcVvrCbw+Jc5F=ud2DOXG5vwoVgUukHA@mail.gmail.com>
Subject: Re: [PATCH v2] Reorder some fields in struct rq.
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Josh Don <joshdon@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Madadi,

Thanks so much for reviewing this, and I'm glad to hear that the
change seemed to work well for you.

On Wed, Aug 13, 2025 at 12:30=E2=80=AFAM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
> Also ran ebizzy, which doesn=E2=80=99t seem to be impacted. I think it wo=
uld be good
> to run a set of standard benchmarks like schbench, ebizzy, hackbench, and
> stress-ng, along with a real-life workload, to ensure there=E2=80=99s no =
negative
> impact. I saw that hackbench was tried, but including those numbers would
> be helpful.

I agree that it would be interesting to have such a set of benchmarks
- and also, I'm not sure what they should be. Part of why I mentioned
my experiment with hackbench is that I'd seen it cited several times
as a standard scheduling benchmark, and my conclusion from running it
and profiling it was that I wouldn't recommend including it in a
canonical set of scheduling benchmarks. I don't have my actual numbers
from running it, but my recollection was that any delta in performance
that it showed was well within the margin of error of the test.

I did run this change on a fraction of the Google server fleet, as an
experiment along with a few other related data structure tweaks, and
saw a meaningful improvement in application performance. But I only
got results for the experiment as a whole, so I can't be sure how much
of the improvement was due to this change vs. the others.

Blake

> Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

