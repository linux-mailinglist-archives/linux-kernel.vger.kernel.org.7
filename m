Return-Path: <linux-kernel+bounces-727211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82827B01685
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F341CA37E9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB32621CC43;
	Fri, 11 Jul 2025 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kDPAIK2d"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265F21A457;
	Fri, 11 Jul 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222989; cv=none; b=TARa9q0NpfJmqRmUelHRjhXbvoS0WFbgFCXz+DnBR9B9SDXv9YrdXzLjKj6iGNqltPey07Bs4+Ao/FgCPxzGK1iswL/1LkGjHwZclmlwekHl90IYrNNGTZ7ExxY/tThQ1jxdE/O3QDNZIzqN/tpoNrtzplXvlknUcmQQwciiVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222989; c=relaxed/simple;
	bh=bwj8bQCQTSix0tFd7qc0EZ2our6zfTa68jiiExDYk5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gSlJchn02szLk/QfITRMvNZwE9spCy20VqQaB6FWsGRIfO0TtUiAqjwxSs5D+O9sBwENq1S6KyEo5PfddugT2QNyDllnO55avl+i9KJIyRJaw5br4YdzAF0zl3GVDIx8brPc8Zg3Q3JUTfsT8xy5EZFA4IxggdAZaVPmEBIJxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kDPAIK2d; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dK
	+nduMdCKOu9mKYc1GxziLAjiaoIfvFOt6yIdLSkqk=; b=kDPAIK2dqi/6SNrtak
	Pi0Li9ETZkO9gcB7ymgeqv5A5Am5U3Dv/A6rFH3Mn57RzJpIWL5x39vZOf/pt2Pa
	cmpIZQntpU1H1u3WrRDAXCfHQ50yrhy7L5hM2qw+LCmn1NwcWM8WJLQ/OqqsxZLp
	S8imV7WGjULK72GYHxfcQQ0fs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCHLA3nzHBoQrP2Dw--.36013S2;
	Fri, 11 Jul 2025 16:35:52 +0800 (CST)
From: oushixiong1025@163.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] usb: gadget: uvc: destroy worker when function is unbound
Date: Fri, 11 Jul 2025 16:35:50 +0800
Message-Id: <20250711083550.425714-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHLA3nzHBoQrP2Dw--.36013S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDJw1fArWrXr1UGw18uFg_yoW3WFg_CF
	y2qrZ7Gr9rG34DK3yI9a9xuFW2k3Z8Xry0gF1qgry5t34jqw17uw1vvr4vy3Wj9r1xCFnI
	k345JF9xAwn3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8x9N7UUUUU==
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXR+HD2hwyJlhVwAAs1

From: Shixiong Ou <oushixiong@kylinos.cn>

Destroy worker when function is unbound.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/usb/gadget/function/f_uvc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index aa6ab666741a..e38477751894 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -992,6 +992,7 @@ static void uvc_function_unbind(struct usb_configuration *c,
 	uvcg_info(f, "%s()\n", __func__);
 
 	kthread_cancel_work_sync(&video->hw_submit);
+	kthread_destroy_worker(video->kworker);
 
 	if (video->async_wq)
 		destroy_workqueue(video->async_wq);
-- 
2.25.1


