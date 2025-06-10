Return-Path: <linux-kernel+bounces-680215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E080AD4210
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 20:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FAD17D4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D15F24BC0A;
	Tue, 10 Jun 2025 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJZHANML"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B432248F5D;
	Tue, 10 Jun 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580742; cv=none; b=Y52fJwXwZH26DtLsRDvjjnzRW0aw2Spa0UP8VeMadwDtiLHcWsxZsFHEYXX8ib2axjCvIKJ28meb2JYe3Gt/Ft6rfCVinXoBe3ir/RRE2uBNFOqONBsHcXZpzjLBq6VJpI2i6D+l4vqG8Cstu2Xbl71xq1pq9onIDMylqm97dUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580742; c=relaxed/simple;
	bh=OVsOzPzWsnVW8JbvOw87afxktbnPMRAztX8I84TWDiU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ralnfhOVcv/bggtfxxPFo+9FJS6q76McOX+l6eiPIFuD0IHfTvH5A8PLX/plzx0SkqFNiFBaAmwSldYgOqBRCsBE6ImnYJ7SjqMAAA/XJ3pX6dqPhzIRKqechebPdoVQLJdKqtv7mBgYv+UnWZenEZfxbuMB7pXLHS+jBcpLZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJZHANML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14860C4CEF3;
	Tue, 10 Jun 2025 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749580742;
	bh=OVsOzPzWsnVW8JbvOw87afxktbnPMRAztX8I84TWDiU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=NJZHANMLsVGaWKxkm2COuE/t8NbCmAqiX7Dn6aAI1uo3zce1EsWBb8Ca4iFDmD6NU
	 SK22v04BiGzyTflCPdjKeSNXRYgt8mwuPer3euIHiBU1dwatBCTnsN1xLSvs5W34/J
	 OVNIb1w6JCkTKR/qYlY8t2vre2BUzHfcm07qWzBErET8zTqblBAoUUVOh4o8aOZf7W
	 Nj7wpaKUkbiLBs+n43j9+XIRYYBCvea34HZirC9MmugaepVapd0hMTSFTrnIGok/QQ
	 jYVGOnDW3ENtekMZOXKi9CnV4BXTVVPkaC2fdO1Or4LkYUjnc6pNThiu+hFW97R50y
	 F+Wtly4KMv8nw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Liang Kan <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuzhuo Jing <yuzhuo@google.com>
In-Reply-To: <20250604173632.2362759-1-yuzhuo@google.com>
References: <20250604173632.2362759-1-yuzhuo@google.com>
Subject: Re: [PATCH v1] perf: Fix libjvmti.c sign compare error
Message-Id: <174958074204.4039944.12003562719667856301.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 11:39:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 04 Jun 2025 10:36:32 -0700, Yuzhuo Jing wrote:
> Fix the compile errors when compiling with -Werror=sign-compare.
> 
> This is a follow-up patch to a previous patch series for a separate
> issue.  Link: https://lore.kernel.org/lkml/aC9lXhPFcs5fkHWH@x1/
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



