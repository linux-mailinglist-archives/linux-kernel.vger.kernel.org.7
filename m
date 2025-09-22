Return-Path: <linux-kernel+bounces-827970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D7B938D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024FF2A7E13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9F2797B1;
	Mon, 22 Sep 2025 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="pOVnhSG7"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494BC1459FA;
	Mon, 22 Sep 2025 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583060; cv=none; b=Lua2bWyaccJRacis5trsQHLBd2BeMu1CFbYGlUQpCyggIuRkGKCWFHCNaeTjczuDE4nVGOfh5A4D6PDu4OkAupef3R25qB+cbEMTJar21Nx4ZKjqeOta9AXdoivz60sy+8FhcDIVCXSn2Mh0nEUz1ea8ND2Kv61uwDZ1wANHRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583060; c=relaxed/simple;
	bh=3Y3ZDE1TqesA7tSB3ZJaGNiNXJe6Vu1t6mGoV99mq3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhpWcw0qncDVdo7hFgcGtUZf68TeFjg0GSyXQB7BoYqU7nOxU7iVqx1uIucqkR5e1f0OSUHoSpij7dCmVe3BjYWWnoCfu0TagwLMbaCpnYZT9abgtGM9GR0eNDXJLkkdK+K9aSLoRJTIaDmnIQrAKdBjVCU6/Ztut5EwtAafD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=pOVnhSG7; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cVzXr0jZMz9sTb;
	Tue, 23 Sep 2025 01:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1758583052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHo7lTctN2q34mxLZ8N4ckYAueSG3T7NFnjOFWFRhgc=;
	b=pOVnhSG7IRoX7PzUDbk3kIKub8Np/jLnS9OUIBSN4aDEJIxZKIo0BwpOdbbvhQIFGUDn1Y
	hVf8UXy2OFyAb2772/EMSM6cImu1iB1JB2FD/DTagGBAnMVpnPDO+siMiLc+dKNCGTZczw
	aoXGSplQKAAIocPqCIWDK2R5tmoA8Ca2U69R9+ddgyaeKil2BIQx4SJWgX1eWQvlo5gemU
	BOSZB8LAizhh7Gw5tGXcZVL4SmeKX8QBMmcMLVBFRymdDu0kOWiKgdyYpnOjK7Ye835r+y
	b8EXFeDn1CA3lHtBwJCwaMJgYxmrJ0ayswmNOBNx6d6Qz9l/j/hF2z7dv6vMUA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
Cc: clemens@ladisch.de,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: [PATCH 1/1] ALSA: usb-audio: Avoid NULL dereference in snd_usbmidi_do_output()
Date: Tue, 23 Sep 2025 04:47:20 +0530
Message-ID: <20250922231720.3603805-1-listout@listout.xyz>
In-Reply-To: <68d17f44.050a0220.13cd81.05b7.GAE@google.com>
References: <68d17f44.050a0220.13cd81.05b7.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cVzXr0jZMz9sTb

Syzkaller reported a general protection fault in snd_usbmidi_do_output(),
caused by dereferencing a NULL URB pointer when accessing
ep->urbs[urb_index].urb.

This can happen in rare race conditions where the URB was not initialized
or was already freed (e.g. during disconnect or after errors), and the
output timer or other path tries to reuse it.

Fix this by checking if the URB is NULL before accessing it, and skipping
the current slot if it is.

Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 sound/usb/midi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index acb3bf92857c..7919a39decb4 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -307,6 +307,10 @@ static void snd_usbmidi_do_output(struct snd_usb_midi_out_endpoint *ep)
 	for (;;) {
 		if (!(ep->active_urbs & (1 << urb_index))) {
 			urb = ep->urbs[urb_index].urb;
+			if (!urb) {
+				// Skip this urb
+				goto next_urb;
+			}
 			urb->transfer_buffer_length = 0;
 			ep->umidi->usb_protocol_ops->output(ep, urb);
 			if (urb->transfer_buffer_length == 0)
@@ -319,6 +323,7 @@ static void snd_usbmidi_do_output(struct snd_usb_midi_out_endpoint *ep)
 				break;
 			ep->active_urbs |= 1 << urb_index;
 		}
+next_urb:
 		if (++urb_index >= OUTPUT_URBS)
 			urb_index = 0;
 		if (urb_index == ep->next_urb)
-- 
2.51.0


