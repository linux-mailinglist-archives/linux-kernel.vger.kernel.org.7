Return-Path: <linux-kernel+bounces-826631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB1CB8EFF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986D517AA24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2726520468E;
	Mon, 22 Sep 2025 05:19:47 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75822A1C7;
	Mon, 22 Sep 2025 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758518386; cv=none; b=M3znK5c7oUM7GJmMAwNqBco5R24ZvhWe9AAmkiusO+2KRK8ZjPZ23LDOtbBoYF60YzBzvL7XhIGF1cip4kDD3KawHksdFg/xfvlg8S7BK3OQW4Y4zkOfjjbLSrRgk4rL5ByVthQZXSgh+qOn40wyxvoxkBMriXxHsMho/DrP6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758518386; c=relaxed/simple;
	bh=5Vhn615erT56U5+0fJC8EIRESo6bbvqz1nnSe6HNd0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TcaP0XdmXGJufeHopItuF+BKozklvqC+L1PgK/mh2lt38//KL2qN0Dmp1EXFiZwnQb3Eb8q3R6KTvJaRasY+CpQUSmEsa6v7918NoXV56RTza3htJYY0oZiXwh6hospSwaZqQQub5r1ZtlUV9/b+SVcP+lYwYQZOpMePCPrcx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.18.142])
	by mtasvr (Coremail) with SMTP id _____wBX0WJP3NBoIBxdAg--.35127S3;
	Mon, 22 Sep 2025 13:19:12 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.18.142])
	by mail-app4 (Coremail) with SMTP id zi_KCgD3r4ZM3NBojL4EAg--.64758S2;
	Mon, 22 Sep 2025 13:19:11 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	YehezkelShB@gmail.com,
	westeri@kernel.org,
	michael.jamet@intel.com,
	andreas.noever@gmail.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] thunderbolt: Fix use-after-free in tb_dp_dprx_work
Date: Mon, 22 Sep 2025 13:18:59 +0800
Message-Id: <20250922051859.16095-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgD3r4ZM3NBojL4EAg--.64758S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQQAWjPA3sJtAA0sA
X-CM-DELIVERINFO: =?B?G7l//AXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR1yV5ixbmzrSF5xUw9Ym+rCxDSQJy/c2fDMmS0l/agfY5Z3Xq3tTgbHUvoqwYtvjxAcr2
	P+DlzJ/7OC4qow1mgaWfEhYM8QRk76Hg6MgPYq9ZoYypeS1GrpR2WHq9h/vUzg==
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4DAw1DXr4kXF13uF4kAFc_yoW5Gw4UpF
	W5G3yUtay5tan0yrsFqa1DuFnxur9Yy3W5Gr4kKa1rAw1Yqw43ta1rGFyFvF45ArW8JF13
	Ar4Utr47ZF4qkrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxU7xwIDUUUU

The original code relies on cancel_delayed_work() in tb_dp_dprx_stop(),
which does not ensure that the delayed work item tunnel->dprx_work has
fully completed if it was already running. This leads to use-after-free
scenarios where tb_tunnel is deallocated by tb_tunnel_put(), while
tunnel->dprx_work remains active and attempts to dereference tb_tunnel
in tb_dp_dprx_work().

A typical race condition is illustrated below:

CPU 0                            | CPU 1
tb_dp_tunnel_active()            |
  tb_deactivate_and_free_tunnel()| tb_dp_dprx_start()
    tb_tunnel_deactivate()       |   queue_delayed_work()
      tb_dp_activate()           |
        tb_dp_dprx_stop()        | tb_dp_dprx_work() //delayed worker
          cancel_delayed_work()  |
    tb_tunnel_put(tunnel);       |
                                 |   tunnel = container_of(...); //UAF
                                 |   tunnel-> //UAF

Replacing cancel_delayed_work() with cancel_delayed_work_sync() is
not feasible as it would introduce a deadlock: both tb_dp_dprx_work()
and the cleanup path acquire tb->lock, and cancel_delayed_work_sync()
would wait indefinitely for the work item that cannot proceed.

Instead, implement proper reference counting:
- If cancel_delayed_work() returns true (work is pending), we release
  the reference in the stop function.
- If it returns false (work is executing or already completed), the
  reference is released in delayed work function itself.

This ensures the tb_tunnel remains valid during work item execution
while preventing memory leaks.

This bug was found by static analysis.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/thunderbolt/tunnel.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index d52efe3f658c..89fa0c626d3e 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1073,6 +1073,7 @@ static void tb_dp_dprx_work(struct work_struct *work)
 
 	if (tunnel->callback)
 		tunnel->callback(tunnel, tunnel->callback_data);
+	tb_tunnel_put(tunnel);
 }
 
 static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
@@ -1097,11 +1098,14 @@ static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
 
 static void tb_dp_dprx_stop(struct tb_tunnel *tunnel)
 {
+	bool ret;
+
 	if (tunnel->dprx_started) {
 		tunnel->dprx_started = false;
 		tunnel->dprx_canceled = true;
-		cancel_delayed_work(&tunnel->dprx_work);
-		tb_tunnel_put(tunnel);
+		ret = cancel_delayed_work(&tunnel->dprx_work);
+		if (ret)
+			tb_tunnel_put(tunnel);
 	}
 }
 
-- 
2.34.1


