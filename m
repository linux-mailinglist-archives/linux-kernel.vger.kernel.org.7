Return-Path: <linux-kernel+bounces-814666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BEBB55714
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C0C3A9976
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26DB239E81;
	Fri, 12 Sep 2025 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGxLGgRj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0309D4C81;
	Fri, 12 Sep 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706324; cv=none; b=BpowPIzBy4PvHr200MSAnfhkzca5H20Zrk+DwYiOtVhRB2+ZF9FX4XD5bGyLQajYpmqWDTUZzAlRhN1QUe5s6Gxj0Jye8kN6LvCzdYQJpRxZWgSsU0+F9Ffa80a6Lb3nq1RAGIeDLSuafIqfZesWTumsNqRsU3Yuifph/SoEHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706324; c=relaxed/simple;
	bh=eRmlEgZBdwAVe3h7/GUPU9Q+gTO65mCT/B7HM+C5/r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fryko6bKElKZZ0Xtil7Us2PzxI/Ytu6PuEP/l9YU4VBGsT2MMNODsvuip/5sEciIifeGosa2YYtK3Amynat6MbEJupabE3exBTxFtbSGLxJY301384arMifUJ3kOsjst5G5vrEe2udZhIopbN/uDf6sghcZdykDeTG/mnpxMZ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGxLGgRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D1AC4CEF1;
	Fri, 12 Sep 2025 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757706323;
	bh=eRmlEgZBdwAVe3h7/GUPU9Q+gTO65mCT/B7HM+C5/r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGxLGgRjMDweOQcz1o9SLsb4xdM047FEMoHGsd+9t1EJPz8DcZllP6Dh7GIEhwELe
	 QUHRQ6RFNj72LgTkzPlBJWmmyO14IZNKvFmpCqgnOs5R25eBkYuqwE48olpdeOvHhp
	 8Z14wHaxuxIQKh65NJNPSakqY6xeLxOlQIRrKlQ9uTpUOnLI2cQUQ/IWX0CYU1Lyh2
	 vMhw65Etr9I402cbjwoiLi4y5OTmLvnH6WpKVIRmrruaygrm7gN6WZKSTFhXz7/jIf
	 ESWkov3bh4QNU/MQsWxio8zGGCPzkQAC97XVNHBNjZL2U5Kj/wUAwzVpc66O/tUe8e
	 gqTN/pJXedUVw==
Date: Fri, 12 Sep 2025 16:45:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: Add --max-summary option
Message-ID: <aMR4UIY94UhoJUMl@x1>
References: <20250821003220.1051711-1-namhyung@kernel.org>
 <CAH0uvoj7s3V7qby7BxQ9Eby4G562MMsFtbonLJ2L3SF1N7CDng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoj7s3V7qby7BxQ9Eby4G562MMsFtbonLJ2L3SF1N7CDng@mail.gmail.com>

On Fri, Aug 22, 2025 at 10:19:26PM -0700, Howard Chu wrote:
> On Wed, Aug 20, 2025 at 5:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
> Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks, applied to perf-tools-next,

- Arnaldo

