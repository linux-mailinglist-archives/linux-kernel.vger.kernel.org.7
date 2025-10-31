Return-Path: <linux-kernel+bounces-879862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E40C1C24455
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 265924ED372
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1B1333743;
	Fri, 31 Oct 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxT4RJ95"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F0333455
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904297; cv=none; b=h38WMkzhCBpkU4wz7sfSf6NCU5PDT7sEzUpV4tsOBJrETEI20U57rY24HrJnFdPTBnVxdnBX/f4d9iMqwMXoElhk0ZwTiEY7y8edWOUDnHijEhLgVMfmesGIEGkPbyS1krhrJgT0OrBaIDyqBKIvYWaTYLSbRCLGi82rzw5SfdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904297; c=relaxed/simple;
	bh=RwoS/PDm0zxnUlW4Huu6pywDv/HskMxqzUb9B5plkDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sthrWx8Qm6F/smDK7hkQ6Y1iAzT9d8HnyylVWWQzApQqA+hw39c0IDaKSpP9JIc05O0lVW6HEwTirqEAdXbWXAeCRTyR1JhsIe9ts2LIME4I6Hc9wW+Xg6edG2dyvz/AKDdQHNSutU2s+V2ZXdI5n3Q4zntcAI3oIXiu75cE3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxT4RJ95; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710022571cso21860495e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761904294; x=1762509094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IQtVhF5z2Qs400V3EordEf1XdwEv4+Wc34rjUmUuvY=;
        b=gxT4RJ95rehUKo7kmquvEjbm5CIUe2zg10bCdu0yBv80WzaE1vWnmnVANFa/gwPgDl
         P3IaT/6VVLGZ+fc05r8VYMJBomKGRow920LnwPRZ9lk7dKeSclCxBLwiju34I/7tFlBj
         3+Z712Fhs33j7zMLvmWjYiXwAK2F7mTCxt6/trz4Bqh64ALZ4B61ZjBo0uuwt3foE5AU
         t0UiJ81Om6aLoswj0i400sE0IgLYf47gdZWTLyCfxlGvJmsAGZYd3/kyxzdFy1kRkHp5
         +TpFplkswQcJO5dMRDThmXNlfRI0EHIbR/5gMC0tD1HcGKDEuSfdikaw21qSEgs5VXdm
         eQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904294; x=1762509094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IQtVhF5z2Qs400V3EordEf1XdwEv4+Wc34rjUmUuvY=;
        b=Jo7ITaduQYUCIiSTP/13fApxU2rrmMtyZKYYucPgH1j5IGJEcc1Xw53lu7BNXKaoTN
         7cQZ6tiu8d8KtplAhsDafdrrlrpOP7faw2zriOspWQpeHtIqRXzlTVw/r2KPEnGvlwQA
         sojviTvcHMkfjTXPcUnIeqhYWBuXiuKBgY35/PvcvdolHwREjeMsk0H0SjHTCVCE81sq
         L9a0KfLnYj3cDqbET3pBAGxhRxrHCsm/ebz+/mLTThgG3RkrNGlgZLdQTEagAjuU6cQX
         7jRpVWd1hRW6af0XfbQIdZjQI2xMQrz2awKVrgeNouWDTtajCtw8Yo/F8HFIX+pBGbru
         6oPw==
X-Forwarded-Encrypted: i=1; AJvYcCX3ehVH3gfx1QMFg14ALclmRvvy0TWUp3yyR1GohaK/4Xz1jiE6y2lD1RXObm0mGB2ySQkbS4bxzqdWOiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCZMdFrqK/owbABfqvlY3Zq8WjVWGpicGlhAFWzGBbsvjYIwe
	oMgo2kTMbHJzXFfApLSRcvyHch+qQRx7SgolrT4c0yvB1WQjz0VUdxkSGm+byA==
X-Gm-Gg: ASbGncuJVeiXF7UegUiv7QOpQVdJOwLnOflJwuS47aNZiDKqiBfXq/RcP3DNdPJsK8d
	YZvPoZwp8epdaiPmHci9Tgs6bJoPefmeYT3QMmW+jSJDDlrSVP2iWZ6bW3y6e6VoBkIztDUxd1n
	1zJvmkFVy5Nf7+G4uNvBvDM1Xrqs+ObLaiceYWUEhcl+RUnWOszNqtcoFiAhoDNuz/cuTrYZraq
	NrPHhCQj6OShYG+hrbMQSwNcYiOF6436GrNZXkiq4UcA7zVJUWurnzT1G5MsqQYQL1GecB5UVDM
	iH6/M4DDDvjKZIAYLsDQ/IBKMYdtskhI0hqBMkdDFVPikLvrEHwcrkLwOty0r0N8DaQjgaRnVOo
	QYyorrH5l5PnqE+GxFpMlYXhCMdNhXm0U95V/o9Bsj4eIMm4zSkkURfvv5eLamF7fZvK/U52r8e
	LrG9MIItpsflrhKcpbffAZZEzT+T30V7o/HQVgwA0mrFaKbEpIHw+2
X-Google-Smtp-Source: AGHT+IHhOwaM87UnJaQRrN7fhHF0k/Vk8dAJKE4DsDjg6unQFW9Cs7BqIsOLGGMUISX91/3zXJdi9g==
X-Received: by 2002:a05:600c:630e:b0:471:11a3:a6a9 with SMTP id 5b1f17b1804b1-477308acfe4mr25198435e9.37.1761904294421;
        Fri, 31 Oct 2025 02:51:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477389b3acasm10684535e9.6.2025.10.31.02.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:51:34 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:51:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, sparclinux@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Andreas Larsson
 <andreas@gaisler.com>, Christoph Lameter <cl@linux.com>, "David S. Miller"
 <davem@davemloft.net>, Finn Thain <fthain@linux-m68k.org>, Tejun Heo
 <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] sparc: time: Use pointer from memcpy() call for
 assignment in setup_sparc64_timer()
Message-ID: <20251031095132.3db72d29@pumpkin>
In-Reply-To: <33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
References: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de>
	<CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
	<33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 09:46:25 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> =E2=80=A6>> +++ b/arch/sparc/kernel/time_64.c
> >> @@ -760,9 +760,7 @@ void setup_sparc64_timer(void)
> >>                              : /* no outputs */
> >>                              : "r" (pstate));
> >>
> >> -       sevt =3D this_cpu_ptr(&sparc64_events);
> >> -
> >> -       memcpy(sevt, &sparc64_clockevent, sizeof(*sevt));
> >> +       sevt =3D memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clocke=
vent, sizeof(*sevt)); =20
> >=20
> > IMHO this makes the code harder to read:
> >   - Only 0.15% of the memcpy() calls in the kernel use the
> >     memcpy() chaining feature, =20
>=20
> I obviously propose to refactor this implementation detail.

Reduce it to 0% and the kernel memcpy() can be made 'void'. :-)
That will simplify the architecture specific implementations.

The same can be done for strcpy() and strcat() (etc).
Where the 'useful' return value would be the address of the '\0'.

	David



