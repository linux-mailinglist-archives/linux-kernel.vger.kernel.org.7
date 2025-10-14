Return-Path: <linux-kernel+bounces-853373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D575EBDB6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B743D4F385C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FF1267B94;
	Tue, 14 Oct 2025 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cQMrjpHd"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE91FC3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477803; cv=none; b=KMERe6WHeTATTxnBcnu8kKTp3GaoGvmj+7gPbTTMUo2WZHoMOVE0UOaIz9koz0I4TuzEQTQadeGYIT+o5N21rCbopoXiOHH6ki+Ssu9pMJdG9dz0DRlagOvW/kvsJ0D95ToLKlmkpqiXR2faG5+w0+hZDWOZw4S0BQSCHEtxkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477803; c=relaxed/simple;
	bh=ZUIRdYZQRcwfhCH+Vlc/JdR4M8zeOQmTDhaf33rvWfk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iDFW7gSGaygS19jflEPkwMzidrvvDptbFpodz7/4n7aPMLON7Nuftm3aR5FDKSNEmQsvb2okdArRrUdjOTqDsaAkg8u69nkHSgqsgD7iKE5E7ecREsDZ78s0md15LJ2ULGZNTeyyDxvz/sA1B9vh1xKjcs9YL4uqXfFWfOplz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cQMrjpHd; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0ca5bfb-5ead-4f67-8716-d44485a8d8f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760477789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=26qtT9ADxKfqtKOtsTo9Te2deMC1DhOohsQsJvZmWD4=;
	b=cQMrjpHd5fVUOaAy9Bw8d0GteIDTRsz39kfZp5Kuy+r/3eXFhyQM7VntZyZHjx1YppaLkx
	EMRvAUg0HYYGtIhXwBLmZ3km4QnYo4p/kAs2T8PzvY8jJdzV9l13EOaaMCZAX9UIQXFVgA
	U7jI8Y6JaamEQc7on4CSm+vWlqyrpH8=
Date: Tue, 14 Oct 2025 14:36:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: helpdesk@kernel.org
Cc: bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Requests to git.kernel.org return 502
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi, 

Today we started seeing frequent 502 errors on attempts to fetch from
git.kernel.org in BPF CI jobs, which causes many of them to fail.

Kernel Patches Daemon instance is also down because of this. 

Example [1]:

+ git remote add origin https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
Initialized empty Git repository in /tmp/work/vmtest/vmtest/.kernel/.git/
+ git fetch --depth=64 origin master
fatal: unable to access 'https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/': The requested URL returned error: 502
Error: Process completed with exit code 128.

https://github.com/kernel-patches/vmtest/actions/runs/18510075579/job/52750495992?pr=404

Any recent changes on kernel.org side? Is this a known issue?

Please let me know. Thanks.

