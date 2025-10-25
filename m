Return-Path: <linux-kernel+bounces-869748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F6AC08A6E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 05:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06C7189DEE1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 03:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084025291B;
	Sat, 25 Oct 2025 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iys64O/F"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A372580E1
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363487; cv=none; b=HiDQyMPHkRVDRBQLCDTn2/LrzOk7DcyvlP/vlP0AvMQLEF+3ZU3oxCCHjyBv2J4tSaRvNBW05IUysYxfPagDSE1asdT6ChF/D3a5AirU8JKFvKGXOx1LlUrvofX85y9tjiDFPyFa5A+UBvBc+0QifyEIv5fWqkQEdWnKjaLY8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363487; c=relaxed/simple;
	bh=MSm2STsu1OScM8I8RvJHx9e3rLug4XaaM/vb3Ol9s60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LQupshzLUlFHLuyDfnkKfR6fzy9Qy9fDImpTobw3t0shEOXD9MqB6gWUO6dAImu993lgpr9srJ4B8uGitB62sh/Zanstb/DoFdoYD1Z4/+HZYhbrt9HYDLhVz1ebHH4wLbx/n/8LG7y41y02wQbmHtgbS/7P7fEQsCYi8GmQejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iys64O/F; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7811a02316bso2039279b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761363485; x=1761968285; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S1Rr+XG8pIEaWKzksED6IwpW+zljJmMqZaZf6Zprc+w=;
        b=iys64O/F4mQuebS3Oi+x7l6v3cFgWqKxXzAF4F5SALobiA3irVDorlkFair0ve58g9
         2DHdlNZljD9+jQn6FSMlrZdDyFKPc3idPeUNf57zhbeLqvu4oSWmTd58SBE+rV6iQU56
         rz+ilOdO40NyZrqVgztIYm0iipmVJJp0uMepfhyK8lL93RMlkuKzmS0sK0E2XldOhdhz
         19SyHSPp6VBhr0/GS97ORiY361318ZlM64FkhvDJ9ppevNprm7lSvA7X8owTWltPKU/n
         DnRNGJzltCetad07+t9Qb8SfvspKHZfEAR/WrG2+jOiHFVyBpJCgmbdOWp1Q0ewQTfUg
         9KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761363485; x=1761968285;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1Rr+XG8pIEaWKzksED6IwpW+zljJmMqZaZf6Zprc+w=;
        b=hCCIFeghW8pPZxVtMyQHGX7BfZffWi/VIyOPiQqNlYl50FLnAUzLGay9gSDgLtMTAy
         ynB8h+BwfKlikvZRVc92KWCGSNeoXLLnTR8P9iMUtZtUfo8vB2Joz+LTVyXGltiDfEMP
         BHvDlDj0/DOiiiNDLm1C5A1EfYoTLCL8719fnKsYOVjEThEN+wV5rTYrWnedZkRe+SUT
         k3n2Vubd2y0kXVphkxsnYtTEORwelnX3OrwPeITxYNAuD0HjiP2w7o4FfrWXKudeZVzM
         CnUrtyKXe5Bs5VOTVhHmkD4m6TIgp6UDSDhAfbksbRY2NW1Daz84U8D3lS4bq9+5NxUX
         nVgA==
X-Forwarded-Encrypted: i=1; AJvYcCVKf7fMxdOhk8fgeILV/artqLiBE5NrJGyP7Jry5Y/lw3Hbkn8PmYv2EtOO37xYmjm/9aV0tAwR0pY7Lj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ofu6Z3r/xhL1G7OkxAyWiCjxMZjTLR3rcJtO89qzGLVMXeIp
	Gpd4glpGWdiebktjae0fR1n0HB90SbKf07M0v5lehXiIkWcSDTbz4WUN
X-Gm-Gg: ASbGncv5dvc1I0ZexgJOIlIv7vrUcDObb4JlN7SQfpBUOt7VbkkQrxwdnQdntlB4jkL
	wI9QklL7wYD5yMwn2Nah4kNGaNHO8G0Pd7FDSXFk28geTept3AzzIZOhJfGcADvIexfPmtRMSyw
	QBMizf+k6LgsQi49KvDp2f9qG4SYRugzds1ohKp/W3wc7XZdCI8UKwE8LL1sLGqURZxrIzN10Tk
	6C/TJ0BM7svfgAWeXsi1EG3MPcwScg4twHGa+Oc5sOrOt6MfknbeNZUUeBC/G1KmGi+26hjvSQA
	TV7mJUkfpsq1pxuWlVNG9345rOXYCn9Ote0y1gtGs8z4b2tCQOPofE1kX7O0vAdBQTxah336amT
	uBHlGSy5M6m072m/qooOjrrglJ7XmiXMp8h3Pmn3JBEDJEFlvhmox45vaHW9jICBel0UYdOd30c
	vI6x4o1XLWLWgOT3kdQ1FVF2azsPvvEyA/+jEDotx4V/5sYqsiwMOCI2fN5mY=
X-Google-Smtp-Source: AGHT+IGlVmEr+KV8oVMLrPtqVKsS5HLztOHi6CRyrI4of7GV5Hke4rtw1iz5DMcdL32dqz1/HUS2Pw==
X-Received: by 2002:a05:6a21:6daa:b0:33e:6885:2bbd with SMTP id adf61e73a8af0-33e68852da4mr4208699637.40.1761363485250;
        Fri, 24 Oct 2025 20:38:05 -0700 (PDT)
Received: from ?IPv6:2401:4900:88f6:d7b0:fede:e287:a1d3:d967? ([2401:4900:88f6:d7b0:fede:e287:a1d3:d967])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdb2dsm745571a12.5.2025.10.24.20.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 20:38:04 -0700 (PDT)
Message-ID: <66575ceb29493f3b9c5b8bb94f4f66bf21d53211.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] checkpatch: add uninitialized pointer with
 __free attribute check
From: ally heev <allyheev@gmail.com>
To: Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Date: Sat, 25 Oct 2025 09:07:56 +0530
In-Reply-To: <026a32413b0c9e4edb5d3ab411d18134078430d8.camel@perches.com>
References: 
	<20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
		 <20251024-aheev-checkpatch-uninitialized-free-v2-1-16c0900e8130@gmail.com>
	 <026a32413b0c9e4edb5d3ab411d18134078430d8.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 11:14 -0700, Joe Perches wrote:
> On Fri, 2025-10-24 at 22:59 +0530, Ally Heev wrote:
> > uninitialized pointers with __free attribute can cause undefined
> > behaviour as the memory allocated to the pointer is freed
> > automatically when the pointer goes out of scope.
> > add check in checkpatch to detect such issues
> >=20
> > Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@=
suswa.mountain/
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
> > ---
> >  Documentation/dev-tools/checkpatch.rst | 5 +++++
> >  scripts/checkpatch.pl                  | 7 +++++++
> >  2 files changed, 12 insertions(+)
> >=20
> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev=
-tools/checkpatch.rst
> > index d5c47e560324fb2399a5b1bc99c891ed1de10535..1a304bf38bcd27e50bbb7cd=
4383b07ac54d20b0a 100644
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -1009,6 +1009,11 @@ Functions and Variables
> > =20
> >        return bar;
> > =20
> > +  **UNINITIALIZED_PTR_WITH_FREE**
> > +    Pointers with __free attribute should be initialized. Not doing so
> > +    may lead to undefined behavior as the memory allocated (garbage,
> > +    in case not initialized) to the pointer is freed automatically
> > +    when the pointer goes out of scope.
> > =20
> >  Permissions
> >  -----------
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..1009a4a065e910143dabeee=
6640b3b3a4bd3fe06 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -509,6 +509,7 @@ our $InitAttributeData =3D qr{$InitAttributePrefix(=
?:initdata\b)};
> >  our $InitAttributeConst =3D qr{$InitAttributePrefix(?:initconst\b)};
> >  our $InitAttributeInit =3D qr{$InitAttributePrefix(?:init\b)};
> >  our $InitAttribute =3D qr{$InitAttributeData|$InitAttributeConst|$Init=
AttributeInit};
> > +our $FreeAttribute =3D qr{__free\s*\(\s*$Ident\s*\)};
>=20
> If you are really suggesting using this, and I don't think it's
> particularly useful, please use
>=20
> out $InitAttributeFree =3D qr{$InitAttributePrefix(?:free\s*\(\s*$Ident\s=
*\)};

Thanks, I'll check it out

> > =20
> >  # Notes to $Attribute:
> >  # We need \b after 'init' otherwise 'initconst' will cause a false pos=
itive in a check
> > @@ -7721,6 +7722,12 @@ sub process {
> >  				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$her=
e\n$stat\n");
> >  			}
> >  		}
> > +
> > +# check for uninitialized pointers with __free attribute
> > +		while ($line =3D~ /\*\s*($Ident)\s+$FreeAttribute\s*[,;]/g) {
> > +			ERROR("UNINITIALIZED_PTR_WITH_FREE",
> > +			      "pointer '$1' with __free attribute should be initialized\n" =
. $herecurr);
> > +		}
> >  	}
> > =20
> >  	# If we have no input at all, then there is nothing to report on

