Return-Path: <linux-kernel+bounces-747121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F1B13000
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 411887A520D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13C086344;
	Sun, 27 Jul 2025 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="iOEnQwZv"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055521423C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753628664; cv=none; b=aI19F0fi+riyNPDMGtz0YUmRQ7blwQIPVVmRngwsOxGhhARhpQRHCM0J1iBz6woh+gy7v+uCsYkm1aXQR49YmjtibTvZ4l+L6m88HC358LEdOl6bS9+520WYcagJSZ7RyZDOBlcx3+oE1pr9Ahli97+5lnxgy1TwVFMfwAELivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753628664; c=relaxed/simple;
	bh=lq0rvADk0ip5/mydADtM0En2DQCVdDhGMreH6FgPDVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdbQJVlPveoz4SsGplwhv+R/BIo8PxI8Cq2mAPC63gDXhjlq89u+74ACKVvKfJtKquA6f9gSgzrb4NFyhjVXaa9hT5THjrNQE5B5MTaw4PkxKIiVGlpO+5OGAo34uRJKPxPlMKGhFqEC2xrZUcenX/2U+98A3W0SdG5+P/y8OXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=iOEnQwZv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2402b5396cdso702625ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753628662; x=1754233462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I8fMaV7c+UtGlaRMtsdXr3vVISUVpzDVRmnS+us0bO8=;
        b=iOEnQwZv/cVZs2U7/iys6edJfNysimk7xFgnXVJun2ATq/8ab9oIn58iqyHiUhzN+1
         F/evwjxkJvFUZvqanlZwosyoBAmUagJFn0dva0oXexwxUPDWdDJ54Y7vxbf+Tb+BsAq4
         KLfqT47wWABwAjlGusEubViRLWf40XMytiCjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753628662; x=1754233462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8fMaV7c+UtGlaRMtsdXr3vVISUVpzDVRmnS+us0bO8=;
        b=mQfcGM7t4F3CLsTKGs2NdcTdmpkwaYogY7qXO1davlULrj3aQFIRKf2oT4Brtqih/E
         3Rb+JGVvJZZOfRGrTIWIon8hRK2DDW2JWKctjjz6u1maJgJP1LjsVpeYFZnZxDZZeUOq
         9nE7jZZi4ymw5G0khFoEZr5xnt/A078Zy6JMIAem2luu9FzntbSRu57N6shh097YA/5o
         bGQ/29XBou2BzyrIoCsoNCn1P4xOhr8cGF/PLlFGAd2e3s5jlJaQwtcERiL3jlabZ3Ec
         b64PMuOZjRmH/F11yoh8fYINJ2iVr79AUIi+ct0aPCm9vcMyt72Y4PRyJAc30cvieJTY
         z1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhN39+SWNFz6oIyuRD/D8hrG1Vv5yyITosHvLMU/GHbFm80cYdn7rk/eyoDKKVcRXV+iKXpXGPONK7Fas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuS2H8qiSHRGzMkXGJyE6Zcpa4Sv7+vwAxAORzm5tXSqWK4q+E
	yXn/kKXYsLcGGv4BGRBZ2E1kQ3fA8WDmgKup+IcBWJJJMAAr5jVuz7L8euXN9fGAiz8=
X-Gm-Gg: ASbGncuyKL1wC+YTquaSgiuT2Wf9qubBTjyXdgRZjv4Ap3Owo1qeqMA1GZmh3kbIojD
	xTiYebHpjj/JGa3q/Fx9WFCjCLnfDxXbC3sEI8Z6TMqpqhxRCLCOz5/FIhvrD2LH4nIKlioXVrh
	Ly/4xWzThWa3aHiJTnbmezk84K88qxewuwAwTFN7kqUk3zBV/0ZcBHeQeiZUKvbsm+ER7ldYz9C
	rKI+ELZD3nzKutpTRznTndqLnvEz9Yjw71K3PLHN0WMiXxZaabcrQYv7OzNfO2p/Z6u5FMr+z+8
	E4s0ED/c1XTQSQgL00CMByjmoJziuj/4hFmSc70wj4BK2p0+9MYmi2GKVnKgRK3gDDihDy22DHt
	3knE78xlpCNVC3jR/lIx57Zc2y0pdogDRRxYI3TLrRI8uGDvUQeLPAnsQtyfK1Y0OLcVOsRyK
X-Google-Smtp-Source: AGHT+IERy6bHNyPQYc6vhNgW+EwcyEcEdVXT80IqNzqwwqkceUiP0GUosARdB51ehMoaNIFf//OcvA==
X-Received: by 2002:a17:902:ccc4:b0:224:910:23f6 with SMTP id d9443c01a7336-23fb31675bfmr164192955ad.45.1753628661986;
        Sun, 27 Jul 2025 08:04:21 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffdec96aesm15381965ad.165.2025.07.27.08.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 08:04:21 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v2 0/4] rust: miscdevice: abstraction for uring-cmd
Date: Sun, 27 Jul 2025 15:03:25 +0000
Message-ID: <20250727150329.27433-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implemens an abstraction for io-uring sqe and cmd and
adds uring_cmd callback for miscdevice. Also there is an example that use
uring_cmd in rust-miscdevice sample.

I received a email from kernel bot that `io_tw_state` is not FFI-safe.
It seems that the struct has no field how can I fix this?

Changelog:
v2:
* use pinned &mut for IoUringCmd
* add missing safety comments
* use write_volatile for read uring_cmd in sample

Sidong Yang (4):
  rust: bindings: add io_uring headers in bindings_helper.h
  rust: io_uring: introduce rust abstraction for io-uring cmd
  rust: miscdevice: add uring_cmd() for MiscDevice trait
  samples: rust: rust_misc_device: add uring_cmd example

 rust/bindings/bindings_helper.h  |   2 +
 rust/kernel/io_uring.rs          | 183 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/miscdevice.rs        |  41 +++++++
 samples/rust/rust_misc_device.rs |  34 ++++++
 5 files changed, 261 insertions(+)
 create mode 100644 rust/kernel/io_uring.rs

-- 
2.43.0


