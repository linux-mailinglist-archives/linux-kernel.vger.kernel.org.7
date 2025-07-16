Return-Path: <linux-kernel+bounces-733131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633FFB07095
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6881E4E1A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFC32EB5A8;
	Wed, 16 Jul 2025 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNja/b0H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426D2EAB9D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654636; cv=none; b=apLhun8zk97ZDfQia5sPBvJR/r57uWIcOSugdvint87bPHyy92G75YMUFX54N5Q3VmSf0u9s+QZogEMLHyUQWJdOGRVizcvwt74HkQGJGLs3oh9/b3AjU8NoSrTHe56s5lX5uRELYQTgA7JrzmriE3u9vkc3c29z59jaxeh0/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654636; c=relaxed/simple;
	bh=9LzaigoLl4b2p/ALb/kqMnj7SvMdKnIsLF2Wd7Z3hNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+WhX7omEcuV8Mp4AOgiLRYDw8oBQ2mcS74rcKYQYMN9XqsVOz++p0btVLt0JNHT94KvXDtu4MGigA6A/C9CrEKqt8H5FYzLNdWMp2/pr/4zj73IZO3LkWUXxV6LToIMHyC9gzuPlTyNfto6oeK9TD4/c6SmIy4HxQq37iXc0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNja/b0H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752654633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9LzaigoLl4b2p/ALb/kqMnj7SvMdKnIsLF2Wd7Z3hNc=;
	b=BNja/b0HbYX1gna8Oqys1Ns7/sEAkFn1VxZJoxpbcCYM38BPQPDbCUmgc7fr2I1DFfXEFZ
	2eQ5kMAVcDGvQma5XPIgA4zeZBNXJ0mYGnhxOL3EqeFIEF2l+eMoXeXYlrGP6IIR1Xtgqm
	uQc+WADJ+RIgjyC7y5xDiNXq7l86QNs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-OfUY0czGOcOvcOXtgWSE9g-1; Wed, 16 Jul 2025 04:30:32 -0400
X-MC-Unique: OfUY0czGOcOvcOXtgWSE9g-1
X-Mimecast-MFC-AGG-ID: OfUY0czGOcOvcOXtgWSE9g_1752654631
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so35860525e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654631; x=1753259431;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LzaigoLl4b2p/ALb/kqMnj7SvMdKnIsLF2Wd7Z3hNc=;
        b=be4ZYriLgiVtsZMIsnTHdN5/qLeiHvCSv0pdnUmsGOCLFkjJFqXhwli8ROZJcLcG2o
         lJVMyYMrBhtRhQlBh6Z1woI2lOHewW/0AEirDsnXDnzBqrFZVie4uQmMbwzWvYiPQUHs
         vuIao7eVpOox+WEm8MTcDEfpbpvh5O84MGVMrGAUZDwOisD0ldfOTmlZHNvEFcyQ9Gg0
         l6Acvy2TdTFjkSqMsVec2dHe0Yxxst1BmsCUTQgCi4mAPaGrzkfH9B9q0yfjPPE09irk
         n3Ewer9mJx2Ae7M3oLeiPJccRm9Xvj06PUD5AVuaJ1Iy2FYCAef6mjJ0LmjF8q6E/aAQ
         78Eg==
X-Gm-Message-State: AOJu0YzxZ4hGvlkrdfPa8/89EJqmh/hwIYLxq5nDekBvXxS9ZRIBI7vx
	0Q2r+3fHqNTnOppQF0BgA+5Ucz/9amaNMQC3XFKN+e2vf7pJbpski9gmIjdDy4Smh6f1VhGWk/N
	mLmT5f++GFLvVq4ltbUz4oBACWOLLjbl3Oq9I+1oNb8NYmgpk19HSZPvpNBl8m0IcEw==
X-Gm-Gg: ASbGncuFxFnLX5skdEgLWdnrvu4VzsfV3gDQWEap9M62SXSBsVGpmsllYpS78jSJGHC
	vl2s+6LV2cLflPbo+ufmBQ2K3mC54P57R7EnkPu4SSVgZ+C0CQUeqVjogr63oS3moyaydJC8EuL
	vOPbulWqM0BwOaAl4PnnUIGBKnxPJDTVF9/tsx3AcnexC9qlSxkyJhli5khDDOIZCflEk6vszrZ
	fyLAXhk1bIajgZH7DHbCfAMdlTahs4hE65mq4A8iaMaMDf73X8TH8H/zBkNqOhDJUrs67FbGuds
	pFMP6+RBi0SDwiLPaN6bXUbb0O7wh12vR5xUmeh4EDJofpvVNF7DkIluy5eVF6Kw9w==
X-Received: by 2002:a05:600c:6745:b0:456:1514:5b04 with SMTP id 5b1f17b1804b1-4562e02c811mr16898235e9.21.1752654630730;
        Wed, 16 Jul 2025 01:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUIwx7H1nxEf1vHGpk4PDRMhHAle6zi/pzxcdnKbjne9zRXLYDRUQxx4T3mN/pgqucWdBIZw==
X-Received: by 2002:a05:600c:6745:b0:456:1514:5b04 with SMTP id 5b1f17b1804b1-4562e02c811mr16897925e9.21.1752654630361;
        Wed, 16 Jul 2025 01:30:30 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm13651125e9.23.2025.07.16.01.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:30:30 -0700 (PDT)
Message-ID: <41906b93f031015729d969f03987ca87f22c3cf0.camel@redhat.com>
Subject: Re: [PATCH v3 07/17] rv: Adjust monitor dependencies
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 10:30:28 +0200
In-Reply-To: <20250716081948.gpIAM97C@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-8-gmonaco@redhat.com>
	 <20250716081948.gpIAM97C@linutronix.de>
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



On Wed, 2025-07-16 at 10:19 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 09:14:24AM +0200, Gabriele Monaco wrote:
> > RV monitors relying on the preemptirqs tracepoints are set as
> > dependent
> > on PREEMPT_TRACER and IRQSOFF_TRACER. In fact, those configurations
> > do
> > enable the tracepoints but are not the minimal configurations
> > enabling
> > them, which are TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS (not
> > selectable
> > manually).
> >=20
> > Set TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS as dependencies for
> > monitors.
> >=20
> > Fixes: fbe6c09b7eb4 ("rv: Add scpd, snep and sncid per-cpu
> > monitors")
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> I still dislike this. TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS are not
> selectable manually, making it hard to enable the monitors. You would
> need
> to manually enable PREEMPT_TRACER and IRQSOFF_TRACER.
>=20

Right, they cannot but they are sufficient. For instance the debug
version of several distribution kernels has PROVE_LOCKING enabled but
not TRACE_PREEMPT_TOGGLE. Both of them set TRACE_IRQFLAGS, so the
monitor should be available on those builds.

> I prefer "select" instead.
>=20
> But well, if you insist on doing it this way. It is not broken, it is
> just
> inconvenient to configure.

We had an internal discussion and my approach seems still better from a
distro maintainer/reviewer perspective.
Anyway, let's agree to disagree :)

>=20
> Acked-by: Nam Cao <namcao@linutronix.de>

Thanks,
Gabriele


