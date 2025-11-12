Return-Path: <linux-kernel+bounces-896492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81ECC5086F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00F118965DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07522E336E;
	Wed, 12 Nov 2025 04:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnwK0ba/"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A72D8763
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921719; cv=none; b=YSuvmNSsNjldSPfyxYNTTnAI/MGrlnRA2rQtiIrKsdJF1NhdJby+FnxdM3sFfTDWcAktY0sBrdT6Gt60zWIfJ22YwmbS6+TpI5IljxPpqDO6itWuAfqQOd9KlJgEm7LHfFBX5G1aqnKajPPq0+Tv+XiqI007MZQ5xLuhhSUWURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921719; c=relaxed/simple;
	bh=WzzlpcIVvJDG08mn5WxWf9o+FOGQQrSDl+xHVjEaO58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5iyaPg33024x9zasWeWxV+87ZfCWLMn074gA+DVQa8I8iXo85PRLyZ7LqrjUcazl9DhGDH0v8uA6jPHYUKZL1htTLOAivAqcLnWx7Cf+jKFj0pIgMzYKHU2BeJmF8daw5LRBNVAbzK9On9cDjH6tR7zcuBDnpu/Yy13/mnV37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnwK0ba/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3436a97f092so502171a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921717; x=1763526517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M80qUNZc1XHsNmFVJZkZr4sttr+ksd9CwMk6Xp4mOs8=;
        b=UnwK0ba/VuAiUssExLelCzLrUMui+9N3HcqmvUdEflLvmXcEuREhJ2XysvsyNSXi79
         1eAlmtNOjOoBEOXLnVelxJPZKKzCjVMJpxTZjU/R5iYAK9EPPCvXF/6W3GBS2CH5uFfu
         xAl2gnpiEBl014IX21UmahMMGcb30jz03AWdBI60HZdYTZVoIZrX5GxqV8aHlQdUPIug
         PxJLOj83Jh0yLwz+GW8Vdg/y3uYCt7ZYdvn3QI0SM1+0uFw7RoSJivajxesbXT00JZPD
         FMhd7lS7KMIc7wtADd8O22qwRYIPMfy0MtwUoae5/d6Jcu/WcHW7OI5boUTT9TqjCj3v
         c6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921717; x=1763526517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M80qUNZc1XHsNmFVJZkZr4sttr+ksd9CwMk6Xp4mOs8=;
        b=gVMLIuA0+hUOwPTOKWexxda3tupvDDzXtJa7YRNc8ZRoaAYkXGcp1U0lqcZJM7fksG
         y7EVRDsoYNG/3Q8IswrzyLRV30jCMFbZVRbRauR8ZNYjW3lFrK5Bhcar5KIU9oGzeGmH
         erjM6px/uaJRwMiAJ3tqMf6FmKDgEb+8KLADlP9jxJJhKuj4vVKGMjdP7e3fE70eNmNk
         2PzAa4xTCk9AWoFMsX7ZC7Mw4k1+Z8qMpccV7HjvIBMVQKdeFLlZHXWU/kNQ4Gvh7d/N
         pqzYN4kX7MJwSB8BtE7RhoE3l4iRcltQFBmAAaRJDlTv9ELhStdND/pqNfeudVZRczMl
         a10w==
X-Forwarded-Encrypted: i=1; AJvYcCVeRAKbHoyvOofkIQHKsZln49NUI7/CcROzCP+MTIepar/iSnwgSegsP8A1Y1kfg5PLsgJ/ztnzbAorsPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jclhen6oMdTa9xRn+sVTnaT0a61F6LLNsEBBPaoOfwWA+v6Y
	xKfeYN0bHQWKc4o1hvvJ0Ff3dWP2xJn2a+pEYmwiWN1gjt2XR60pNiUG
X-Gm-Gg: ASbGncveVdIkupGMwupiJrIMQFlAPtShL4GoTosCk7Fn73Ru8tAnDWRglivIgHSJs+j
	lbTrwEU01eIWllT9pBPswpeasR5X+6mPXHtkDswVBBNGbq3TUN7OHM7IZNN0KzQfxHErmCpR56A
	5uDy71zqZ1ZFCbbBNdKf7Qg5kjuh+ee1YhoUTNEsmck8bRZs/ti3A6cserwQo9Xi4ikv57JZ88R
	OPDMNJguDBz1f2s9bJtb5uIq8X9+fjcUUUuAxUKOYVFcjDV4VdzAr9DlWyKc7HyfY5KQnjWrXCO
	7Grtayljo4AHyaqdorILMyzgEXsS3/HxCZlvHB4BSDsdUHsj83YKBKVt5UwQmhuvN59x3WY7QBT
	RGhnLMF/nrqF87qopbggWEevgXx2+XEr/A0MuHy8jd2ZU5mlPYJQgsmTHioaIO0APzw/IIDEr+q
	AqV0+3B+aUGcqhrLBsBBsvVrftg+Zs0HlTSEdCkhoXt6Qs9gMfI28rxQS9I27Cq8yczyA3ntza8
	1Myh8RYvRN8PSmFigZV
X-Google-Smtp-Source: AGHT+IH+yGIMkP+5jLWuv7dmVXtMrTOjJ9if6zSq3lOjXH0ncDd2BGvxBgxvOWF7qaIpKkGatI+aRA==
X-Received: by 2002:a17:90b:4c44:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-343dde0d055mr2061728a91.8.1762921716677;
        Tue, 11 Nov 2025 20:28:36 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:36 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
Date: Wed, 12 Nov 2025 14:27:19 +1000
Message-ID: <20251112042720.3695972-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112042720.3695972-1-alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
on an KeyUpdate event as described in RFC8446
https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.

If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe target sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v5:
 - Cleanup code flow
 - Check for MSG_CTRUNC in the msg_flags return from recvmsg
   and use that to determine if it's a control message
v4:
 - Remove all support for initiating KeyUpdate
 - Don't call cancel_work() when updating keys
v3:
 - Don't cancel existing handshake requests
v2:
 - Don't change the state
 - Use a helper function for KeyUpdates
 - Continue sending in nvme_tcp_send_all() after a KeyUpdate
 - Remove command message using recvmsg

 drivers/nvme/host/tcp.c | 85 +++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4797a4532b0d..5cec5a974bbf 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -172,6 +172,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		handshake_session_id;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -858,7 +859,10 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
 static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 {
 	char *pdu = queue->pdu;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
 		.msg_flags = MSG_DONTWAIT,
 	};
 	struct kvec iov = {
@@ -873,12 +877,17 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 	if (ret <= 0)
 		return ret;
 
+	hdr = queue->pdu;
+	if (hdr->type == TLS_HANDSHAKE_KEYUPDATE) {
+		dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
+		return 1;
+	}
+
 	queue->pdu_remaining -= ret;
 	queue->pdu_offset += ret;
 	if (queue->pdu_remaining)
 		return 0;
 
-	hdr = queue->pdu;
 	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
 		if (!nvme_tcp_recv_pdu_supported(hdr->type))
 			goto unsupported_pdu;
@@ -944,6 +953,7 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 	struct request *rq =
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 
 	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
 		return 0;
@@ -976,10 +986,26 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 
 		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
 		if (ret < 0) {
-			dev_err(queue->ctrl->ctrl.device,
-				"queue %d failed to receive request %#x data",
-				nvme_tcp_queue_id(queue), rq->tag);
-			return ret;
+			/* If MSG_CTRUNC is set, it's a control message,
+			 * so let's read the control message.
+			 */
+			if (msg.msg_flags & MSG_CTRUNC) {
+				memset(&msg, 0, sizeof(msg));
+				msg.msg_flags = MSG_DONTWAIT;
+				msg.msg_control = cbuf;
+				msg.msg_controllen = sizeof(cbuf);
+
+				ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
+			}
+
+			if (ret < 0) {
+				dev_dbg(queue->ctrl->ctrl.device,
+					"queue %d failed to receive request %#x data, %d",
+					nvme_tcp_queue_id(queue), rq->tag, ret);
+				return ret;
+			}
+
+			return 0;
 		}
 		if (queue->data_digest)
 			nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
@@ -1384,15 +1410,39 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
 		}
 	} while (result >= 0);
 
-	if (result < 0 && result != -EAGAIN) {
-		dev_err(queue->ctrl->ctrl.device,
-			"receive failed:  %d\n", result);
-		queue->rd_enabled = false;
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-	} else if (result == -EAGAIN)
-		result = 0;
+	if (result < 0) {
+		if (result != -EKEYEXPIRED && result != -EAGAIN) {
+			dev_err(queue->ctrl->ctrl.device,
+				"receive failed:  %d\n", result);
+			queue->rd_enabled = false;
+			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		}
+		return result;
+	}
+
+	queue->nr_cqe = nr_cqe;
+	return nr_cqe;
+}
+
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
 
-	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
+	flush_work(&(queue->ctrl->ctrl).async_event_work);
+
+	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+				 queue, queue->ctrl->ctrl.tls_pskid,
+				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"failed to update the keys %d\n", ret);
+		nvme_tcp_fail_request(queue->request);
+	}
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
@@ -1417,8 +1467,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		result = nvme_tcp_try_recvmsg(queue);
 		if (result > 0)
 			pending = true;
-		else if (unlikely(result < 0))
-			return;
+		else if (unlikely(result < 0)) {
+			if (result == -EKEYEXPIRED)
+				update_tls_keys(queue);
+			break;
+		}
 
 		/* did we get some space after spending time in recv? */
 		if (nvme_tcp_queue_has_pending(queue) &&
@@ -1726,6 +1779,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->handshake_session_id = handshake_session_id;
 	}
 
 out_complete:
@@ -1755,6 +1809,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.handshake_session_id = queue->handshake_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
-- 
2.51.1


