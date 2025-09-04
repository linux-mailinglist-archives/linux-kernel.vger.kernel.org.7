Return-Path: <linux-kernel+bounces-800307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DAAB4360F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A91C5A18F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5222D063C;
	Thu,  4 Sep 2025 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNTqr4gu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0A2C17B2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975180; cv=none; b=nUK33H1YZT18hWGzEfA+ZpiadVX0/if9WUbVw2YRitI59eU0662Ix1ATJtc+ESNb+zd31/7KyW/zVF4EFn4F/FE/XC1zP2CT0TTtvGKvoyuz3FuR6LkpeVwjo3JRUz6R2WyBNDnGAGtFVl7GrMu8QsI1iZVJyEY+zlpKchxdPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975180; c=relaxed/simple;
	bh=zD+pNh84vYqx3bcx9772vWzqVK6F9lba3ZgTFMFLfgQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Foc5kg/ESnIHrU8r1BfeeL4rr5TGoTD1vGAtH20MSmcXGloqsOYMA9SIqkkQLxRdypLrWTkUx1xyqglDfKzbZ0oR1eKpB71mVtNmA5ePfo+aBXsKWeehIo4jwdfvqbNW/fB9bP5PUr76ff8GXeqqGrV/GPojzABXlWfmuiMiQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNTqr4gu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756975176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f0hzQ2a9v1Rzd23MMlpkQFgzttJOaFNChg5sTvJ96Kk=;
	b=PNTqr4gu79aFvt6FiGwK5yS/y48ieJTW1l9rTSUHzGh4kLlF7TA2jq3n+d1cj+jUO2s2+f
	0nrDPhKw7JTvb1e7QZKuC3XCir4LZdLARfoE/RR5A6v/bKI1lOvwTrIIz3P/ACKO+c3VDz
	vSZJRzb6FJ9gqBP+UTl8a6leqKFRQC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-O6wnz0DWPWatViAnWIY6jQ-1; Thu, 04 Sep 2025 04:39:35 -0400
X-MC-Unique: O6wnz0DWPWatViAnWIY6jQ-1
X-Mimecast-MFC-AGG-ID: O6wnz0DWPWatViAnWIY6jQ_1756975174
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3d17731ab27so606600f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975174; x=1757579974;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0hzQ2a9v1Rzd23MMlpkQFgzttJOaFNChg5sTvJ96Kk=;
        b=HDxVyOFnsizB+YuIdjAkAyzpx81sfrkU2s4o9wNAybUN2BLh733dX44Y8TIe1QQwVm
         aHjwVHTemtJJaxthIUXcNzgQEYR3KGxWY0eLQjpKVS1w2tN7O2GGeKsyo6fE1bWJPW42
         /g3HuuYRkLYjXECLPY7ZiNDZzjdkzG5EHUY/zZe5/KO7QpuWOPqPVf3eB4GhZkFJWtjz
         ski65oCojUXwacF2mjAZh4NdcUFMY9XRleVlrQHt2DXETEgQw0JjVgJV0J64QXRRCrIr
         2BOGGDiUUeNIPOfThoqzYVnik30tlRE3dBVBdSU+VCcM+5uRZ+icvodbjdKE5YODEaM2
         NJzg==
X-Gm-Message-State: AOJu0Yz0Aigi56cOJYwHhcsCoqMxRbOWxJzl5j3qUT6vUUFe+q40DmDg
	rsTs26K4TsIx6kKENoJh2xSzQYns5/Vpl6wEwCUC9kttNKj+DWv0z/g+ndB5DTThhElOJhZuz5S
	N++bRJWgLV0dePpFCxUlpZ21Ga75WnVumRhpCCipzxxAsPrEc/3z/vLDAvQQJLuum7A==
X-Gm-Gg: ASbGncuZr/zbrmqJd/Nr6I3muxjRsz+4c3ZgcBh796lH4nfbC6ziywn+TYrCagxUxWy
	WDTUDTUWYPa0ouN6iASLuZUX+GOvmIvIbt4WCZY3jYi9oJabqJcqzO/6gN5g7aCqPLdzdU3orkh
	rJUsNfCiROq9YnV3Yh8mmxy/N4q1LXHhKFySNF8lnZz5a0a0RWNstu0rBpt6hrtt5XR+MCN3sYi
	Np1iMSol5CTkQ0sxB6AQROuN8K0OTLafOFHZYBtB7+yjXhTkefS62imhXLsD59lPYtOuzzRD72e
	2E8oilYYwhxjXqc9dJc0raJ7DfbYQiS5AWiUGPBgBD7A1vF3+Sr/Ybykf77qgi88Bg==
X-Received: by 2002:a05:6000:4202:b0:3e1:addf:58f4 with SMTP id ffacd0b85a97d-3e1addf6672mr660503f8f.57.1756975173857;
        Thu, 04 Sep 2025 01:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZE7tSFnufedEV5cMkbNyKprnC3TYa8i/aOEHrDa/AD29kXH54pzkmGPOW9Qhn5Fp6F3/bOg==
X-Received: by 2002:a05:6000:4202:b0:3e1:addf:58f4 with SMTP id ffacd0b85a97d-3e1addf6672mr660479f8f.57.1756975173416;
        Thu, 04 Sep 2025 01:39:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d520eada16sm17982800f8f.41.2025.09.04.01.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:39:32 -0700 (PDT)
Message-ID: <a2813fab9089cf89d6ac60998abe4fa3f226d9d7.camel@redhat.com>
Subject: Re: [RFC PATCH 16/17] verification/rvgen: Add support for per-obj
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Thu, 04 Sep 2025 10:39:31 +0200
In-Reply-To: <20250904082054.W0fQJAQw@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-17-gmonaco@redhat.com>
	 <20250904082054.W0fQJAQw@linutronix.de>
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



On Thu, 2025-09-04 at 10:20 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:08:08PM +0200, Gabriele Monaco wrote:
> > +=C2=A0=C2=A0=C2=A0 def fill_per_obj_definitions(self) -> list:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.monitor_type =3D=3D=
 "per_obj":
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn ["""
> > +/*
> > + * da_get_id - Get the id from a target
> > + */
> > +static inline da_id_type da_get_id(monitor_target target)
> > +{
> > +	return /* XXX: define how to get an id from the target */;
> > +}
> > +"""]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return []
> > +
>=20
> I know this is the existing style that we have. But I think this is
> not something we should keep. How about something like:
>=20
> import textwrap
>=20
> def fill_per_obj_definitions(self) -> list:
> =C2=A0=C2=A0=C2=A0 if self.monitor_type =3D=3D "per_obj":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return [textwrap.dedent("""
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
* da_get_id - Get the id from a target
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
*/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static=
 inline da_id_type da_get_id(monitor_target target)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	=
return /* XXX: define how to get an id from the
> target */;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """)]
> =C2=A0=C2=A0=C2=A0 return []

Mmh, I see what you mean.
I wasn't aware of this textwrap, but what immediately comes to mind is
that we'd end up mixing spaces (python indentation) and tabs (C
indentation).
While textwrap may handle the case, it doesn't look too readable to me.

I'd say we can (slowly) transition to using textwrap here but mandate
having \t for tabs to make them explicit (didn't test).

What do you think?

Thanks,
Gabriele


