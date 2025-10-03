Return-Path: <linux-kernel+bounces-841303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7AFBB6EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 607004ECD31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8582F39A8;
	Fri,  3 Oct 2025 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5eqvfXh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0412F3632
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759496977; cv=none; b=ASyD7tCdX3Lwg0iHSaxnPKHF4Mux8b/8GiH8pSLwrz9fNBowa32iHG3CKSyo5BkIlweGYqJHRwAYJbnPjlHghOfuDGryHD/g13mg/420feeDaQn5EcApr3DEr34n8nIl1sum++RDdSeVCBbrCy/QK+c0Rl/uaHObO4QPBjScDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759496977; c=relaxed/simple;
	bh=0Xw4OrpjWdDORDcldR9v9bzLrfr0F1CBruVxe1CW9mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCNpWH+dvqvZh/Gi/kD3dFKffk5n6N49gIa454r9yALrsuIzWeqrjzswDqdhjTM1DfBUgtPZSjGHxXw1hJovFrU7F+GHwFbMB9uOCW6qWlD76PXxrOkcihZ3l7XlIaMMD4dlLx5HQKmAWa7bB0TJNJKyLjC5ZWm8UCMNFn9T3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5eqvfXh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759496974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eg6B+28DeYgN6XdKeJOVznWh4ZfZPQPBD7mqFN84nc8=;
	b=L5eqvfXhTYts3+xlfQv40gD7Yq2y38pzckalzAUQixQgwEWJvTglhStY704IwUoX2MbKEQ
	1NP83+B+oM2sOQzlirfQ4paCoLkn5Uf7qRD4tFtgMzFvkY5YWFBxhQVRnNNtLxcTdXFveG
	NyY0jtkWNoYkkFfjRz4bNUGe12+hLxk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-_YpQDRWOOEqmPmnufmZ1Ng-1; Fri, 03 Oct 2025 09:09:31 -0400
X-MC-Unique: _YpQDRWOOEqmPmnufmZ1Ng-1
X-Mimecast-MFC-AGG-ID: _YpQDRWOOEqmPmnufmZ1Ng_1759496970
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso1024037f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759496969; x=1760101769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eg6B+28DeYgN6XdKeJOVznWh4ZfZPQPBD7mqFN84nc8=;
        b=CGu3MtgrcGkTDymBxWA1TAzrkiaSEOFrQT+RaBAQbvcWJyGOLpKLgCnlPVYf703+22
         HoG4f96JW0+SyIhGB0dcxg6PEG5xlSjfpqs36Lj7fMRDMrFy7suYH+PwmUbQwyGHmgYS
         sjYgs25Rpk3UJHycJt3CGZtcysZEmOdrtRqHSJLLdfINTZsev0B1dVc4mIRBN2mOA+FK
         unTtCj5qSgjOmRA8MqBdAVpZ4UGL+q+chv8C44i+VKw5Z4LrfozzAJiIRlt7jeVzflXD
         o0lAuwMQR0m3SwoFcGIVlFwVl/mGfv6R0AlF7L6BTLkdv8VJftNlLb+W7MjZughUpmcc
         LahA==
X-Gm-Message-State: AOJu0Yys2A4kft68z6/r1ml6igUh7frF7xIO+COZn3l1ZkoYEip73dqp
	ZBYm6TfZYqEXprG/r0LotrVTQktWXYlnhxwHct5FMOf+ZF9hWCvGB0Cl7kUnXbJpU7WZDuh1cNs
	pSYqCgl8qu1H60y7cAVFoEkwup8W4IxJvrOeHMKTGUrLycvWo5GX5vyJUTwUqxWR+GoBr+cQzze
	jwajt/zqQdND7f0aMLpqTkkoB5U6C1xzHHrpWcvI27OdxciZB4
X-Gm-Gg: ASbGncsk65qTDJlWmv/JR7XBlKifVjaQBj5hPnEznHsR//dn3VbI1SDyinwJ0+DHFEF
	95PYJZ4E0GPHBDFWBIO1auFJ6526XVaiy0BH05qaJGZaGNgl+wknvFstbn7UhuWEtx9d6TcM9uo
	rGvfb7wZMHAavRgplZSaMNlnosOI+elCypfMY+ke8bYKc//ALKfsoBu1sc3RYGB6u2BBYvxBcTp
	WeVprPTPiFR7yDyvXhuKYFClb3MHA==
X-Received: by 2002:a05:6000:2583:b0:407:23f7:51 with SMTP id ffacd0b85a97d-42567139c92mr1640641f8f.1.1759496969096;
        Fri, 03 Oct 2025 06:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzAenVtcphcMGAWHYvO2v3kNfpOU2vJxj0QqILnulExcDPJNr8MPCwAVl6rlHmLadXK2j/bt5MbGd1fhqTEe8=
X-Received: by 2002:a05:6000:2583:b0:407:23f7:51 with SMTP id
 ffacd0b85a97d-42567139c92mr1640625f8f.1.1759496968712; Fri, 03 Oct 2025
 06:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901160930.1785244-1-pbonzini@redhat.com>
In-Reply-To: <20250901160930.1785244-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 3 Oct 2025 15:09:17 +0200
X-Gm-Features: AS18NWAANVc028IrEWCYH8_s3j0p7D-JkOKS1W3aZhhlnuZ_7HZRUQfOviWSiqM
Message-ID: <CABgObfb0Qc3hdXTmZvOykxuR+7RZ4vRUBpm8M84UmHgjwx7BCA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] TDX host: kexec/kdump support
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, dave.hansen@intel.com
Cc: bp@alien8.de, tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com, 
	hpa@zytor.com, thomas.lendacky@amd.com, x86@kernel.org, kas@kernel.org, 
	rick.p.edgecombe@intel.com, dwmw@amazon.co.uk, kai.huang@intel.com, 
	seanjc@google.com, reinette.chatre@intel.com, isaku.yamahata@intel.com, 
	dan.j.williams@intel.com, ashish.kalra@amd.com, nik.borisov@suse.com, 
	chao.gao@intel.com, sagis@google.com, farrah.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave and others,

any reason why this series was not pulled into 6.18? I was a bit
surprised not to see it...

Thanks,

Paolo

On Mon, Sep 1, 2025 at 6:09=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Currently kexec() support and TDX host are muturally exclusive in the
> Kconfig.  This series adds the TDX host kexec support so that they can
> be both enabled in Kconfig.
>
> With this series, the user can kexec (including crash kdump) to the new
> kernel at any time regardless of whether TDX has been enabled in the
> first kernel.  One limitation is if the first kernel has ever enabled
> TDX, for now the second kernel cannot use TDX.  This is the future work
> in my TODO list.
>
> This series should go in through the tip tree.
>
> Thanks,
>
> Paolo
>
> v7->v8: stub out the new code when kexec is not enabled in the kernel.
>         Of course even the smallest code change is subject to bikesheddin=
g,
>         and I chose my preferred color for the bikeshed.  But it's pastel
>         green and I'm sure you'll agree that it's beautiful.
>
>
> Kai Huang (7):
>   x86/kexec: Consolidate relocate_kernel() function parameters
>   x86/sme: Use percpu boolean to control WBINVD during kexec
>   x86/virt/tdx: Mark memory cache state incoherent when making SEAMCALL
>   x86/kexec: Disable kexec/kdump on platforms with TDX partial write
>     erratum
>   x86/virt/tdx: Remove the !KEXEC_CORE dependency
>   x86/virt/tdx: Update the kexec section in the TDX documentation
>   KVM: TDX: Explicitly do WBINVD when no more TDX SEAMCALLs
>
>  Documentation/arch/x86/tdx.rst       | 14 ++++-----
>  arch/x86/Kconfig                     |  1 -
>  arch/x86/include/asm/kexec.h         | 12 ++++++--
>  arch/x86/include/asm/processor.h     |  2 ++
>  arch/x86/include/asm/tdx.h           | 31 +++++++++++++++++++-
>  arch/x86/kernel/cpu/amd.c            | 17 +++++++++++
>  arch/x86/kernel/machine_kexec_64.c   | 44 ++++++++++++++++++++++------
>  arch/x86/kernel/process.c            | 24 +++++++--------
>  arch/x86/kernel/relocate_kernel_64.S | 36 +++++++++++++++--------
>  arch/x86/kvm/vmx/tdx.c               | 10 +++++++
>  arch/x86/virt/vmx/tdx/tdx.c          | 23 +++++++++++++--
>  11 files changed, 167 insertions(+), 47 deletions(-)
>
> --
> 2.51.0


