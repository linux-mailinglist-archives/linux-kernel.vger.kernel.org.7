Return-Path: <linux-kernel+bounces-887936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A51C3965A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B97A4F1A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD3B2DF3FD;
	Thu,  6 Nov 2025 07:26:55 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF921FF2E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414015; cv=none; b=q8grfuvFMpLQzBI8gabmR7hHv1rLDX7AbnXJar1JL0FJrl+n0UHfHCB3ccJLBZhKKlVxo1/5Y9lDijhN9qBeIcnaqxl4NV4YGf1KKRF8jToq/t93s0VYUzjV6SNgMBXBP0EPNLIaWp+jUvnUQx1ZK8Z3B5PAmCUMQCgc0Xfh6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414015; c=relaxed/simple;
	bh=2JBuRJt65OA7w2UwrRzCurhhC637sy1rWyTxMxoTCZg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QwsH2KNSh5Rz6OWdvYjzAkAktkWW2Wi+MIbGI3pQW6sLmMf2VmT63XlI4dzmdoj8yLgokjgTJhnb8gMAJn+SgVRpgp2KVikQYeRglXfcnSSUfpgl1zrNXQ5tQ5MaeGpFx9F+hoBBnFcZQyNJlTjpU5dTOwhRSsV0n8r7NQ6asgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e7b0584c9so56456339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762414013; x=1763018813;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5hibFlMlPaKRCFQgOq3+yUJhwCK2DdBwiNINaxH9O0=;
        b=iimj+XzNUOWtCoP3u9NZvM59MP3KanbBNwOmlFntrDtzqLUpaA5GU0bgQBSQ9XTrdV
         SHhqIo7XZKgl2fhbk4EkcrsKf/QmmaictLsTLGXYbRGoSZHkJJaIxswaMFuD8eEEEPpw
         XTQBg4P/kv/SgO0CIj4pN2mdJeBDDNaKrsDb70R+5v659MZ7nIN5E6OYvpFjYgMC10yl
         blHIq2hB4avLX6r+yU36MqbGfjcxYG1P0aepsOeDr9WWBNXsDXQKhwm5yxl2N/BJBKm4
         hfyXGooILVCyjD45sXDnBBiZwRF1HeU5U26cJWhsBpzBC9EE5p3ReuNczv+F+ghxGvcT
         qSkw==
X-Gm-Message-State: AOJu0YxdZw4/GcJZVdTpWzF3KOwGJ2iouSyLFkamW+qRC6pXFueYCP4a
	M5nppy0fDsOFHkqdyfY1sc09EhnhGl//WYr+84QRQIEYP4wn2HO4Lt/QnIAU/pGT9tp3iOkrulx
	J6COLVycy0BDTSslYqB8UZ5GgpwD3B5vONuvF1KdCs+/tGKaUpKG+TGlwV6U=
X-Google-Smtp-Source: AGHT+IH5W+wWbWxR93XDdjQT3/j6upXvcuDEiXkjDXAEAU4X8AdBmunyn7mpPqBxB6OqtjawDNzIXgP3ALhwU1gcmH4ruYMICRzg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1544:b0:93e:8b7c:4a25 with SMTP id
 ca18e2360f4ac-94869ec94bcmr957661239f.18.1762414013050; Wed, 05 Nov 2025
 23:26:53 -0800 (PST)
Date: Wed, 05 Nov 2025 23:26:53 -0800
In-Reply-To: <6903e7f7.050a0220.3344a1.044c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c4dbd.050a0220.baf87.0081.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [sound?] [usb?] KASAN: slab-out-of-bounds
 Write in copy_to_urb
From: syzbot <syzbot+76916a45d2294b551fd9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [sound?] [usb?] KASAN: slab-out-of-bounds Write in copy_to_urb
Author: lizhi.xu@windriver.com

#syz test

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 54d01dfd820f..a4c0ea685b8a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1606,6 +1606,9 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 				    subs->cur_audiofmt->dsd_bitrev)) {
 			fill_playback_urb_dsd_bitrev(subs, urb, bytes);
 		} else {
+			if (bytes > ctx->buffer_size)
+				return -EPIPE;
+
 			/* usual PCM */
 			if (!subs->tx_length_quirk)
 				copy_to_urb(subs, urb, 0, stride, bytes);

