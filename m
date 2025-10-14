Return-Path: <linux-kernel+bounces-852883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120BCBDA279
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E92188BC58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64D12FFF8D;
	Tue, 14 Oct 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLwzzgGj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468942FFF87
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453425; cv=none; b=u1K+F2kxh+1bPVa2ZWMUIOlW0+bzfcAoaibtnLUVF580IA8Qp5KVDUuv0ADiFuujuaZtUwNNhcIV5SXoIzNOvB57IvC26YGtc8tQHxMete1bReeXgMlK4DKTYGfXhpwx5uTPEN4Qnn2GoAg8zk/Uk1R1IJO0QdCbf85vcYTDhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453425; c=relaxed/simple;
	bh=fVcMhfwaRjdAcBAcAaGiUIuafT9v6J+i1zbK+jCrO9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hzqTQugz7EXhUnq64itC4AQS3RSttsHuE4jQSSJfz7WTPydZfCppwLKAOKAIbGDV7bOCzL5qcOx+Zvqg1p6q+nC5ABnuKy/8XWAU0JX7emABK03H690c92EHzyhU8enAs0AdaT3GLi2X1GvSKbVd7CN5anng5/dN/MHDf+O3VUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLwzzgGj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760453422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fVcMhfwaRjdAcBAcAaGiUIuafT9v6J+i1zbK+jCrO9E=;
	b=gLwzzgGj5Kz4MpuahYHA4RMwOVZ+UgNiQ+6OE/j/Nady4f90SVPRVw+Wo4AfMXSig4xC4+
	9WNXN9f7KjuYdOuYLy0Kx7w+eRgUBmgrjkAO44ekr4xISEka+XeE9k/lsjXgCSLylgxzn+
	Vkye7FWWQ3P68PjN4I1nt740B+3cMTI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-O0c4pBiPPqCyik1LjEWpHg-1; Tue, 14 Oct 2025 10:50:21 -0400
X-MC-Unique: O0c4pBiPPqCyik1LjEWpHg-1
X-Mimecast-MFC-AGG-ID: O0c4pBiPPqCyik1LjEWpHg_1760453420
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e38957979so30121445e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453420; x=1761058220;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVcMhfwaRjdAcBAcAaGiUIuafT9v6J+i1zbK+jCrO9E=;
        b=QRRUVM1atsxsLtvyFkt4cU9sghqxTORxqg2crIX9SG1UevtCqnCDTENmFM7LVpCvwg
         4B6Bd009Q5kMFdJvmHWml0R59qUXs+m4dbBwlEajX1eVXVr3gcFDyESTR0LucJgn6afu
         wu0dpdO5zBZDpSCiuKHUOUAlPEAVhuQMTD3kiYmw4LUdW9gRFVXyRNVBnBJH8bkGa1jN
         RUYmO1UXfIIwc36/iZ7NxlyJXhUJrBR7AJU+M9+ns6uXQKiM/D1c5mge18HVEUEFTknH
         c6MWaVo/m8GoHoz7888rtw1h4XXjGDwPryNLHi4hvwOEKIhmxQ7IykxMBEBcRX5GWNds
         SU6w==
X-Forwarded-Encrypted: i=1; AJvYcCX78Z5s1/E6PPZKPz2v7bVWe9siB7Nea6Yn8EKqwoT2s+aoQMKf7xEWh+MiuKjBvb3Zz9okc/8zxaWnLeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLTyDfI7Ew3bgfbm3Hrel2nmMRh2BhmBOwE127Hrg/Y4Fq12d
	Yd1Speq4LtYi84kEYRlyfKYtRAC4SzHRUoof/sWDkKwnG9phatCxH1pqZxyCKMfW/glch1GGK+C
	adkPSEUvBC4+vJ8UMKn79I8nfP6yCkq0G9XUz9y6RWX93eEaKbCkt/gBbkvQNxITdrw==
X-Gm-Gg: ASbGncsXskaBdwxAR9Y39pKFJ7HGSwpFz222V4ZiqAdXV1xWY5O8az5WjiwVd0BrtHs
	LT/MCAk+qwVD+fj6nlP/6FknOhptjU6doQ3qP/lRgZJHAk+4R2A3TlSay7rGyw7LGAH/opYI/Um
	Lng+5iMNdnjTUOf3ztL7vjib6xuyRMLIbAaGa4U4dYXGoTtvHX4zwmt/mRckEEJQnjwwh/5NXOp
	O9tSpDbNVyAGoO5aiJ6xEaNbd3/+OeGVi+OPRaKweqnz8Yu8HQLKR9/BBgF8+To31nwfguTuCoR
	+QZxNyq9mJ9i1dLbOOdZRH11XB/C37mbOc++llWIf845dphBShS+ms3W09LxM/X5P/mN
X-Received: by 2002:a05:600c:1d11:b0:46e:3d50:360e with SMTP id 5b1f17b1804b1-46fa9aeff01mr183085605e9.18.1760453419710;
        Tue, 14 Oct 2025 07:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlq9Rm8u6vlO/er2whrOgRGrlMCaR+wVXWhesQuVdZWlwOKvWLJBdCOyRtJ2yhfX6qVIv0uQ==
X-Received: by 2002:a05:600c:1d11:b0:46e:3d50:360e with SMTP id 5b1f17b1804b1-46fa9aeff01mr183085345e9.18.1760453419304;
        Tue, 14 Oct 2025 07:50:19 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm24542899f8f.32.2025.10.14.07.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:50:18 -0700 (PDT)
Message-ID: <1014118845296ead20fc1f8ae64c4fa610d06bc0.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 16:50:18 +0200
In-Reply-To: <20251014160719-f5a075fa-7cdf-4367-8551-05cf7715a3e7@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
	 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
	 <87qzv6szku.fsf@yellow.woof>
	 <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
	 <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>
	 <20251014140813-692b312f-67d8-4f11-99f9-73d5d8d34c87@linutronix.de>
	 <ef1503b097e6113cec24f2c20684635fe1337260.camel@redhat.com>
	 <20251014160719-f5a075fa-7cdf-4367-8551-05cf7715a3e7@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 16:18 +0200, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Oct 14, 2025 at 03:45:39PM +0200, Gabriele Monaco wrote:
> > On Tue, 2025-10-14 at 14:51 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > I can't follow here. lockdep can indicate problems, but it should not
> > > introduce
> > > problems on its own. So preventing the usage together with lockdep wo=
uld
> > > be
> > > the
> > > proverbial head in the sand. If the tracepoints called by lockdep are=
 an
> > > issue
> > > then we would just not call into lockdep in the first place. lockdep
> > > triggering
> > > these tracepoints should not be an issue in practice. I don't see a
> > > bulletproof
> > > way to prevent a tracepoint handler from calling another tracepoint,
> > > except
> > > maybe extending lockdep to also track that.
> >=20
> > Forget about it, you're right. This leads to not using lockdep inside
> > reactors
> > in the first place. We could even have notrace versions of the lockdep =
calls
> > (I'm not sure lockdep itself needs them), but that's getting horrid.
>=20
> I still don't understand why the tracepoints called from lockdep are wors=
e
> then
> the ones called from the reactors themselves? Any solution should also ap=
ply
> to
> those. Especially as even the simplest printk reactor runs into the same
> issue.

They aren't in fact, so yes, we already had this problem without knowing ab=
out
it.

> > Leaving for a moment concurrency quirks aside, a monitor that is reacti=
ng
> > should be done for a while and can be marked as not monitoring before
> > reacting, instead of after.
> > Trace handlers triggered in the same tracepoints should, in principle, =
be
> > able to tell they are not supposed to run. This at least stands for DA
> > monitors, but the same idea could work on LTL as well.
> >=20
> > Of course this gets more complicated in practice, but perhaps suspendin=
g
> > monitors during reaction can be enough to allow these lockdep calls wit=
hout
> > risking infinite loops.
>=20
> What would it mean to suspend a monitor? In my opinion we shouldn't sacri=
fice
> the accuracy of the monitors or the reliability of the reactors while try=
ing
> to mitigate a theoretical problem.

I don't mean to really sacrifice accuracy, DA monitors are disabled after a
reaction. This comes from the assumption that the model becomes invalid, so
whatever comes after might be meaningless. Monitors restart as soon as we a=
re
sure we reached the initial state.
In this case, it already doesn't make sense to monitor events triggered by
reactors.

LTL is a bit more complex, so it might make sense to continue monitoring ju=
st
after a reaction, but I'm not sure how useful that is.


