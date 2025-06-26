Return-Path: <linux-kernel+bounces-705342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17305AEA86A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 22:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2641C41E21
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2633523B622;
	Thu, 26 Jun 2025 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqhnfKT+"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C511DFFD
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750971012; cv=none; b=IguhoeCqqdeRirBHjvEoAqc/nmzln+2UwkitSpk2KCapMCe9d2KGefxRhQCAnpaIiEI7prvaE6m9cj0cqLep9+g5iE0UoIuYOpUpsrstvBUTeempmyLCXjP8YoWgetb86HOgv6aRf8XQseih7ue9F18LiH2I42eHktSR9tpJnSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750971012; c=relaxed/simple;
	bh=0B+GG0V9IxayHUjd+GrM2c+j6iCMSNSpCAoduPtwMhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K+67bEanl5MeDk++kVb/Q33STx6JFSgzskB+Z22IFmEcNPDj7OmaWu9Q7TpdcpDqaREnrG1Zf9QMBbGsi/WQgA53DWR/atKmmgssbI9o9WnLvQZxlqAklEGL+PVmF66/3s5iaJtm1g2lpsdbQiQBapnLGWzFTIxso7+NBqzegX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EqhnfKT+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ad608d60aso1145580b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750971011; x=1751575811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7OlW39s6ulMaqljMLUWDij/EiBowAxWTwHoPBioqCw=;
        b=EqhnfKT+hDusE1aTwykpY1/5vhixXbk7JkMhUqvQVSAPYWWc+oTZKOw9q8kOhkz714
         gLoBasHaTRtvuQtV6op9rsKnkXm/KGjtcEyBMCDFBIAPZ5v6tlaL+kD85Fjid0/8EoTr
         96FPF1NFXfZOm3l6s6qUOiZDKmdJVArYteoV7vl0LGgFxIMPENOQvLR8aif1rcfwIRWG
         Uyndrz9RhBzI6B0FJzuIB0jDPP1K8+XuJPPHIOJlAH1NembqL4aI/dozzNde8hS8l4Ip
         qu2h44DxBaVJslUTy4xjYTifS1917TAceRqpolmpkZ5AeLIdO8sTBz7qNbwGwtmnoHzZ
         ST4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750971011; x=1751575811;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C7OlW39s6ulMaqljMLUWDij/EiBowAxWTwHoPBioqCw=;
        b=T6zD8hWMlEkst+uVYNkJGq49ntR7Sy3lIm6xzyxIvSwVjnRtT1pyoiK3Lx5lcPNuIS
         LFJuXfXjDd5q8SHuTrieVEY2tGpXSnovVFKtQvaT9VQVyf8qV+kWTK/lsaQTqlL0bvLt
         t1bxLUCPamUzkmrM/JkFlyS5tSM/Mlri1LYSlwxFVBxoSqfZqOpgmE0x2mEhDTSgh4wU
         mDckeTT9zhI9roaEBUWcaz5MyEyMYGVRRCuOYrPIrWt70hUU27PvZSD416uD3pvo6LIZ
         J/x2XH3BOIxHSLcduYKiz1jAYaogynFqkCAlwpKAQZ6TKaD4CZLqn35EEoMEy1hIoDwf
         x0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVSfMmE5Thx5w7l3jtiSOm9i/GzDHQJl7NZbnpXEaU6u5Skam3UngreMbAXk8kgNt99kpE/mt0QDWJID+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXS1lobINGU9uGq35QypmzKlvs8B7AB8qWXmwwTXteSOtml9s
	vRlaPH41sdCjNFJkI9Udq4FcWnRzbkHzyD7XSt5AXS8uV6rxNagMgPKuWqrtek7wQF6zmJnsqZ7
	ry/4Wbg==
X-Google-Smtp-Source: AGHT+IEvqZwxFHUi+bQpaauJGtY8KGrib3OUPRdkSaQ6XydD6Sn6vov8+Sgs49EQUuL4CN8i3MDM/JPkMv0=
X-Received: from pfbdo6.prod.google.com ([2002:a05:6a00:4a06:b0:749:1d32:aa78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e1e:b0:748:2eb7:8cc7
 with SMTP id d2e1a72fcca58-74af6f79db6mr649612b3a.21.1750971010693; Thu, 26
 Jun 2025 13:50:10 -0700 (PDT)
Date: Thu, 26 Jun 2025 13:50:09 -0700
In-Reply-To: <003b5de7-502c-47ba-ae46-0905ee467384@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328171205.2029296-1-xin@zytor.com> <20250328171205.2029296-9-xin@zytor.com>
 <aFrR5Nk1Ge3_ApWy@google.com> <858a3c30-08ab-4b9b-b74c-a3917a247841@zytor.com>
 <003b5de7-502c-47ba-ae46-0905ee467384@zytor.com>
Message-ID: <aF2ygVI8MN5IrAcg@google.com>
Subject: Re: [PATCH v4 08/19] KVM: VMX: Add support for FRED context save/restore
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, andrew.cooper3@citrix.com, luto@kernel.org, 
	peterz@infradead.org, chao.gao@intel.com, xin3.li@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025, Xin Li wrote:
> On 6/25/2025 10:18 AM, Xin Li wrote:
> > >=20
> > > Maybe add helpers to deal with the preemption stuff?=C2=A0 Oh, never
> > > mind, FRED
> >=20
> > This is a good idea.
> >=20
> > Do you want to upstream the following patch?
>=20
> As I have almost done addressing your comments in my local repo, just
> sent out the patch.

Saw it, and the LKGS patch.  I'm OOO for a week, so I probably won't get th=
em
applied for a couple weeks.

Thanks!

