Return-Path: <linux-kernel+bounces-869009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863EEC06B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00F01C04E19
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E92343BE;
	Fri, 24 Oct 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2YE9Ct0"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256A1D63EF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316275; cv=none; b=MbI1Qw6Gh+ymB2totUIaZGFmX+xKKPD8fY1uN0+SKJtVoJGbQOzuWnjeTaqi9m+yZHCisTHMAdqyGxgkahFFzrQT7yIHTW7dy44idA+n9/rjbIQIKKoKuocAVsfHE42ldgKNpRDqUCae7RcInztuHUoAleEyVSkyU/dFAWV9Mjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316275; c=relaxed/simple;
	bh=YwWaL7YELIgYKGB8/RNOfIPO+vpDTLb5fhNB+3MDkO0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EndUviyDfCVwI/1uq8BiN6+Ukgru+BWILEoEAkqxbUMUuf8v1m8h45cL7VlMCWqdvMWPVqtP5FXNCRnweIJ1T5/qBn6M+oSFeP+u2/bVdMzce8RkUkSoO8LbL6AMhkEIzcxt8fVnJQ0SNX190eDXsnscm5s6D7blhZPSS6zoo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2YE9Ct0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-81efcad9c90so22976596d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761316272; x=1761921072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0SfcH6cGIjO4GCF81rPy0gjRHBMgVWt4XFd5yPJO6t4=;
        b=D2YE9Ct0sQbdyKm7QkYZJY5IURTf6OETJ4Ko3D3xNw1UPwQivNeK8HHqe7OhuiPSck
         K9TDnAqv60UI8JluNeFiumJzR2er5gvoohBQ7CSl3Q3mD/sidcR9eQEPX8roCEYr7fEa
         83l42Uz8GD0d3smGmEuaoZcj1PoJRCulIx7dPeWRMjS9ciEbf7gkJj7nMIAz5pXlH/Qq
         sVJH8/T1+oA3cWh6pD71Gx6AeVihHlgpFtqphVcmt8xMqfLRYJNyuU7hxbqIk4MqUV8J
         7MoN1eXlE5PgyHl7BBjAyIeVotcMdUnLuTja7WCuHiwueIBg+SqR1+Sl3XSm8Ztx7+7I
         LbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316272; x=1761921072;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0SfcH6cGIjO4GCF81rPy0gjRHBMgVWt4XFd5yPJO6t4=;
        b=LGSTNYhBw8xJFYugtZa3SZw4rr5kCT8CdouDy+1kHoLCDvssMP/jcEit0GzBnxvLu7
         Vc1hpiVk0RKW/G33/H7f+eDS6YVJLr/215kAE66rPTM/HuhgnZ6oxbz3woD+PVd7Tfgy
         cK1ZLBn+GO3sFvRu8D7XegnCSl4ACQKLJE+3H6PTRZrvkLYbTVNHEOEJ8J9wQYcP3VLm
         SQlM/bUkfEJa5XBB8xZr49ZiL2U3erAFW4PcxmyCDRJo95YKYa67/60Sk1G6bQv/vrEY
         ciUQGMmkvGymZ1Ri0VwVTagFz1gbXOi0DihtCvR61yngm5jw1ReDBLDnjY/RQnKHHGKv
         aSVA==
X-Gm-Message-State: AOJu0YwL8bAlBtsML+dAn5d77rIwEEyCpKsZmSJzyYf8eT4xYyBHkK7W
	RmT//0o3dhFMuTG64yTBU/aI34IZKD02q+VYJQXr86fp0wxm208Q+Rx0tDhsUcv4qt6zmeZLgip
	EAtbzR9wKjMhPgu0o6BmzoIbrzPAE9GgUi6Pw
X-Gm-Gg: ASbGncs53Cb0QbFWRP8HLhY6mL6G18tyz0hp5zfO8jOjJMEOdJ+m+ytg6DCk8LLP55W
	4RQZB9inQwkXMycamEDXxCeLyb5gFT9mdcvDzwnB/aq6jfmbhdDO/X9C8z3Nm7bNerXxht5xnTA
	kwicdbATHarCsnFFPLqIw7Cps93h9UBEVr/EUsO+3FmHUykV6X3q3rl9OLbEnPlQH6AHEl32nDS
	UFx6kUheh0nZygoAqQGLyh455smvRlp4SMEBUXtOB5lVu5jYyAars4xDfw3uD+VH4aASsA3waLF
	Qtezewz86c9wjdPbJXZRR/i3EIFdEOiPFQqM6E2BR/irpX9hsNn90wfJq5iNV/JB0DWvAZUTnWL
	lBbjSBQ5+MFCU5mb5rTO5eO5d+NnZmQKAt/xmVv63BVOaI1NKGP8oMZsICn00n0sb3YLsGG716N
	0Nqx4NNsPRmLEp4VTHPsZt
X-Google-Smtp-Source: AGHT+IH6Onrt1C57J648mHfgDzK7l5oADdvj83TGXRqZO0zc/iSil8hZgrdfB9t9cPOweL58IPlDUnQzrdV5d+yu3bQ=
X-Received: by 2002:a05:6214:2a84:b0:87f:b2f2:c591 with SMTP id
 6a1803df08f44-87fb2f2c6cdmr43135406d6.62.1761316272532; Fri, 24 Oct 2025
 07:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 24 Oct 2025 09:31:01 -0500
X-Gm-Features: AWmQ_bn5GytQ4_bDnpEs9WssDXChStMg2wmQo6fAZTzxfcRt45URfRBpCcQuu4s
Message-ID: <CAH2r5mtRwOOJo1J_dR_2M4FwPcc1=LP1+NczMV8-PKJf+M=k-g@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.18-rc2-smb-client-fixes

for you to fetch changes up to 64c9471aa9ded2440bf182b1c71d3f93f80b2f85:

  cifs: #include cifsglob.h before trace.h to allow structs in
tracepoints (2025-10-23 02:47:20 -0500)

----------------------------------------------------------------
Six smb client fixes
- add missing tracepoints
- smbdirect (RDMA) fix
- fix potential issue with credits underflow
- rename fix
- improvement to calc_signature and additional cleanup patch

----------------------------------------------------------------
David Howells (4):
      cifs: Add a couple of missing smb3_rw_credits tracepoints
      cifs: Fix TCP_Server_Info::credits to be signed
      cifs: Call the calc_signature functions directly
      cifs: #include cifsglob.h before trace.h to allow structs in tracepoints

Paulo Alcantara (1):
      smb: client: get rid of d_drop() in cifs_do_rename()

Stefan Metzmacher (1):
      smb: client: allocate enough space for MR WRs and ib_drain_qp()

 fs/smb/client/cifsglob.h      |  4 +---
 fs/smb/client/cifsproto.h     |  1 +
 fs/smb/client/cifssmb.c       |  8 ++++++++
 fs/smb/client/inode.c         |  5 +----
 fs/smb/client/smb2ops.c       |  4 ----
 fs/smb/client/smb2proto.h     |  6 ------
 fs/smb/client/smb2transport.c | 18 +++++++++---------
 fs/smb/client/smbdirect.c     | 36 +++++++++++++++++++++++-------------
 fs/smb/client/trace.c         |  1 +
 9 files changed, 44 insertions(+), 39 deletions(-)


--
Thanks,

Steve

