Return-Path: <linux-kernel+bounces-836335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8FBA95E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25551920FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DCD21C167;
	Mon, 29 Sep 2025 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzKy2w11"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B019066D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153080; cv=none; b=XbYkjBep+O4pAuXoiPPfyuPdY/NdIyQxIQdYLYBTDLK3A6LtE5ikI7EOudFQqltZ177jVQrO/RRhYORywIslzke0K5jlsG7wPDgHpcgC/yNdVVCEu9RE0NjzqxwfazF7crvydbJ8vqIJBhn+U9h/FOlQgrgJCDhnRDdTUmcXMic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153080; c=relaxed/simple;
	bh=FY1LjOpDLpksUSLmXGZUKzGIe9ouVn1mPmzbxhAS2n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0loptWupNQCx38nzEOFwPjJYZEhSL6KsWtgTVqoBWJOatcPqlvZFrKAqE8WwpDw0km2yE9iYUJT342sAkHT0qMyA4aw3SR0T50KQ+q4jlIGVZxLY4Fq7ALSqjEYhM7ZbkQFXVVVbeS7w3Fpm2b27Vzk6G9sCiuEQv9zgqM9uGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzKy2w11; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-279e2554c8fso48192195ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759153078; x=1759757878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OXzHidEDJyzmTDhhwCWrD5gyTm2wXdwOJ8l86bMR2yA=;
        b=EzKy2w11DZBdf8gqS0groFj2FauR0sR2+6P/SoYDYidj7ka533uWVnRkpPiw/+hRud
         Tb8YCbjJepoyFXxLnvJX3l61lIu4S0LTDo0xyJzSdMRZrAk60cZjsze+6rNt2cXszcfy
         7qL+MDIz782x7YoKkJpDabKOYqKFUQwhJPD9jf7t5+CzONCzGjBUcq/orD21y77npJ2l
         GqrQJls38pd00U0fIQeaywmok3HLzRkZQjOGsl79JKqJAop5h2ZtWNg+8Aa4eSUHmb08
         nwRvD55pQMxLVSL8Kb3IIpwKlAYdyvXF/8FyPhLEpTjarVtPvNJnx5Ymri5FpkSS71Zj
         6ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759153078; x=1759757878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXzHidEDJyzmTDhhwCWrD5gyTm2wXdwOJ8l86bMR2yA=;
        b=DeZSXzcBx4fBolP+VSGMfIrXMtbalcv14w4O+YN0mHDY+ciPMKxkFgG8N6s6kSIbgv
         ITwSKo3K+p15oLEuxqy/85IG9QQ3WqjRw1YqO+aiYlLgyeziHmJ4o31A6GW5ztK5bnx5
         K5miy9os/5wQKVIUQb+VVtypfr1nKttmKaz363ZMBj1vUIZ1RcN3l8kssLckkRB7wRQM
         /zVzb8hNMd+nVn/y4t2ks4Gj5Dt3Xbf9Aazx5w+ftV5Bvn3Yn0ZqmLrarGKzi+uxUtMI
         Zi3PgDL1VLBEol1jlung5PBHJKz5AtMcN5XZZWxJcbZRJHZBTayQHhW5PkXJzcd9n2s1
         p2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVKlwXKCYXRPwLYcjojUzBVVU5KRFPV+TkD1RuXinV3p2gA+/ALuKClk0qssqK9RVE8VFOmoPaGcUXFgHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5F8aHOixPvgFLYS+W5r9pXLGvGj/HKEl1nBS7LwyN5qOlkBG9
	mokAKYEHNPf04E3UC5x1/jNeM8n6KsSTUMIBqUYafB6pNGILeMNKpwMe
X-Gm-Gg: ASbGnct/WX+dUwc5cyqzr84lW3cwcS77u8k/kxYXgOaqZ6IhYIjSpOG8fcvrAt4xOvy
	N5Dh9oZ6prk9vpfBSlr7Dwo+faqnuMADZV5t6rjTE5V7/WZn9ckzKEofFQjxNGSe1fD/C3jwa1V
	pOGTYWyhk85/Zm8BsksSXd6wTOcesGHF2KZk5VaUeR0YLfCSAzAt8qJpYjn2D7SF/I24FPx7kPp
	2pJ8ogx8hyqtHYXK+fUoiFZ0hLuUhzpwKJR1J5WBfGydK3GjXaWKBDrrnF9qA9DFTsNclOYqrgk
	CRQRxHnb1MmgNhYF5FzMvrqK7jXGDD/y9IqqMqItwZsDM1Bk0nFGWzemLkx9X/Azk2KlguBUqHc
	6xNPdSlz7nhq/g6wB+i5ZLM9b9HiV
X-Google-Smtp-Source: AGHT+IH4R/GxdVbMosbKSLCpbqs8Cb8AEuNL0zYMxkhHdazFExlSy3pz64QZN8YVF5/yYX8seCi2Iw==
X-Received: by 2002:a17:903:3c6f:b0:286:d3c5:4d11 with SMTP id d9443c01a7336-286d3c554b6mr71165805ad.17.1759153077780;
        Mon, 29 Sep 2025 06:37:57 -0700 (PDT)
Received: from y740.local ([2401:4900:1f30:25ff:36cb:10ee:ba03:839f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm133290095ad.49.2025.09.29.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 06:37:57 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	zhujun2@cmss.chinamobile.com,
	kuninori.morimoto.gx@renesas.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC]sound:usb:mixer.c: Solving 'Generic AB13X USB Audio' Unlikely volume range.
Date: Mon, 29 Sep 2025 19:07:52 +0530
Message-ID: <20250929133752.31847-1-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Maintainers,
I am using a generic "boat" make earphones, which are too loud across
different systems with eg: iOS, macOS, Debian Linux. And hence I believe
the issue is not with a driver but the headphones.

After connecting this device to laptop I get the following in dmesg logs:
	usb 1-5: New USB device found, idVendor=001f, idProduct=0b21, bcdDevice= 1.00
	usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
	usb 1-5: Product: AB13X USB Audio
	usb 1-5: Manufacturer: Generic
	usb 1-5: SerialNumber: 20210726905926
	usb 1-5: Warning! Unlikely big volume range (=11520), cval->res is probably wrong.
	usb 1-5: [2] FU [PCM Playback Volume] ch = 2, val = -11520/0/1
	usb 1-5: Warning! Unlikely big volume range (=8191), cval->res is probably wrong.
	usb 1-5: [5] FU [Mic Capture Volume] ch = 1, val = 0/8191/1

By using pavucontrol, I am able to get fair sound, after reducing 17dB in
Analog Stereo Output and reducing 6dB in Digital Stereo Output.

I believe this issue could be solved by adding a quirk patch to
sound/usb/mixer.c:1096 (/* volume control quriks */).


BR,
Sidharth Seela

