Return-Path: <linux-kernel+bounces-822956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC35DB85225
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6395B7BDBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEB230F95A;
	Thu, 18 Sep 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3m9zWCDd"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BB30F944
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204502; cv=none; b=j+xOiJQNEdrtz+X39N8oK/EqOZVlxi39qvqLCshOVnMsIbY+M5mAveecduzDRmLGs6A8gHbSPYYJ6vXJ272QGKMqLswUQQsqhP6kCInDh0yu09pFmCYdm2kXOWp5UBu/v9YtoQac8/t81OVaV8kj2Jzn5aCz1dBnkmZvYVpxOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204502; c=relaxed/simple;
	bh=YSGrtfzAbZPKJsMm6ZbeS2bMB7Oz2V5ev45q3M2vX3k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IDvgJeQeob1Kj9r4sl9B4fJij8eb2blbc8dkjau0G1YJVfuo3JFjaBQ5wiWo3D9kYu4m8eBDXphcO+2uW/yCD/GCIIy4Z2/j2fq29pYrszG5Bu6ND92qjdfwz7ttScQoO8GGNZNtPHDlj65z7lpqIOmOoqNxEKG0q8CxPuVnlJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3m9zWCDd; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45f2c1556aeso3821765e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204499; x=1758809299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zX8hRmCAzatzTP7W5f8Y/6xpy5/2V7FwxYbZWinrYv8=;
        b=3m9zWCDdNqei8iEGscLSElHMnjjZ7ASn4QkqESbQuSfiq4UZqwUDEpB/PIxi4tzBEE
         L9W559vgjR4op8ZtPjGUpgv/E+NbWcgEBG6Z+c9T4HOrpZBHYvc02yg/32BIPCcsy+mJ
         4veBJCevj1Nw7t/VKXHAKMEaM18UfQKKDOC8GJrJJc4+7z19DDkrDHcTDo4ON3J9CIfA
         OLzAfYqpSG1B9uXL5cIxp/qqa3FHHQBxyTVyjIMFunmrPcoIK/vd3+b7p9OA+RvAqPaE
         Gv2qZ6u2gyP9FzU3D7csPhL3Z4Be9njwkkb/UaT4PrLR/wyY5YaJECmmqcwZruhWGIUf
         SVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204499; x=1758809299;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX8hRmCAzatzTP7W5f8Y/6xpy5/2V7FwxYbZWinrYv8=;
        b=UQCCqSebkCpM/fNkpM4hBfp/8igT1SdusYdfHd3lgnjjighhPMT3MEqJCFD6m1lzTp
         pDG8xDpL6nGOuQiPUzDBaFzLJaye86+tLefaQU0H1RAhBndGtvtYftPxDgGXwjcIvdC8
         GJzsMhwhXILBAOPMVPTblDbNUBStsrgXUYCXJzyWKIIUAUuw9hXCzHw+jGB5fM179iJy
         jiqNG/yjep5xJI2SywG1NVeCf/PERqEBhqHoNSWzxYgiQ7ZGs8XUrqBIu3NBlWfqL45I
         EoYelWH0fQob5QzfXQLY4D8VDc7l0OQ382/6pvB1WWLgwbCQrskrKPWEh14ahkh5Fl0r
         OP1g==
X-Forwarded-Encrypted: i=1; AJvYcCUiHV1R9vr9iTRE6nXQoWr9xrhfLylJPmGiYbS21RzkAQbk8i19x36Nzlg7XWsxlknLLMLfjsHHSi56rLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZLFn6oOVGLG/KmEU5mgh1WAW4AqEYpi9cV41ldf/Ht61QAQ2
	PSCXw9a3ukN7XVVoJG9GZ47qrLxvE4JMbz9lCopB8r0ljaU18xsIfYOeV+qdupvDetIwoI98hwx
	AbhXcJ6i5WA==
X-Google-Smtp-Source: AGHT+IF1RQGSRNYZqdScgFD6eUa92ab9fa9/BqynjtzBd+gLQZAlGCMW8rWJZNptgVbcM6q8cADYm4uMJB3v
X-Received: from wmbdp7.prod.google.com ([2002:a05:600c:6487:b0:45b:9acb:6940])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:470f:b0:45b:615c:cd2
 with SMTP id 5b1f17b1804b1-46201f8a4b9mr68058415e9.8.1758204499266; Thu, 18
 Sep 2025 07:08:19 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:08:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918140816.335916-1-abarnas@google.com>
Subject: [PATCH 0/2] powerpc: pseries: making bus_type structures const
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Current driver core properly handle constant bus_type structures.
Both changes are moving bus_type structures to be constant.
It is a part of tree clean-up from non const bus_type structures

Adrian Barna=C5=9B (2):
  powerpc: pseries: make suspend_subsys const
  powerpc: pseries: make cmm_subsys const

 arch/powerpc/platforms/pseries/cmm.c     | 2 +-
 arch/powerpc/platforms/pseries/suspend.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--=20
2.51.0.470.ga7dc726c21-goog


