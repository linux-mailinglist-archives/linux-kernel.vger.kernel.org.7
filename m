Return-Path: <linux-kernel+bounces-834879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8303ABA5BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D274C0CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638E12D23AD;
	Sat, 27 Sep 2025 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G+DpoSOp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6nMtjTt9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98891F541E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758963675; cv=none; b=l8SG+XYWGOyf2sv01zJ0gkuqzDU0oYUYmefeTsmBd1SwbAAM+CDR2Urah5VC9eua4xoKrOpUq+idTmpd45kyADSXCdJ5ruM7VnXR2G2+k5gDihfLFyGNtKH+L0d/bMSauEPFT3fJo+U4NTjknCXsk7cEMhAwoV39KJDiQEInxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758963675; c=relaxed/simple;
	bh=zdRQRHhvt6Vawrp71Ee8rgqcd+My0HHqWVdNW8KLfhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h4Zo3AONNWKa24uTn62lGuASvqBIDUj+aE/RkOnOCP4dsxovBopevO229niBgyFYegs4UQ3W2ajZePt8GBTY1zpzBbCIEzDUsbhIyIfcAqzndyhtiS/YFgYT8aMMmvGNwiaxDrPDtbOLL8+0v00AnrwmsQxDYtkxZt8NpEA3YbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G+DpoSOp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6nMtjTt9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 27 Sep 2025 11:01:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758963671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iHeXG/5kOeq+hBxNkoY7r+qiSkTLeC9wrtt/YnX+4bA=;
	b=G+DpoSOpsWd04425RUnGyl+QPf1u1lkClWo7Jh0D0fKL+CkAgL+1XshVSAZ4pLxOnh/VSR
	eJNkcIHF9FUFGiiVhicfl5qKyi5lKMDjpE8OwUDVVcg2TL7ViWihF80ewTbM0vlBQTL+4I
	cbZUYWp6qyuHcBXgBaVufynUaf5d/MtiktXLBzPpAmVyhk0P8WnhJR/MHJJp102SMhXlQg
	4K33BbBl0JMDyWcIkx17ND+JPpxAByIVwbQdTDxEDlMMEpxlVycDGaX/c1iSJ0epZze9XW
	5Mrg2wTbpW3w9JXBZtKN5qJ88E0kNye7rovdL2IUOwqnhAnsJvW55fa5/VgfnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758963671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iHeXG/5kOeq+hBxNkoY7r+qiSkTLeC9wrtt/YnX+4bA=;
	b=6nMtjTt9j3tWoOzJ/SaKsflPKqwsdLTHx7GmNxaitg4Ui5kYRPl5Z7+I7PFPWrI8pzMBEl
	HDSGfvBv9hlgLHCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] locking: Add local_locks to MAINTAINERS
Message-ID: <20250927090110.t8Tm9yrk@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The local_lock_t was never added to the MAINTAINERS file since its
inclusion.

Add local_lock_t to the locking primitives section.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f346abc84ab0..45e6499405236 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14291,6 +14291,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 F:	Documentation/locking/
 F:	arch/*/include/asm/spinlock*.h
+F:	include/linux/local_lock*.h
 F:	include/linux/lockdep*.h
 F:	include/linux/mutex*.h
 F:	include/linux/rwlock*.h
-- 
2.51.0


