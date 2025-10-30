Return-Path: <linux-kernel+bounces-878516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A62C20DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3AE534E0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EA732E6AB;
	Thu, 30 Oct 2025 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AW2PYHRm"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544362222B2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837283; cv=none; b=oNwD9vtK3A9CzgIDMA/JzR+a88m8nu0kjprn2flz7IwDDTAePGbC6As2upKLvoNBC8HIfWGpgS6FaIcgsem7ovzzyw6v0pQkjb6cZW6kPcWP8m7wQAXIBUJnFe0Hkq7ITh7C9aP98F8R29C3w07iEJV7tQQgN+dLY53+qc2itoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837283; c=relaxed/simple;
	bh=q59XP1HDZ7mD5Vmiv8zo+s7Q4fPF5v6QJu61zUHa8Jg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=niEMIpAWh7jsNzwtFFUVUsSHaFuUh+Hqg1I1EPFVYaX3HelMkqPCEAo2wnKaq11BiYVj3FBQ43R3MW5E0R5QQjWY6LeRbTe99zheRfXFiFVLDdL1ck/ZuA+OCxjEvXGp5pou7t88GcwK604BsDMhDY92gcU6Um71+fXRTkK3bmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AW2PYHRm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290b13c5877so23356215ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761837281; x=1762442081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tOKsrqWz9v3pH3CqifzxDRCIt1c5IhuvPUyONKMbswY=;
        b=AW2PYHRmHIQRn9gsiphQ1uyQb/TI/1QHZf7cbS3KH8NQlZtGrXMNtz/gwEmL0fM82Q
         vBRWUiJa6WBlBB/mBnB32tGxjm2sAVbr/Usw9w5zrG7kzZlNoWUrFNbEurGYCHuxcfPf
         czqH6OjmjUormKUYeJuPxYzLwNsi8SJYmbIdT8sCHL8UiZ9/s918qzggMI35Mjow9LH6
         NuVnssQU0TpIIiNHXpVvETTUIcSDDD4LEo1092OXmynOrXyo6LqWvpfXDqdhrmlI3vzO
         N+9SPdRQB88TNLZHGsNuske8yGskY+e0xU0O/+mNmI0LE+TG4Hl2B7+8WJilbkK4l1xn
         bQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837281; x=1762442081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOKsrqWz9v3pH3CqifzxDRCIt1c5IhuvPUyONKMbswY=;
        b=tkVbKwUhM+Nn0rn3lTqrdI3ND7+N1C1+Pw3qM0ywRd41H9lKkZRP9k54zLW5B9mWQl
         li0eKe0ELI+VowPqoaf4zI6WdKU56jd3QIRfgf0Wiy8L1ovx9fxZQFpYVjTHsg7hV2Aq
         3+rF9dPfW3Z3d/oKYl2JQ6ObHRTKsKqqcRleSKcF4HnQ28B2Dz7BPaT2nVtwJEGFOq03
         1s4vtHI2CMhYdS01GEE2B8ZdveErazzpYPk1u77V3Cho60Vbv1cEJiHRVM2w2ulf3v7Y
         fqu2+CymHfmvW5SxWBE4AS7U/t8idV2hu/bI7d5yKqJIE1OOJzwSK+KBGO2d+Fg4ungZ
         wK6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYqf4Ss8/iJBB/pvKU1AhnClIMK2quIngiWFAdJf8rJDHqM/0SSQ+lpacJdbgPnhTtqAbj8KAacoNzpjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR6bYHGW9mITjasVn/81ZzHze2Jfqb+HIq8oZLUVAm2K6kBQTq
	Q7AsZfJd1QQfqeHyQMNT2d2HbN+sV2qtztRls3lZ2V2sCaGtG6YBm+nYiu5DEprUjxNtKV/+9kM
	tGhmQGg==
X-Google-Smtp-Source: AGHT+IEKkb/E2RKrkxusDM6cv5FWmALGXDAB7THKuaYzKiPsWfnnW5P2usl6VZaAYaqa1LCy691i9SOKuec=
X-Received: from plbbf4.prod.google.com ([2002:a17:902:b904:b0:269:740f:8ae8])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1666:b0:269:9a7a:9a43
 with SMTP id d9443c01a7336-2951a38dde4mr888805ad.10.1761837281314; Thu, 30
 Oct 2025 08:14:41 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:14:19 +0800
In-Reply-To: <20251030-auto-cleanup-v1-0-db30584fadfd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030-auto-cleanup-v1-0-db30584fadfd@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761837277; l=6655;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=q59XP1HDZ7mD5Vmiv8zo+s7Q4fPF5v6QJu61zUHa8Jg=; b=Njk3fnvT+Wbu4er1kE+A2IO10zYzzLahZCQzzaEH4owrPu0dfd2NBILAdjCmPYrbAYGiArzoE
 trNJqOzMBcbBkQAUVdW294ZmAboq+ecfqU56iOR8NkdY5Oa4rXJpHQt
X-Mailer: b4 0.14.2
Message-ID: <20251030-auto-cleanup-v1-1-db30584fadfd@google.com>
Subject: [PATCH 1/2] usb: gadget: f_tcm: Use auto-cleanup for usb_request
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="utf-8"

Refactor f_tcm.c to use auto-cleanup mechanism for usb_request
allocations in bot_prepare_reqs(), uasp_alloc_stream_res(), and
uasp_alloc_cmd().

The explicit nullification of fu->..._req and stream->..._req pointers
on error is no longer needed. This is safe because these pointers are
only updated after all allocations within the function have succeeded.
If an error occurs, the fu structure members retain their previous
value, and the existing cleanup functions like bot_cleanup_old_alt() and
uasp_cleanup_old_alt() already handle stale pointers in the fu
structure.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/f_tcm.c | 141 +++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 74 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 6e8804f04baa774f5e6bed548b64769e93f6eb1c..782995040af3acdb42d380b4dbb012941592da06 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/cleanup.h>
 #include <linux/configfs.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
@@ -309,57 +310,54 @@ static int bot_prepare_reqs(struct f_uas *fu)
 {
 	int ret;
 
-	fu->bot_req_in = usb_ep_alloc_request(fu->ep_in, GFP_KERNEL);
-	if (!fu->bot_req_in)
-		goto err;
-
-	fu->bot_req_out = usb_ep_alloc_request(fu->ep_out, GFP_KERNEL);
-	if (!fu->bot_req_out)
-		goto err_out;
+	struct usb_request *bot_req_in __free(free_usb_request) =
+		usb_ep_alloc_request(fu->ep_in, GFP_KERNEL);
+	if (!bot_req_in)
+		return -ENOMEM;
 
-	fu->cmd[0].req = usb_ep_alloc_request(fu->ep_out, GFP_KERNEL);
-	if (!fu->cmd[0].req)
-		goto err_cmd;
+	struct usb_request *bot_req_out __free(free_usb_request) =
+		usb_ep_alloc_request(fu->ep_out, GFP_KERNEL);
+	if (!bot_req_out)
+		return -ENOMEM;
 
-	fu->bot_status.req = usb_ep_alloc_request(fu->ep_in, GFP_KERNEL);
-	if (!fu->bot_status.req)
-		goto err_sts;
+	struct usb_request *cmd_req __free(free_usb_request) =
+		usb_ep_alloc_request(fu->ep_out, GFP_KERNEL);
+	if (!cmd_req)
+		return -ENOMEM;
 
-	fu->bot_status.req->buf = &fu->bot_status.csw;
-	fu->bot_status.req->length = US_BULK_CS_WRAP_LEN;
-	fu->bot_status.req->complete = bot_status_complete;
-	fu->bot_status.csw.Signature = cpu_to_le32(US_BULK_CS_SIGN);
+	struct usb_request *status_req __free(free_usb_request) =
+		usb_ep_alloc_request(fu->ep_in, GFP_KERNEL);
+	if (!status_req)
+		return -ENOMEM;
 
-	fu->cmd[0].buf = kmalloc(fu->ep_out->maxpacket, GFP_KERNEL);
-	if (!fu->cmd[0].buf)
-		goto err_buf;
+	cmd_req->buf = kmalloc(fu->ep_out->maxpacket, GFP_KERNEL);
+	if (!cmd_req->buf)
+		return -ENOMEM;
 
-	fu->cmd[0].req->complete = bot_cmd_complete;
-	fu->cmd[0].req->buf = fu->cmd[0].buf;
-	fu->cmd[0].req->length = fu->ep_out->maxpacket;
-	fu->cmd[0].req->context = fu;
+	cmd_req->complete = bot_cmd_complete;
+	cmd_req->length = fu->ep_out->maxpacket;
+	cmd_req->context = fu;
 
 	ret = bot_enqueue_cmd_cbw(fu);
 	if (ret)
-		goto err_queue;
+		return ret;
+
+	fu->bot_req_in = no_free_ptr(bot_req_in);
+	fu->bot_req_out = no_free_ptr(bot_req_out);
+
+	/* This line is placed here because free_usb_request also frees its
+	 * buffer, which in this case points to the static fu->bot_status.csw.
+	 */
+	status_req->buf = &fu->bot_status.csw;
+	status_req->length = US_BULK_CS_WRAP_LEN;
+	status_req->complete = bot_status_complete;
+	fu->bot_status.csw.Signature = cpu_to_le32(US_BULK_CS_SIGN);
+	fu->bot_status.req = no_free_ptr(status_req);
+
+	fu->cmd[0].buf = cmd_req->buf;
+	fu->cmd[0].req = no_free_ptr(cmd_req);
+
 	return 0;
-err_queue:
-	kfree(fu->cmd[0].buf);
-	fu->cmd[0].buf = NULL;
-err_buf:
-	usb_ep_free_request(fu->ep_in, fu->bot_status.req);
-err_sts:
-	usb_ep_free_request(fu->ep_out, fu->cmd[0].req);
-	fu->cmd[0].req = NULL;
-err_cmd:
-	usb_ep_free_request(fu->ep_out, fu->bot_req_out);
-	fu->bot_req_out = NULL;
-err_out:
-	usb_ep_free_request(fu->ep_in, fu->bot_req_in);
-	fu->bot_req_in = NULL;
-err:
-	pr_err("BOT: endpoint setup failed\n");
-	return -ENOMEM;
 }
 
 static void bot_cleanup_old_alt(struct f_uas *fu)
@@ -878,50 +876,45 @@ static int uasp_alloc_stream_res(struct f_uas *fu, struct uas_stream *stream)
 {
 	init_completion(&stream->cmd_completion);
 
-	stream->req_in = usb_ep_alloc_request(fu->ep_in, GFP_KERNEL);
-	if (!stream->req_in)
-		goto out;
+	struct usb_request *req_in __free(free_usb_request) =
+		usb_ep_alloc_request(fu->ep_in, GFP_KERNEL);
+	if (!req_in)
+		return -ENOMEM;
 
-	stream->req_out = usb_ep_alloc_request(fu->ep_out, GFP_KERNEL);
-	if (!stream->req_out)
-		goto err_out;
+	struct usb_request *req_out __free(free_usb_request) =
+		usb_ep_alloc_request(fu->ep_out, GFP_KERNEL);
+	if (!req_out)
+		return -ENOMEM;
 
-	stream->req_status = usb_ep_alloc_request(fu->ep_status, GFP_KERNEL);
+	struct usb_request *req_status __free(free_usb_request) =
+		usb_ep_alloc_request(fu->ep_status, GFP_KERNEL);
 	if (!stream->req_status)
-		goto err_sts;
+		return -ENOMEM;
 
-	return 0;
+	stream->req_in = no_free_ptr(req_in);
+	stream->req_out = no_free_ptr(req_out);
+	stream->req_status = no_free_ptr(req_status);
 
-err_sts:
-	usb_ep_free_request(fu->ep_out, stream->req_out);
-	stream->req_out = NULL;
-err_out:
-	usb_ep_free_request(fu->ep_in, stream->req_in);
-	stream->req_in = NULL;
-out:
-	return -ENOMEM;
+	return 0;
 }
 
 static int uasp_alloc_cmd(struct f_uas *fu, int i)
 {
-	fu->cmd[i].req = usb_ep_alloc_request(fu->ep_cmd, GFP_KERNEL);
-	if (!fu->cmd[i].req)
-		goto err;
+	struct usb_request *req __free(free_usb_request) =
+		usb_ep_alloc_request(fu->ep_cmd, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
 
-	fu->cmd[i].buf = kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL);
-	if (!fu->cmd[i].buf)
-		goto err_buf;
+	req->buf = kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL);
+	if (!req->buf)
+		return -ENOMEM;
 
-	fu->cmd[i].req->complete = uasp_cmd_complete;
-	fu->cmd[i].req->buf = fu->cmd[i].buf;
-	fu->cmd[i].req->length = fu->ep_cmd->maxpacket;
-	fu->cmd[i].req->context = fu;
+	req->complete = uasp_cmd_complete;
+	req->length = fu->ep_cmd->maxpacket;
+	req->context = fu;
+	fu->cmd[i].buf = req->buf;
+	fu->cmd[i].req = no_free_ptr(req);
 	return 0;
-
-err_buf:
-	usb_ep_free_request(fu->ep_cmd, fu->cmd[i].req);
-err:
-	return -ENOMEM;
 }
 
 static int uasp_prepare_reqs(struct f_uas *fu)

-- 
2.51.1.851.g4ebd6896fd-goog


