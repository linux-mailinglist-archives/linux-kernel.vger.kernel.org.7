Return-Path: <linux-kernel+bounces-854653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F2DBDEFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE16485DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB7C262FE9;
	Wed, 15 Oct 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2vd5WkX"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D325B69F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537957; cv=none; b=LafgRh31MMeDe9TAREnKTyKwbpV1QeuEb32uEn/B7QgFMtgFMXGIjSadgGTqZKye+GyvA+kBt7W01hYB0KHHo1uSOfSkTbJeWaBXbQdwm1XyiI/keMAfH9pmE/ojwGmjrRDIGK9TNHRuiP5XjNCpP+fvNba/uPH8PfYbYVfxCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537957; c=relaxed/simple;
	bh=ahnyCh5R5YFZLiOo76ToNT+ZdHj0T9SGh5TEC5IfhYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQm7yVpOmrml79BAYDUzmuqqa/RQttRqdFLXiuQ6JZcLBGqF0JXE8siioVbKEb6Q/TzlN4qaAHI1c9B2lp8Aj7jAhBOQ8P/GsxGidmNHpGu+oXcyDMTRXQgwL7GVk9L7gzRoUyulMWLjOFgfCxDxhfdIyQFT/yqfk4B9KwukaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2vd5WkX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eeafd4882so245495ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760537955; x=1761142755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCNBMdJdwB64svQgLfQeqcexCDnkXaxgEUAP3+vIY24=;
        b=s2vd5WkXMUgT7SHbJDMdftS2pMcEj3j33fPxPZ6gVGK0QA2cFjr2aavpHBh+uWAN+R
         b2O92BMqFCut2X27EigKMCZEt79omDONOo14dJYL/e4lWDgvcVG8kYlxryizNH/s5mQh
         USEZ9ipF9HiVNUEMqP0Y1ekB6G2sHsm3jBsn6vhMs8NYG6NlDLkctLkmH6wXFkDs3Ovo
         laiOW2Q0ShRQoJlQGRl7GwTWFRWfNg+SRWxhADPq3w4//hQWH2eFnqUmw8DH9nJctiPn
         FBk5k4tXWmFTIcF2d7BzCejWo4iahFIp1/ENW9qw5QAheJl6RYcziXatZCcyw9xn/G8s
         7peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537955; x=1761142755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCNBMdJdwB64svQgLfQeqcexCDnkXaxgEUAP3+vIY24=;
        b=MCPy5iHExU3SKxYA246hN+E2AOFM7DJK6Hdq4Kpc8GUKQwKD/B4H5upG5sW2Vp4Ggg
         TGLzZAiZtUkOyNibT8UZb5cv5+VIGv7CVs3u277FD8RdHrghwG7OYiJk1IINz0hRfkSB
         9mmABKfRBC20/NZ07wDTSBnk0j9F6iWqPknKabSNt3OEpvtw3Y8GAXi07mO6SuLsLh+w
         jZ+Q4x7AX58M9kQZ75l8oytUQ7SZdVlKickf59eqsrLhTVT63G3MLOoe/FxbpQkLSfiy
         p29Hl0U5Jo3ZQLPRGBk4ToREjc4hmNc6cZnqya3F+E70UC0uS1wMlnZ4NvAAx96bJV1h
         KL4w==
X-Forwarded-Encrypted: i=1; AJvYcCXBkMZRaXxEeO5s8zzzIcYFwHGXEqxoBBg47JtLhpaJecOhAT6AASNk2tq8le2g3ELNgVNxCOhFodC47kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgavpHndfFAqhTonCEjgv5Ga/ZL/V0vGQipb+2TfHz16rxjkr
	m5JgfYdcUJWQL8KlNLEP+h6OrSWL8PWIV6vDswEkQNgTPp6oqAZ1plFbIpJgJJTcILNqfs8CARW
	dpfEc0d26MO6OGlDf+9jz5W0+Emrkp2DJTBesfKQc
X-Gm-Gg: ASbGnctYNkVHIGVJsjU1MLWeW+pbltXeOEenBGWETqrxnksX+7YkPQsMsvazpS8Qupp
	f15liB+de+OO/4rPF6GtUb90ou2+JXG8vOCEk1LmpqThidD3RVR164eAOFCoIPgxmL6oVOu1PDo
	rBIjMFGD01E6eQskIxDZ8rUg7+CAUotSSgqhxnrCFjxve8KYgYmXNz+vmAhTkN2yOUnUwGjjXUS
	xqcJNkJaJSYntrt3QKZU3+dw6ZLnVe7pdPZn3fgVaUGDCdLmtq/vuzM7YKbnhBskA==
X-Google-Smtp-Source: AGHT+IHbrKGyHgyLNoSCIdBbTZkdLJfabMC03fgDQKhmrZ1EoKqCqqsSYDZsJamV5nH7yv64jCZddGCI/SoNF2uOK1A=
X-Received: by 2002:a17:902:cccd:b0:274:506d:7fea with SMTP id
 d9443c01a7336-29088b377f4mr3550475ad.5.1760537954542; Wed, 15 Oct 2025
 07:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001025442.427697-1-chao.gao@intel.com> <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 15 Oct 2025 07:19:01 -0700
X-Gm-Features: AS18NWBxbEW9bsNjqLRNqJQ0HIKpJDLUxowkEdxssJCTakHfAQlYHCoSzv6AcpM
Message-ID: <CAGtprH93h_f11-mBRExr7xwN284Otnk6vi9R-b5PfVtL+wvXaQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>, 
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 1:54=E2=80=AFAM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>
> > On Tue, Sep 30, 2025 at 7:54=E2=80=AFPM Chao Gao <chao.gao@intel.com> w=
rote:
> > >
> > > =3D=3D=3D TDX Module Distribution Model =3D=3D=3D
> > >
> > > At a high level, Intel publishes all TDX Modules on the github [2], a=
long
> > > with a mapping_file.json which documents the compatibility informatio=
n
> > > about each TDX Module and a userspace tool to install the TDX Module.=
 OS
> >
> > [2] mentions about a limitation of doing runtime TDX module update:
> >
> > "Performing TD Preserving during a TD Build operation might result in
> > a corrupted TD hash in the TD attestation report. Until fixed in a
> > future Intel TDX module update, a host VMM can avoid the problem by
> > not conducting a TD Preserving Update while TD Build operation is in
> > progress."
> >
> > Do you know if this issue is fixed already? If so, what version of TDX
> > module fixes this issue?
>
> It is not fixed, because the limitation comes from the internal crypto co=
ntext
> maintained by the IPP crypto library. Different versions of TDX module ca=
n
> use different versions of IPP library (as any good SW that aims to take l=
atest and
> greatest version of its dependencies) and IPP library (as any library) do=
es not
> provide any compatibility guarantees on its runtime data structures.
> So, the problem can show up if the old and new TDX module (prior and post
> TD preserving update) use different IPP versions and IPP happened to chan=
ge
> internal data structure format in between these versions. There is nothin=
g
> TDX module can really do in this case.
> But the situation can be avoided fully, if TD preserving update is not co=
nducted
> during the TD build time.

Few questions:
1) How is TD build time defined in this scenario?
2) IIUC, this series doesn't add any protection of TDX module update
against ongoing TD build steps, is that supposed to be the
responsibility of userspace VMM?
    - If so, what prevents the series from building in this protection
in the kernel?

>
> Best Regards,
> Elena.
>
>

