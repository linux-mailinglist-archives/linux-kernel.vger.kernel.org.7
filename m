Return-Path: <linux-kernel+bounces-749910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C18B1549D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4150218A61C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65527AC4B;
	Tue, 29 Jul 2025 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R9NTTjX+"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E323D2A8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753824221; cv=none; b=ZY5wrvJMbB1PU3asP9P1cPDDFWCQ1o2ke56EP3/XHezowOjpxmb1TLb92g6ActCyRwAFhA2j96DT3C6zAtFDzQXfAnZ1PG/L0LK8focMCY1S9C4ntvz8gmLvi8tOrUUFm5vGK1SFiBxDxs06M7fS8syjuXMGtN0LjVYLtjIwdac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753824221; c=relaxed/simple;
	bh=YPw39hM0XPwwHdZLB+B/18nFgGiAdWO+RbYDk3eDt1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtvbj1AaNQd4AsnqXvrGdjTkpoA754I0cQvt/qrvYpXHTdGYDY1e97OYJ8mPA5nI8zjQhWjtJ9MdHJ/ut2/P9avowAvbAcvPxn/KR0okJMj37jTBJ6OrU621BzCK3KI6b46ZG+atAs9ixHqiI/VzJXfF+P/nlHrDvoeEjuzT3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R9NTTjX+; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753824207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbTYZV5A/izXGKdYsYyam9domfvB6oEjtk6O72eaKBs=;
	b=R9NTTjX+rORwT+a6JEIYVzSVkSK/RdLskz6BUNFX0dC5BsyCafVhv2uhz1byrhsymuxQGR
	YPqf6IDP1I3oHmOLby3G/aQ8iLzsfJuE5kx9SeVn3eZ4BTbAQA1QMAQnuJhSDlAVA0pX51
	rCK0mNvbXaGok210uECSnNBoj2j9l0s=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: Move bundling vLPI and vSGI to vgic_supports_direct_msis()
Date: Tue, 29 Jul 2025 14:23:16 -0700
Message-Id: <175382415249.3325682.6984441451099105450.b4-ty@linux.dev>
In-Reply-To: <20250729210644.830364-1-rananta@google.com>
References: <20250729210644.830364-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 29 Jul 2025 21:06:44 +0000, Raghavendra Rao Ananta wrote:
> Commit <c652887a9288> ("KVM: arm64: vgic-v3: Allow userspace to write
> GICD_TYPER2.nASSGIcap") bundles the vLPIs and vSGIs behind the
> GICD_TYPER2.nASSGIcap field. While the vGIC v4 initialization and
> teardown is handled correctly, it erroneously left out the cases when
> KVM sets/unset vGIC v4 forwarding, which leads to a kernel panic of the
> following nature:
> 
> [...]

Massaged the changelog a bit. Applied to fixes, thanks!

[1/1] KVM: arm64: Move bundling vLPI and vSGI to vgic_supports_direct_msis()
      https://git.kernel.org/kvmarm/kvmarm/c/7b8346bd9fce

--
Best,
Oliver

