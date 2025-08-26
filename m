Return-Path: <linux-kernel+bounces-786462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A222B35A24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EBA2A5C68
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44C2BDC33;
	Tue, 26 Aug 2025 10:35:11 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AD4233D85
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204511; cv=none; b=G/UlI8ieuU8uZzYPHrC9qtu8JlPSj4ZzTP/eVbnPoeDzgytRKbkg3LC+02CDO13Do2o0ElCnFeeE8qf+khbQJ7gAxyUf29cx+f6mL/KvQBhkWlsSlk18Ey0vF0jDQ9LfKDGyPsyWPYMOjUzNMpKMrKbgKnaVLp8IOXsWdex2a00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204511; c=relaxed/simple;
	bh=NCQeJrKLI5olyCDn+n2YwIhuKN/9qE1k8ByZXi6zlXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B+QVeQGNa31G1nj1cVlnc+KnxbN0v25zcy0s3HE9QQNMjOFnhjh584DAE9gnmPmvpfleJiSDdqbIAWx4s7HMAfovhrFeP91FXMTBpR7FGd/7B35As3ZgiS1gBofDa+B1FPCx9wdw9LQ9kG8Fc9BJLNPJepsrdjuwk1mok4ddVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowAD3iHrNja1oSQhZDw--.465S2;
	Tue, 26 Aug 2025 18:34:54 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Tue, 26 Aug 2025 18:34:40 +0800
Subject: [PATCH v2] uio: uio_pdrv_genirq: Remove MODULE_DEVICE_TABLE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-uio-no-modalias-v2-1-495afa9e8a5b@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAL+NrWgC/3WOTQ6CMBCFr0Jm7ZC2VARW3sOwKKXIJNJqC42Gc
 HcrrF1+L+9vhWA8mQBNtoI3kQI5m0CcMtCjsneD1CcGwcSZVULiQg6tw8n16kEqYFd3UhasYJW
 uIKWe3gz03htv7cHevJZUPB8idCoY1G6aaG6yWOb8gl5z+JlHCrPzn/1N5Lv773DkyFGZoaxl0
 TOp9JWCViFXOtcW2m3bvvNK6cvdAAAA
X-Change-ID: 20250824-uio-no-modalias-b9b4430308c8
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <monstr@monstr.eu>, Wolfram Sang <wsa@kernel.org>, 
 "Hans J. Koch" <hjk@hansjkoch.de>, Pavel Machek <pavel@ucw.cz>
Cc: Vivian Wang <uwu@dram.page>, linux-kernel@vger.kernel.org, 
 Emily <hello@emily.moe>, Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID:rQCowAD3iHrNja1oSQhZDw--.465S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4DZF47Cr47uw1xtr15XFb_yoW8CF47pF
	48JFW3tr4jgFy8WF4kA3yfXFy09wnFyFWv9FW2gw12k39xAr10krWfKrnFg3s8Xr4rXa15
	AFykXw1kuFykZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUU
	UU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

The struct of_device_id list here is filled in at load time since
commit 05c3e0bb5629 ("UIO: allow binding uio_pdrv_genirq.c to devices using
command line option").

However, this does not work with MODULE_DEVICE_TABLE, which generates an
alias at build time.  In this case, it generates the aliases "of:N*T*"
and "of:N*T*C*", which matches *any* OF device node, which is obviously
not intended. It confuses userspace into loading this module for any OF
device, and confuses anyone trying to resolve an OF modalias.

Remove this broken MODULE_DEVICE_TABLE.

Suggested-by: Emily <hello@emily.moe>
Fixes: 05c3e0bb5629 ("UIO: allow binding uio_pdrv_genirq.c to devices using command line option")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Changes in v2:
- Point "Fixes:" to newer commit that added the placeholder entry
- Reworded commit message
- Link to v1: https://lore.kernel.org/r/20250824-uio-no-modalias-v1-1-aef6943d04ac@iscas.ac.cn
---
 drivers/uio/uio_pdrv_genirq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index 2ec7d25e826490999404382e6aa69e4af56f7fe8..633ab6b916719e783d0f82cb2f8decac35a37054 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -276,7 +276,6 @@ static struct of_device_id uio_of_genirq_match[] = {
 	{ /* This is filled with module_parm */ },
 	{ /* Sentinel */ },
 };
-MODULE_DEVICE_TABLE(of, uio_of_genirq_match);
 module_param_string(of_id, uio_of_genirq_match[0].compatible, 128, 0);
 MODULE_PARM_DESC(of_id, "Openfirmware id of the device to be handled by uio");
 #endif

---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250824-uio-no-modalias-b9b4430308c8

Best regards,
-- 
Vivian "dramforever" Wang


