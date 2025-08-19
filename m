Return-Path: <linux-kernel+bounces-775450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A706B2BF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B203B1964
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CC326D45;
	Tue, 19 Aug 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZURFB6e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901F322C8A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600411; cv=none; b=BtFIdXo+HxInWeK0O1bAZYo49Vz49OyLABXWekQISE1HVgtEPWmzn/63Zk54ADdnh7Qdn/ORJPQvnANroJTPIJtJB6LQD07zXaW82h7uy6oyvZav2dtsNcMrPmDXU3W5a8Lbk4xfe1cE9R6k8r/ExJaJZulUPVM/IgAZU9VUvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600411; c=relaxed/simple;
	bh=mN4W5lU/nYDZ1u4qGcbGFkkHXrasqWu0B4ILcHlhbEQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PDPrfIa8VylGCOZyyHjX3fmFR68NGE+uBRiDVa5RqrthrVTvaYrE6nMOOo4ua6+naqH0KTkMEGrz2GZVjKKhC552ES8YfbHGD+a/t1XDJwf8ukTmBxXfJyQ9aRLB2pN8g9YgNFmTXdf7mJxNrtDb19ngxifHdg0QM3zGtQR+b7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZURFB6e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755600408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ya9rYpVnEq1bqrzAsmHksoTnC8P3FflAlqr+wlwGFI4=;
	b=UZURFB6eJmpS3uYEPCMajmFYz26zvS+e57ApZnRY0cso7nhX0Yc5/om8245dzKA5MKljsx
	MIQkNG+aR6VUHAdKJFY2ouHsjaCSbxvj/EMMDJGkXfW8lU5JUz++dSYiaAfvz+RyU9KrSB
	xn0jDshyy/qGjJ+8p4nWkmhYAWaPcTM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-THRUVvdsN8anxBa8iUl-rQ-1; Tue, 19 Aug 2025 06:46:45 -0400
X-MC-Unique: THRUVvdsN8anxBa8iUl-rQ-1
X-Mimecast-MFC-AGG-ID: THRUVvdsN8anxBa8iUl-rQ_1755600405
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e870662c1dso1428982585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600405; x=1756205205;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya9rYpVnEq1bqrzAsmHksoTnC8P3FflAlqr+wlwGFI4=;
        b=ofnqvhd2+H0UQCIKkd2718ssEOBvmZ3pTfbatlUThn7aWOtvclUsX8pct5xY3E01rq
         bvdxv2qv8HM/gzLlUN6qEMSUKelBRsmytLqvh+gV2SGqCIxKAjfwAsQkz6QEXwTbclNk
         JVhTxw2zRfj0FU3J3GGsk0+IGjCwzZwo91loDiOc2rb8ftZG9kA+aIZAJ/sChxGSa7WD
         VHUZmbu5fQ3mktfwB3tU4VfgA6gQtWchuEgcL4OfPi/xH8c8wvneKq4ukUmkpXRU0NXU
         cGy5UprcOp83J/31iMG/5EylnxMzFtZkeTiZMFjn+9YxI9tnSLHGzGC4I6fMprLNKRFG
         fWKw==
X-Gm-Message-State: AOJu0YweuEHoY62Uxm31fcblrjwaHQukVONg4TBranEq6VIvWxclVz6e
	CQlOs7gnq6K7tqsxOL0w5XfyVlNfGSsHujoxYmE4UjgtO7KjjfN+4hsNQwiGAZSR/U2kfT9H1D/
	0D2biFd1vYziDXcnEi8sEm/bG4vOrBze+LeEBOHgQPh9Og8Sx5QV8BvEcjhdL2KsKzzbRCZviB2
	R1
X-Gm-Gg: ASbGncvsiJjv292MdpxhDhHkc9naE6TRIB9FH9oDeqzx0H9SnpmVlotNQQWJPSJ/ZO0
	ALq5Ot8gcOUh2e+za8ANlTWXuKcyJeey4g3WNeSulFXmHcsUjboi8lxqD9tp6QI3FsOhC/pm5es
	gXXe3NfuuRbORrBwmBxQcULkiPwGiJ/wQz8TYSR3zm6yXbYJA3sNohmrR1gr4HdIa1CsGfuuFZD
	fnAWLqSAk7OLTvROga0TD5D9q7SOjk/yRAVqpcHPrN9aQauisieqWg8G3RZC0cATqEZJLlzyirR
	qR2OA/A0yISOXviRiP4aJqAysizJQ/+B85g64WI2UUvvflFZvbrVB+FjyVVqNqsZ6w==
X-Received: by 2002:a05:620a:17a3:b0:7e8:34b0:6e07 with SMTP id af79cd13be357-7e9f330d21emr238065785a.7.1755600404711;
        Tue, 19 Aug 2025 03:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGePi7pyFUeDcLopu06z03bZieJKd0N149MulemJ5fyts6v+HbKw6uGpTSN7vDff4vEX0HHQw==
X-Received: by 2002:a05:620a:17a3:b0:7e8:34b0:6e07 with SMTP id af79cd13be357-7e9f330d21emr238063685a.7.1755600404307;
        Tue, 19 Aug 2025 03:46:44 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba95cd49asm66838496d6.76.2025.08.19.03.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:46:44 -0700 (PDT)
Message-ID: <2e4ee3715146262df549b177ed6534129b827f09.camel@redhat.com>
Subject: Re: [RFC PATCH 11/17] Documentation/rv: Add documentation about
 hybrid automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet	 <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,  Nam Cao <namcao@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 12:46:40 +0200
In-Reply-To: <aKRAeOakjiwmgML_@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-12-gmonaco@redhat.com>
	 <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>
	 <aKRAeOakjiwmgML_@jlelli-thinkpadt14gen4.remote.csb>
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



On Tue, 2025-08-19 at 11:14 +0200, Juri Lelli wrote:
> On 19/08/25 10:53, Juri Lelli wrote:
> > Hi!
> >=20
> > On 14/08/25 17:08, Gabriele Monaco wrote:
>=20
> ...
>=20
> > > +=C2=A0 static bool verify_constraint(enum states curr_state, enum
> > > events event,
> > > +				 enum states next_state)
> > > +=C2=A0 {
> > > +	bool res =3D true;
> > > +
> > > +	/* Validate guards as part of f */
> > > +	if (curr_state =3D=3D enqueued && event =3D=3D sched_switch_in)
> > > +		res =3D get_env(clk) < threshold;
> > > +	else if (curr_state =3D=3D dequeued && event =3D=3D
> > > sched_wakeup)
> > > +		reset_env(clk);
> > > +
> > > +	/* Validate invariants in i */
> > > +	if (next_state =3D=3D curr_state)
> > > +		return res;
> > > +	if (next_state =3D=3D enqueued && res)
> > > +		start_timer(clk, threshold);
> >=20
> > So, then the timer callback checks the invariant and possibly
> > reports failure?
>=20
> Ah, OK. The 'standard' ha_monitor_timer_callback just reports failure
> (react) in case the timer fires. Which makes sense as at that point
> the invariant is broken. Maybe add some wording to highlight this?

Yeah indeed. That isn't even the 'standard' one as it isn't explicitly
configurable, but yes, at the expiration the invariant is already false
(I currently don't support AND/OR conditions in there).

I should make all this process clear, especially that those state
constraints are the only ones arming a timer and leaving the state
after that expiration (if the callback didn't run) or going through the
expiration itself implies a failure.

Thanks for pointing it out!
Gabriele


