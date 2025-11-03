Return-Path: <linux-kernel+bounces-883221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F066FC2CC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2887C189A0A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155F9298991;
	Mon,  3 Nov 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZmU4jPL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPzu029s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E04316187
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183048; cv=none; b=OSQdS6rJAQLTP99X3M79qJ5epXfP1B37WsIlCqiig9POgCb4NaA7MPbTPrmodLJL+whEjKIaVdmW65DaWkeY3SjsWi4ENlC/wkaTXILSLCZ23oBZfBKatDoBLv6MpAPRMsngCXB9Er95+jg27TsnF4jT6MndpRvf/BhX5CJq41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183048; c=relaxed/simple;
	bh=q48umo4/q1q1MbO4xsF7zhh0+GwClpjJz2v4mliYzIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j61Eug3thZUx9mNnncbE6oRk+cAev+7dUl4vMAVUGq1VnaNBcVw2miaPCkJvCAihKZAlXI7+LgumWTPypFwrzPRdoPwXvrf67zEnfFBYf0zPOp+dXHoHJkx8KA0vJip+u5hd7+G2BKOcr8X1Nvx761jmV8mtpSjACxtOTGisilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZmU4jPL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPzu029s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762183045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpgDWPP7kl7KS2qB5bXOXx86/uomsXqBkBf/uz0U2p0=;
	b=QZmU4jPLh+GE7Zg2yQqtSIOKTePJu4ht5tNfUhZEmLw01tppcv/Uff7o+4suSB5vyeCgRB
	7UlIcYpTxXtBGnJC8/butea5gOkvwxLfrzoIShS0r6xJZBzNg7rSoZIDgPI04TwWDOVV6m
	4jGApaZCQwCUiDoWdfNbHxPURP0Qe2s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-I5QL3HavPEmAuum6eA58YQ-1; Mon, 03 Nov 2025 10:17:24 -0500
X-MC-Unique: I5QL3HavPEmAuum6eA58YQ-1
X-Mimecast-MFC-AGG-ID: I5QL3HavPEmAuum6eA58YQ_1762183043
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b4635c413a7so521185766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762183042; x=1762787842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpgDWPP7kl7KS2qB5bXOXx86/uomsXqBkBf/uz0U2p0=;
        b=LPzu029sj1CMM+38535JZe/NSFA9/8GONCbJ0+MHgnSiRDs0hVCx9t9SsWUSJ6cITf
         ROTjsaUCCoZy4Za/0I0JcWT62x8mhhvFfuzBssJeaKHNeVRoSIzC/aMAKDysJDt6SDMe
         CbUH909UZs3T5ITmx5dFC1KUsdMLW074PK4f8tSfwC/EQ5e7Pap8zXI3lax0QlCmbGIq
         jG92TlZK2xymEFC8hktIQXPnwD158WxCx4vhq6OzHEaTcTCiKelFZPLdhx3G9rrnf/8k
         ETwWGkmd7MtmmPvR5VDonGwy2XtEzm0qmgHdvyOddGXaAfwM9FjTe2k4QRKOycK2DMbO
         2qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183042; x=1762787842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpgDWPP7kl7KS2qB5bXOXx86/uomsXqBkBf/uz0U2p0=;
        b=NaAfkYobS2VGpzXMWEGkWc+6Wi5G9Jywl1z+cukCA0e1vuwkqg9hLBBQSvisAB2qWw
         r8CB9Hovj+NnUPfRWnP4TiUbemJknpj13SWYK/aYOHkZMyvzXNVKBNuEmoL/HttQGwPp
         XDpPCQhzG7jiUhiARGo7VYnCWviMMcKndB3FssuIxwqSDZJ6PukJ88SD+BMm7GrY272A
         IvNCBKRzX9A5DClX7MM+1IxEAfDCZ4eYYCgJSubtLGJ9qNN14/nK6arbUO5Z70e1eqjr
         2wTLA5jrGujRvYss8qtnn6dQmVFwI27VUM6Bo1BTH6QmxdWlm6FcSxCVQZSmZLuY3TsY
         dOhw==
X-Forwarded-Encrypted: i=1; AJvYcCWqHF7YIyBzerNd3hyy25BCx+uLkIoetjRJLJHsltnmai4hkcJkh+84vZdr1vdhmOfu6UHYvmGKaRpWAjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0WztJ9bI2EpsPU43VYKm3s+Znnit3Dxtbz8XpODSShbBdTvp
	V8ptQapRSADljet+ZDKUBiu1prtc6EZKBj0xjrzu6+30WefGo6GafOBwY5ojdqmU+GLZOKflY5d
	RVr8bBAS+bCsm+lp2HoE4pmte07mK9k1PIuwAmk4ciAh7jOpk4+LRjkQjMK+47HUNFfwFk/2/3s
	y7DHxqbJAQwmAhglZhLog7IoEPtvR9VspkrckEaZdNiulxOMiqPjM=
X-Gm-Gg: ASbGnctaqucFC9EWnUPrOCZnl5umbYIq2oK7ylMesHzPZrGj/mN6wXbUsTEXQTfd4rl
	+WnE4Kf4iVM6oGfKa6hCBwgn7ylGSD7Bebk3MrEwUbdRYJ2opPTtl9Phe0t7EcZtRq9ZJ/BEWR/
	0Ol16nI9z/cpICi/jp+h6+awMqjxZwH42mLSUSB+e/BayuYT7cxMelAxel2iEXk9F4TPOn/XY06
	sN5/XlZbOkINA==
X-Received: by 2002:a17:907:980f:b0:b6c:38d9:6935 with SMTP id a640c23a62f3a-b70701bb7c0mr1268330166b.24.1762183042408;
        Mon, 03 Nov 2025 07:17:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElx/perxXX9P7/6h0riJ/rQ9LEZ9cmufxqTXsD3ZsskR/uVYi6Xx21LwvaUDRKH62Nbslp3x326tIK+km7h3w=
X-Received: by 2002:a17:907:980f:b0:b6c:38d9:6935 with SMTP id
 a640c23a62f3a-b70701bb7c0mr1268327166b.24.1762183041955; Mon, 03 Nov 2025
 07:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027153401.1039217-1-tglozar@redhat.com> <20251027153401.1039217-5-tglozar@redhat.com>
 <u4jf3ut26njnm63qgyfhq5xik7zhioecjzffok2h6jmd5utd7g@2ptjrmuvbehq>
In-Reply-To: <u4jf3ut26njnm63qgyfhq5xik7zhioecjzffok2h6jmd5utd7g@2ptjrmuvbehq>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 3 Nov 2025 16:17:08 +0100
X-Gm-Features: AWmQ_blMMM5E0pvRVAMUQDjGcAd71yBFqSuHOu0EGid7MRzf3MGBpZadKnPGprQ
Message-ID: <CAP4=nvSJq1kOUvBRwy_5Fh_FX=Qx-=xiRfngSyky1eVdZsGrrg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] rtla/tests: Test BPF action program
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 3. 11. 2025 v 16:10 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> > diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> > index 5f1529ce3693..aef814b639b7 100644
> > --- a/tools/tracing/rtla/Makefile
> > +++ b/tools/tracing/rtla/Makefile
> > @@ -76,12 +76,18 @@ src/timerlat.skel.h: src/timerlat.bpf.o
> >
> >  example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
> >       $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o =
$@
>
> I didn't understand why the filter function is needed. $< or $^ seems
> enough.
>

Ah, good catch. The filter is copied from the Makefile of stalld,
which includes a "vmlinux.h" in the targets. That makes the filter
needed, to prevent passing of the header file to the C compiler. It is
not needed here.

> > +
> > +tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
> > +     $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o =
$@
> >  else
> >  src/timerlat.skel.h:
> >       $(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
> >
> >  example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
> >       $(Q)echo "BPF skeleton support is disabled, skipping example/time=
rlat_bpf_action.o"
> > +
> > +tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
> > +     $(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bp=
f_action_map.o"
>
> Why not just not creating the targets if BPF is not enabled?
>

I could do that, but then, I would have to duplicate the check target.

> >  endif
> >
> >  $(RTLA): $(RTLA_IN)
> > @@ -103,7 +109,7 @@ clean: doc_clean fixdep-clean
> >       $(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
> >       $(Q)rm -rf feature
> >       $(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat=
_bpf_action.o
> > -check: $(RTLA)
> > -     RTLA=3D$(RTLA) prove -o -f tests/
> > +check: $(RTLA) tests/bpf/bpf_action_map.o
>
> Will this work if BPF is disabled?
>

Yes, the bpf_action_map.o target will simply print the warning. You
can try it with:

$ make BUILD_BPF_SKEL=3D0 check

Thank you for the review.

Tomas


