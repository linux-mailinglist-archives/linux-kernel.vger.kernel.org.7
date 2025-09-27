Return-Path: <linux-kernel+bounces-834886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723CBBA5C32
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102EA4A7EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505FF2D5926;
	Sat, 27 Sep 2025 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="0EVqi6yi"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B31EA7EC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758964796; cv=none; b=mwmV/CoQP5koJK0UrxdH0NhgAzH3D/JBO4KDEO53F11UveZnrjLVyd8cYHliuVSXcX46GF92zzAcCssEFQ589jM9mqVsAIBXHGvMD80p3J7WgG6aLrQOL1gtfxheZ/wDM3Z4jkAnKQ8hV2+Qu27ep1t5TiSDNIJEdoVgTRJkdl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758964796; c=relaxed/simple;
	bh=OWIMR0L5vkff4Ys/9AAqmy1jpmGTpcfS/mJh7BqMR5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzXWNdc5g6S7QJBKZ0HtboCxga0NqzB7Zr+EyETMwNZjHaWxc+8pejLwM83Ujh6fTYaR2v3ukhUejBeQbz9H9mEy0l3p6afliTR0wJPfp03jF0j4fmwrTdWqaVuYjt7z1z8Nt4G5VHvwhLR8nSqeyNRjE1YjkjElO6PNvsEEK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=0EVqi6yi; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758964791;
	bh=j/01ePzQPDKPh07IXh1FLzg373Fq7gj6Elmi7oXim6E=;
	h=From:Subject:Date:Message-ID;
	b=0EVqi6yiEV1tq2YAfbZifbSLGETYwGub1k/+X28tTs0gjVQGRV71Ei0gOgFVvdBdt
	 BvTReX702aVTwBdfy2z5OtvEnyEZQOeZvqnfltCzvacMHGVYdP7vLs0ovEnHISGymQ
	 xpstbuV+prG4f1Zrp/vVunSHTAUAWJgjvof6Fn3E=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68D7AC2B0000679D; Sat, 27 Sep 2025 17:19:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2410786292040
X-SMAIL-UIID: 84B51BDFE84749BCA5154F6B87C6AF64-20250927-171941-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jeongjun Park <aha310510@gmail.com>,
	clemens@ladisch.de,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
Date: Sat, 27 Sep 2025 17:19:29 +0800
Message-ID: <20250927091931.7691-1-hdanton@sina.com>
In-Reply-To: <87bjmwb9y6.wl-tiwai@suse.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Sep 2025 10:01:37 +0200 Takashi Iwai wrote:
>On Sat, 27 Sep 2025 06:41:06 +0200 Jeongjun Park wrote:
>> 
>> The previous commit 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at
>> removal") patched a UAF issue caused by the error timer.
>> 
>> However, because the error timer kill added in this patch occurs after the
>> endpoint delete, a race condition to UAF still occurs, albeit rarely.
>> 
>> Therefore, to prevent this, the error timer must be killed before freeing
>> the heap memory.
>> 
>> Cc: <stable@vger.kernel.org>
>> Fixes: 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at removal")
>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>
> I suppose it's a fix for the recent syzbot reports?
>   https://lore.kernel.org/68d17f44.050a0220.13cd81.05b7.GAE@google.com
>   https://lore.kernel.org/68d38327.a70a0220.1b52b.02be.GAE@google.com

#syz test upstream master

--- x/sound/usb/midi.c
+++ y/sound/usb/midi.c
@@ -1522,6 +1522,8 @@ static void snd_usbmidi_free(struct snd_
 {
 	int i;
 
+	timer_shutdown_sync(&umidi->error_timer);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
 		if (ep->out)
@@ -1530,7 +1532,6 @@ static void snd_usbmidi_free(struct snd_
 			snd_usbmidi_in_endpoint_delete(ep->in);
 	}
 	mutex_destroy(&umidi->mutex);
-	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 
--

