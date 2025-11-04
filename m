Return-Path: <linux-kernel+bounces-884935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A649C3188D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAD118C5103
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2C32D7C8;
	Tue,  4 Nov 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="WZHvPOJu"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5B2222D0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266618; cv=none; b=atjDV8uIanqs0oHjygq4UOfNFEaPye2hBYEBQPSaVBpZYbjym+OlW1lmXp43aabXhfCH81dEHE9xRC+vpyjAWnKAvCiASYIYHuTUyjB3HXFfv6LscvqCgOEg5sRLelPGRF42JrvoGuXV5gtjJ02joQsn/iK1DiZPfwaU1wcV5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266618; c=relaxed/simple;
	bh=F5S/0iH2cpmMGHud5IC55HcyTekJ4slPNvntrHD1n8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYjhSqZJq0M1npR3RcXgI7K/lYjYBQxvvI4REcJt/NHtD/yx9j8kpLiMNyBfo9FvoCqUR4BboSZrtyxDxGgAGm2BZ+BVvs1gmd5K4tCpDzxNPGb70FLAW6v5P8zMl0GaEKC2L8KqcU79ZLwjBSZMq7+tyJuqAmmSvsEF8YYzyj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=WZHvPOJu; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: fdbc7bb4-b98a-11f0-9e68-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fdbc7bb4-b98a-11f0-9e68-005056994fde;
	Tue, 04 Nov 2025 15:31:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=XbM4iNsi5nJLgtGzuN4SDkuKeOirEOrYvwhEt+pkvfM=;
	b=WZHvPOJuf2DwMtFLbTbDY7J/XNpVmwBNlWlhSCAZukdIraOBeVGLsTNt/enBpfX/yjadietqMHls2
	 jvEwC0Itvtvc7POAIhrXF5IiKTwW1p4Yt3StT7f2pX3e0ZCaoNBZIev8EvBkWS+X/Nrii923lAbovH
	 yxWmgX5PNs5g/leBDaqsjlCr4MVUipkN43JiCQ7S1yVnxg5dyB0OlA/V/Zx8RCoK7g+Q2HJ37fBj5c
	 yd+NBmgYAC3cLThClN8uGQGPV4jmEjBg70F2Z8JP/PyKu5Kl2K4aZpxaY+aDtBLA0hHUPG/HMobl8F
	 CWlejRzZ6IOL5JB4ySg/EoINJPgK4mQ==
X-KPN-MID: 33|LAJlAHdLnro746YRsnom0KjKcr8ybqbZPBrmTRGIYHn0sX+TuV+F1Pab7T19EzH
 DgYzw/r4aM3apNQVsi8q8GQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|TI1C/vEuYkrfME8/uwQA2fthvIzI1Vk97qlqOUmKxHpSzaYqs1V6xPXcssVCLjc
 tFaw9lfgUkB8sLLAQBCtVmg==
Received: from daedalus.home (unknown [178.231.9.53])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c27280d7-b98a-11f0-9bf6-00505699d6e5;
	Tue, 04 Nov 2025 15:30:07 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Cc: jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fix two syzbot corruption bugs in minix filesystem
Date: Tue,  4 Nov 2025 15:30:02 +0100
Message-ID: <20251104143005.3283980-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot fuzzes /fs by trying to mount and manipulate deliberately
corrupted filesystems. This should not lead to BUG_ONs and WARN_ONs for
easy to detect corruptions. This series adds code to be able to report
such corruptions and fixes two syzbot bugs on this kind.

Jori Koolstra (3):
  Add error handling to minix filesystem for inode corruption detection
  Fix a drop_nlink warning in minix_rmdir
  Fix a drop_nlink warning in minix_rename

 fs/minix/inode.c | 16 ++++++++++++++++
 fs/minix/minix.h |  9 +++++++++
 fs/minix/namei.c | 39 ++++++++++++++++++++++++++++++++-------
 3 files changed, 57 insertions(+), 7 deletions(-)

-- 
2.51.2


