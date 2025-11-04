Return-Path: <linux-kernel+bounces-885264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12008C3269D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6B7C34B9BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D646337B9C;
	Tue,  4 Nov 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sEmE8SpK"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DB26562D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278349; cv=none; b=rt/q0tiCW6siTJzWENQy+1pdM0+AaF3PcB4QPCiuNPPXCDhzwUhQlRdf/L3ekKtMXRY6SXXxptMSH/uI2hkyCzrRDWmXs80m9HxglT93fcri0F1ohwPYJzQpJSuGEzcg8m955zTuF7ZYKO1n5GS7BI58GdVFZLUptFMmmjdDwmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278349; c=relaxed/simple;
	bh=fBHyh4lKIxCTDwgTRfUUKt+kE22zWmOu/3V7EgwlniA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jTjDeCivnZB/UwOFtBfFRkf5ZIQcXeG9amerNXah+iUEDtHiHzNuV0N82sdbalrVXczx0jDPoDgbDs8nz0tyfcbxvg9DRj4sZEPDdO0RpDdG7PaDy+FCAVJVuczV7oes3oBNR3wAgql4565ji7bYjgu3Wrfs3iDWgA+BLyyhigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sEmE8SpK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-294ecd3fdd4so69592415ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278347; x=1762883147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2Tu+KDxGtSxrgMOAtFN7Npf0pEh0K0jTPtmg/yHZME=;
        b=sEmE8SpK0MCEHoqslmCpgj+evljko+l+ijzIxZMD6ViyAteeVa7bpoCpPG9Vt5xWrI
         YZqcCrcih3iTl9L2KXjWTyAHA3BWc0f3KkNTAAPZ9/AgoB6E1bgnZL3+ehmn3IP8Db8M
         VUZeREi1Ja32vX3+RIjUqbcclL4DHXjeBeaU0sHKSrS2rDvdSQ4x77+ra5p/FnPgNLWD
         ZCT+NGCqY/x/dLoztP2bDy/O2i3g+lB7ywKCjWskV1TN73el19Gf88ZdtskrrzUEdnlM
         srkljSLavv3tJvzfJWwDsyK+U20rwQ+QO5jvnJeTFutWJKVDwGLIs+Ofgng+046lOPas
         W/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278347; x=1762883147;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z2Tu+KDxGtSxrgMOAtFN7Npf0pEh0K0jTPtmg/yHZME=;
        b=r2UIqe5Sv4JXCc4MDoiijRhKOS/9t+u+8iATMWnJKikpkb0KrGps68MGSPH7/mcx/d
         AuluU5zyAwJZ8XQRGMzuHcjG7vysxUuZ1A4qKsoKsn0pdBCXmhUA8tVHvMhb6+4wfJ7q
         yNXv7Gcdfmog92HowNttsAkb6/LmOK/sn5YeQFRNZcYCMAWVTI9pPKyHfpOvkBGRHRXj
         nUgWHJCjxQPwW5P9zP/SX0dRLYfQpplyvaBUKvfRMYEVdOTzlAFd+GCmUZLU8kYh3tIj
         SC+W42+3XuRrWYujgBK4IO03dMvnyvYh/2tC6fqhkRPieHXMbxxZko1FqMj4odCBFn9V
         1wOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlOQ4pruJ6n7n/s08mYd9XT3zRUIppfeLZoXZ+PR0ON3LqzDLqfMr/Qoup8Kd8pLV9RzEHvN8cIGNlksE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwidcNXuavk47cDiPxbfb5PVyHl4FPgjH4/DLw6hjatOUCuWy22
	kBEBJIG9Htve9Sw52gyI2dywgVGpZwS3ZANEAbIYHU2z1HBO98svYI/cGRZY/CiGVJXuxKDyjUC
	pp63kbQ==
X-Google-Smtp-Source: AGHT+IFv3dUrYmn1lVlBlYev0eg/cf2TWmxof3SNenYFyvB6TqMDKe0rrPAkSHQAlVHpWcI5k2MtUqf2+Ns=
X-Received: from plrq15.prod.google.com ([2002:a17:902:b10f:b0:295:5948:f5d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0f:b0:252:50ad:4e6f
 with SMTP id d9443c01a7336-2962ade2bccmr5238175ad.54.1762278346475; Tue, 04
 Nov 2025 09:45:46 -0800 (PST)
Date: Tue,  4 Nov 2025 09:44:56 -0800
In-Reply-To: <20251028060142.29830-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028060142.29830-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <176227794159.3934184.6943075964127868106.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Call out MSR_IA32_S_CET is not handled by XSAVES
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2025 23:01:41 -0700, Chao Gao wrote:
> Update the comment above is_xstate_managed_msr() to note that
> MSR_IA32_S_CET isn't saved/restored by XSAVES/XRSTORS.
>=20
> MSR_IA32_S_CET isn't part of CET_U/S state as the SDM states:
>   The register state used by Control-Flow Enforcement Technology (CET)
>   comprises the two 64-bit MSRs (IA32_U_CET and IA32_PL3_SSP) that manage
>   CET when CPL =3D 3 (CET_U state); and the three 64-bit MSRs
>   (IA32_PL0_SSP=E2=80=93IA32_PL2_SSP) that manage CET when CPL < 3 (CET_S=
 state).
>=20
> [...]

Applied to kvm-x86 fixes, with an opportunistic tweak of the comment (the w=
hole
spiel about the safety was attached to the wrong function).  Thanks!

[1/1] KVM: x86: Call out MSR_IA32_S_CET is not handled by XSAVES
      https://github.com/kvm-x86/linux/commit/cab4098be418

--
https://github.com/kvm-x86/linux/tree/next

