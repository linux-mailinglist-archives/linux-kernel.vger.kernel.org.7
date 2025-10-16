Return-Path: <linux-kernel+bounces-856653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07077BE4B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE155E0268
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C0632AAC6;
	Thu, 16 Oct 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X43P2cyr"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B02E1730
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633577; cv=none; b=gzCjo2YQ2r+9JLzsso5VV84NXxK9P7fYzpcDdDADsB/FLg5VniDEn8U4+WaB5uIfZ2uA5b2bPfBgBm0vr0lEZ8D/u2oxwbKlygg5dWC5ZL/bLDKBWSKsAZEN1ACJJdOc5PG4PlQzEVN4ZlzBgycQdiA/Gc2vdbdhupn19zcgH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633577; c=relaxed/simple;
	bh=91r2Z9uzGui6jXDDbwibTsOiKmukFVeg4rpidFEE7Xc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EeY4seJ1Dh3uVzIAbtpmyS5hBnOZcUmBJjrsK8RWdvJ1VxW+s0QyVY2SNo1tm8TmEoGyckUopNZnkfN7uAWbedabj5HfthCSq5oPMsOJ1jnwR+JOER0s7T679KBO4T7h1P+5L+B/qzpakRntrIhp5IAg7QupAFwyf0s4guJTwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X43P2cyr; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-78ed682e9d3so13298486d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760633574; x=1761238374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aKSl3+cfP1Vo2Qx3JDVFT4eNJLa+wkzdcmaYs35sXUE=;
        b=X43P2cyrB5YBvI6WPgCXtpWcVFq3tKeQJ9A95Ha3fV1E6f9kvypFlBLeFNrXBrA35/
         2MpsguqkrEjFnCnSLHEdMX6Yd0Gpb0U6DPab3sueW7n9efmAT6Sl+L2IrnbnX5vuifYa
         bS9vSHUlOLx4fn1boqMP6TQguliKeFh5EFUid46aF7nCXU2ExT+j9TG8eYdREt3HcAPf
         9Y+RTLOsq98JOmhVSdN02pIUrg7JtHGpNufUKQ31iAl6kthSR2BNTOIutTHn9j2kn4vR
         9P3X6KKVHX55+J594wnzMmY7e3rR/xV5PE3IaX7rKRbZQmqHC7tpjXmZay9foTqaw9ai
         tXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760633574; x=1761238374;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKSl3+cfP1Vo2Qx3JDVFT4eNJLa+wkzdcmaYs35sXUE=;
        b=VHUYmyOdFG1chTNPv8X7z9+unIVThCZqZX2J35c4qdQGiRGeDL4zhDXdC/rnDEjCaJ
         h5FiNRI4h3KjZZ3SjVrSv6Xmcd2L0+g17BZHwSNIie1oaC9GY3+nIkbexZk8AAUkt3oP
         DBacRkU1AMCYWZVhiF2+rvCMJ9RoN2ERhkPznxDxZTBy5xxUffPm6piCYcgMfCdRsaiQ
         bdRcweJTnb7/3E2GeR6aEVVRqo5ZLqvt1QnDnW69t1YhuRe9o44+v2ACNicNzsudxDDo
         2SPxYdI9fETiwaVsLtcSMDhi1RmgwClBrdukecv8uJsrbk/NcEpG4rAeT4qSPVWcFkZ9
         lk1g==
X-Gm-Message-State: AOJu0YwKtbFJObK3OBxQBFO4HjvCX+KGodxlyWQGzK7U6zV0fHXt6TUT
	Pa9wlpp7n8KmtuK9hCvmrY/hWQ1ruhK3ShEiPnd/8f3IIOHQHjguhinVGgzW/B+ah08gyCBhJ8l
	amoi7YmN7J2FPpFZNjT1pgF4nh/604kA=
X-Gm-Gg: ASbGncvMsTXOHeA7ruF37a4tfeluI+e6X8LUvUHPxKG0UxU8YytSMQsNjiFMHRQg6mz
	PtE65qibrHpICIlUpfm2wuyaLXcoR1Qmo5SIh61FQhvZ+nkIxkldl7KBHfX1k1nxixwpkL/u0P5
	A6yBHM8GYgB+7VwhY9VhZ89uOqcP/4Q0qttrHLP0bCbb5JmakFX/mPvGtU110j3At57AAVLqIMh
	FGJllUfrq8sYYD/pj7VcE8XStE3hP1gQ8ZWS1zWCy3Er5kC+lDI05xekveRhv7oPX4z77MIa8K+
	5GRim3nbUGkWMqNNu9eudNi4HQjb49cUxMJrAQ6NNZrnSt9D2p+CMr4UFn5WkmJLvaynoJpxQ4F
	8XuLKo9ZAfHikIyrZa/0W5cAntNDW62BTeOJJ7qkhAccvWUcCGwGM1O24zkbllrlcxcu61Q4QSR
	bI34y7jANG25rluu95D1PV
X-Google-Smtp-Source: AGHT+IGJWK3C6CF6OQJYzlqP095zFMaxgQUYflqcsTg/NQ3H0vdkLJDgmLZOaPUa6ctU9X5Y9xly2T64YAiDFjsV7QE=
X-Received: by 2002:ad4:5dc7:0:b0:851:746c:e6d7 with SMTP id
 6a1803df08f44-87c2055e644mr14330976d6.8.1760633574307; Thu, 16 Oct 2025
 09:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 16 Oct 2025 11:52:42 -0500
X-Gm-Features: AS18NWBpxJH37Hbj1jPUIn9nxP1UtWfLrFrfUeFXBooZHwdcuASwvIpONS-PBxg
Message-ID: <CAH2r5mt98+bMTuyp+AuEJMi8rCo+2PTxy=a8a_gXi4AyLuSG+A@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/v6.18-rc1-smb-server-fixes

for you to fetch changes up to 88f170814fea74911ceab798a43cbd7c5599bed4:

  ksmbd: fix recursive locking in RPC handle list access (2025-10-15
06:03:09 -0500)

----------------------------------------------------------------
Three ksmbd fixes, and one cleanup
- Fix RPC hang due to locking bug
- Fix for memory leak  in read and refcount leak (in session setup)
- Minor cleanup
----------------------------------------------------------------
Marios Makassikis (1):
      ksmbd: fix recursive locking in RPC handle list access

Markus Elfring (1):
      smb: server: Use common error handling code in smb_direct_rdma_xmit()

ZhangGuoDong (2):
      smb/server: fix possible memory leak in smb2_read()
      smb/server: fix possible refcount leak in smb2_sess_setup()

 fs/smb/server/mgmt/user_session.c |  7 ++-----
 fs/smb/server/smb2pdu.c           | 11 ++++++++++-
 fs/smb/server/transport_ipc.c     | 12 ++++++++++++
 fs/smb/server/transport_rdma.c    | 20 ++++++++++----------
 4 files changed, 34 insertions(+), 16 deletions(-)

-- 
Thanks,

Steve

