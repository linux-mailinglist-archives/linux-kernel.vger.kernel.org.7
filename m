Return-Path: <linux-kernel+bounces-681900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3081AD58C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8638189B4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DAB28A72A;
	Wed, 11 Jun 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZaAIS6w"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E566FBF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652225; cv=none; b=H08pGQAzye7ox8pwgLwu4QARBH1k6STCxWCysa9/NRKVPTHW/4eXPdLAJJkb1WKajsoTnh0uzY67wAX04pNKFw9wM27kXTbJNdJQwijyj7Hi79Gq32jX9EvtKcBSYnj8wwpLEDjyzSLkK2Bq3lZbjXqLRQEv0MrvS4en2clipXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652225; c=relaxed/simple;
	bh=rkm1anVyEvlv41ekO9EkqphK/tRo0dQ1qrXJJPYq8Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CinSnIAV4VZ/UECGHKovv0TJ2LrjUCr0WQvwlfpFZGiH8oCLmp24JVGwYI8anDsZGGvJtAFiVo5MfB6xxve8Te6BNjQDSNrLLr4/e//+YIUt5SGCzzEdjGHemu94HAka8OYIgVrnopQww5cnB1GYyPcmPS5b/z5B+fA1FmKBnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZaAIS6w; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ca5eba8cso163545ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749652223; x=1750257023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCrASjwvEXPxtyzltQ9FdaCz1lyWMA2UAOb6kJk+LMU=;
        b=HZaAIS6wHnert5EPC18K609hN+G98vQ6VMbNNz/F2dEOuY78og5yxPdMJIvv0f97XF
         RfLYN+lviGFRLyNeoUXHal/+NHJwoPSBMcVXZ6YNvLTokWl3EJUJrIEJL+8NBc3b+zcL
         UeSeUhGJEb+Qi7NuDxvLb/ryL4IwCL0YRps1BYst9BuVSTE8Ab+xWtCJsvKiTPIsebm/
         HcrX7VOTip5Lng1fFdRMNQwEXF6HPE7zQTW5FNywP5Cmrd6cCreZKDV6QuMCiKjh0Un5
         yGthXeMcWLRzy3RymLLLbblCVEcW4It/NoDkNcpBnnqLzzx3oXwgPNtPIUGRxOHLGrM4
         WjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652223; x=1750257023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCrASjwvEXPxtyzltQ9FdaCz1lyWMA2UAOb6kJk+LMU=;
        b=i1BzdbT+2dU00612mVhhLer35IudXmmSjQTC1TXn9FGc06E9RcZu8ZoXiHssBVqrFr
         m2MdRobii1pQUNoJzyhpGRzwTkDdTWcoq1bx3xm7az9S8TlKYM9Le1kqlu+/1NpPjsbJ
         M8lk201WHsHOydsqmsg8s93vCgPwXkMpBsiFDJ2c462tpZTTyZjpsOG10sD9O5i+lHzo
         6sMPRToRKO91WHu93tqUBpTFA2AaV+ZsohSSXwRfD8P+E0mglU/FPGXpQiDV6prEhJyq
         tP75GTChwf152ErB52HID0YFHNhCJRnduSmuDY9N4PfTS/x+OvIUIuduGKzgg7IKehqC
         b4xg==
X-Forwarded-Encrypted: i=1; AJvYcCWRfJ98XtuPbkTNr5lRw600EsOvjk83dWvc3tColQ6pXEQQT/E9Bc9c4YKLUYgqNFbQkFDUHVfy1l2DFJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/bA5d5Hzjzn40g7vxv1vJKl+EM/H5XPf8ipE9y/354ieLNQgr
	KhO4GSF6V9wsOMTHx0iMTOJ/wtGFfD3AxG0NQoupnzkQxQ1gSXyTLL2lOzGKzvcBu+XJn/8neUE
	4ToK137hYECU4Pt+Sm5sepNmM0GJnjlj3sMJ0zA0t
X-Gm-Gg: ASbGncsLLAXtuxrbXFeRPSBfO5CjZkcCClo+f6CAxe5hk+KvAKPy/o6c0h0bc9aA5+8
	HXsRRzsmJpu1zSMBKC2O4KWgrBzmmT/xAbj6f0GJWNGIWMzMF4nmZm37HXZD2LiIRiMIV2lQE6L
	Ju6UGKlocAPJMZf/WPPum90/1PFwF2jAhrniTAmWX/bax3Mm/aWaL/0y1XVycG6bGl4x7UYAOQ+
	Fo=
X-Google-Smtp-Source: AGHT+IEhf4eflDYpBh6Otp+k6a5H201iTzzT4f+4id8dLRp3h7IKX6ii2/45YOqAnWuQZlEb6GrQ/WrSSH1VQKvceGs=
X-Received: by 2002:a17:902:e846:b0:234:afcf:d9e9 with SMTP id
 d9443c01a7336-23643336f38mr2411095ad.11.1749652222729; Wed, 11 Jun 2025
 07:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCVZIuBHx51o7Pbl@yzhao56-desk.sh.intel.com> <diqzfrgfp95d.fsf@ackerleytng-ctop.c.googlers.com>
 <aEEEJbTzlncbRaRA@yzhao56-desk.sh.intel.com>
In-Reply-To: <aEEEJbTzlncbRaRA@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 11 Jun 2025 07:30:10 -0700
X-Gm-Features: AX0GCFvuClKJecOSDpZ2O2m8SBn0sgRnBvQCza0ISi3mFJAfiNvE0buiGQZUE1c
Message-ID: <CAGtprH_Vj=KS0BmiX=P6nUTdYeAZhNEyjrRFXVK0sG=k4gbBMg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] KVM: TDX: Increase/decrease folio ref for huge pages
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, pbonzini@redhat.com, seanjc@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@intel.com, kirill.shutemov@intel.com, 
	tabba@google.com, quic_eberman@quicinc.com, michael.roth@amd.com, 
	david@redhat.com, vbabka@suse.cz, jroedel@suse.de, thomas.lendacky@amd.com, 
	pgonda@google.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, ira.weiny@intel.com, isaku.yamahata@intel.com, 
	xiaoyao.li@intel.com, binbin.wu@linux.intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 7:45=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:
>
> We need to restore to the previous status (which includes the host page t=
able)
> if conversion can't be done.
> That said, in my view, a better flow would be:
>
> 1. guest_memfd sends a pre-invalidation request to users (users here mean=
s the
>    consumers in kernel of memory allocated from guest_memfd).
>
> 2. Users (A, B, ..., X) perform pre-checks to determine if invalidation c=
an
>    proceed. For example, in the case of TDX, this might involve memory
>    allocation and page splitting.
>
> 3. Based on the pre-check results, guest_memfd either aborts the invalida=
tion or
>    proceeds by sending the actual invalidation request.
>
> 4. Users (A-X) perform the actual unmap operation, ensuring it cannot fai=
l. For
>    TDX, the unmap must succeed unless there are bugs in the KVM or TDX mo=
dule.
>    In such cases, TDX can callback guest_memfd to inform the poison-statu=
s of
>    the page or elevate the page reference count.

Few questions here:
1) It sounds like the failure to remove entries from SEPT could only
be due to bugs in the KVM/TDX module, how reliable would it be to
continue executing TDX VMs on the host once such bugs are hit?
2) Is it reliable to continue executing the host kernel and other
normal VMs once such bugs are hit?
3) Can the memory be reclaimed reliably if the VM is marked as dead
and cleaned up right away?

>
> 5. guest_memfd completes the invalidation process. If the memory is marke=
d as
>    "poison," guest_memfd can handle it accordingly. If the page has an el=
evated
>    reference count, guest_memfd may not need to take special action, as t=
he
>    elevated count prevents the OS from reallocating the page.
>    (but from your reply below, seems a callback to guest_memfd is a bette=
r
>    approach).
>

