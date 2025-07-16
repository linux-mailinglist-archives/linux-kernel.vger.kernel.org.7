Return-Path: <linux-kernel+bounces-733496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF9B07572
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A41AA03BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD32F2F49E5;
	Wed, 16 Jul 2025 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKuVdMvX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FEA2EF292
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668316; cv=none; b=CYlNr/D9XH8lAFrxMo+wHU85hS3Q2tzizCKzkQdj5Rr2JSssOHKoBiw8ge1BEdGoHgh/w4zjGTVLH6eyQ2mUnQvV3zB2+vjUMvPJjXTf0zxJP5FtFWIBCZGx3oOycPzngRLWYh9Qql1l2JAxSG8SraEvAnW1C4qq/vpZdBDuV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668316; c=relaxed/simple;
	bh=/XxJtrUgi+9wdYcFM5uYwMyNrfDVUvQYja9DdrBCodM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B4FMd7TkZWT6Bg9c82ztp97KN+ilYijTtzRrxWrRcM8LRO9KPigE/FMKumg/L2ex/8uvpOwZCMIech5dlDXVDeJf8li9LarG4u8KkCedUiVXgs2c8wAxab+fIOb4MnZVak6Dja7xcMwDdNGNDKSwjldikV3LTQ6HPIOUlMe9cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKuVdMvX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752668313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fmdc0S+s7zNUMo0B5ddaCw3YpY22llIhLIpvf6wHzbg=;
	b=RKuVdMvXasLFjnhuyKCC+0TOj2RJUKHHmgf4HzEKlXT+l7l0QdVmHiqnYuVfS4KXCuhR7K
	wAerAWoyHMM2zD+bT0pcNi2io8Ws702ReV0BxwxnZcO3djWzbin3uHSQxGSxwkW/Ive+aq
	Df4mjebjCPUQGAEpSZNu+jpGnUHvwmA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-4JQiE18TOJ2aWbVTFkLzCg-1; Wed, 16 Jul 2025 08:18:32 -0400
X-MC-Unique: 4JQiE18TOJ2aWbVTFkLzCg-1
X-Mimecast-MFC-AGG-ID: 4JQiE18TOJ2aWbVTFkLzCg_1752668311
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so37129895e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752668311; x=1753273111;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmdc0S+s7zNUMo0B5ddaCw3YpY22llIhLIpvf6wHzbg=;
        b=FtYf3MZPCeQIVi6jHon9FBT2FKV7Xn2S7AnDlFKvM8JccyOH70i5nBhwPzOQf1wHM+
         ngznVV5QiuvUiV3ss7gOrvHnnp7JH86HHW1SAVvChrCH5D04QjxivXY5CYFj31LJhWo5
         rNH6QUdlZjlWluKVR149gVw78uuMKoiIKUtsAryWhx1pnc2qROl1qkeFgOxD/Hoky83g
         MmOkjYFOyH/vBCSv4PrsXMsV8t0MxPzEWmVxikER5Z4P88WlRL9IxT7Ihr/soHvfRK/x
         zx5+rZGmSvszqW3eyCvJlOUM5BaSkKQv8CpZ9y8WvXZFdHDZf9FwaL/2ZfZLAUF5S7Cr
         +W8Q==
X-Gm-Message-State: AOJu0Yz+/ftM7FXPq6WXltBNHIk/MY8qGucHjs8vAoLkK/S8Xwz8EGHW
	Nk1mCAdvLsMki8VpOw1ASpwVdTdpkNSuzxMjn4EaqRf5MfpKEXRTop1+AZwieBG1NAyCJDc0eO5
	pcGZw6I8gl17Bup6T04xyDF4Y6E29B2XUoQ1Mxq0QUyceNMsXdTR8OrvL+++ZXS+4r1ynPDJvwF
	C6
X-Gm-Gg: ASbGncvEta1hKuD2XUWEiKqBeyW84QVKPDdbp4rknveKydiOUjAey6gJQZjt2BHEaau
	NZHClM+GIThHyN2kQVmQ2Gll3aIU6m5+gV4UGN8EMxXHcx2xvFSwzIsWQ7PorWguwde4j/l0MCw
	2plBX8CRL7/iHC39H8hzojdlVCuIQMFNx/rSmLKWeJW2Q6qHn7/N20WYm9pMBlaFQbx4wWwNT9p
	Aw0LcYLkEJnDny7h8MCp2NYqOVau8HunLbMKCvsceJkBpEP+uc2vIdTEb/tO4gPt2BLN3Uv90wa
	HmZKNyussupAvp8DwoJzf21gpyqLoM+zgcr+lID5Su79v/SgvMCJ+zJP8dELWF5t6Q==
X-Received: by 2002:a05:600c:45d1:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-4562e02c62fmr29010825e9.19.1752668311004;
        Wed, 16 Jul 2025 05:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEizuNZ7KMS3nV1ER+gRuwQX33CLZiIoP4lhqjrhroW2amy9gQOh+ZyUTRgeqViJuRyQZ7swg==
X-Received: by 2002:a05:600c:45d1:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-4562e02c62fmr29010415e9.19.1752668310548;
        Wed, 16 Jul 2025 05:18:30 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2bb4sm19193835e9.8.2025.07.16.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:18:30 -0700 (PDT)
Message-ID: <21b23f125e20102440e36da08a039d88bdf58eb1.camel@redhat.com>
Subject: Re: [PATCH v3 01/17] tools/rv: Do not skip idle in trace
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Nam Cao
	 <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri Lelli
	 <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
	 <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 14:18:28 +0200
In-Reply-To: <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-2-gmonaco@redhat.com>
	 <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
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



On Wed, 2025-07-16 at 13:50 +0200, Peter Zijlstra wrote:
> On Tue, Jul 15, 2025 at 09:14:18AM +0200, Gabriele Monaco wrote:
> > Currently, the userspace RV tool skips trace events triggered by
> > the RV
> > tool itself, this can be changed by passing the parameter -s, which
> > sets
> > the variable config_my_pid to 0 (instead of the tool's PID).
> > The current condition for per-task monitors (config_has_id) does
> > not
> > check that config_my_pid isn't 0 to skip. In case we pass -s, we
> > show
> > events triggered by RV but don't show those triggered by idle (PID
> > 0).
> >=20
> > Fix the condition to account this scenario.
>=20
> The distinction between !my_pid and has_id is that you can in fact
> trace
> pid-0 if you want?
>=20

Yes pretty much, no flag is meant to skip events from pid-0.


has_id is used to distinguish between per-cpu/global monitors (they
don't have id) and per-task monitors (the id is the pid).

The case with !has_id is correctly checking for both my_pid !=3D 0 while
skipping events associated to my_pid (rv thread's PID).

In the other case we end up with:
* -s skipping events generated by the tool (correct)
* omitting -s skips events generated by pid-0 (undesired)


> > Fixes: 6d60f89691fc ("tools/rv: Add in-kernel monitor interface")
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0tools/verification/rv/src/in_kernel.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/verification/rv/src/in_kernel.c
> > b/tools/verification/rv/src/in_kernel.c
> > index c0dcee795c0de..72b03bae021cd 100644
> > --- a/tools/verification/rv/src/in_kernel.c
> > +++ b/tools/verification/rv/src/in_kernel.c
> > @@ -429,7 +429,7 @@ ikm_event_handler(struct trace_seq *s, struct
> > tep_record *record,
> > =C2=A0
> > =C2=A0	tep_get_common_field_val(s, trace_event, "common_pid",
> > record, &pid, 1);
> > =C2=A0
> > -	if (config_has_id && (config_my_pid =3D=3D id))
> > +	if (config_my_pid && config_has_id && (config_my_pid =3D=3D
> > id))
> > =C2=A0		return 0;
> > =C2=A0	else if (config_my_pid && (config_my_pid =3D=3D pid))
> > =C2=A0		return 0;
> > --=20
> > 2.50.1
> >=20


