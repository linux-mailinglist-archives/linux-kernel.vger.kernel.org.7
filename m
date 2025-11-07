Return-Path: <linux-kernel+bounces-890637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89FFC40833
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45181A408E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D28632779A;
	Fri,  7 Nov 2025 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="V4y/l3GR"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA62D97A1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527857; cv=none; b=Ghq498QNm5O4n8FFID1il+l/JMX+bGz24c2LwdnNBpSf0T+JwHEZuuTwyHpXdVW2YZPMuDnAquECbExoCQ0gXywLLkH37S/H6qIoE46mZhY0be6AwTH/ajJiqp6LHKal3VGzWVULIiLlXlBUa3J6/ozWHoWMBg4f5XJ1UtjYGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527857; c=relaxed/simple;
	bh=oSBv0A71CU85/YPsMg4XLU+W0wcrWdsr9t6iVZ2w9cw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ESGwR4udOn5DfVJl3NWHbtHciqQpXqWGYf5KzAIUfzkJLhTYIz2DKVCcm9TZ3v2kJBmD48ytrEqr/ZPjZdA2vt4ghEtuzxojT7ttiClFssK29ROmzvj5uC5cTayaTW/TxruRnOl8i1yHlClV27VvE/0VYglEngF06Dp6c7YGkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=V4y/l3GR; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
DKIM-Signature: a=rsa-sha256; b=V4y/l3GRUld2BHT2f4Yw4ZugWu/+XCTD8oZKJTDrj+Ut1yi3E9v0Fft9xurY/ffxSNaL4VKqcVNCei966CKY40RZucEXaLYqD6MQfUVP0W0Lr/VI/vQZLbSBPJORBTbuSx+8lqQ1N6CJTEvyt2NKLNp0CtdOpFPvcx9Qs67qup+qb3ec7fOKonoIishmjYH3tq/lAhMhBqnnfUEFIimUUxPuYQX4hkv3yHjRY7Z9Wo5H1434Isnx9XdYAeHxpb1bDJwsqGjtdFjqze9fSlvt9BYDN3EUye3VaSFWKQWClqr556xvX/8t1KbbIea4Thsl9CR8GSG3SmSjOfmK/yt1jg==; s=purelymail2; d=purelymail.com; v=1; bh=oSBv0A71CU85/YPsMg4XLU+W0wcrWdsr9t6iVZ2w9cw=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1430717498;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 07 Nov 2025 15:03:38 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1vHO00-008jXJ-2N;
	Fri, 07 Nov 2025 16:03:36 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: javier.carrasco@wolfvision.net,  heikki.krogerus@linux.intel.com,
  neal@gompa.dev,  linux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tipd: drop double register read in
 tps6598x_interrupt
References: <20251106164850.1703648-1-peter@korsgaard.com>
	<2025110750-diminish-film-f952@gregkh>
Date: Fri, 07 Nov 2025 16:03:36 +0100
In-Reply-To: <2025110750-diminish-film-f952@gregkh> (Greg KH's message of
	"Fri, 7 Nov 2025 17:36:10 +0900")
Message-ID: <87bjld51h3.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

>>>>> "Greg" == Greg KH <gregkh@linuxfoundation.org> writes:

 > On Thu, Nov 06, 2025 at 05:48:49PM +0100, Peter Korsgaard wrote:
 >> Commit 409c1cfb5a80 ("usb: typec: tipd: fix event checking for tps6598x")
 >> added (by accident?) a double read of the TPS_REG_INT_EVENT1 register.  Drop
 >> that.

 > Are you sure?  Sometimes 2 reads are required.  How was this tested?

Hard to be 100% sure, but the code did not have a double read before the
above commit and sticking a printk in the driver like this:

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 01db27cbf1d1..6687d192dbd4 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -536,8 +536,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
                intev_len = TPS_65987_8_INTEVENT_LEN;

        ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
-
+       printk(KERN_ERR "1st: %llx %llx\n", event1[0], event1[1]);
        ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
+       printk(KERN_ERR "2nd: %llx %llx\n", event1[0], event1[1]);
        if (ret) {
                dev_err(tps->dev, "%s: failed to read event1\n", __func__);
                goto err_unlock;


and (un)plugging the USB cable I see:

[ 3267.257341] 1st: 3000008 0
[ 3267.262097] 2nd: 3000008 0

[ 3267.345179] 1st: 1000000 0
[ 3267.350512] 2nd: 1000000 0

[ 3267.388947] 1st: 1000000 0
[ 3267.393707] 2nd: 1000000 0

[ 3267.912112] 1st: 1000000 0
[ 3267.916872] 2nd: 1000000 0

[ 3268.049505] 1st: 1000000 0
[ 3268.054773] 2nd: 1000000 0

[ 3269.105173] 1st: 1000000 0
[ 3269.109970] 2nd: 1000000 0

[ 3280.049111] 1st: 3000008 0
[ 3280.053865] 2nd: 3000008 0

So I am fairly sure it is not needed.

-- 
Bye, Peter Korsgaard

