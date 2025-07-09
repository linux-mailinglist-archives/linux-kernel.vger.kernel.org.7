Return-Path: <linux-kernel+bounces-723859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DB8AFEBC9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D4F5616B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ECB2E265B;
	Wed,  9 Jul 2025 14:15:35 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312532C3257
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070535; cv=none; b=ceE9CxT9Yh26n5o/Zfk4lt4i1evA+ypHg0oj3Sa/J2dNcvojF5ylRFIMpgwoHyEgKxhP/8WgAH12rkJff0MPL19ck1Fxl0My2hoKFR79DcU411/DxLMp5CVA3wON8CjV0cnW4s6VNnjG5fdMSSJKf74j/X3D0nxbyKiEaF1pllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070535; c=relaxed/simple;
	bh=EpAySwiECLuhBUrrnIo0jwbAsRc3ZT+2vDGvV384yRU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bAm3+mk4XR5IaIzYhixyoZ/qq92SFP04SJGouJy6rqGtRE1uCe+myONxftn0RrXGnDnqfp9m8dxbIy4DzU8xhAhTJkz/qP+40UkgwnASh8JX1xcT7yDZgxChwBmaYEvJFxCiOLnBuSiuTLB/mRhGxJ+f+UMFjfZnS/fpi2Tu6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 569EFTtQ063969;
	Wed, 9 Jul 2025 23:15:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 569EFTdR063965
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 9 Jul 2025 23:15:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <924bf5c7-9466-49dc-ad26-53939ca49825@I-love.SAKURA.ne.jp>
Date: Wed, 9 Jul 2025 23:15:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [usb?] INFO: task hung in uevent_show (2)
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>
References: <672f73a6.050a0220.138bd5.0041.GAE@google.com>
 <c2b2b02d-2571-451c-bb1c-7dde18b45d4f@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <c2b2b02d-2571-451c-bb1c-7dde18b45d4f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Virus-Status: clean

#syz test

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index f5221b018808..10124a26ffde 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1765,7 +1765,7 @@ static void usb_rx_callback_intf0(struct urb *urb)
 		break;
 
 	default:
-		dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
+		dev_warn_ratelimited(ictx->dev, "imon %s: status(%d): ignored\n",
 			 __func__, urb->status);
 		break;
 	}
@@ -1806,7 +1806,7 @@ static void usb_rx_callback_intf1(struct urb *urb)
 		break;
 
 	default:
-		dev_warn(ictx->dev, "imon %s: status(%d): ignored\n",
+		dev_warn_ratelimited(ictx->dev, "imon %s: status(%d): ignored\n",
 			 __func__, urb->status);
 		break;
 	}


