Return-Path: <linux-kernel+bounces-835758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC1BA7FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F0C18953D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8650E284880;
	Mon, 29 Sep 2025 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKS6uQUh"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1521F428F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123646; cv=none; b=rnTmEMigvYRBI60H5sxsY0HXCmtjPeGTzXjtbkLOoNVUGILV0Fx2nzDvcJV9CPqEqGEz/4K7GAb7KEafeyq0Y7OZqIF5nUoCPsE7r4YANGLlJFxbOgUaOvfWU4sX2vGMe2lkhsMRYj0IBHw3i0r7oUtURmikehp9IY8vqwxlIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123646; c=relaxed/simple;
	bh=0NiOHakfTmoFWZh8rfV5EHJ+Dc5FlUDe4sVlxp/w39o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYEzwDwKHPXhFriT2at469XvAiRg7Jlyzc/oU5Hbnqs31iBU/bEgQPI6LMmIoia9Yncusfnbc1HTXrPtOnc+gbFg4dc5hAPwe4LSCnpb/gNMEeeC7Gnsp6kpPjTifSrHpqWsb42ldQ347VF7y4Ti/2+ig2tu5EZeShfi0zYfxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKS6uQUh; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b57bffc0248so3257411a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759123644; x=1759728444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBoNC3hiqOU4l/l1DzdLcpvA7kcnMf+nX8xh76MMsns=;
        b=bKS6uQUhU/2FbUXOxy27meYOBu4hqsgcznRStH6jdJdKVAPkP8x0kfUfhsPC2nF5wE
         JP7cjaDYivOX5Jbho8bgFjAAiYkQsKAx2INn692LCkjMzgQMoXSgiWr5g+lgGv4/VZtR
         UHWhMFpMZl26Lg9a7weVxrdTzvtklLFPNLWaphdTQwMMm98l3E26c3YRfJ6EEjYAWREF
         ZXyhAfV56CQmer71XjpfO9TWCnibf7nqnGrIKh8+yIHmQgJJWX8vUm4rLIykK7XtPPPH
         CRocSiTFTeGN6Ov1nXD+qNL7Xhvdi4YOVcs9JAO9EE75/ka33qaQ1T6Ivddkk4W8HgLj
         ogKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759123644; x=1759728444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBoNC3hiqOU4l/l1DzdLcpvA7kcnMf+nX8xh76MMsns=;
        b=t7dCW0LVWtQBT9ZzVLM9kekJ1rz+hH6YsgSkEr1B0BjQc/T8UaEdVMRRmALfitC9LQ
         keeeR64wCmCHtZEmS4h6FsdBLuA3Si3XLxkwllNGvqDqRI8oIvt2ILHEkUqf1AwGOj0p
         nZ/m8cnpdFlgVs3Vzatkxytl3I5/e5N5l8qtNpP2fEFGgP7LXJt/GS0UZIkNB/goEHJD
         PIqX3CsCb9ehkVKOc8stozYt28yvEC79CyVxc9CKM1HlLtex51wFEuMCXvR6Glozrqwv
         DN+emcjwL0pxelQM28gjQ+9j6GgJL/TB1/X1vx61mZIcpVqituHxFGUBrrEH5r3KR8Ca
         w1Mg==
X-Forwarded-Encrypted: i=1; AJvYcCV7W8FKRXYDOg5nQieS/9veiCeLhPzTawTZuUVEisNKfswN8Iw2zwk7vyVM6llRc4mi2Xn3pa3uZZMulBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8AQhdjqKrtskvRPY1kIvfH0ET3P1WkRTwzceZtRYrp6Gv8RW
	uO23GAHlOT72YIKKtNp4XV2UnpTQCY0dJdyJVWQwPmrf0qnHZ4OAX/9J
X-Gm-Gg: ASbGncuJytfwCBwWpfbBXCn2IMBBOAzY4nseV2I5BIHnafWDvCUnJSNn0nt7difi7IZ
	ohp1a6aCNnbnA6E4+EqB+gBReC3IOLNvFXc9HOWfkWwKklYCCYsJgRrA598uOTeyDhV917EatGI
	/Pm8kBNs+idg6x9csHlH2MZuYsSSz0jgnF8OWA9w/8GEYoglG2qbM9Dur6oPFsdeg1aUbMbHHH1
	WHnkGG4ufUNBsYGoo2VM9ozLG44yS9sqaUMEX3m7a8qSGcVkil/7HsqEU2j5jDmNBNkhYWSfBlY
	Zr1trTyjzSvQ6doh1SVBGkjoBISgUg2byUE7FI4Vq0xhHSS1vaAoi/fPebzjuik4WilvjaYqVpM
	ER2qy6bZMr+3uxR5ieLij3F28uPZ5VemNxXXb1Rs0TwMM7KQHXfZrS5nSkIjjerOR+r2H+qSoMF
	rYLesz2p3nz3B/uw==
X-Google-Smtp-Source: AGHT+IEx6UKs8efPkW1dX5lUxh0mkL22O8o1vZNeKLKlkfHQM7u0IeFx32nwKXg+SVd891dUgR2uzA==
X-Received: by 2002:a17:902:f60d:b0:267:fa8d:29a6 with SMTP id d9443c01a7336-27ed710a48dmr174142155ad.25.1759123643658;
        Sun, 28 Sep 2025 22:27:23 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:10a6:37a8:772f:4db1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d310csm119207755ad.10.2025.09.28.22.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 22:27:23 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: yi.zhang@huaweicloud.com
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
Date: Mon, 29 Sep 2025 10:57:18 +0530
Message-ID: <20250929052718.334986-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zhang Yi,

You're correct that ext4_ext_check_inode() should catch this. I investigated and found why it doesn't:
[   18.824142] DEBUG: Validating inode 2 (no inline data)
[   18.835777] DEBUG: verity inode 15, inline=0, extents=1
[   18.836793] DEBUG: Skipping validation for inode 15 (has inline data)

The verity inode reports inline=0 when checking the flag directly, but ext4_has_inline_data() returns true at the validation check, causing validation to be skipped.

This corrupted filesystem has a verity file that somehow triggers the inline data check to return true, even though verity files should never have inline data. This allows the corrupted out-of-order extents to bypass validation.

My patch adds validation before caching extents, which catches such corruption regardless of why the inline data check fails. This provides necessary defense against corrupted filesystems at the point where extents are actually used.

