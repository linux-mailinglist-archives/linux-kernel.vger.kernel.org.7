Return-Path: <linux-kernel+bounces-783920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E54B33435
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B8D3B6854
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC1235041;
	Mon, 25 Aug 2025 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MLWMxJE3"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421FA1CEAB2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090634; cv=none; b=k0VH1XsD+YCAl7RxueCHCcUfnZLoh3uWKbKeOcgkkFFaf8VV8nLLI4JQHA9Imdk/ld5XUjfh2qWrCv00ZSChHiG2gq1KI6nMhIgFBn0EaWhhv/inMa5XwI6dNvxay/pzxxwXCFhwWd1NAhZajp+DKQpN9Kdi1zX7+Gim+JpFVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090634; c=relaxed/simple;
	bh=1ePLtSUBcarwJa5LeEXPPl01AUNMMi4CqTrkfPRi8mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UqRY8qUObVxxai9y2s9Mk2K80Pfg8dtsonzqJaoT3P+83o5CcKKqIT49lPvps3hgSH8ZmN0QodadVukHcAEBgTby1Kk16OsNVE2fTz/dCd6HwAdXWnPRMO1nrlsxdpVEFl1IzDDbWsLkZF4CP8W6Swbqe4FOnPA0yUYyEDdFP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MLWMxJE3; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756090622; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RwwE6X5Q1HoNLyqlnpZ8qyvl5FJbjZWxGbFV6q2X61w=;
	b=MLWMxJE3CzSf5FS9UTWfablZVMGZFN0dTB03y2MCZvZL5jyzQkuhs9F+Pqa9uFH2qKouPXV1EKAR2L9/Mimd8f2xOjwHP103vODzdGoVscjL+YuEJKPx0nzbTYHF6up0ewwFK2HSaIwtsqY8XQ/V3zWGTlMtSHIwrnVisvULl9Y=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WmPseH5_1756090621 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 10:57:02 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Cc: Askar Safin <safinaskar@zohomail.com>,
	paulmck@kernel.org,
	john.ogness@linutronix.de,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2 0/4] follow up patches for panic_print's generalization 
Date: Mon, 25 Aug 2025 10:56:57 +0800
Message-Id: <20250825025701.81921-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalization of panic_print's dump function [1] has been merged, and
this patchset is to address some remaining issues, like adding note of
the obsoletion of 'panic_print' cmdline parameter, refining the kernel
document for panic_print, and hardening some string management.

Please help to review!

- Feng

Changelog:

  v2:
  * Add Petr's cleanup patch for obsoleting msg of 'panic_print'
  * Some comment and format cleanup
  * Collect review/test tags


Feng Tang (3):
  lib/sys_info: handle sys_info_mask==0 case
  panic: refine the document for 'panic_print'
  panic: add note that 'panic_print' parameter is deprecated

Petr Mladek (1):
  panic: Clean up message about deprecated 'panic_print' parameter

 .../admin-guide/kernel-parameters.txt         |  2 +-
 Documentation/admin-guide/sysctl/kernel.rst   |  2 +-
 include/linux/moduleparam.h                   | 13 ++++++++++
 kernel/panic.c                                | 26 +++++++++++++++++--
 lib/sys_info.c                                |  3 ++-
 5 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.39.5 (Apple Git-154)


