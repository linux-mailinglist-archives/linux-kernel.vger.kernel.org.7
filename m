Return-Path: <linux-kernel+bounces-888659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0DC3B8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6E094F9A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0173F334C09;
	Thu,  6 Nov 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh5x04/u"
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A78302174
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437479; cv=none; b=uQc9LrHDRdu4c9jE/HZDd+2pDCcBlekF7WT+naW4WC8FBzYJEEz7zV3YKlHTwB1gOkkOvia49wFO4BfG1nyxuTGAzfl/J+ddKE/VtFK9glket/GYPN5R9sZ1rN6QDx/krD8Km3ynQwGQFuxtrVr3T8KP0Ikz9Ont6AKiTxNmWok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437479; c=relaxed/simple;
	bh=eAcUEUze+QlCXdsbwI+Wip9ydBN282GhqtqUvWE6FHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UUUhh8TWQzN18P2+m6C+q1qkZa1KG/Rrr03fblXd6U4+bHSyhWySnJcJpOt/JHMJAD/2uH1tRJQjiKMidnfR2sLCw87hv1p0hpyf7zQ8eJT7W07iCgwo18Ff0ztBcKmKgG6iS7+0Fe+KkOA46SxNr119zZg0Cp3fbuAH8u3aLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh5x04/u; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-340bb45e37cso171162a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762437477; x=1763042277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye7hjkGVC3kxY/pLGCymOWaVgNGzirgT5n0GDI/IGxA=;
        b=Xh5x04/uWk34LIGX2uj2pcrB9F6oj0IgUeEsDwJ4JuhI2m/5ApyNpCbJjrurFmOaAr
         /9V50OcXNRn0dnP3lpghEw4W95ZH0lcruI/Bq6a9sjMg2GPilUV8uMdJhvtP/FaWA7ul
         /XqYZE314+/YWFJGnRd/lDfhCuFmeWkeCbJohKtEEwdHzdlY7mnsy/bRtmsvyVR8xPT0
         VjJY9n6RfYZIGk8OPORE/UXKK9g7amDatnbetinQwWJHlFfS1qVQh50mIB+EviIm/9p/
         s9sCxwVsvyTSxV3+BMJfZtkIvzq0cb4qnqJPuevG8TGvT6K+oyKHXBb969iGojh7naOw
         wxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762437477; x=1763042277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ye7hjkGVC3kxY/pLGCymOWaVgNGzirgT5n0GDI/IGxA=;
        b=pxVS7Lw4WxHrHd8HbpD/HZlVpfwm/z/wJHiU5QpEGmvHNShXAr9drFIFF01nrIRehK
         eWQep7X/syU2yUzYs26e0VGvau824/fd+twYEIOtHZw0B4p4fn5NjIciN0Okxb2ELIj8
         Q4iW2gr3IjS1EtOBU4FqLFL9AwVxMs37Hi4KSeYHMmbyllXDQvEi/IYJpppNLV66Fnlj
         NarzaztHExHZ7nNxzHR88ZhBD2DlIC4uGMJvr0t0+vIKGhzo5LmVGSP7I4xB5kKqZ8v8
         QMB63N3hFXEXKYQorfPeHmEdAEOZDdtLkcnEZujUaNTGeTi4U95ps9uL8VjsOWN65daA
         98dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxE1sNOD0zOZENTm7A2hXqwOxWYWtxxt8piOhQ5KKUQYAK13pQPiYxEUt6xZWHi/jhiR1U04/FdqtUsPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxxUstwfbYkTR/X+y1NM1vEh58KPlqDJ1LUV2rWxJGKn8YNDdL
	83x1br3bUNDnAX3JOWTXA942hDEZ6LrCUz06RViqzlNY5V3kXSTDb0mF
X-Gm-Gg: ASbGncsyhHIOQkD6aiAzHhklvI1UE4NDrIw6pkHZpgmkdg3SWgsZ/koD9xVxivrhz/I
	KcOjfujADDsTeauepjwe6Cb9hLgKh/XVmf3qxKv1oR1GS0kyG3VXxjQaiUhQk1+V6B6T8JF0hB7
	cfpc4+F6b91vuTXgFsApbHlfUZGfqR+k+OsvqJIbVeDmfaTBxxRuLhWEkktUIb9VsBegbYNTZx/
	v0M4YSEDEAFtJeB0F0MBbJWQhRwHOu7dxg7sjINWsqG5Z1hxBjwiUfAk6+6tVHmchMrzPHE/o4X
	19i7GDA/0g2ySvBZ7fir2ladN0g7L9nqsR0HR2/5mrYSZo4dbI4KtwQW9hfp9ocakE59pShN69i
	1pCan9LNB7U352Y+ds638OhjyZlIRQzKlN/y52/qJc70u4+e5pD5HQZq4Weu+8QU8KmTQLhdA3r
	8=
X-Google-Smtp-Source: AGHT+IERxPG30t3/e+NFDrgeBwt4EvMMnzTNurxDkEDboeY0n9L1eVxcF8JjHJwX4YtJqsdtg75lqA==
X-Received: by 2002:a17:90b:2ec7:b0:341:a9c7:8fa0 with SMTP id 98e67ed59e1d1-341a9c792c8mr4751076a91.4.1762437477075;
        Thu, 06 Nov 2025 05:57:57 -0800 (PST)
Received: from user.. ([58.206.232.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68bf37bsm6439593a91.7.2025.11.06.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:57:56 -0800 (PST)
From: clingfei <clf700383@gmail.com>
X-Google-Original-From: clingfei <1599101385@qq.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	eadavis@qq.com,
	ssrane_b23@ee.vjti.ac.in,
	syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	clf700383@gmail.com
Subject: [PATCHSET IPSec 0/3] net: key: Fix address family validation and integer overflow in set_ipsecrequest
Date: Thu,  6 Nov 2025 21:56:55 +0800
Message-Id: <20251106135658.866481-1-1599101385@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Lingfei <clf700383@gmail.com>

Hi,

This patchset addresses a security issue in the PF_KEYv2 implementation where
improper address family validation could lead to integer overflows and buffer
calculation errors in the set_ipsecrequest() function.

The core problem stems from two interrelated issues:

1. The `family` parameter in set_ipsecrequest() is declared as u8 but receives
   a 16-bit value, causing truncation of the upper byte.

2. pfkey_sockaddr_len() returns 0 for unsupported address families, but the
   calling code doesn't properly validate this return value before using it in
   size calculations, leading to potential integer overflows.

The patchset is structured as follows:

Patch 1/3: Corrects the type of the family argument from u8 to u16 to prevent
           truncation of 16-bit address family values.

Patch 2/3: Adds proper validation for the return value of pfkey_sockaddr_len()
           to catch unsupported address families early.

Patch 3/3: Enhances the error handling to ensure zero-length allocations are
           properly rejected and adds appropriate error returns.

This series fixes the original issue introduced in:
Fixes: 14ad6ed30a10 ("net: allow small head cache usage with large MAX_SKB_FRAGS values")

This coordinated approach addresses all aspects of the problem discussed in
the recent thread[1, 2] and provides a comprehensive fix for the IPsec subsystem.

[1] https://lore.kernel.org/all/aP_X8sFJKWVycTn0@horms.kernel.org/
[2] https://lore.kernel.org/all/20251027205955.GA4074718@horms.kernel.org/

Thanks to all contributors who identified different facets of this issue.

Best regards.

Edward Adam Davis (1):
  key: No support for family zero

SHAURYA RANE (1):
  net: key: Validate address family in set_ipsecrequest()

clingfei (1):
  fix integer overflow in set_ipsecrequest

 net/key/af_key.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1


