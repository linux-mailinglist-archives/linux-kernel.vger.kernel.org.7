Return-Path: <linux-kernel+bounces-779346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F49B2F2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409957202BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE902ECEA5;
	Thu, 21 Aug 2025 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/cFcfLI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C982EACF9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766272; cv=none; b=Wasc4ndZ/JPdK+t9/ee5L5Z8AmeQXr6aluOl2/Rhu2SObN/+zZA//S92rnjL5piyFKyacYsp1IAM93I87Nq0ShkAVM6V9L3Ud3HIA+9oa07matD85HF0q+b1okHRTFbWCPy4B18XHX2F5A+oPkjpTYWpGqzl12NhneFXVYaDtUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766272; c=relaxed/simple;
	bh=X6kIUevNVnbOU9WmlCvFJDogVu2n7XAzdX0bs9u7nAg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lce58nGq230J1sj89tqPSZlBEavuMJKspfICvRu0TtgcB/W3+8zCA1x9lMn1SyO0Mo9/VE8h2prPrPVkIls9fD490U2cg165xvA5xJfAojijI3XR2HStZrvfSZvmYr5gWwanesbm3ikfS1MGiREP5pp56tFFK/U/bGoIOnW/Px0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/cFcfLI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755766269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X6kIUevNVnbOU9WmlCvFJDogVu2n7XAzdX0bs9u7nAg=;
	b=d/cFcfLItZd08Z95n5oG/WTrD1rZOWnks3W8F4lbWGYVM5vDDok7gFt04KJwJozWtymOCT
	OI31i3rv8+zv6Y1k+cIe44di+ulj+8r2aqV06GJwkpw9Cl4w+sQto/ycIvijO3QwqJOz4r
	5Z9JbbEyPWTM4HGmj8TgpNJ79QiOUzc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-g9a-5QM_NGCp7h4jsVE2yQ-1; Thu, 21 Aug 2025 04:51:07 -0400
X-MC-Unique: g9a-5QM_NGCp7h4jsVE2yQ-1
X-Mimecast-MFC-AGG-ID: g9a-5QM_NGCp7h4jsVE2yQ_1755766267
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e87069677cso166971485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766267; x=1756371067;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6kIUevNVnbOU9WmlCvFJDogVu2n7XAzdX0bs9u7nAg=;
        b=iqAJ5G0j/LZDNitjzO2qJHB+VpWn3ggTSbVXt/kc2XRtSpdcZB/VT33nqKa+pAguN8
         AU6mpj9m9xJyYp9RXi6roXQyi27LJku33G3+t0Nkza5a/lq5PfhXdIZzzBNFI3gBUEOj
         0rPN5yoFbljfSKzGlPhQHiQR1eE5zYQybdHKLtIW5HolRgxfNKSyjYOJv03qoNPxuBrJ
         kP8X/aJwtyYRXbfhTcSdQmuaH0xB1hlLLLUGTho47ne+UHzqoIsXzQ4EjPGtDRBD7vXG
         fPURxD2sDfEwy3gd2JMS+2ZtvHMjLxK0Fn8Smc2sLSrEuGgJB9t4LWrylxlyVdlBWSJ1
         4HZw==
X-Gm-Message-State: AOJu0YxiBu+ou0ql/Zz7+EQ1gbdMv7g7hLgbVtzK9BflBjCubKu+za4c
	fDYfHq66zH42JY/oFY4YN0HRhUQ39096rTwSV7miRVVhEnqkTGZHLm1JEPwJxOt8k1/iQ+KFtdO
	CLJMrpMHTeifkkyBxw7W74kezo5AQCSf2q122JWc4nH/ArVh72aJPyYcrrJThMGiWhA==
X-Gm-Gg: ASbGnct6CvtNZYuFs6uoGpF+AwnPsyAa7twbt8blFpg1nnVu0Q+n9wCBq6M0gJaFR7c
	wT0XyIqMMDfvwom9fSuJW3TZ2sTqr3ulGf3IvpG7Jp2DK5qdtXZS1HgN5AZSLefGWCbLNRvgxYF
	1eEMc/X6HTp6iq5Hi0fN3rNaN/iytvjok1bjPwLEsgO4IQWAISuqvanSRlVzjT6Wmix1hIMVxIg
	GmxRfDzQcLff/yD9/i/gBjtfXa6s8Bu1TxxL2IWDbIRdY/akCFmJXwRrr3zegfq9oW5bjQUfg1E
	dULwSEnw60BIcwDR8JNc1XbdiQMdcVNtJf1oLe1cPxqzLUyHF7OaNfuT/C+XsR91+Q==
X-Received: by 2002:a05:620a:4042:b0:7e9:f820:2b92 with SMTP id af79cd13be357-7ea08ed4d75mr139021185a.83.1755766266847;
        Thu, 21 Aug 2025 01:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK/XLaMLV8iagxPgHwEg6DkFLLoNJvZLFK83g7DciD1/OyAVesIqZuoqMHrVAM/eDT5oQ0aQ==
X-Received: by 2002:a05:620a:4042:b0:7e9:f820:2b92 with SMTP id af79cd13be357-7ea08ed4d75mr139019285a.83.1755766266431;
        Thu, 21 Aug 2025 01:51:06 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd693asm96733851cf.37.2025.08.21.01.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:51:06 -0700 (PDT)
Message-ID: <aac621d698dbb38458a1e701f0d177c6110f5447.camel@redhat.com>
Subject: Re: [RFC PATCH 05/17] verification/rvgen: Annotate DA functions
 with types
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Thu, 21 Aug 2025 10:51:02 +0200
In-Reply-To: <20250821082934.trGZCw9D@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-6-gmonaco@redhat.com>
	 <20250821082934.trGZCw9D@linutronix.de>
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

On Thu, 2025-08-21 at 10:29 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:07:57PM +0200, Gabriele Monaco wrote:
> > Functions in automata.py, dot2c.py and dot2k.py don't have type
> > annotations and it can get complicated to remember how to use them.
> >=20
> > Add minimal type annotations.
>=20
> Nice, Python is sometimes hard to read because the type is not clear.
>=20
> > -=C2=A0=C2=A0=C2=A0 def __get_event_variables(self):
> > +=C2=A0=C2=A0=C2=A0 def __get_event_variables(self) -> tuple[list[str],
> > list[str]]:
>=20
> This annotation is wrong. It becomes correct only after your later
> patch
> (verification/rvgen: Add support for Hybrid Automata)

Mmh, good point, that happened after I moved all cleanup patches before
the main changes (this was done after). I'm going to fix that.

Thanks,
Gabriele


