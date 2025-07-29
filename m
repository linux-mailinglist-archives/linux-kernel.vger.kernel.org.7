Return-Path: <linux-kernel+bounces-749168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DCCB14AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7743A8654
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A721E0B2;
	Tue, 29 Jul 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YduF7GV+"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76670264A60;
	Tue, 29 Jul 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780438; cv=none; b=alaObczaezffRAREta67H63fwGM907bZLjGbq3MEw+9XsGr8BXDZE1LWsu2R/JWlXPdn9HYhCwCELEOc7pirQq//ahPbqoAz+iXA4+Xldt/0XuvAmwS5sgahNxf8wybWUnVVgWwwxY6yuzXE6GnNbByGYqdIqhHrHXOGDNBX4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780438; c=relaxed/simple;
	bh=H0NQBYVHTmZzarqDz2wS/1YJiTdprgg2acyD5u6hl2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RMOOXjiDThzJn2f7pyysjIrT43sfxvJLaXLFkgglIbJUdfumtp/FPnMqwnUFaO0W5S+9qbtoXkS7CL1YIe2a/Mi96J8Io6atitQfqG3HOSgYWLiTNwp1vyO+dpdBDqDHEfBvJOyPobH7kQUdrn7ha1LXJ/edkJaPZsDUFSlcFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YduF7GV+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7682560a2f2so859758b3a.1;
        Tue, 29 Jul 2025 02:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780436; x=1754385236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQyxRL212NH2CE2dAFaZIS3vSFyJbqnMjH8EoS/AicY=;
        b=YduF7GV+0UCRFtaeUfW5gknFN3BAbHW9MFC59IQVVVjJKRVErhOE0RFHLbKrqNErPn
         JNOKfnym0PjTP97luM3S6I4bZsfh9GxCK3Fa/CCVPuoxzOleofH8aL179bLbmGOHq3bi
         9+wnsgaIUtydgqEQk0KFa0nN9PXCf85+Y8UP9s0eVYGhym3U3JzZn5uBGuSfw5F712CT
         4JHt/Si7+MJdalKVjHqA6+3UQN0vNvdkYu3u7sw0mxP5O56jHa2N7fVBjL1JIzSEkVKq
         rd+dmccBZf4hAoF23PlFqz01O0zD5Banqi3X48omZz3pKtZlN6VhVY64jKO1IkZzUT4Z
         /zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780436; x=1754385236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQyxRL212NH2CE2dAFaZIS3vSFyJbqnMjH8EoS/AicY=;
        b=YIRAXMIrJ17afsbcv750xp2WililgexJK1eZq05cyu8jUSbA7b07WINB1w/cSNP6Pq
         gdXAnv0TKJwpSPfvDZIXLWlpcKUdc7JY9IbSP1a9v2Eahfq6cOhH1b8STBxHIoSuXCkn
         Au4e23WWxXPPrH9flZcGy8I1Dy3BOLuqfmcycUl1MHpqpHxXaShdGU7b8ElYg0mzrYKH
         1t4gXsO17jrqK5Hk2RtmAVe0Gs5j8mR4FM6mP56WsZ9NdGVLO1D0e2yVUcBEE9MO8Yj3
         hxSSuDketGLrhTbjNYSDYQcQ3rUmdhJv9/8aVSxhl5Gz2E/UPabSf3zSSeGe3zJ8XTHr
         7KTw==
X-Forwarded-Encrypted: i=1; AJvYcCWrmhDMB/KUs5fedmU7R8Aey155goLy1LcJIUnYfRRkeBLKVt1ewiX9U8rwYRp8l/AGzINXrkvp2h5B@vger.kernel.org, AJvYcCXrQ7YefE7leLnZxRx1WOfAMQByDBky3iVdqO+saXcnKvzBz4lLBn6ofzqQ0OMqC/lYwke1ddXRVTcGGf34@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0eydGsskaJeqQfAQIQ7GQLNFWtaLACFU4XHoh7x54eHQfJzR
	1b7sbYUjNbeKR2/6SA2aKsHAFP5X58eXpLjql+tiEToHHj02Jz4f6C15
X-Gm-Gg: ASbGncsTmeezOZyePQHtr4ckgg1R8nHYyBecOLAt9Ek0ETsMtXc445OmClmggYSiUNi
	4wLC/YrL4AllcquNh9n4O7TpQP7Wvt9PrnttNiDj8Mxa5gSKIFFZJt1fE+exF4Xitl7fo/w/QaX
	k5Hnsy7/NEz0BOja6gqLkF3EEn2V8e42mcF/8uwLfeB4MnJhurZrvEB8ve32LEnu4QkWj8l9OWv
	DGl1ww8tv91aHJ/gTXu0FdwpZs+/+xDnsxbxMmvWnbs/rCe0PDHtfNM/hR8POGHPrU+EGvANhRe
	D6Tw3du/fRYPRVbdICg2rAWJv8BYk2DorFjTRPzAdrLDE36c8uAbm+sjwuuHrmPxTFkiA4rlaKF
	0Ca+RpT0mK0pOrQG2mJq1JAtfNYexrz0f/8ZG1HiwUHwaXzYP2Xn/7aUfkNwWRflFFDnli4aI8k
	9hm9Q+NVquBSh+d4PyPz09R1WjQaRGGKgUCQHhqta88qawPD49956+tSl1Pw==
X-Google-Smtp-Source: AGHT+IEF+2Zavb47/riBr9cIbA+jDv2YfAkypoAz4HCbP7aW46kup2+kr9hS5IwmTEmyf3wzvvaWQg==
X-Received: by 2002:a05:6a00:759a:b0:748:e2d8:100d with SMTP id d2e1a72fcca58-76967298756mr3498076b3a.8.1753780435773;
        Tue, 29 Jul 2025 02:13:55 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e38d-c586-0429-5c72-053d-8858.emome-ip6.hinet.net. [2001:b400:e38d:c586:429:5c72:53d:8858])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b06ddsm7528612b3a.121.2025.07.29.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:13:55 -0700 (PDT)
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
Subject: [PATCH v1 0/3] Revise Meta Santabarbara devicetree
Date: Tue, 29 Jul 2025 17:13:42 +0800
Message-ID: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
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
- add sensor nodes for extension board
- add mctp node for NIC
- adjust LED configuration
Base on branch for-next

Fred Chen (3):
  ARM: dts: aspeed: santabarbara: add sensor support for extension
    boards
  ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
  ARM: dts: aspeed: santabarbara: Adjust LED configuration

 .../aspeed-bmc-facebook-santabarbara.dts      | 840 +++++++++++++++++-
 1 file changed, 839 insertions(+), 1 deletion(-)

-- 
2.49.0


