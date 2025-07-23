Return-Path: <linux-kernel+bounces-742234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C57B0EEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D5C1C83DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052228A721;
	Wed, 23 Jul 2025 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WahhgIWS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4E28A1DA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264560; cv=none; b=FuIB4miEB+4/9uVOnMye6AHGRuv8E4AIb8NsUZgYGAKZj2QrLKQgXYvmKsOTCh7IfwNDwrkfxfRLPIROoyXkf3TPM62ivf9z692T5ZSeTw0xXUFP5FAVCSthJstZMhFS/gpTP0AUQbDB+HM2lt6D/GV9IZBTUl9tYok6tULlQ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264560; c=relaxed/simple;
	bh=EWdwMvmStBaO1a+iyDKhgcucZLPmEmD/21+U6+CW2K0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uemeo5c6hL9vPj7CV62KxCJ9El8UKXPsunA/eS9/jxBM9OXWXo2OeIXpYP/G4RFTeQtLtYFQG3xcJYpUUFW3HB9/F9l+LigQNS+1fCb3qmfeIYEUkhW7UoKZ+ESB0+uPBhONw/2FdPoYp1HP4dF/vv5jg3DgFtx0eetPAz3vz/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WahhgIWS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753264556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xCYGDLksS0O5txynkhqef6RP3rgDM3Y/Sulv790AyW0=;
	b=WahhgIWSdWIwlAstF/T6iFCcWW4abrPy395yEH+B6QRHV07IWArXVCdIr+OsEaf69aGs3o
	8rLzW1eNlHAI7qRIOwZcFwhqNe1f5m6+Vb0mSr6zBAIzmcCjaDLDNdgPuYrC0pY4gG3Enn
	T17HagxamCNTq7bbb0k/63S+nFmI6AM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-XW14VlrYMkmbyTV-wodKcw-1; Wed, 23 Jul 2025 05:55:54 -0400
X-MC-Unique: XW14VlrYMkmbyTV-wodKcw-1
X-Mimecast-MFC-AGG-ID: XW14VlrYMkmbyTV-wodKcw_1753264553
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so34467175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264553; x=1753869353;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCYGDLksS0O5txynkhqef6RP3rgDM3Y/Sulv790AyW0=;
        b=KmUXesBtIvanBNJwQeVv0fODd8qq4v9/F5KEFmUflSQzkts90KgHQcZmCZkLypvW/t
         qE916SBLiRAmCaQfS9YMjj+sI8+DKI+Ks70RxZEEyLP/ZY8vNxIZiWMWj+BuS5sif9Wt
         uKNWVWxPvmMfq/iMsNjyBMBKldToAb5GFTLM3VPMrQTuVoLC3X9wlWIDXM3l97pbExe/
         +mucxaHYUKYGaUuyBxGI2SYDaEyRQ2qZMm0p9ZIdDMKEib7P7kGsxqt1bof00jcfIjD/
         dmjuic7ExR5CX3Q5SQO/Qx1zxcyHsl30y89qDXjMUIXrJZPUCig2xf0TWCfhC4vUPgrs
         4qGw==
X-Gm-Message-State: AOJu0YxixuYdCwcj/GO9z3j2um2PNmxAcnqYKw0M93n/oJgWdhcftxK3
	yAgrh3r5qi/cDwe+BZRMtkUHJgbah5wzFsTtDI3BSQ2Etqzxv+Hmqgwrh+NCAddD/r7u+ESS9D+
	wQ32PawyoS74m9wA3BeVoY8U/dgw1wTgKLWDdCyMjlRtHv6BgAVBLwvV3a5hPyi4Q2Q==
X-Gm-Gg: ASbGncua3OHQ2xZIfDm+FJMpYDdDenIJoYfRXhObaQjPHbtAuFDvDVWavDX7AgKaWn+
	F350dJnL0GlHjzAtVXqGZjrtZuaRjInd5MHYCrw9IylO4C2uYoa3n15+OEDD07NyP44vXYU8y0q
	vLKFgK3kVfr4m8ib6JrCnaPhCRyr1Rb92DI67HxfXLq+9BWLhUoovT2jrfV7PIwFuRh/2oYPGC2
	rCmV8qgL4D5pZ76ydEYKbLB2Bl8+3MOA51lLYA8vZ/31gwpPNw+x5niOsmK7l3RXvSq+FV+1wi6
	mEP/DDz+a51zUIDPKgnNx10+wusZoOAa4aOSNbO55gOuGCQUGYK7jln2uETD48E7pg==
X-Received: by 2002:a05:600c:8208:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-45868cff3b7mr19965795e9.19.1753264553388;
        Wed, 23 Jul 2025 02:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTjgOJZVpaL+eLQNTWcsZ0UxHyFvUNcsK/FPxCxG6O1mvq/jozX32Hpwd7+Znzwfcaz4qzSw==
X-Received: by 2002:a05:600c:8208:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-45868cff3b7mr19965485e9.19.1753264552906;
        Wed, 23 Jul 2025 02:55:52 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586918b65dsm17828015e9.10.2025.07.23.02.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:55:52 -0700 (PDT)
Message-ID: <374df509738db8314aa45971ba8b5469fa4e673e.camel@redhat.com>
Subject: Re: [PATCH v4 00/14] rv: Add monitors to validate task switch
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar <tglozar@redhat.com>,  Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 23 Jul 2025 11:55:50 +0200
In-Reply-To: <20250722205047.621efa7e@gandalf.local.home>
References: <20250721082325.71554-1-gmonaco@redhat.com>
	 <20250722205047.621efa7e@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 20:50 -0400, Steven Rostedt wrote:
>=20
> Can you break this up into two patch series? One that modifies the
> kernel and one that modifies the tools directory. Linus prefers
> changes to tools come in separately to changes in the kernel. So do I
> as I test them differently.

Mmh, I see. The problem with splitting those patches that strictly is
that patches changing the generating tools also include the adaptation
of kernel files, I could create something like:

  verification/rvgen: Organise Kconfig entries for nested monitors

  Do the tools/ stuff...
  The kernel changes are required to test this!


  rv: Organise Kconfig entries for nested monitors

  As introduced in commit XYZ, adapt the Kconfig...


And send them in separate series, but it doesn't look too clean to me
as the tool change requires the kernel change or, in general (see the
other patch about line length), the two things belong with each other.

Likewise, patches about monitors touch the dot models in tools/ but
those definitely belong in the same patch, otherwise we lose context.

What about keeping the patches as they are right now and send them
separately like this:

kernel series:

    rv: Add opid per-cpu monitor
     tools/verification/models/sched/opid.dot   |  35 ++++++
    rv: Add nrp and sssw per-task monitors
     tools/verification/models/sched/nrp.dot    |  29 +++++
     tools/verification/models/sched/sssw.dot   |  30 ++++++
    rv: Replace tss and sncid monitors with more complete sts
     tools/verification/models/sched/sncid.dot          |  18 ---
     tools/verification/models/sched/sts.dot            |  38 +++++
     tools/verification/models/sched/tss.dot            |  18 ---
    sched: Adapt sched tracepoints for RV task model
    rv: Retry when da monitor detects race conditions
    rv: Adjust monitor dependencies
    rv: Use strings in da monitors tracepoints
    rv: Remove trailing whitespace from tracepoint string
    rv: Add da_handle_start_run_event_ to per-task monitors

tools series:

    tools/dot2c: Fix generated files going over 100 column limit
     kernel/trace/rv/monitors/snep/snep.h    | 14 ++++++++++++--
    verification/rvgen: Organise Kconfig entries for nested monitors
     kernel/trace/rv/Kconfig                     |  5 +++++
    rv: Return init error when registering monitors
     tools/verification/rvgen/rvgen/templates/container/main.c | 3 +--
     tools/verification/rvgen/rvgen/templates/dot2k/main.c     | 3 +--
     kernel/trace/rv/monitors/sched/sched.c | 3 +--
     kernel/trace/rv/monitors/sco/sco.c     | 3 +--
     ...
     kernel/trace/rv/monitors/wwnr/wwnr.c   | 3 +--
    tools/rv: Stop gracefully also on SIGTERM
    tools/rv: Do not skip idle in trace

The rationale is that tools files changed in the kernel patches are not
really tool stuff (dot models). And kernel stuff changed in the tools
are something that the tools generate, and to test them a build should
suffice (kernel robot would do that). Having them together eases
testing the tool, I believe.

Note: I missed the tools templates from "rv: Return init error when
registering monitors" (now in the tools series with added files), I
believe that belongs more to tools but I could also move it or split
them in two if you prefer.

Does it make sense to you?

Thanks,
Gabriele


