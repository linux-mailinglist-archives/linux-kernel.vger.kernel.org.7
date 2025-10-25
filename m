Return-Path: <linux-kernel+bounces-869678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34670C087EC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 03:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FD8A4E104E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC1F2139CE;
	Sat, 25 Oct 2025 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvvzzYLG"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9C20FAAB
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761354671; cv=none; b=RBeURt3V+NHELsrDGvrL67fGsApjVaXCmaN+w1ef9sruWZIsW1U3YiseOSvtK3YsLx/4uo+30sqLPKMY/SkRI0Y8wUNsVKaYSnHKr70d3RzQI3hzGFwL/YqhvGnDqeoDhAXDCTZXa3/mIu6Q2EjDS/4VTeYxqiEmlv4UlTYqp2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761354671; c=relaxed/simple;
	bh=vkFLnchn18y3PGU0HuO7wDzePkXF+DMlKXXu3yVYCSI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QJFRoOFYHynwKOZLaq+LNRfL2bdGCTqPce/4iMnnXy7CGt+EU1ZQd39EFCaSt0Q5tQJ50KpZZBdLx6uLj4IxhEju5n90ITxEn0SPM4hPjnN4i0pZi80l+s84AepSInVkY/hET01GYP1+0597VraLTs0i1FyJMnh1ULYk6MbhmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvvzzYLG; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87dfba1b278so28957306d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761354668; x=1761959468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pXXynZiVA7ILhETj4SRlC+eTmkqrxVS2pruELk/St0s=;
        b=XvvzzYLGggzo7N7xoLshem6CY5pxDAGyc+sWuMysZ3Z5IhEuzUnL0dCcZqlZyzdtix
         e5Po7GbTujP3+7gJp8VFb+Y1UaUU4JWu8cbJpQfoOqseb8XvMG2AeTs6yaBbqJp1Crfh
         CcUNXrzgb2zRIGFdSfZjUvqM9J1M6DSl0IFbHyV6Os42JBP81eUXGG3muiHpSUyaz1qr
         pjmj+iLRhg6v5ErjeBpY8b9Urdh8rt+avY2GQbBTsqASN+SgB6q4YI9ippm3BxQyqc01
         UIhnv69dQ9h5lQuMQEs6HKeEMFLGgIy74IoshUM9fS7WHNX4lm2aetTGxKsgDB5tyfob
         h3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761354668; x=1761959468;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXXynZiVA7ILhETj4SRlC+eTmkqrxVS2pruELk/St0s=;
        b=kE8oJ07bssSllEBZrM4Ow0mUaaB77nScarLJ1jLri+U45t+2hM/X6+gUFtA+8uk3W8
         k7+f5caJhmTdXxUI7N2DJ5nFZO85s+hO14IdFYpiV46ktoC6eUtW5ObvoFkcoS3nVEyQ
         4OshOlW4xSoDjKlLDYz0gYH4IW2S3V+zGK5eSk50QmE0Nzgs6XEa5y2SWUxOK0zp30vw
         UK0JVByqObOoKwFE6A68cTBgtqJFlngris7fceEJzu4pzi4l3748ykjP1l/w+/VT13p0
         3xiq20zP6gVKQ9oRa7QfIkkvjvFew4cqGWFD9BP/JNckTGrJ9NqznrWPzZDWDsTf4zP7
         DvoA==
X-Forwarded-Encrypted: i=1; AJvYcCUQN0VSSRBQaLieMufi7Xe9KNmA9hjxVq52xVQz9BX+U9nDy3Z6jrPzdLKjTrtSSFXI1s8s0oUbpAdUxOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwarBVjxVEOeAiahNx9MNVs4iObt+Dwj1RTYC7TbrPuM4uB+g3w
	ueIdpPElL7nKWKjMNOimxdE6LT1m0ADBLoXeeYBj5WMRGlmS1Ny9RlGY25qX/oz229HCf8krr70
	xKSy4AjWOYwfa0WZF3YcUXZyljl80uNPw3PKQKp4=
X-Gm-Gg: ASbGncsv4Pf9YDfKv68RAmf4+m811lXjbSPcAYOAJiEH2SMtjeFJlnSTZSCzKvdXiH3
	rWWWi45mPP3Fr3uKK/V+D0aAQi/QzaILy4MnSWTItf+JO2Pa2caeXUdsRsV6Y9H811Y44bbbTtx
	iOzSCDvbOv8YsueewdalRZgEF7KB2edOxbauYhYDbEWAOUwqWTpLpptxHEAPuHSMqkAtRRgda1l
	jjvEFjOdxwiXz2sbxmu5RG+cqpxHl8ERvXDMIvRvtWC7q2/8tU93HI1Yt6cPIkN9aAD1yL540Un
	4p5/X8UJ8c/lqLEfRZLtRQ1fI4nBx1x+giAjr2Xq71eSAZFugqQiutDocY371xCj3Rf4HyGb46c
	BDf3l5E+vSr89mzLAZIk4udq0A2/yC6Ov+NcwfwmAwQzY6VbaV2d375WvRHHn0eyJ99oyw2XlE5
	d34dppzNjWHg==
X-Google-Smtp-Source: AGHT+IGLC1riZEI7Reuuli+Gtx1S04wkLThtwoO6dLMPrCiDVZkSRZIZ/K4miOs8BpZc7XQeGiqvbgyG8/WTrQJ0SBI=
X-Received: by 2002:ad4:5ca3:0:b0:87d:f3a9:26c7 with SMTP id
 6a1803df08f44-87f9eda1c30mr108192226d6.17.1761354668558; Fri, 24 Oct 2025
 18:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 24 Oct 2025 20:10:57 -0500
X-Gm-Features: AWmQ_bnObCO69NTARUO5wmRbMghuLsHgMFyJ2N1PvDKSWdSvX_SolGwmjveF0jU
Message-ID: <CAH2r5muFRm0X_uYTFySHj-T7YZQhXZWVa4WzKny_YmEzXOhCBw@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/v6.18-rc2-smb-server-fixes

for you to fetch changes up to dd6940f5c7dbee7ae70708f4c8967c3c8cb1d965:

  smb: server: let free_transport() wait for
SMBDIRECT_SOCKET_DISCONNECTED (2025-10-23 20:58:51 -0500)

----------------------------------------------------------------
Seven ksmbd server smbdirect (RDMA) fixes in order avoid potential
submission queue overflows
- free transport teardown fix
- six credit related fixes (five server related, one client related)
----------------------------------------------------------------
Stefan Metzmacher (7):
      smb: server: allocate enough space for RW WRs and ib_drain_qp()
      smb: smbdirect: introduce smbdirect_socket.send_io.lcredits.*
      smb: server: smb_direct_disconnect_rdma_connection() already
wakes all waiters on error
      smb: server: simplify sibling_list handling in
smb_direct_flush_send_list/send_done
      smb: server: make use of smbdirect_socket.send_io.lcredits.*
      smb: client: make use of smbdirect_socket.send_io.lcredits.*
      smb: server: let free_transport() wait for SMBDIRECT_SOCKET_DISCONNECTED

 fs/smb/client/smbdirect.c                  |  67 +++--
 fs/smb/common/smbdirect/smbdirect_socket.h |  13 +-
 fs/smb/server/transport_rdma.c             | 344 +++++++++++++++---------
 3 files changed, 273 insertions(+), 151 deletions(-)

-- 
Thanks,

Steve

