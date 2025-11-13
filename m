Return-Path: <linux-kernel+bounces-899866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D969C58F77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04D8036058D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581AE359FB5;
	Thu, 13 Nov 2025 16:46:16 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4B359708
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052375; cv=none; b=RfbXZ9aZnG/6t/6jl6zazwCrWbchO24p4cCoiFM5GO5ay8ZzwmTJdgbUFlwiPHVRvs2IXYQhMFSWi+s1OAcCJEhckwnm1SC/4Z/lMw50bWuyWFzMwijde7kle8xZXGqgPRf8uWIlIg2AGrUZs/+2KlEofAgjdvYo/2YPlSfPUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052375; c=relaxed/simple;
	bh=VGnC9M5GyCZAIUV5N/UMNwO6x7HUT0IBSW2UW8dHOTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nk4tpI7Oj/7Pgo0F9b7gOJxhXP9BzSmzt4SPjiHV5GyKLngQ4kWU7Ap8+focNQZ3H9pnGUX8uGCrnbitPrDz2yH5KkVrhCtQIH9iobvLaukc6QXpkn20nLgKZdKS/+1zH/vP6wHFeK5NXOUUDpiqkJrPYHF3Zmw8PNLPEKTAW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c6ce4f65f7so877165a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052373; x=1763657173;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Le654lwVo/6yvzyB42yjnqH7EJH3FTtiuiBest9Aydw=;
        b=X/P5RMht7vJ5TO8qFsU2DkCxyEaOOrNeogTKjH1XmfJHffxMWQ4jjgQdw4o2FyEaMO
         0QL2Cf/Lz79e/DNVM251boAzIs2s9ecURNZvDMuPY8uUB+HksF9w8inEG49xjyqrdiWI
         7DJWwDTHN25BJ0SMDLl9zn2hrcqpNcCFNi0OTT7qcM6sooU2UzqEKPvuko4RAqvLqPYr
         x8mEzffB9wurwJEViLgv/DMrkkKK2ioDu/Uin80kmap3K+lyuDUBu5HpTI4HaDNtC6tH
         lc9RsGBSnQrza1KcMwpo45Y9xydz3RNWYqewx90OSnc3vtMRnpeomVO97+qgkDat/2dc
         uyDw==
X-Forwarded-Encrypted: i=1; AJvYcCVA+iMGH5tehfzWmd1R/9WwR1d4Bk6T0S9qGZxDlGKM78bkiCk982Q+5cjQjZcn9YTF4Dseg+l3DNwVb0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvp/Dqmi61ih3foRfzw+u8xUaqjeKnz6bm1sC7H3Nfx3Cmb96R
	0x5afQH3uCbG1FF1/Ke5B+ZdRbtB9Nv83x9VlFxxUPhsGxQJ4UEnCdXe
X-Gm-Gg: ASbGncvxb+j/UJOUrBFBRH7BSKsKtDSnTP1Os6QiQnl6Lji5T0NnbwgBouLjHaDa+A0
	z2/rSxWIzu8a6SBkiZjQSVEv/iHUwAG6e2hNwkIdsbMWTwUPNDhkESdjFuNj/jQIx3QNneMcr51
	Cej3tcSQ2JolYQS5MGJvFVUy2TRcS5nTpKWNcjlv0xSGXgdSCn3pFQs9g0JGaP/HGyfWuk9JnOS
	hOm75jQJjmh+sYQRhH5kb+6TpjAZd/hTItGspqDL2J8E/+SZTA47zxODYxMZMRWCdd1ZdF8c3ST
	GbWtGGxrwGih+t35UHBulVEBIM7qEdsL58oRHx0JBSgZ6+ml8i3r27YqngsXWwBRzyGxjrCpY1n
	gZb/n3sjg0MXqM+h8jmlwKEqxkPNWVKDQMYCGnYK/9QolkwYOXIQYI1niH/f50ndqn1EXy5YRpd
	A9XQ==
X-Google-Smtp-Source: AGHT+IHMlldWyJC6JRWEYFYT1iL5gomLD7IIC4KMdUcHwaxmTiV3LQSm9YXqc/Il2hpg7iYHwyqiKQ==
X-Received: by 2002:a05:6830:67da:b0:7ba:8107:d559 with SMTP id 46e09a7af769-7c74454ea64mr121594a34.26.1763052373137;
        Thu, 13 Nov 2025 08:46:13 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a39310csm1490035a34.21.2025.11.13.08.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:46:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] net: mlx: migrate to new get_rx_ring_count ethtool API
Date: Thu, 13 Nov 2025 08:46:02 -0800
Message-Id: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEoLFmkC/x3MQQqDMBAF0KsMf20gY5tFcpUiInVMB2osE5CA5
 O5C3wHehSqmUpHogsmpVY+CRDwQ3p+lZHG6IhFGPwZmfrj92+ZszbTk6jiGNYZNvMQnBsLPZNP
 2715T7ze2omJYXgAAAA==
X-Change-ID: 20251113-mlx_grxrings-195d95fe0e94
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=leitao@debian.org;
 h=from:subject:message-id; bh=VGnC9M5GyCZAIUV5N/UMNwO6x7HUT0IBSW2UW8dHOTs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpFgtTGtn9i7Py9ec07FVPLZv/6rFQlwLiE6XVC
 6+4CuAYJhqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaRYLUwAKCRA1o5Of/Hh3
 bYrZEACULVWobdnQ9efzrcFpilU50BH9Lh3TGK7pgRlVM29ZOju0jvQacwOi19SlHukYZiOnmW8
 yKgdmIVbPFSYuCgIcHTU6SUQ4W2LDKqDenwbmKJiTNVGgr91vWVhms1+0hT5EOtCfzvPZjmWaIF
 uv4ZRJiT088YQUbMrVIORBqpOICaKHx8Qm+lN+6uSnd7pfDT05W9PNlBoMaJoMnG0Ds0gTfot4h
 s2+CsizvYVB2M7ij2zxJh8xIkY0WjFd2VoZXuij8yZK4sXJhDKnIe6FEqTbs/KoTBEhpbpr7ech
 wvQGJEKIyeoZK5xN9f8gvt4wkOrnsbVi9U8cxelWfeeOPgxX+mnDVEOiPweFUO6N3KXy2dNSbhB
 j9QQzvR9361xkSpftm2D2A2IloduQSnM7kNT5tbrM8qjR+w69UftVJ5en4VobiHw+4nwFXWxHW5
 5r7N3W7m38YKbTgcXfF9cA7lqiyqyJLYDoGrAYPjupKQoqhFCplb3uR7aYShy4HeuioYeo3ZW3x
 5Vd0CyLn14g41jd8WTraQpkuAFRE+V4C+qozgMkI21bJwyOcRzrRiBHqrZpVzEfMWxfbZjLR3II
 /4Uqcgmh/AjJnxOL7tKsLW/dFHTjhxC66B7Gd+UYoDtwbFVczLz7X2CS+/N9JAPHZ7VQ84HpgtI
 0IdnQAAKtiQKs0Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This series migrates the mlx4 and mlx5 drivers to use the new
.get_rx_ring_count() callback introduced in commit 84eaf4359c36 ("net:
ethtool: add get_rx_ring_count callback to optimize RX ring queries").

Previously, these drivers handled ETHTOOL_GRXRINGS within the
.get_rxnfc() callback. With the dedicated .get_rx_ring_count() API, this
handling can be extracted and simplified.

For mlx5, this affects both the ethernet and IPoIB drivers. The
ETHTOOL_GRXRINGS handling was previously kept in .get_rxnfc() to support
"ethtool -x" when CONFIG_MLX5_EN_RXNFC=n, but this is no longer
necessary with the new dedicated callback.

Note: The mlx4 changes are compile-tested only, while mlx5 changes were
properly tested.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      mlx4: extract GRXRINGS from .get_rxnfc
      mlx5: extract GRXRINGS from .get_rxnfc

 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c        | 11 ++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 18 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c    | 18 ++++++++----------
 3 files changed, 24 insertions(+), 23 deletions(-)
---
base-commit: 9f07af1d274223a4314b5e2e6d395a78166c24c5
change-id: 20251113-mlx_grxrings-195d95fe0e94

Best regards,
--  
Breno Leitao <leitao@debian.org>


