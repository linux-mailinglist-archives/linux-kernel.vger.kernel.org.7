Return-Path: <linux-kernel+bounces-887960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43409C39735
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AC5A4E8C07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A047D2DC79A;
	Thu,  6 Nov 2025 07:50:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C621D00A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415404; cv=none; b=GCOfJ6AxpxadwzSzRedpGcmwVs9SmXGQUITmzFh4sTeXMOJbmlQ/TBsNZCYeY+/fvhAP88MFX89G406rvMyArN8DpAGbwiFWYrfnP0lMSieqth936sFfFBsDRcw05bFfZ+QVXT/CXwh3BBiNrF3Dy05li6MNWqdFiMreCqNysbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415404; c=relaxed/simple;
	bh=2JBuRJt65OA7w2UwrRzCurhhC637sy1rWyTxMxoTCZg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HSgVA5uVlEysLPrf57VRy/4FhlYutcXIYPqA8EJeAppKVN/us51FudcPC6BR2ug1kWRkWcpihajkpPrbB7qjmPwAr1AW/NYvRj8vz+mJiDMJ4crpbuF4lyKMvz4TXIYc5gjfQYNrLqZmNxEijNGXahel6iDTmhdIi/UwMGyvrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e86696b5fso5034839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415402; x=1763020202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5hibFlMlPaKRCFQgOq3+yUJhwCK2DdBwiNINaxH9O0=;
        b=JrFMk3S5iFB7u+xQMxt3cB2/TD0BuSOhMBVtVRVEG9yHSt8seG1h4e/iJBrWBfjWaW
         VuZGBNBTAVqKehM5m6gR9UHMbWMuxpF60zgPpxXNyb58MIflf3NaLB/V6KNog2kV82VF
         aQQKRxL3+RPV4Vz1CPGIN3rzXbbVo8Cy1wD31cZSG8Qu5nKE4IFE/OtPc3HVFMLtQe2G
         1n8GPhGz01IQt09dxlArHkZtXEDv6Kq14VeKrjvg7ubxfayQWOah1veR2nT5uHazoUzi
         m2ELo5ZxQsWjbk9aD5bp6UyRd7cKlLXeb00kaN3nXFg6lt0Z2ti/aswvxpK66gImahQ2
         aZgg==
X-Gm-Message-State: AOJu0YxaaM7ZunAtsbOVGTqnDDLS9tEUKYdnefvSF6xtjuBUc9frFkMQ
	9wEExRD1oLEAhjPbxRYjgxKJWJBYnGRW33Z/qKlV7CApGSgmi4N+W/TVE7Uk7wzxjva5HSGnAeC
	XdnSShzZbCEwcoVb0cYIKj/utIAbeYOBt/7cH9XyyoAcejEKgQ3StcJg6em4=
X-Google-Smtp-Source: AGHT+IFuDfyAeA9pgvVdN2NS2EEvow6cXnms11VY7LqoGZLLHw7ql3hO9671D1YjjMaPgSvqrEb0QiUXyCCuvxqlfIp9rqlIkJeN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1611:b0:948:3f60:a620 with SMTP id
 ca18e2360f4ac-94869ca1af3mr983946039f.1.1762415402079; Wed, 05 Nov 2025
 23:50:02 -0800 (PST)
Date: Wed, 05 Nov 2025 23:50:02 -0800
In-Reply-To: <690b6b46.050a0220.3d0d33.0054.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c532a.050a0220.1e8caa.00b9.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [sound?] [usb?] KASAN: slab-out-of-bounds
 Write in copy_to_urb
From: syzbot <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>
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

