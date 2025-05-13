Return-Path: <linux-kernel+bounces-646416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74828AB5BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 19:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B6E8C11B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBDF2BFC63;
	Tue, 13 May 2025 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acH8k/2y"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120E2BF96F
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158852; cv=none; b=WHkX1IJa4B5gK7LcMn8to+T/F77GSXzSWaNIjk3FeL6y+YZutm/Ezn7xrH9odf8AktdVciWdgj+5uRpnovOJaY3moudH4b3U/AgRd7XcREzS9IXQVsPa8lSTc8At5Yc/b7FbZvm2sDqW2VCxcmlIaH081oyd/luxn0HLD9ItYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158852; c=relaxed/simple;
	bh=ZETV0SyLB51ABOS7GCLSTe/c/Lkm4H/VBnpprfCzoQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BsSdCE1gPLEthbqOZGOLe2vciERDk9+p6SpuS2RwU9E/zWKAMNTxYpAv4MOr9tKI0HaPB41HHom2rUvRd639F1eoCWRlaPfwrOkViRi6x4HPQoVCW9rtwSlIikDyvIhSu09lrdhP+uWDDLmWTgKTZFK/cnhOpBEdWbNs/ulIODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=acH8k/2y; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b20027d9ac0so3382506a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747158849; x=1747763649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1ScAKPK9lKlY9UgspugLQpSKdL/YPUt4UHrgfW8UlU=;
        b=acH8k/2yIcyjz1Sa059qHVw9qnQFUxllHvkDqapLBEOE3oo7FcVxe2nZrPWWf1XsrX
         zS3BlX0T5FFqqT00iktnn8cHB/BExnlbl7HKTk2k25gRxZvoihIL6gzWC6jomF2Qi4OQ
         WpHVlAU93merFMOXUxCasis/OjdGNInTmc9p8iyyNchBxEwPlu6A1KfJrTJqVe+yz2vR
         ztBIvHAiKq8UuAVJEEdOU6h90H1cevVv0u1/UIE3/qt7MM25RQRBaYWWZdthQE5ozGNH
         sxo8J6jVMgre9UhdKjUI/v5b6kMkSl96XtvbLHsKMmSQ2JTV4OHg6mHXgARFhFeAS9VS
         beUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747158849; x=1747763649;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F1ScAKPK9lKlY9UgspugLQpSKdL/YPUt4UHrgfW8UlU=;
        b=WovzDUdvgCRGv6rDxL+VdDqDeZevvHtJvQ3b8CISfRqTlDkdmDFJsLq58WyTtrfZoM
         R1Ns7TxnhqZxnr4hnBDjvCAy5NuxgRyv9uTLfDm0Fqan3AiBXA/oSbDccAMY3CCsF60A
         G+anK0jJUw7Bp8s1XXjAVqHgLxfEziVpldQreKdmoL4KAi+LtfUrkLTFosCD/ARbT7Rh
         2qpwnMuRUTFDTcYBD1TlPU71E4DKFk4LDfy8y3rknHHoue4k8uJx8C09/h9q9Vqofncb
         GR68Ep1C2liU2k73Cf8EBBrOGnHfX21R1kmAuHODwKO3Cyz5DRRfp0CvCnfdEZt+dXbK
         s61g==
X-Forwarded-Encrypted: i=1; AJvYcCV74Vf8/mBVTFrXEG3SR6l0JdGED5O/q5jCDQrdhuAAlvpa4HpEypn6MdhjEdF1Pd0GvnssQL1e5eHyYEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWG/8f3TQlGOnfh1YgQs8yDGLkUsN8YM20SyrdrGOqYnbF7UZt
	tlFkAHnb4SopdWyYSvktfmiww+BbzJkalFuuVaKRG5+jHOEM6hLOfOZNE8lBe8Q62p0L5g7OUeY
	1AA==
X-Google-Smtp-Source: AGHT+IHiDZAiOpBEFOJgxUpXok2oMelxQphuEuzlOnuu5yK+a04Vf0oTH+lvsg7fpahPLTxAOdtcgKu4Bpw=
X-Received: from pjk3.prod.google.com ([2002:a17:90b:5583:b0:2fa:1481:81f5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:268b:b0:2fe:a336:fe63
 with SMTP id 98e67ed59e1d1-30e2e62a8f7mr733965a91.24.1747158848982; Tue, 13
 May 2025 10:54:08 -0700 (PDT)
Date: Tue, 13 May 2025 10:54:07 -0700
In-Reply-To: <9F6D5641-E2DC-47EF-BAFC-E0FF20D1FC08@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313203702.575156-1-jon@nutanix.com> <20250313203702.575156-16-jon@nutanix.com>
 <aCJoNvABQugU2rdZ@google.com> <9F6D5641-E2DC-47EF-BAFC-E0FF20D1FC08@nutanix.com>
Message-ID: <aCOHP3B2sRVut3By@google.com>
Subject: Re: [RFC PATCH 15/18] KVM: x86/mmu: Extend make_spte to understand MBEC
From: Sean Christopherson <seanjc@google.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sergey Dyasli <sergey.dyasli@nutanix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025, Jon Kohler wrote:
> > I would straight up WARN, because it should be impossible to reach this=
 code with
> > ACC_USER_EXEC_MASK set.  In fact, this entire blob of code should be #i=
fdef'd
> > out for PTTYPE_EPT.  AFAICT, the only reason it doesn't break nEPT is b=
ecause
> > its impossible to have a WRITE EPT violation without READ (a.k.a. USER)=
 being
> > set.
>=20
> Would you like me to send a separate patch out for that to clean up as
> I go? Or make such ifdef=E2=80=99ery as part of this series?

I'll send a patch.  It's not at all urgent, not a hard dependency for MBEC,=
 the
comment(s) needs to be rewritten, I want to do an audit of paging_tmpl.h to=
 see
if there is more code that'd be worth #idef'ing out for nEPT.

