Return-Path: <linux-kernel+bounces-740722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A8B0D851
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83801C26DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79CC2E1753;
	Tue, 22 Jul 2025 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeFpFi0r"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F728A1D5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184215; cv=none; b=CkFQMIUn+2fQEfxzLsjB8q9CLjDFfRGCmOnQxflognJvXewk+LlwUUoYHyuRRSq0PLHxVB4cfl6Al0J1pAOyXB1erhOXimfQe0fMbNyT7oy5Ie3Id9aIzpIFkGRtF4V48JUMuHs/+sQgcqzvS4steHvWRV5YtV5vGsNwBonpWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184215; c=relaxed/simple;
	bh=6//zenhPNQDHN7K+9U+Tx3PsCjGiCETDp+TJHqjhyiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIH92mZM2SqoKmULWRTHL3i0eezLHAkw/Aj+bSTn+n+ZNZA0xY7eWSJujI9UB67z8mPGvtUio4Z5o1TGFTDCIlR4AnjpVaSj478xmwdTkTjb9dPMuFMPL6YcE3hFnR1qtnkQEKrHav+cMgAIkzmp0Sw4bLcd/kp40Uu6hA9q1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeFpFi0r; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab814c4f2dso101750311cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184213; x=1753789013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2Qc28pSvII7CBXOhS40nwybeXCP6W+fSVJVxYE1KIY=;
        b=NeFpFi0rTebIkO4gxpDKa463ZyKWnbMCJnbCpDizdekSomXjSM266zJ2egGwnky5NH
         pNcvQI8LLV6HdczjUjibgtzrphH8fvNHweYB2kjauMocvwfkbemWZVxGlZMgW7VHLyuJ
         lF3FdjIYIc62G/zsG5C/KKjrPpOkNzgcadKMWFv/WvQwdD+9Isiqkuq70GqvtiIS4R8R
         WBpdwQ5u5b7FAjr/GWYP38ILrIw6ZPYCsYiFI5koHk0pu/riPcLjBjLKK7iU1G+bK68b
         IrYsQ4AnrDk4OSdXS3vm+hOA7IhavKAzrEXpkAp4y7I12SCHPlBy2N7B2Pg9FzU9p49u
         //jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184213; x=1753789013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2Qc28pSvII7CBXOhS40nwybeXCP6W+fSVJVxYE1KIY=;
        b=iOLs35/rtGTlI8cqgUWVJiWCU7Ff6xc0Z3KIi2RzjAMZopayjWCHTUIDaMFvQERmlt
         W/rHg93jhlDw9YYJdv+36Jh2zY69F92fgqWw62IP2ySAxaEqf8Loj1b+PFmORx1pKJqU
         /ADKBp4IdByPV5Q512lfmCpowNknfxWwpI2c0vezbkUKQ8Tg4ZytKtAf6ChyLA5u8hVV
         dRoCProJEi6xaryK+cdY23/o8ynntZ2eQZGiNpF4fNsMEm7Hac2PKngBP3kAIafhPm95
         gcQPr2zf+O+bIezuMKu2lM4pxkc0k2NH/WE4oQV+09dr4CTRfTDYsG1ipRrDZ2m0nrYs
         zV6A==
X-Forwarded-Encrypted: i=1; AJvYcCU4A2/ppQVQBwWYrNc92lbv16lOCZ14KXPsDsByyHu113aIyBDE+ebfahDZif9jYnDWfQ0z7GnlGACBBRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBVtGfpbdMU5yv7e6A8Zp4Vq88SAMDafNagU7egVSgt8pqiec
	bCzQb1Bndsy8CSB3JD/8kMtLv/6DaTZ7mdi9fJUEEUdxOv+RSvlVdZGSP6hq9kaxWaE=
X-Gm-Gg: ASbGnctrg49ywJNo2mgTZgBkaaPB3TnBye7EYH7zk0UOK/+Ug1eYqS4SUcBkzXUBmIy
	LSShMSXrnJ3Z0bewfLSQVhKDkrhr/7gkip6U0XvOrI3RYEh1X6bgfmFtIqRmjlzNfyqG3EGUvCB
	7j6iI3eUp6w5K68spTNxQOyTcMLYEg/RdKBu+tDBpJoJQCyw3mMONDxiXYbsxpsvrbmiR2WnVHH
	LTb8fI9s4sO2E9xUM8DRMD3L/1W5mF9gJLH84MSC8OZ/um/2ygFl7dm29KXqqh4prU649aFI0sB
	rCjL4IyoR51/ryKpbPVUYikkdhLVt+4gcTdQewvlDJothZfo/lqLlOCavjdM32+M1M+FIs/u9R9
	wJwxrBC+7hQ7LeWHGkk4+amM7unotg/C0hw==
X-Google-Smtp-Source: AGHT+IE9u8ONqS70Htc+SgVgJOoI0p5qMyN2myTex8rkJ6I6NM6DNOwDFUBUpWuJ6/RYEvFmZ+yolQ==
X-Received: by 2002:ac8:5854:0:b0:4ab:533c:1098 with SMTP id d75a77b69052e-4ab93d98966mr320032841cf.35.1753184212597;
        Tue, 22 Jul 2025 04:36:52 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:36:52 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 00/11] Various trees,shell files missing the shebang line
Date: Tue, 22 Jul 2025 16:46:56 +0530
Message-ID: <cover.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a human being with flesh and blood.

Shell script files were missing the "shebang" line aka shell interpreter.

Note to Randy,

This is for your spare time Eagle Eye stuff, if you could...please.

Oh, I might have inadvertantly added some harmless blank lines too.

Bhaskar Chowdhury (11):
  Shebang line was missing,fixed
  Shebang line was missing,fixed
  Shebang line was missing,fixed
  Shebang line was missing,fixed
  There was a space between bang and shell path,fixed
  Shebang line was missing,fixed
  Shebang line was missing,fixed
  Shebang line was missing,fixed
  Shebang line was missing,fixed
  Shebang line was missing,fixed
  Shebang line was missing,fixed

 Documentation/admin-guide/aoe/status.sh                     | 2 +-
 Documentation/admin-guide/aoe/udev-install.sh               | 6 ++++--
 Documentation/features/list-arch.sh                         | 2 ++
 Documentation/features/scripts/features-refresh.sh          | 2 +-
 arch/powerpc/tools/head_check.sh                            | 1 +
 samples/pktgen/functions.sh                                 | 2 +-
 samples/pktgen/parameters.sh                                | 2 +-
 tools/bootconfig/scripts/ftrace.sh                          | 1 +
 tools/perf/tests/shell/common/init.sh                       | 1 +
 tools/perf/tests/shell/common/patterns.sh                   | 1 +
 .../drivers/net/mlxsw/spectrum-2/mirror_gre_scale.sh        | 1 +
 11 files changed, 15 insertions(+), 6 deletions(-)

--
2.49.1


