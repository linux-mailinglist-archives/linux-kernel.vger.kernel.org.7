Return-Path: <linux-kernel+bounces-891657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD3C432BC
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE8FC4E7638
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB626D4F9;
	Sat,  8 Nov 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="viuk+q12"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68BE239E6C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624513; cv=none; b=Soc7goRrldPbwjbhvssi0O1Mu0vC3oYPCDRxAifwZPHkxx7XFmzPVeyEQRG0KxjaBJMbOSysXJgxLv1V1qibbOR5M1FOSAoyvtIGfMPiKLw+1GTbPaes4K/LNoJVgKPr8FIra1FxUZ2d6lZgF/KIyvNlQuLZl0uXgirSRCIUiok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624513; c=relaxed/simple;
	bh=k3Rd2Spgfzz89r7hRtjniFD7Bv4+K6aF4f38At+Vvq8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject; b=awXtoUwzyNOsSzOsBnQr3Kr3G7GC+uqJ3G9EIjjhWl1xQGW1B4V/ClcCvmGp2I3oWWO6/Q9o8CS79gFQe38HXQAsXJ2ZGw8Sj3AEo1c8s1ScwTn2kxCW8QMkHRtcfk2XHg1PQ5F+oYt9AS59YM5+/0hUCkQV4QKBnk3xJGMCyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=viuk+q12; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b72b495aa81so202691766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 09:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1762624510; x=1763229310; darn=vger.kernel.org;
        h=subject:to:from:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k3Rd2Spgfzz89r7hRtjniFD7Bv4+K6aF4f38At+Vvq8=;
        b=viuk+q12cYzUO4OJtENxKqozl8pzSciZ5Xl7jIfwbGEi7ZtJ4YqXiM1Ez96R6Yx3/s
         ELbkhcsmHOHYTDPdfCP3ZDDKE+8KzlzGaecDru8jYhAAjMLhdJRbZ5aohu4Le3ZSMVkJ
         68OfpVCsQkwyC4uYlHspj/9D3Z3zfTT1gLMMz+7Ve1NBcXWGOFq62uxP9a8W+sHic2PB
         8lcuLC7JktlHVuo1ClfX2Rx/tdLi7hsx93ydD781upkEvLA0XNWYRt2mkJTuQpdj+hjA
         LeaD+Y2a1G0mjuonqKzXezmFcvDPYjBfK+nGosoh6s8qxYESsohBLVX29qlhm+mh/gnn
         Chjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762624510; x=1763229310;
        h=subject:to:from:message-id:date:content-transfer-encoding
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3Rd2Spgfzz89r7hRtjniFD7Bv4+K6aF4f38At+Vvq8=;
        b=kNv9ce1YI2NRddJb2RZ9d5oj3PcAgp3DixoMMn+BvZ4G0/FOu62OLYF5qrqsvrBHxM
         vJpUmsdRWk69kuUglq2q5ucFURWPgFeJiSdGBZQ0DF2stFdJvdl75Me9+sN5jL9s622n
         zddgGsP+IQfEO8YmTFkFHpObS1iGzYYjSfOKJLG4Ra+pINakYCB+vY/igMycw/6/47Zn
         3MOX+i3AMZlycJ9MOBkv/lIlH3X9VGfxJXfQoM3UuoiIUcA4cNah3bDekxJUROmuxw3S
         x/oz6EiZdCQAVKr6yaphX3xe8mx/7ZXcjnLlqI1sgVc9W+UHPAGOOq7Qsw0ZXsPKXn9v
         dMLw==
X-Forwarded-Encrypted: i=1; AJvYcCVeVsrdDC+mlTDQ89ZDdJF3wIqlVSkr6tKN0+tHo3QxjL9t/67BlhgUu8uKuKku4kw094j2eyS/UhM9a6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+dkR0FA/Rot1AvhdAr5nFm1VMLvcQwBSL3fXlOnr7rDTLgQoN
	ZsZ0c7er/5nXtHoca8fHgmh3mTaZQCGQleNzI50KR445bisMWWXvlA3gcF/ZXDEAlCo=
X-Gm-Gg: ASbGncuC9vY+9n6pZlS5TQ6sMuMHkSYpbdZ9tJu3DS3mh2AnKQ3vf3KrgZLFP/oMTne
	5+eVz+7zIO2F6wBT8+Crl9dV+H14LerMlPpI/7tAj5OHqvBP+6fDU/Yr03B+CERHZeJHBWoQch6
	5fwW+ixujUzvJQ/vi61d250L9Cl8MniGmr6PBSO3aONhhS/6yMN1xBJ8dZmdiNyqq+jnvmaXbPb
	h7OQPcIms90DtUArfflPMoqb/5/atmN2E13/Rf55MiaWZNGultRPmT5C4OdpzbhBfa7f9qZSAun
	S6et9OwL4oubRhBe1hDPt/30V7p33cnetUrOWBK8LOjzYPDBs9C2ptzuUiztzNeVQQN+2SbtZlf
	w5WAkdnKtPKI5cGEsFOeKZRb8SESb7p176EJZWrMYrYw2XZe8068dQ3iDRrXTkJZgp8ctRR7fes
	pw8zvvXbArnm/qFLfvWF5MP3sVmIubsxPtxzGx+s+6HPfea8E82G1VDSeZAt02V0UqzFOkxZ1/T
	aH5WiZGoX9uxQ9IPvsN/X3T
X-Google-Smtp-Source: AGHT+IHO/XSg1vNOl56IB1ngZ+T/41rI5MA8N+sLmeHNN0HtGXapUDDsZZNZHcSABN+1CQ4xrTQiag==
X-Received: by 2002:a17:907:5ca:b0:b4e:b7ee:deea with SMTP id a640c23a62f3a-b72e031ca37mr356826466b.27.1762624508997;
        Sat, 08 Nov 2025 09:55:08 -0800 (PST)
Received: from localhost (2001-1c00-3b8a-ea00-c4de-d39d-05f4-c77a.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:c4de:d39d:5f4:c77a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf40768fsm584216966b.23.2025.11.08.09.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 09:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 08 Nov 2025 18:55:08 +0100
Message-Id: <DE3I8OHQQD0F.2VTQS2PET9MI0@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Documentation of iio_read_channel_processed return value
X-Mailer: aerc 0.21.0-0-g5549850facc2

Hi all,

I've noticed that the docstring in include/linux/iio/consumer.h for
iio_read_channel_processed (and likely some other functions in there) is
wrong because it's saying "Returns an error code or 0." while often it's
returning e.g. IIO_VAL_INT. In some code paths it's actually returning 0
but it seems in standard cases it's not.

Could the docstring please be updated so this is clear to users of this
function? I don't understand IIO well enough to confidently propose
changes there myself.

Thanks and kind regards
Luca

