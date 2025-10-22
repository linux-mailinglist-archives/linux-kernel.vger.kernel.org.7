Return-Path: <linux-kernel+bounces-865391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED7BFCF49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A27054E5D16
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3689A346E67;
	Wed, 22 Oct 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcSiWJ7v"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F441547E7
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147749; cv=none; b=kZVLBqICgDmnVsqGtHqKwtNHu189qWdi5kPcwqmBFUsahGio8KcqNXDmqUlgVdB5QBngn55jN5LXglOrqKt5/m91rJ/mlL5CCYLRAFWW7lgDgjuMrK/6v2HSnLikbAMVBpN6Twh9ZFPnuPYRpCRL+1Lr9LdcNGFnEx0zyhJJk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147749; c=relaxed/simple;
	bh=lrh9trOuUbfB9tr4S4CppAg4eYIoTFqaZqvi7679HzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNIzues3idkQUePwJM07kln3hTQdJkuivJDaq8hwBeatN2XgtID/M/g/CTySDHQlS+Q/hjHkOtT0OTF6tBm7JSnYuySW6rvLvHzDFWuis6Im00nI7kFhUHvY5ZUe5/wGN965NsH36q7LarBfO8tiqT7GUeGMDaRwiw6El2KFzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcSiWJ7v; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290d48e9f1fso227915ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761147747; x=1761752547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzoL+yZOu+8De1TKJwlUHggqh8pBAGHO5eUlyyjXTpk=;
        b=dcSiWJ7v5GLB7/gMOY/FmFc0TdpPOee4RAo+khTyDEk7wjlhwOTheG6WGsT9CssoCf
         mf+H0R++q2oHOaa99P9o5Qp54NdFiO41UbYNixW+qGH9nYT4rJ6BsJLwp7gZW3dh2cXW
         1Pwq+glqNu3simBzlDI8kfE1UnimKT/Vj+CdEsbaixtzgKm2Xe66h25YFE5tpGi1DW9f
         CcnEwB+epo9Kz9zEl1VT9ItKSyspnb0vOEhoOeTIJKvJsXo4eCCn8eTdXFBO7jBbT/0z
         tknzCyKtDOO6M6tN1PRdhaaWDBDXaLBhd6iiaKRkMkkK+jdeWIHguJeEApfIyinzT6+Z
         rVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147747; x=1761752547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzoL+yZOu+8De1TKJwlUHggqh8pBAGHO5eUlyyjXTpk=;
        b=O4KJxGGGiGqc6k6N+4RZQeRRMPc+8Bi5Yz+ZK2R6a4TE+eXn1y4v0nPa5QR4vftaGD
         lO2OhAkBzNDqa5ATgkUEAaC53zjRjmK+/3C3riGN/8YilhrsKxMiVTnoieTXnUSrJypg
         6KMblQ+v2eDec431SSt96Sp+ExdhQHfruq2JNyWqAgT0lCDTrMCXScNBu29w5pZi4/bB
         oazHi3t7+Su9nQmgHisN4AutAFdkNuXssUt5a1lOPTDiCOaWysqH7v8lKIKUui2ouGm4
         hrxuukzCBDkdxNsSx8nso+gnTNorcLu0dONpbPPRjUsYKOxQHwTo6DUuaxRPpMWw8g94
         2lig==
X-Forwarded-Encrypted: i=1; AJvYcCWwPBAlyavxEootwPtGn3IRQSGrQPabRr9gMWdv99KscP3VksE/5TeJAJdpNH2vRqW4PanQfBRpexGhgGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4XrxC71yT6FJIuKsJcy/22xNPMqZgs7K7mC+hldseCrbR1ba
	UscBeQVAYrUrrl6bgxtVi21uWXrKUrFThx80/+hx37dMYyIoQDREzIs3ivtIMm4h1YdFH5lzMtO
	EeQEFPxxTp6Q72/lx9hAKSewNNAHE49W3RO3DeOdv
X-Gm-Gg: ASbGnct8u2l6JXFIglL7P9rc6nt+aiEBT1mYXI8JXDn3kfVbiaZSQiIp/+U2MwQVF+A
	0oJ8hy+D5a8BiSwp1ylpThjrjRq32ii+bFqhbToqj5I87Epgwqa63mwtl37PIvTNKpmABfbz+km
	r83VLn8OiGYxqE9Cq+9GFIluy4xAT1q3OKADNgLAxBcPa6pzUkFNgGWuvCyHUShnfWpIo8xYFWg
	QmErpv0HdKyeQTDIq1rq6hiSSj9MVu+5hiyg8xt1+xbLZykxRKTJZoFDjOkBpN5BjGAllHM34qC
	NUOS1HlWb2O0zeuFQlvde5fKo1+Q
X-Google-Smtp-Source: AGHT+IHN5wM7xniJlXhXiDrVzdda1CBjT3wNmDvc4ugbOBZyMG4cRzMe9o5SvQOygWk52Qt8pxDlzqXiMUa6QjXw8Yg=
X-Received: by 2002:a17:902:f54a:b0:26a:8171:daf8 with SMTP id
 d9443c01a7336-29300ace4c2mr2290455ad.8.1761147746628; Wed, 22 Oct 2025
 08:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001025442.427697-1-chao.gao@intel.com> <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com> <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com> <aPiEakpcADuQHqQ3@intel.com>
In-Reply-To: <aPiEakpcADuQHqQ3@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 22 Oct 2025 08:42:13 -0700
X-Gm-Features: AS18NWCKamJJqOgfaVBvWApA5RD4LCnBz687TAXQf72Y4CIsxZQOYxW8E_FTLCQ
Message-ID: <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: Chao Gao <chao.gao@intel.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
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

On Wed, Oct 22, 2025 at 12:15=E2=80=AFAM Chao Gao <chao.gao@intel.com> wrot=
e:
>
> On Fri, Oct 17, 2025 at 05:01:55PM -0700, Vishal Annapurve wrote:
> >On Fri, Oct 17, 2025 at 3:08=E2=80=AFAM Reshetova, Elena
> ><elena.reshetova@intel.com> wrote:
> >>
> >>
> >> > > > ...
> >> > > > > But the situation can be avoided fully, if TD preserving updat=
e is not
> >> > > > conducted
> >> > > > > during the TD build time.
> >> > > >
> >> > > > Sure, and the TDX module itself could guarantee this as well as =
much as
> >> > > > the kernel could. It could decline to allow module updates durin=
g TD
> >> > > > builds, or error out the TD build if it collides with an update.
> >> > >
> >> > > TDX module has a functionality to decline going into SHUTDOWN stat=
e
> >> > > (pre-requisite for TD preserving update) if TD build or any proble=
matic
> >> > > operation is in progress. It requires VMM to opt-in into this feat=
ure.
> >> >
> >> > Is this opt-in enabled as part of this series? If not, what is the
> >> > mechanism to enable this opt-in?
> >>
> >> For the information about how it works on TDX module side,
> >> please consult the latest ABI spec, definition of TDH.SYS.SHUTDOWN lea=
f,
> >> page 321:
> >> https://cdrdv2.intel.com/v1/dl/getContent/733579
> >>
> >
> >Thanks Elena. Should the patch [1] from this series be modified to
> >handle the TDX module shutdown as per:
>
> Hi Vishal,
>
> I will fix this issue in the next version.
>
> The plan is to opt in post-update compatibility detection in the TDX
> Module. If incompatibilities are found, the module will return errors to
> any TD build or migration operations that were initiated prior to the
> updates. Please refer to the TDH.SYS.UPDATE leaf definition in the ABI
> spec above for details.
>
> I prefer this approach because:
>
> a. it guarantees forward progress. In contrast, failing updates would
>    require admins to retry TDX Module updates, and no progress would be
>    made unless they can successfully avoid race conditions between TDX
>    module updates and TD build/migration operations. However, if such rac=
e
>    conditions could be reliably prevented, this issue wouldn't require a
>    fix in the first place.

TD build operations are much more frequent than TDX module update
operations. Retrying TD build operation will need additional KVM and
userspace VMM changes IIUC (assuming TD build process needs to be
restarted from the scratch). IMO, it would be simpler to handle TDX
module update failures by retrying.

Admin logic to update TDX modules can be designed to either retry
failed TDX module updates or to be more robust, adds some
synchronization with VM creation attempts on the host. i.e. I think
it's fine to punt this problem of ensuring the forward progress to
user-space admin logic on the host.

>
> b. it eliminates false alarms that could occur with the "block update"
>    approach. Under the "block update" approach, updates would be rejected
>    whenever TD build operations are running, regardless of whether the ne=
w
>    module is actually compatible (e.g., when using the same crypto librar=
y as
>    the current module). In contrast, the post-update detection approach o=
nly
>    fails TD build or migration operations when genuine incompatibilities
>    exist.

