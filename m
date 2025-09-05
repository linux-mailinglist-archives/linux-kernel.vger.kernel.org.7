Return-Path: <linux-kernel+bounces-802987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32592B4592F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DC6B62DF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C6353353;
	Fri,  5 Sep 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1u/3mWPG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A+tXZiTT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1u/3mWPG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A+tXZiTT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A3352FF8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079169; cv=none; b=T72XL3uDRFaVqX+Tx8LVaQ/kUT7RqJ6hy3J//+iPcaS0XJPRgFo/Ux9ZtENrY0/H4ZDySUyMsZdM7Oe99Y9XD0IefM5WRD8wLnP2uuLHdyNKpJeLipxiPrEnmgV4Cr3PTm0zYWUHhkP5JaBfiFzcEUcsAi4mV14W1O0rxLVuTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079169; c=relaxed/simple;
	bh=GtEJWrEres7rwBd187ORd43g7mXHoj113YAAzRhrZ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H05rIoG1PeRqG1y5e7rjtBx15G12c7wPDbc9rkXDuoB7/HC32RRFZCpiiIxfIopjY6zMxCUvWWerVdy6F4wf6bCFJArMfXDuS/iXwhQIKQoLPq1A0aRkiAED3e2d0zzC2YT57clMzFVJ2E2MvYzUt/6exYH4SJ16L6jvWGGF7nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1u/3mWPG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A+tXZiTT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1u/3mWPG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A+tXZiTT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6CB355CE;
	Fri,  5 Sep 2025 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757079164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xaEQOXHnj5AQbKgdBzSltCb7gf/7Q/irpuQGgAGye2I=;
	b=1u/3mWPG+EObXouIIIQDBwTgbqLW+Jbg4IgyqK7YeVtGItiE8rw9BPTkRpxA7y2wP9C14+
	0r3mACK4Czq1EcBKWZ9QBVFTY5JfHo8V44hlvHumZLP6JX/yYnZqdcD801wyyVF7q1UIom
	IFyAfz8Fu/i7NUBumj5xuN8jzNM8BMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757079164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xaEQOXHnj5AQbKgdBzSltCb7gf/7Q/irpuQGgAGye2I=;
	b=A+tXZiTT7pSs+iSkahqm7dN83kqEx8kkSowrNmB3mwElQtV6ipgJO0P0rhnFho3cliiHOy
	xM/JCMem0Y4lTkAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757079164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xaEQOXHnj5AQbKgdBzSltCb7gf/7Q/irpuQGgAGye2I=;
	b=1u/3mWPG+EObXouIIIQDBwTgbqLW+Jbg4IgyqK7YeVtGItiE8rw9BPTkRpxA7y2wP9C14+
	0r3mACK4Czq1EcBKWZ9QBVFTY5JfHo8V44hlvHumZLP6JX/yYnZqdcD801wyyVF7q1UIom
	IFyAfz8Fu/i7NUBumj5xuN8jzNM8BMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757079164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xaEQOXHnj5AQbKgdBzSltCb7gf/7Q/irpuQGgAGye2I=;
	b=A+tXZiTT7pSs+iSkahqm7dN83kqEx8kkSowrNmB3mwElQtV6ipgJO0P0rhnFho3cliiHOy
	xM/JCMem0Y4lTkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 812AE13306;
	Fri,  5 Sep 2025 13:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gawlHnzmumg5dgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 05 Sep 2025 13:32:44 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: midi2: Fix MIDI2 IN EP max packet size
Date: Fri,  5 Sep 2025 15:32:34 +0200
Message-ID: <20250905133240.20966-1-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The EP-IN of MIDI2 (altset 1) wasn't initialized in
f_midi2_create_usb_configs() as it's an INT EP unlike others BULK
EPs.  But this leaves rather the max packet size unchanged no matter
which speed is used, resulting in the very slow access.
And the wMaxPacketSize values set there look legit for INT EPs, so
let's initialize the MIDI2 EP-IN there for achieving the equivalent
speed as well.

Fixes: 8b645922b223 ("usb: gadget: Add support for USB MIDI 2.0 function driver")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/gadget/function/f_midi2.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index b351f9ae0fc5..de16b02d857e 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -1737,9 +1737,12 @@ static int f_midi2_create_usb_configs(struct f_midi2 *midi2,
 	case USB_SPEED_HIGH:
 		midi2_midi1_ep_out_desc.wMaxPacketSize = cpu_to_le16(512);
 		midi2_midi1_ep_in_desc.wMaxPacketSize = cpu_to_le16(512);
-		for (i = 0; i < midi2->num_eps; i++)
+		for (i = 0; i < midi2->num_eps; i++) {
 			midi2_midi2_ep_out_desc[i].wMaxPacketSize =
 				cpu_to_le16(512);
+			midi2_midi2_ep_in_desc[i].wMaxPacketSize =
+				cpu_to_le16(512);
+		}
 		fallthrough;
 	case USB_SPEED_FULL:
 		midi1_in_eps = midi2_midi1_ep_in_descs;
@@ -1748,9 +1751,12 @@ static int f_midi2_create_usb_configs(struct f_midi2 *midi2,
 	case USB_SPEED_SUPER:
 		midi2_midi1_ep_out_desc.wMaxPacketSize = cpu_to_le16(1024);
 		midi2_midi1_ep_in_desc.wMaxPacketSize = cpu_to_le16(1024);
-		for (i = 0; i < midi2->num_eps; i++)
+		for (i = 0; i < midi2->num_eps; i++) {
 			midi2_midi2_ep_out_desc[i].wMaxPacketSize =
 				cpu_to_le16(1024);
+			midi2_midi2_ep_in_desc[i].wMaxPacketSize =
+				cpu_to_le16(1024);
+		}
 		midi1_in_eps = midi2_midi1_ep_in_ss_descs;
 		midi1_out_eps = midi2_midi1_ep_out_ss_descs;
 		break;
-- 
2.50.1


