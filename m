Return-Path: <linux-kernel+bounces-864784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB237BFB8A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 865AE4E446F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC9332860A;
	Wed, 22 Oct 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b8H4kUzn"
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1531B810
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131235; cv=none; b=jr8Be/KppkfyJQ5A6w1+fudGOhSXfJ54FB5tTr8S96+zVAud+eTPQTrezJQp60zoJiRgJ9Dk0XAkNF+nG66fsd7ubGkKU0Gs+ze3sQJygtoWG6dpCstwn3L25sHuwAlhcatnKLN7hA+wCw7XLoZMmqmMn+KeLDezFX6vc3OwxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131235; c=relaxed/simple;
	bh=ZY4ksHec6wJzWCalGrMOvAU5kA0Tf1c5wcS05kGhWVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=coUF+oZTKVlw7MTgxE8XucAivYt9aaB8bJSqfQzXGAVIlenPClG9zZLHDuSiFZV11ebmqCwwGF7Hz7+kguxUniskER1KT8uwasb8mhASTUFofQBXJrqaOQnuL6tfJp7OnF5M3SoZfpKawpvnJWU+q4GeIw+3o6vRvAku8tS1PhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b8H4kUzn; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-4e89ffd95b9so11939771cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131232; x=1761736032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2jSL7X+YIPN8ymI0EGsh1TEga+mDeE0bn24UOno88E=;
        b=MfscaO2gjaAl+MOdWcwixud54xqsdDBj05Si4eFmmM8ZpKx74D8N68/+OiHK7QNJ9D
         f6OnaO5sGHPslx5MDhtB6JvZn9znvZFS9jZ7zDPbZH1Ji2K9Kq+tUvqMXIddPmCyL4nh
         14whLAqKGWjQvAG+rYta3Z3JORof6iVkkCk6v63CqB7BVEodZzXP4aqeFiE/gSUikPnR
         YmOPIRysBbRs6C/XqLenpsCjWnUQmckLPNhNZ4KBxnsUUFqizseTvh6XB3lYo+vdpb05
         TDx6SGPjjUMDqLhkCKh9zShBAQOjvYeUhzoNq6GGqaG8LoIw2UpN200zZTv0PBftG45C
         oAUg==
X-Forwarded-Encrypted: i=1; AJvYcCVmm/k94dfFIPjQ80mCo3e9SA+mcJgn6tczEJ/pLpqXb4T163K7GM73eJdVR4Vr7qKoQ8nd35t7fMaHkjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaG9hVVAheD1cCkDg1H5kwYu++pW+atPXWwfzh2JKRiF8V7MB
	velGwtIHLmVC4yLBRF9tQiCYlfqd7S2WWfaCCgZHQ8uJlQpe0chNt53a3wLNWgJn9eUcXAsY1Ci
	ZwyOpxLOniHTgNEugYG9y2Kv6lGiFjHjM6xu4RRdmc3tQm9as8z6XdEnzb0LQSTfN8Uv+XNdn71
	emLVeqFPUcrsZUj3jwiGpIV2+FY0wFubpRTPZ+2BvSCuc0qqQQlcSi6VgYSj9hL6bMtAzn/li2w
	95pzP5xzrjQiB0P5kI=
X-Gm-Gg: ASbGncthECSHIlwQW94GBMuNi+r30M4Rb2l3GS6xoreHUSMysCyVnLsVHQDaJzdTM3x
	S5MlRVop2KkhPEAna65+ue9cBzqYLTjKqCzhX3NoENO5PdANV/IYDRgdXg6SpJCAI10H7iC1Hfw
	9WdtsLYZf1rqryixjmzSv5GtF2GqRhIQp6ppATXaNDApBWY09Ahm1TAmfegJYQWG2h929rTaHcW
	7NRDOyNuW6EfC/nIJsuzTqjPWiMXlJsbH0GMJtfFdAK/QL41F0H6k+dxpVv0bREE6nr3MtUHjy2
	o59wG6sNjzt0dazuk3CUwFim0Zxak8b14YSoqB/l3mMhNNEKsYo0RVM8hZdjVNygzZrS4eIqYHA
	iCvV8rpw/QHLsr6Bc2w2X5/rG3sWTQlaa7KKsBRUq8Dd1vPZ5pUs482EqV4AFiigu/k7gXDCpZf
	hbwr4hnqju2fRVAzW7Yc9e93eQhC4gTCw=
X-Google-Smtp-Source: AGHT+IGEMhmkxQDNUDFUyFdI+econ6svELEg4XTMmNAbLfe9aQ4AlN3sK2WE/PoS+3RxXIpfSZ3lw9QBHBPK
X-Received: by 2002:ac8:5a93:0:b0:4e8:99f0:a5aa with SMTP id d75a77b69052e-4e89d415184mr242763851cf.78.1761131232097;
        Wed, 22 Oct 2025 04:07:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87ce9f600f8sm15126666d6.6.2025.10.22.04.07.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:07:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28c58e009d1so152244555ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761131231; x=1761736031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2jSL7X+YIPN8ymI0EGsh1TEga+mDeE0bn24UOno88E=;
        b=b8H4kUzn3LR4nBn5WgN0jxYsNNWyc/rAO6CMXtrdr4pme/cKfK5Dgna3BycP51lBNd
         5rBTXA71hiujrDqKNzBhQpJKL24O3BelmMPTPHLdAv0C1lhg1atiU77dfu8MVmdQfJzQ
         57m48BNn2jXULvdZDDXz+eP0VzUaZq7iZcdXc=
X-Forwarded-Encrypted: i=1; AJvYcCUjutxkcEcCpzHQYtUPekcG9B4pf0I+LyCQANRzoNZfP45cOvJzimDxUfWouNVYBXxqc1+3cbdBSyUSJ8k=@vger.kernel.org
X-Received: by 2002:a17:902:d58d:b0:269:9719:fffd with SMTP id d9443c01a7336-290c9cf9775mr254082145ad.1.1761131231007;
        Wed, 22 Oct 2025 04:07:11 -0700 (PDT)
X-Received: by 2002:a17:902:d58d:b0:269:9719:fffd with SMTP id d9443c01a7336-290c9cf9775mr254081735ad.1.1761131230496;
        Wed, 22 Oct 2025 04:07:10 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm135964955ad.52.2025.10.22.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:07:10 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	richardcochran@gmail.com,
	nick.shi@broadcom.com,
	alexey.makhalov@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	jiashengjiangcool@gmail.com,
	andrew@lunn.ch,
	viswanathiyyappan@gmail.com,
	vadim.fedorenko@linux.dev,
	wei.fang@nxp.com,
	rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	cjubran@nvidia.com,
	dtatulea@nvidia.com,
	tariqt@nvidia.com
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
Subject: [PATCH v2 0/2] ptp/ptp_vmw: enhancements to ptp_vmw
Date: Wed, 22 Oct 2025 10:51:26 +0000
Message-Id: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
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

v2:
- [PATCH 2/2]: remove blank line in ptp_vmw_init()

v1 link:
https://lore.kernel.org/lkml/20250821110323.974367-1-ajay.kaher@broadcom.com/

Ajay Kaher (2):
  ptp/ptp_vmw: Implement PTP clock adjustments ops
  ptp/ptp_vmw: load ptp_vmw driver by directly probing the device

 drivers/ptp/ptp_vmw.c | 109 +++++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 22 deletions(-)

-- 
2.40.4


