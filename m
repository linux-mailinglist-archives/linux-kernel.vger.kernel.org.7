Return-Path: <linux-kernel+bounces-830570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9314FB9A003
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5302C2A3F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB13002C6;
	Wed, 24 Sep 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="K8Xmf3Tp"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE1C2E0B73
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719910; cv=none; b=kNm4pZSsGGQILn2EPJrxIdMsmdBB07CtBKdECzyHURkDChhTk1gYQG27Vj9ikiR6cJMcYt/2EH+ckkLqB4J11ReH+kmLqc/30J7KLbIDX9Fc/ScPIK6NAM+Rq4vd+7Yrw1PhxzsMQ5r3g+y8rSfFQq2L8zwEmP5O+1TZ08sWeXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719910; c=relaxed/simple;
	bh=wn3sim0a/4uaeGg7qjlMnQPSKkuQBiERIyMkddt5cTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBy8JG+lPckTcGDebviPDSd/9yisXTEtb7r4Q06PdRCuUAWBYMQBbgQiVjABP8aIGmFJpqK0mW/yhmwX5To9Oz4b14PExxx0snuLRJWWvAB5ZprvLPLhnvD3VilUB4ItCCRO59DtqqFZvvkuu5NW+cZUFmwumfWz7PeyhrLrO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=K8Xmf3Tp; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cWy8c1k7Zz9sqW;
	Wed, 24 Sep 2025 15:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1758719904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xG1bM0E9OevYD1Y4QbdnMMS+Vb2pYQgk1wR9wH0SuSc=;
	b=K8Xmf3TpwnKoWBfx5GlIlG/03vnUH4HCrSrEpLX7Ov/x7G/XBlgf9C8HIBK5QklOjEzcuP
	vNS85eORXfFgdqfdkibFnycE5AoSkL2rfyiN/Bj1fUOUq+r2P1VWy4EenOVXiEIyGHVxyD
	w+XqPPUtNc5vFHvXJzCShX3/TPeH7IRyAQQNM0vxxy1M1+j2DnYQl2Xnb4hFoR8hgH1m1E
	rFLfw4/pTjgIZU4mlE31HWHRo3sqs1RYkoXDsP7rU8ggV16OmfFjPIu0cIHjvdSAToi3nP
	nCBzhF36ZoKfGkhVZQOQkqBnnX6HXklbUXm2Ow69uWuwtakjmFYOw29qpSiorQ==
Message-ID: <8decdb30-237a-47ba-a748-4c0f03e8efee@pankajraghav.com>
Date: Wed, 24 Sep 2025 15:18:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] minor fixes to faddr2line
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
References: <20250921100358.19986-1-kernel@pankajraghav.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20250921100358.19986-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 12:03, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> The first commit fixes the issue I am facing in NixOS.
> 
> The second commit uses a tempfile instead of shell variable while trying
> to read the elf file.
> 
> Pankaj Raghav (2):
>   scripts/faddr2line:use /usr/bin/env bash for portability
>   scripts/faddr2line:fix "Argument list too long" error
> 
>  scripts/faddr2line | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Gentle ping Josh :)

--
Pankaj

