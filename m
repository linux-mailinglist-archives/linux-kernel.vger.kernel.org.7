Return-Path: <linux-kernel+bounces-892779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D277C45C92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004FE3B80E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997DE267B15;
	Mon, 10 Nov 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="D/5KGmiP"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E250D35957
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768792; cv=none; b=GHAOVDEKyG/pAxKZPTlWipOGVLgnRqmbh7YCVhEUhkZNASn2ltCViR/moYTEsjX9lLderE505GXTvXnFGm9M+62fL/G3v6nAGiSylTFRXB3QGF6vEiPLG93/nbkpRM+Y3mtGZ7ZxYdxr5wRSNpb8Uh8KfuQQ2fuPjmy3DE/izCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768792; c=relaxed/simple;
	bh=JBt8g7SQEsL3M79khwzWnQNCRB3focf1yPfhFa4I6Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PKjHH23p0fJRxvAgGG6vwGeGoL9q2hOYBdJ9dCTOqkodtgi5wn2d9IwFsMt6YWx5J6H0ndUTW9vaTn1FkpE6ZGioa8RROkAiOr0Vgyol6ouE25DMXevcGIJqrsswbyQac+cWMBOMwYEVq3Y2mbVRsPuusDVLNFBI/N7BvKkDzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=D/5KGmiP; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.19])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id D782C40762F2;
	Mon, 10 Nov 2025 09:59:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D782C40762F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762768785;
	bh=xOM9WnInGgzHSjHTGzbObl3+3rrWsxV5Xy308i+md0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D/5KGmiPQI9vugWX7l7uY3wZIdNFuzDhjqJ6zhDEXEawXDwDH+ebaHGytc13LGCNf
	 tQ+rB+grIGkJMWVmhxVYwiHUYFzZcdWGR7t+xVBFGwuLEieujaPkJfaCFga8pSCZVn
	 ewAzXcwE4qNkaCV8Nt9alJoWYyKtl16jN91iQd6o=
Date: Mon, 10 Nov 2025 12:59:45 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: syzbot+a11c46f37ee083a73deb@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] KASAN: use-after-free Read in
 em28xx_close_extension (2)
Message-ID: <20251110125137-e6946c988e9f22f6d30a5fea-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66ec3c83.050a0220.29194.002f.GAE@google.com>

#syz test

--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3445,17 +3445,16 @@ static void request_module_async(struct work_struct *work)
 
        /*
         * Devices with an audio-only intf also have a V4L/DVB/RC
-        * intf. Don't register extensions twice on those devices.
+        * intf.
         */
        if (dev->is_audio_only) {
 #if defined(CONFIG_MODULES) && defined(MODULE)
                request_module("em28xx-alsa");
 #endif
+               em28xx_init_extension(dev);
                return;
        }
 
-       em28xx_init_extension(dev);
-
 #if defined(CONFIG_MODULES) && defined(MODULE)
        if (dev->has_video)
                request_module("em28xx-v4l");
@@ -3469,6 +3468,8 @@ static void request_module_async(struct work_struct *work)
            ((dev->board.ir_codes || dev->board.has_ir_i2c) && !disable_ir))
                request_module("em28xx-rc");
 #endif /* CONFIG_MODULES */
+
+       em28xx_init_extension(dev);
 }
 
 static void request_modules(struct em28xx *dev)
@@ -3676,8 +3677,6 @@ static int em28xx_init_dev(struct em28xx *dev, struct usb_device *udev,
                        retval = -ENODEV;
                        goto err_deinit_media;
                }
-               em28xx_init_extension(dev);
-
                return 0;
        }


