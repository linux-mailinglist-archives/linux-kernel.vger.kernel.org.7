Return-Path: <linux-kernel+bounces-733589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2A3B076A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A01F3A618F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873FB38F80;
	Wed, 16 Jul 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZX4Gufmu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A062F3C2C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671631; cv=none; b=Qf3DW4wPEsrh/uEv5uln6IP4JEtu8r1Eq2dW86pAw4oCZ+Kzuc/jurCFqV1QFdDQbwBVvVsan4UrK6j3J8rYMfUbJyRnaYsP++7VZ4dx1ZKf8etGBdOLro4RaWCDtpz/BGnxtF/8vbatpDel2Q1ptNlzKx3Co8FsCWTxmEO1bjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671631; c=relaxed/simple;
	bh=Pps7bmd8kE4AfO+Zn5fO67U10a1+bEv085CXMYYJfiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqyKnDPAMdS1aFYbkhMuFjvTEdBwehQIQn1n2iU158HSFuSt59QnnoH3bcWcXuibu1trEx0IYR+ZM4KHGoVok2+BtnaIpqeRBGmt2NePwecZgAEEhR3CdkLfdmBfgptcT8pcYsb1e02f+bOx6mpGNM17R+tWJG4Tfp/C/rYqH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZX4Gufmu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752671629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fyKbxHjITdG/t6LvPifqhCJmc7mlWwpekSsbT3bH2ig=;
	b=ZX4Gufmuk2HqBIKTAUcGtL4pQmnaV9FB0teU/x+ddupTD8MNfkrfsIsC3K7Bf7YBHTp5hz
	kL/4/ZDOBnUgIAvSPBWeluyqWyx26h4M5kgmMVzP3lEXqhB0fUqV1GSyOxuExMjadiEffW
	140TQ/cTkSMz7/x0hErG3LDagxtYAOM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-QPKbfuPmM2q3flIHqjC60Q-1; Wed, 16 Jul 2025 09:13:47 -0400
X-MC-Unique: QPKbfuPmM2q3flIHqjC60Q-1
X-Mimecast-MFC-AGG-ID: QPKbfuPmM2q3flIHqjC60Q_1752671626
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-456106b7c4aso4275735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752671626; x=1753276426;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyKbxHjITdG/t6LvPifqhCJmc7mlWwpekSsbT3bH2ig=;
        b=L+5Vg+Hpj0kgbFlwTqtyW3Qep+4r9z0l1RPCbg0+gPK7MmEyrM43RZGRRl33qHSpMZ
         Ha6ZUIo77ZoWN2nKB6II63ckGm+R6o1rhMI1MOWN07egQfgYCIWBQeAda+dyql0CglBB
         zMLxzAbAHPwEyqonxcXMkBdShIJe9b/Z/O0OpSJ4iRET8fWwBNIg3y86L2hG8jeHu4wC
         0WeHCVMUfPrnqCbh1fyn24o5kgh1SgHnfY+EwPRy1KddRveejz/uFRO6kKDeMynf9dgx
         0lxtDbkI0Yf+zHREpGIGX9j1lauS54lmliTKeMH5mw5Xm2kWnmS/EwqBx374HPORv5Po
         xAdg==
X-Gm-Message-State: AOJu0YxKmAmb04PnoIFWSI8hRc7NYbqwQUmU0AJL80vUjCjRrhsiWd6j
	XnNByRTg+ojNb4IGCImq3yD2qPwwo+sfjX/0NMJqE8Gh5Q4O+IayRaUM+0YflccI2M0dtNQfuvi
	wXyCKbkSBeGKrHi66tWQKPVWzWYpBtwwYAV96HdNRyNG9pnU3uMhZh5mRMQaFrNdpCA==
X-Gm-Gg: ASbGncuFM5or0uuOoPzzFMPL2UJoWZtUoDxwIQQQJgcDJifGLN0TEQ1FR85+HzLj6w+
	92o8NLh7T/N0KM7BGJpeQy3pivztJD68HVkcfDSTO4N4wQ4dPpyJFIPwrtS+rUtmU5gqqvXOLJ3
	2Jo8dsvyGp5gdElldOkaF0qXYUY0cqxTyJx9EE9n/0QHWIly8WxlCS7BHziUxKsqFu/8mgPxKHK
	/v0kwN8QuyegpWnIPiHJBBt+Gj+1GJfGTmmlj2ZTGxKuLCAG7CY/FfTo7GuGm3UQfmre67ZBM17
	h0YvNz4ANinpplGCSDgp28Ha6MdKL2wuVWrxLnwM/iMx6D51z7YBKK5RAkSLmcuqTg==
X-Received: by 2002:a05:600c:8b62:b0:456:1a79:49a0 with SMTP id 5b1f17b1804b1-4562dc7d288mr33139975e9.8.1752671626201;
        Wed, 16 Jul 2025 06:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfwHGgZ6HD4UQjq1BuuxJhLnJtnjRV9Ef9VjGwO/QB0x+rXaieVermWwev6SGcjNjt6zUwNg==
X-Received: by 2002:a05:600c:8b62:b0:456:1a79:49a0 with SMTP id 5b1f17b1804b1-4562dc7d288mr33139625e9.8.1752671625700;
        Wed, 16 Jul 2025 06:13:45 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d70csm18110704f8f.62.2025.07.16.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:13:44 -0700 (PDT)
Message-ID: <77bf0cb4262af4edf78dd0b5233788b358bdc79b.camel@redhat.com>
Subject: Re: [PATCH v3 01/17] tools/rv: Do not skip idle in trace
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Nam Cao
	 <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri Lelli
	 <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
	 <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 15:13:43 +0200
In-Reply-To: <20250716130846.GC3429938@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-2-gmonaco@redhat.com>
	 <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
	 <21b23f125e20102440e36da08a039d88bdf58eb1.camel@redhat.com>
	 <20250716124105.GX1613200@noisy.programming.kicks-ass.net>
	 <5aa9b70894f464dbff8e317cbd8fc188db9920e4.camel@redhat.com>
	 <20250716130846.GC3429938@noisy.programming.kicks-ass.net>
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

On Wed, 2025-07-16 at 15:08 +0200, Peter Zijlstra wrote:
> > > > > > -	if (config_has_id && (config_my_pid =3D=3D id))
> > > > > > +	if (config_my_pid && config_has_id &&
> > > > > > (config_my_pid =3D=3D id))
> > >=20
> > > But should we then not write:
> > >=20
> > > 	if (config_has_id && (config_my_pid =3D=3D id))
> >=20
> > Sorry, got a bit confused, I flipped the two while describing:
> > * -s shows traces from RV but skips from pid-0 (unintended)
> > * omitting -s skips events from RV (correct)
> >=20
> > If we are running a per-task monitor config_has_id is always true,
> > we pass -s,
> > which makes config_my_pid =3D 0 (intended /not/ to skip RV).
> > Now when we are about to trace an event from idle (id=3D0), we skip
> > it, although
> > we really shouldn't.
> > That's why we also needs to check for config_my_pid not being 0.
> >=20
> > Does it make sense?
>=20
> Sorta, but would it not make sense to use has_pid :=3D -1 for the
> invalid case, instead of 0, which is a valid pid?

Yeah that's another option, I reckon even cleaner since it's currently
misleading..


