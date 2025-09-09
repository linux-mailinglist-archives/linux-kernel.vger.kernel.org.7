Return-Path: <linux-kernel+bounces-807157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2AB4A0EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762F07B04CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823FC2EB851;
	Tue,  9 Sep 2025 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI6y0Kvz"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612EC45945;
	Tue,  9 Sep 2025 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393498; cv=none; b=uKFQux1Yn9mbISxPiTIWiARR0HxIX72WJ6lu10xxqbPQViO08bZNbpjby5raALJK68xnCiHicMAi1byQKIZ1Fwa6M/9wYiSozBqp+Rrt5db4jU+rlv9zS/DU1sOAxaqv6W/OPQdtD6hU5xIN2HAwi17YZzPmIiR61R1RUGS/+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393498; c=relaxed/simple;
	bh=wH/OryNLCEcRYqyLFBNK6IHwMxcsp/ft3tNfmOPPNJQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k/VGQ1qNCnNb74mGL8eIonxb2s7Va1knTHcedl8QEQm9rFPz9HTEvNiz29mrAAUjoQjsaCCOYBuKaJIWlQTHNXzTie3oyvACSTcM3yJ/SOHU5yLCgiuidaNKSAhZCTgi07pkd9J8BzG/VAVeknOfhdBonMjffTE9g1JVzSod7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI6y0Kvz; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b61161c30fso10046751cf.3;
        Mon, 08 Sep 2025 21:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757393496; x=1757998296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wH/OryNLCEcRYqyLFBNK6IHwMxcsp/ft3tNfmOPPNJQ=;
        b=FI6y0Kvz85pjIj1NoLtsgh9yADrLGf/1ZP5nsabVCmisE25qW5jE3hcFvA2zpXeiFA
         sRBGaDf0VcZXL8QLNt28ejUoslDkbZr4pVpeylb3umEiPwaK+dckdejnyIjiXOJ1dCiv
         Xeq+lyORP9ANVb2jUQNik9C0wtTQOG7ALhoml2L1gpdbHIs1eeTS8+DBPJRltNncrMd3
         d8GZ1K/xfWpRHkShHAsgx5TaRWA6mXPF/Eo2vlGh/hl5jJSbAuyrOJHpgwFf+e6aGu7G
         vasAs3kGdX5HrqfXfVp6FrK6ncPgX0V/ie/49+5OGS+U+9HAU9FLYXHD4bc9tAkP2+pu
         haew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757393496; x=1757998296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wH/OryNLCEcRYqyLFBNK6IHwMxcsp/ft3tNfmOPPNJQ=;
        b=hdnaxh8tXOOUCDVyC3XBLePO7ybI1JrE94SaZmECCFfTpRGh9um/FWk+ltPcxPwSrk
         fLU9t02V1zHLfzdbYobk8VzZssDMaNw26pPZ9KX/jO0G9QvvO6vnKh287xAVXeUBI2OJ
         gaLoHJTto8ldJ0t2aTGBThZISQjzmsmTxYqxST+zAKXtN5d00srEGIWJb44X7WD8nssh
         QtdpquF0V/24X+WxTeXTWSEKBZIXK9JEsnHMNCzwUFH+G9yws18LNoXS3dwYWiBKgpGn
         rRjLebBoNbFzit9lghgkdYuf91X2+RzDZO4CZ2e7gXo0V0ieAJXo1OTg5mv6YtMAwEFj
         v40Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZ7XOFGYu4FXURelAEkd3teXaKbnWXZW87XUbL9EuSjbxKD8+p8aWYLKuCXPE7e5Si0tjjNR29wBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMgtU31y7m4mqkbPb11sq5yfR942GthSrd6D8DnySb3YZ+HFP
	eajaEhG2CDMZSrj7sCTtrACoUr6tmlQ4kT3Hrcy4q7HhoL+VjyGKq0R5UDVGg6mPQg6bBRDXcHd
	BZrzitqqYjn2iTGtqcTgqk4iRnwqomyaamg==
X-Gm-Gg: ASbGncsfOzozNL8iFaOwElxkML8BSFyqhCzWzfyzey7gjacEsWK96VHH9CiSdq3jv2h
	FXBJ0dPSQGK3oZ+MU862H4Oid09kMbMYahOTs5Jh0AR24HrtJIOBvLfTo9EbQz1QQiSrDPDqRgP
	5/0tRnFRJSeT9x5NqQQWCiZGc/nmpmCntWumnC8B1XwxkvhY1mDfFj9L5stjgT4WO/J0lZoxpdd
	/QXVlL6oXzpWz8fOVT43prTPMzPfQ==
X-Google-Smtp-Source: AGHT+IHJtJRTUXQmOqYObA+I/Kj+efEnxR/Y5qMByvHXNuz8Olc4ZCWrdxlznJK4GFkaxnUmApWZkdqJIpC4tbNHanU=
X-Received: by 2002:ac8:578d:0:b0:4b5:f75c:1568 with SMTP id
 d75a77b69052e-4b5f8377244mr96446891cf.10.1757393496207; Mon, 08 Sep 2025
 21:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Forest Crossman <cyrozap@gmail.com>
Date: Mon, 8 Sep 2025 23:50:00 -0500
X-Gm-Features: Ac12FXybq92r9r1M96nhwQvax4391vC35S83AyjCaVhisGgoTkrYtLq33fYEb0k
Message-ID: <CAO3ALPzdUkmMr0YMrODLeDSLZqNCkWcAP8NumuPHLjNJ8wC1kQ@mail.gmail.com>
Subject: [RFC] usb: mon: Increase BUFF_MAX to support modern higher-speed devices
To: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The usbmon binary interface currently truncates captures for large
transfers from higher-speed USB devices. This is caused by the
BUFF_MAX limit in drivers/usb/mon/mon_bin.c, which has not been
updated since the usbmon binary interface was first introduced in
2006. A single event capture is limited to one-fifth of the total
buffer size, capping URB captures at 240 KiB each.

I discovered this limitation while developing a Wireshark protocol
dissector [1], where truncated captures made it impossible for the
dissector to defragment and reassemble the protocol packets (an
example of this truncation can be seen in frame 1580 of this capture
file [2]). Others in the community have also encountered this hard
limit when working with modern devices that use transfers of several
hundred kilobytes or more [3].

The original comment for BUFF_MAX based its calculation on a saturated
480 Mbit/s bus. Applying the same logic to a USB 3.2 Gen 2=C3=972 20 Gbit/s
bus (~2500 MB/s over a 20ms window) indicates a required buffer size
of at least 50 MB.

I propose increasing BUFF_MAX to 64 MiB. Making this change would
enable usbmon to better support capturing the USB traffic of modern
higher-speed devices, enabling users and developers to debug and
reverse engineer their USB devices while running unmodified distro
kernels. This change would not affect the default buffer size, as a
larger buffer is only allocated when explicitly requested via the
MON_IOCT_RING_SIZE ioctl.

This proposal follows the same rationale as the original calculation,
but with updates for modern hardware.

I would appreciate any feedback on this approach before I prepare a patch.

Thank you,
Forest

[1]: https://github.com/cyrozap/mct-usb-display-adapter-re/tree/master/wire=
shark
[2]: https://github.com/cyrozap/mct-usb-display-adapter-re/blob/aad88e9fb80=
603ebf45fcd3ecb57640c3970986b/captures/trace-JCD543-20220514T1925-win10-plu=
g-in-dongle-with-hdmi-disconnected-then-connect-1080p-edid.pcapng.gz
[3]: https://web.archive.org/web/20240618163716/https://ask.wireshark.org/q=
uestion/23535/how-to-increase-capture-length-framecap_len-when-using-wiresh=
ark-for-usb-sniffing-on-ubuntu/

