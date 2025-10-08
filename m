Return-Path: <linux-kernel+bounces-845459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90202BC5067
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC581883584
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D37283C9E;
	Wed,  8 Oct 2025 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="oueu940+"
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE227055E;
	Wed,  8 Oct 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928116; cv=none; b=LiAcWOKoHnmkwaixlj8bhhEpY39V/qhgZYd9Ga/RkoNX3x+qpA1FrIhn8yq5e1ES4YaEQsP1pmq+Pk5U/WJ4fIYdnxMYdMRoyd+IKW/uZVO5aA/w4xk1zl2/KWY9A/w6KwTQ8Qb2cEnYNrUuGl20+Li1pJ2p/qYhgx7qC0p8pPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928116; c=relaxed/simple;
	bh=iyZ0NQTMwHJa0iRevFjZ1FacZ09ygg9cqm8+WLU/nb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T5J6z7faa8Ng8aJbimrOjhaZPEDIgGiWF8PhFw3fK5PSArW1dIduBkOVxdEg46mHVGdYwM962VlGfPS5ZQBMzpFev5saPVfqFObFvyV626uKM+lg+OS8rPDzvDJQYPoto7hLNX2ywQpDj0Q0X6P9ovENMiKaR1Vz29dblsIjCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=oueu940+; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id 78C9A8349E;
	Wed, 08 Oct 2025 15:47:29 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1b:3715:0:640:1185:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 63A8EC00DB;
	Wed, 08 Oct 2025 15:47:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LklD46OLveA0-JB9jbiOL;
	Wed, 08 Oct 2025 15:47:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759927640;
	bh=bkq8bxjoQBPBAeuIV+Iopt/vH8cY8Lqh9crfFUygyEc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=oueu940+xx8CrpE1N/VvyUC7r5OLbi3YFswozl9PaSVeEPclX2tH70L+qHv1MZVR1
	 2r7DlbvFfG+aNC0j7OEyq7xHiihbg+Sf+rkqrxYA8Dv4n/X3Y3raDzshe8YpIOhLYY
	 7DdL0RmbyzaASALMqeLOySMIKJ8557TCVBMeKj8A=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	acourbot@nvidia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	lyude@redhat.com,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2 0/4] rust: xarray: abstract xa_alloc and xa_alloc_cyclic
Date: Wed,  8 Oct 2025 15:46:15 +0300
Message-ID: <20251008124619.3160-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Second version of xa_alloc and xa_alloc_cyclic abstraction
patch series. See the initial version at [1].

[1]: https://lore.kernel.org/all/DDCV43KW9OGL.27I8HP4TSTQ6N@kernel.org/T/#u

This series will also be sent to linux-mm@kvack.org which was not done in
the previous submission.

Changes in v2:
  - Moved the pointer check into the constructor function.
  - Minor updates on the function doc-comments.
  - Minor updates on xa_alloc and xa_alloc_cyclic commit descriptions.
  - Replaced bindings::xa_limit with Range<u32> on xa_alloc_cyclic and
    xa_alloc.
  - Updated how alloc_cyclic handles the next pointer (it no longer
    requires a mutable reference)

Onur Özkan (4):
  rust: xarray: move pointer check into `XArray::new`
  rust: xarray: abstract `xa_alloc`
  rust: xarray: abstract `xa_alloc_cyclic`
  remove completed task from nova-core task list

 Documentation/gpu/nova/core/todo.rst |   8 ---
 rust/kernel/xarray.rs                | 101 +++++++++++++++++++++++++--
 2 files changed, 96 insertions(+), 13 deletions(-)

--
2.51.0


