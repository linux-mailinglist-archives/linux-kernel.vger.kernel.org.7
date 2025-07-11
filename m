Return-Path: <linux-kernel+bounces-727745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E164BB01F04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EF23BCB03
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18C82E7173;
	Fri, 11 Jul 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anxbPdwQ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B302E6D2F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243721; cv=none; b=o8GTfco0/HilJ+VNI5FJ1QQ8ivx4TVyxJ/bvtqqofqVnYO1yjjJow2T+RkeF4HIPDrOkNuMM1qpzUKR0xqyBUs2gWtHF/jeZGuPe6eWrcDX9jVQeuZ//JtrABLZxdv8Wj5oh8C77VTzZP4HB/9thSpebLMCosf+KLGgO1dKbMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243721; c=relaxed/simple;
	bh=TN7z0GjEbxxUAoiTOxp77hq0qhhS8YzV/BQrHx3wHQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IR+Xx//gFB/W2Tes3JtT10OMqR23HS0RRvt3DJRHbdnS3Tiaz1Y/Gca4O1dCBX2fEF8pla2EP1XOz1fVN4TKZ4Ky0BF6HPWKjW0sCvZgU1APPRnicf53aY1vglJkJ28EDz0N4sXfA6QtyaYXiOtFDx/fL82S39WJprU5mSoJRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=anxbPdwQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138c50d2a0so3352301a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752243719; x=1752848519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRqfrEzs7x4CSVnJByAwD+FgPqEDD1PmaKQCTJjNx0Y=;
        b=anxbPdwQWE0cqdpGdZ3l+m6drn3XhlrlwC64vEcJozIqyhXqg8Dl2aw86MrBOtqRe3
         FZ+4Uynk7eHULvdrq+we/JvGRpvx2fpxEzDa1ko+t0YAvpKB6fQKUhQBo48DUy/NPVvl
         NTm7Opmz4n0IbPdBxm3n+rV+yHfkvxY/rgHbOT6py1QBEqF9AOLrtoqQt6JaaRQMraqi
         mdEkI/yzBLh3yZnWTvt0CXFHVSahj3ITzQhgeyD18mxB5u2w8kxom5su7vIgLamYWmI9
         y67fS+X0gqs0mQB05txc0yXfS5F8Pd9P/bQfpgK3kPPJUFdgpW0fR0ITJzIF5qDt1CBs
         GZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752243719; x=1752848519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRqfrEzs7x4CSVnJByAwD+FgPqEDD1PmaKQCTJjNx0Y=;
        b=noMPDscv5oRx+zOJjgsR1QoVTkWmNEkPoU8weO/YfTXmaXdQhknKMr9NDXkzn1TeTm
         Np3sxae+MfNXVmFr/7VxaIN+83n/GCsBbUHsWu4JaPZsSe+fJO/O0C8OqZqIxuDV+ntB
         TXo1nZ5xZ9Nzp0Z1r5uiz7lIo3zi6fCERc62Sp1xPna3ZJffR9LE3BUHJH55kPJGLbuK
         u5zDP/6NNO6S5QpmZbR5th9lVePtKmVwGZWR7pGVi4QTHFFczfHI7y2XEMX9GBPaTV2l
         CDf792dQhBw9dbw6fnJLEsclnO5LRBCDvPY8jXGTV3LaCts+Xwwq4724skDjjoQTUPZj
         8x5A==
X-Forwarded-Encrypted: i=1; AJvYcCWH+G3KpyXIQveY7CBhbbTMSsSaxYEJB4AoDhRMYd2039m1FXcjoA6hwErVItlWvnfzZMcvZXXHB/YeINw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5pJBuL7R74yD0i7C6kaWLyb1R56+ePWqdzhir1S0h8Jvh5Z4
	hi4jJIvAHZ2QBcSMIzzhgAwHMnWtIGkeuhKfZcj0iB/VhVFK9bqLGoxrSVPF+6fRH2QDfVu+dby
	KT48YFQ==
X-Google-Smtp-Source: AGHT+IGVZvI2EczQC2O/jvZ7pBcroS18t80B3UR61pZDWGz6MbNGGv2qQSEnw44w+1NR0rPQm9jABeQZu68=
X-Received: from pjbtc4.prod.google.com ([2002:a17:90b:5404:b0:312:1900:72e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cc5:b0:31c:404f:c14a
 with SMTP id 98e67ed59e1d1-31c4cd09cbemr4621578a91.29.1752243718883; Fri, 11
 Jul 2025 07:21:58 -0700 (PDT)
Date: Fri, 11 Jul 2025 07:21:57 -0700
In-Reply-To: <68706bb42efc8_371c7129412@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250703062641.3247-1-yan.y.zhao@intel.com> <20250709232103.zwmufocd3l7sqk7y@amd.com>
 <aG_pLUlHdYIZ2luh@google.com> <68706bb42efc8_371c7129412@iweiny-mobl.notmuch>
Message-ID: <aHEeBcn65JocfU8i@google.com>
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from kvm_gmem_populate()
From: Sean Christopherson <seanjc@google.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kai.huang@intel.com, adrian.hunter@intel.com, reinette.chatre@intel.com, 
	xiaoyao.li@intel.com, tony.lindgren@intel.com, binbin.wu@linux.intel.com, 
	dmatlack@google.com, isaku.yamahata@intel.com, vannapurve@google.com, 
	david@redhat.com, ackerleytng@google.com, tabba@google.com, 
	chao.p.peng@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 10, 2025, Ira Weiny wrote:
> Sean Christopherson wrote:
> > On Wed, Jul 09, 2025, Michael Roth wrote:
> > > I don't think this hurts anything in the current code, and I don't
> > > personally see any issue with open-coding the population path if it doesn't
> > > fit TDX very well, but there was some effort put into making
> > > kvm_gmem_populate() usable for both TDX/SNP, and if the real issue isn't the
> > > design of the interface itself, but instead just some inflexibility on the
> > > KVM MMU mapping side, then it seems more robust to address the latter if
> > > possible.
> > > 
> > > Would something like the below be reasonable? 
> > 
> > No, polluting the page fault paths is a non-starter for me.  TDX really shouldn't
> > be synthesizing a page fault when it has the PFN in hand.  And some of the behavior
> > that's desirable for pre-faults looks flat out wrong for TDX.  E.g. returning '0'
> > on RET_PF_WRITE_PROTECTED and RET_PF_SPURIOUS (though maybe spurious is fine?).
> > 
> > I would much rather special case this path, because it absolutely is a special
> > snowflake.  This even eliminates several exports of low level helpers that frankly
> > have no business being used by TDX, e.g. kvm_mmu_reload().
> 
> I'm not quite following what the code below is for.  Is it an addition to
> Yan's patch to eliminate the use of kvm_gmem_populate() from TDX?
> I don't see how this code helps with the lock invalidation so I think we
> still need Yan's patch, correct?

Dunno, I haven't read through Yan's patch, I was just reacting to Mike's proposal.

