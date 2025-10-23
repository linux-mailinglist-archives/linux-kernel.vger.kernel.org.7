Return-Path: <linux-kernel+bounces-866806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B3C00B05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C01718960A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997330DD0B;
	Thu, 23 Oct 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTH3qzor"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AF309F0D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218489; cv=none; b=X5fVbeB8pUvND2yEnyo1dO3BS1PU47zQHkfB4LGfrhh6yg9XnVZ6fvjp7u7TqvA/czElR49i4+hj+S8QgIaBXJWiv3bLMh9nQXR2ljLjYzSRBGhsWjcuj5HJaJ06wrw87szO4mDXQY8MGz47wgiJkksjGS5dnJhCFx0ywbXXCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218489; c=relaxed/simple;
	bh=GRKxdnG6EAwEEwZaN9kIsS0ShqlDa1LWlfGj40dNoY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nt2egNfQmxnTbPk8CU8GamnZ96UoypF8SsbciOwi3WCI+72ZwEZ6aVzHiYlgh4XxGzQ9yK8FE9rmxq6laOyDFfQ7aouIYOWe1ep8SAw3obk+cqlI7XKKs0Hpi/iwSpUtZ3/vZRCpHi6FboF6GI4NVqwvraOJePuIzHKWpqsjfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTH3qzor; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290a3a4c7ecso7920095ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218487; x=1761823287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlgvmBPLgehoAq+qXl2/qSo9ZfDpQHfJlMq911IhmcY=;
        b=ZTH3qzorLlyhg44IF0SOwB0byWrHK8kkx+CksB6NauiL5t/ela9vS6vR6OK4wsstYo
         H3xVVad1c+6FYVg6ufgtgpHpIMufPOTfJ9FHSs3IG/vIu2QLfVpMBuz8RHWWDH3B6XLj
         GAQ4GrOmkc9j/CLj61mG9HyL5Lqanl8mnen3mJUMfY8uuS/BRlvxpb/fAA5XzS5A8DzQ
         Z86KK9/+pBGDcemyD5CmY8fQOqxK6xxUW0yYqgMAmpLaNPfg1mz7GC3wbW+dlEDQ/oEF
         wPMeVTkTIuQ106PxEL66EkYoMqEpqo88kcN1r9Sik0X6NMKZKaBVgAp3Q5k72mtXJ8JR
         xwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218487; x=1761823287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlgvmBPLgehoAq+qXl2/qSo9ZfDpQHfJlMq911IhmcY=;
        b=h0nW1MsazxrbEVbBYshopt5fyrTjGeuJ/z6d4SFxlsWzr/wnfRFBBPuy/Ja/Ro8PtF
         jLwSBp6yfuUfxohtBRGMR2Vmu3e1OVzzsKtSsOaxBJ7v5NFhA6nP2V5jB3vNHuF6ra8/
         +SKYqS7UByPJd0pnd/hcbsKfV34ScS8o4cjHVj/y0Ebu32gqF3j+3nngOOOz42rwMiLB
         eZI5tU1Qt9zqLno9ku/fNl4LocH3ZSLCz64gr7OIen8lgtdRr80ihZHEs3JaekfxoigW
         nBXdE7d92+MX2WoaJ9xQOkEtAjfDeprOuFsjRSqPtUJnhv5rpXjOeA8UfvTUP4ikeBv6
         TZRg==
X-Forwarded-Encrypted: i=1; AJvYcCXyTcgwYwogozw8SM6AtRUQ/X3ObIkn8oGFInXZQSPnVlIhfWav8rEctu/14XRUqF86bE5tutBqxQS1anU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1q5ui2zSR+izgQ80IBG9GWBB/7TgwGjo4R+abCUITkq+Nopz
	A0a+B5lQaxQaTZJk/san/HaX1WrkXrhDSAddBBETyoldhJvPD+D+KcnKCDJeFvCI
X-Gm-Gg: ASbGncvrpksdKGXSh1VypQmo+lH/3cv9MEisB0PnOt5UsDo4hgRQXLTMjG9fg4kHWrG
	J0X/hfPvOdYx8O91/bBKxkAFbcyxF2LiLI1UogflV30yI8ISHGNCv5QPkIAyMEHZ5+9DqyJqZRn
	fzdMS4fO3JRLkKYP7xsbLFnc6xGC0uTD9KoIgbucrZlzRoVfL67/gGZVfDDRBlft6casHb942+U
	+e9R0HybfrzmKHh1B+Nj2Qc8VjCzQIxKM88ZI9572DU/7KpH6wEmR1GT6WCf/SIrXWfmjKd8Kn9
	a4Tx4HlpuW2SUbVAXSU+UCOwb4CAVCuieOOC66FQDWVp8boTjGhkO2aoh1IWDF2urIQsrh9gLHx
	MsIY2UvTABEv5aKXIuAsN4qdz+DspKCRY/WJI6OI9x1VAviKa8yTvFOWoUYXyQZ+RITVme/XS6M
	gfhieungnUbzZHaz9lsjQ=
X-Google-Smtp-Source: AGHT+IFqM1qThq8uRjoxvPG6LNB2Te+R9PY3nw4Tc7SvEuUzlsBFl9YlVcL0VToRy2HrIgcsKyGcVA==
X-Received: by 2002:a17:902:d503:b0:290:91b0:def4 with SMTP id d9443c01a7336-290ca21635emr336955825ad.29.1761218487485;
        Thu, 23 Oct 2025 04:21:27 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dded613sm20226885ad.37.2025.10.23.04.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:21:26 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 0/2] net: ravb: Fix SoC-specific configuration
Date: Thu, 23 Oct 2025 12:21:09 +0100
Message-ID: <20251023112111.215198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This series addresses several issues in the Renesas Ethernet AVB (ravb)
driver related to SoC-specific resource configuration.

The series includes the following changes:

- Make DBAT entry count configurable per SoC
The number of descriptor base address table (DBAT) entries is not uniform
across all SoCs. Pass this information via the hardware info structure and
allocate resources accordingly.

- Allocate correct number of queues based on SoC support
Use the per-SoC configuration to determine whether a network control queue
is available, and allocate queues dynamically to match the SoC's
capability.

Note, these patches were posted previously [0] as fixes but based on the
discussion there, I've reworked them based on feedback from Jakub and
dropped the fixes tag and Cc to stable, hence sending them for net-next.

[0] https://lore.kernel.org/all/20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  net: ravb: Make DBAT entry count configurable per-SoC
  net: ravb: Allocate correct number of queues based on SoC support

 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.43.0


