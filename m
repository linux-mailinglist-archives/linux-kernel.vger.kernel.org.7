Return-Path: <linux-kernel+bounces-759006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA45B1D703
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAFF1892BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481D23B638;
	Thu,  7 Aug 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ryPizfHX"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC223ABB2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567565; cv=none; b=rnNNyH90DXcLue7qYupd0c7tegIT3Hx5d+O+oI8K5sE1xVHplK85pFCOHnag6aBQGZKn1eF/zx5oNJ553u3zTyOJ0yqv1KT540CmMGjeEjvBm4QGtksk0JSx8cxeS5yDHeJWgRDH4BvsthoMWmd/ollUP1pR+ULSR5vV+D4X1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567565; c=relaxed/simple;
	bh=/j/0CFagv8ovoKO2D7mEsPuZqxQrhWmRFdUB2jOt43M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PZGK54mMFCCwEPRBxhlLRKgGz+f5oSIdWJpKC1rXPqnF2rbzbLTa4ArS19hdGdV9IeWckXNtw8eERYsUazDpO0LbRltzWi0tdwZw7QjvxKUyvN6LNuQVPbCN5RBXgGENAKmNfKjcZSeWGTr2UzO4jp7iWcmVuncT7U4kdLEukEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ryPizfHX; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1754567254; bh=Nzi+y4Mv1Px6SqC1QCxkHwptqaKNRcR6sgzWrAi9eyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ryPizfHXBUlVCxXEuycZX9Hj/GZxq1/QKOnb1TagUeNIoT+FUSOP6K0Cx19kQyXV7
	 zh5wiinyCRt9TX1mE/5k8dqhvg+HG25pqdx7rQH0i57kSDk5UMlujsQ6DwJKIdl64M
	 ysG4HD8s3G3zFv+l47emoM/Jw+IHAgKbqQ1/WaT4=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id A5691041; Thu, 07 Aug 2025 19:41:22 +0800
X-QQ-mid: xmsmtpt1754566882tbc6a1he2
Message-ID: <tencent_46A42583BA68BB6233C69EF11B674B7C1B08@qq.com>
X-QQ-XMAILINFO: NdB5/PuY7PjG6CG0T/xSJ+el3OBOlmvc/2cLRFA1vqtZbm64ZgAbgszpKOlL4O
	 OF1ronBy9rarmmUolXD5qdkcQT8LenbRvWsEZeOU78bALppI/j4nuAyBEBNrbQHrd3Xyox0WmkZ7
	 9NMa2jtHqiTNpO31vLVQL0ayJozCzFaiaoQYF+2xe56HnxCfj6MVyB2uZVwjisL3HGwlnvLFUxDv
	 k+SkH5PHequZmUbVRBN7vh+KJU9S8LSTJjSchyAHHocGUanK8e2kxyVNfayNl/yb+h/w5h4WptxE
	 jWcKR+IMhvvwoMhlvP71HeI8I318v2U0AVWYS0UjEcRw6HQul4Qk3/JyB8B3n0unJqJsyUm4Y+Yf
	 r6oi84QYxPKPYiLooEsbiQ7HrfcjekwiHNATw+URnit2Fh5G32wkPEv+IUzoBho4WW1TNi4SkuN/
	 zfAkWLditIxI863jxw7JO/sVR9mCfZanFl1r8JvsZkop2z2likiHtOBWDYzGRzhgSGPXL5z2DTGa
	 gxA0iPrfNzSo1smRQemPeCaVk3WApWrTc4jzlU5tNRHvBnq6SPERs2UhN15oXuYc/A8wxHtqaNYT
	 KwRfyHYpY1XpdqBaWKkVo9ca5iereGYE9iEv4TvlIDXoG1vJOGna+txR+MoHHSYZILWNl5IWsiob
	 Eetj0fWod+Pnb5fda9HkRciOoZmofgGFuZ3NLQT4RkUY6glN9R0p9TpKREVVNufvr17AyxkFMiyG
	 BzLRwd5RAIHh72obiRz8HHNUy8ZdCPHrpLF3f2TLSYjCK8cgIfoOnhaEzx54qw8IzV1IjWWLaGdz
	 6G6nf7daNwCqKKi4GFkL41M07PbXgBwdLHI/9pxiwFahCYuc7GaoVFBev2tEpl26RzVLG1ho4QpE
	 3do2ryc8qnPJ/WjOCizCi9dJrogwMW7g/wyXmRmpLLhAL3lPp+PUICIGmruobS0fVAbAZ35WlW
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2d7d0fbb5fb979113ff3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_remove
Date: Thu,  7 Aug 2025 19:41:16 +0800
X-OQ-MSGID: <20250807114115.3235525-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6890f71a.050a0220.7f033.0010.GAE@google.com>
References: <6890f71a.050a0220.7f033.0010.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..8fff08c4c360 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -395,7 +395,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	struct request_queue *q;
 	int error;
 
-	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | __GFP_ZERO,
+	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_NOFS | __GFP_ZERO,
 				  node_id);
 	if (!q)
 		return ERR_PTR(-ENOMEM);


