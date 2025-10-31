Return-Path: <linux-kernel+bounces-880588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB502C2617B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDFB1B22C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D853093D7;
	Fri, 31 Oct 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORVqpIt1"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE0308F17
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927212; cv=none; b=ZTHmdsU3kVt/ng/INNOHW+anyXw+9j1bVGMltdfrb7BWRoGQM6vLKukKZZQk9bzMIALH+ZgUTGFC4fcHMJ/r6tn6oeGDI5YtwbF4zzXKPnLoHSKq+p0SqCp6cznjO2yW5Ro76lq4UrymddCgR5Sf1IGNK2NCXRsHyVPTa2dt2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927212; c=relaxed/simple;
	bh=9RdCBa4+4sRCwXB20xmXer78rbra+zl9rgLx/Ct8cus=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Yp6CteUiB+7RIgDsn+nODSuyZxTF0lSZMvesN0HLqHzxq+Iq65LXRBbYTXTWfoHz4G+gYb+e5MCJlIijfB4zL2A68kgDejsg/JwqXmOEuC2og7OEee3lWAByGkmLyLpcaO8fHER1KIslh9H4o7TICE6/h/LDfClZTsiVgLDDJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORVqpIt1; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8801f4e308dso21163336d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761927209; x=1762532009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2xkF6zKonfubE7Gp45g4295GunQ1O6+736QRxZvvn1w=;
        b=ORVqpIt1GmcIbDzbHsdSmDxORXdoKcRKGqL25FqvEJ0kc1gcyxGte81BM55QZyD3K8
         jpxCCykrkM1QDVeYAjXI173urdb+58NPBWLTLEO5Pz1MbSEeRB9S6yQ2ySIQQ/yq7Y/J
         4AxNuLFo2kKv6WV5fpJWgWzRFSK3brUMrwC+KQHFSHngNzP4syeKmL71OwV5DLrmn+NN
         hfEHCbi4697f1zdB008F/a4f7AosnFlGZE94aK0HsZkg0lKVv4Prchm+A8nfv7YWC58x
         mno3k5J+/GiW8opwg3lhoOw+N54wfnguxHmaA7747ylFWiYX+5GYGE4bAgzjTbg/G1qG
         y9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927209; x=1762532009;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xkF6zKonfubE7Gp45g4295GunQ1O6+736QRxZvvn1w=;
        b=iDqwKFHHA/3BiVmhAvzJB5HbPWsuBKYoOusjE//keqwq+xZdQMmC9wSSnI4fdy0sKN
         Nk4ZGsfIM1CDVf9jOzzx7OL3Qqht6qxeYXjgswXgaOryiHRn1cV7/bdRDRd7PebMn+/4
         s1NnPR4V0UDBZkwPDm56i/aqey1EmtTHPSNRBrR4WZwnZZlUrICyp64pHz+q6Wysckx5
         re2mS5BBRFo2NgDvCfXHuiahMIZhtclMHjXqiGLGf2nar83usXhIzDwqYekwKymP+jgv
         JIt2M3ALqzDs8XXSZTTcHkPcNZ6G5oJPrHjo8+jjPPr0BidtMTDuVWkeEx/JJsR61PMY
         DY1Q==
X-Gm-Message-State: AOJu0YxhJ4lJZBFEHTjy5fD9phpjZqj9LB2qv0Ak0xBNVh6GSgbGKsRe
	0+3Md+rDoI+E77fJDkRGatQj6zWf7Cdo/0dVR1iRZzFmW9YMyv1e8qs9KyyrJVJnikVrFIO6+uK
	SKdsXPTG+ntSDvPqCMP+6uJuksm8h2FI2RgjsTWo=
X-Gm-Gg: ASbGncsl4e/1yOB6mi96gt31i0iQ/Jvgy3u/rCaPl051vjlzd6Ybz/u4QuAlIZWPGhh
	QarpSGzE6r5RY4z9RdGAmsjEMugGisE/7bk9wGX9a09+q/TvS794poXTzm/TUOyankEcJrvQ9sn
	B/g2xYnazDcjBXyxynZtTf2XnThgvRZ7izTs03u1daCye0G5T/FfiACpZnwrg2+9DEydxtJl35v
	JQahHsGt2Wr80jb1NPiD3mfI4WN+RM1zlDFrRoUjg/WWRiFWT6eePdk6TOARkfm1wwE26YSZa19
	uwdEbTi4ejSB4TPWgwzhkHPfQywwwhua+w2qwekXY5OnRIy7sxSpzBI44xSOZ/AmxaneOsYgZXV
	xhp46tA9E7USPKUrnQPemMs/nA0tUwlVRVKzFzVnnjqH0AJsW1TXjVtvFjk6a+FO0Z/SyAil/mZ
	wh46Ebvh248g==
X-Google-Smtp-Source: AGHT+IE52OHr9noC3oLJ1WckJWhHadkdiT7DbUmXmXtxox11pJWlk5r6sZIzlJMLBkAH7DXTCdcA9fcO7XZllyQdAeQ=
X-Received: by 2002:a05:6214:20ac:b0:880:415d:a9ff with SMTP id
 6a1803df08f44-880415dacc8mr18734106d6.37.1761927209173; Fri, 31 Oct 2025
 09:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 31 Oct 2025 11:13:15 -0500
X-Gm-Features: AWmQ_blIddoJEuR4b-Bb6q2Sqpv8Ry0bX3Y62WreUtUF4tvYBQPX1WS7N1E64rg
Message-ID: <CAH2r5mvmJJAp1AX2Sda3ungmu7hcaYje2NYS6YtngC4F67PHeA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.18-rc3-smb-client-fixes

for you to fetch changes up to 895ad6f7083b0c9f1902b23b84136298a492cbeb:

  smb: client: call smbd_destroy() in the same splace as
kernel_sock_shutdown()/sock_release() (2025-10-29 20:13:13 -0500)

----------------------------------------------------------------
Four smb client fixes
- Fix potential UAF in statfs
- DFS fix for expired referrals
- Fix minor modinfo typo
- small improvement to reconnect for smbdirect
----------------------------------------------------------------
Henrique Carvalho (1):
      smb: client: fix potential cfid UAF in smb2_query_info_compound

Paulo Alcantara (1):
      smb: client: handle lack of IPC in dfs_cache_refresh()

Stefan Metzmacher (1):
      smb: client: call smbd_destroy() in the same splace as
kernel_sock_shutdown()/sock_release()

Steve French (1):
      cifs: fix typo in enable_gcm_256 module parameter

 fs/smb/client/cifsfs.c    |  2 +-
 fs/smb/client/cifsproto.h |  2 ++
 fs/smb/client/connect.c   | 46 ++++++++++++++++-----------------------
 fs/smb/client/dfs_cache.c | 55 ++++++++++++++++++++++++++++++++++++++++-------
 fs/smb/client/smb2ops.c   |  3 ++-
 5 files changed, 71 insertions(+), 37 deletions(-)


-- 
Thanks,

Steve

