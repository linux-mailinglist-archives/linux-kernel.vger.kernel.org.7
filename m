Return-Path: <linux-kernel+bounces-770355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFBDB279E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC1AAC5EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B41F1921;
	Fri, 15 Aug 2025 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="usDtsnlG"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F7321FF3B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242074; cv=none; b=mUSB1h6YsE/1xeXMKc70I3ZPE3Ng0ZXVLKMUQhqEdveBVPYnpBDUBQQh5jjkDFqYWEObhosUbBn45ggDbfhIhU5+ZzRrTwGLxdGIJeuGxsL/BIDsjEN73PdDTJGHQ5Em9ORpdlUchsXwDLvDOyAgYnWfOMp/1zDQUubsKHn/a2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242074; c=relaxed/simple;
	bh=LqGqaNj2eQqbHIepbNnFta9CqT+u9VNzEKAgyWDgkQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sps7+3Am5Jsp8jFq84HEa2gp057nay9jzkB0VceXCNMWXFeWA/6kHgFJSmsBmIihtnPhjPJOr0LrHqvScIlIryr+czG7zCio7kLMOqfTsHVCX4BUD6HUTzGuUnkw2vB4Rx4u8Lw93pbs7k7SpH1FQWmewMypuZD449x6Pu/lUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=usDtsnlG; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755242069; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZRf3j0/5/Z8dqScEKOyu/qK0bmEYXZNMCna4JhG0NFA=;
	b=usDtsnlGqeDZ+NVdUYXqkvaJXmz9IRPWXJ8fnDry04L0t0P16CtY4rVs3epmiEbLM6gkiWGJdeN5lqxYxw9NdE3K/rxPOzHOGbsSVhMV6fkDfnJ0felg40b4kNZDmxPJz1YWzngyjgwMhyOq5Fjj6oo/wDawBbS5JR8YIdeTBCU=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wlo5rJk_1755242068 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 15:14:28 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Cc: paulmck@kernel.org,
	john.ogness@linutronix.de,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH 0/3] follow up patches for panic_print's generalization 
Date: Fri, 15 Aug 2025 15:14:25 +0800
Message-Id: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
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

Feng Tang (3):
  lib/sys_info: handle sys_info_mask==0 case
  panic: refine the document for 'panic_print'
  panic: add note that 'panic_print' parameter is deprecated

 .../admin-guide/kernel-parameters.txt         |  2 +-
 Documentation/admin-guide/sysctl/kernel.rst   |  2 +-
 include/linux/moduleparam.h                   | 14 ++++++++++++++
 kernel/panic.c                                | 19 ++++++++++++++++++-
 lib/sys_info.c                                |  5 ++++-
 5 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.43.5


