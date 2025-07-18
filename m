Return-Path: <linux-kernel+bounces-736702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CA3B0A0C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9824F3A3FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980F2BCF4B;
	Fri, 18 Jul 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcKEbCUs"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF81198A2F;
	Fri, 18 Jul 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834856; cv=none; b=E7SbKfH5SF6bq+xkfza4wbRYOOyJ4DJ08f1aaHx7thWDsvrmNPQL+zTmQId++xCr4RWH9mseIRQNTV7POjEACxTNjwMKg3BYyBNH6LuDjbyj3jrzWfrt9Okw4NdZ9Znz5ucQhLmuy+kjHYP1NvEznToIN8SsgYJxgdKXsaru5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834856; c=relaxed/simple;
	bh=URT4x0Acr8D69x0WfU/q2WOWVbFVaINnDpDK31b1/9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZj8mB0UrFsY6RoIeCU8H0S0OyepzgCXq3dXvKZtq8RMIsdiCc6Qh9O6r25zoc/hjm0hQK6ifU69tFairSyYoCO+iKWy5VU1FZj3NNORz5XJ6tNh331mwFpa7AHygutdjiKWnAE5U0hZ7uHkhHYYIjakYGXlpFEJFTV2qBuhDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcKEbCUs; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5550dca1241so1736148e87.0;
        Fri, 18 Jul 2025 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752834852; x=1753439652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L16c/8jEUuiIlk2H4pEeJaRqtG3hOpwT7bIYsra1fiw=;
        b=DcKEbCUsdMlAd98doBkA8JcbrqH6zd96OiACoBvlYKtq9aSPMldOld7D0H3aajjcOY
         JqKwsJtSykfX+Gs0bNmruK0IujsKp9Uh/FrS1DAHNJkGQzzH3SunoaygldlcaMeeXmQe
         LERVHtdXZzBWJtzWztMZp+qIQ/bYyh+Ia5251mxT7JgdSVauo+7YtqGRTA1jdvJ4BsgV
         1SWwbSXp4HwX/VOVluCYvr+Ygo9e7VUr1rpSEjGTvYCXPG18/InVJRPuPpY8C2dlwpBx
         KMjJINUQuKgf5IQ+NzQF3VZ70dm+7EP123NA47wZZid1+yWx1CmfI1hPxhQ3TezbooKe
         y/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834852; x=1753439652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L16c/8jEUuiIlk2H4pEeJaRqtG3hOpwT7bIYsra1fiw=;
        b=BCRf8jToKUGQUr2uiCQtmRslml6aZR3KXzjrzNdvAa4vXuEvwAeGFZFmoNXe54nJNz
         3/WSFZpgPiOpV7nblYwhvKIPmPGoBi++bV3DOuXjTlYJKyc7pJO7GKv1+aFmfW6OHS4S
         9AsMZruye1nhSv3STR08iCrCHalbmjmOztoITu4dEZBQ+2FtHkF3sjMseBveh4oeCvtH
         Uo/Tm/17zJ/CEDfwJxOQGoLmqpHBb+VB5O4gB3N+0Dmwy3IpOH2vqXohEhXhhgNR5tcy
         N2zV2keam4tHUNCpzOucrC1kVnDuLiVTEwZqpGwOzaCkaHyiIFAYXMTapx+KQI7ONKsn
         OCnw==
X-Forwarded-Encrypted: i=1; AJvYcCU0NmAUj1EL+jH7oO/W6afWilbcNfzrkYr0p7o7SZ5RhqzgzxyahEoefbdEijt3Cg8YYRPuK6VN+e2U0cDIQdI=@vger.kernel.org, AJvYcCUYpoKMkYpl89DJw0znIs+NusBupQ2ep4BtLdWIECknDyOkfujqRMjiwuQyji/psQkH5v2GL4z3D+98EtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0uKndRD72U1XwiNuF0VG3Ajfo+rVsybtv7AsxZEob+2yDNudq
	Bi5idw3MjDM6wYr11Ny8SdPvKXP90XaYVGsqIDEmEl0FhvCcAXCkArjs
X-Gm-Gg: ASbGnctAIl2QSQGm9v0kxFlbKBYF3jVv45ke/WEd7T/7u+TsBVoEoETEsNHHIDEvlAL
	Gfzj6q51bvM5vag28sJKe1wEqCrvsZClichTczfZLZaA220AcxXBK4NU+SFCdsmzBUmixKOh7MF
	auYcnVW5EBTD7uhXA5tkH6oHg3UPNjfQfeiXFAvWNf3VbgDwCGmyVF5ovHwxGKybIjjWoKYXOA7
	usMX5xXyv/zI4+d7eNcwtd9wU1Mrvk7SovX8G6GAiwuPcg4iC7P9vl9l4Yjp/dbf9Pk2CSlvIhw
	/m5dolPmzk6nvD6L6m0PNySis/Jlm4SCEgmNfGtnGy6NypYaRq6Y+J311D9LsGZa8ztR2GEFp1k
	LDHazA84cxlG5xmOJIijg0bBHpLR18IVO7nbBekT2k4hwaCufe9Eio8JPYcvqZb8xXKMdgxC+MO
	E=
X-Google-Smtp-Source: AGHT+IFFMGQELOhee441f3hfVlskDcHVYSyft1CA1/LFgX6RrnJxMgUqeZOwcEWvRatCceHUxRfGqA==
X-Received: by 2002:a05:6512:40c2:10b0:553:2311:e1f6 with SMTP id 2adb3069b0e04-55a23f7fad8mr2256705e87.49.1752834852016;
        Fri, 18 Jul 2025 03:34:12 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d9176bsm203689e87.161.2025.07.18.03.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:34:11 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: acourbot@nvidia.com,
	dakr@kernel.org,
	jgg@ziepe.ca,
	lyude@redhat.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	rust-for-linux@vger.kernel.org,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 0/2] rust: add initial scatterlist abstraction
Date: Fri, 18 Jul 2025 13:33:33 +0300
Message-ID: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is v3 of the rust scatterlist abstraction incorporating feedback
and code from Alexandre Courbot.

Changes since v3:
- After further discussion it seems we need a variant of typestate after
  all. A major change for this version is to introduce unsafe methods only
  when using one of the constructors for a SG table. Otherwise nothing in
  the interface should need to be unsafe.

Changes since v2:
- Drop typestate pattern. Introduce SGTablePages trait to enforce ownership
  of the pages to SGTable.

Link to v2: https://lore.kernel.org/lkml/20250626203247.816273-1-abdiel.janulgue@gmail.com/

Abdiel Janulgue (2):
  rust: add initial scatterlist abstraction
  samples: rust: add sample code for scatterlist abstraction

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/scatterlist.c      |  30 +++
 rust/kernel/dma.rs              |  18 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 405 ++++++++++++++++++++++++++++++++
 samples/rust/rust_dma.rs        |  49 +++-
 7 files changed, 504 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs


base-commit: 23b128bba76776541dc09efaf3acf6242917e1f0
-- 
2.43.0


