Return-Path: <linux-kernel+bounces-644747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86695AB43FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 20:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232CD19E3E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D19297128;
	Mon, 12 May 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9YMBkgA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAD1E5705
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075576; cv=none; b=bgCVSMJ0pN7WheKON3dA+rXGDHne6JbXkezy2AwipfG1SLZIkzKmswAAZKCHbkEUEaQXWKw04ayPwUjuYPsWpjARCwCuDKF32UPtbGxncvnNIg/DBLHei74HMv6ClnDL7GpW1EOoNi0U4aRCykMztqnNy1ZTcjCOSbf+zL8dLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075576; c=relaxed/simple;
	bh=KTHbeKmh7csudR8176KG0O0zrZanG5wTGnGpE2K39TY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l17kfsrq474blwzrvUuv2yYr64IYH7amOZKF6pCdjEPZpdwIuUSeJuwsfLWvPe7y6wUexzEbRmi/6M/UcEJzijd1PMDMbF1GLLXhap1h+pYYrvmUmQFG+A9Q+f04l5IMxtKM06GJ2x14iTZAfJ1zmBS+6yGZFXeW+JiAahuvhN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9YMBkgA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747075571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=MRlJdxaHRLU0G69QLi6XRmYLc6kA0ycMlNYlR7WFnAU=;
	b=S9YMBkgAZ4DsuBF7rwnt+upvGAX+RdtTT2oVnD5OqaL5bZHK2TwEShoYbJ/ojaIn07RwIK
	/PnA5eufTpKAGPcxzgOMENVIHt3jjtUKE128L33j9FW3w7cFmAiGOqoKpw4g1+LBW8S/LK
	cXpDMtxwPi/dN5ioNC2+iqc7SFA7kAE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606--BxVW4CCMU6MRGstWZVZRQ-1; Mon,
 12 May 2025 14:46:07 -0400
X-MC-Unique: -BxVW4CCMU6MRGstWZVZRQ-1
X-Mimecast-MFC-AGG-ID: -BxVW4CCMU6MRGstWZVZRQ_1747075565
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB7C21800877;
	Mon, 12 May 2025 18:46:04 +0000 (UTC)
Received: from localhost (unknown [10.22.80.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C44D9180049D;
	Mon, 12 May 2025 18:46:03 +0000 (UTC)
Date: Mon, 12 May 2025 15:46:02 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.237-rt131
Message-ID: <aCJB6th2YHpoWEUV@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello RT-list!

I'm pleased to announce the 5.10.237-rt131 stable release.

This release is just an update to the new stable 5.10.237
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 54373e23e43ab56de8b65b83bf5371e9bc26dfa9

Or to build 5.10.237-rt131 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.237.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.237-rt131.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis


