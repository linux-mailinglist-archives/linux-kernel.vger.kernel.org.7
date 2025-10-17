Return-Path: <linux-kernel+bounces-858751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48910BEBB89
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AB214E0409
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422B1354AC9;
	Fri, 17 Oct 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rQr+QPgb"
Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2951643B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734093; cv=none; b=dRIn1YTukYKHInAarE/5parKXKpz/kCsbsmkPvHIW03m/K/o3gJd3ptx76cDcxvX14qC8GVgu+WhAe2WspzLHEFNo/JkTots4lN0utMpuJWjkkjZKP4JRBspD8H9Kz/X845Jf/55DOzjWZ+ONVsgSN46+3AC5Uu42kqWsCSIpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734093; c=relaxed/simple;
	bh=hE5BNME5jjYzsuDXGKZnAOa4a3nDpryR7EZ1q7Ng32s=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jRTWGQ08a/J+DPoKQpOYzrj3xlBiSWhxXML0D51UOnPd3vxVzP5BF0nc6MTU1J8l3Sob6opbRSJQi2M8VDHD1LHEK5M0TmUH2bpkB+DyJh28X2wO98qR+SAo+E9W1gEsRZ2b7/h01OJ0o85giD6uyiTu4mQCrgT0E44366tv034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=rQr+QPgb; arc=none smtp.client-ip=79.135.106.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760734083; x=1760993283;
	bh=hE5BNME5jjYzsuDXGKZnAOa4a3nDpryR7EZ1q7Ng32s=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rQr+QPgb8R4zaSd0b22Ij2dxFop8j12xIzmdJV1E4EhZHR7gjxCfVJehFnxROn4Mv
	 10FcjiCvilyZwa0b4DHjMffTr/E1+QO7NCDPeR9zwf9eX+bbquqHjjhCu+ZEcrqSla
	 Enjz+3QNZSHrrNVxY6udFFp/3XXRYqqy3Jd5JpSjBOhG44o11BJtglqmeCKzTlDc7L
	 nKKnzoAH4OQ1gdUEJF0Q98rLl59deYosx/pthrI12JiLnF69SyLlDLHp2yfKw8WgKs
	 1DwfAxSSV9IkV1vawgWOTNjjBmj+qi2qpQV8iw5G2j2EqjD22JaEK/0ToMYjEcqfVB
	 yEYBuqz20X1FQ==
Date: Fri, 17 Oct 2025 20:47:58 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?utf-8?Q?Na=C3=BCm_Jumpertz?= <n.jumpertz@protonmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Oppo/Oneplus phones and usb3.0 incompatibility
Message-ID: <YhXrCm5ig-YWPY2OVkmdPl48N1Td6K8qJJ5cW7OtIMQt9ENXrexATCgeXCmuG5Mq1wIDxyhaLZhZeuW15lgKhKEKKLfU3GwjMMhKP1Awyj4=@protonmail.com>
Feedback-ID: 107994687:user:proton
X-Pm-Message-ID: ee0bc6c042fc5f5b12019010a0ddd5d060ce24a9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Because of wrong device descriptor, certain oppo/oneplus phones,=20
like my oppo find x5, can't connect to linux computers using usb3 cables,
the issue is also on other oppo/oneplus phones such as oneplus 9 pro,=20
starting from OxygenOs 13 in december 2022=20
link: https://xdaforums.com/t/connection-problems-to-a-computer-with-linux.=
4642402/
The issue is present in kernel 6.17 but also in older versions.
The connection correctly works using an usb2 cable.

The phone is detected as a USB SuperSpeed device but the device descriptor =
flag given is USB 2.0,
so, according to dmesg, the kernel warm reset the phone and don't manage to=
 establishes the connection, which is annoying:

[ 3537.701845] usb 2-2: new SuperSpeed USB device number 4 using xhci_hcd
[ 3537.722594] usb 2-2: got a wrong device descriptor, warm reset device
[ 3538.105960] usb 2-2: new SuperSpeed USB device number 5 using xhci_hcd
[ 3538.126933] usb 2-2: got a wrong device descriptor, warm reset device
[ 3538.313826] usb usb2-port2: attempt power cycle
[ 3539.241985] usb 2-2: new SuperSpeed USB device number 6 using xhci_hcd
[ 3539.262410] usb 2-2: got a wrong device descriptor, warm reset device
[ 3539.646017] usb 2-2: new SuperSpeed USB device number 7 using xhci_hcd
[ 3539.666993] usb 2-2: got a wrong device descriptor, warm reset device
[ 3539.853713] usb usb2-port2: unable to enumerate USB device

The issue is due to oppo phones not being conformant to usb standard.
Maybe the kernel should still establish the connection if warm resets fail,=
 by counting fails or something,
otherwise oppo phones will never manage to connect through usb3.0 cables, u=
ntil oppo fixes it.

I'm not a dev, so my solution was just to disable the feature:
---
 drivers/usb/core/hub.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 256fe8c86828..be28296b39de 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5186,20 +5186,6 @@ hub_port_init(struct usb_hub *hub, struct usb_device=
 *udev, int port1,
 =09=09*dev_descr =3D *descr;
 =09kfree(descr);
=20
-=09/*
-=09 * Some superspeed devices have finished the link training process
-=09 * and attached to a superspeed hub port, but the device descriptor
-=09 * got from those devices show they aren't superspeed devices. Warm
-=09 * reset the port attached by the devices can fix them.
-=09 */
-=09if ((udev->speed >=3D USB_SPEED_SUPER) &&
-=09=09=09(le16_to_cpu(udev->descriptor.bcdUSB) < 0x0300)) {
-=09=09dev_err(&udev->dev, "got a wrong device descriptor, warm reset devic=
e\n");
-=09=09hub_port_reset(hub, port1, udev, HUB_BH_RESET_TIME, true);
-=09=09retval =3D -EINVAL;
-=09=09goto fail;
-=09}
-
 =09usb_detect_quirks(udev);
=20
 =09if (le16_to_cpu(udev->descriptor.bcdUSB) >=3D 0x0201) {
--=20
2.51.0



