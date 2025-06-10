Return-Path: <linux-kernel+bounces-680214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDDAAD420F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F337D7AA15A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B513924A055;
	Tue, 10 Jun 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0kW5d5L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888A248F63;
	Tue, 10 Jun 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580742; cv=none; b=lT39nW1i1f9AREesMKrXWLoPZs3lBd5PpBqFiIvOxS8JIMc09H7nleErTnHuphK55E9jVI5NLQVJFACCdl/893hZ4rOTn89skYu7qu5R45zyL4pp4zXn2RmibsXIhKa01G+txqFMB5ZRTa/0n+jVPBUWU6thJKIJ94IGHB9C/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580742; c=relaxed/simple;
	bh=wuxiZLoYC/AdfEaqPEMocOUJMEC63L49Uwa4SCkPFF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EsobyBtH5EiyIdip1tc3HEErqrUaEGSbnrq8igjx6/lqkYtewp9GngKfmZFgLDgTyHaUnNDpbD9oW/8gYNVKaZTKYnoTBBhrrmd+P6x4pw3s2EYrQSCect822e7jWgzDj4Jfys9jkkHiP5AeboXY9VVMQDA/MGNHBnUw0khLJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0kW5d5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD4BC4CEF4;
	Tue, 10 Jun 2025 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749580741;
	bh=wuxiZLoYC/AdfEaqPEMocOUJMEC63L49Uwa4SCkPFF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p0kW5d5LD9/rjbqqgAqruhCUisM4chEzud94zxOEtZ//hF6wRXvlCwC1iIPO4567A
	 CnLg9yqr1APHLegOZZW52+YeYuVX/WJQ4Vm9C7Vo21oxdYJRLMgsGwECm+19agmVie
	 0zg6USeND++yh9wq3QZdPjlMZrWgLoyyHpo4iyiuT2wd7NAtC+84DyR6Wbs7JQNa0v
	 U8kprqrxEzxhYuJGKVAIamGRwi3dk6i/DtH8l8hk+4BUlk1cLRo2t8SX76+VoUEYvJ
	 AB8cx6ABuu9qzQdeKnB+PrYYiUeONdmEn2vn0vLgI80dXr4nG0D5bGrW4oCc2aNJOX
	 skrtGDntZg3Ng==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Howard Chu <howardchu95@gmail.com>
Cc: mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250528191148.89118-1-howardchu95@gmail.com>
References: <20250528191148.89118-1-howardchu95@gmail.com>
Subject: Re: [PATCH v3 0/6] perf test trace: Reduce test failures and make
 error messages verbose
Message-Id: <174958074126.4039944.17488945500661997155.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 11:39:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 28 May 2025 12:11:42 -0700, Howard Chu wrote:
> Currently, BTF tests fail constantly, this series fixes two major reasons
> why they fail, and makes the error messages acquired when using '-vv'
> more verbose, so when they fail, one can easily diagnose the problem.
> 
> Before:
>     $ sudo /tmp/perf test enum -vv
>     107: perf trace enum augmentation tests:
>     107: perf trace enum augmentation tests                              : Running
>     --- start ---
>     test child forked, pid 783533
>     Checking if vmlinux exists
>     Tracing syscall landlock_add_rule
>     Tracing non-syscall tracepoint syscall
>     ---- end(-1) ----
>     107: perf trace enum augmentation tests                              : FAILED!
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



