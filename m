Return-Path: <linux-kernel+bounces-872836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12962C1224A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090C319C0539
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F2226299;
	Tue, 28 Oct 2025 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnU3ehrB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113EAF50F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761610050; cv=none; b=QgVmlF/Zv29FQyaveDKiYkxsOxHLQcEMhvPVQKOrqJt8nwaosBgVysjqKCYiQrKzFzSJUUOgaG8a35CExAPK5wXezPTnjBsMhSWvcJ8v4a52VgQ6E95JQrdCYoVdjS5TSrcVbfNw1PLDEuKzPTRw8TVgOfNY+v5WmLnfTA7p4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761610050; c=relaxed/simple;
	bh=mch/ZI5qLRVAoaLgIQZaPQoMvhlcGy0VDNUbNfpQoNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GA46YPFJIwOjYO0+ow6UZSRad4uhAuladfBXjfT5BpDEpcfBM07yphnCBgETbRLXrXu9grVTTstYd9U0HIyWzhSqIjUMR46cAGDYQPYs5FEFPJjiRHCTu50ZfwV7Dhk4V02767oUTaYbT1lhSApHvURRzCr+YDY3QZtMRDBPKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnU3ehrB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290d48e9f1fso49925ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761610048; x=1762214848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUCmWZphGtvkCj1oy/zutgPwDivCyw9UJKHVVAKeUSU=;
        b=PnU3ehrBAYP6zshNxUjevkDIW/+Ba3a6CqI7xwyMyj6Y1+QcyyZamaGEzsJGbd1JTb
         R5NS0/gsfQUTN62uUNQvCfbMb2RiOAMVheOh7/TLim3c3E1jnkwNvyhULsdw0tfE5nB5
         GW+tcbo92vlOLE7ZALop9N+jZ086b2u5pQ2fYlL7HYQTKcGvIqZ5fLjn/rykm5iSBkYy
         Q32xvwamlCOgUtsz2bO28YwrMi2BHGk5KvnBdg/uXsnozx3vbmWunIhRNtt39NzPj3lI
         DzfZ7eYU2Joc2k8m1q7PVHjU5C7BaSQdK51SZMpXwKoC9VEMunHj2uXPq+glg2WTMqf+
         n9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761610048; x=1762214848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUCmWZphGtvkCj1oy/zutgPwDivCyw9UJKHVVAKeUSU=;
        b=hp3G4m6hFwm9w4cPN7DEw8BTpbVVI16+KKmSrmhIN8uaJODKz47Yxk8abU2RXCMaMs
         /tVnq8Vs+wcq0vu3mWc6wzX8Tn/Nb20LcM2q17coV/Q0yCT5DwMO2KSYp7zAu756Rw+2
         4tUF1PYqD/mL3eKe9XLa5R2mEA1IHsgohVP1j1Kh3PRWc72GO0RLgPRTSEvmTdX0wDIl
         22JZ5a7ZMe8rr/DuaNqAL6v6XskXqHTtUXqm+cg6YEIqMFHkAIyDhwNOile/xvymyXM3
         TkcIFuKqSS36qmZVXWRblhWXT5f6SBrAPHsbCdbWvCA5c+CXRg5xf8TXxR6ATRxt3mqf
         Yrmg==
X-Forwarded-Encrypted: i=1; AJvYcCWbhqtjvfTuE+H4jiPnM0PC3pjOGAQJYXzvEYp/VJw2fSJqdYJJm3dYcmkz2uuXG7p3Wu8CNctQ3n06Bd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1g0/gaIkTuo7S1cvwhgJKe8rboAm177GuztlDbHXR46MCerzL
	1IFWKerEmoGHHLpDHJB5EcWpPkk5Yi4Z3H37Pgwwf5ilx4gFTlaSmpplm+GYfmAF22QyLUYKsox
	xl8TY2t6GkhlI5T/z8gBYibd/8y/tg9LuZ0AqBl/l
X-Gm-Gg: ASbGncuFfFLKs41bWiG4vknpsv2Th8m3B2iRH1Qy+iz1dmIvJ9BSYHEwJAh4vApI2NS
	vE9IxNUeOPVB/v/Kh5o1WBS1NnC4U5KDjIwXhK3UIrdDM1iRJsAvX46PLFqGOhntHIefOcNDLvr
	Os0xiioATW8N5528XzL+a3XMz2XKxxEqZ8BdVcg8hGpa9JwbBQ6s9EF5nIrALlM143w0H5Ty1lg
	KLs7Ks+4LCZm08dneR5nuFQZRqWrKwxpyUYz8EEFLv73jSYVBIUADGRbjoxLrpDAvInzTVLeKxW
	+Hsanly29z7V4mnT5w==
X-Google-Smtp-Source: AGHT+IG1q9g21l8rIvkT2cpB43lyzci5HXE6aW1WkiXoYueYDIDNmiWxZPEvNuYZas1IC0sktW0/2rOmQ3UGOrkSU9U=
X-Received: by 2002:a17:902:e744:b0:290:dd42:eb5f with SMTP id
 d9443c01a7336-294ccb598e8mr2710275ad.12.1761610047632; Mon, 27 Oct 2025
 17:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901160930.1785244-1-pbonzini@redhat.com> <20250901160930.1785244-5-pbonzini@redhat.com>
 <CAGtprH-63eMtsU6TMeYrR8bi=-83sve=ObgdVzSv0htGf-kX+A@mail.gmail.com>
 <811dc6c51bb4dfdc19d434f535f8b75d43fde213.camel@intel.com>
 <ec07b62e266aa95d998c725336e773b8bc78225d.camel@intel.com> <114b9d1593f1168072c145a0041c3bfe62f67a37.camel@intel.com>
In-Reply-To: <114b9d1593f1168072c145a0041c3bfe62f67a37.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 27 Oct 2025 17:07:14 -0700
X-Gm-Features: AWmQ_blc7n8be0yWMkZPZeKdodPbTZIhORkjSheAPIkmIz8FANtGM3ijy60532w
Message-ID: <CAGtprH9uhdwppnQxNUBKmA4DwXn3qwTShBMoDALxox4qmvF6_g@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86/kexec: Disable kexec/kdump on platforms with TDX
 partial write erratum
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>, 
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "sagis@google.com" <sagis@google.com>, 
	"Chen, Farrah" <farrah.chen@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"bp@alien8.de" <bp@alien8.de>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"Gao, Chao" <chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"Williams, Dan J" <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 2:28=E2=80=AFPM Huang, Kai <kai.huang@intel.com> wr=
ote:
>
> On Mon, 2025-10-27 at 16:23 +0000, Edgecombe, Rick P wrote:
> > On Mon, 2025-10-27 at 00:50 +0000, Huang, Kai wrote:
> > > >
> > > > IIUC, kernel doesn't donate any of it's available memory to TDX mod=
ule
> > > > if TDX is not actually enabled (i.e. if "kvm.intel.tdx=3Dy" kernel
> > > > command line parameter is missing).
> > >
> > > Right (for now KVM is the only in-kernel TDX user).
> > >
> > > >
> > > > Why is it unsafe to allow kexec/kdump if "kvm.intel.tdx=3Dy" is not
> > > > supplied to the kernel?
> > >
> > > It can be relaxed.  Please see the above quoted text from the changel=
og:
> > >
> > >  > It's feasible to further relax this limitation, i.e., only fail ke=
xec
> > >  > when TDX is actually enabled by the kernel.  But this is still a h=
alf
> > >  > measure compared to resetting TDX private memory so just do the si=
mplest
> > >  > thing for now.
> >
> > I think KVM could be re-inserted with different module params? As in, t=
he two
> > in-tree users could be two separate insertions of the KVM module. That =
seems
> > like something that could easily come up in the real world, if a user r=
e-inserts
> > for the purpose of enabling TDX. I think the above quote was talking ab=
out
> > another way of checking if it's enabled.
>
> Yes exactly.  We need to look at module status for that.

So, the right thing to do is to declare the host platform as affected
by PW_MCE_BUG only if TDX module is initialized, does that sound
correct?

