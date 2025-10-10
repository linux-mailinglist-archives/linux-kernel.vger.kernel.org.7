Return-Path: <linux-kernel+bounces-848516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE4BBCDF1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F8024E361C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DC62FBE1B;
	Fri, 10 Oct 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imIIo98/"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934202F83A7
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113281; cv=none; b=RKdEwbrY54uW+pYF2i7cuE0d7JNbnSIsBmf1Rn+SLp0qO6O2lPS9FFiQpHjarcF97tZBAs7dvqYzOnF5SfNo+Vl9A/l+lHpwvxk6C8mlZ/wQUvqgzzI2YWShXhODdbLEwlBzkydscl4RjvrTCduoKlCv/dFgjIJQGZy3zeERtCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113281; c=relaxed/simple;
	bh=bi8Ww4SBPK6KHJ5yWKiPcWGJgDLTCJ2/7+AhcbOec+k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sTijL8PWhMVdU07xqwjPIbni7jFffTSYxh+aqxhm+LTradk0L1sS4vIBRrTWThjc/dergaiDkMUBWYr39cVPb8KDa7ZLe4jvgKUMJAR9yyXzi4lkFpDL+XhxrMCX8yknGkN7ScvjrtslWRZaMgb6CpO48avIt6AF5XG28MqnoOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imIIo98/; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-78e4056623fso22953256d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760113278; x=1760718078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZh2Djw2dUH4TQlfLsxjKa5aBoJaNHURt3DWz7LWtjo=;
        b=imIIo98/asqSrmKf6XY08G0od+jAyTRsEShBNu8bfPb2L+RIL390h8svw9653QG4vQ
         AggLABptaUZ7vNh0RpkC0F3bSQm8oKSTWD0QejmADGXlyv/O7C61ZZizrSM8ATlcNNmx
         Nv2zTJLb9i+qv8Sw2wk8rKBpg21UDG84HuGmvsPx9mEIGUf2XETp/dQDx7yAT+TKXpyX
         ot9FB6GgzsoK2JtNshTLAuLoI7ZamXYy9GDTbsmaOT8HKobuW7k+mhcCp2TKmLJhkdPL
         6Scj0TPcq2e2ZG93ixVdhkUXZnHfyAHjppFoScC0gvUALdOKaDxURGrwTiDCVewPQPpk
         Ucmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760113278; x=1760718078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZh2Djw2dUH4TQlfLsxjKa5aBoJaNHURt3DWz7LWtjo=;
        b=jtprAxY4VDdfwdOJLfb5GwY+pvl8k0YpK/8J5RYHYLv4O8D8zU/AuPX03eQkYNvA8l
         bEwjHrcppIGaSjXuacCgi2YitN8TB0Z/4+WN9YIHWCiHCInZr7aURQ8vbQ+DnqBLYolw
         a1Gw0n1iUEynE6o4fPfLQvShrlCdBQqENbpx6SlMDqDsx1qd5r60lzkg30so746SOfXE
         wH5pqkLeiJjTwju48Y7hRdfnixbavIVwmU3xLerNMk7bs7JLL+hM/p7+jWZM8vLEVq9V
         7yLVt/soF96RxSgIhDVK0BjsyI5tXKV0h2dgJ1nFmMG2PBLrywws/L9oYJC56Jdjk3Vo
         AZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGIIZ/1GVQKR6Z0PAiZxU3tOeILSKqiAygjB6i7TdMt7VTbTezUuQyxCQSzaUJ2e9m4IVvjvymUkhlTcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1P/o8T4X4qTq7wmTgX3qbqxttf216Z1i37ePDxp9YAOl/GvFa
	7ksr34ZM82OiPVYHSPh8IXdMNdp9m+ldCit+3ysTJdXiiRz6jgUzReFnWpvmB0Cq/B+2MTmEHbe
	liq8hySgIAeq4Gas1XxglSKGbaG1iNO8=
X-Gm-Gg: ASbGncsB/d7cFFI7ffXOOZmJY8JOMLKTU/t9S5jvf6agBpVgEI9OFjBxzpQzcB87BpD
	guoUeRupsKCraacCVkNWm1n5wXxbE9CbV1owzGWSJO3hIp31N83O4ycFLnWFfYfFEHg5P0xR7WX
	Aqhcj7UKbNV52GP6YyYtcCqFOK2mN6SDps/f8in95rT8iO8EgRFCyJCJtXkUP6X1vPW5936oD3n
	+2esGTjAyBRsi8DwlNCWnN0aLOuvh+iiAfDGZ27PVOogKTcCVlGbpcOAEHrp3Zozzkka6pOY/3E
	i8grqkAjl9i48HF18lhHeiMj6ZPgxMZ4TMftKtnuMTigAnUhBRKQzCxdLgQBERzvjdQl14S6ATc
	7fJTQMAv+IWWwnHae2nIE2W66NIIT3TQm5VOkFV0zXuzz6aSzARQ=
X-Google-Smtp-Source: AGHT+IEfF0wJ8FsGEVM2oi1+RohCJJnnmyvfGp2qTCX1yWDEasvSsC6MDyQLUUHAUOn/QX4LDk9Hq5BXOpM3/hJnD38=
X-Received: by 2002:a05:6214:caa:b0:80e:327d:be5b with SMTP id
 6a1803df08f44-87b2ef951ebmr170872756d6.66.1760113277997; Fri, 10 Oct 2025
 09:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 10 Oct 2025 11:21:06 -0500
X-Gm-Features: AS18NWAnmBimj15GslY_-Tm8AP8gpcYffUfBtSnK-8s9IwC7BHYg7rvSaY703IQ
Message-ID: <CAH2r5msx5Nkp5PBAAF_Jzzdq87S+dt4VmdUjKHvTGjq6ejKHjA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please pull the following changes since commit
63e62baaa72e1aceb422f64a50408bc9b02a6022:

  Merge tag '6.18-rc-part1-smb3-client-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2025-10-03 14:13:23 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/v6.18-rc-part2-smb-client-f=
ixes

for you to fetch changes up to b30c32c784bf29735dabff15443a5feeafd26d1c:

  cifs: update internal version number (2025-10-10 11:10:01 -0500)

----------------------------------------------------------------
20 smb client fixes
- fix i_size in fallocate
- two truncate fixes
- utime fix
- 11 minor cleanups
- 3 SMB1 fixes
- improve error check in read
- improve perf of copy file_range (copy_chunk)
----------------------------------------------------------------
Enzo Matsumiya (1):
      smb: client: remove cfids_invalidation_worker

Fushuai Wang (1):
      cifs: Fix copy_to_iter return value check

Henrique Carvalho (1):
      smb: client: batch SRV_COPYCHUNK entries to cut round trips

Markus Elfring (7):
      smb: client: Reduce the scopes for a few variables in two functions
      smb: client: Use common code in cifs_lookup()
      smb: client: Return a status code only as a constant in
cifs_spnego_key_instantiate()
      smb: client: Improve unlocking of a mutex in cifs_get_swn_reg()
      smb: client: Use common code in cifs_do_create()
      smb: client: Return directly after a failed genlmsg_new() in
cifs_swn_send_register_message()
      smb: client: Omit an if branch in smb2_find_smb_tcon()

Pali Roh=C3=A1r (4):
      cifs: Query EA $LXMOD in cifs_query_path_info() for WSL reparse point=
s
      cifs: Allow fallback code in smb_set_file_info() also for directories
      cifs: Add fallback code path for cifs_mkdir_setinfo()
      cifs: Add comments for DeletePending assignments in open functions

Paulo Alcantara (5):
      smb: client: fix missing timestamp updates with O_TRUNC
      smb: client: fix missing timestamp updates after ftruncate(2)
      smb: client: fix missing timestamp updates after utime(2)
      smb: client: fix race with fallocate(2) and AIO+DIO
      smb: client: remove redudant assignment in cifs_strict_fsync()

Steve French (1):
      cifs: update internal version number

 fs/smb/client/cached_dir.c    |  37 ++---
 fs/smb/client/cached_dir.h    |   1 -
 fs/smb/client/cifs_spnego.c   |  12 +-
 fs/smb/client/cifs_swn.c      |  20 +--
 fs/smb/client/cifsfs.c        |  22 ++-
 fs/smb/client/cifsfs.h        |   4 +-
 fs/smb/client/cifsglob.h      |   5 +
 fs/smb/client/cifssmb.c       |   4 +-
 fs/smb/client/dir.c           |  38 ++---
 fs/smb/client/file.c          | 105 ++++++++-----
 fs/smb/client/inode.c         | 151 ++++++++++---------
 fs/smb/client/smb1ops.c       |  69 ++++++++-
 fs/smb/client/smb2inode.c     |  24 +--
 fs/smb/client/smb2ops.c       | 334 ++++++++++++++++++++++++++------------=
----
 fs/smb/client/smb2pdu.c       |   2 +-
 fs/smb/client/smb2pdu.h       |  16 +-
 fs/smb/client/smb2transport.c |   5 -
 fs/smb/client/trace.h         |   2 +-
 18 files changed, 522 insertions(+), 329 deletions(-)

--=20
Thanks,

Steve

