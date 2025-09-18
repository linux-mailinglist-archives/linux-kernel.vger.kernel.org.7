Return-Path: <linux-kernel+bounces-796460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E889FB400F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B467BC12E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08AA2BDC1B;
	Tue,  2 Sep 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZCRd08B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860429B8E1;
	Tue,  2 Sep 2025 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816931; cv=none; b=SJBaaEMKKmnLZDn+X27Hs2crsYUoorlEShfKB30KH/oAHTE8706/2qED6r15Px4U//dpmb8TLJCbon7yoxhvZwrgIjnoJB3yYHNYff9x3UGkN6CysNoKP+jmEzStw8CIwGyzqY5vWg1yyAUqQuxHLGsB1/z7FSUdqfGJ/5UC4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816931; c=relaxed/simple;
	bh=vfVAXgi/xoadFdLNQPKyg6IA8NM2WS3piyY2GDuRiDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9ZINF7559/J1vFqdossfV6Ig+P5kRgpal7HKzSF6WZYIxvVnF70Q/ohLYDXHX7eurOpAPqagXcRc4p+AkS/hlShbQMRcxFXuR7maAXs3i2TGo4hgdzci/PzauowKwtq75n20dArjI2iOa/M7i1pLZ1+jH3AOOlPY9T11dA+GwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZCRd08B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6360BC4CEED;
	Tue,  2 Sep 2025 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756816930;
	bh=vfVAXgi/xoadFdLNQPKyg6IA8NM2WS3piyY2GDuRiDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZCRd08BOuFqi4xDMDXSY4mSBtD7aWXhCzNa1EiUuStTllrufiB2M7hX8WQyL3d+H
	 yfNUAeapHP1iiF+Ui+BnCDAingaYfo+kqDrdGYDIpe7zstaEehQSjbI4C6EGgLzlRh
	 HU5PlaKkR0iAMcUeCPx+HAVik87lGQXUtS7XH/9yRBCqpFjASpBXIOAxFNTbv90ukh
	 JC+SWE4B1OBcOUf/foBq7kWn3Ij6DZNIBE2Sj5I887z68tnm9I6m9izLKVRWX07j4O
	 QEgc8d1FxpkcNGaCL8UuDCV6wGjxUileXxvVUWH62Fp5oEUY+eZQ2B6FBL60zEFxrn
	 Yb7lcQkSNmqDQ==
Date: Tue, 2 Sep 2025 13:42:05 +0100
From: Lee Jones <lee@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: herbert@gondor.apana.org.au, jarkko@kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, Char and Crypto due for the
 v6.18 merge window
Message-ID: <20250902124205.GL2163762@google.com>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705072045.1067-1-zhaoqunqin@loongson.cn>

Enjoy!

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-char-crypto-v6.18

for you to fetch changes up to 74fddd5fbab879a7d039d9fb49af923927a64811:

  MAINTAINERS: Add entry for Loongson Security Engine drivers (2025-09-02 12:29:57 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Char and Crypto due for the v6.18 merge window

----------------------------------------------------------------
Qunqin Zhao (4):
      mfd: Add support for Loongson Security Engine chip controller
      crypto: loongson - add Loongson RNG driver support
      tpm: Add a driver for Loongson TPM device
      MAINTAINERS: Add entry for Loongson Security Engine drivers

 MAINTAINERS                            |   9 ++
 drivers/char/tpm/Kconfig               |   9 ++
 drivers/char/tpm/Makefile              |   1 +
 drivers/char/tpm/tpm_loongson.c        |  84 +++++++++++
 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |   5 +
 drivers/crypto/loongson/Makefile       |   1 +
 drivers/crypto/loongson/loongson-rng.c | 209 +++++++++++++++++++++++++++
 drivers/mfd/Kconfig                    |  11 ++
 drivers/mfd/Makefile                   |   2 +
 drivers/mfd/loongson-se.c              | 253 +++++++++++++++++++++++++++++++++
 include/linux/mfd/loongson-se.h        |  53 +++++++
 13 files changed, 639 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_loongson.c
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/loongson-rng.c
 create mode 100644 drivers/mfd/loongson-se.c
 create mode 100644 include/linux/mfd/loongson-se.h

-- 
Lee Jones [李琼斯]

