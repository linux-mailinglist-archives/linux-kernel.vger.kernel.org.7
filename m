Return-Path: <linux-kernel+bounces-847559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED9BCB30A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283A71A646CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1BE2882D6;
	Thu,  9 Oct 2025 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NKd5qfww"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC12877DB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052269; cv=none; b=iOWtxMowVY3uNOIn5lXZm5eb/ptUm/a9M7dvPdIdveTS80kk0n6SeaTiHpJ5xbNLyzEkV8xhUFAYV1nV+m0ammGaCBkcJOZTyv9ZYFp2AQnEMdvz8vt1sV6zD9g1NqCxvKmjM4cWhj/MCKL8wbqbjx66Hy/lzVaPDZNyG/FyBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052269; c=relaxed/simple;
	bh=gb6+kgsPdEZsCXYqeP/WBffqIKJD+QujlZEul3CXZMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSzWaRD4Q3kuewhmWM1d/cWoxSMG+AaKF+J33N1h+FpY8uGe+y0iUpzZMY5L7HNYZOusV5wsuQiWk3zoNFBdu9PYGY+et4CNbEVJxmWKXo1Kt4oaQPJVe/H0M7j+Z7fnmJq8kduTaEMT/Wv/b4jQPfx2q0DKryHoBF1QjyYXDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NKd5qfww; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 Oct 2025 23:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760052254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8+eqI1GnESCV/6qqpxbOeDo5s3/0CF3tmLj3ohK2TI=;
	b=NKd5qfww3DCPFBmMakUN/VXY67bbCvp+wCFdJz3v8bseNpFkVVRw+NDQsk+Q37ZFbIuS5l
	vC7jtWsCVPt+/V32kfuk7xIrWFo+BpS3QmVfakzY5jrDnI+f8hsp84H6mlDXXouqg5QwKE
	Dt5kw+H+j/VEJ7oy20wakfqga36ZOjQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] KVM: selftests: Remove invalid CR3 test from
 vmx_tsc_adjust_test
Message-ID: <7egn6azfxckepxadqwqg6s7lsu4ycm4lhchn2ijx7zydcseifw@jvfuvy4vz44h>
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev>
 <20251001145816.1414855-6-yosry.ahmed@linux.dev>
 <CALMp9eT5DjpTy_UcU_99uHjSWymk09riWePTCzZG7RyHb5KFUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eT5DjpTy_UcU_99uHjSWymk09riWePTCzZG7RyHb5KFUw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 09, 2025 at 03:55:32PM -0700, Jim Mattson wrote:
> On Wed, Oct 1, 2025 at 8:02 AM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> >
> > From: Yosry Ahmed <yosryahmed@google.com>
> >
> > Checking that VMLAUNCH fails with an invalid CR3 is irrelevant to this
> > test. Remove it to simplify the test a little bit before generalizing it
> > to cover SVM.
> >
> > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> 
> Is there value in moving the invalid CR3 test elsewhere, rather than
> just eliminating it?

It's a very basic test, but yeah we can keep it. I was doing the lazy
thing by just dropping it to see if anyone will comment.

I will find a new home for it (or keep it here out of more laziness).

