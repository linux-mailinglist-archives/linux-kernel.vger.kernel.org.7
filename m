Return-Path: <linux-kernel+bounces-751915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130E7B16F45
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CD9624319
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839DD19066D;
	Thu, 31 Jul 2025 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEu9pQTl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A82BD028
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956852; cv=none; b=q1vRHEMxKLM9LWChLQcvghuhqr5dvV+6W9o/nG2mBQZj4fuPFrsWKPX9uagLJbkxr2wz3z0raWldQ5tphuXzL+kH2TAzwi34y2emhacbRqCP5NdosgBjl3fQIb+ran6ycE6mJ+Pidis6vrHGdyowTzlsq6b/d09OKY/6ymTVgNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956852; c=relaxed/simple;
	bh=Zzys3oDX6nnVMWahhtIHkbjUttylZL+Pdd1jNHENB2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vC3XR2Dwk9iM7c7exTDxKs/H1LezdA5zP95kocBsJUUa21vqdFoT326d4mDydSm+Www0r5Tl/0NcNPJCIV3jFB+L5HrQTwUC28nJQYZUDqq8fCOQdJrh0WoXlhRJJpyU4DsXUdXvv6yEJjJ1QB5ntKhmzCeRn5HOCXLxaXumbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEu9pQTl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753956849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8+Updhps2Tis0Qkn63kABOeQ6kuHwuPfHE7bAxmojdA=;
	b=JEu9pQTlcQ+ZSZurmIsjWrg0Yrfml283GVGFAk/X+/odnSU8LEDYOIduPecK0tCvvBD+01
	G2avALmNTU35OKScZMMRitlBOpVk0xhPa3YJU/w55WilTkfpoSXlDXCTGzxA8Nag/QZ/Kj
	v+SpC5/+weF3D2e0nSxr2SNrrQfdUg8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-ENa559R9MbShC1KTHWs1Bw-1; Thu, 31 Jul 2025 06:14:08 -0400
X-MC-Unique: ENa559R9MbShC1KTHWs1Bw-1
X-Mimecast-MFC-AGG-ID: ENa559R9MbShC1KTHWs1Bw_1753956847
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7882c0992so455404f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753956847; x=1754561647;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Updhps2Tis0Qkn63kABOeQ6kuHwuPfHE7bAxmojdA=;
        b=DKiIimXBlI1qsOuGBHcCBWmWtNkmXlHLMBNMEGHMsmnvutdfOFtqdewqLcuFwGbHle
         I7dELbdRpkHr5ZRsVd5esUkGiIpMEFpODd0v2HBelCzjmibWoxOQSevwOAq3AfQsBYxL
         suGimYZtyT38NmzmwFQ07ETFLlNOHWjN5SjLXhyz+cLhEzNpJiTwubmftYfSgPoZFtys
         RvmhUriw7PZIYHQ9db5ruDleE12s1h2f04la97BxrxjusJcDtJ9uk0ldWY/K9gxIfZSY
         ChYzmfFJZqk7k6SrMJbaP7rmGY/Ux92ApuyjmJdIWEgWHcjPQ+3+ZsXRoEC4Bq3GZroc
         rgOw==
X-Forwarded-Encrypted: i=1; AJvYcCVLl3ypXC8XdHY/udJhs55/3VgHaVdJefdaaYxAOgl2LMlkyNMRG+mvRc0wget/bu0nW7CCxtufDRV1aok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcLs3/WXvuELgzZzUjJSswAIcHveRiShHyMEEFystidJ9nqMC
	+IhzijFtgkzjnEP5FMhvRYve+0zp1Ngam6E8Iz4noeEKaeRHXJgcPzt/JQkqEEvxjywIi+sbnz5
	ygXJcy7IijoDI0V8vVb1LGU8/ZluR5SbNxOlm0quzJYPZ6NckEzkuKustqhn9InoUoxSKkCBhcG
	Za
X-Gm-Gg: ASbGncst8IzjCzCI31ebDcIM67YFqgNWBK/57Cw2/qbWGxkhqd5j/mSeGm4sX8mCWkN
	9Ij82p7miJkvY/YetbcjKUDjGodHTZJuLJv6AdlPuJETCtMSl92WjMobelfcGx34q7GI1v5Ibfi
	faolra9xyRYw7xlMLdi8nq5eRRSIVB/WMt7cEqbQgjVfm6+SPfC/LfqVEGEb38KxI4EiGfu5MD4
	DiPFMZLhThNv9QN9JePW0gjvn3byjHwJoRu5r0KXDi7GwizvH1rWobbVqjz+i2dnRyfk/r96nWL
	4RdhTGATFC/S4bvFw10yzcfoLhp31YHBt1AgHcITpBAzy/mdAq2fUcWw7nHDwRe7iA==
X-Received: by 2002:a05:6000:24c2:b0:3b7:930a:bb0d with SMTP id ffacd0b85a97d-3b794fd5d30mr5137412f8f.20.1753956847003;
        Thu, 31 Jul 2025 03:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+UBjxbRY7BvJmpX5xfoZYctE99KGpaavtNC5flkCkpYfIj5dzBaODgml3EnIDnCnFk50qEw==
X-Received: by 2002:a05:6000:24c2:b0:3b7:930a:bb0d with SMTP id ffacd0b85a97d-3b794fd5d30mr5137381f8f.20.1753956846474;
        Thu, 31 Jul 2025 03:14:06 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453c75sm1925032f8f.41.2025.07.31.03.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:14:05 -0700 (PDT)
Message-ID: <88f589e09328b907ff2dd3e58d1fe4fcc09dbb3c.camel@redhat.com>
Subject: Re: [PATCH 1/5] rv/ltl: Prepare for other monitor types
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 31 Jul 2025 12:14:03 +0200
In-Reply-To: <20250731092805.EjcyYi0M@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <0d13c61bc6e0dc82108995c9a1d140bad4082039.1753879295.git.namcao@linutronix.de>
	 <adeb68b39e8b468da685bbbf3b453f947fe2336d.camel@redhat.com>
	 <20250731092805.EjcyYi0M@linutronix.de>
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

On Thu, 2025-07-31 at 11:28 +0200, Nam Cao wrote:
> On Thu, Jul 31, 2025 at 11:04:44AM +0200, Gabriele Monaco wrote:
> > I stole your solution to get rid of macros for the DA as well
> > (might
> > post it after this merge window or with the next changes) and I'm
> > currently running with this:
>=20
> Nice, glad you like it.
>=20
> For global monitor, you could do
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 typdef struct {} monitor_target;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 static monitor_target rv_global_target;
>=20

Well, implicit monitors (cpu and global for DA) don't really have a
target but I'll probably be using this for other types if necessary or
in case I'm unifying things. Which might be nice, if it didn't require
modifying all per-cpu monitors (where CPU is not passed because the
current one is assumed).

> I didn't check clang, but gcc does not emit anything for this. So
> effectively the compiled code does not have the "target" parameter.
>=20
> > diff --git a/include/linux/rv.h b/include/linux/rv.h
> > index 14410a42faef..6a7594080db1 100644
> > --- a/include/linux/rv.h
> > +++ b/include/linux/rv.h
> > @@ -13,6 +13,10 @@
> > =C2=A0#define MAX_DA_NAME_LEN			32
> > =C2=A0#define MAX_DA_RETRY_RACING_EVENTS	3
> > =C2=A0
> > +#define RV_MON_GLOBAL=C2=A0=C2=A0 0
> > +#define RV_MON_PER_CPU=C2=A0 1
> > +#define RV_MON_PER_TASK 2
> > +
> >=20
> > The numbers don't really matter and you don't need to implement
> > all, of
> > course.
>=20
> That makes sense, will do.
>=20
> > I'm not sure how are our patches going to coordinate,
>=20
> Let's just post them. The one whose patches are not applied first
> will have to rebase. It is a trivial rebase anyway.

Sure then, git may be smart enough to see there aren't conflicts.

Thanks,
Gabriele


