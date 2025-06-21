Return-Path: <linux-kernel+bounces-696738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA549AE2AEB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3179517760D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E526FA70;
	Sat, 21 Jun 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOIsqXM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3926F46E;
	Sat, 21 Jun 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528884; cv=none; b=Nk2Zv9CSpU5539TE6XQVfEzboJevK1RO2kfyVKcThVUvvjywo+MjWMUSSWEhrnYVRYSHqjWp3BJu5+woBYQGx/enh7VTt48ug/nzMl/N3n5ayJ578okqsW88yehpjO5ObJjs8f6hAvQqnox0zvjM1woe6CFVT0sIg5Re2k/QAQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528884; c=relaxed/simple;
	bh=QIQ1W9n/2wTSUm8GTP6ksbZ+avPTfI+yWmDqMPp6dm4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d5x4lgXvvxWZyikXa7TwmJIKMBFx9rgZmulJvNcotUV9rgxRTe4/v3CxQnjYgzoydlNYtuKWNngyIvAuw58tdg1UL5Tu/fWPg27eNKJW4ZtmP5eMwGUw3RKeB0xRVsD3k/gUhbaQaQaVY5JjPlr8jWF2Mrkech+uGmuSHa5ne3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOIsqXM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770B3C4AF0C;
	Sat, 21 Jun 2025 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750528883;
	bh=QIQ1W9n/2wTSUm8GTP6ksbZ+avPTfI+yWmDqMPp6dm4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=cOIsqXM6uCcYGX+UhP30iUqDkTZA39y1Ye6iHl/+loTZJEcNKtIwOd3PlK2rb0fya
	 8d9OFm1whqfKwyud/U2FeyvmwCrlEMwTjM7IYfTsiJUpqOMJH092hG2OXnapNEUF+V
	 OmviAkXZlHbsUQzzD6K4K5NrGQdtfrNnGgFi5RC3aq38HGqGjaXaXtADzFSbU8GRvG
	 3HOl/yAnryLKR7tk9js7EUZolgR1rufkN9Dr795ZTRSm1yBfKYasJwZoX8BxbOS6xE
	 HOjRjJOrm+t3yexHaxhkk07AQ6u2kWPG7mxTcpN6peGIaiF3YGhdREn9YjrYcYE5pm
	 /Vus5xcytzSxQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250619002555.100896-1-irogers@google.com>
References: <20250619002555.100896-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test: Add header shell test
Message-Id: <175052888344.2250071.11324057542557447908.b4-ty@kernel.org>
Date: Sat, 21 Jun 2025 11:01:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 18 Jun 2025 17:25:55 -0700, Ian Rogers wrote:
> Add a shell test that sanity checks perf data and pipe mode produce
> expected header fields.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



