Return-Path: <linux-kernel+bounces-733140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36895B070BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E881887336
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB52EE981;
	Wed, 16 Jul 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b97S1sS/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815C28B4EA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655099; cv=none; b=Bp3GthJyZXPMEPxtSHD9yPnqgPIopFqpGpS433iK0Oh8NGzf3ZKc6it9/m5+dhwXCAbXZ54gZ9bKFqL9WMl8EoHOi9BKzrUzxYSY/5yKBWlSOrM/pYEC5ipBCdL8XsVvaYK0Wyiornvn+MMvxr46wNLH1JeS+shzJGzlvSMXOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655099; c=relaxed/simple;
	bh=QQq8vBZfSk2P43wHNlFThQAoMuJo81QL4o6cGnRFKfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hCpMZSkX0QXjB4GFRikHOLp9+6wA9+pTvPH0M/dlOjJYwnJW8Xz0hAkwiVp/9x8rFyZFhQttuBrBaVB/aGpItACvJKRaIhoqfZjvOf7ixyr+34ef9cOq2Tygitg7a1uEXpxIbZ64cBz6OGPIwd/YpHYZ/DfqQTDDzZhMFoEUtuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b97S1sS/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752655097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QQq8vBZfSk2P43wHNlFThQAoMuJo81QL4o6cGnRFKfw=;
	b=b97S1sS/TR02+6KHH88SuM/dn2V3jOKRa1Dbj9XeyB7Yj0mB6YCu/J9T8de7emrsviL+Ry
	HrThYI/f1Ir/BhkcDA0oxQCtm/j2s7liU1ty3ms7qnF2IN+ii/oyT94nZF3q1DbAIeCdWa
	BMDt4y5kRSb4bWOQOLtIEwKuL6dOWx0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-NP88lCCBNO2HUoD0WBO9WQ-1; Wed, 16 Jul 2025 04:38:15 -0400
X-MC-Unique: NP88lCCBNO2HUoD0WBO9WQ-1
X-Mimecast-MFC-AGG-ID: NP88lCCBNO2HUoD0WBO9WQ_1752655094
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso41005245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752655094; x=1753259894;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQq8vBZfSk2P43wHNlFThQAoMuJo81QL4o6cGnRFKfw=;
        b=NkxBfyra7lkFEUkt+r8rgeWMaRf6m0JxqDdPUqzGyitng+umJ23nIrPG7CKNtrrBnf
         gzIGDGUrew1CY7KKBiKkhj9WeIFpC/Ei9m3GfaejEdCryazrDC15VTocvTIAphOdh5/K
         JPAnzjtvkWjdkTkA1Ei/tOMEQU7m7SsCaaHdcw2J7isjlfAD26cY9TiZwrLysFxKf7fI
         om5N336OEINWNPr13p/unghY2Eew/CbwXemSJKhJJhtrdAXo/uVlOoNi5AECiowzXpZM
         oY5EyWPFhMn8EZlvuO4hhrNaid/5iou85zVplP3mBIsDiQNwzfkYiWmO6+B6l+Tsqp03
         eqSQ==
X-Gm-Message-State: AOJu0YzENs8ahVM271Yl4t3rNZEnmdxA1Iv6ubHWQEGby+d0/SYrQB6Q
	nn2ZYVPbCRdFpqJWyVUkR5xY22kWIvhC6Gw4rcXPg4SWBlGtmxketExvE6twP+qMCTU2vnf723/
	ES8CJAqA3QMmkggmalkM2frefaKAIbjJPQilOdeidMlmXsBmY+L1EphXevVNbmCiAog==
X-Gm-Gg: ASbGncuoXc84XBThE1nggkzoBrEZ7UihiJRCDURPtPVTK6jXn/F70f48NreGK7MyRO9
	XbhConvKyp4HuBPld5Owbp6nS8yPVuEbkTzS4LWCfa3ohHVt3ug6bb/kwgJwWWFCED2jsKY+kiL
	mlEPirVIN90ajsnsq3VgB/zCJPELHS0yn2KANdaWzFv61ybLkcGL/p72pEvbzxq2ZjKeHd3JcSr
	TunkF1UkLWsebE85+TGmHm8ZE/9PZDs1PvzAv/Bbze3nTYyRiGTUvT5dq/zoyiIzvlmpQljklRm
	d+1UGiAb/dtiUNPrGDKRmS1GNS+50BdOSt6IIbN36ewseZw2+WkX0LkOiztNJMoTwA==
X-Received: by 2002:a05:600c:64cc:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4562e3548acmr19340865e9.11.1752655094318;
        Wed, 16 Jul 2025 01:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+/nnuhW+F2Hws04Pmk8/5vN80FGzipbhCV9r67JREdN9AMG3evNFkRpoGcxhrIiM9lirDhA==
X-Received: by 2002:a05:600c:64cc:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4562e3548acmr19340525e9.11.1752655093847;
        Wed, 16 Jul 2025 01:38:13 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm13876205e9.23.2025.07.16.01.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:38:13 -0700 (PDT)
Message-ID: <f7028488e9d820848955de87ead3ec619fe5dbec.camel@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Retry when da monitor detects race
 conditions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>,  Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 10:38:11 +0200
In-Reply-To: <20250716082712.L9z_ptHK@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-12-gmonaco@redhat.com>
	 <20250715152322.Os4lDq_B@linutronix.de>
	 <e2f4f8d372612cd61689b91562e73677599d08de.camel@redhat.com>
	 <20250716082712.L9z_ptHK@linutronix.de>
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



On Wed, 2025-07-16 at 10:27 +0200, Nam Cao wrote:
> On Wed, Jul 16, 2025 at 10:20:39AM +0200, Gabriele Monaco wrote:
> > On Tue, 2025-07-15 at 17:23 +0200, Nam Cao wrote:
> > > If I understand correctly, if after 3 tries and we still fail to
> > > change the
> > > state, we will invoke the reactor and trace_error? Doesn't that
> > > cause
> > > a
> > > false positive? Because it is not a violation of the model, it is
> > > just a
> > > race making us fail to change the state.
> > >=20
> >=20
> > Yes, that's correct.
> > My rationale was that, at that point, the monitor is likely no
> > longer
> > in sync, so silently ignoring the situation is not really an
> > option.
> > In this case, the reaction includes an invalid current state
> > (because
> > in fact we don't know what the current state is) and tools may be
> > able
> > to understand that.
>=20
> Can't you bring the monitor back to the init state, and start over
> again?
>=20
> I think "da_mon->monitoring =3D 0;" does the trick?
>=20

Yes you can, but I wouldn't do so silently.
I'd say the cleanest approach without reaction is to still return false
for the system to do all the cleanup but trace the event or, at the
very least, print a warning.

But you're right, this is more relevant for who develops the monitor
rather than for the user, so should probably be tracked separately.

Thanks,
Gabriele

> > I know you wouldn't be able to do that in LTL..=C2=A0 By the way, LTL
> > uses
> > multiple statuses, so this lockless approach may not really work.
>=20
> Let's worry about one thing at a time ;)
>=20
> > I don't see this situation happening often: I only ever observed 2
> > events able to race, 4 happening at the same time is wild, but of
> > course cannot be excluded in principle for any possible monitor.
> > Yet, I have the feeling a monitor where this can happen is not well
> > designed and RV should point that out.
> > Do you have ideas of potential monitors where more than 3 events
> > can
> > race?
> >=20
> > Perhaps a full blown reaction is a bit aggressive in this
> > situation, as
> > the /fault/ may not be necessarily in the monitor.
> > We could think of a special tracepoint or just printing.
> >=20
> > > Same below.
> > >=20
> > > Also, I wouldn't use goto unless necessary. Perhaps it is better
> > > to
> > > put the
> > > code at "out_react:" and "out_success:" into the loop. But that's
> > > just my
> > > personal preference, up to you.
> >=20
> > That could be done if we do a whole different thing when retries
> > run
> > out, instead of defaulting to out_react.
> > I liked to avoid excessive indentation with those goto as well but
> > yeah, it may not be quite necessary.
>=20
> Sure, as I said before, "just my personal preference, up to you."
>=20
> Nam


