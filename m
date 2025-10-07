Return-Path: <linux-kernel+bounces-844730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5A5BC29BD
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5733A3C3A31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9763B9;
	Tue,  7 Oct 2025 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALXVaBmr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E57A3FC2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868235; cv=none; b=JWBpoqdvaBtEyJ8nemyvrTmKkEE0XExJQrqFQZ46bsag61cxQlGt0U5qx+8HQF8mu0BCR5mLO/+cb7qlgsFstcJPgb+nMe+eIyWkWw5OEc0jqJOa0S+TApLPiTQnjd75lIgkWgraBUuZ9ie81ZGNttDgrzaFCLfucS8r46FvoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868235; c=relaxed/simple;
	bh=Kcv6zsMZfEl+6h8HunMxz3/G+uBgQtKYYMO13zoV/+M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hY5Gvs1Lwu4nNDJJ6FhDBTsI63HBIaH/Yh+dIHvD2CyJ0pkSKXPoPhNszBDulL0XdO7Jt6dfetGFU2OGt2gPaAdsr9FdTob6sxjZmei/lnaUOyiDJfGBVdT4jECLIEo4hCPy0nbHE9qWuAGYZYluRVE0TI7OjyudacqsR6djXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALXVaBmr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759868231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=QRrCe4gGX04uhNKyTCWKoCNqAVf8tAIrtZz+/8z1Jus=;
	b=ALXVaBmr6lISSEi9ArknqLldOEcfgyl5404bm09hyvlm7c7pxCeOnMt1wWnLjiCc2yKKTW
	ZKWy6M/elRi+5XJR4mMTvj7badPtLhJzo87EiIxiFJnkmM+lc1q6dtPEH2Rl5Uzu2lhLDM
	lcOnrKhs1QiRFQukd1kohf9SsK1Hi4w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-qMr4TglFM3OlOKpKI7Qttw-1; Tue,
 07 Oct 2025 16:17:08 -0400
X-MC-Unique: qMr4TglFM3OlOKpKI7Qttw-1
X-Mimecast-MFC-AGG-ID: qMr4TglFM3OlOKpKI7Qttw_1759868225
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5D8219560B8;
	Tue,  7 Oct 2025 20:17:04 +0000 (UTC)
Received: from localhost (unknown [10.22.88.226])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D91E1956056;
	Tue,  7 Oct 2025 20:17:03 +0000 (UTC)
Date: Tue, 7 Oct 2025 17:17:02 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.245-rt139
Message-ID: <aOV1PvarprPXURPb@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello RT-list!

I'm pleased to announce the 5.10.245-rt139 stable release.

This release is just an update to the new stable 5.10.245 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 7a9ef2cebfadb557a32d8fed925475de07f9ef86

Or to build 5.10.245-rt139 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.245.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.245-rt139.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis


