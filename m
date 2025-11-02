Return-Path: <linux-kernel+bounces-882361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C2FC2A47C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BEE3AB966
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F529D277;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bloD1Jui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933252505A5;
	Mon,  3 Nov 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154352; cv=none; b=XeQWl3fJVNOsagftPDFeCKRt0pIjqC51MeDFMLYPVfDxlcJiyquUHjqRAHJLLToAzZ76PlPxfKoTzkGSTK1ED9VpSOwxbK51TzSgYtFlNakkRiwvch+wSz+/fv3hWWtTslI8lYgT4o4atZ2zttvbpLd9wpe7utjxpXdd/09oC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154352; c=relaxed/simple;
	bh=o3FPsu9oFmCNzOIxp8CepOafB2L7gYII4K494ei8Kbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lON2XIzIDkU7v1V3d9ulp7KNUNkBlpq13ZUs59X7N15Ou8f71W8WpdaT34CTlp9JD7JTeHXtRz7EQrsbZJPQFs11ya4+0iraldgpLsSSfk0NWYhfTVdKTOzNUXWwnl7ghbPGRuigTgwdCjikXXR/ymu8fOFJo83RP2P4OshId3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bloD1Jui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C768C116B1;
	Mon,  3 Nov 2025 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154352;
	bh=o3FPsu9oFmCNzOIxp8CepOafB2L7gYII4K494ei8Kbk=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=bloD1JuiJ4RWYYCeSGaq5VoU8fshB/tZZ5bCLsf4u7vjoqqGHFem1+Y+wOriRxUu0
	 qlIuxr6xB/9YLzgYxatpxqwuXpdAf5jxo7ySqhz6giTOIc6SAMTwSFQpieyCIsPI3d
	 U5Qnla7yNQEj4F6XrFe+ZJ5686lbPOnJkOCwgzujfnAiLRJ62Wmi3GR4FaTw7F6n+T
	 jlsDm2gkHdh2wtP8fx7AhIRZLFOoy819CgjmEkoSLeEfK2s+bJ7mI+elLRDUPby2oI
	 Bk21g9XcJ9q5LboBEqOsWqdO5mEJDa23j3lClBWCy1WugB9uhn5oePZne/5mAyFIGS
	 Xm3AwIG4A9xDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7CB5BCE0F4C; Sun,  2 Nov 2025 14:49:34 -0800 (PST)
Date: Sun, 2 Nov 2025 14:49:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/8] refscale updates for v6.19
Message-ID: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains additions of microbenchmarks to the refscale suite,
and depends on the SRCU series.

1.	Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().

2.	Add local_irq_disable() and local_irq_save() readers.

3.	Add local_bh_disable() readers.

4.	Add preempt_disable() readers.

5.	Add this_cpu_inc() readers.

6.	Add non-atomic per-CPU increment readers.

7.	Do not diable interrupts for tests involving local_bh_enable().

8.	Add SRCU-fast-updown readers.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/refscale.c |    9 +
 kernel/rcu/refscale.c   |  378 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 372 insertions(+), 15 deletions(-)

