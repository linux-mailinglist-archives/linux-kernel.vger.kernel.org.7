Return-Path: <linux-kernel+bounces-792483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD3DB3C498
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF415A486A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA922882A7;
	Fri, 29 Aug 2025 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CsvoMefr"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97427B343
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504957; cv=none; b=bhnzhWCV++Ak2RmWTPv6PtZ8DX8koOE1JfXHi3fpaqeMHr7sBTDaB6HsERViae/DkKsXsz0nAInPlEK/6dj+fB6J+JH5qEjjPJdIpFgVEHsv4eF52ZmjcvxExSy/4B4lq9YWWg7E8jMO0mKHuHEc5S+6rulttPfkzxyBU26wDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504957; c=relaxed/simple;
	bh=teUtsxIZpBnaqng2C1jlrv5zNtwbyX2kDo+oVQ2VG30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4c9eCk0oiV4ep37jA7HQUCLYZzgvb8Hugj3yHTR9aI1n2eydEPzlp+sEQftsWFxDdrClnYoQRHWhoe9rOODYEBR4F7uP8/QU+grm/FRW/riRV2iHQKcD27ePwFLYM//q/Ohr2LL5a+bKxG3/ASGYBTJzo203uHPFvqnwxX2XtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CsvoMefr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7720cb56ee3so4223319b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756504955; x=1757109755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iXEWhIvVHrzcTGbP6wwieYYs4x0k51AW/FLHROxpRAQ=;
        b=CsvoMefraAeeYE/DJ52ieIYI5J3UxP3CAXXOFZ4Z+BeO5KkFIE2Br0aj0bVFnykVnb
         vEUJSC4UtQUbfTG67WjN7VJkHj5vxK6S4xGQ4/AuBle5hp53nwFERnZyXKeNFNsNjsHa
         L30PiNDNRgLSFhITxGjc168+uSCpg7qyIKD+pre3lJb9z5Vu8TaGjXc10t5B7fCcBSrV
         oII0qh2WQemjMNC2/1qlYDajP6XnIPw31OE668Phl/ByY6tYswqbpDq/LYS6DzdYP/+J
         rB5sOSocylknDd64+kiqGKLsj1c+eAc5zPLfcYMEBw75RJghAGM9LiiOXb8SPCp05vaU
         GPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504955; x=1757109755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXEWhIvVHrzcTGbP6wwieYYs4x0k51AW/FLHROxpRAQ=;
        b=RZLAZF3BLSDRFYavvPc13Egp5kz17ImV8b4lPHqi+te1qIoGwkYLSdl8UHAyaGni1h
         2B9NKl7yUsUgZhkBRU9IOgPTGlL8AdeLs0Llkjm9LBeHTz1pS9h2IevZ4rU1wP2png6C
         dFL9TA7Su5eO+SdDFEkv1vVutyI7xshVni1cOmpFFYmH++Pq5wOYr/itEsvbYwSNqnk5
         vXA1p8eNAJd8bvr3vB1K+EVdLnuI6GcB9lbNGzvnKJWnAMupJuViTg8cyoMcuwDh1Qfe
         iVQd6qsDl4UefuYdF604o0c4VRp+Tq1iM/Mb6u7tv8Zt4ftQwn3+M7v16o3SN4RvMO6h
         qbtw==
X-Forwarded-Encrypted: i=1; AJvYcCU1HubfLuQAdG59PqYpW91yHoBVLJGlv5OfViuNxqFqY7Jrw0J4h6Lbvj8ROWQYw9OwBF9SzkW18LZX/Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7MDWu65hBcII9P5eiiKI/gwb8+jcpAg7ke3m9gF93+GQs4eHt
	NErbiIXlWnA0O9qe/n0CP0ouS1JGeKAzgXq/JlOgSVHUNdxq2DoKHp8gOaNfEHTICdTEOFrbJZf
	QZ1Ui4w==
X-Google-Smtp-Source: AGHT+IGE42jmllapP3icYQ+LWJU82IQuzrhCrOAG2NNkbzVcYj65Gf5ke1Rd0y2p3N64dxuaZyPvxJEyHzM=
X-Received: from pfuu10.prod.google.com ([2002:a05:6a00:6f8a:b0:748:e22c:600c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f94:b0:243:78a:82b2
 with SMTP id adf61e73a8af0-243d6f8774fmr192515637.58.1756504955599; Fri, 29
 Aug 2025 15:02:35 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:02:34 -0700
In-Reply-To: <e3b1daca29f5a50bd1d01df1aa1a0403f36d596b.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com> <20250829000618.351013-6-seanjc@google.com>
 <49c337d247940e8bd3920e5723c2fa710cd0dd83.camel@intel.com>
 <aLILRk6252a3-iKJ@google.com> <e3b1daca29f5a50bd1d01df1aa1a0403f36d596b.camel@intel.com>
Message-ID: <aLIjelexDYa5dtkn@google.com>
Subject: Re: [RFC PATCH v2 05/18] KVM: TDX: Drop superfluous page pinning in
 S-EPT management
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kai Huang <kai.huang@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "michael.roth@amd.com" <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 29, 2025, Rick P Edgecombe wrote:
> On Fri, 2025-08-29 at 13:19 -0700, Sean Christopherson wrote:
> > I'm happy to include more context in the changelog, but I really don't want
> > anyone to walk away from this thinking that pinning pages in random KVM code
> > is at all encouraged.
> 
> Sorry for going on a tangent. Defensive programming inside the kernel is a
> little more settled. But for defensive programming against the TDX module, there
> are various schools of thought internally. Currently we rely on some
> undocumented behavior of the TDX module (as in not in the spec) for correctness.

Examples?

> But I don't think we do for security.
> 
> Speaking for Yan here, I think she was a little more worried about this scenario
> then me, so I read this verbiage and thought to try to close it out.

