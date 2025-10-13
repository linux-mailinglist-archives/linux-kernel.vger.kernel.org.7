Return-Path: <linux-kernel+bounces-851480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42863BD69A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEDD84E0EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00022EFDBA;
	Mon, 13 Oct 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MrOsC5OA"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B72FDC29
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394082; cv=none; b=KzBEhApWK9loFNPVnuwKQIKJOXLCv6rwyJ76ieTTiXZGQ4nHZRyAY5o6vPPZmuAhUBiW6FjJsZPEJPnBJIOCxqENZrc+dNrqpMPl3OocwxY2NhSSGgTYHMdOWE0Q6IhgHIo/3dCj+yjL8DhJIXyj+hPwGf0CoOPC+v04em90YTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394082; c=relaxed/simple;
	bh=U0b2FYuoZRm8Pxjx9RsW+UXje4fkTM4H5iZ/bJSnheg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcFkEgCbCkqXRnhN1+ebTz77+1i0ZmvmGJOlUc5TGRqVSlMAR9fh0NUzBqRutpV2zOAQHGHBpf9Zs298aJlzuMipf8xYcq+UKucSn92C0ZD3gscJUVSaVtFdWg/D1lKasf0mGfXQA2oaiso1KKK+P1dAxTTRZ3//uWVEWwg8Ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MrOsC5OA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3322e63602eso6298054a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760394078; x=1760998878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QrVvuzGQFvU0hfzvyeDbWGCHPSfPo8gC4N1w4Q3nkM=;
        b=MrOsC5OAzJ9IRIPCe2MDCDZflQ8K3EN6TvxFg7ODB44iqeYyJnyghqdlXvsmZDWe81
         uoma5nCK41up70cN272rGONwApj8becxErZze51Bw/H4tAgmHvS7/X8Rlq/y35BCb+eM
         QN6SBJUl+fUkdBJQjqZKqUk9esZVpiepRm1zBRNOASnU/boPWVgdKub6T8fMh15HOLRj
         wb+tWmfdZ3bv+fnzgH4XrXgi1a9uI4/onnkwhB5VPUzsoe6Prdi6flsr9cri1UNdFeXW
         4/S2nIHfGAArwTAzLmDcSmcsJihezWZ/RtX1uC16lpsVGqlywPpCdcVUNoXI0YSWYe0o
         ocAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760394078; x=1760998878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QrVvuzGQFvU0hfzvyeDbWGCHPSfPo8gC4N1w4Q3nkM=;
        b=YzS8U4X+3efaVLdA8CLSM9uDaaTfNIpM3eFx2UVfwhlBndNggYKV1jK4pXyX1tEz5t
         Oh5/P2vrdbEKD4i2eppQqcTDAeSNEtz5p12qg/comQCf1Zp18uTsT0emU3v2f1zxFGgN
         tp/RML+Ma8KtAXfU3qCmN+SE0aXYW70ysp/VRISKw9zKKKamlSWjzUzRec3vHd6wT8cW
         Y+aZs6uB7dMAf6DaU/aMC7d3KJFH0ZCk6Xz+U6DlIJPF5aBOFRjpwqG4bKWB6ZzpAeKc
         wE8HzcpXsUhpMmZIPYZJGAFoa95Shv9xeo8m1j5vienp6AB+yg+bfGdfYfUucuyiDaLZ
         +TuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGddcUBWfIwhmvr0s/16Bwc2+9Sye2zcQmbyOh2p0oennQvGK3mB8pIfXq4tQLUpLmGXgnOb+2OJZiOGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4V7CNo6tJnK4C7L3jRXExZoQyxml0x26URCccNWxMhHxnDoU
	3xVLwze6C1gpKBOyALnMbDLMny9ilLLzXSMmTXaUQJ53qaMdpxqHATz4wHIZGb1HCbrDTiHIGAL
	xyNZN48EXmVbkdW491+gxOjh8eCmBh7R4ppDoRN9s
X-Gm-Gg: ASbGncsTENXPuQLJ6jeJohNjgyzVP11TG4kfuKelDD2J8U9pVPovgkEqGyCstZ+cTqN
	wzL8jtHa8gaa1C/CoXw6p6op9ao5xeKM3i4KKTLvHB98odpSrQTOzH5p/fWSSz4zI8wHYeDAibU
	/QjchHqmwq0yrP5sL8OeL7Mq1eTfD7yrDBjknDSO1ml00y3f8U8E+Dei4+9UqojZFQqenMmTImu
	dh7elYQmv5jhjeKplCap6gmGd+v9Bo8+PsS
X-Google-Smtp-Source: AGHT+IGJj6wfIA3JgS5ivMxkaZ5cevk68TDvGU+RjQzOwOxB3VAdgwaSKuY91BI4oP64o4zu3+KGLQrIUftJOPtxttI=
X-Received: by 2002:a17:90b:4a52:b0:332:84c1:31de with SMTP id
 98e67ed59e1d1-33b513ced6emr28514559a91.25.1760394078550; Mon, 13 Oct 2025
 15:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-3-casey@schaufler-ca.com> <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
 <ec89959d-c3a0-403d-bfb0-7405639eb0cf@schaufler-ca.com> <CAEjxPJ5N+vGS4rhBJmCfoW+rUnjPm7TVAC9reRmu6YCaJWTO+Q@mail.gmail.com>
 <01879779-d529-40f2-8693-257cc598dcd7@schaufler-ca.com>
In-Reply-To: <01879779-d529-40f2-8693-257cc598dcd7@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 18:21:06 -0400
X-Gm-Features: AS18NWDHyfSLp4xj_ujKY48qVsLCMXrHD6EmUTyrztEFvgCIwupjgZrcRdxU_X0
Message-ID: <CAHC9VhSBxhiTvxPpHHqZJygDTTuMWOPFpQcoMSsvZD6Bueg0ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] LSM: Allow reservation of netlabel
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 5:11=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 10/10/2025 12:53 PM, Stephen Smalley wrote:
> > On Fri, Oct 10, 2025 at 11:09=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 10/9/2025 11:53 AM, Stephen Smalley wrote:
> >>> On Wed, Oct 1, 2025 at 5:56=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:

...

> > But some security modules may not function correctly (or at all) if
> > secmark and/or netlabel are silently disabled on them, and the end
> > user needs a better way to express intent.

This is the point I was trying to make in patch 1/2 with secmarks, but
Stephen has captured the idea much better in the sentence above.  To
be clear, the argument applies to both secmarks and NetLabel.

> I'm open to suggestions. Would boot options lsm.secmark and lsm.netlabel
> be sufficient to address your concern?

No.  Please no.  We already have two LSM initialization related
command line parameters, and one of them is pretty broken and very
confusing in the new world of multiple LSMs (as an aside, does someone
want to kick off the work to deprecate "security=3D?").  Maybe we have
to go this route eventually, but let's keep it simple for right now; I
don't want to add a lot of user-visible APIs for something that is
pretty niche.

If you absolutely can't live with the "first one gets it" approach,
look at the no/wants/must idea in my patch 1/2 comments.  It would
require work in the individual LSMs to support it, but I'd rather try
that route first.

--=20
paul-moore.com

