Return-Path: <linux-kernel+bounces-889699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80254C3E45D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C9E188AD95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F712F658E;
	Fri,  7 Nov 2025 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzRfi/MB"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC52F5472
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 02:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483320; cv=none; b=rB0YLHHNLLe6TEtUVz5esTwXawVlzLRwRXvT+xSy6WAOo7I7XAvmRSy3/MEO49SPgmlaIfxUn/fSahEutLAMF4PNnei/K1yWbETKOr3ABdX4jp4avc1EUxADqg2omi0y8FeS1rQ+LPEY1r3QzYdD/63+aVzsSiyg6pK5d0jxepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483320; c=relaxed/simple;
	bh=Q7q+6HE3gBACuPDLSuVD5gMut5hwjMOGYzMwDa2J+qs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ycp0ZnswMa2pyOM8OuxuN3+LTCs3Sw3VzjNms32ANTK4ncejXFTwdNbi8n20sLNMy57opgpmPd+NtRjKNcohtg02UYNJ7c/z779/e8vzA7+l8jpruMKlEj2bGcTddE5HcuJ9TWqzW/HXgftaFYby9yYgmzufKSs4/0nUnNLMpDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzRfi/MB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4e896e91368so3126161cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 18:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762483317; x=1763088117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GuX6ozITqfxTr69Iutw4PA8KBIRjaj56s+0CHhG7Hc4=;
        b=ZzRfi/MBNUwy62nCl2LQuaeBgZf9QuIwgXlmifrcxiQ9wQB2hZceILSCyyyq5a3NSH
         Qkl1Dlrz8VxlR9as6rlFKGXexn6tpwNDxmuycuLN/ehan6Cnxv0nc/b3CS1J6AI93kOz
         UFISTpAWS6SLjz5MN4OOYDSiVFeSYhfFkIWXse4bQUQmsySjKdmmISNgcqTVlXp577HP
         dhx8HN2jY3PtuuaKc9iRSou36LhclmqAxe2pm1OYS58CRY1QT/k5ihPOmjlHQOTLf1Ko
         YtHX3c3+/SsWckO451NgSrYftoILqYG8H2l3vl+Lh30c0v24aotHlGe/hVDRt/Brv6rw
         Jd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762483317; x=1763088117;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuX6ozITqfxTr69Iutw4PA8KBIRjaj56s+0CHhG7Hc4=;
        b=em5vJcRTIlZrOq68tjcoWAD6EUPizO5ngvSt9ex7hAUzOGFdhtqJ74pmp8GFtUcGca
         XZNsh6SzDRtRcFpnJGkkfXo9jJymqlVo78QwRZNDmoRzoEn82IM7JybkjvoMn270hxOX
         BjnH8T/v+LRJfaWVsWj1I8/Tnt6YqFFPZ9vJR1aErL8oIFkBetYxI5VRSd6g0bCwtPHb
         iI7NiAojYlTodb/EC0edQ5e1NmumtaFJLZ/4fkqIqF2UKiMQm9PizVJnDMiAujpt3KIC
         SroHk8sZ/yI2txCshHGQ/NDcpxak7jZdCmBL0Gd7ZzICx5WwyFUI0kgfcR8oR/KfB6cf
         p3+w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6qQK60Jjs52HAGT/ISeQwE/eXbS7D46ssZMS8xcC4edK5l2PV3/i0XhDEhVSoHSw1jcFxTI7rZSFKN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjucQ1v489of9dVqLkKeZ6m9m2nd9Ozg2rky+ChGdxwnJzqroj
	GYaeA3Yop3XVgeKXIct4KKDh4REWdb6hoDUYmuWIcw6OV7JHPQXimPYzVW7Nm1OSja6kZOPYR5/
	f85pZFc/sKwWKSOm2PkVwZuzZrW8Hyu9acyxv+WQ=
X-Gm-Gg: ASbGnctlRJSZjqtIO67Gog16b5ca5opJgERD0kVHLXoYTXOhHm58G0Gv1PK49Q3Cl3G
	PeWT+/aMbWBtRyq5lKg26Wg6PxADFpegaZl1YGSD7FlLIdagST7EiFYqPr18eGxz9+uz3OLp+2X
	u2jwiaNeul+xxKmIsCqB2STB3NuWc5w1/Fmrn+bVLkObGDzrW9ntsSGqMB0gryZjLtcG56CQp4h
	s65R+mr3jiO2+FDNFViuDw+PGk9Svs5VK1E7QiDGn9N0IMO3bZLTvHkFAtbl5cnWsL3WKUUVk7u
	2KEjjCVt8UU07+LQxaO7iiKczA1x5ip5FKse74b6cFT3U1zbAdO3xEzk1pn2ZtjhynA0/AVbtd3
	8MNQ+/ERP022mrp6GxTsOSUkMvyoBYPiCBhsdTJP3YKtPBFrnIrPds4Y2A2M6cVeTx0MlVtOc8m
	Hmy5lB1FwlKK/WmHr1ppc=
X-Google-Smtp-Source: AGHT+IG8du6mXS4YIE7YkG3FvWVLy9rkbo78r1iMccu8LGwiFJHEj4xS/Hg+LBgGfZTkQH+wVD0xqjBucNgSkcKvQgw=
X-Received: by 2002:ac8:7f4f:0:b0:4ec:f486:9f27 with SMTP id
 d75a77b69052e-4ed94a96916mr17252291cf.75.1762483317518; Thu, 06 Nov 2025
 18:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 6 Nov 2025 20:41:45 -0600
X-Gm-Features: AWmQ_bldFeideAXahC5S_-_FMH2uBiWUtixisdc9C4fudEWjXpTcI-FD3T_b3Uc
Message-ID: <CAH2r5mujzgdeMzwHrTaeK8fBNrpjcWyHCQkNq5Lm85ADL2pYew@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/v6.18-rc4-smb-server-fixes

for you to fetch changes up to e6187655acfa2dd566ea2aed4522083f0bb940c3:

  ksmbd: detect RDMA capable netdevs include IPoIB (2025-11-04 08:47:55 -0600)

----------------------------------------------------------------
Two ksmbd server fixes
- More safely detect RDMA capable devices correctly
----------------------------------------------------------------
Namjae Jeon (2):
      ksmbd: detect RDMA capable lower devices when bridge and vlan
netdev is used
      ksmbd: detect RDMA capable netdevs include IPoIB

 fs/smb/server/transport_rdma.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
Thanks,

Steve

