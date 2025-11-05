Return-Path: <linux-kernel+bounces-887223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44822C379D8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667FA3BF80E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD143446D5;
	Wed,  5 Nov 2025 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nRrKMTZK"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C9345CA2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372771; cv=none; b=g+L73jc8SbVwRNIZBMPxylFctypfjeTChGBR7PFYOJDh+nIbE4GROoh7gtA6QL8Yu1CC5ovAxdzhvLcAFYIzVSZYSxx9UxSznaNIUnamXRLkngyel76e+9wICvE67RzLZGVnm5QnMX3wMHrYWAgpq3C9HUpfLBjyxd/LeLsAifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372771; c=relaxed/simple;
	bh=frx9tGBSSneJcawE0KDbhbycEq8++b8chRG3r1od8CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c18LTTM87XxX+g93kd1JZ8lBDGC7NO+dJhpGrQUCvF+CH8ju/Af7B1JIaCZT+4k3fnryvoUlTPJhrKTqr2ff+95Cgc8UN0HaIe2+QvwlQfGzCkltKf3QkZb0yBqgOma+1KNNXg81iGldzEMW9OoDHzwwkaBuWj3fP5e8k+k0IIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nRrKMTZK; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 19:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762372764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QnF62zEzU3e4jOr8bDtQN13Ffwv+H7Jp6/m3XSYk1g=;
	b=nRrKMTZKbbO/GGcghrTE/hQ9a0N2A1KqK/RgbMY1WK8oCJzfFbG9D6STS+3WhudrTRvUht
	3yCqxJdvqkSCvxK9eQRdewk3sfAW/pUVc6v9dLTNroMRzikd7godJ/TLSVV2FK8BHIQEt2
	ABR0jo92ugauaHzUJU47jttYXPiUfBM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel, 
	Matteo Rizzo <matteorizzo@google.com>
Subject: Re: [PATCH 2/3] KVM: nSVM: Propagate SVM_EXIT_CR0_SEL_WRITE
 correctly for LMSW emulation
Message-ID: <42uppdj3ehrnihk7xnejblgla6enenqgredjpe4vknur7iof6r@4d2yi6zataqp>
References: <20251024192918.3191141-1-yosry.ahmed@linux.dev>
 <20251024192918.3191141-3-yosry.ahmed@linux.dev>
 <aQupG93pUl-IYx8G@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQupG93pUl-IYx8G@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 05, 2025 at 11:44:27AM -0800, Sean Christopherson wrote:
> On Fri, Oct 24, 2025, Yosry Ahmed wrote:
> > When emulating L2 instructions, svm_check_intercept() checks whether a
> > write to CR0 should trigger a synthesized #VMEXIT with
> > SVM_EXIT_CR0_SEL_WRITE. For MOV-to-CR0, SVM_EXIT_CR0_SEL_WRITE is only
> > triggered if any bit other than CR0.MP and CR0.TS is updated. However,
> > according to the APM (24593—Rev.  3.42—March 2024, Table 15-7):
> > 
> >   The LMSW instruction treats the selective CR0-write
> >   intercept as a non-selective intercept (i.e., it intercepts
> >   regardless of the value being written).
> > 
> > Skip checking the changed bits for x86_intercept_lmsw and always inject
> > SVM_EXIT_CR0_SEL_WRITE.
> > 
> > Fixes: cfec82cb7d31 ("KVM: SVM: Add intercept check for emulated cr accesses")
> > Cc: stable@vger.kernel
> 
> Bad email (mostly in case you're using a macro for this; the next patch has the
> same typo).

Yeah I realized after sending it. Will fixup if there's a new version.

