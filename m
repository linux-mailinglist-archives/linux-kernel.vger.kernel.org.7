Return-Path: <linux-kernel+bounces-771666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB27B28A32
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE4558374C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3AD19F135;
	Sat, 16 Aug 2025 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXlEq53K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D415ECD7;
	Sat, 16 Aug 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314201; cv=none; b=vDB5CfmnUZnMzDot8eElgcmUk0gOjlk5mRkDPhc5fncPydJXPtBFBl2Q2Dvgsn7/cAeoC4uaqtVaSW/7L8o70ZG0XG0nlsU5a3IYlm1c8+cQn7OsEXMCvWfUjvMvqKfQ5IdEwj2mIEj9L3a6brYW40SiyA8sy6mCPXtieoVXxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314201; c=relaxed/simple;
	bh=NFD6hde2HewAQQPNS9+iLbK5cknXHkrysgrIbDhm46g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uD8aUm4A4aPoN2W47LPMp5xPwabCex9gFYseGpe07BZDdz58twd3ZPNnNzondLQTCNz3FxhcJVegZz2m4n5QCbojGhcHQOsEujeH6wGejFlPiZ3rltkGvY5GT+RVOn9u+vIah3kRw0Q3ZqwkGnFy2R1JXSD/RmtoHtbKEhNYQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXlEq53K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7B3C4CEEB;
	Sat, 16 Aug 2025 03:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314201;
	bh=NFD6hde2HewAQQPNS9+iLbK5cknXHkrysgrIbDhm46g=;
	h=From:To:Cc:Subject:Date:From;
	b=mXlEq53KYpbmiFtVYHXKQ4UODSmfac+Q8wkMntpd61yp5DEnlkQdKJZVDrMbhP4EX
	 THV49OfdO2vISv456ejQxFakNVAtPXMVy0SwmPANdJDu4qXchxilD9umF+fo3LZ4kZ
	 P7egAhNWZ+YHCPV86QW8KBWbpIzc2TSD6GhJTc3jzZ5iC4kUvw8wTsm/byegG/R9Np
	 qpD63U7AMPj65obM4s5FrJMM5qR4FY7bf0rStapC1UrsWhNICRT7eSxbxXVXpt/svW
	 vac9+5obtfByuFkiHAIkBuW/VUt5n6sOPBMaB07id+ZiRaALC6nAgg0w9KzYHUhmrY
	 Wnrq2G6jvizEg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCHSET v5 00/12] perf annotate: Support --code-with-type on TUI
Date: Fri, 15 Aug 2025 20:16:23 -0700
Message-ID: <20250816031635.25318-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hello,

The --code-with-type option is to show normal annotate output with type
information.  It was supported only on --stdio, but this change adds it
to TUI as well.

Arnaldo, please tell me if you still don't like the
__hist_entry__tui_annotate() but I don't have a better idea for now.

v5 changes)
 * use a copy of hist entry for perf top  (Ian)
 * split disasm_line__write() change  (Ian)
 * constify annotation_write_ops parameter  (Ian)
 * update printed length calculation  (Ian)
 * remove annotation_print_data.start
 * add a hashmap to skip duplicate processing

v4 changes)
 * add dso__debuginfo() helper  (Ian)

v3 changes)
 * hide stack operation and stack canary by default

v2 changes)
 * use 'T' key to toggle data type display  (Arnaldo)
 * display '[Type]' in the title line when it's enabled  (Arnaldo)
 * show warning when debug info is not available  (Arnaldo)
 * fix a typo  (Arnaldo)

Actually the command line option sets the default behavior and users can
change it by pressing 'T' key in the TUI annotate browser.

The code is also available at 'perf/annotate-code-type-tui-v5' branch at
https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (12):
  perf annotate: Rename to __hist_entry__tui_annotate()
  perf annotate: Remove annotation_print_data.start
  perf annotate: Remove __annotation_line__write()
  perf annotate: Pass annotation_print_data to annotation_line__write()
  perf annotate: Simplify width calculation in annotation_line__write()
  perf annotate: Return printed number from disasm_line__write()
  perf annotate: Add --code-with-type support for TUI
  perf annotate: Add 'T' hot key to toggle data type display
  perf annotate: Show warning when debuginfo is not available
  perf annotate: Hide data-type for stack operation and canary
  perf annotate: Add dso__debuginfo() helper
  perf annotate: Use a hashmap to save type data

 tools/perf/Documentation/perf-annotate.txt |   1 -
 tools/perf/builtin-annotate.c              |   5 -
 tools/perf/ui/browsers/annotate.c          | 117 ++++++++++++--
 tools/perf/ui/browsers/hists.c             |   2 +-
 tools/perf/util/annotate.c                 | 178 +++++++++++++++------
 tools/perf/util/annotate.h                 |  29 ++--
 tools/perf/util/dso.h                      |  21 +++
 tools/perf/util/hist.h                     |  12 +-
 8 files changed, 273 insertions(+), 92 deletions(-)

-- 
2.50.1


