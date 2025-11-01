Return-Path: <linux-kernel+bounces-881197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5CAC27B3F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D67403EC9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83EA2D46BB;
	Sat,  1 Nov 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLcbzdl9"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA092D0C72
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990485; cv=none; b=hzTdMGCAV1UDr74HwkmQTwuO+HpWmnWYvAD5aAbAlYuOt6PNzIoKdpD6dIjCDROoeaqWm65mst9EGCB4Wnja19Lm7Dj4HLNO5caYRSAyp/j4uzMKXEohyYtWagACKr0h+NNSKH9unIac7fEAJh33wVzDtIr2y54r89VPgb61xhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990485; c=relaxed/simple;
	bh=3OG2wiKH22RCfvC+iceoRBKIWpDNYuCgxZ/0fv2vRj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONBd8sA1Rmpu0kVBfog3/icVvFe2kvijoCE45qs6yZPWkSeHRQk3z4gM/aqxc2u4QUXqBmhAJrs4KbBnmirZ8nlEpmFCmJzST09eUm26ylTk60uGuriQncbtBMfvQk+Cd8mmCtPaAZG4WIyLsz7HYteUl4IU6lJU/Mw4Aj/YgxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLcbzdl9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso3062435b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990483; x=1762595283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WH5O/8nAx5rVFTEi7/lXcZZ45r+c3Q9ZyuJj8snlwgs=;
        b=nLcbzdl9dR0X3krcX6dwvdW2QSYs+p3GtfBlu3l2dEIINpLVz700FoeUkEvGq/kuiM
         mk6ObxRygf8sG5V1QlH6k4Mcyvz1+hqXbgoHbLL4iSUDAsJBd3NezgbCsDNRfCO6vUam
         1gHzIn8UzOm80YSQ2UudACKO0iPJL0qltaCF35gEgjPA66GkaAwnF090QE3HHc4Owide
         rhNUk0bgSFS4z5qXDpLw4pfbqO8zWLbrTY+tZQcMttGe/jyLRHd6wHn35gMD7BsGnaXY
         hx9lfmc3PXqDRYEMexP11+x7I75c8HWOUAxYihyjjhEjoH65atsT2Ncpb+Gyhn8a9zmZ
         bhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990483; x=1762595283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WH5O/8nAx5rVFTEi7/lXcZZ45r+c3Q9ZyuJj8snlwgs=;
        b=PxXUOxzrNXH17cwK5hzXifSjgTKpQ3IjROnZ5+GJFeGFbW/6BeKU8g0RM5ebChCsWB
         urrJzxLTiunpM16U7GNNmwfqnEJY6AnP8hUdLar64MxRxCdLWlxJg1xRHtM+Ee5zXzCo
         vN+e1rSh99/y/7CgR3sIcChyNFys5mLKbKjLCUBuGmiuO9tyDkE//TIuzoZGPRs48V4+
         KpQ9LnMNenFQN0+Rq7F4ngz1gQ5btQA+PB+QDYFXSGMmFAKarRbvuuWB0cjdxjrUvoiZ
         p8bBgbIbY1SpEnHbq/1wY1NnNs2qwS645qVqZIAWqPQ5w8U8sQsCNWnGyO6V7NllWNW0
         Gk1g==
X-Gm-Message-State: AOJu0YzYO9u95G0z3xTBqBnWNDEVB5wP4F9sfa+TWrkEZmBpvvohfVRv
	q3B89Q7N1h6oXZPe0Q/kmZCSJoi+av6q3GW2A97dsvhO66EtVkOQuLk3
X-Gm-Gg: ASbGncuuf1nzYJ/jzLSz/6Nf8ClOwsG8KlFPz2bWMuJDF+cAF6pVbTnAgypRgpnZZWr
	McgGGL704Nchx6hRVoHDCobUqpcEPhP8aNq8OcoR8BbcLxy0E2jBcsiR+SH295kS3Ts7UE1Chjb
	iid6/t+GtMTKV2w4Pd9EXQ2CE8v5cai/QrCcoPEe/FjzYi89giHwUHZ6CGQUL/yfHUHBSbhG6ty
	Pf4QIz+1klA2QkHUGLSptSEVyfBOz4t5Ke1JVvmkSEWzWXZFDr89Vu2bK8Et+sII7UBtfE07mN4
	PKrMVQSMSU0Hhwm4P5zEm6qkLUgKqNko1L/NtOxKwUS3o7Z8wHdpF1d1FAtR8Ojb5TaENFM3I82
	Va3vg+GBWuZCRokBDF5a698AhN1rbepE/9wpbl3LkGdoYOhWh0xQtwP/Tcek/k8G7mq0q7hz24j
	fa
X-Google-Smtp-Source: AGHT+IFkkEhMNFBtz799ZVmYFsXMsu0ozafr7JzI6vs8a+fPrI8GNOdanKuJbIbpaRMf1whMNOYWqw==
X-Received: by 2002:aa7:8883:0:b0:7a2:70f5:c83f with SMTP id d2e1a72fcca58-7a77747a497mr7159153b3a.10.1761990483399;
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d72733sm4804521b3a.21.2025.11.01.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5228C4209E50; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v2 0/8] xfrm docs update
Date: Sat,  1 Nov 2025 16:47:36 +0700
Message-ID: <20251101094744.46932-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=bagasdotme@gmail.com; h=from:subject; bh=3OG2wiKH22RCfvC+iceoRBKIWpDNYuCgxZ/0fv2vRj4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms1zJm651g7L3+4YxH5x0enzdfmeoZHySvdDr6TVHpz yZ3ETmXjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyk8jQjw9QJLtFbJZYwFVpE udzYf1lR8dq8NYLW9cc3buHV4OUT9mBkuKZv0dzqV/Ji39eN699+4thtcO6Q6M1FJ1+U6PzQnLj ajBEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are xfrm documentation patches. Patches [1-6/8] are formatting polishing;
[7/8] groups the docs and [8/8] adds MAINTAINERS entries for them.

Enjoy!

Changes since v1 [1]:

  - Also polish xfrm_sync section headings (Randy)
  - Apply review trailers (Randy)

[1]: https://lore.kernel.org/lkml/20251029082615.39518-1-bagasdotme@gmail.com/

Bagas Sanjaya (8):
  Documentation: xfrm_device: Wrap iproute2 snippets in literal code
    block
  Documentation: xfrm_device: Use numbered list for offloading steps
  Documentation: xfrm_device: Separate hardware offload sublists
  Documentation: xfrm_sync: Properly reindent list text
  Documentation: xfrm_sync: Trim excess section heading characters
  Documentation: xfrm_sync: Number the fifth section
  net: Move XFRM documentation into its own subdirectory
  MAINTAINERS: Add entry for XFRM documentation

 Documentation/networking/index.rst            |  5 +-
 Documentation/networking/xfrm/index.rst       | 13 +++
 .../networking/{ => xfrm}/xfrm_device.rst     | 20 ++--
 .../networking/{ => xfrm}/xfrm_proc.rst       |  0
 .../networking/{ => xfrm}/xfrm_sync.rst       | 97 ++++++++++---------
 .../networking/{ => xfrm}/xfrm_sysctl.rst     |  0
 MAINTAINERS                                   |  1 +
 7 files changed, 77 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/networking/xfrm/index.rst
 rename Documentation/networking/{ => xfrm}/xfrm_device.rst (95%)
 rename Documentation/networking/{ => xfrm}/xfrm_proc.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_sync.rst (64%)
 rename Documentation/networking/{ => xfrm}/xfrm_sysctl.rst (100%)


base-commit: 01cc760632b875c4ad0d8fec0b0c01896b8a36d4
-- 
An old man doll... just what I always wanted! - Clara


