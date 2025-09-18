Return-Path: <linux-kernel+bounces-823536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424AAB86C59
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BFD588450
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498B1DF74F;
	Thu, 18 Sep 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtlC/w5o"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500472EAB7A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225080; cv=none; b=jFk5oU99y0+VN3E17ezaL1wK8+HFcziimuBCbPqmEhnBhWKaYVMtgkZYYo5q0sDll3e6QQWYz2hTMgljhXl1o2cerTRtmNEDi6XYVaxuaNf1c3aYWJalq5B9iju5gfBI7+HNldJxKPOmbXUUicPT/IIIyroc99iecnbiztqd2sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225080; c=relaxed/simple;
	bh=6syJdSpwOuKgxvfK6CJQXA1mo4R5z+GK0PPQjQL52Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YU5YEoQd16e1hfvPFQNeEWOMhC1u51f8yWSmp+0RqKx13656NNBJV0ykUHKgqd4wIUFfOr4Bte890ls2gdYDwdtw6L9Rw4MKCbpcl9a267+xlINfPvLdCaVbF6h5VUQkdlqIOX/Z6NAVrwibDnU+cdU2J8/G+M0FnIt7MLanARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtlC/w5o; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-80e2c52703bso134856785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758225076; x=1758829876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8krst8IwRhvi5nQ0njnzXjVOua4V4UJe+k0j+3GNts=;
        b=qtlC/w5o7oqOt5KSb8eVYY1qgdu3W7fm5pAqzP3WjBB5U7exzjiIZcbYBt0mm2kOxZ
         OIOV3SMCZF5x+Clo7Oafwv8CnJbMP2DICBWQuuv4WUo4My17i5uejgr7oqOl31kV6inJ
         1lEps0ZL4zreN8RteZmoMCipGv2TFW4VokO7tHk2Y5pPOSWq7DvlVVsHfsN9hW12BxTQ
         Ing7kEhgkMvZPosbxf75UJWJjWBbLlfRwtDNQGabgqrvmjNfFwEyD9ivpQA91ZqHuUI0
         DR5pTEkkFys3awuuAmviJb5LI0z4KBQPjaVmX1vex08ieXfUDxD+8YpBIC6Eqm5luwTJ
         wvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225076; x=1758829876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8krst8IwRhvi5nQ0njnzXjVOua4V4UJe+k0j+3GNts=;
        b=N1IGzECWBd+stfxFXRXBXvTL5GtNYoHdF7PQTuCr680aEvap5lJWQvQO/JVp2bGJI2
         4ivsIY1Z2JzvugwUda4l6m5sEq1nBceSlDqA+c8ugQ1pCIcggwb5/TrBPbia+f1Slhbs
         AFkf3S5Qzq1UD1pieLcod0TN4fI0Qg2ovQwTQFnyM4TZmvv8yAq1ekuVJ/WfRrlpBKeT
         OGp0fvJpOUeFDFkPxywfSh/ZYYnepU/myasZBFDX9/WMVQQaPu012Obcz3BxmVx2pj27
         sgIQpJuI3R424KOZh4F40l8Bapvzw1C55WVWY/BHeVimLsRliFCqgSSmjK8s6HrPq7+j
         2sSg==
X-Forwarded-Encrypted: i=1; AJvYcCWktNJai+PmvUkkpruhYIvnAfrEVhvqodbbjdWxCP5dCoc91o6oXa2qhDI5kiwBp4WBSxDzCGHtmA+jU0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu65iZfnMfrp0hCxhUsrsz4gjC9kStx2TwP0UOVTGRtL6dBl19
	HHSUwXaHjqi4F2mwHHEuUEBjlsH0uOor3L0zCFoI6ZbR66fKbWP1cT4m19yaCo78VHcNOVADe0i
	TFvT/NsjNkZ8+gu3ze0AKYawMoEEJAXWBtBmilKWB
X-Gm-Gg: ASbGnct45lSINziTYmJ8XLlfEN6hQhTW2RM24nR9o1eLATNTmfaIObaUqvYIRPb3xEm
	/fdZZZaTwOio48nhuTkeAyXhLm7v6Dw0uIh5x8IYGjGC4YcJB7XnxIuDuwhcN8EpSZu6gbRMvtz
	vzfsehL5IwXh072We7aNhfRlfRlIMZ03qQKjRrdZq3UFEmzY3VbC56uZ1HWhQfZefGO6j9G486Q
	eqYQBrDkGTPLFF4pwHMieNx+OXarG4XkGOmY8u9mZ1HL0jBVf+lX3RJTMWLS+4=
X-Google-Smtp-Source: AGHT+IEBRicdafJf3u77ctjkGg0qQE01vvq76y8OfmUEZq9l+r7vlVJkRpkH6O+HQWrp9aS+8G9GRAXwfO+KbOCqR1U=
X-Received: by 2002:a05:620a:2615:b0:82b:15c2:509 with SMTP id
 af79cd13be357-83ba29b6776mr106004485a.1.1758225075919; Thu, 18 Sep 2025
 12:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825203223.629515-1-jarkko@kernel.org> <aMxV9fB0E72QQY2G@earth.li>
 <aMxZlHn9bfa5LGEU@kernel.org>
In-Reply-To: <aMxZlHn9bfa5LGEU@kernel.org>
From: Chris Fenner <cfenn@google.com>
Date: Thu, 18 Sep 2025 12:50:57 -0700
X-Gm-Features: AS18NWCj6f0C0cTQbPavL2yzofztQlVPZRuus3lDO36bJFzWpZEEGANZWXKMSrk
Message-ID: <CAMigqh2gJ+ALqxb8RcNFENJg-Z0FfKE2DZjaGdOER7G3AGZvKg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Disable TPM2_TCG_HMAC by default
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org, 
	stable@vger.kernel.or, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed, the feature needs some work in order to provide meaningful
security value, and disabling it by default facilitates that work.

Reviewed-By: Chris Fenner <cfenn@google.com>

On Thu, Sep 18, 2025 at 12:12=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Thu, Sep 18, 2025 at 07:56:53PM +0100, Jonathan McDowell wrote:
> > On Mon, Aug 25, 2025 at 11:32:23PM +0300, Jarkko Sakkinen wrote:
> > > After reading all the feedback, right now disabling the TPM2_TCG_HMAC
> > > is the right call.
> > >
> > > Other views discussed:
> > >
> > > A. Having a kernel command-line parameter or refining the feature
> > >   otherwise. This goes to the area of improvements.  E.g., one
> > >   example is my own idea where the null key specific code would be
> > >   replaced with a persistent handle parameter (which can be
> > >   *unambigously* defined as part of attestation process when
> > >   done correctly).
> > >
> > > B. Removing the code. I don't buy this because that is same as saying
> > >   that HMAC encryption cannot work at all (if really nitpicking) in
> > >   any form. Also I disagree on the view that the feature could not
> > >   be refined to something more reasoable.
> > >
> > > Also, both A and B are worst options in terms of backporting.
> > >
> > > Thus, this is the best possible choice.
> >
> > I think this is reasonable; it's adding runtime overhead and not adding
> > enough benefit to be the default upstream.
>
> Yes, I think this is a balanced change. I agree what you say and at the
> same time this gives more space to refine it something usable. Right now
> it is much harder to tackle those issue, as it is part of the default
> config. By looking at things from this angle, the change is also
> benefical for the feature itself (in the long run).
>
> > Reviewed-By: Jonathan McDowell <noodles@earth.li>
>
> Thank you! I appreciate this and will append this to the commit.
>
> BR, Jarkko

