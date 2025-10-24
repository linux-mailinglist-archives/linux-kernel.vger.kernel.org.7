Return-Path: <linux-kernel+bounces-869416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD570C07D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AD50351561
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA09234C13F;
	Fri, 24 Oct 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anFOByt5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8AF2DF6F4;
	Fri, 24 Oct 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332233; cv=none; b=fZcOgOZXp6Ce0hNGZjDVLt+h1jz8kAzF2wtT2Yv6IQdyBoXOelvEPqCN2A3/ObMuX4pSD1SEbkRAhMOTtYPDgIspZGmIuwe387ZKfjKXLKrc2Ev+1kEbISf8Gax1+2Aw1yC13rYv0m/FsEnH5lYeKAejkScY3Y1ofmTX6JA0nsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332233; c=relaxed/simple;
	bh=p05rsSZgSChb3d2eSe7H7FBxTjrXHC8LbKm7GpcUmvw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W0Ia4fxmgNSj00WzVDnpxP1pgQkAlf4RztHzjr98/beylEskNB0hVk4zkeoXXYtJpq+Zilb0pddN/60p+0F4QK82fI2p54wHbgYsoHNShdBSNylKqDmUtDBICaC02SsI4dg+yX+3rsYPwQlQimjnjMNOwgUcivDvoyxFCqaqw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anFOByt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1037C4CEF1;
	Fri, 24 Oct 2025 18:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761332230;
	bh=p05rsSZgSChb3d2eSe7H7FBxTjrXHC8LbKm7GpcUmvw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=anFOByt5xqVluJi3WHlfW4y76JZhSL6ZBlwKRsExXST/0G7rt+LiF3/D3vtHYX127
	 XU7ecUUuctE7TjoKs4r70KGPCKlTZt06rNncnvDU8Y8a1oUVj7py3bmytyHC49SCe7
	 bdoktswxN9vtyG60vwPEHyUPLtruCAlK9L4vMmxr1N518GwUbr8oAsh4t2p+N4mbiq
	 z0FrDqIy04B2ALerkT9kQ0KkIitaRTjXnFNMZxx/1i6TA1w2/HrPTz4MHtXzBdtebM
	 I+vrcyBbhHZ0oo+s8UbIgZz0ifFV5ImDXaCrf3OqfaEmVb4IhBexgrY4wsCTLZskft
	 9uebEVfuGfqvA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, 
 James Clark <james.clark@linaro.org>
Cc: irogers@google.com, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
 Zhiguo Zhou <zhiguo.zhou@intel.com>, Wangyang Guo <wangyang.guo@intel.com>, 
 Pan Deng <pan.deng@intel.com>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20251022110241.1283519-1-james.clark@linaro.org>
References: <20251022110241.1283519-1-james.clark@linaro.org>
Subject: Re: [PATCH] perf annotate: Fix Clang build by adding block in
 switch case
Message-Id: <176133222994.3710582.4946257287449096710.b4-ty@kernel.org>
Date: Fri, 24 Oct 2025 11:57:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 22 Oct 2025 12:02:40 +0100, James Clark wrote:
> Clang and GCC disagree with what constitutes a "declaration after
> statement". GCC allows declarations in switch cases without an extra
> block, as long as it's immediately after the label. Clang does not.
> Unfortunately this is the case even in the latest versions of both
> compilers. The only option that makes them behave in the same way is
> -Wpedantic, which can't be enabled in Perf because of the number of
> warnings it generates.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



