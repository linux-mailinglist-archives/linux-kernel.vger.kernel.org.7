Return-Path: <linux-kernel+bounces-726621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21073B00F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B6318933F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589FC2BEFF0;
	Thu, 10 Jul 2025 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvDIdXMg"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621A228B7DF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189099; cv=none; b=Cg+b4pKL7/YzRKuE72QJEWtmoHEmnRYkreKi1tsK+tgbcyweY8IU+goHHMeIPsgOCkFbg8qX7YI1NcvTPX6sOd1k7WpqftYiUzYcXMlIIaIzU2D/8CEA2VHCxQy4bEejiiGeNbq1PeiMOXaKjHYOJ/aQbu5dpT78RKUMmu7QK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189099; c=relaxed/simple;
	bh=wm6Wd5au2fnz7UxjhnlfMl1+6W1viErT2yduG18GLsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R/13OYsFAwjZhwAjjD9xczwySiEHgyDK9xZO92CVBkBn2Hl2Uck455j634K8+xZNRkoKdfAJoasiRfI+0NiYJHbmoze3aqPDJLpwC2QRhGQSlK3bm5sCugAa7bYLvepAGGcwd0tC3za5hnE84hLFgsMOw1U0wrSguOCUYf5mAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvDIdXMg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748d96b974cso1264134b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752189097; x=1752793897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKtCb7Xj4mtxwWSxUeEiuhEIoorqmHA0GRJaxYgIn0Y=;
        b=mvDIdXMgL1LQywRyCiXzaRUMrXSQt5oKcC4+93JjyWyXm0Q2r+7xA8D09sccoYy+Y1
         dDJonQ/vX2qwbIwPJeyvPbqqAhlSMkHkpFgrrNLdEhkTR281IIPKVRxgOV5ZQWyCyHLp
         dbL4ZAJaSgBbLHVHYW97nGGgQepTVuPmTSpJM9r4tDjypfMMJDZZfRqOcW4GbOC1ZPPF
         oUCM9/vGcIltg5pgUJgzxqTcgwzRnEZYIZgceFcAYIJpdK9h/xBOcspM/I1pl4fMp2vi
         F/QimUWE11joVjzfzWBOnHXKoawBfyx61wWd58zZfguucQQJRgcQ/2iqRPUHoJrCK4M7
         BboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752189097; x=1752793897;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PKtCb7Xj4mtxwWSxUeEiuhEIoorqmHA0GRJaxYgIn0Y=;
        b=MLyqHh2J6ZpxzpGGy+52ykZj1Z1jRLOXYEOJTtluVOrmQe3HuVt9nQiy1r4LjkaszF
         04rZkwnLTVar4EY++uT6DGmecBpU+YcLTJw4zn+53T4yAHhqSnxPUAegZv7FEXJ+dS38
         7bIfp79Kw9C5u154hFPYLY4VNLUb/8O+6RFk7gK2jy5hf+n7dOVVSj2PxtsCLAWYojhE
         iWf6m/nu2Avh/e7xeD1rpuCaRTo5lV1Jxkk5E2EGl/PGWpE261BihfWSFn0MDs+zjfIW
         gDzixbBx1pws5IaUuI6XOt6yVHveM/s1uLdW9fHidV8Pm5C3WHY74SEp3p5fl3cjiyRx
         1tkA==
X-Forwarded-Encrypted: i=1; AJvYcCXo9o+COUbYzRN0CbjT2sTxWZ8mSk5xOAQYFrzW2nRv9GzxMy2OY2VeaFz08Y0TxNmpYZLyit+auV3jFGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSHdfjR2jjaxX7szMGLPWESg35jpwjRVYNIv9zn6fD9c0pE8R
	6z7b3aQqW0wa+236vEl17OOqdUbjVbcPPnq2y4uePcR76Ff0iq2j6gE75A2ZREdbUh/YDK1Mlxu
	pe1JqzA==
X-Google-Smtp-Source: AGHT+IHRi1NzmmRcomy9+VnQh2MU41hTqBAdM7YEVagYh78o8au9Ol1f3VRw0+QwKsIOf2PZoNj+28bJdD4=
X-Received: from pfbhr19-n1.prod.google.com ([2002:a05:6a00:6b93:10b0:747:a8ac:ca05])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:856:b0:736:5e28:cfba
 with SMTP id d2e1a72fcca58-74f1ebcd73cmr176601b3a.18.1752189097613; Thu, 10
 Jul 2025 16:11:37 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:11:36 -0700
In-Reply-To: <cda50cdf2329b5de76c6cdbf97f248f77ab5a55a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250610232010.162191-1-seanjc@google.com> <20250610232010.162191-9-seanjc@google.com>
 <17b45add9debcc226f515e5d8bb31c508576fa1e.camel@redhat.com>
 <aF1yni8U6XNkyfRf@google.com> <cda50cdf2329b5de76c6cdbf97f248f77ab5a55a.camel@redhat.com>
Message-ID: <aHBIqCNLrRZjBt0N@google.com>
Subject: Re: [PATCH v6 8/8] KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM
 while running the guest
From: Sean Christopherson <seanjc@google.com>
To: mlevitsk@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025, mlevitsk@redhat.com wrote:
> On Thu, 2025-06-26 at 09:17 -0700, Sean Christopherson wrote:
> > --
> > From: Sean Christopherson <seanjc@google.com>
> > Date: Thu, 26 Jun 2025 09:14:20 -0700
> > Subject: [PATCH] KVM: VMX: Add a macro to track which DEBUGCTL bits are
> > =C2=A0host-owned
> >=20
> > Add VMX_HOST_OWNED_DEBUGCTL_BITS to track which bits are host-owned, i.=
e.
> > need to be preserved when running the guest, to dedup the logic without
> > having to incur a memory load to get at kvm_x86_ops.HOST_OWNED_DEBUGCTL=
.
> >=20
> > No functional change intended.
> >=20
> > Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---

...

> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Applied to kvm-x86 misc, thanks!

[1/1] KVM: VMX: Add a macro to track which DEBUGCTL bits are host-owned
      https://github.com/kvm-x86/linux/commit/e1ef1c57ff70

