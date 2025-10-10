Return-Path: <linux-kernel+bounces-847950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FE3BCC252
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7201A62710
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D061026159E;
	Fri, 10 Oct 2025 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDhWykYG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A026C25A655
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085258; cv=none; b=R35Vtf1OefzT16mRJVVhy1UgE5gyxR3new7cP1nzaUWIb47xZTqMY6jd/IrzCeeQUd8v4R7ZzgSR+QG1AUjiSZhSNq/rf4usrgZGLEXiuL5RiYdlv2MaL2mGI3RwmVr0NrdUq1wKfmvv0SE94y09xNPEUcv7VZuNBi6/EFzXjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085258; c=relaxed/simple;
	bh=0nVHt1G+Jqp+oKetIsOYgW2nvWNPm+MyfNq6WGmqwlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkOEvuNRmvE7RIJq2a3vmlxwgr9tcSYNDSlwTADMJaS65sruc468PSrcsG2Obrq7QeAa6J44XSokidJRGx6UYE/ns36LLrEI6Vl+urorqPi67xKEzMrA8bfmIpZHu5yG22VYclVbW9hQKrDTCTXRIk1gs1WfL4fLtO6i9/euEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDhWykYG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760085255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XEPIUQZfoE+JbLbZCi1s6/pbCySyRkdPveDvN9XnJDU=;
	b=hDhWykYG+IiRL9tSUjGkgIGy1xSvLB0yuOuEWafsAHrW36spUJyCTWN70U9v72gvhMARg/
	kmOmwADJ9t9LfFQtSrMu7KzIiaG4XQoS9WT8/YbG6KA+12EKj5rsoy6Vsn35qLqgL1XqL6
	lv7tTso9BIepM1x3jG5IkyJxkeG7bDs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-kjVYaasiM0yHr0H3tFuLMQ-1; Fri,
 10 Oct 2025 04:34:12 -0400
X-MC-Unique: kjVYaasiM0yHr0H3tFuLMQ-1
X-Mimecast-MFC-AGG-ID: kjVYaasiM0yHr0H3tFuLMQ_1760085251
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC37A180057A;
	Fri, 10 Oct 2025 08:34:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D847519560BB;
	Fri, 10 Oct 2025 08:34:05 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/9] Documentation/rtla: Cover default options
Date: Fri, 10 Oct 2025 10:33:29 +0200
Message-ID: <20251010083338.478961-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

RTLA has many options that have a default value that is used when
the option is not set associated with them. Those are not covered in
the documentation for the options, which creates confusion among users.

Document the default behavior for all relevant options: -H, -P, -C,
--trace-buffer-size. Some of these are covered in general
descriptions, only missing from the option documentation.

Also, fix a few typos and incorrect naming of tracers.

-----------------------

The patchset contains two parts: fixes (first five commits), and new
additions for default options, which were previously undocumented or
poorly documented (the rest).

The patchset assumes [1] is applied, renaming included files to *.txt
from *.rst, to prevent build error on "make htmldocs".

Note: I am aware that there are more issues with the documentation, just
not everything can (and should) be fixed in one patchset.

[1] https://lore.kernel.org/linux-trace-kernel/20251008184522.13201-1-krishnagopi487@gmail.com/

Tomas Glozar (9):
  Documentation/rtla: Fix typo in common_options.txt
  Documentation/rtla: Fix typo in common_timerlat_options.txt
  Documentation/rtla: Fix typo in rtla-timerlat-top.rst
  Documentation/rtla: Fix typo in common_timerlat_options.txt
  Documentation/rtla: Correct tracer name for common options
  Documentation/rtla: Mention default priority
  Documentation/rtla: Mention default cgroup state
  Documentation/trace: Specify exact priority for timerlat
  Documentation/rtla: Include defaults for tracer options

 Documentation/tools/rtla/common_options.txt      | 16 +++++++++++++---
 .../tools/rtla/common_timerlat_options.txt       |  4 ++--
 Documentation/tools/rtla/rtla-timerlat-top.rst   |  2 +-
 Documentation/trace/timerlat-tracer.rst          | 12 ++++++------
 4 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.51.0


