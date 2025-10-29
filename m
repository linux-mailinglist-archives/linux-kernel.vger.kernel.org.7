Return-Path: <linux-kernel+bounces-877124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FE0C1D42F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A23C4E1DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A39363357;
	Wed, 29 Oct 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIT8FZH5"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81735A927
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770667; cv=none; b=elVrqBf0qK/W34XS9i8Bbw36L3ZzUX7uI37rdOYwJZdv5H2n2pMpgJz33dzNmB/awJLaavKAmZL2j4EuCV879ShC9rFP/PtCOzLajUfxhdcXZTNhf3cseMFwSUKC4NMepDL4ugwPfw/cM5xZYy5KfQDJkO8Tkfh+8VY48NuAhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770667; c=relaxed/simple;
	bh=/nRyrHH69bDwdkUwV+ZvUiMlkERSxLC5qY0L4yNkpAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqKO2JP02B/6FvE95ncwlphdP9HlRDeoh3rY1DmUiClj7sZo4g0X75mH4GlMiqnq2fVXJ3kOA2khUDBGwn0gE7LTsbpyeOHIUc80GMhygKKOgHbbLKvv7nC7fX7fDJmYM97nLsiI55lYtnXYXxeAG+FLpKYXdbiA60YwtX3Km0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIT8FZH5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-378f010bf18so14819071fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761770664; x=1762375464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nRyrHH69bDwdkUwV+ZvUiMlkERSxLC5qY0L4yNkpAA=;
        b=ZIT8FZH51950wDS/bjbvoKGOA8qhHonV7KO9v4ASHE/9xRn3ynMtghPFcpBjOistJH
         2lDJC8qO5e33qWIzdICHnbPQyQbleSTxhRTXXmBRLGOGCyZzy+q1Sd+c4kD9S/keZClS
         MZt8ZPz7P4MLIzfxWg2TmnOnQZh1igfmm8ZEeJ8srgrqVAyq+4zbSyFWUbE7XBWoPObj
         jw6yyodMDdTkDAscIF6SN8BwOhAbZUdl9M4vi15xPNeKdSfMqdZWqtIpGdFgtw+Sa8tW
         WjRpVWRJwEG8tvxYBPzUBdlm27ROSFhNUxSh/hDPDKJJLfUfuJmwJAxMt1X6eC6zK8u7
         BRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761770664; x=1762375464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nRyrHH69bDwdkUwV+ZvUiMlkERSxLC5qY0L4yNkpAA=;
        b=dAEIdi2/p0m1QYTtSwVPnNB+KSraurCVgMsqeaUuvB6QOrR7NrN4Chu9o1WUOQy6C/
         x/reibHmLlByLWtroHgB3o08DjPERfLkDp5LMXvQKKDBSLke4mJYuwzpQZPfefQDFKMH
         2xadD3K7KYs8Xmon7eVWaW3O3GzTpGRjXxCk0lrC7Kd7YweSp7lkAkLkvALJrUtBcKEU
         FGLZcGa5XRFhZt7jQs+uD/eBCwdnxshO5DdGCPIdxD2EO6ZX+mYDC5m16YPEXYFn8Qcu
         yDj0Q7iE6yU7O5M8qgyp4Aq9ZjOyhCxxQr8fym/cGpJn9K42bvGJDlGxhaorNt4x/EGg
         3K/A==
X-Forwarded-Encrypted: i=1; AJvYcCWUesy4CCzbTsl8qkvvzF9aNKwWoSEmj9cydS7QnPohV81Gwz2J20nVx1++ngHiD2kc1Pe+RaXClmzRv/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXnzil8I64TOrGD1i07MvEp9ONJZs1wzOfOlnIMfv+OVOjlho
	rsC5lvtRiMR8vP8Wm52MQfP4FtyVvo+51LiB0XUrqRINHnqLaC5ubQZsGFzcmO10oRzLEpujc+X
	IvjiF7Yy+AtfrgRiKW8o9Qi9n9JfDj3CJKd5kqB2y
X-Gm-Gg: ASbGnctb8ZFYminrBR95W65bj2Pf6B/cngDWfUps3w0wkKxmrgSx8v3ENvZf8C111xE
	VZW5+nZW9KWxM2oMAtDWmtevIyQcgdahMI8ODcSVkhBCJqTuoxq8c+n+WCFklGB+QYkApv0rrLB
	5b4qdOTBT/keB3SOAOHoPNnpdvOQH1iS7xt+LUfqoJvtwctM1EOiU7O/nfrBpIzBC+4y5m0Wt4Y
	evreFXbSrja92ji5k5/5SRcs7oiVv/QuGhfRumA+uamJ8esp0JrRTTgYEh7
X-Google-Smtp-Source: AGHT+IFRYtH5XfTJnxxGfkJO0Gi6f1H2nFBXWvOk+OBKFsn98ppWQIAtWYQQwdGEa9VK8XbxcXnwXcPQMdyC3mUpVtI=
X-Received: by 2002:a05:651c:32a6:b0:378:d020:b6b3 with SMTP id
 38308e7fff4ca-37a1068ccefmr2106821fa.7.1761770663502; Wed, 29 Oct 2025
 13:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0tszhcyrw.fsf@kernel.org>
 <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
In-Reply-To: <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 29 Oct 2025 13:43:56 -0700
X-Gm-Features: AWmQ_blzsfm8AU4aSmOo38Baxqd-QolYtNvPxHfj3yJKEB0u3KTJVZdMqBMfTX4
Message-ID: <CALzav=d_Gmb8xKCwWCGsQQrdxHJrnk5VP-8hvO6FugUP7_ukAw@mail.gmail.com>
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:13=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> On Wed, Oct 29, 2025 at 3:07=E2=80=AFPM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
> > Also, I think the model we should have is to only allow new sessions in
> > normal state. Currently luo_session_create() allows creating a new
> > session in updated state. This would end up mixing sessions from a
> > previous boot and sessions from current boot. I don't really see a
> > reason for that and I think the userspace should first call finish
> > before starting new serialization. Keeps things simpler.
>
> It does. However, yesterday Jason Gunthorpe suggested that we simplify
> the uapi, at least for the initial landing, by removing the state
> machine during boot and allowing new sessions to be created at any
> time. This would also mean separating the incoming and outgoing
> sessions and removing the ioctl() call used to bring the machine into
> a normal state; instead, only individual sessions could be brought
> into a 'normal' state.
>
> Simplified uAPI Proposal
> The simplest uAPI would look like this:
> IOCTLs on /dev/liveupdate (to create and retrieve session FDs):
> LIVEUPDATE_IOCTL_CREATE_SESSION
> LIVEUPDATE_IOCTL_RETRIEVE_SESSION
>
> IOCTLs on session FDs:
> LIVEUPDATE_CMD_SESSION_PRESERVE_FD
> LIVEUPDATE_CMD_SESSION_RETRIEVE_FD
> LIVEUPDATE_CMD_SESSION_FINISH

Should we drop LIVEUPDATE_CMD_SESSION_FINISH and do this work in
close(session_fd)? close() can return an error.

I think this cleans up a few parts of the uAPI:

 - One less ioctl.
 - The only way to get an outgoing session would be through
LIVEUPDATE_IOCTL_CREATE_SESSION. The kernel does not have to deal with
an empty incoming session "becoming" an outgoing session (as described
below).
 - The kernel can properly leak the session and its resources by
refusing to close the session file.

