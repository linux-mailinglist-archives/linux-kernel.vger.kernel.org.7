Return-Path: <linux-kernel+bounces-737584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259EAB0AE0E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 06:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52A71AA76BC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 04:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C4C21CC60;
	Sat, 19 Jul 2025 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6HLIgMI"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C9204C0C
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 04:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752900702; cv=none; b=ndv40DzLkglYPts2Cafi8gsmVosVGWps+55+0smZ5j4vBcoe/hSPnE0VRkLYywzDU55QlVhFnGCTetozfV1cuZY6vvymW2bH6S80M/1C2Y2nK5BRwRadSWe7zziMRf0m8RKRoKPV5RUfLipyu/0jBHvh1IT3epWprtBUO4KiRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752900702; c=relaxed/simple;
	bh=7rgnlLdpFe5nY8I60iwhOJeZZ3aZTftVrF7D17fx2Ho=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rA5BF2D4EyyqPIJ1Es2fotIx+HOggeKb8vkeqlPvDHQcDsBeglg3UM0oH2CB/VQnFutKi3rcnhahzDENXaCYzRRX6rppqZLqKunaxJwPwfFa78urE1JxspPJBidYWNzpFAjFXUDTZInN4Dl3A0HXMeyvY1VKPYU/CeIjq8/oqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6HLIgMI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e346ab52e9so346988385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752900700; x=1753505500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHEnmYIM+SeFjlhJdqgVG2IthJkOPKza0M12Y4tm9Hs=;
        b=T6HLIgMIpmFP26aO4AWNBP4pMPzn6wicQaHj8rOrCjPLaWARs5LKY7cEpfMLZSSsuI
         Wp2+Py79qNaMEXK1RPDIRoEDFVUuR3qMTeX4pxDcxM6VAGF/n8+o6O3rhX2CpyiJB2xG
         Y5144ElZ1+/PVpj5QKQeXRB27CDc2KT+9RtvIWSY2sVDtb+03Ng5RmGcXk5LmTViFerP
         qO9uEBVm2vNE+A0XCvrIFlMjTMvJ7TCUSqZbXqBWeAFgpcdz6Sx2ZXglUq7ZRTxUaYrB
         BZM43OblbNMx1e7XFP6BImiO/O+d1sZPZ+usQ5h/NfRgxVKW2pbMVeIuhqOaCHr08qSk
         nzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752900700; x=1753505500;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHEnmYIM+SeFjlhJdqgVG2IthJkOPKza0M12Y4tm9Hs=;
        b=AI2ntR5CBewMyibaxZTIf5Kkgzqw8CA0S158ysX7LdT8Ku5Ol82EeXF6w+J0o2Ncu7
         t8Q4nUIkPAk6D2Hv4sf0Xs0mftaNbGWz7mO69eujo4l5/JkXLIXGZw9dXYEvRywPck0I
         7yF8+ROx5F/p5rq539S0ADjMZGr4rSkusDGnUlbWtIlRzYStxybIuCtuJVPmbYYNxWNJ
         Bw8zANXkFijOHgkHkSXNKxEe5T3FTfpT7xBpRQXNoYYiWMqJnuLhG7DSAT3XysdgUdIs
         TvEi3UppoYfMYUy+D1P9KKwJy4yg+Miwei1g3D0B/jngnQWCoICzQ51M735ZUVUC+Wcu
         mRxg==
X-Forwarded-Encrypted: i=1; AJvYcCXBRFj0GL9eGzNadCWl4w9XNj9ODO4gN6DuslKYljgIsIRzMZQgTfj2pTwhmTHes2muBFk8Yy4AgLf+eUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70H5/2lrC8E0X4nnjze31J024O0jFE80rTf4pVNKYl4h+slfE
	PBQQ0HOJz+8P41kx/tvpMyUgQ4FCHNvQc4tQO7EWH28YRw5JjmtkBM3N
X-Gm-Gg: ASbGnctWjIT+t5L/Z6eeQUKKUG86HoBEDyxIAqOwi63EielrYpHVF6RaclwqLH0m2Pz
	s2Qrc93e0I9r5eUwbZP/ga6JbBCrRjiID9O0TRo7O+6pl7HhvOQgxV548eIKtstgkwquxVj7Bg5
	Ean2SpMcO6Ccjiit3twJOFJKo37WuEf9HU/mAxXzNOBvsWxd6mJJWHwLmU8UEyXvyg4GAYy1FNv
	iOZFiVntipbZkMWK6V1cMuisUF2TEyPfZoLYp1Tuo3yGzf6Od+myANgxUIsUicAmzEhn11ADLfR
	PG2GkagRc7y3HKu2aFTvvGhOA9ZcPM4X4blwdjSJqMIoLSaEvW1wCJH1XR0xuhZVclAqMF+tvBK
	TQgPB0HqbIsZ/6w==
X-Google-Smtp-Source: AGHT+IF/cGGeWlAl9b+X3J2/Tkj/l9nfGEABT0CMN+K1g1dkZaC1a29+U/VuKbOkr3f8bmDABEbFKg==
X-Received: by 2002:a05:620a:2985:b0:7e3:2ec5:69e2 with SMTP id af79cd13be357-7e3435e9345mr1730622885a.28.1752900699939;
        Fri, 18 Jul 2025 21:51:39 -0700 (PDT)
Received: from pc ([196.235.158.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b2c850sm169899785a.6.2025.07.18.21.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 21:51:39 -0700 (PDT)
Date: Sat, 19 Jul 2025 05:51:36 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] char: xillybus: Replace deprecated MSI API
Message-ID: <aHskWESzZdyBFj4x@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d3513e3-6294-b6df-189a-cc3bee76f0a3@outbound.gmail.com>

Replace deprecated pci_enable_msi() with pci_alloc_irq_vectors().

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v4:
   - Drop devm_add_action() since it is useless

Changes in v3:
    - Some checkpatch cleanups

Changes in v2:
    - Replace PCI_IRQ_ALL_TYPES with PCI_IRQ_MSI
    - Delete pci_free_irq_vectors(pdev) in remove function
    - Add devm action that calls pci_free_irq_vectors(pdev)

 drivers/char/xillybus/xillybus_pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index 9858711e3e79..c8b4cdfe695a 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -76,7 +76,8 @@ static int xilly_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	/* Set up a single MSI interrupt */
-	if (pci_enable_msi(pdev)) {
+	rc = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+	if (rc < 0) {
 		dev_err(endpoint->dev,
 			"Failed to enable MSI interrupts. Aborting.\n");
 		return -ENODEV;
-- 
2.43.0


