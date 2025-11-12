Return-Path: <linux-kernel+bounces-897548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE052C5363C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36FC50689C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E77340A6D;
	Wed, 12 Nov 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldhr0IvQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1EA33F39B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960959; cv=none; b=asBOGZHpFEPcE31hgVP1PZl84Js2CQF9knNHo88H/w88ZlbwoZBV+i5N+r/R9blCmfGImUd0Yfv4xWzNcv7WLPdk4LxShzK/0r2LA9vgQZB6lHbOBMcaVITRWqy7TRsEqI0VdSdi4IcRs26XKA/72at9j4zroF4IQfUyC2EVBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960959; c=relaxed/simple;
	bh=Imb/4otkYSMRXnQIsxJEvw+xkERBT4QOeancUnAl36s=;
	h=Message-ID:Date:From:To:Cc:Subject; b=nVm+dSoXNcFLTdtqrFWv8l8bBGSqTtzTFWg6xrxT0qcDP9yX8jQV8sYmXrMjL6UQh2VaC6AUAnDD2yCNNjsuTjjz32o2ET7BWjc1DRUadaKJ6om1yi6wgYpOCXfm7ufnUgeH+pAguzhovdfmWqmqkM5qjaa23+2sHE5wrtaZCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ldhr0IvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B495C2BC9E;
	Wed, 12 Nov 2025 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762960959;
	bh=Imb/4otkYSMRXnQIsxJEvw+xkERBT4QOeancUnAl36s=;
	h=Date:From:To:Cc:Subject:From;
	b=Ldhr0IvQj+ibg46Xk0m7hEYAI4fjTt3o6s120yl18eJkKwkijkyiuW7Bi3XK2FP2n
	 jvgDsz+4RB1cnCROJIQd0/fGJYL01DXfdQjjmbVrleiiyZ80fq431ZqGvLXMEOZXaw
	 IkIA0BohiZKRcSve60kdtjuuyEHsorjrg6/h2PlymDh11MyJDc0OGtG3QsCK8m5dLv
	 57Kc2OZlp1gSiBF68UYNrUi2BlG8kBJoMy53l+++7YaiP9oTwe0obLYO7oyM28ZhW7
	 bhDloxyE0D5FpeawCNCfhbgNo2p0Q1GrSDu+h3J3SQGrPC4B2CcMje8X/D+4RxWbty
	 gXgVY0wwR+WYQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJCgO-000000018L1-1R1k;
	Wed, 12 Nov 2025 10:22:52 -0500
Message-ID: <20251112152235.655878322@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 12 Nov 2025 10:22:35 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] tracing: Updates for v6.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: ecef4b5565a7653df68f2fee7cdcb174e561f0b3


Masami Hiramatsu (Google) (1):
      tracing: Report wrong dynamic event command

Steven Rostedt (3):
      tracing: Have tracer option be instance specific
      tracing: Have function tracer define options per instance
      tracing: Have function graph tracer define options per instance

----
 kernel/trace/trace.c                 | 257 +++++++++++++++++++++++++----------
 kernel/trace/trace.h                 |   3 +
 kernel/trace/trace_dynevent.c        |  11 +-
 kernel/trace/trace_functions.c       |  10 +-
 kernel/trace/trace_functions_graph.c |  18 ++-
 5 files changed, 211 insertions(+), 88 deletions(-)

