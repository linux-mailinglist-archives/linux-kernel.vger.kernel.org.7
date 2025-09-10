Return-Path: <linux-kernel+bounces-809854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A201B512D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BD71883044
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38E0306492;
	Wed, 10 Sep 2025 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmflZhe0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F0241139;
	Wed, 10 Sep 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497264; cv=none; b=fA/mL1YkB5QUZ89aC2FJECB7wfPZ0sDCFMxz9Qh7fQ3WFKODWXWDtr5Ty7/3PzMiCEPz3fv9Ix5yqTI1lf8YaIJytNWOgEUwx+2v330V4Ne8DXi320VF7PE9xJO4gD55+AjbOL4QDfSZ2X5rDkO3ILJIQOP9oEXrvs3CVU7/nY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497264; c=relaxed/simple;
	bh=lvYn9eg1hctElf592ouO63bzTtzzMC1s11sttsG3hY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gj9ORfb5ExuRdL+ksEXj5kG8ppEq2XLBZf21lBpwpLV5igMbJrms/rN2ST7fxL7NUinMxtm+KLBeQ6M1RU9BxhoU+MohKkaWoVsMQV9HJv6JlM7dviH9XpCdwc4m8Mw2M81bpuf5iwtiYhpfqDgHqeOOhYCKLdNvtZguLFwfaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmflZhe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2411C4CEF0;
	Wed, 10 Sep 2025 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757497263;
	bh=lvYn9eg1hctElf592ouO63bzTtzzMC1s11sttsG3hY8=;
	h=From:To:Cc:Subject:Date:From;
	b=FmflZhe0+ZE/C3s5kFN9yHv/9+4iXIfFth7Px5CjvIQcKjN1hW/AJWLptjUS3SadT
	 t6JHC6Xg40h8/7/TCCKDj/BgVmg2KZ6hzlS+SQKqkfd9jqCWgeW01++zeUXUxRN1Kg
	 wYrAE5ScFxKKrGIUdO9Gk5l+FyvJEOFTBgR+sYxYKLKOr//Lb113mHJOLMv+9i6wMz
	 t2J6aYuZwxUGz0f+ulS+hJ6s1hZUOHc+Sb62j1wTj7cUw4KapRvKnq6T/jBwLE2U3f
	 BcWtsUTTR15vXZnqVz4miQn1ohkQaXxqOISSyBR6Ja05xFuISIC13ibYQiQyv3S9QW
	 IkX/Gsg5a0i+g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	abdiel.janulgue@gmail.com,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] MAINTAINERS: Update the DMA Rust entry
Date: Wed, 10 Sep 2025 11:40:03 +0200
Message-ID: <20250910094015.11551-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the DMA Rust maintainers entry in the following two aspects:

  (1) Change Abdiel's entry to 'Reviewer'.

  (2) Take patches through the driver-core tree.

Abdiel won't do any more maintainer work on the DMA (or scatterlist)
infrastructure, but he'd like to be kept in the loop, hence change is
entry to 'R:'.

Analogous to [1], the DMA (and scatterlist) helpers are closely coupled
with the core device infrastructure and the device lifecycle, hence take
patches through the driver-core tree by default.

Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Link: https://lore.kernel.org/r/20250725202840.2251768-1-ojeda@kernel.org [1]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..281149d9b821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7239,15 +7239,15 @@ F:	include/linux/swiotlb.h
 F:	kernel/dma/
 
 DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
-M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
 M:	Danilo Krummrich <dakr@kernel.org>
+R:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
 R:	Daniel Almeida <daniel.almeida@collabora.com>
 R:	Robin Murphy <robin.murphy@arm.com>
 R:	Andreas Hindborg <a.hindborg@kernel.org>
 L:	rust-for-linux@vger.kernel.org
 S:	Supported
 W:	https://rust-for-linux.com
-T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
 F:	rust/helpers/dma.c
 F:	rust/kernel/dma.rs
 F:	samples/rust/rust_dma.rs

base-commit: 3c9ba2777d6c86025e1ba4186dc5cd930e40ec5f
-- 
2.51.0


