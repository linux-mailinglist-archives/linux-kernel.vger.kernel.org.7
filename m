Return-Path: <linux-kernel+bounces-851370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC5EBD64C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BA6406621
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1005C2E2DFA;
	Mon, 13 Oct 2025 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O+UyanCS"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893E2F1FC2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388949; cv=none; b=uanOoH/tDrAOGzMb7P1WUpx3vAVPTkD6xlCY8f1/yEHajXDGRAoQc4OXmPQ98a0f4wucMhbXsbeUnph26GeRtjuC3ZUQa44Zjcbp5qixfj9PGumrxodViL5IGKvc1QDzvj/kC117jGbe1n0vi5N78gU/PN3hlXEz5hgHxspg5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388949; c=relaxed/simple;
	bh=gDYIsGZJNtpz85UGGORoVa634/GqJuKrEvq8/6pyYD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsioJH0IOc+GGVLHYIXirg+2Zp2CvpydiJZ1GHlh4UzTRSr9EUN5jePE30X0eYc/Izun5TY9xti+ybvQXYS0vpOTRIZxU9tm7UoyIy2rJEOTbF0mATscJxRZuDUJMXBCfiMYoTWNim/85JzTSNa68lTkRvBoWTyy8XRErzil7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=O+UyanCS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-330a4d4359bso3872009a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760388947; x=1760993747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RDNpZAyhwqcckigDtVfOVuYTuSUKS3TRvIv4aY4DWs=;
        b=O+UyanCSQFWA8QndFiHUonQfLD97F4UplMUx26OOxzdNUyK8VQWf+erRmFu7Dy3Sui
         NHebMdt19I2HyRYe/0jAJtARWwHbtB/A+frLu1OpSwXZ3MG824LUv+XqQRU5wBmPRUTp
         1Imz5QF5LGYz6OI52/86EenXOGn5h05YpnZWX99ODPlt4yZMXWc0PkyN/jWU3qatPuAq
         I4IzHvAgy5PtvarhBHvXKHDfI9/qHRTtMR3k3Rhlj4EYWIjcjIcX2oZqW+kRHcpuDlO0
         4IJrey4Y7Tf4rnQGDM79wXgYdKWlBymf4MCmwj8Wa/F/w8IGNGNGL3g1DXToqHxV+Bwh
         Gt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388947; x=1760993747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RDNpZAyhwqcckigDtVfOVuYTuSUKS3TRvIv4aY4DWs=;
        b=ALzEG19wtX2vzIoAdB6R0oKeomrITXmBaArEjuPK4WTeQ4xBywYl5ge9BYtifXGLq1
         /XmsCiIbXehSqmxBl8VzgRf80Edu9yYGVvgrpUJn847A/bhkdJZ5KZUFlrgsbYIRfAGn
         S/loLPAz38TjIjYIHYbmgB36wNAhXEMRdAQRXYe4C6XCT7uIXaoRTEUFRlPpV+VQSc8Q
         rMnrN2NNQFIXFTdpIOb5z/OGwLwmmLMc8Q6Zdk6MH3mxR4SO6x833gF9RaX9vQ6MqJQc
         e4sYTrw0PdLXxgJP2r2PB37C/7XAnvWWSrBCf5+MKEL3CdR5j7Ya09RI1ghpv62y5Lny
         KFZA==
X-Forwarded-Encrypted: i=1; AJvYcCW3aMnQZO6w4N8GKVuGDXtycF437+bsF1YgsWpQHFbUReW0pHNRKVqQ/3WLmq+nxZ51Hgi8CGph9rXdV58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrW2963S75N9QLu0vbaYalVHPuFKVGHN/IGQSg4CiCLBQfuqGB
	RMlsQ/0R43TOUX8K8GRWtELHre6sEVm8XGkhpe3GH/w15i1hSd1ANcbVHoqa4Lt0qJaZBr7xrIT
	OhmgFWBEAvI3Qd4hryBXh/zuDNCLsPTwNhwAHZmyR
X-Gm-Gg: ASbGnct3WVF2iii7qhLbI8pZJ6KYk1zwk+fzyjIkEdh2YMAhuL2WlBogY0YMf1n01rh
	bJeqe2ncbSF8+jR9rJVTnhrvUZt08hWGxNcHXAhHOU1yVvwF28Qef3OBa9iqgj92RzUtrGd2/mD
	/yxaQZYJGfPvbTpo7FJNgW3JOG95Rcoym0qOHATZumGIcbCWdTqrrMiQ8rCoO/r32+P/pG8iG8g
	ejKeI0qtS8l4DWSMl1MbtamGAEyC4AzfMpSEvLW9WiAlB4=
X-Google-Smtp-Source: AGHT+IFqAomyulxKG8LO+DgQFeLFDPy+KFQmqr2wqA7gA8PG1OfLl0aF1pmvG9L+PEXZ8/496jeCTHuT+POsXuT50tg=
X-Received: by 2002:a17:90b:3ec4:b0:32e:51dd:46dd with SMTP id
 98e67ed59e1d1-33b5116b782mr32102690a91.16.1760388947138; Mon, 13 Oct 2025
 13:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925171208.5997-1-casey@schaufler-ca.com> <20250925171208.5997-3-casey@schaufler-ca.com>
 <CAEjxPJ4D7A4KDF9BfmRa9VvzcAHBkkrdKCvmGazuZUto5=qDuw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4D7A4KDF9BfmRa9VvzcAHBkkrdKCvmGazuZUto5=qDuw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 16:55:34 -0400
X-Gm-Features: AS18NWDkJN7A1rvC66jbpLrd01lw_5s8wNzGOHMHaR2wj-KW1Eukad0lJzueb3o
Message-ID: <CAHC9VhSRGyMuTYxP0nDpXv_MwvNqVsrBXcak84AGHj7ycDtu3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] LSM: Infrastructure management of the mnt_opts
 security blob
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, eparis@redhat.com, 
	linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 2:38=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 25, 2025 at 1:12=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > Move management of the mnt_opts->security blob out of the individual
> > security modules and into the security infrastructure.  The modules
> > tell the infrastructure how much space is required, and the space is
> > allocated as required in the interfaces that use the blob.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 4bba9d119713..1ccf880e4894 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -656,19 +651,13 @@ static int selinux_set_mnt_opts(struct super_bloc=
k *sb,
> >         mutex_lock(&sbsec->lock);
> >
> >         if (!selinux_initialized()) {
> > -               if (!opts) {
> > -                       /* Defer initialization until selinux_complete_=
init,
> > -                          after the initial policy is loaded and the s=
ecurity
> > -                          server is ready to handle calls. */
> > -                       if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
> > -                               sbsec->flags |=3D SE_SBNATIVE;
> > -                               *set_kern_flags |=3D SECURITY_LSM_NATIV=
E_LABELS;
> > -                       }
> > -                       goto out;
> > +               /* Defer initialization until selinux_complete_init,
> > +                  after the initial policy is loaded and the security
> > +                  server is ready to handle calls. */
> > +               if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
> > +                       sbsec->flags |=3D SE_SBNATIVE;
> > +                       *set_kern_flags |=3D SECURITY_LSM_NATIVE_LABELS=
;
>
> This seemingly would produce a change in behavior for SELinux.
> Previously we would only do this if there were no SELinux mount
> options specified.

What Stephen said.  I think this is good work that needs to be done
(thank you for doing it!), but we have to preserve existing behaviors.

--=20
paul-moore.com

