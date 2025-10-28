Return-Path: <linux-kernel+bounces-873815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71068C14CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137424264D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B32DA746;
	Tue, 28 Oct 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHm/mnj2"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAF204F8B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657639; cv=none; b=AfdwBHknNRR8DXViQyTJMDu9mBhDKLx0o2dr9FVXuWMQXpXb2gszi6YGCfXZq1yJmD07FLQJMCb5cIzehWk8+jOCJJfCrEfiquzgRKhDdrK0oVxiuMRdaq5+2AD9fdhWiPHo8SvGnJ9P4oAz5AHvORJsFz6dqhfFXEG5eEd3akc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657639; c=relaxed/simple;
	bh=OraHByRSkDTKrt5+sOvd0Ht/6LFZDkcv/nCwyeH4DNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+19lSkkA4SjxReg90lCwpg9zwIxl8P3QynLy4N3iju2JtKzs+crpIUNRJQcwYWm30+CSVp3atu33Q1qMRjCIgOAgnpzyUnZHJLqQi1kUOHctiODdYSKZsq3Mpcllul3zG+mPoVxiNwLjGqGSLRWRJGwyUEbQb/LAkdCVnbu1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHm/mnj2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a27053843bso8252452b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761657637; x=1762262437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzLIntGDHL7+P055GuRT7nFuEDkNdk58z2RuQjYnrI8=;
        b=CHm/mnj2dpn87cmLzHcWzWMEC7+jnqnLJxAqGrvOw4INkKxqRau3eRaSPxvf0uHU4q
         NpcSHskzE7xCm+jFtev4+ckipvkl26thUpNqSu+02D0zSrw1jKWdGcOHcFjuvCcibV6A
         md7vijLNpkG/bKCkbKOmOQou8nyMMbB4iVi2cFHMcmZz9k6L8r37goPqD2wZJMVu9M3k
         OwlB8y7DONRhTKgD4UqMGrHgW+i31yywF0TyNifAUqoReMKyogL1rkZqxRMLel17mN14
         mxWZiCZa7kjXAG25tTPU3vjYkECJHWJ1xojIfWvVvOo0Gt0InoewiXwNIQY0cKIli7Je
         rdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761657637; x=1762262437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzLIntGDHL7+P055GuRT7nFuEDkNdk58z2RuQjYnrI8=;
        b=jQUTlbHXfSVW9dUCMhvLaOwLtply9u1Bg0wCTfIA9iIMt4Hh6mp9KcYswskVFDOfDL
         pYjRZQdA6ZmynGleowA3aFNRbVqcxIcdd1DJFbA34guaSCjAfr7xJaLsXF6ND281fBDB
         D4cjAC8P2BSQ+8spokYjSm+xbhuJN9WYf99pSLHgKjiBaBi5NQ0eb0f17929oHIUM5hA
         9t5pREw5bAGhaENRHlZ2Ps3GNS6AazN/4Swrk3hnhq7DmpyoeXqCEsNogvWvT9RscuP9
         4qAMXDZgtQZ9jArLBY1VI1+Z+mmsoj8cMVBQ9aJ6pTPuzK1elNVzMdX887L5jBH1XgTK
         8/Xw==
X-Gm-Message-State: AOJu0YyFt3k6YZ0ZuIT44V0xOZXotLReGioAE6fuTXsNW/2Guz06UARz
	ovzIxX4fUlhy4T8A3OopqlW/ChrXM5P38vXW8VqdajCLEPfNQazld6Hg
X-Gm-Gg: ASbGnctbz/kCd85sV87O1R0OAqA79basd3WHf/8yPVuwxqQUbT4k53mm/4GDlCiYA58
	uT7r231i4gdx4MrGafAGXrXjQ7/lDjORs4p8B/GROhm6fzWQIG2JvJ+mMvPI34B0hKKBb2kHb08
	kBadum2BRzdySPVrHnMwcLLqnr4ye8B3dmaa+rAn/MK7FF/qxi3ecSdyGvtTJvbJ/qZzQR+zhv2
	/QaEyt1lOWKmHxUIrOszl4iaLZcYUk7tX0bWblOFj3odrhoCxQ3RicWRzgo7gH18zqBVHofzVPL
	H7cG3FeePUYP3mXwUXqhOW2jD8DH/NL8pN6IUm5a+9FSeqHCmBzxhHK4a0esMlKTXrN8S/x/c+y
	EexMBQdk3UHxe5qDRLcBUtczq3QChOBllHtsjUr2JQJCNfysIMHL+AVClJHyneQsEPI4mbrcU3R
	uE
X-Google-Smtp-Source: AGHT+IE5u7Id+aiml99gQys+AcPpH4Eit68IjE0RkIpz2pZA136//uNZkrUUyLYbvp3Vhsbk8QnGqA==
X-Received: by 2002:a05:6a00:4b10:b0:7a2:7930:6854 with SMTP id d2e1a72fcca58-7a441bbe8b6mr4307214b3a.13.1761657636780;
        Tue, 28 Oct 2025 06:20:36 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301ecsm11844986b3a.24.2025.10.28.06.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:20:35 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E146D4209E50; Tue, 28 Oct 2025 20:20:33 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Matt Mackall <mpm@selenic.com>,
	Satyam Sharma <satyam@infradead.org>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH net-next] Documentation: netconsole: Remove obsolete contact people
Date: Tue, 28 Oct 2025 20:20:27 +0700
Message-ID: <20251028132027.48102-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=bagasdotme@gmail.com; h=from:subject; bh=OraHByRSkDTKrt5+sOvd0Ht/6LFZDkcv/nCwyeH4DNI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkMh4685/SZl8pvmJU++5ua8Kmnm2r8bY5JrJ3fq23w4 6yZxtWyjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExE/yUjw+xdEx9w7H/gPXmG fn/v9peudQs1/eoZ1evVr59axj91fjwjw+3kG/M2lV+d9uu42qWU41EKmnNVjBcFbelOmGDm/Cd nEjMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Breno Leitao has been listed in MAINTAINERS as netconsole maintainer
since 7c938e438c56db ("MAINTAINERS: make Breno the netconsole
maintainer"), but the documentation says otherwise that bug reports
should be sent to original netconsole authors.

Remove obsolate contact info.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Cc: Matt Mackall <mpm@selenic.com>
Cc: Satyam Sharma <satyam@infradead.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>

 Documentation/networking/netconsole.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 59cb9982afe60a..2555e75e5cc1c3 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -19,9 +19,6 @@ Userdata append support by Matthew Wood <thepacketgeek@gmail.com>, Jan 22 2024
 
 Sysdata append support by Breno Leitao <leitao@debian.org>, Jan 15 2025
 
-Please send bug reports to Matt Mackall <mpm@selenic.com>
-Satyam Sharma <satyam.sharma@gmail.com>, and Cong Wang <xiyou.wangcong@gmail.com>
-
 Introduction:
 =============
 

base-commit: 5f30bc470672f7b38a60d6641d519f308723085c
-- 
An old man doll... just what I always wanted! - Clara


