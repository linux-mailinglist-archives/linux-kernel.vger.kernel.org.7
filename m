Return-Path: <linux-kernel+bounces-840363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6187BB4349
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527833C824C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A36312805;
	Thu,  2 Oct 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MHVEbBlX"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA272C027F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759416265; cv=none; b=ZuPYIaHyYN2bXqpYjTNGgk21t8hrLcHPgFt1SKgwhEEpAr4YvDWb00FomK0LCkDOoPTIlOoJSmvwvEM2BiYUk6EKC/txPlhD0nUgxaRht1iIVWg0KVj/e1hQJXiIg7wBbc20LVYSPeYCunZ5Cb0xln1BtiLzoWLRpK5fCMGPtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759416265; c=relaxed/simple;
	bh=aFsyykfKdVfUZ6OYSkvanTpq9T0/ktCIc35j5HZJV2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ez0CZ7A3ut+u9DymptjuQuM/TxWrjnLZFpTTalrSxE4CRQDYfr3BTgJCEEBktF5wq9kKkKDUyijdQzV3KTwqIXDqDmr/h+OX9JCQJEQowAHjRG16jz2IcK33SXFlcbI/dINgnkZyBx2xRGtSZTZ16HgiGXMOINlnvhpT18rNaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=MHVEbBlX; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-86420079b01so106542085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759416263; x=1760021063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUdgvpTLhvmJ1bP4tagSyz2Yjbg3ABuiWON3GAUGKAI=;
        b=MHVEbBlXiahSFWEnhIECC1bs5YDd/kgc7lq6R0rFLYStfzpexwiECLre5iJhKyMnH/
         yASORhLsM+AadC6xiqGehtWbmrzKqTFaRfE0yWGroDhMQiWRwjfsvo/XNYaFYB3ekRFf
         QpJEv0BO6ZGyr/Dvuq/JMFw5rPkuDYByM2djSqrbMRiQvC1hE9km8tJOcdMfx8TteKWq
         P/2FJD2bB/hDc7l3WRohRdpGSS3yUMriEvYwg6/gL2O41or3cmUderZA+c8aPsIkq9fW
         6EmqrOayLSgswF6JxZb3Iboh4a8hzeDU0CJTE62Sj3017Rh9HRbGSbw6FJrMn/ee3SD1
         ZzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759416263; x=1760021063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUdgvpTLhvmJ1bP4tagSyz2Yjbg3ABuiWON3GAUGKAI=;
        b=WF9aftPJyd0qK/XoscIgq3WvRs4fOdDSQlPKrSqOshE4RPvhSR6jNFh72GhUZBcnA4
         hTgaGgwBpwSJZ1RG0nycbWjIoQmN2vNaDP8xjPGZfLBvodAuQHCa+uop8MnBNR38nb4O
         mA3t37LrOFfrQDsx5Lrk6upwrBW+lPtLb38cIP30WWshxZQ+U4Ha1AM29hlCl7/SpeQP
         BTH46cB+kwbHuyC2dn+ncgkyXUO9b5vyEpCWU9o7qwWPqMRZamDE0jOplnXdXqR8vEnT
         POftwJ3w9KgmLPUtKdseympX60A8SNDLzMW6mHZxHPtpvRgZruEGF5yrRuxZUv7r/95R
         RKeA==
X-Forwarded-Encrypted: i=1; AJvYcCUIR3nc3sThEaWzGmS+31g7XMRkIChzPR5Kdx3ghQ3SduhlNqLgQi0x6VQcImF8r95HISJuEiR3y9Rs31w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJijyBpx6klHcax2EImkEtd7E2jnTuaRnBVW2nqdbr1VDHZlb9
	5FVgmo5fgtY96CdpBI6ST5gjnc9kzg0WKUaeM/DGScqQex2AMA51WuobyTgPFL9wibXp2Vn8K4w
	Dd0BG7PKJcOgq5PGrpnMiduqsJgVo4tpx5jsTfMB2JQ==
X-Gm-Gg: ASbGnctI9mOxKdNVcE127h41PKeVz7mV0jiQw/oZZxoawGfGpG6eYYGL3n7gb0FTO5i
	9HGTF538CB9+Hs4kxR/94BlMj7QeXWQdhcydlmmcSVsfyjy3aA0QW7t4Ku7edEYrzdyP0MufjAJ
	SL7vWxc37XreFuwJRCa4QFu5iwZ4MSviVV95pKQvqfvflJ3IP26x617z5Wgr+hhDdMCEIlHn2po
	WEip9CJwvX9HhTmUAjppnl4K2iVNabCYDGypIY=
X-Google-Smtp-Source: AGHT+IGVMGKUNvEytPBUBiSRA0mE9OlqXs6dKRKkwtnlotBZX7A4sJ1yzYAuoM2EkNHdvMa26nVXJxT3V5vw3So//6c=
X-Received: by 2002:a05:620a:1a96:b0:851:cb50:c5d0 with SMTP id
 af79cd13be357-8737021afc9mr974017485a.12.1759416262594; Thu, 02 Oct 2025
 07:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca>
In-Reply-To: <20251002115712.GA3195829@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Oct 2025 10:43:45 -0400
X-Gm-Features: AS18NWDqwdwuRxoZh_uXq08M5BHLz0U3xt0O7Y5fWskUwNH0ZUclyFnSzqq54qE
Message-ID: <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 7:57=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Wed, Oct 01, 2025 at 03:28:56PM -0400, Pasha Tatashin wrote:
> > > > 3. On FINISH, the IOMMU core updates the context entries of preserv=
ed
> > > > devices to point to the new domain.
> > >
> > > No, finish should never do anything on the restore path, IMHO. User
> > > should directly attach the newly created HWPT when it is ready.
> >
> > But, finish is our indicator that a particular session (VM) is out of
> > blackout, and now we are free to do slow things, such as
> > re-allocating/recreating page tables. Why start it before a VM is out
> > of blackout?
>
> Things should be paired.. The suspend side is
>
>  start luo - "brown out" - kernel does basically nothing as the luo is em=
pty
>  add all sorts of things to sessions
>  finish - kernel does last minute things
>
> While the resume is the symmetric opposite:
>
>  kexec boot - kernel restores the critical stuff it needs to boot to
>                userspace
>  userspace does all sorts of stuff and gets things out of the sessions
>  finish - luo should be empty now as everything was taken out by
>           userspace

I see, so you are proposing that finish() is basically a no-op for
IOMMU as long as everything was properly reclaimed by userspace.

> I think when things come out of luo they should be fully operational
> immediately.

I agree. Once we are in "normal" mode, we should be done with all
live-update specifics. In this state, the kernel must be fully
operational without limitations or pending background work that could
reduce VM performance. Also, any session was not reclaimed before
finish(), it and all resources associated with it should be terminated
during finish.

> Finish on resume shouldn't indicate anything specific beyond the luo
> should be empty and everything should have been restored. It isn't
> like finish on pre-kexec.
>
> Userspace decides how it sequences things and what steps it takes
> before ending blackout and resuming the VM.

This is a fair statement: userspace knows when vCPUs are resumed and
can decide when to do the HWPT swap. Following that logic, what if we
provide a specific ioctl() to perform the swap? Userspace could then
call that ioctl() prior to finish(), and during the finish() callback,
we would only need to do a quick sanity check that everything is in
order (i.e., resources were retrieved and the HWPTs were swapped).

What do we do if the user reclaimed iommufd but did not swap HWPT or
did not perform some other ioctl() before finish(), simply print a
kernel warnings and let it be, or force swapping during finish before
going into normal mode?

Pasha

