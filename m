Return-Path: <linux-kernel+bounces-842043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBFDBB8D66
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824501898FF2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B3279794;
	Sat,  4 Oct 2025 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+o/f2Nc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915212773D9;
	Sat,  4 Oct 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759582720; cv=none; b=VBrf6zkccqiKwxSbJ88TAuLLooduMUTW73Y/0tkwyWBcFimdKdSyl5ZFBRjrdzvuNm4bxe/iINb8fD5vFwDv/rNONsV8yaBp78pEWVFxc6D66RurdCDrh+UTbHR5xZil8BD/zfk4QAUxqgMsumJSwDmRKe038XB/Omr1M8hL8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759582720; c=relaxed/simple;
	bh=6w2vZiZSHfxzifnyr91bFeb7N267eeWvK1GvezAtz00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlYNPVIVAfy+mvfX7JcJE6oLzAIR1DvDa4rvZ7lwWnPOn0JmWBZH2XQRaOEWJf/EfsruLtdBynSomFtjkKQhaACoZ7B+PvvlvSu51rkGUegneVFYItUmYv5q5NDEFyExkM+D2J3qoGwog5izuRv1iaYxKFbpjYr1x0kg/dMfHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+o/f2Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4569C4CEFA;
	Sat,  4 Oct 2025 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759582720;
	bh=6w2vZiZSHfxzifnyr91bFeb7N267eeWvK1GvezAtz00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+o/f2NcJU638QXv8BcP+i5PhBk0sMqAQIa8/S9uH/Dpb8sz2OKfEf/2RkyJpYu3J
	 vu3Dx7AZ5+/5B/nnKfGDXhBDEqAUw/9gC7W8giGl+SS5KjSPSjVtc/Th1RzuaJODnU
	 WqLdhGk3auSr9rPY/iAdppTNob/obVw+TYubbzWsx0AYWkIVgfsHbjpbRKxBrPGqZ8
	 yRFAkI4ZflcVojemmrzLCICSchdi86vHWj0g3kBj+a3EQcDm5g2YwXKFZFwTV/J3JS
	 lLG99w8c+HwVpthpuvt9sInsMgxVtuo2ZSHqTXdgcdZ3Aa8kNj0GRWrA4/5HGgLBqm
	 9Dg5enRETVhkQ==
Date: Sat, 4 Oct 2025 09:58:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf parse-events: Fix parsing of >30kb event strings
Message-ID: <aOEZ_HOcIMggsebi@x1>
References: <20250905042643.1937122-1-irogers@google.com>
 <CAP-5=fUSuh+hKVg_1owmzPAZka3DGmhr6FzN__n_Cb2XUET3=A@mail.gmail.com>
 <CAP-5=fUOpiJypozewCSi6Avg2pQnjmvNcFMM5iUsbTR1P_47zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUOpiJypozewCSi6Avg2pQnjmvNcFMM5iUsbTR1P_47zQ@mail.gmail.com>

On Fri, Oct 03, 2025 at 02:25:39PM -0700, Ian Rogers wrote:
> On Wed, Sep 17, 2025 at 11:05 AM Ian Rogers <irogers@google.com> wrote:
> > On Thu, Sep 4, 2025 at 9:26 PM Ian Rogers <irogers@google.com> wrote:
> > > Whilst cleaning up "%option reject" make the header files accurately
> > > reflect functions used in the code and tidy up not requiring yywrap.

> > > Measuring on the "PMU JSON event tests" a modest reduction of 0.41%
> > > user time and 0.27% max resident size was observed. More importantly
> > > this change fixes parsing large metrics and event strings.

> > Ping. I think this may have gotten lost in noise about things like
> > hardware json and the python metrics. It is a small change, bug fix
> > and performance win. It can land independently of anything else. PTAL.
 
> It'd be nice to land this for the v6.18 pull. I don't think it has any
> visible implications and just makes stuff better.

Applied and now testing on the container build set.

- Arnaldo

