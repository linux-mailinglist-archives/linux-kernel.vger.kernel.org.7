Return-Path: <linux-kernel+bounces-884070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A29C2F4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8C084F1BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A52C11C6;
	Tue,  4 Nov 2025 04:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+d1io8z"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF226F2AC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 04:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229919; cv=none; b=heXKXKu5N0+GmIa0ms004TYIROmEL6akbbRkQLJH6B+Drbi5tnzzZB2tQtj/J9YDGFoCqVpmrGQ6emDtTW4gSmZO01FqrlKtDahpHcYLIvI6SpCdHKISM7rsfYsA6AcW9UBqtZX7hTZ7zCgh1mvMug+Cd8EUiMtVlt6+BX+Unj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229919; c=relaxed/simple;
	bh=d3rqa1ult8IYHT+pOGDFjb+rtGvu3JZ7+RJtjJ/9aO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1IrzEwxJS8/jU0EZxuV+fmSnvwrcDse5+jbXkSKwqagIPIV8l3jaInZ1l3VtiGzXI3LElH0Y+P2nBRLxspYdDuD2de1GKlhr48Ao90xDuZm/QZa4c4ySp1J2+zWThibExPcqqEGI5dw8dOxeQxzExdntO+i/WANHTYQ7XgYcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+d1io8z; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so4696149a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 20:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762229916; x=1762834716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOEzRCysEL4x+FuysJWqjlh6gSnAH1oKrrtDPG6N4YE=;
        b=S+d1io8z+VGlkDeOegFeVZZ+VZDSYEhBGAmURVgfAjKGhkOWFS9Fdn4i79Cc0uWjm6
         /V3hUua4Ewz+gx3gO77HjdVfvPEcUdSt17+U3bHHMB6sIdBf3BBgQmNZfihPDDqra+RV
         ZxUTwqmyjM91AhrTCWP+30mEs/9K68y5fJQARu40ki6E9FWAUYUlbRghI881fQhEvY1U
         KQZMwa3sIBlqdVVhOzPVizzUjgQvPtASAJuPfy1rHkYTL9xm9+z/QjhrF8AXa16FxQ3y
         Gz00tP9yDZjaymFS8nxYnhLVUGrkm4E4Snd+JB/cH3LRLm0GGFI7u0yKipNnSS4396Dl
         v5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762229916; x=1762834716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOEzRCysEL4x+FuysJWqjlh6gSnAH1oKrrtDPG6N4YE=;
        b=kO3+i80/8AR1up5EiFgIxiHWkJOozZkP5jhillG8qAczLc6v9JFhGl/z+MWrj/Zzhz
         gB9LydBooHNf6zF2ZRGzkUbQBKPAyoF018u86H1dS0fTc3vQFTPF465Ytm2QxOuqVJMS
         /YxbhBHRm1kG4BjhZnBfnpp68qJ991RuMcLdXBSNe6Ut2BF/jiA8XkbDg2SQQ6SNgNXE
         VlEgG7AvH1OLdA7uMKFd5a1s+XlV3WsouL6bS/hRkpmVUa9ibcji4mZgSorVAgL43AmI
         IF+jDGv+fhH87dW5RftEFVz4ETjt0txaTtzyXuc1OW+jjljooiWR5si3xSuJMju1VI8C
         QZaQ==
X-Gm-Message-State: AOJu0YyOpnBbqai+Zogli7bn1uyk4K7oOG8dw/IprYVN/vN58ZhQs4eq
	98tNF28A3Txtlhj85GKyuftXfWZabVhht1fVcIpbc38277v3+gQiWZln
X-Gm-Gg: ASbGncsItmIN+/KvsZPmE5mRwIymPBBN5H/D2058MBeC3X5Z9GdXtmrgTwmN++uAdYm
	xGHZXK24cXmEamfzIDchP/tyY/MXYzKE8XeEkqWaWelXac5VTjx8YccyD+HsaMu/XxrV1Sbuse8
	Sdwrrefo0ouiwfT75BuzrsyO4eWwGVEad8GIJ1W7HEhWra0l3f2ILI8W57j7kbS8A9tIq7I4P8J
	LkGdBms6aAJ7X1YEXsAPIcL1/jH0UGQ3UJvIhZViskTF/vvJKFck5d1wB+natGApJnxFVZWnh4F
	Fvp3E7zoFaG6afDgq30ALXzzWpKc172LIFyh5ChRupkNGOfuhGMvDphQIMKsOPtGLSfLiFPaJIN
	lyZ3640j4F+THOphMmKX6rQu+wWqc7dH7n8SpkkitffLKsYpBiIfxjQ63SgYq0Eh8HYbCXLcNJS
	hZDqzYyeRPayY=
X-Google-Smtp-Source: AGHT+IF2gVVXIyi2y6ccvDeSRxF3EKmw6lJ5/T5UH+EEDwxXUqwmRvEoqwHDHQlOaSYlJWAumbaTNQ==
X-Received: by 2002:a17:90b:584b:b0:340:b152:efe7 with SMTP id 98e67ed59e1d1-340b152f234mr16472957a91.11.1762229916164;
        Mon, 03 Nov 2025 20:18:36 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f1831141sm801807a12.4.2025.11.03.20.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 20:18:33 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 604F2420A6B9; Tue, 04 Nov 2025 11:18:21 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Akshay Gupta <akshay.gupta@amd.com>,
	Srujana Challa <schalla@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Julien Panis <jpanis@baylibre.com>
Subject: [PATCH 0/3] misc devices formatting devices
Date: Tue,  4 Nov 2025 11:18:09 +0700
Message-ID: <20251104041812.31402-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=bagasdotme@gmail.com; h=from:subject; bh=d3rqa1ult8IYHT+pOGDFjb+rtGvu3JZ7+RJtjJ/9aO8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmcNb/CZvCyubx5d//cMt2783eYzI/Qblobc6stu3OD8 5f/+w8Ld5SyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAid3kZGQ6vite/Ua5+KCX/ vqOdi/H0KXIncm+IT0radLnX4YJu2WZGhve9z2ZfiPr1VzflO5Ns68dKv2sbXQM/LGL/zcvA/uD uOw4A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here is a small docs formatting cleanup for assorted miscellaneous devices.
Patches [2-3/3] are split from my previous macro references fixup patch [1].

Enjoy!

[1]: https://lore.kernel.org/linux-doc/20251104022242.19224-1-bagasdotme@gmail.com/

Bagas Sanjaya (3):
  Documentation: amd-sbi: Wrap miscdevice listing snippet in literal
    code block
  Documentation: mrvl-cn10k-dpi: Fix macro cross-reference syntax
  Documentation: tps6594-pfsm: Fix macro cross-reference syntax

 Documentation/misc-devices/amd-sbi.rst        |  6 ++++--
 Documentation/misc-devices/mrvl_cn10k_dpi.rst |  4 ++--
 Documentation/misc-devices/tps6594-pfsm.rst   | 12 ++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)


base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f
-- 
An old man doll... just what I always wanted! - Clara


