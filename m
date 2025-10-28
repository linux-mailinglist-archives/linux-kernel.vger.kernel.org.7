Return-Path: <linux-kernel+bounces-872969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFBAC12B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF5424E330D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4426CE3F;
	Tue, 28 Oct 2025 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UE9AF/R6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45B17555
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620991; cv=none; b=DNohy/6nH415E5vzZpeV5nwJx1ByUUxHGbD7b++lWMTYYhfSuvRcxKGgv4JRX/qWFhDuuQ7ve3gGxORHikMnhgDrQqQpQdLeWgyc2PMjBnUq3eC4+peKvk9T6I8glSCL8oN0cAjEBEEBUuYL9zkjU87Xj0FKaEMN40fEA18vCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620991; c=relaxed/simple;
	bh=0217rs0LwBe2oS4qcYMZdZiISRop0reVzqdAotWS97I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZxl9NyOE/NHj4oF/9b1Qa15rPrDV4xKpdHrXGBssYYEPbXCkMlKj2VcgYJwcUUCNaY2k1AGljA9iGEdaNMM3STTbjR/kdKY1q0GQjlwznOkSsOY74sW4dWyaLZFA/7E2QYnw6u7ODQANthOTl5jpGcgCOwU35Qwxz1KUZuyYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UE9AF/R6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761620986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/PboEGb5Bi20U4EjQEuRJRA//eO8r+xifvCuzH96AMU=;
	b=UE9AF/R6KzUYcBvqXQjN9BLqsjHuL736SWd6nWNERwsobnoL3Il8PrRf6Bdnwbs9GT9fU/
	GiVG2CgzHmed062lb6++MUsaVTBD9Yb/gDZy/fYmHrJM7WsGhGuLV1iEgSJzac1C27ib+N
	is0pSvDILFEKoHXQGg1ESpXlK7cw2gc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-BdOLfbtFP9is6KRXmxDCcg-1; Mon,
 27 Oct 2025 23:09:41 -0400
X-MC-Unique: BdOLfbtFP9is6KRXmxDCcg-1
X-Mimecast-MFC-AGG-ID: BdOLfbtFP9is6KRXmxDCcg_1761620978
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81EEF180136A;
	Tue, 28 Oct 2025 03:09:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E93B2180057F;
	Tue, 28 Oct 2025 03:09:27 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCHv2 0/2]: kexec: Force kexec to proceed under heavy deadline load
Date: Tue, 28 Oct 2025 11:09:12 +0800
Message-ID: <20251028030914.9520-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

During discussion of the scheduler deadline bug [1], Pierre Gondois
pointed out a potential issue during kexec: as CPUs are unplugged, the
available DL bandwidth of the root domain gradually decreases. At some
point, insufficient bandwidth triggers an overflow detection, causing
CPU hot-removal to fail and kexec to hang.[2]
    
I reproduced it on a system with 160 cpus with the following command
  seq 10 | xargs -I{} -P10 sh -c 'chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &'
  kexec -e

The system hang during the kexec process.
 
This series skips the DL bandwidth check, SIGSTOP all DL tasks so that
the kexec process can proceed.

[1]: https://lore.kernel.org/all/20250929133602.32462-1-piliu@redhat.com/
[2]: https://lore.kernel.org/all/3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com/

RFC -> v2:
Instead of migrating the DL tasks, SIGSTOP them.

Pingfan Liu (2):
  sched/deadline: Skip the deadline bandwidth check if kexec_in_progress
  kernel/kexec: Stop all userspace deadline tasks

 kernel/kexec_core.c     | 23 +++++++++++++++++++++++
 kernel/sched/deadline.c |  7 +++++++
 2 files changed, 30 insertions(+)

-- 
2.49.0


