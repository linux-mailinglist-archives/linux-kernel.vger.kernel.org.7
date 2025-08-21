Return-Path: <linux-kernel+bounces-779615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B686DB2F651
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57ADE1C2107F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2252E2253A1;
	Thu, 21 Aug 2025 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="emOzK0LT"
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A92BD01B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775004; cv=none; b=nzfTugzVtgwNyb1wJf4ppkt02n7Np45+cdZbuOXlRciaUrpu06gb36cBoCdytf3JeZ1noKn7oJl/B+OTpiCJRApmUnYACG8ssCzaCXtOvO5izeBRydCu+3OabJ0ekPrUGBLK2sl/3knguj+Wu6bHIlKSq/0paIGQZoVPv53SKpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775004; c=relaxed/simple;
	bh=3RlZSj4ygi3yxZvCh2ME7pHE4GTKWmg2Iq4Gsz/GWzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qdPPyBy1mfMtMl1qprmNKJxdvGXqxXrAoZh8p/EzlKqmmwOS5LVQzA2AOL3BBNvv9ajZ+qz4nd2RUu9XVz5XaO8NXcLSEZ3C/f76NJFaKN+Fbbx4gIEVbcY59mVeL0w4/v8cZenE7vSvTVJsK2nUFs5dtog6bJH8t/9Pkd8+/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=emOzK0LT; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b47174beb13so556967a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755775001; x=1756379801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C9m78DY2oo0QEwB+fU7Tphb0IaeTBYjgFM9rxi/RnM=;
        b=mMOBU5cJZ8VK/sYDn3fDbbgxhBCiDBXTK/ReN8df3rvFffLZZyYOHUnJ4lyU0DkKxj
         bsdmFMeNTmiLhLkXgtThHbAlcabekKtDXClRapupnw6kltsWMrLIbl9eYqxGBjVlqVI4
         qa8+vMNdR2SAa8M0YJtoFF3fTak3PnEdMeqlDX4D2lCnmU68rLWBuyWdKce0vRxheD4T
         Xo0jEQRBQ4ryX6tA0Td0xD0sJ99UIYzFkiy/0mRMArqX5RlcBsqqEWmaieS848X+X1ZO
         9voAEfDY8p2+S3gjI4u4f/FnXQT6PZvFh3Q92uKXz8/QuduiK1LcTdNfrQGv+mhUGk7y
         0Jpg==
X-Forwarded-Encrypted: i=1; AJvYcCXkIHYoQGBaKm6cD4L6mvrJZNxfH7xpsfHEvR48LmekIKBs5jBD4pc58BPpolkFPiYF4gAWyL4EwT7V2is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0F/dndaQunOKu4OeCiDr/hOduGEAtaZW5/spUdaJmQyBr/va/
	33Aylr1xYJUWrb5X2w40yT3N/ziskh34NYJFxybNZXnmJceqfOuNe4D3Hd8zjOBpb4gQ6J6x9GC
	WOuzjCKwpHEcui5uqJU0f0kQtPtQWxfJOs777tBeqU+lOQWs4sNQsRhiqKriLl3+7RYPmmmyIIm
	+3x8eRHm5+L8m4WWRtGptnVjlX+Xy9/fefaIbN8NsMgfT9ujqFJeSLznZCE8TE4E612/2E/Y9SU
	x3S12CPkKuXfk3+He0=
X-Gm-Gg: ASbGncu+Kzh+eutHN1WZlCuUWufT0WbGoA9jMFsuREwupiDJ/Jzc3cEdNCG9OqWBisc
	q1ao7Tmrg+unZ0KaasCL/vdIMoxbiC8GOHbZCB/0qYUhJCq/Uw9qp0dho/vmrR9v+QSnTGBbHvj
	ttmLSk+wQJGZ4yHFqSqurWSNGY+dkty27ozYKdV+pEPIJUAUyt6rzGfOhbTREeckDtU/YRW08Fb
	eL+voJBsOYVLbZL8ggr/T4HOaM0uO9Cc8qjOM61kkXyUcAEONe3BM6Sc8eeZ+23WPkMi/u4d2PM
	X7TYjpC6R6kwAHgcScSNIct5zFqbRPTBpbjlhFIxwYiv9J3RAatmWIG/OKARb83ycuNNFDXZXI2
	+sQKY8cyJ6lVU7xaUc5H0Zsay+3ktsKrrwUJ83eKZXa/w1kgDPf7vkd4ihZhEQA207hqe4/y2Xu
	k=
X-Google-Smtp-Source: AGHT+IGfoKxXPT5HuqDwDiDbY8i+NBDbMbiA2vZ5g5jxb30qo6czHJdswP7r+jIijv1cRFPcyCG25zteBPXs
X-Received: by 2002:a17:903:434c:b0:240:6766:ac01 with SMTP id d9443c01a7336-245febef706mr22391935ad.2.1755775001121;
        Thu, 21 Aug 2025 04:16:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245f4f0b5e7sm3445345ad.65.2025.08.21.04.16.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 04:16:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458121274so11018155ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755774999; x=1756379799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/C9m78DY2oo0QEwB+fU7Tphb0IaeTBYjgFM9rxi/RnM=;
        b=emOzK0LTBmRoejrIy8JkjknOAM8iUuMWXQFJT1UvdaB97zc7hYuF7rp9rBbPzXxb8+
         WI2LQDpgjuJ7ej55EQoX1qzh+blkZOjQO+GNGRGu8jPxZa6DEFl5DXuaIN5CULjBiO5Y
         69I5hKXxTqSBo7TwcrZU3KQXn0jLD74+USDGw=
X-Forwarded-Encrypted: i=1; AJvYcCViHY7jFgj/X4WWKkFywrJJ8piz0l2a83b2vaI2A/QNY5P/IDshAUF1GunJ6T4JJq5EHu/2Ol2cLdrLTrQ=@vger.kernel.org
X-Received: by 2002:a17:902:d54f:b0:246:115a:e5e6 with SMTP id d9443c01a7336-246115ae81emr14311245ad.42.1755774999355;
        Thu, 21 Aug 2025 04:16:39 -0700 (PDT)
X-Received: by 2002:a17:902:d54f:b0:246:115a:e5e6 with SMTP id d9443c01a7336-246115ae81emr14311005ad.42.1755774998952;
        Thu, 21 Aug 2025 04:16:38 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245fd335ea1sm21363285ad.110.2025.08.21.04.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:16:38 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: nick.shi@broadcom.com,
	alexey.makhalov@broadcom.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	shubham-sg.gupta@broadcom.com,
	karen.wang@broadcom.com,
	hari-krishna.ginka@broadcom.com,
	ajay.kaher@broadcom.com
Subject: [PATCH 0/2] ptp/ptp_vmw: enhancements to ptp_vmw
Date: Thu, 21 Aug 2025 11:03:21 +0000
Message-Id: <20250821110323.974367-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series provides:

- implementation of PTP clock adjustments ops for ptp_vmw driver to
adjust its time and frequency, allowing time transfer from a virtual
machine to the underlying hypervisor.

- add a module parameter probe_hv_port that allows ptp_vmw driver to
be loaded even when ACPI is disabled, by directly probing for the
device using VMware hypervisor port commands.

Ajay Kaher (2):
  ptp/ptp_vmw: Implement PTP clock adjustments ops
  ptp/ptp_vmw: load ptp_vmw driver by directly probing the device

 drivers/ptp/ptp_vmw.c | 110 +++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 22 deletions(-)

-- 
2.40.4


