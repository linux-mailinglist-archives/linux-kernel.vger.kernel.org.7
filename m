Return-Path: <linux-kernel+bounces-869465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1635C07F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFD964F47B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C8A2C3769;
	Fri, 24 Oct 2025 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="krINLBuj"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F00224AE8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335383; cv=none; b=UjN37Pb5EWjDuktyWDnMJdN1+qlE45cuIBJksDL/rpENDUPunVvPmREQr9xihc+l3u55MpXYFsnP1o//KIWA1w2HRQxTwudNS7GjTBYTOIKxwbSIR7p+jZ+bs1G34PqQf7Mehy/T31oGAi4EYBGaXdU+Cbp/9ES3SDuRhDCw0OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335383; c=relaxed/simple;
	bh=0YY0+byixgPTOxUuwNhZ2WaLXRHmYynDes+aMFzWqrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5uLbuC8BzNEpHAjP3mHvIbPT+OD3391fzKBxoAVbwoU5gEHOpr0WImGPA8jZi2ihm2cntemObCsz7CYSaT8D/pOv5VHMX3fL1dX9lmjE8/KZFgmetIg1ZTRRV4dSerFdAVBXDeHe+u5BSgyk/PWt3gZfZFgVdwdCplBlizjvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=krINLBuj; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761335378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vllfWIu9vuciLFHNcZvUb5oqxGmTyqYKUXBTT9jzeUk=;
	b=krINLBujvM+taXhIbCRtxLXCoA73uyjXP5V39MBrq24SEzsLyCIjZgi71+7E/ZbGyakiZe
	QQCH7x0DmgNhvaZ96/WYfatgQDq0YiT8l+LjM0MjVk6vqyjavpKobdiOEaP7Qx+4zrz43c
	fLltXB4F9oUm2m6+XrnJwbWLWcBnOmI=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [kvm-unit-tests 0/7] More tests for selective CR0 intercept
Date: Fri, 24 Oct 2025 19:49:18 +0000
Message-ID: <20251024194925.3201933-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yosry Ahmed <yosryahmed@google.com>

Add more test cases for the selective CR0 write intercept, covering bugs
fixed by
https://lore.kernel.org/kvm/20251024192918.3191141-1-yosry.ahmed@linux.dev/.

Patches 1-5 are cleanups and prep work. Patch 6 generalizes the existing
test to make it easy to extend, and patch 7 adds the actual tests.

Yosry Ahmed (7):
  x86/svm: Cleanup selective cr0 write intercept test
  x86/svm: Move CR0 selective write intercept test near CR3 intercept
  x86/svm: Add FEP helpers for SVM tests
  x86/svm: Report unsupported SVM tests
  x86/svm: Move report_svm_guest() to the top of svm_tests.c
  x86/svm: Generalize and improve selective CR0 write intercept test
  x86/svm: Add more selective CR0 write and LMSW test cases

 lib/x86/desc.h  |   8 +++
 x86/svm.c       |   9 ++-
 x86/svm.h       |   1 +
 x86/svm_tests.c | 178 ++++++++++++++++++++++++++++++++++--------------
 4 files changed, 144 insertions(+), 52 deletions(-)

-- 
2.51.1.821.gb6fe4d2222-goog


