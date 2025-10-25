Return-Path: <linux-kernel+bounces-869674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8222C087BB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F8034E13C9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05DB1F37D3;
	Sat, 25 Oct 2025 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="30SDF+ls"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918CE1A9FB4
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761353696; cv=none; b=Gat3hF0uSPFSGcF5bbj4L8urw5PWHCoRKnzIGRXb2UcAlJDLb+2GkI89lpJqOosO57pQJSWkBTb2FkXi7OA/JLBut/P05pJklm0EwwYtbo34FItX6gMSrM0SOIxqB/6JRVNKVVe+XZStCi2WFvIrN0S42aY+hF8LVCGHyWw/eAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761353696; c=relaxed/simple;
	bh=FAa8qh/yrZ/DivWv0HekP569K1EcOK1GynHOSo9ol4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhd8PUz2Hojw4DKCJDhAF1VbkIP9z4UwnW1na3L7opp618j4pJczqhcnfpDYMbtHjnh38KOrSt/IP5o9oPRD+ZigCPK7+0OM+T7cZZh0BzUeytYWRbHkp1HDyJnaHPfoIVXv4KaeX1IRdVkAFPD+akn0sSsLJ2pHc6hhistWRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=30SDF+ls; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eeafd4882so85965ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761353694; x=1761958494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAa8qh/yrZ/DivWv0HekP569K1EcOK1GynHOSo9ol4g=;
        b=30SDF+lswvHj5UJ2oyrKDQLoVhuH2LJwDdeLuuxcl2Rx76jPp+Kw4xvey13ctlrxv8
         iKPhNJlncqXEI/oHWNLyK7GHm48OwfqWqBv8qorpVIu8sDWwDIHdv3AURbBfmwGFqvHG
         yeu1aPR+mOAjRxCwyDbGi4JR0djFJIskihE6Yk2yJb0i5I7w2+twx0cKiXSwfiEsyOsC
         qZnFK7I3d0AvmFCzIMluDlurw3/vFvGkNDlYgNY0aJHn9MN5v8upG2pJDvHLScMthrAW
         wqxZS1Ef4Z9bVN1sItOTlmyL47oJMvWpHHIvrZLzYQaVk6J5THwm44+qrTQnqE3U1xO4
         W8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761353694; x=1761958494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAa8qh/yrZ/DivWv0HekP569K1EcOK1GynHOSo9ol4g=;
        b=Gw3kZ1ZNtMPzG6ci8XllAkt91+q9pLWr5Q4ZKgrso+dt4Whx47K4phlVHQhXCDVg+c
         UQUgDLnvhfVT3ofaVsUAEfvaZ6WtCRdyyXGlyH8AlDouT9fl7NEBOp1Q+HZclYmeLiYK
         5Rb314jv4CHsXM48wS2murMt24q4a2Rd3mG/hw2t0WDRMSi7Mxc7wrRy+IILeb3joOm7
         NFkiQxDiDwA2OdmFs65GVaD1GoZC3CoSOEGQqcgmAy8FK5DudBwILGr3fMolKDy8K3Om
         Lf/Nth2d6D7fJ6whs4WqlkdaryNwURdBomT66WaA7fhYQvxbwuKHnz9+kQCeA8560RIG
         lBWw==
X-Forwarded-Encrypted: i=1; AJvYcCWfzNbGunR+yaAw7kIqEEghp1Lsdc2/9CwvQOIRb5lWuFBWSy4Wj2l30JzdvUxz7egZ/CGDnU5UeM3MlsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzolQpJV4kYA/76eHydJ/zi1SKOo1WPekV5Mx7/RXO/ja+FtncZ
	5/XZ81WMUBAZ1Je5s3gpxXCl7oxNGc7bqrfTTh9/YLDn5P//QPzrLva3teLR+DU66zHkXu8D4OA
	uKnrwChWOXhtHFXZZ9xU+wHQRgvkDRHN8/PbBgAcJ
X-Gm-Gg: ASbGncshyKBRcEihYccTI3f3pmtFDDIWxke9SJPOKBXfNrYB/u4zt858IYhZioAwUvv
	Cz72LOmW5KTNeexlEiiOLctZn7dAWa+2pKDjY552AilaRS8Avc1Sz7kmC8wFUB8fgfRbR4r6ufn
	htd/IjhCaCkoNP5WkHsWiSkmnZIaRxO1Kyt+pcw5XbUm8V6WuOLdael9+Pd3LgXkgVRm+FJwRSm
	MAVieIvJ6MomvDl+kU9alf5S1/xaNmWvtJr1HnIzdAVrsABx6oAGU8Dcz3CoZlUuxfDY/Aq+KPV
	dEWOy1LOARQx03LO
X-Google-Smtp-Source: AGHT+IHAZ97kNRS6LIm17OkKE+WVWsFtHlMK6rPjrAsP/+pfRZatmLGaC4FeacAc9nw5mRAZKQnmr9bJJldNrkXuH1Y=
X-Received: by 2002:a17:902:ce84:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-29497bb4f1amr2404035ad.6.1761353693538; Fri, 24 Oct 2025
 17:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com> <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
 <aPiEakpcADuQHqQ3@intel.com> <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
 <CAGtprH9bLpQQ_2UOOShd15hPwMqwW+gwo1TzczLbwGdNkcJHhg@mail.gmail.com>
 <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com> <aPsuD2fbYwCccgNi@intel.com>
 <ca688bca-df3f-4d82-97e7-20fc26f7d69e@intel.com> <68fbd63450c7c_10e910021@dwillia2-mobl4.notmuch>
 <2e49e80f-fab0-4248-8dae-76543e3c6ae3@intel.com> <68fbebc54e776_10e9100fd@dwillia2-mobl4.notmuch>
 <10786082-94e0-454e-a581-7778b3a22e26@intel.com>
In-Reply-To: <10786082-94e0-454e-a581-7778b3a22e26@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 24 Oct 2025 17:54:40 -0700
X-Gm-Features: AS18NWD48cIVeisP_Vz7McnMgruGX1KZ_wuEbrM37xSeUhKYSGdaLBQqN8lJETQ
Message-ID: <CAGtprH8AbW4P2t-wHVcTdfLwf3SJK5mxP1CbsMHTgMYEpLiWjQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: Dave Hansen <dave.hansen@intel.com>
Cc: dan.j.williams@intel.com, Chao Gao <chao.gao@intel.com>, 
	"Reshetova, Elena" <elena.reshetova@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
	"sagis@google.com" <sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:19=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 10/24/25 14:12, dan.j.williams@intel.com wrote:
> >> The SGX solution, btw, was to at least ensure forward progress (CPUSVN
> >> update) when the last enclave goes away. So new enclaves aren't
> >> *prevented* from starting but the window when the first one starts
> >> (enclave count going from 0->1) is leveraged to do the update.
> > The status quo does ensure forward progress. The TD does get built and
> > the update does complete, just the small matter of TD attestation
> > failures, right?

I would think that it's not a "small" problem if confidential
workloads on the hosts are not able to pass attestation.

>
> Oh, yeah, for sure.
>
> If we do _nothing_ in the kernel (no build vs. module update
> synchronization), then the downside is being exposed to attestation
> failures if userspace either also does nothing or has bugs.
>
> That's actually, by far, my preferred solution to this whole mess:
> Userspace plays stupid games, userspace wins stupid prizes.
>

IIUC, enforcing "Avoid updates during update sensitive times" is not
that complex and will ensure to avoid any issues with user space
logic.

