Return-Path: <linux-kernel+bounces-742389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB82B0F109
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD45AC2768
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA927A124;
	Wed, 23 Jul 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8tKKvsf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914F253944
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269509; cv=none; b=J5ma4IgZ9iXHkPQzbAyEvU86ZTNM1aOHKGDYD05G3BoTvYMcW84JzOec+uia8/a1z7rQm2b7qGLhLsTlmvGKk7CTs27ih7YvBt7JIa1r1jIkPmAbEj/LMFZkxNP85DTWhCbcQr+hv8dMvt6Ev01dWGEvhe4zbOUXpXgCKXrkHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269509; c=relaxed/simple;
	bh=NCsjaUI2FgWzArbYhZfq+jli7Z84VPLHoBN6tS76E3s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5bTFV2XlJ88vjZY4CaNKEfEgQ7DHqFaAAogTpv1eOabf0abRMgcWog4vwKJVhuq67voKNiUukHeuMwuffAgLIxPUFu4QxPsx+uc9lDEk1UubwO6WyeQMLaMANZkUOdTKTkxGwJjDPDw40KPeknar5FDXeeaR18hUkwFxwfpIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8tKKvsf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753269506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NCsjaUI2FgWzArbYhZfq+jli7Z84VPLHoBN6tS76E3s=;
	b=g8tKKvsfhM9C+pNay108G1RzAwlHCRywIbmgXnjvdqxhPsGbUqOYZCDwEIEaw7BnlQE7A5
	+RC2asafdLfhdP7mok5fqaw+pquPV6TDA/Lj64ga1vG/kfKTttYeD2VU/b29gPV2kEMtpD
	ETNAUV8Iz6zFduHxEYDOf2eF4uduEcE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-MJQEO0JiMW2PjRG4MzgexQ-1; Wed, 23 Jul 2025 07:18:25 -0400
X-MC-Unique: MJQEO0JiMW2PjRG4MzgexQ-1
X-Mimecast-MFC-AGG-ID: MJQEO0JiMW2PjRG4MzgexQ_1753269504
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4560f28b2b1so23196465e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269504; x=1753874304;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCsjaUI2FgWzArbYhZfq+jli7Z84VPLHoBN6tS76E3s=;
        b=e8K+3s4hS15NH7YUtkBOQvDGuDWG2BV6Jd4jv64wNLlnFGsNBuzooPpo2Fhxx9zrwt
         eCyGXSH9LfhmoX3krKLe8DHFJ8N7YAXlcr/hqvOdLI96kWmTb69bV4zYdLLwnEi+geFm
         xFSEE7k0uNr4N5TH1lGeSiCpaX9QQbdTciH97vjugjn8/V3sSvZbRzb1sxrDCBtB2oyr
         kuJt80z2C/+lV058RZMvlcPp2q726IfonQOaHIhjibRWwaAgLmmDt7I8SyzDJmNgcOiu
         b/6hMeg1kE0TvdK2kCwdlcjKhsQ7VOOKywXCd4cj0KAfaeSj9NCjn7iU4hhtUVnSrYEi
         eQrA==
X-Gm-Message-State: AOJu0YyjrGPT7mSKHjVrD2kPrsFda8rLdY8mpiONZ5GbXAP+XxxTxTBM
	mO+W4os/AAHposvNBiSI8bD/YHiC/5bhPwM8yzrdtLck+HkIUpjeo/XNfqR/WCLT1E24IryrmTL
	KF1MwtjQn4Swe3GTbRTvWrRnuUsD750/MpAu8VvQNtYsqMWkhsRHVXNXnsVH5HE7o9w==
X-Gm-Gg: ASbGncsOieVTDNX6tNGCnCotinoKnBB1c3Y/PSspE5zgYDzIa4pfAy6O8a1QKzFz2fZ
	uN4uGl16jVOcnmwqAvzYz7XvcL5t19HnKYzNOFsLYN/G3PrtxKzcTgnabkbXQYq27YVPRWB7Ovs
	lh8P7B9TpMyW23/MFkn5qXJJD2zzOAtrdiRadeoItdnGKmv6M1fOAUBWAYAPWzOP7/F0LGc5f8S
	yp5PgoZpO9K7Fm/EG4QCGKJsA9IkwbqGDa3fDKwzL2nEP/0TFF/jBxYrMApSXCx0FBuKPdPPq8f
	dFTqXLJerJwP3XELstPI3JPg+9uJOn6YlvKHwdjAH/oWKHQz3X1wXh8yl79Ex3LDZQ==
X-Received: by 2002:a05:600c:3f07:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45868d80dd4mr24977965e9.30.1753269503738;
        Wed, 23 Jul 2025 04:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy5TCWxQoAdDPCS7gnjL4Nc9CVcn2kV1G0g/sNAUjUbZay7cLSZYcSITz14tFnwyBCBiPeDw==
X-Received: by 2002:a05:600c:3f07:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45868d80dd4mr24977445e9.30.1753269503141;
        Wed, 23 Jul 2025 04:18:23 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586918c6c4sm19870955e9.11.2025.07.23.04.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:18:22 -0700 (PDT)
Message-ID: <d6d432828fb542903cf87e1c0be57812cda92b0a.camel@redhat.com>
Subject: Re: [PATCH v4 09/14] tools/dot2c: Fix generated files going over
 100 column limit
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Tomas Glozar
 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 23 Jul 2025 13:18:21 +0200
In-Reply-To: <20250721145254.WPp6FNzS@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
	 <20250721082325.71554-10-gmonaco@redhat.com>
	 <20250721145254.WPp6FNzS@linutronix.de>
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

On Mon, 2025-07-21 at 16:52 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 10:23:19AM +0200, Gabriele Monaco wrote:
> > The dot2c.py script generates all states in a single line. This
> > breaks the
> > 100 column limit when the state machines are non-trivial.
> >=20
> > Change dot2c.py to generate the states in separate lines in case
> > the
> > generated line is going to be too long.
> >=20
> > Also adapt existing monitors with line length over the limit.
> >=20
> > Suggested-by: Nam Cao <namcao@linutronix.de>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strformat =3D self.__get_st=
ate_string_length()
> > -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxlen =3D self.__get_max_s=
trlen_of_states() +
> > len(self.enum_suffix)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tab_braces =3D 2 * 8 + 2 + =
1 # "\t\t{ " ... "}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comma_space =3D 2 # ", " co=
unt last comma here
>=20
> PEP8 prefers two spaces before the comments.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linetoolong =3D tab_braces =
+ (maxlen + comma_space) *
> > nr_events >=3D self.line_length
>=20
> Shouldn't this be '>' instead of '>=3D'? 100 columns are still within
> the limit.

Right, will do.

Thanks,
Gabriele


