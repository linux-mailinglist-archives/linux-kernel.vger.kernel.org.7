Return-Path: <linux-kernel+bounces-681940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DEAAD5953
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4D53A5525
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1802BCF65;
	Wed, 11 Jun 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pt6KqQMd"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6727E7C6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653676; cv=none; b=MNnOWzQ5pdw1BUefY+QVzB2sZRqcN+3l57WL03GJc8gBvOpSibN6N4EdDkbbA4zfOVzNguImeG+W1X70e8/VKEGMcO1QM8U/8BsQnamKow2T2N65tdgxGlzbPggl4XSOWjpu19oapmxdOIV9md79ILrIEJCA4K2Ow4F09p+aC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653676; c=relaxed/simple;
	bh=zCBUsmQCNtzpOKb3kzZfDwL9Y2XTMaJp4Ho4TyPBe+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KgagsfdEg2/A6yjn1jHfw60MmvpuZ5LXJhWTdYXlph0rwoQO23KS9YaYHLadu/YjDiFElZk+BlqEcNOI6yHUE2GGPnoMD7zYFtsBxXi3ONlfdVDDNmkpt+l0L1z7WthcFwPIeO/jqqxi7mvy6ndmv6NUX1TBXrTRQON5CaXy3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pt6KqQMd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311b6d25163so5817060a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749653674; x=1750258474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7dU2XMq7cH0BFFGQ+DgqIHQtmep1TbKLe5KJJmPBu4=;
        b=Pt6KqQMdzHfULXCcrfX4BbWmWnZn7NgcfvZp/hGl8FCPbgv4WgJNh7mUN3EEP/wyAI
         AIh4mLWs1sC/ZdI6Pfcz+kXr3ucywqBqUjknrybwSjzyV9fhB/Odj5RdBRLA2WxxSFBD
         vj6tVnbwG8/SK38nyD5J+glCQfeKkwa28D0xolxHWnxugsF8onx9qTkCGKvSlWkUuE4q
         v7MdmZ8C378CuxEfvpth90GFE1Ptr9dQ5G0d7PBWXCQtEykxqSOxHbdJ6hoHm+qj0KWz
         A8CJyJRq7ZAun5wtxsBhOY/BXTbITOBhXr+66HzGqW97ok8Qc0lY3tppyfR2N4jslFyH
         3ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749653674; x=1750258474;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d7dU2XMq7cH0BFFGQ+DgqIHQtmep1TbKLe5KJJmPBu4=;
        b=SYGoKRNTJ5vRamj4VLC14TRpwbW3xx2Qu3oh+TsYfI1ctZuhPX+ZbjGgHguQbaCECJ
         YEzQGeCj+C95Owt79jGqzIhHkZrDb1WbtcYYp9FM7JmRoD300+D9bQUdojrp5/Xx68OW
         PC7fWna3omDvHMWCBp7V6tuAo41aHOWTLB6p4Zga+L5UWBYw9bxUXMzBa6i87eX24kdc
         OIaSyGkRR1kK6CQ+nPsQBtFfl9OdKyeQwDW5ursZd9HvOGajdXHy5u3bGZYjUfKBSM45
         xEnepX8tvFeyGvzFTVWWWYuulViJjweAjtPambfEu3DdwhfY8JHU/Nt8YwbtrEJiCrbh
         xjPg==
X-Forwarded-Encrypted: i=1; AJvYcCXMNWGCkd67KhIGw+rKqNWqUVjx4ytNSvnhSuqrpKdoI/e1nbrip20oDeX87N758AgTgiOZ484lQgbwiqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/KOsLtZjdKvcN+8fhuxFQBdZSCxw6+zDkQv+kjnJCNcZ0riy
	WDQmwmNShQt0QGfPAncYt5Ic4F/RxmMBa23gq+dCoXKXoXdplDbS/cB6SIIeCW/rXPKVb8g+nKB
	O0QfacQ==
X-Google-Smtp-Source: AGHT+IHjT9+x0VCM9Pw4MWr32hSRzkY7bgSAUFaQJkT6BKWZAAEydapOPokmqOEJAXru1zHxzAthq+kZwNQ=
X-Received: from pjbqo13.prod.google.com ([2002:a17:90b:3dcd:b0:311:a4ee:7c3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3802:b0:312:1ae9:1525
 with SMTP id 98e67ed59e1d1-313b1ee6608mr4132239a91.8.1749653673748; Wed, 11
 Jun 2025 07:54:33 -0700 (PDT)
Date: Wed, 11 Jun 2025 07:54:32 -0700
In-Reply-To: <7f17ca58-5522-45de-9dae-6a11b1041317@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250610021422.1214715-1-binbin.wu@linux.intel.com>
 <20250610021422.1214715-4-binbin.wu@linux.intel.com> <ff5fd57a-9522-448c-9ab6-e0006cb6b2ee@intel.com>
 <671f2439-1101-4729-b206-4f328dc2d319@linux.intel.com> <7f17ca58-5522-45de-9dae-6a11b1041317@intel.com>
Message-ID: <aEmYqH_2MLSwloBX@google.com>
Subject: Re: [RFC PATCH 3/4] KVM: TDX: Exit to userspace for GetTdVmCallInfo
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, rick.p.edgecombe@intel.com, 
	pbonzini@redhat.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	adrian.hunter@intel.com, reinette.chatre@intel.com, tony.lindgren@intel.com, 
	isaku.yamahata@intel.com, yan.y.zhao@intel.com, mikko.ylinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, kirill.shutemov@intel.com, jiewen.yao@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025, Xiaoyao Li wrote:
> On 6/11/2025 9:37 AM, Binbin Wu wrote:
> > On 6/10/2025 5:16 PM, Xiaoyao Li wrote:
> > > On 6/10/2025 10:14 AM, Binbin Wu wrote:
> > > > Exit to userspace for TDG.VP.VMCALL<GetTdVmCallInfo> via a new KVM =
exit
> > > > reason to allow userspace to provide information about the support =
of
> > > > TDVMCALLs when r12 is 1 for the TDVMCALLs beyond the GHCI base API.
> > > >=20
> > > > GHCI spec defines the GHCI base TDVMCALLs: <GetTdVmCallInfo>, <MapG=
PA>,
> > > > <ReportFatalError>, <Instruction.CPUID>, <#VE.RequestMMIO>,
> > > > <Instruction.HLT>, <Instruction.IO>, <Instruction.RDMSR> and
> > > > <Instruction.WRMSR>. They must be supported by VMM to support
> > > > TDX guests.
> > > >=20
> > > > For GetTdVmCallInfo
> > > > - When leaf (r12) to enumerate TDVMCALL functionality is set to 0,
> > > > =C2=A0=C2=A0 successful execution indicates all GHCI base TDVMCALLs=
 listed
> > > > above are
> > > > =C2=A0=C2=A0 supported.
> > > >=20
> > > > =C2=A0=C2=A0 Update the KVM TDX document with the set of the GHCI b=
ase APIs.
> > > >=20
> > > > - When leaf (r12) to enumerate TDVMCALL functionality is set to 1, =
it
> > > > =C2=A0=C2=A0 indicates the TDX guest is querying the supported TDVM=
CALLs beyond
> > > > =C2=A0=C2=A0 the GHCI base TDVMCALLs.
> > > > =C2=A0=C2=A0 Exit to userspace to let userspace set the TDVMCALL
> > > > sub-function bit(s)
> > > > =C2=A0=C2=A0 accordingly to the leaf outputs.=C2=A0 KVM could set t=
he TDVMCALL bit(s)
> > > > =C2=A0=C2=A0 supported by itself when the TDVMCALLs don't need supp=
ort
> > > > from userspace
> > > > =C2=A0=C2=A0 after returning from userspace and before entering gue=
st.
> > > > Currently, no
> > > > =C2=A0=C2=A0 such TDVMCALLs implemented, KVM just sets the values r=
eturned from
> > > > =C2=A0=C2=A0 userspace.
> > > >=20
> > > > =C2=A0=C2=A0 A new KVM exit reason KVM_EXIT_TDX_GET_TDVMCALL_INFO a=
nd its
> > > > structure
> > > > =C2=A0=C2=A0 are added. Userspace is required to handle the exit re=
ason as
> > > > the initial
> > > > =C2=A0=C2=A0 support for TDX.
> > >=20
> > > It doesn't look like a good and correct design.
> > >=20
> > > Consider the case that userspace supports SetupEventNotifyInterrupt
> > > and returns bit 1 of leaf_output[0] as 1 to KVM, and KVM returns it
> > > to TD guest for TDVMCALL_GET_TD_VM_CALL_INFO. So TD guest treats it
> > > as SetupEventNotifyInterrupt is support. But when TD guest issues
> > > this TDVMCALL, KVM doesn't support the exit to userspace for this
> > > specific leaf and userspace doesn't have chance to handle it.
> > Previously, I also had the idea of setting the information based on
> > userspace's opt-ins.
> >=20
> > But for simplicity, this patch set doesn't adopt the opt-in mechanism f=
or
> > KVM exit reasons due to TDVMCALLs.
> >=20
> > To resolve the issue you mentions that userspace could set a bit that K=
VM
> > doesn't support the exit to userspace, KVM could mask off the bit(s) no=
t
> > supported by KVM before returning back to guest.
>=20
> silently mask off the value provided from userspace is not a stable ABI f=
rom
> userspace perspective. A kvm cap to report what value is allowed/supporte=
d
> is still helpful.
>=20
> > If we agree that it's the right time to have the opt-in, we could go th=
e
> > opt-in way and KVM could set the information based on userspace's opt-i=
ns
> > without exit to userspace for GetTdVmCallInfo.
>=20
> Let's see what Paolo and Sean will say.

Kicking this to userspace seems premature.  AIUI, no "optional" VMCALL feat=
ures
are defined at this time, i.e. there's nothing to enumerate.  And there's n=
o
guarantee that there will ever be capabilties that require enumeration from=
=20
*userspace*.  E.g. if fancy feature XYZ requires enumeration, but that feat=
ure
requires explicit KVM support, then forcing userspace will be messy.

So I don't see why KVM should anything other than return '0' to the guest (=
or
whatever value says "there's nothing here").

