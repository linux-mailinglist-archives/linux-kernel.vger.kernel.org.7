Return-Path: <linux-kernel+bounces-786875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E80FB36D32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED591C25E08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46263258CF7;
	Tue, 26 Aug 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="K9ZF+v7p"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCE420E6E3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220577; cv=none; b=LRi27H79YwKt0atXsjkN5U24IgBOSMy6tUHzs3kWToxUz+gxpKH+cPVDT+p7lZ5Lo+WAp5+yNHwrl9hVT6qKArpLLOxXwCC4k0bOt8ymdUyMInSgT2qC8U/mVLpnJnmK9OPtH2RjODRBCwC0Cvo2+se+tJHfsDoPpfD/uCJ+TL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220577; c=relaxed/simple;
	bh=vipNTbGB9wFWdA45CBFqlA3kiRpHyWKU7fupy2TzZxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeUwzf8V+w3IOV5PIzOT/E/TIBxmUX7zAb/q8APRN9lzZeRkIsic+UUM7wxmyA17xi7mgJwXP8+udwDQvdtOmTZvkWxZTdlgIKacuCJwYFNmv4YllinTEvQnmm1jwFn5Q41xPjlJ8jJsYxqO8uieuNy69iPSZry48H3l3Z2Yfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=K9ZF+v7p; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61bf1542ecbso2616707eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756220574; x=1756825374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+0PR2fJcjZ6JOVTFgH14262z5rkDGxSbAwbjWWLyng=;
        b=K9ZF+v7p+72pfwTw6pYAp8gUNmgFmG/Qsy2vzJdBuWGFlAz9o5c5jzGsqIBxwCo7Wn
         mHUPyb1QYyDY2ZDtXxEP6tmMmrpJ1GnctCQuDH9XT9X+i5ly+tT1auWXULWxX2Yqvj5w
         lI6ejW8xXCEyEwJPNqUhAuZmkRetbVL3XyE9LWUkYTCuS3xErB6UZsgrcqkPI74taDyC
         s+XFSpbw1R8fxFp6s1JdudHpplysh2dRmoQdSr8JRTTX3QULw1QA+RXFs2dhBWOwN0m+
         UfbBaPVFPJq9KbbCKeHG4TiHSH6hnmTlpp0pe6bIn5t+QrgUXram6XosO8qB4bqUThiX
         u2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220574; x=1756825374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+0PR2fJcjZ6JOVTFgH14262z5rkDGxSbAwbjWWLyng=;
        b=CGGxMt5Tk7Os+wFlFtas+augXxKCvGJXMh49nWpWxALNrFxcotYFT+TSEVr501TM7B
         mhn5L0KfA+TN39Wgw6bycBHAgYsIWqBud5uVIMIR8pFvRXS2rGdMK4JYspWsw5ux3UIO
         23vip3+GMmXfInEDrjm9Cl1DfevPAtvYGKdsSn89kP0iQxxzLof8D3UBkS9eFCfX+umz
         0sB1vz6WtkY7pCVHvoY3Cvqys+bIHycYns3WBAxMzNTquc/muK94hBVqgHu2rYHilkfD
         ZNELRrNiewnYb4TvyHiL8mM/8ucd51xTB0uFfOYGovo4puLIKXX5Ru6TyeIV+r0ZTDdM
         1IRw==
X-Forwarded-Encrypted: i=1; AJvYcCVP2LscfOzLSTlVsBVw+oVemgHAQWK+dJia66GKzppTepbkM1WVM6blsoDRubOW3pTSH76YeXxvyC+/2XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynSCeNX6Puq+3hoYVsuBLc47jCW/M3itqCjM0NWz6ppvPbSnhz
	BM3OIjU9Qio8Q734dBg4pFuX3qBIjsogwl9YzAy+s0WR/ht9nSyYDYAb6EPMVXLT2TJK77srsJJ
	dm+NtCH8scKT1w/UgTOISHXX8g9Xtd9AN6Z/pfetmzg==
X-Gm-Gg: ASbGncue2lRyV5DIzZsaNHmuKr5h/2+YI7yGm6fZcZ5Vg9GbAun2HJQMdZrBpCD4WoE
	DaMaRsEB8nBWg1YHmmQdo8lJexfNV8pw9LdmuRqgjOBiRNuSWQ0nz7xFHsROqNbYHPFX3Lr8Yns
	rg+kCiY1YonlMNDFIxoIE2vBlt5LhH7z2dx0SoTg4C/0mFaBMBh3M8Tl0bpdPAp4NrQGLx7iiUY
	RQF
X-Google-Smtp-Source: AGHT+IGZRoryUW5ksQYVJjIedWGTznIaiVqZiY1Pg/H6rjAtNQNm/14jN2CvpI319rkbtN5Pjbxs+aqTIMSdEzY6AGA=
X-Received: by 2002:a05:6808:3442:b0:434:b43:d4a3 with SMTP id
 5614622812f47-437c543fdd9mr854638b6e.12.1756220572416; Tue, 26 Aug 2025
 08:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <mafs0ms7mxly1.fsf@kernel.org> <CA+CK2bBoLi9tYWHSFyDEHWd_cwvS_hR4q2HMmg-C+SJpQDNs=g@mail.gmail.com>
 <20250826142406.GE1970008@nvidia.com>
In-Reply-To: <20250826142406.GE1970008@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Aug 2025 15:02:13 +0000
X-Gm-Features: Ac12FXyHXPcCjTtFR9AWQQdvDhbej8DQJ5aeFKL6iCSLSRPcL1vtdZDLkhVgq68
Message-ID: <CA+CK2bBrCd8t_BUeE-sVPGjsJwmtk3mCSVhTMGbseTi_Wk+4yQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:24=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Aug 26, 2025 at 01:54:31PM +0000, Pasha Tatashin wrote:
> > > > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
> > > >
> > > > Changelog from v2:
> > > > - Addressed comments from Mike Rapoport and Jason Gunthorpe
> > > > - Only one user agent (LiveupdateD) can open /dev/liveupdate
> > > > - With the above changes, sessions are not needed, and should be
> > > >   maintained by the user-agent itself, so removed support for
> > > >   sessions.
> > >
> > > If all the FDs are restored in the agent's context, this assigns all =
the
> > > resources to the agent. For example, if the agent restores a memfd, a=
ll
> > > the memory gets charged to the agent's cgroup, and the client gets no=
ne
> > > of it. This makes it impossible to do any kind of resource limits.
> > >
> > > This was one of the advantages of being able to pass around sessions
> > > instead of FDs. The agent can pass on the right session to the right
> > > client, and then the client does the restore, getting all the resourc=
es
> > > charged to it.
> > >
> > > If we don't allow this, I think we will make LUO/LiveupdateD unsuitab=
le
> > > for many kinds of workloads. Do you have any ideas on how to do prope=
r
> > > resource attribution with the current patches? If not, then perhaps w=
e
> > > should reconsider this change?
> >
> > Hi Pratyush,
> >
> > That's an excellent point, and you're right that we must have a
> > solution for correct resource charging.
> >
> > I'd prefer to keep the session logic in the userspace agent (luod
> > https://tinyurl.com/luoddesign).
> >
> > For the charging problem, I believe there's a clear path forward with
> > the current ioctl-based API. The design of the ioctl commands (with a
> > size field in each struct) is intentionally extensible. In a follow-up
> > patch, we can extend the liveupdate_ioctl_fd_restore struct to include
> > a target pid field. The luod agent, would then be able to restore an
> > FD on behalf of a client and instruct the kernel to charge the
> > associated resources to that client's PID.
>
> This wasn't quite the idea though..
>
> The sessions sub FD were intended to be passed directly to other
> processes though unix sockets and fd passing so they could run their
> own ioctls in their own context for both save and restore. The ioctls
> available on the sessions should be specifically narrowed to be safe
> for this.
>
> I can understand not implementing session FDs in the first version,
> but when sessions FD are available they should work like this and
> solve the namespace/cgroup/etc issues.
>
> Passing some PID in an ioctl is not a great idea...

Hi Jason,

I'm trying to understand the drawbacks of the PID-based approach.
Could you elaborate on why passing a PID in the RESTORE_FD ioctl is
not a good idea?

From my perspective, luod would have a live, open socket to the client
process requesting the restore. It can use SO_PEERCRED to securely
identify the client's PID at that moment. The flow would be:

1. Client connects and resumes its session with luod.
2. Client requests to restore TOKEN_X.
3. luod verifies the client owns TOKEN_X for its session.
4. luod calls the RESTORE_FD ioctl, telling the kernel: "Please
restore TOKEN_X and charge the resources to PID Y (which I just
verified is on the other end of this socket)."
5. The kernel performs the action.
6. luod receives the new FD from the kernel and passes it back to the
client over the socket.

In this flow, the client isn't providing an arbitrary PID; the trusted
luod agent is providing the PID of a process it has an active
connection with.

The idea was to let luod handle the session/security story, and the
kernel handle the core preservation mechanism. Adding sessions to the
kernel, delegates the management and part of the security model into
the kernel. I am not sure if it is necessary, what can be cleanly
managed in userspace should stay in userspace.

Thanks,
Pasha


>
> Jason

