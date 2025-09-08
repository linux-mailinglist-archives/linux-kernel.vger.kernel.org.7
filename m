Return-Path: <linux-kernel+bounces-805270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C25B48645
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A2F3A7E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571D2E7621;
	Mon,  8 Sep 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIPbsx4l"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A533AD23;
	Mon,  8 Sep 2025 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318547; cv=none; b=RipNaAdaBZm6+8cwKtOLjyvGss009a9gHDgJZi9uHUYWoUkBTwcv7ACKxpKCR4va6DkV63h8cjlEwIjn+DDaTio6R214b/RtkojOaafO2AjIscKPNmzevIN/jp0zFBebZoYexSZbtNnwPamzQTNui0MJyZ4hNfxaxZUwVxPBl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318547; c=relaxed/simple;
	bh=qP4jzX/zYUAju3m1CNLRymmZ6661Elv/SLU8GIOqrow=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PTVZI2UgMg5ph+9kCK0iRvr8QJ2VqXbv+Hc2Zy1KR3MoYaJfGhPjAHgNk5lVgsU13Z/h99XeVl8evMSzwisy9CDNoPwheJNyhXSEAG4RoQwE3Y5lPWo1k9hJt91Al+aXuJgWDE4kT5ytu8yN2EbO2h4lvmBy3YfF/mccUEj969g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIPbsx4l; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b522fbe3088so510389a12.1;
        Mon, 08 Sep 2025 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757318545; x=1757923345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GK9tSWxCSwHclhCGlVejFXBQ2aFQkr+nMXMBqRXK58=;
        b=bIPbsx4l9w3nfZqmbzXlJANJPEx2bIIAWv9DWqcGoeNfkTCqkynYoqIeEWChlQN57j
         YsTCMrhMkyp6hvhHLfb8/aA28cDPI8RqH6H6FYAn3cVRiZN1wiWqwyQjEFPBlewtGFUp
         qv83fnyAc50VJXZ0/ecPJqFQ4K5TEOIg40xl/QsVsFaak8M6wD8XzuHMJ7lw6DRA3HRx
         oMy2071MsF2Z3tpCtoPMofFGzMdOES6CI29wlHr1jk8gLK9N5zmWfr1zcdz1snXqAxzY
         QLWh9H4LrU+ArCtg2L9Xj7AYXEuxWcW3hQLDcLT0vR2+gpJT1+S92i5AczwxZa4C24NF
         8lJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318545; x=1757923345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GK9tSWxCSwHclhCGlVejFXBQ2aFQkr+nMXMBqRXK58=;
        b=IaTYQkr+XYdOLJxJuGBvlnKr9u2GJCg8OzkzPIhH1Qex7ivJkLQdMOOt92Uaa+mgD/
         Br8aQ/C8toAkcwmXgWMD0UzLuLYzbthDh67Dw+xsth6TvXFfytJj1SyIs1nAVHGHap7A
         epZw+R3gpzcb4R0XqPubZlgKSzUM9bZhAGL52GlEg6u9bsmRMdEHJKxBN36qMvdIAKQl
         DetAqqrBgQpBFi2DcNMSkI12ySzIf5GQTB0w8MGuK59EFurYa3Q8rxazdsBtj6Nb74ei
         ZlSOzduMkD7BaLNaG8T2Z34eLbsEeCncIUUcBB8uBibjItWgJ2v1fGyFgjL3BOEre4D6
         Y8xg==
X-Forwarded-Encrypted: i=1; AJvYcCUgcLTy+bTVC7fP+aRfjMVD6KxutBaI0HXnB6+s103md8R9BahBzIKAbZhjOXb7J6ojoHB0sTTt7jFdQ6Gv@vger.kernel.org, AJvYcCWEhhsWuz27wOpnl2029jHYEs7RikaSyY+BPqgWErF6q6bOfS1IGqZ9LKCi+A2tvAe9n7npIRNTUNF8@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhRU01Bvl63CYu22Wm21vzoTz6vyGbymnXPjD1rUBtMxVqv8/
	+tNPytNAppXrsG0+f+S05m4U74wEZ7dH58Gqnvh5oY8q++kYv/h0E55e
X-Gm-Gg: ASbGnctIYbQFMCo68ykkKKA7NSJlQW7E/hdz/cUqYshju2MkzFFUdE58FfWIpOUDDOK
	HLYyL+XlXk0pqFPY8RjIjha26dQcQRe40a7SYaFnYp7HaQ3gIemE+QrDQQijEa+8LMp4nNyhShs
	CmZjG0I6CVMWdko31ej6pp/IH80+4OqzdW6lDanOa43T0qoeZlRyxANT94SQBio9/hacHJtIfMd
	vzc4kcNZUKcWOiAGCdoUyx1Bw+iK7PXUX9Y8lrTLgttJ/i2ObSzb5P2CO9dlDdngUNQ5NxLfwbu
	/O98gcpj0i2qPcYy5aU6COa/zRi+cQJSCKCgZf3KubTQ397jnUigeu18U/TYxnQmAi9R5FrORBJ
	WC1Bm3AcdFptwLqp2Qpysl5JDTHl6/V83F9QEwlGRQ30vdRyUOSvHaBTn9AyGItswJocxdoR5uW
	9tsG8Tvl33FYtnn1rb1BBXtnVNY6N1Dje2dKUCr4SNUqspFpUczuHjlH69PwEWJIcKJB4xERo7c
	YJvSg==
X-Google-Smtp-Source: AGHT+IHllvq11IvDLajj8xHW5uT3UeRGLK1mFDGxqYTfZLrLjLfh/epSzbZCpYMmk4Nyq0zjxJyr+g==
X-Received: by 2002:a17:90b:3c44:b0:32b:6223:262 with SMTP id 98e67ed59e1d1-32bbcb945aemr14341441a91.3.1757318545276;
        Mon, 08 Sep 2025 01:02:25 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm15186600b3a.9.2025.09.08.01.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:02:24 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Revise Meta Santabarbara devicetree
Date: Mon,  8 Sep 2025 16:02:11 +0800
Message-ID: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta (Facebook) Santabarbara.

Change log
v2 -> v3:
  - remove mctp node label
v1 -> v2:
  - add 'bmc_ready_noled' LED and update commit message
  - add sgpio line name for leak detection
v1:
  - add sensor nodes for extension board
  - add mctp node for NIC
  - adjust LED configuration

Fred Chen (4):
  ARM: dts: aspeed: santabarbara: add sensor support for extension
    boards
  ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
  ARM: dts: aspeed: santabarbara: Adjust LED configuration
  ARM: dts: aspeed: santabarbara: add sgpio line name for leak detection

 .../aspeed-bmc-facebook-santabarbara.dts      | 856 +++++++++++++++++-
 1 file changed, 852 insertions(+), 4 deletions(-)

-- 
2.49.0


