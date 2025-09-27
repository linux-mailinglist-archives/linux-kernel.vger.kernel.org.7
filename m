Return-Path: <linux-kernel+bounces-834790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A51BA5868
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C874C6D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527D1221DB1;
	Sat, 27 Sep 2025 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ea10qfzU"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686617A2E8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758942458; cv=none; b=Ahpki8mxpiX5A1+buNn+xJiuSSv/r6Kb9VKjM2U7T5MQrKXGMWzu8GUTcUOL/qBDPno8+iNgZimrYbA5Y4+l2Tn1KDT/SpbBQnkPrbctb4G0BP0A958LRpp3jli7mqLdCt8Nft3B1CgmybBEKVYoSL/42zpdXcvAwkSu7D7plNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758942458; c=relaxed/simple;
	bh=ucrbnxHbs6y8rfjx9+39n5L5p/YEYkoVyR9JIDN1sHg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Zd1aayV5lH8e9fxEHYk2gTCv2dS9RVhjpwXy+1s2sFAqzcygbQ0I45gxYL58k/AFNLfkq9J7jNQ8ckDrUFfcq7CxcgY44sqYYTbnTXv1IK3mt+4PQItrztCw0e7s3nq+jLjVzew08T7sGhHCSxTWnT6vC8iY5FUdMGLhZ9lFRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ea10qfzU; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-84827ef386aso188137885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758942456; x=1759547256; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qarOpL2GufODFN9/VORlA9hfhsH3FKJWScm5xbA4n6E=;
        b=ea10qfzU3wCzJOzfvkdKZ03UYUlgB/8bkV9jQHkLCoWAQsSLmshvl1rTLjjIt7K4n1
         OFzEmX+p4L3WAPRUu1GXffGT0NyP2UA9ELNlK+mscaBwLmq401V4NzUu3ZNh8pNOXnyj
         QCnVHwQrCWoyxBSHM64lvae6Qj6UghZsfFssF80RWFwSkPrFYlW+N5Otf/2FlCTM034g
         auCtIFHPQNWlDklkmdsK4VUcSQ3RYVc66Ckg/78AZtmQUK4rzUieO7wYHlMpVLfb26CV
         Ay+XaVST/WYvMp7Nl05pBIgg/pqwhj/DYUfk4Q62BqiSktqcx+vDRy1PAd0n9X+OpLv+
         KhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758942456; x=1759547256;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qarOpL2GufODFN9/VORlA9hfhsH3FKJWScm5xbA4n6E=;
        b=fiLFDDQKYXVARGgCdS2RIidi3V8OUcEpMm5oBXv7QH7rY/98bCAi/XfJCiZMv9m8k3
         22pDYhiavdsjNF7T0EMlJTaB6XDpDZ7ynw52Mz82fh2MrUHTODy2ctXzoXpinFGuViYu
         mrLYWW0DM2qMVwL41yr4mttv5zIbKgAlt4GkHq7Z6TAnws1ioOB5xB59SOiIn0TwK3SZ
         ZgkJY6fVXYfIoawjYoSmfGkiW3MkLkUB4SV7Ut8TwvHuHnyy04N6zMbeWAj2FHo/5mDf
         DXaEw7XToTHCZ5Z7A/xkToTywBUm/kLNXv9cfN96GUVGf7gaXeddn6CsZ6IDjQMXFweY
         x+dg==
X-Forwarded-Encrypted: i=1; AJvYcCVOVo8SCrqxYpz2ZCdXD0tBRmVCHPZn5seWCp9QWug3Lyf7gMxWUSFyVa4GU5VFYNRiZhBLCHuMg4dg06U=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZSjTRnBc3eOLaknIRAHGEKKTeERpdDOSA3lri9pKvWUqWdUF
	7e3sPcTteWEZ8RtGQzE0SKd+CbhttnZUiAoiJrok8pWJkdRzK07Zb1TsJPU+P4lRb0QIMSGjr00
	f8VI=
X-Gm-Gg: ASbGncvTNnBzcorEdNdWEyhBeNUWoOSSHrDb7WsFJygf2uQTs+dw4/emj3uhJDA6sXp
	GmSHUXKVDHj09Zxr7uuS4FWSVsW2KzIbxUR7gFrF22FIiB1Tae0M/fMz5QUAww5259sO/Wyd/HP
	vkBmlOInmcNhqWLcGtM7BLS2o2shpQ5AlH5l4LRHbL+tIJMwUNx3t+eLzUdHQfM48VUAD96Q9Qk
	nVNjmlTX+fBxgDywr3lMYmXsp6u6k62PsYqMj4IqBEb5v8uNxPtCHWclnJltG2RUDB1xaCCuCau
	8JKzWkpS7g6Ib+K/fPxZsgnIQ9CEZIVf6qzxEDeP9Yu7w0dw5DoDExCb7mOQx3yoPKBad64dzoC
	QUvR07RBtLLLjqFLK+H2gQ8VsZvLaeJHNgvnrULXvj/UhCHYhqvKkwJnvwTXZrnxsXjBb
X-Google-Smtp-Source: AGHT+IH7/95OX7mDmeLwjFg9UQBqc4U9wVQ3WQqLE+SJ450L4afnkagQt2OSLDQqm/vQMLWRbYZQVw==
X-Received: by 2002:a05:620a:17ac:b0:865:cacf:e11d with SMTP id af79cd13be357-865cacfe675mr27248685a.12.1758942455861;
        Fri, 26 Sep 2025 20:07:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4db11cd52e5sm36709041cf.47.2025.09.26.20.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 20:07:34 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:07:34 -0400
Message-ID: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250926
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

Here are the SELinux patches for the upcoming Linux v6.18 merge window:

- Support per-file labeling for functionfs

  Both genfscon and user defined labeling methods are supported.  This
  should help users who want to provide separation between the control
  endpoint file, "ep0", and other endpoints.

- Remove our use of get_zeroed_page() in sel_read_bool()

  Update sel_read_bool() to use a four byte stack buffer instead of a
  memory page fetched via get_zeroed_page(), and fix a memory in the
  process.

  Needless to say we should have done this a long time ago, but it was
  in a very old chunk of code that "just worked" and I don't think
  anyone had taken a real look at it in many years.

- Better use of the netdev skb/sock helper functions

  Convert a sk_to_full_sk(skb->sk) into a skb_to_full_sk(skb) call.

- Remove some old, dead, and/or redundant code

Paul

--
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250926

for you to fetch changes up to 68e1e908cb7682db9fb7f79907f9352435a81c0f:

  selinux: enable per-file labeling for functionfs
    (2025-09-07 12:54:56 -0400)

----------------------------------------------------------------
selinux/stable-6.18 PR 20250926
----------------------------------------------------------------

Neill Kapron (1):
      selinux: enable per-file labeling for functionfs

Qianfeng Rong (1):
      selinux: Remove redundant __GFP_NOWARN

Stephen Smalley (1):
      selinux: fix sel_read_bool() allocation and error handling

Tianjia Zhang (1):
      selinux: use a consistent method to get full socket from skb

Yue Haibing (1):
      selinux: Remove unused function selinux_policycap_netif_wildcard()

 security/selinux/avc.c                     |   13 ++++++-------
 security/selinux/hooks.c                   |   10 +++++++---
 security/selinux/include/policycap.h       |    1 +
 security/selinux/include/policycap_names.h |    1 +
 security/selinux/include/security.h        |    4 ++--
 security/selinux/selinuxfs.c               |   18 +++++-------------
 6 files changed, 22 insertions(+), 25 deletions(-)

--
paul-moore.com

