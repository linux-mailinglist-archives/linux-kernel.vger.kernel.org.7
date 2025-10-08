Return-Path: <linux-kernel+bounces-845711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ACCBC5F85
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097454223D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2164E29E0E7;
	Wed,  8 Oct 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rmzgu+5J"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA2D221DB1
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938927; cv=none; b=VpeUzeb2vzfg4AUKi0HaLnR/0mmBhAC7kADn+6jChj5t7BUf32rQCZ/cYlAHbNeP7Gu5fQcUlBnw/tnbbJYEccGASPlinAVxRckdHoDFi/ITS8aEqcAegLuKnvMCVlqlfbmWKGVGlgqv/d5Y3+T2a9Bo8NWvSAUSUNxdmw+QNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938927; c=relaxed/simple;
	bh=85/mm3sXpOoNOn6cTJ/JXyXBRwl6do61EpL+5QUva/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYhXyHSCF9ge8em0T0tFVMDUunn+xLU1H7f/6gtGqt2SIRM9NFV+myhW6+xLQuqTGL/gllJNHOn/iBb6Ff+qIkjFtV7axFRBayCp30Sj+vV51eGaO+MXYvZhFM7bpVi+Dm97z3X4JH5nQRlFCjK7Eh0aqIz3+AlVBPAVXWBl3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rmzgu+5J; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-272ed8c106eso50763165ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759938925; x=1760543725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yE/1NjviAjYgzvKEBWocmDsuG1eu4K2fZd8EwARCmAo=;
        b=Rmzgu+5JNaP/UN9JgmylzNruOIukS2R/xVk7j7Iqnnhl7MKPZ1UjPISJYpLxpxV/6u
         s+lQHSnOnijkTV0g2ym7gBYtC7eJsR7CAQGVFVR0aNCjeDWVu1a5MpmtRGFhw2re+oek
         FDQ16zrGEgJr3qBS2LnUS7Gctro8DA/G8Qys02TF0kqGX3R94iL5ZkJJnpdOHD97Xa+l
         xOVX9Gzja6xl2NIO+mWzGnpNeFTqEwdNiJ/FnK94+nxPN2bDNqZvp60mCCtF7gAx8xnE
         GicmN0Fa8TLdlu+KlUx2LU5sZHiA5CmaQ++OO0UfqWJPo2TQrcPwwYFQ0CxlOh0gwS8k
         WuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938925; x=1760543725;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yE/1NjviAjYgzvKEBWocmDsuG1eu4K2fZd8EwARCmAo=;
        b=uhVKt8WsPeHY+tsELxxZowG5e3eVIrExV3xIKT/JTG97neA3h80b1Re1eQF6FClMZ+
         vB0DndPko3NemtbaGfIGq8OIknC49MFM07WHPiZBxlIhgTEIb+T/x/wAhkdmquawK3sM
         IHEYqaRkpAJMEIET15nViH5F6oI/T7npBy3xjh9w7xR2EwtaWAn9VJ3MyRlbHmosR6iC
         j67SkpEP2cKtz/RGHp1Ueqo0UGcMEerExS/6Jw89aE76B+wgGfsAslWLRXkod7CiwqxX
         MHmH50Sqx5BnAO09famu+TtSEQv5nJTOPUn9tB9HobtBrLiqKYarnkOAtyd2VZte4APx
         koeA==
X-Forwarded-Encrypted: i=1; AJvYcCX281/BX1Z6OsRPo8IzC/Ci+Fkn82UiM0iqLg0ykD9rm15J7068A8hJiv4lf11HCZWSlk5Y0XlXRKnvEgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGFJzpdSE2+liGxr1J3HYli7ddMMDK/K3ix0EtBTqUN3eRYZn
	sb44jfBl+/9kJZujVAsG4jlQE/2cKmxZ13N1C579fapRRTtb9ZpyrYL2nvYKIXegNnc0z4bkdko
	aDqN5Ug==
X-Google-Smtp-Source: AGHT+IHNZ9o1aucHiV07bHDBIvskxFmukfMK9SZ5tpZZEnJ+tyDCdecEFDLxuqTyrcbJu7v6jlO0OKadLqQ=
X-Received: from plblv11.prod.google.com ([2002:a17:903:2a8b:b0:234:c104:43f1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac7:b0:269:9a8f:a4ab
 with SMTP id d9443c01a7336-29027321d6fmr43055485ad.60.1759938925410; Wed, 08
 Oct 2025 08:55:25 -0700 (PDT)
Date: Wed, 8 Oct 2025 08:55:24 -0700
In-Reply-To: <CAMGffE=P5HJkJxh2mj3c_oh6busFKYb0TGuhAc36toc5_uD72w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <539FC243.2070906@redhat.com> <20140617060500.GA20764@minantech.com>
 <FFEF5F78-D9E6-4333-BC1A-78076C132CBF@jnielsen.net> <6850B127-F16B-465F-BDDB-BA3F99B9E446@jnielsen.net>
 <jpgioafjtxb.fsf@redhat.com> <74412BDB-EF6F-4C20-84C8-C6EF3A25885C@jnielsen.net>
 <558AD1B0.5060200@redhat.com> <FAFB2BA9-E924-4E70-A84A-E5F2D97BC2F0@jnielsen.net>
 <CACzj_yVTyescyWBRuA3MMCC0Ymg7TKF-+sCW1N+Xwfffvw_Wsg@mail.gmail.com> <CAMGffE=P5HJkJxh2mj3c_oh6busFKYb0TGuhAc36toc5_uD72w@mail.gmail.com>
Message-ID: <aOaJbHPBXHwxlC1S@google.com>
Subject: Re: Hang on reboot in multi-core FreeBSD guest on Linux KVM host with
 Intel Sierra Forest CPU
From: Sean Christopherson <seanjc@google.com>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: fanwenyi0529@gmail.com, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Trimmed Cc: to drop people from the original thread.  In the future, just s=
tart
a new bug report.  Piggybacking a 10 year old bug just because the symptoms=
 are
similar does more harm than good.  Whatever the old thread was chasing was =
already
fixed, _10 years_ ago; they were just trying to identy exactly what commit =
fixed
the problem.  I.e. whatever they were chasing _can't_ be the same root caus=
e,
because even if it's literally the same code bug, it would require a code c=
hange
and thus a regression between v4.0 and v6.1.

On Wed, Oct 08, 2025, Jinpu Wang wrote:
> On Wed, Oct 8, 2025 at 2:44=E2=80=AFPM Jack Wang <jinpu.wang@ionos.com> w=
rote:
> > Sorry for bump this old thread, we hit same issue on Intel Sierra Fores=
t
> > machines with LTS kernel 6.1/6.12, maybe KVM comunity could help fix it=
.

Are there any host kernels that _do_ work?  E.g. have you tried a bleeding =
edge
host kernel?

> > ### **[BUG] Hang on FreeBSD Guest Reboot under KVM on Intel SierraFores=
t (Xeon 6710E)**
> >
> > **Summary:**
> > Multi-cores FreeBSD guests hang during reboot under KVM on systems with
> > Intel(R) Xeon(R) 6710E (SierraForest). The issue is fully reproducible =
with
> > APICv enabled and disappears when disabling APICv (`enable_apicv=3DN`).=
 The
> > same configuration works correctly on Ice Lake (Xeon Gold 6338).

Does Sierra Forest have IPI virtualization?  If so, you could try running w=
ith
APICv enabled, but enable_ipiv=3Dfalse to specifically disable IPI virtuali=
zation.

