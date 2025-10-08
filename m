Return-Path: <linux-kernel+bounces-845350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A0BC48A8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9923AA8A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9422F3625;
	Wed,  8 Oct 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS6b8rgL"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B675222562
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922665; cv=none; b=uhWmldgIWeXkMHEvLj+ScpkiAwKYAvGl8vZHIms0fLvDYTsVYoeXSuSuXw/LHuQTWLTyc5tuYy7I3mTvKORut+GOC5BLH8z4eKJKInQt34qadhsGBmCJZ9FTs5tSHpqtYWgIggHo0sxEBQkzYpdqgjk/KjVmvAL74Zz9TdZNtdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922665; c=relaxed/simple;
	bh=KhgwqCmWQnKf1NGRM9QzpocddkHPlKhp9lU+qW/BhUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LK57oMo5WNuTNkJ3WKQICdQIK+AKka3rOGyqMrXhb1M3aqEM+wu1HAnxzaRBj6pNsh+hHiBSWj0UcYfBKcLRM/0fdh59FGpuQpPVc9sXDLS9Q2K7AR4i1LV25WbNORxeGnzDfRTAQJ2wjfR37W6IWfPMq5GaJ2lu1zBYmjRvLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS6b8rgL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b556284db11so6866906a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759922663; x=1760527463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpunCpJAgk2eLHa/FgrPVIG+nR6l3Db8tqGL3tL6T3Q=;
        b=KS6b8rgLfxaiL0nJqMlG9AFR6qZ7W6E69TeujeBoPC/fESE32iPnnK4oMT1Wlrfx5S
         1t19E4aRcoCV+vhk17rxCTOWopt7Jcnhl8AFqqS7ILz39yglcbio1mKTqPD3jLlvBsZY
         BkMxibSlYRO58lyipLmoIX2dVI1W0Gke+Hcv/1N36bYm5j0Vv0hlaNQhAm+MinUbu9n0
         9GPyfvXXReZOgxKt2xzGJ2YQwG4DWYf3RiR1DBpH8pWyYmeHsIvT21ZF/SLrJqzyQtwg
         qAnsNcTUcWHTNFjHh6LGhLzWPQ7tAzkENjR1n2YS8h/vLN4cH4NX2TDFgtHVUqet4ExF
         AvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759922663; x=1760527463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpunCpJAgk2eLHa/FgrPVIG+nR6l3Db8tqGL3tL6T3Q=;
        b=F6v0AUZte/XsG9H9JQBJv1duoXmA4lOWHWvR9u1gkVPfjN3G8Suh4VNchktp3xwhng
         s3rhgXFl67qp+U9VtaFTREaOy+KjNHqj4mkbs1cRI/e3HzSUGSV4lkr6XnykD5ELIst4
         TVrebiPuV8OakFGZVJRdollZAMv0B71gRBgh3PtDoZvT3xSFhouYTPVWuUKapN7tsUoZ
         nnmyE+kSV+nsMXER4BoG9MHBfpUYPN6ynlowTzd5OhYmIfckkSWCkDBb6i26yTtD1sHV
         Btwkzc0dagFgisYH/EuKFPkhW3btqaHJsJ3nq9IqX+kmGFpoNF1UpirArPdAVyxcN9wC
         XPzQ==
X-Gm-Message-State: AOJu0YyBupFZS1SI09PhAFNRr01AqA2TcsbC2yZxFdzBLqQ6PmZFzID9
	SZetBAJbxX4zaB1OzF3KVvcOtp6NkFO+HaWgR59xo5uim4/A2EFQI8Rq
X-Gm-Gg: ASbGnctGGQpyrg2kIJYdVVcIssTXpK4Nf9cg29SszSDPhH7wNFEXYLeTnNQHZUUNhnP
	fHDy6BqcYgdYCeOr0YUB15qjlPs3Ipp+3AYVYoPgCeHTk/LzU6VKlWtVZkFzMDsCY/pLp/mQx0B
	Nb5QZzTKTkcX54kdsOPaGK3PA+/JaCkTkNq4sutQ5I7lU6hWyyxXUMATLk/KeaV87NlCB5GG6Lq
	uupvDFcHED/lwNRsZRtkHxbcrQfGgA47Ax8XAayqcxZ4HPf2VA3wFBZwaGuk/0+XHwT1knXrxGf
	BhvKgTBzJnzNKoUdjJ4P76XupIWPBC1F+wqk3nQRI+PRu+cnwa282c9XIqyIWsxi19pnVtbzs6n
	Jmi11e6m3k/pWycA+bSaU3D8H+HAInZnhQBX9shHJmH/D7i4t0A==
X-Google-Smtp-Source: AGHT+IGzccRUgsYIfQOv4mK4YMIOcoXs/vxnypDZjs9mlFa+b6ZL037YONwW6vYEs5SdhyVUnUekog==
X-Received: by 2002:a17:902:e786:b0:269:b30c:c9b8 with SMTP id d9443c01a7336-2902741e45bmr39405215ad.56.1759922663079;
        Wed, 08 Oct 2025 04:24:23 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87acsm197346765ad.76.2025.10.08.04.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 04:24:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 88AF54235ADC; Wed, 08 Oct 2025 18:24:18 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Cengiz Can <cengiz@kernel.wtf>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Anselm=20Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: [PATCH] Documentation: sysrq: Remove contradicting sentence on extra /proc/sysrq-trigger characters
Date: Wed,  8 Oct 2025 18:24:09 +0700
Message-ID: <20251008112409.33622-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=bagasdotme@gmail.com; h=from:subject; bh=KhgwqCmWQnKf1NGRM9QzpocddkHPlKhp9lU+qW/BhUw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnPPNX+/1pfwGCQKK3s+DfytrPq9rOHNWqEbr17qcH5O qasWDmvo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABP5uoWRYd0dllWvI757CZ/P Xq8s+DNbUjkyhFvf0IBjQolASOktc4Y//Lph27lub92yaKuATKC6kUfyz8MvfrRkFWS9tjsik1j HDQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

/proc/sysrq-trigger documentation states that only first character is
processed and the rest is ignored, yet it is not recommended to write
any extra characters to it. The latter statement is contradictive as
these characters are also ignored as implied by preceding sentence.

Remove it.

Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/sysrq.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 9c7aa817adc72d..63ff415ce85d66 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -77,9 +77,7 @@ On other
 On all
 	Write a single character to /proc/sysrq-trigger.
 	Only the first character is processed, the rest of the string is
-	ignored. However, it is not recommended to write any extra characters
-	as the behavior is undefined and might change in the future versions.
-	E.g.::
+	ignored. E.g.::
 
 		echo t > /proc/sysrq-trigger
 

base-commit: c746c3b5169831d7fb032a1051d8b45592ae8d78
-- 
An old man doll... just what I always wanted! - Clara


