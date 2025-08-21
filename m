Return-Path: <linux-kernel+bounces-779848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DEDB2FA14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE643BA076
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46187326D7B;
	Thu, 21 Aug 2025 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffXZQRIW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3132778C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782158; cv=none; b=rbC0Lbh03pVYD9sbsfN8FHMeZIElFuETjPhBoWeXMjIhjbKvIiyzUrUX2QzlkvmU/WZxefnFiESZ8Prbb0JedbSjSqtdVMSeLXw6ZE5TuBwHKOL+erfOfxRGBEfgOT08+9Rqa9FctVVCbGGIjkO3O/0WMVdIBi4WpkAMx9VtB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782158; c=relaxed/simple;
	bh=msgffiOloBjq+GFhdV+bs9pFdBd05WgnGCdo2+fhp8U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CI1WHu/SICLt0gVVc2geXCaAxg+WXkgl54/z2UAzqLyptczl/TC6A21Db7k9Jq6dnnJAV4YsicWGiY5hEMpCcBb3RvXCd2DSSR/ZNSa+u2tH1iNtbWNJf1waibHYnd9LJ0Jw85pF3nDNY6orNTyWQkqXYhGiatamxBciTZusSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffXZQRIW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755782155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=msgffiOloBjq+GFhdV+bs9pFdBd05WgnGCdo2+fhp8U=;
	b=ffXZQRIWBdF6QLQFt64GHAutvo5BztvsaHOkAnJnrNjEeKvIJOEqwTopZIwHJXvwKXX4SU
	rJ3aH359HlRpTlCQvwLr4vTEgnNjTL4VHTFi6i/yQxBlrvcW8uWnzcFZkY6P7/Ix+d2ZqN
	NfhGNhE+7TYA6DhwhmxWsDADwPDpxeE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-9-wL7mD_NlC2zRRkuXu4BQ-1; Thu, 21 Aug 2025 09:15:54 -0400
X-MC-Unique: 9-wL7mD_NlC2zRRkuXu4BQ-1
X-Mimecast-MFC-AGG-ID: 9-wL7mD_NlC2zRRkuXu4BQ_1755782153
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a15fd6b45so9080455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782153; x=1756386953;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msgffiOloBjq+GFhdV+bs9pFdBd05WgnGCdo2+fhp8U=;
        b=iwk46THADsF6gssXZ6ygstchjuJbWHB+O6ldlld93xzcQ7cT1SVST/D2Lcd1fw773j
         2egy52psDASEFy6R2rUo4CAoAC9imWfUmx/+ZJubZkX3/Orn56XboJjka+2LGxdN3YZ1
         ppNPRR6ZEZ+mwdf5l00WqsUOdYpsaQFNhrrSoB8BT841EP9z4J4neXuyOI6yPGrj5trC
         iFSmowxTSnGKyIr+mg3OAU1Aa1xBisAWWsgzsrV/8orckTo2qpbTRt9bPHr6aWo6useL
         VAch7WnrB9JR/EzyVxZvqbgkk5bl2A7U2MEy/uWJD8kAHesDJvHdSrfAficm+vyEVYQO
         hirA==
X-Gm-Message-State: AOJu0Ywylm9eaghSQsY3B1yA8ov9GhXV7ftqxzbOs38W7OXP6bYjep6/
	D8UdsYeoDJkSXkNy7iOFHwVvryghfwwYHfIp0luOkyCARVqGwJO7pTTK83ab6pDIDlUiJBQOye3
	gA+FuWEHuNC6Mzx6MvGuoKQf06J+zxEMHMAWIT8vb8nbeGApvTY+GqWWq6CGpQk9h1g==
X-Gm-Gg: ASbGnct+YoCgBrZs93pkLWF3Z6Q86xKC87xi79hqgGTHIHsciO3PHJTK/+hmLBWoZAE
	zNlz4vbuMnCqlBHQUXLIZCguX/AZrwnI4LZVGYR3vpjrn+YU07pzZI89sHK8Ca1iwlcpYc774CX
	VHu26XCyfhwDvxnI/+DHJ+oBUWP5Ak41bzEKp7FhQC7ZYr7FiVSWfA1EHme2AdCjpWHi3SoA7++
	A5d1TP+vdFfJKIsSdh2yoCm5Qf1ebqLVmEgMRHtGjBhaBlfv7bPFLJEWdlx34UkuCsxuph8Xd1J
	wQkLwmP3wPrDOVazeELqYAgfscsCFJU56MWvqfIrRBHfe9uRmU8nMFv7RDUtAOdH+Q==
X-Received: by 2002:a05:6000:2911:b0:3b7:9d87:9808 with SMTP id ffacd0b85a97d-3c4b0445cbcmr2270370f8f.15.1755782152964;
        Thu, 21 Aug 2025 06:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF60F2x8bVCz2Eb0YASpJ6PNJOl/W7nIqVud/U4BDMPOH2Lc4EYmVIcu9FE9RErfYPj/Op7Rw==
X-Received: by 2002:a05:6000:2911:b0:3b7:9d87:9808 with SMTP id ffacd0b85a97d-3c4b0445cbcmr2270330f8f.15.1755782152492;
        Thu, 21 Aug 2025 06:15:52 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4d62907b3sm2188671f8f.36.2025.08.21.06.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:15:52 -0700 (PDT)
Message-ID: <b06da1ceee8a7f4efe97c6b46fe26f9f68d8b18f.camel@redhat.com>
Subject: Re: [RFC PATCH 10/17] verification/rvgen: Add support for Hybrid
 Automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Thu, 21 Aug 2025 15:15:50 +0200
In-Reply-To: <20250821123839.Gj3vCzCo@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-11-gmonaco@redhat.com>
	 <20250821123839.Gj3vCzCo@linutronix.de>
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



On Thu, 2025-08-21 at 14:38 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:08:02PM +0200, Gabriele Monaco wrote:
> > +import re
>=20
> Oh no..

I was tempted to suggest rewriting the dot parser with regex but I
guess I'll hold that back!

>=20
> > +from typing import Iterator
> > =C2=A0
> > =C2=A0class Automata:
> > =C2=A0=C2=A0=C2=A0=C2=A0 """Automata class: Reads a dot file and part i=
t as an
> > automata.
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0 It supports both deterministic and hybrid automata.
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0 Attributes:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_file: A dot file w=
ith an state_automaton definition.
> > =C2=A0=C2=A0=C2=A0=C2=A0 """
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 invalid_state_str =3D "INVALID_STATE"
> > +=C2=A0=C2=A0=C2=A0 # val can be numerical, uppercase (constant or macr=
o),
> > lowercase (parameter or function)
> > +=C2=A0=C2=A0=C2=A0 # only numerical values should have units
> > +=C2=A0=C2=A0=C2=A0 constraint_rule =3D re.compile(r"""
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (?P<env>[a-zA-Z_][a-zA-Z0-9=
_]+)=C2=A0 # C-like identifier for
> > the env var
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 My reg=
ex knowledge is not that great, but I think this is
> not
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 standa=
rd regex syntax, right?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I'm gu=
essing this is Python's feature to store this group
> into
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "env"?
>=20
> I think my brain's battery just run out, I will continue with the
> review another day.

Yeah, you got that right. That P is kinda python specific, but it seems
other regex variants (perl/PCRE) work with the same notation, there's
another notation supported by browsers and .NET without the P.

Unfortunately regex are as standard as many other things in the unix
world [1]..

I tried to be as verbose as possible in this regex and I think a
crafted parser would look much uglier, but I'd appreciate your
comments!

Thanks,
Gabriele

[1] - https://xkcd.com/927/


