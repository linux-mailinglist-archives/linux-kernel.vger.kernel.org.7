Return-Path: <linux-kernel+bounces-858865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1101ABEC127
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0746E6001
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7B58F49;
	Sat, 18 Oct 2025 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tp7kSAsN"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B381397
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745732; cv=none; b=p72d2V42JeieH7EDw9qwulMSoO46syxR/PcYwxO+7UPZ/J1pqh6l/69unC9biRlCBlyllzmwbUpVMHKuXddW/mXlcYPle9AomI3H+bUQjHBjBUXmngVb9/jyCb+QQMs3fJnfSNalSc1XzTtoqlXBWsXlKspP15bfi7Rd3Km3h48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745732; c=relaxed/simple;
	bh=PFFaPl522Tuh1RF/N52HE3b8Oto9E5SoDFOd5u3Qg7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7ub0/PipNF8LPgzoneRyVwDvbxigUjVU6M4tSchY9Fs1bRySDYgGC14XKxtebNQP7eOBEA5/qvLxE8va0h1fHOOH5aSd4HcWqtFat+F1wbs0MZ9MRwkPbWLULTwr0N8xc0SMznfBFHPaIKOGEdxK45zm+2L2fGKnxx0XwiF81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tp7kSAsN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27eeafd4882so74315ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760745729; x=1761350529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFFaPl522Tuh1RF/N52HE3b8Oto9E5SoDFOd5u3Qg7E=;
        b=tp7kSAsN8ulC4VUzXKRkcemOozm9Zy5dvMB1websmnOwwKNVqMA5at4pmgsUB6qEr6
         yV9aVWQ6kWRFRLGm+JtIE1XpKHXkUCkIVuvvCe8GFWBqRDb79m8O0WoGABAZYETWWpPR
         NSjZQlDZ73uW1zle7MAWaQPS5awvP341W0wQu2+imJM+XV2TNnlBABCtX+dBhOO7/ZE2
         66vWcywyufD87YKDCR0XORj3W5VaOavQSnxWBJz4sjKzx1sAHeaI3fLZngfeCOMDv9kT
         XN2XveiLAif9E6Uxer/HmEVedkwa+YUjF+EPu34mRYNcDvVr6Gx4WDKH/USUlwYcZ7k5
         Tx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760745729; x=1761350529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFFaPl522Tuh1RF/N52HE3b8Oto9E5SoDFOd5u3Qg7E=;
        b=RGG1yAc4nuDl2C2mYYtGCXkr+/Gy9LZxB/y7M2Ea524lQWrnr3SHMTQBinTDWWJaki
         sHB5BCYK8x1B7jNUg9u1SK6RmKEF0PqLZCDpK02cfK/uLBFK8IKkKYq0OPYv8V6qbYpE
         Ha7fkaRQOP00SUc56qQUVuqBHuAjO+DQdT366c3QwpCOyV/uzjZ28gNl5DNFx6IQDOvG
         Yy94bcKLiI780ckx9w0vSUPV5DLMFtupvUIXOBDTSQpJsscz6IFhPx0E+hy3Qxu3OZ0u
         HHnp++jwzszJJFssOlzs74lsjztUuIkZjBiegWJZgfZ6n6MnudlgSzU1yufFdtHNzUl4
         VAYA==
X-Forwarded-Encrypted: i=1; AJvYcCW4v2QRFvjonhThg3rnda/k0SYgGhUv/R+cw6D0M0T/LV1CTxRXj35CjrG9dBuJr1VektanwK7WQv+Zy4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZZiZs9tTHDfrNrVs7/SEglbX5qBkdmZd3lGAsZCqzdBN+aIzE
	Hmg2ZYOvYkMHO41hWe/d0GoKMrwtYduQQ0lBhV4V4cWYicU4BY4Dt0a2RhHYw+iU7c255SFuDUT
	WoMlRucWn8tElhICOSOLiL62IRos8oU8fpYSqyQVgwJkUPagO/Jid9DmrEIk=
X-Gm-Gg: ASbGncuD15orD6MPGOgx9T6AFjz/UH/wG3zZEBhu8qh4uwV1UPWqIy+pVTR5YgwFHjG
	SZ3dkJvRufNxatWrMkYnRawU21FFo2KN4y9ZtzsSBr+U3gGXrYNPeBpxWA+8/6E61dusRXccLR0
	sBA9a5NSJV3T1e+LRtVOZS00fqksCt6DWyU2+QVNm9jJh1zlBGaqkvWJi7Li7fnSsD3zB+Yf0dx
	TAmlyeMmIjzrKNtvWHfhGZu5aZAVkRFxzmai2DJrB0xO8jYKP4KQn0rWPeGJR6q4hmLqeovSfdX
	T+m3JfBkMf5ArOj4oog4lgjFcQ==
X-Google-Smtp-Source: AGHT+IGS6D0cEerAch1ZNAxH+28FjiEz6Ek4jRtm0Z30Nd4P9X26VfzqUo7NNhK4jwKy2fUMCLADwy7nvB+KqxLEqHY=
X-Received: by 2002:a17:903:230a:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-290877a3fb0mr20388215ad.0.1760745728557; Fri, 17 Oct 2025
 17:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001025442.427697-1-chao.gao@intel.com> <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com> <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com> <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 17 Oct 2025 17:01:55 -0700
X-Gm-Features: AS18NWAQzNIk6iX2cjplI6mE1nRy77pJKpI0Ok4V-Hgp0sUCgMwBGuwBq0CrWrc
Message-ID: <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Hansen, Dave" <dave.hansen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, 
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

On Fri, Oct 17, 2025 at 3:08=E2=80=AFAM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>
> > > > ...
> > > > > But the situation can be avoided fully, if TD preserving update i=
s not
> > > > conducted
> > > > > during the TD build time.
> > > >
> > > > Sure, and the TDX module itself could guarantee this as well as muc=
h as
> > > > the kernel could. It could decline to allow module updates during T=
D
> > > > builds, or error out the TD build if it collides with an update.
> > >
> > > TDX module has a functionality to decline going into SHUTDOWN state
> > > (pre-requisite for TD preserving update) if TD build or any problemat=
ic
> > > operation is in progress. It requires VMM to opt-in into this feature=
.
> >
> > Is this opt-in enabled as part of this series? If not, what is the
> > mechanism to enable this opt-in?
>
> For the information about how it works on TDX module side,
> please consult the latest ABI spec, definition of TDH.SYS.SHUTDOWN leaf,
> page 321:
> https://cdrdv2.intel.com/v1/dl/getContent/733579
>

Thanks Elena. Should the patch [1] from this series be modified to
handle the TDX module shutdown as per:
"If supported by the TDX Module, the host VMM can set the
AVOID_COMPAT_SENSITIVE flag to request the TDX Module to fail
TDH.SYS.UPDATE if any of the TDs are currently in a state that is
impacted by the update-sensitive cases"

The documentation below doesn't make sense to me:
"The compatibility checks done by TDH.SYS.UPDATE do not include the
following cases:
* If any TD was initialized by an older TDX Module that did enumerate
TDX_FEATURES0.UPDATE_COMPATIBLITY as 1, TDH.SYS.SHUTDOWN does not
check for a TD build in progress condition for that TD.
* If any TD migration session is in progress, it was initialized by an
older TDX Module that did enumerate TDX_FEATURES0.UPDATE_COMPATIBLITY
as 1"

Was it supposed to say below?
"If any TD was initialized by an older TDX Module that did enumerate
TDX_FEATURES0.UPDATE_COMPATIBLITY as 0, TDH.SYS.SHUTDOWN does not
check for a TD build in progress condition for that TD"

[1] https://lore.kernel.org/all/20251001025442.427697-15-chao.gao@intel.com=
/

