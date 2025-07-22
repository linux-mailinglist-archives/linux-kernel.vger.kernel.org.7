Return-Path: <linux-kernel+bounces-740730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B0B0D85D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DD416AF38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D632E610E;
	Tue, 22 Jul 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDC1EiVR"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E6F2E5B37
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184233; cv=none; b=UXLk+zuWVaNvd+adeWCsbWkO7svKaCokge80FPdluCyVLd4PpdO2Bpb7s1beSMI5IXNj3sIzyYFOeGbd9UZjeme91IfDFBSvef19elkiw+i6Kuah9XBB+18yn6oQ2ZKOFsmyjrlhqc+Y7pjTlzJdg56OlP8YiuyeE2k06ZrPKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184233; c=relaxed/simple;
	bh=ZJY8qtGUgQlA8qvim0awplqEecy/dcGjZSuAVjiJKHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujsZDj4Zf0nK39nfudKec/xr5kKPpBhqiQJNdTqiK8hcbUI+EMwvFt6YwoiRiMM/32CWEbkwiYDohKP5UAbpbUoGD+iQ/zOjFLVqhPR+Kt7m++67Px90FZhpLSShwCzbaPQSnKFzLSZziU4JayXYQwgegf9jUC0UxgSiQJ0QybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDC1EiVR; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab8403b6daso54739641cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184231; x=1753789031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJY8qtGUgQlA8qvim0awplqEecy/dcGjZSuAVjiJKHU=;
        b=CDC1EiVRrfgFciKSmktZ6Rdjngwbn7CsmUImqN53OrRUGyaM1mViV3OZX/R7oUaOjk
         IJXjOvyLQjniElbj1M+GUv3eAPL+w0HZ494QuZT421ZNZeYg95fbXHSg0UBe5zU67cSd
         z7cAhyK/aLrDuJeRZrH8kgAqP3NqhaKO3Ex8X4ZZdT2jyOGa+xVWT1jwikV1zhX+sWCf
         o7Ef2m4O0/lrX2wQYugD/Dpg7r1J6iP7sFQHENqDIh1VrK7KBKdFO4zGSd75sfhWdpof
         tKyUawvb7r3fzVpH3GpMhm6MvUKj11FO2MhtkbnAbROs8xsBZD8G+zmrQ1EeEiPlSf8c
         z9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184231; x=1753789031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJY8qtGUgQlA8qvim0awplqEecy/dcGjZSuAVjiJKHU=;
        b=p2iQCHgE794rovQ6mJpDhVWyvNglyFHF0BWHqIUnDcsbqI2KVqmLGpX3wA/P0Gz8P4
         vgPyxYMtB94s3t11eDTlDNTgHU44Q6M3zSO/FLAEMQPgC7yeyryJ37NCYS43j1wcPiTJ
         Sf9mqatdbk4ZZ5JLrBDs/Y6+rsIsmegvfP4bacjQgVebsSO+Xjm2nVV3JUBqGX+KTTj1
         zZ967fh8dF9bv2ZW6hgrM1jKWrogd1hfAqxZNJoE/tz9QRp+o95APAs4tjbyjoDttYIh
         5jDdisq00LP8gWzZUHiS7eqxow+aMHEHhZbzpC0HlkOBM4CJ85ZhYCjk3A+CqtUQTWSn
         X9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU0r7aaxUXE0Y98LO2codOWPhJ2YyLRm1hLfURSOVyCogkfdNlmvR8LwRWULdI4/rIEDnpbW0oAHUmn6bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweol0mkzDDdQqDuEWldrsfc995H54T8acjUaA407aLDtQk+VvW
	4SL0ieUwkMiKgQPokxadHBv/5lR5GW0WtGMvtH7Rp1ibk32vYRaMEG20
X-Gm-Gg: ASbGncs5CAHvb/i12LttYz+YJUJU8v4AizOZB4Fp9S6gxn+P1lDU0waztzl1vqqIpG0
	fEZfx5lLckPsXUPjRd2ir81xs9DwpDXpV8HG7mrKktMFWLeaTDqTF3ndUCh8XRxFwnZKs95j6of
	fYG5dhZr35YoITGIynwG80nvUSeMiEicgsKSnOIUmribckBJPKAbjDfWZUMIlQj7/KSkWHJTKS0
	oCyh5bG76J7fu1YLPvnXjwfcTgR9UiOPjTDYTEReWslLUNORfs7GGrzg8L6fBbnY+aMgaQhUkET
	HxM5/CCQuBPf29wPW7NtC4/CGeZETsZs1BDRhaLgGm069xXCNMXK6C12esUl6bmPQXDGbvIW7JX
	+Ax7WI/cSLDyJ/Fe8PvL7eOtI3uSuEP2XTZ/wxK2LzeJD
X-Google-Smtp-Source: AGHT+IG/VROa7DFbHWN083FiyvMS84kqd91Se2FIk+/5gN86UuAeNsXXzk4B9nGlUF3mJXOiN+c+gg==
X-Received: by 2002:a05:622a:5b0d:b0:4ab:765e:5fdd with SMTP id d75a77b69052e-4ab93d46e2cmr320748811cf.24.1753184230945;
        Tue, 22 Jul 2025 04:37:10 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:37:10 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 07/11] Shebang line was missing,fixed
Date: Tue, 22 Jul 2025 16:47:03 +0530
Message-ID: <0554048c9680165c09b99edd80815952cfccc050.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the shebang line at the top of file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 samples/pktgen/parameters.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/pktgen/parameters.sh b/samples/pktgen/parameters.sh
index 81906f199454..419001ddf387 100644
--- a/samples/pktgen/parameters.sh
+++ b/samples/pktgen/parameters.sh
@@ -1,4 +1,4 @@
-#
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # Common parameter parsing for pktgen scripts
 #
--
2.49.1


