Return-Path: <linux-kernel+bounces-880060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4834EC24C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22EF94E571C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF1C3451A8;
	Fri, 31 Oct 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkecskUt"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF742D4807
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910059; cv=none; b=MSfqIt6m0e0dVpRoC/7NQ/7ITZvMxu/0h6NF2ds4E/vRqwKS8qLBajd+ADytVXYi1A3EpuLbIgHTerg3vLBm3z6n4eY8bovA8KnPAa6xLIcGIoze6Gj5Qsgeh/nsnbcwPbmNfbDJ0WnNniOR0niSSF4CRSJZ8QquidqYQUEngvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910059; c=relaxed/simple;
	bh=IPuXV6lIBcqOfrwOexC6xvGZcz1LmHT75V+kfc1/ojY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1nFlGXVEPkpIYKgylQ+9gs2kiNBcKcHHlES0b+798uOB2V/Tq/DUeOTXmgU95yoS+pacuppQT5EUKoSgxIv3RZ05zffs7dSso1vkBW9qTKWzDRS/v4Ss6hCbk2y84O3XFF1Eq56q/tYz77RKlmisIaEEW5HHE4hxcluoLYoI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkecskUt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-780fc3b181aso1586790b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761910057; x=1762514857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=841lRTZT5x+EU23D4TPPYc3iU3UALNZmZRcvpFA9gCE=;
        b=PkecskUt/ox5Eyf+Y/6LbEJyPKHjvmCOIPkZ7zPm7EW0YHSSREw+zSDQrfUSZ0aBuz
         /DLEXLbaVDZweFC7lVawV9/VeIbg72Q8CZGSx31XoHcgNNg3t9O7BGZP9BtE7QyTE7Ec
         zFsnZXepIYdF55qZREIbLXMxJPrzcdmpg9wT1HZjMJyyY4VCtc2Jfi+PA2/By58iUFeL
         RDxY3PGUYiNTA6IbMWN+rGMK+EVOvHY3wpQlLZHMWuud9sNRiTUw6Abj3X6H7kd+nH99
         L7PuKPOvVXgAo8naSUJAMP5W9d2Tq4vnoIZ8C/gCSKKDyuD0HqhBuwme7Kh/a6C4yRZI
         wgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761910057; x=1762514857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=841lRTZT5x+EU23D4TPPYc3iU3UALNZmZRcvpFA9gCE=;
        b=JWaNpuo4XnDZVxg/zI+Qq2DT/x0BfK0UCnnkStZpw3UMEViEGm8Ccb4UPUVICxZfJh
         s4h1PLsdj9OnxdkQHV3eW7/p87LBiwOO6ru3aikcza6JJVcBGterELb9k9XxXG/Yvnak
         tUHBPMJb0fBTAovGfvA1lZ2NUs3SwXTlOjGulucSnRz+XsfQupgfIIypH5tmXY6pGEjc
         SHz9gvEEj4YRvsVr5a3Xtl7upJRlwxx86mXgH+CK5f6VIdF7tpjMyIsCMuIEvn3Qn0T/
         x62Ss0u9KSi0RrJbOE9J/wvuBVypxUSAFJdTysn6kqVo3Vycl2cIAlwjS1RqBS1S9OX3
         3KUg==
X-Gm-Message-State: AOJu0YwJnU842/Z09UELOZxAJf4DY3/NmiAPk62RcNVi0C2Y3OHZRLme
	PP5xpHHYLNpBDssllV2QjZ9VsIEAkY2SG4FOcR2v1EGExZB/sRIkLNgB
X-Gm-Gg: ASbGnctaCJR4etWXzTofRYmi6v7TTm1H/KEySDYc5xSESnA5ZrCUnmXSwFUuMNbnw13
	rr2LYYwwFfg31N2csaf8Z4K69S5ofpj0p8DpGU+x1b/pzvCtgSdXHPXvGXYbfowfvw2fK6x3c6X
	oCzz8Rm+xCYmQcPn8pT7Iew8+yI1USWi1lQOjVkW0zqgRWnCj//vNvxJsWIbVjagzofdHXYwAhL
	Em+T3rpUVnYYJF4iPv4Vh+KxEzRJlScubv7Kd1gbuNKdQR7DEegJyHR+Wt67H76LKKXtpcECFTb
	CKDkcjSQd7CRBiPdPuDqsh+CR+KomslqkcWXZTqLOyFDpVCnNGC0P1/SftjZGT2l/tVVDDkV55j
	j8+ic2AqYAZfdjguM4AI843JD/pFF3/MLZYXtdDn1YUSnKmwUFzS8mA6XC34In7FL4r6Ddrp0St
	LMK/rAUNMuLFg=
X-Google-Smtp-Source: AGHT+IH9hYEkyK3AXZ+IMp9m3KiAHOe4yc444P5qMkA/mzNCRPgTC75k9sFDT03UAxG/sZ06ANMb+w==
X-Received: by 2002:a05:6a20:258c:b0:2d8:ce9e:87a2 with SMTP id adf61e73a8af0-348ccdfd2cdmr4592558637.57.1761910056860;
        Fri, 31 Oct 2025 04:27:36 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bf44dc8esm1827291a12.35.2025.10.31.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:27:35 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 094144209E4A; Fri, 31 Oct 2025 18:27:31 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux RISC-V <linux-riscv@lists.infradead.org>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH] MAINTAINERS: Remove Albert Ou from riscv
Date: Fri, 31 Oct 2025 18:27:03 +0700
Message-ID: <20251031112702.41271-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=bagasdotme@gmail.com; h=from:subject; bh=ILQo4TDpqVd/Vz4HeogVsmkzW+Qi7czkZpkAAN/N6kk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJksc6QmeZ96rKO2kH0W45Hn8yz2WS/6K2Zy5c5P2X8KD 7boS9q96ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBELBIZ/kp9fnl/59yp3F1v D61MWvjRU+Gy5DK2d0neU055dMTVuaYz/E/Z1fZra6XOohvssxXltGorq31CKzY9yee/rf6z9IL ySRYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

From: Charlie Jenkins <charlie@rivosinc.com>

Albert is not an active maintainer (he only posted on LKML three times
in 2019 [1]) and his inbox rejects all emails. Remove him from the
maintainer's list to put an end to everybody who interacts with the
riscv linux mailing list from getting spammed with rejection emails.

Link: https://lore.kernel.org/lkml/?q=f%3Aaou%40eecs.berkeley.edu [1]
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Link: https://lore.kernel.org/r/20241205-remove_albert-v1-1-17eb850f1540@rivosinc.com
[Bagas: Rebase and add lore search link]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
riscv maintainers: Please route this patch through fixes branch of riscv tree.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a796b82..c27d8ad6677c57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22084,7 +22084,6 @@ F:	arch/riscv/boot/dts/andes/
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <pjw@kernel.org>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-M:	Albert Ou <aou@eecs.berkeley.edu>
 R:	Alexandre Ghiti <alex@ghiti.fr>
 L:	linux-riscv@lists.infradead.org
 S:	Supported

base-commit: 2e448567839c65768486d56612c88cb327d26050
-- 
An old man doll... just what I always wanted! - Clara


