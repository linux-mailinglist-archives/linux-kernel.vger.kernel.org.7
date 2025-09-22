Return-Path: <linux-kernel+bounces-827839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B3B933CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABFD3ADC6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD1825C822;
	Mon, 22 Sep 2025 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1d70yzY"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41325A33A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573142; cv=none; b=uGGlupZyC5RfDAulpl5UULKDLnePugjc55Ouee6shQ49jz7B+vMVUOac0AxJkR7seNBGTvJHzn9cgo9A9ycDi7oMB7M9h7C4DYIuLwPFlFDj4SwR2Srzk/EAXxMgMyvgISbxAuFAhzgwXIarYarZR4W7FRhz11sHyJ2r7C20Ub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573142; c=relaxed/simple;
	bh=UG69M1IVVdE2PGp0fqTRKe9oVR9CdEzH1MNduD7Uexk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3E0fbRV3wwiZjMZdhI0ShfFHsuMaVtTQMQLzSz/X/aR68br79rc75+LeJnQkF6b2WoQe4l+G/Mc2HKMBPMhnX6F2iRSiHEMcVHPVc8TqhC/jeTn+iJKZewSmbNptJlw7jUwCrlXnWTMF5HkeGds9RJ+srYgg21O5bnRUi0od0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1d70yzY; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-84dcf6f28e0so87454485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758573138; x=1759177938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG69M1IVVdE2PGp0fqTRKe9oVR9CdEzH1MNduD7Uexk=;
        b=K1d70yzYo3LA2a586ItgQUZ0UeFQ5ggGN2MONG+KD6Z2mt0iiLLI8/9+SktniEKzMd
         T4aFEWeWSMJhaEWIYcXN6MQDz+ePELlUo0MUbPsY/jQ4E+PWJsBhPedmnHYlX2kz846U
         V8YRo1J3IXXY0XdckcoMwIgPJE4u/dZ2XeET/Jsa0BN/QuyordWAr5VDKDoHltlEDtyF
         oK1uWBfMTEvvJvyt3Iw2noUW3zg8vbQp/N1Y+sz1HsA6D384o+05hR261wl9u9LyUmfC
         Gu3p+ss35iTQ41w76oLwm2M2fkWwETck23GRbcpMj4XVM6Br4pJHSPIj3PFHXREVP3M8
         4y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573138; x=1759177938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG69M1IVVdE2PGp0fqTRKe9oVR9CdEzH1MNduD7Uexk=;
        b=IqCib4QZamihS8QqwEovh51wWaZ+roT3KjMss+xL1bq5w3HJOdTlaVHULbKEuUFbeV
         s17pfJTEGt4z4d09nJ2GgFG4Wn9cR2wtegrz4Lr/Rdxvls6Lh9VwuL01vUWpogXimDJd
         AbqaJ+bSNoue+wpSz70TGdqrH/saXe1mGPrE1TojaciSKm+wtAnRiw4s4R36xMx9ur2H
         2zAI4OXkQ+dwHweDmjy/0LZZXPE+YHtKvMbwOnwzZ8Yxqp8zS3qw/OQ7QhQizEerC/90
         h5bkhDlAJXoSpe1lNR1wwRqEksj3cuOVM+N0NLMsEn3uinRlzcSKEkGOH/2e8ShIVIcc
         dkzw==
X-Forwarded-Encrypted: i=1; AJvYcCV+tmI2s6sqOa+A6ibmGMNCicTG3wF/NrLKwnVtti1QAWF6SYvTvwRm0HAU1FByLgGBjl4zxe7YOo1/Hqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEYUyJlyE2EOwjOTxH2RNUfI25b3TBn0lphsoysNseJ3jTwWD
	ohJbV5UAa6A1XzYx9MY4x3gmayKo+nH7O8M5AePPlJrE7PULbTshZDlHGhAcGRw9DVfYiysDldv
	eJ1pfWHc7j+hzyDuqk7pK9y1f/fO9XUI=
X-Gm-Gg: ASbGnctF+0m1pWqD6cH21MpB+6Z3dCZgVvz0F18x5gYBqTbVP15J+rYKVZNthEhkyhN
	aMVHfLweCCmr6tEjSRArDVejTAcBALMhv/ML2JG7c4rLBggEluiTAnNenvOmSy/xPTv4QYnUdZn
	cvixWyINC0HUYtq5z5LO6ZonMVGhsYJlwRgnaFsKBBlIwuF4Q2H8b935qEmgepxHg9+ya1ei3v8
	2A3XHgNj986SYQug/UMRIIHiqtIFhM4PjzGOodOMw==
X-Google-Smtp-Source: AGHT+IHSqXAXRvrgQnAfjh65roix5LaKfKH4YNfu9oaDRcJHx5FbfpRJ/aJ3R/Xkk0NazNTr0SN+HDKIIBs1Mzh1IIo=
X-Received: by 2002:a05:620a:370c:b0:829:25f1:3208 with SMTP id
 af79cd13be357-85175f52ec2mr33267385a.61.1758573138310; Mon, 22 Sep 2025
 13:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEU-x4=Zs22b5LX_rsBVMu4BxvDfO+CZkkuWuVNaxv8mqvh9Gw@mail.gmail.com>
 <bjtev7sgmcafoysd53xrxih4nawn2dbq4odylwdglbub6td2a3@nhoxenprhjvy>
 <CAEU-x4kL45DAddmNahjR2C97+43jchpmXep++LbeP8cXLEWN-w@mail.gmail.com>
 <CAEU-x4nv3XnXchevtwN5mkVcxqnpgBobhavxZc7BjS7EgYG8Ng@mail.gmail.com> <c3plpgl2zsx4do2odwdeowodkkdnfqpexlwqg5a5mckyibxlge@qai35f5yeswy>
In-Reply-To: <c3plpgl2zsx4do2odwdeowodkkdnfqpexlwqg5a5mckyibxlge@qai35f5yeswy>
From: Yinon Burgansky <yinonburgansky@gmail.com>
Date: Mon, 22 Sep 2025 23:32:07 +0300
X-Gm-Features: AS18NWC34wlHuTeaKU4_gAJIUEcIDl27QqadqogiGTSWePhgcUUmRrAOIWjEJR0
Message-ID: <CAEU-x4mJiBM_zKg1DaeJkKB3W3Ay08bUTc-D3QjFjDxNiZGd0g@mail.gmail.com>
Subject: Re: Touchpad multitouch leaves ghost fingers
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:51=E2=80=AFPM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
> Well, I was meaning that I would provide a HID-BPF MR ready to install
> for you.
That would be awesome! Thank you very much!

> But if you want to play with it, feel free to do so :)
> For a jump start on HID-BPF:
> https://libevdev.pages.freedesktop.org/udev-hid-bpf/tutorial.html
Thank you for the reference. I=E2=80=99m feeling quite fatigued from the
debugging process, as it took me a considerable amount of time to
identify the issue.
It was surprisingly difficult to determine what exactly was wrong with
the touchpad and to uncover the root cause; perhaps I didn=E2=80=99t search
for the right terms.
However, I=E2=80=99m glad I finally took the time to debug it, submit the b=
ug
report, and find out what was wrong. Thank you!

> The advantage of HID-BPF is that we can drop the file in the filesystem
> and then forget about it.
> My plan is to have the HID-BPF detect whether the quirk has been applied
> or not and would gracefully remove itself once the kernel is fixed.
That's cool, nice design.

> PS: please try to refrain from top-posting your reply. The usage is to
> inline your reply or reply below,
Sorry about that, hopefully I did it right this time.

Thanks,
Yinon

