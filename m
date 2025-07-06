Return-Path: <linux-kernel+bounces-717870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1ABAF9A30
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 19:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D373C1C4295A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 17:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C272DEA75;
	Fri,  4 Jul 2025 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgJkrkYz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691A2DAFB2;
	Fri,  4 Jul 2025 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651739; cv=none; b=XdWdUE/1/Yh9ycwRCb844goD31M9MtjZ85HhIo+wrdzqQPqesEb8EpmH7bXaMn3MsyEy0313phTmZBCs+WrVZl/zlK7epEt79KU8xf2V0wPQgpf3fePvslb1/frGTQwjBmA3jUiPymktdZeffH/LJidj3lZFrwTXo+4wUNHYVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651739; c=relaxed/simple;
	bh=DAGPet970dtVSdzNzgb0cUUULeqVOXz5UXvENSfYNVc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d76wtkenmlAZzi736H/gKVt/l/QYWl/2tbk4u04m+R/eBWoYBcHg7V0HktABnJITu6txsoECuceSxBAbDrR/T5fXHnQ+OoCnzh/6QFMu/Aeibv5ScwcsGYeMf/Zt1h/p3FonGSqtxCaJ63qGahWvwkQUKCXBV41tIGazDFfAC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgJkrkYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAFBC4AF09;
	Fri,  4 Jul 2025 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651738;
	bh=DAGPet970dtVSdzNzgb0cUUULeqVOXz5UXvENSfYNVc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=YgJkrkYzdIkkgVrp5PRb6AkAEHzBqw9bL3jfE8nwWEqgxyeVm+u396kDnScMZULsk
	 6+7rTAXhxAXulX1FEg38ou6gayAOX/TsGAu/YwwY58GUqqXJkbAbiiKalvBtSXLd1O
	 2C2/mpiaUoofLnwooptYdSa+x9cb3d1duY52jvtM1hi+yfwiL1Me7+oxciotX6OcxB
	 qIyhWSGvsXtZvIR56dSoHxScKeOfsWHAq1/XkF3jn5ce9zLrtUxeaEX3LLUuHzO9S+
	 hNQzAVU9TMpYOFJF5ccRmEPUy+ZIa2+keGoF+O3zw8F+/+rprv5d4UOqlxDUZhbVll
	 isRicJsQrnHdQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250703053622.3141424-1-irogers@google.com>
References: <20250703053622.3141424-1-irogers@google.com>
Subject: Re: [PATCH v1] perf tests make: Add NO_LIBDW=1 to minimal and add
 standalone test
Message-Id: <175165173848.3149172.372461795325655603.b4-ty@kernel.org>
Date: Fri, 04 Jul 2025 10:55:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 02 Jul 2025 22:36:22 -0700, Ian Rogers wrote:
> Missing testing coverage of NO_LIBDW=1 and add NO_LIBDW=1 to the
> minimal test configuration.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



