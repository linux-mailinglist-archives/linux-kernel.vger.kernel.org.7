Return-Path: <linux-kernel+bounces-739604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B02B0C871
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C651AA78AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB1D2E03ED;
	Mon, 21 Jul 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIFywGgx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149B2853E3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114404; cv=none; b=U41/YoWLWyx4xqlkk6L7scKuicIk4xhN//YaezizKGfQUCLd07Rl3KwvSjjiUPchqOhg1KusA0wXrTrMza4qbBoVcrJWnVHBcdBKu4qHRDv7IYAb9aVPxjQ5ThOkLDGhoXkl9lv81x6VF38w/trWlFDaqvPcR1kRxSjPjYM28S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114404; c=relaxed/simple;
	bh=eP6HpFTt5M0VrV12uHRTWUJPZzddGV0wIeJ1SegML+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gr2mb6aBKWaa0EPyYfC3qgUMQH+buMjruLYBe2/fcBA8IFrmiHftd6aSPVmpdWEpuoZrtiSXJMTjSai50zvXhqvU/bci6zIH5v5WVZW37Qz3qMGrCItcwuYm5HWQjQb9vz4UE6JruPO6HRSPCEPXWPZNTJPNtc90/H5hDIGNQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIFywGgx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753114402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eP6HpFTt5M0VrV12uHRTWUJPZzddGV0wIeJ1SegML+E=;
	b=DIFywGgxzWWN39nHrpBHe/79PXsWOAHzrQQWwTTiTg+xtV6npojDR9Lj+ugs7Jhw2m9l+a
	KedUyVrbuqn1PUFysM2dLTMeyCcnn2ONhSGg8dNfiZQTG24/QW3lRj0by/2v2Of5ozyMO4
	qvsRq+JRJyJ88zTd0XTegwLWOTfrcPU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-CWmnFQc1NYy_jmtyjYm4rQ-1; Mon, 21 Jul 2025 12:13:20 -0400
X-MC-Unique: CWmnFQc1NYy_jmtyjYm4rQ-1
X-Mimecast-MFC-AGG-ID: CWmnFQc1NYy_jmtyjYm4rQ_1753114399
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2048302f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753114399; x=1753719199;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eP6HpFTt5M0VrV12uHRTWUJPZzddGV0wIeJ1SegML+E=;
        b=XxTFY6q/XLkTvJuur8m6kHgQauljrUMlTycGe8EDE0BRDWiNQQisjdbmBNFu5ZMvNc
         cEfkmfHSfpzipaIW6PwA4g4H49UB584Txee31IHB4xWtKKkEKiDkAobEE1eIQZTjxSCT
         qQd2LyOzJOnLxEEXy7Gf59nqU7kiBHHbGaPAFyvum56GBXZPJy5T6pqwTa7SQsc0At5q
         G/e+vrSFe0Le47kH5WYRUrgQU2+kaLXHQt1P/yCuBcebqmuQFFqN2f6Y0okMUgJYjuYM
         c8GkpBlXncbbCugtaqXdGaWp2diFCpxV7XFu7f+kdqyfC4q8c0M4jfEwLJOgfZHIaGmk
         tVSA==
X-Gm-Message-State: AOJu0YxlT9hbXS3Bamj/8KrjqjxKiSCj7ezXMCWe3N57NfSOMdwBLlWd
	pUdOxcizLjoBk6yV2C3mbC+RyT9XIg9nd94gNH3wlPBV5eNLoTlywMPHp9tAP+2dk75ifpeC3oZ
	9f5eOyM+siWKbuCS6NrqC7KB58meAenPYzsscguyW1wfoKd1reCSbZAoTKO9FTnFBQA==
X-Gm-Gg: ASbGncszbJGGAV30SwFs96NWJ/GPpgNBliLkQ7T67NpUs9zhU95/Aw1ZHdtkAKryNwD
	CbHAiDXb617BmD+MGn5tCtRV2jhkcgWjjYh8IndfJMzn1l/CpnqCmUFGTwduuu835PC2e5cF+TT
	NElijUna/8yn98w7M0hlZnvZrNEKZ+mH9sLa+YV6Js1hzXnscItalAhwQTDfvNr/uBoGeRsNL/8
	GdchyZIROmpoKy2ykSAmjaLDpWV4F1DyPW2uj+U++nIPQmRciH5+TdFnveeUgI0SeMEwoi8L+zl
	aiXJAfUzznsPuaOIlXgiR+gr8Pkqu7OKMG8zA5ivK+cm4MEFpTglXGFwyl2hSb/6OA==
X-Received: by 2002:a05:6000:25c3:b0:3a5:8a68:b815 with SMTP id ffacd0b85a97d-3b60dd996d8mr17044504f8f.46.1753114399366;
        Mon, 21 Jul 2025 09:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgHb7IPoyQZVbYZX2Z6jGkPlm/aEeWZsfEVFg5fmU98gr7ENzxCxPQYa4SNPQs8aHL13kQpw==
X-Received: by 2002:a05:6000:25c3:b0:3a5:8a68:b815 with SMTP id ffacd0b85a97d-3b60dd996d8mr17044470f8f.46.1753114398783;
        Mon, 21 Jul 2025 09:13:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48986sm10853554f8f.46.2025.07.21.09.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:13:18 -0700 (PDT)
Message-ID: <2e362bb6b1eb1146aba3e88cfa9bba5927d5cc70.camel@redhat.com>
Subject: Re: [PATCH v4 12/14] rv: Replace tss and sncid monitors with more
 complete sts
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet
	 <corbet@lwn.net>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 21 Jul 2025 18:13:16 +0200
In-Reply-To: <20250721151539.EXglDXpl@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
	 <20250721082325.71554-13-gmonaco@redhat.com>
	 <20250721151539.EXglDXpl@linutronix.de>
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

On Mon, 2025-07-21 at 17:15 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 10:23:22AM +0200, Gabriele Monaco wrote:
> > The tss monitor currently guarantees task switches can happen only
> > while
> > scheduling, whereas the sncid monitor enforces scheduling occurs
> > with
> > interrupt disabled.
> >=20
> > Replace the monitors with a more comprehensive specification which
> > implies both but also ensures that:
> > * each scheduler call disable interrupts to switch
> > * each task switch happens with interrupts disabled
> >=20
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> >=20
> > fixup sts remove sncid
>=20
> Is this here by accident?
>=20

Damn, again.. thanks for spotting.

> I cannot comment on the model. The CONFIG_X86_LOCAL_APIC case looks
> complex, but I cannot comment on that either.

Do you mean the amount of tracepoints or the state in the monitor?

As far as I'm aware some special IRQs on x86 use those tracepoints, and
I needed to use all of them not to miss real interrupts, which I need
to understand if interrupts where disabled programmatically or by a
hardware IRQ.

>=20
> But things look fine from RV perspective, so:
> Acked-by: Nam Cao <namcao@linutronix.de>

Thanks!
Gabriele


