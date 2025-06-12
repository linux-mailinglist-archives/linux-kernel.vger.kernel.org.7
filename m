Return-Path: <linux-kernel+bounces-683488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB1AD6E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 12:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D154163B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA68238C3B;
	Thu, 12 Jun 2025 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axYtKBiO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C409231A32
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725049; cv=none; b=EeCJ7Lx9MK6lV/jKgekgSa0DNff4zAZQTOYMj5uQPanyzvuAkCQ1c173aIwyeQVu/KpsNTeFf20qAbA5at5xUaDUMURkIa6yCJVfJ9+njmABAh/X3f2PHpmrJJuSYx8w4rFxY76U3rWo29sMumNORfUP9eEu9kfBJQRS2RWzNJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725049; c=relaxed/simple;
	bh=IR2tm94ReCty00Me3LuhlSMLcePN3XeMWFB4N6hGKp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqxWa03u/0GhHJ3S5xqZL8AjRzDxua/PnY9mlHtrVP0+1SA2EKbyr+ioATvb/4rCZqKTPlcRGLaxcZlmcUkAqLNsetTZqtAW8PUPcyD/12pKx/tdSXrwuwJZ57BbLHWbZ+7fHPkLdf/eHmUmEjmmiJUeSiKarZUbRHron8NJ03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axYtKBiO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749725045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=evoxoq79rUNR1aL96QrvR7FxasZWL1eL5arK+Kk98Uw=;
	b=axYtKBiOQR3afWfNmgfU2/N7GdP41gzqIt61hxASYu+/ZWkhUxEMTR/eVg5HraFXAde9nR
	nA9F8Y8Lc+ojNXPzxpOPiO+2FpErY3TsJ/5weP84r0dxgaC4EujcMrD6pLMq85n+fODlGH
	zPaEGz8Gb+PhWsuWpzMJGNwZQbwV2qM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-RJVN8nC1M16lxocY0wblCg-1; Thu,
 12 Jun 2025 06:44:02 -0400
X-MC-Unique: RJVN8nC1M16lxocY0wblCg-1
X-Mimecast-MFC-AGG-ID: RJVN8nC1M16lxocY0wblCg_1749725041
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C98601809C87;
	Thu, 12 Jun 2025 10:44:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.242.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B881719560A3;
	Thu, 12 Jun 2025 10:43:56 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: acarmina@redhat.com,
	chuck.wolber@boeing.com,
	Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH 0/2] tracing: ftrace_enable_fops fixes
Date: Thu, 12 Jun 2025 12:43:47 +0200
Message-ID: <20250612104349.5047-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This patchset addresses some issues found in ftrace_enable_fops and
proposes low-level documentation for event_enable_write/read.

Gabriele Paoloni (2):
  tracing: fixes of ftrace_enable_fops
  tracing: add testable specifications for event_enable_write/read

 kernel/trace/trace_events.c | 83 +++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

-- 
2.48.1


