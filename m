Return-Path: <linux-kernel+bounces-730150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE2B040C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605C13AD95F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91822571C2;
	Mon, 14 Jul 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duDQ/r+c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9151125394C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501390; cv=none; b=lZmxW16GuST/V/hKeEZy9uBLvvYyDidfJrFPV6ColFoeHSVbILWAkUSirVKFpT1sWkk12VM2pnew0P4/b4cvXF/E+ep/MhYMfMQE2tNWFk8i+c9+Mi6kkMhuM2h3vD8UREiPiTKvp2Hr5UOyJihb3glQrbnQ/VewBzTmupG6A/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501390; c=relaxed/simple;
	bh=d0mYkW6r1E59T2xioq3X6q04oU/JygyZwBxfLULBIfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxBsYzAEzaJ3L5oDH1Oh6WorE3D6HxSn+15Y7V5UKeFHolunlTtVvAD1E7o/yxqdsh2L0S6tWPvzAKwg0RQoJZb/mGVfDvEqNNOMwpVwqZxz8IK5+TA042tzjkvXhEj5LiUptgS7nyvbXECC6ujLzr/0auhwormP39Ejzi9FK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duDQ/r+c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752501387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cHUFJOCGVx0R6dkQg2YQGh551B9n9gOmM8Fe62lW4Pk=;
	b=duDQ/r+c1RqyJjq5AyXGyCkXIUYnAdVNg7zEdqLAhmH4DHJwPD7jAiCQrQiDrFofi2Okef
	sZ23YDiOauJ2zSJM14MSYHpGU/vbZXNvFpE4q6YpJCE9/AOHkZLnUiUNDD9kOcEAHXYPvw
	IU9YWC+G3NEHQJdsnimn10D7EXL9enM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-_fxZuY_TNC-MzgqFrZwK6A-1; Mon, 14 Jul 2025 09:56:26 -0400
X-MC-Unique: _fxZuY_TNC-MzgqFrZwK6A-1
X-Mimecast-MFC-AGG-ID: _fxZuY_TNC-MzgqFrZwK6A_1752501385
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so2582432f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501385; x=1753106185;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHUFJOCGVx0R6dkQg2YQGh551B9n9gOmM8Fe62lW4Pk=;
        b=eu/CvqgGEOCf1LvIMV/fMDDrWT1sHB6JjOR1Me+hTfeOIC462SvWEh3imyVOQmL4YK
         e8bhD0uM/5zlJvMjgSiSjJNxZjrsGk1EVYXuZpLotIwHSQabjHwF0s3/IFCkqY3pnrX6
         FEdNtTKPLlJOr7TcmHAgU15DDt7I/BMEe3yqTyyQpQfnlgdyZQUYkdUt9Twmzc5xvbpI
         pAtkmVXNGBa2NaBzkI7d48QEPWkPfuLV/q3HMcKhx6mzg2iuvmn7niNdqMTOAuhG2YL8
         qr1GthkEwOBrjGOi4Wzcnf/C5LrW9ezWKbpniPc20g66Sek1Vs4Is1KM0XnboxFdv+IU
         r7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUg4frkGKZC7btkhh/SgY7+14gWUSHKUAkpgVIjdOfGrxgmr6BiQEnc7FhoSu9OLKg0teRhz2DOkLZscEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyksTkmgdkhqo1wr8ve9rpUFK42c+6B4QFMWzIyhNDBK3LOSSkE
	hydd8/LC7kTWd4Yhbu4zj+hbAlIzSl0gwFbKBXl3N231Z0APTXp7+cMXGui4xlpBRmfQbbsKd/c
	uml1DHLisB3Doac/zMZTDtQo7Hag0/Df9eRzRXolrhS5jzOIDqqqI49uyDfteJVdzHA==
X-Gm-Gg: ASbGncsWVxk+DDhTctc9c+Y/3S4kj5EfXrhYWHzBGWBO6pCOrpv1XYNORBSBD/vzLiR
	lGdi1oyDcN2uW5Optx3ELra7P6VevFNLM7bDX0pks7tVucslmGKk8BbUwiMjpFIMMlxktaMrl7p
	Ef2izL8iReXni/1Jdm9Vy0lMWeHvyd4Y/T8Z9tJi1T3BrSuJl7jXIXq3gC9aOgUaAfvswEtknE9
	dnmxJ3vafGgu3GIcjFJVMAYGptbR7b+EVadV/OuAwoaT5112E/7LgfduOTDKFHP++/cKROQ0TNL
	XMUF7mH3XBZRU9tBm3E017tWCjCMyux8vOqmLNqRQcMGnZzrRA+zmNsLvcIMOULFyA==
X-Received: by 2002:a05:6000:40d9:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3b5f2e298d0mr9095761f8f.50.1752501384694;
        Mon, 14 Jul 2025 06:56:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2GPTMLNsaQYuBEk68tW+FXjGbMsBQrCUnbTAwpVWxXClUS2qcWRimiu1Lm/16yIcBYMh1bA==
X-Received: by 2002:a05:6000:40d9:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3b5f2e298d0mr9095748f8f.50.1752501384214;
        Mon, 14 Jul 2025 06:56:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1fd7sm12308168f8f.26.2025.07.14.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:56:23 -0700 (PDT)
Message-ID: <f9c8b5d5a0eeb3f1ebae601383ddb984f9df91ad.camel@redhat.com>
Subject: Re: [PATCH 2/2] verification/rvgen: Support the 'next' operator
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness	
 <john.ogness@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2025 15:56:21 +0200
In-Reply-To: <20250714124802.kjqjNWmr@linutronix.de>
References: <cover.1752239482.git.namcao@linutronix.de>
	 <9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de>
	 <7f4409eae10023a804d24ad2a9c67d368db152cb.camel@redhat.com>
	 <20250714124208.qVXvUVqp@linutronix.de>
	 <20250714124802.kjqjNWmr@linutronix.de>
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

On Mon, 2025-07-14 at 14:48 +0200, Nam Cao wrote:
> On Mon, Jul 14, 2025 at 02:42:10PM +0200, Nam Cao wrote:
> > On Mon, Jul 14, 2025 at 02:18:05PM +0200, Gabriele Monaco wrote:
> > > Now I can't think of a way to rewrite the model to allow a pulse
> > > in
> > > sched_switch, that is /whenever scheduling turns to true, the
> > > next
> > > event is a switch/ instead of /any time scheduling is true, the
> > > next
> > > event is a switch/.
> > >=20
> > > I tried something like:
> > > =C2=A0 RULE =3D always ((not SCHEDULING and next SCHEDULING) imply ne=
xt
> > > SWITCH)
> >=20
> > Be careful of operator precedence. This rule is also what I would
> > suggest,
> > but you need parentheses:
> >=20
> > =C2=A0=C2=A0=C2=A0 RULE =3D always (((not SCHEDULING) and (next SCHEDUL=
ING)) imply
> > (next SWITCH))
>=20
> Actually no, this also does not work. You need double 'next':
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 RULE =3D always (((not SCHEDULING) and (next SCH=
EDULING)) imply
> (next next SWITCH))
>=20

Thanks! This one seems to work.

> Not sure what you mean by .init field

I meant in ltl2k there's this condition for variable usage but not for
variable definition. I'm not sure exactly what it stands for.
  _fill_start():
	...
	if not node.init:
		continue

But I guess you got what I meant already.

> Btw, I think this "(not X) and (next X)" seems very useful. So we
> could
> define a helper for this, perhaps something like "rising_edge".

Yeah good idea! I see myself mixing up in the future otherwise..
I guess you'd need to define also a falling_edge for its counterpart.
Or perhaps making it more compact as just rising/falling (with good
documentation or references to somewhere defining it).

Also we need to make clear this operator takes 2 instances, so whatever
happens after (next) it needs a double next.

Maybe it gets complicated but in the future we might have also some
nextN (next2, next3, etc. with a sensible limit not to explode the
generated code) or something along the line.

> Thanks for the report, I will post some patches to address these
> problems
> with the scripts.

Great, thanks!
I'd say since those are unrelated and the next works as intended, feel
free to add

Tested-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks again,
Gabriele


