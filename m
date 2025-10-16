Return-Path: <linux-kernel+bounces-856601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2CBE494D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F106E4FA4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46630FC0C;
	Thu, 16 Oct 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUrEno1f"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057C32D0E8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632101; cv=none; b=HXPCPOD4ljMwFhb5dZ74XMWtQuwsbv3mNi1tLsZEoAp7wYp4Z/iUQMBFoub3Gn+ZKvxP+hP0aeoj6/y0okaYIbKiZqnx1OIpSAb15b7mZcc8lJM+SGd2rYdOABHl+HV0gshiMlQtG0iUF59Iw0gMOZXvs8yM3HJN/xkQysXX+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632101; c=relaxed/simple;
	bh=meGSvo83bG/NgH1eFgQhP6mPo1S2SQAlpXZ3KoB0rBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ODg+WzKY8SWAIjD2YCvlI58d/OaMbxgzzu+meNRjQ1I+cQ+sIDKKN1GGr5DU/5hxmUYTV0FKGSP6zbPm2z7JGLQZdwI13gAPUno1va8Fb003P1McFARDnhye4eItwd4yfk+RJJ4caPWdUlVmZms8Cq3gtHFBMhZflX9LdBGVPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUrEno1f; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c1413dbeeso993744a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760632098; x=1761236898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdboLAzTskrjae4eiT/OIfkDxQ2xcmShr3Pp4Denv80=;
        b=lUrEno1f9wFV+zq31arrFHExmxhxhjDVMjwPhJV9YDHuJeuw09ySXnlhLc+pgFZsb7
         I6tK5rApH4BiuhNlFmUtWF4vU2FhVH/TqUbcOi0+aqxBKynOXcdFXttfAL9vE68YXrOH
         YbLbDkz6p2+TJk9xsTThtmDL9Hf6SvbY31TNqveBJhtLVkT2kWO2mSkW0S0NGttcx7TT
         d6MdGD96yovQ411IjBmVAAeWaW1NI1FyEZ8ZxC7DVPTLhHigPGo/3Uhss5Mv5wbH4PAK
         OyUp/JtsrIhvORbBHh4FDJ9P4CtGdod2MWuekYX2ymZGz0raWOiGwwnPPiU7QVDL04bq
         0Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632098; x=1761236898;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdboLAzTskrjae4eiT/OIfkDxQ2xcmShr3Pp4Denv80=;
        b=iKl14PFbedBOWtaATkcEQQrkB/oJgW3f8dGA9wvT90irejYqLqIRG5EK4m8om0Z4Y+
         9gVtZhi1FwwPOWF4Huiu+EamRkXGU0NBMZzKA0yat2jxlPAkNxmTKqxTO1w/CeiNuRCk
         BHjoyBy8EP4pEHkn/A88S60A0NQeJMt2adWJRy+IHnUhQ9lg1LCKhzP3w7ZRxuvpCpGH
         Bvn40rkv7VqbTlYM7iePadhEEjte1f8R/BY+f4WCiLjrHr2KhbjvBr/UZ5VAg+8txfAy
         wLM7iRkhEceX0own8J8EKxSJnH+DTl6+reHbiJkWnHncDjMR4O3jlrYOXGNI6Woi1SzG
         TUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrefs/kC0XM3qd7TDQlyszwhAGKLA5koQxjQ48ww1K+hPpu24o6i5wygDDqjtt/Zd9yRstWRn8tYvV0Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3abcf7ukPlI9JwkYt8T2JyBkJjPi4nRaBEkpPFqI3QKNYUVR3
	Srw0N9d9sG+CBgjKOQfLmwIWaPnx/W8qCtuei/lQxDUSdTGr14YPUWSs
X-Gm-Gg: ASbGncssDnewJILu4nuDdztxsh1tYqKyn5xLFnV989RdM1mjplYudfe+UauZOKppGb7
	TMTYsz+ljmwv5KoOPpjI1gw526wih3ZQHPQssltuTyDSYCzlVAicxJ8BTjBLCrsW4mmKJ2PuqKr
	aUzfHCh/P0pbSiu0yTvXT81u7WjSvlZaLRiXLg7sAqv3GZTQxgB2HENW3y07BL4R+8KareoVt3I
	mlQbZEf9aN4yntVG+p2m42HQycRI8dSUZcRuR2jDtvJUS9uOALl5AF/LxjckYcsTG0+h7npbwZs
	V55KPKBhGNxBHcq5GfJlvEl+C/QELrrpOytcs1OKzz28MsYIcuXaYmrCesMDzCbM9CPneFEV5O0
	BHVZx+iBj7Np/vkiRsB0FS/KsIt0v0OJh9IGTV9PPRd4NiNhS2Uanda9ANZpEQlFmy1lmwoSJJB
	QvXkz50XWe+5PB76bUhZ5bFSuV6XE=
X-Google-Smtp-Source: AGHT+IFkesBBmGrxbOhWiH0VCGaQxymq8uVdnn+1XAd1sMn+v+QIXeaDW2R29/rjoB8bmqXuf9pC7w==
X-Received: by 2002:a05:6402:5c8:b0:63c:1170:656a with SMTP id 4fb4d7f45d1cf-63c1f6d6428mr444251a12.37.1760632097713;
        Thu, 16 Oct 2025 09:28:17 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f860sm16416411a12.15.2025.10.16.09.28.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Oct 2025 09:28:17 -0700 (PDT)
Date: Thu, 16 Oct 2025 18:28:13 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: xhci: Fix a format bug
Message-ID: <20251016182813.3d10a8a3.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The width of 'addr' depends on kernel configuration and gibberish is
printed in traces and dynamic debug on some 32 bit systems like ARM:

  Removing canceled TD starting at 0xf9c96eb0 (dma) in stream 0 URB 54e247b5
  Set TR Deq ptr 0x205400000000000, cycle 0

  Successful Set TR Deq Ptr cmd, deq = @f9c96ef0

Fix it by casting to 64 bits. No effect on unaffected systems.
Remove the newline which casuses an empty line to appear next.

Fixes: d1dbfb942c33 ("xhci: introduce a new move_dequeue_past_td() function to replace old code.")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index c7f658d446cd..6d799a5a062d 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -776,7 +776,7 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 	ep->queued_deq_ptr = new_deq;
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
-		       "Set TR Deq ptr 0x%llx, cycle %u\n", addr, new_cycle);
+		       "Set TR Deq ptr 0x%llx, cycle %u", (u64) addr, new_cycle);
 
 	/* Stop the TD queueing code from ringing the doorbell until
 	 * this command completes.  The HC won't set the dequeue pointer
-- 
2.48.1

