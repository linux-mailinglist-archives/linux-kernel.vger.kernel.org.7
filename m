Return-Path: <linux-kernel+bounces-744742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F4B11069
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C490E4E08C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F402EAB7A;
	Thu, 24 Jul 2025 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9/S1+Ib"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B21E04BD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378556; cv=none; b=RmYQAnGT+anRYufxqiVEx3d+okJN4lFv1+W/1KBsvkwKyhMk2Jylcu5j0gUBnXviAPcODRICVLL10WGptDnkc2ve9f2MqwPd3pu3Ipc6WS7pNYQrjmw/PEmQ/qr+IufdYutVXvATk20xAvv28OGREpf/8ZyC92jjQKD3tiEd4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378556; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PYhLK5dCOa1NFsmLQqBou+P5wudywrwEVuZ22oxSUxQ/v0Nqy/0dEDtUK4J/18E7p9ccZbcya1U336YMEY7bA+64XfRAXXq4ZhHDDzHHUFKI12c3Zm7ayRMmZjwa1oBxqW25NS/cSUKKU0CU+WGetpdawBds2/QKQkWj9qAJmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9/S1+Ib; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32e14ce168eso13788571fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753378553; x=1753983353; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=X9/S1+IbATlpy/X5R7S2XnqaLfG8OHeI9+hIPhSA7Z9HwIe4okvLjKS0E5/nsaHqzL
         9n7s0z5czv5e4xH2U7G08x6VSdirmQdfXdeo6jPQCVvRXx6OFBayRWPWaoYmhpWm620b
         qSfE3OZP4im6N4HqrEJ8QtgOoSV97nssInAmwEhoHGtqYJbc2PZZXKdoeTF5LczqoU+Y
         ugqQo5dcoLn8Ak4eeeHDdlw+UxD5Vtu5X+CK++P+yncgCqnPlV6I2MvpQmX4/w8zvW4F
         ZAr1l+fstPlEUQqQDvk7R5vFj0jPSb0+U8h/K+ueTslDRdHv+mDbBUhxrQm8MQCdPqEg
         P7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753378553; x=1753983353;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=wLKtLRX4wc08NhWp8QkvBW6RIIT0cA6em6Abr2c9H40tLF9F84RhyGCg1M6F2aI7B8
         w+Wo8iczrnP+gFegv2OCNIiiYGxohhOz4CqIwLECnj+Bo51dSZtBEaglQbeE3Xwj36pW
         bpdguf+FanFE/f3OvSF0yi6CjMmLrc2JmfXW4SbvGAUSvnVV0U928t+4sOfKazGbN4hf
         SPWmm3Zz6LAtjR7spgVjPatQ/Wb9Kfb80v7ezEctLQl5IdfoIj3E95BStFnotDiMc+/v
         1dXN+t/KRMskvKig/MLZEzJHfWGAgzzrg1Jlue6H0mL7pS2k/SBhv58oMXLxpKColMZm
         0oiQ==
X-Gm-Message-State: AOJu0YxztGNvmtoLaA6esPhPDWfcSOnTfZGi08APhOG0J1kVmkWTbdtn
	WpprEZhJLfOOLE2jtLCeWTAizps7lqEc7F1HJZZqvPZLwBQa/qRjWIVXLUzHqMs6cxFXHneeSSx
	15/5A+yamy4Y+BIiAXMZtR/U+0xhE9x+IFQ==
X-Gm-Gg: ASbGnctLVKcmsydhsVZphQMoTwttiuYXfmCLEPLx6on6FbofQ2OR3npXCurSaJrcWXE
	wzeZCD3CBex6bP2d27fW38oqkwE/NcERkKWDfWm/7J3uz4I36pkTRBcFwPw8tjsHvlNfvEztKl0
	ZKh4XloedD5Iu1wEszvVIqORV/1XEjG9evEQLLjjPSjluZQd25cl7HyrvZuVvBCpNrLAJikbi9k
	Z6GtUFd+4qg+2t6CM/tRrxEBfNlRAnryr1idiGQ
X-Google-Smtp-Source: AGHT+IG5UWErXwKC6ykhKSvk02ApXpPii/e89KpwgSyCw+Ph2U9uQ67z+/5Z4PGEBik41cAA09seiiyp+c0UXxg4uCs=
X-Received: by 2002:a05:651c:50f:b0:32b:9792:1887 with SMTP id
 38308e7fff4ca-330dfc273ccmr18850481fa.11.1753378552947; Thu, 24 Jul 2025
 10:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jay <jaymaacton@gmail.com>
Date: Thu, 24 Jul 2025 13:35:41 -0400
X-Gm-Features: Ac12FXw3XmaMmOE_PdKDmHDdjO5PPpWRkX3oCOSodJ1U2mphcmGDwNyl93eGlUI
Message-ID: <CAPpvP8LBrgK7T8s=tg_LWOEQ0NW_GyQvzHeYYqnh-cw942UDYQ@mail.gmail.com>
Subject: unsubscribe
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"



