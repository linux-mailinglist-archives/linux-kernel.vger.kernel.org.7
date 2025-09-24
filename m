Return-Path: <linux-kernel+bounces-829858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF4DB98114
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7CE18930B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327DE21D3C9;
	Wed, 24 Sep 2025 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq9C4i25"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF121D5B3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758680517; cv=none; b=AwPrm0NocI6tMotjCeXN3pPXSP2ugVEvmuSUxu43J+ZrchC07tL9b4gnsFEC9wdwEVP3EcC72+E5B2jLIrVkpKM7pScIjkHx8hj9D2L70ykF4Mw0HY0+rYzBmuyoXHPV9J3yUlpZPKZBUDrINRHFcEnFcQoEyUKh7r+U1xZXauE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758680517; c=relaxed/simple;
	bh=HFHmdE57JXCjKHaQD8SUjF/RrHNTUnZebd0jUZ724UE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oHezaQ6DrYiAfDoMc6TvhtompR3PTGxLOdmfXxgPjrxJYrQmGfzpTVDlzglQ9XAUXF00LgjigQQFgUucb0zjptFxYEDb7cZS3ebE7JHVsHdTZzvOz/pLtchka7u8REaH4/ip/qSnRcT2DArKOI2LHINwdhPIKzBi5SQvodwiQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq9C4i25; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78febbe521cso55644376d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758680515; x=1759285315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uqyfLm8v6T0qYv16JlYYlcUwd5Gfyhb7apOWrngvLGk=;
        b=Lq9C4i25Dy00dIS6rmK0aQW3YSjKO1Ge3El4drhmWR8TtUvA56/5wP906JlNyfzD1H
         nzTND4Ed5p1pTR0c77W79N1mT1IcIhDhLNft+msrkSa6DHYqw1YbIohO4H9lzfYxde8+
         5fNyMyG7ndAelsBopXNTQNV1xvJUEjk/OPQVpEJ83h3rUzs6AyrIFHdHxsrW7o4pKQXd
         Nof5vj2AewbKWkRE4KhjJ9xEJUcg0kCbOiZxnpS/F/XGdWemD66bJtTvwOPK3MI7eicd
         moYhd/AGVXU4oBrYVWW6ncPIwwycWVhODNpJJqhAh4m1bm6h4SUdD/TOmrIt1mmR81/x
         np6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758680515; x=1759285315;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqyfLm8v6T0qYv16JlYYlcUwd5Gfyhb7apOWrngvLGk=;
        b=ujamfsyzjutSukw1zsE/aXyK5TfZlK4mOV+CMdU8w8JNf/VvGPaX+kXcMHC0AbR2Zq
         ndHtaB0+wk8pUwpIO4D2sB3jZCOCo/+PO6xjUczdPwyr/2JWbQuS1OgyFFOc666wzXuS
         +OETymALMyaxrOVISMnBIfLy3vi5iNV8ys+6tWDLTLsTAnDXMm+J++mCQ7sAlBvODVrR
         i/9PCTRlCJOn/jgu8Qfbwr7vA63Wzt/48DNqKYbFViTB+huqcZWYSZRJz/mBDlzwGESz
         Q4QOoF7gMiz/FhlNFQ4ZpdssBRHZCaE54d8vohwa0nm50W+hnoxCZLfsYAcW95yL/lkK
         OWuw==
X-Forwarded-Encrypted: i=1; AJvYcCVPsTMqjdC0NYYuCTWgk5Z+xJHvilB41feWd4IK+rxiDXKJNkzcn1n0h8Jqm5AQDotjC1duJKun5rog6BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx686HGydAM68rU///aPWHbf0YhQi1TbYFL9lhxpSA5dluvszfp
	FyDxmzBZ8WkG+5AKLU/v04jWdj3RveoI9r3FPWeubh2NDRwUh+5QGZLcYVNoeqqjYF4lcu2EHM+
	VxCtSCx+3H5VIbKt7jrqELl6T+jw6G2U=
X-Gm-Gg: ASbGncvdnnMVEuASFr2Nmx+2dPhuCyiLSfsCau+5Jc4S1KeSELWEVajDRkkfUeyIrmL
	/A3cNx5I93mt5IS45h3P/HosTU11oTpchdoOoH7MYwwIzARkaSgws200vAzmKiIJTlFYwtkMFi2
	U11mDGNhHWouHsdDC6bNp5ontiE65UtXW2AI66Qr5rPS155gdPVrE9OM8X+bwa2x+hfDV5B8ghT
	tOUfZi36T4WGCjQ4f/+hXRndOCQMnqNcwY4r+nLtVYRFHnOSV5N8z8sx+YAIosbuaTWcZVww5Lp
	WbrseLaqYrpcAn3SyllkWP65xHVGAYYUw1gtv/ufXR8zVFNTYbIpHtljpp5lTmGzApCJJKCPnth
	6X+6/2jklNkR5ZYvqK3F3HA==
X-Google-Smtp-Source: AGHT+IGC6vYlvhs66ktmkSH4DNM8gnu1Y+JkGwS0f32FuoBMmczQj3Zw9gx+tsGTkFNEZOt8dXwS5okLfdhpl2/fdhU=
X-Received: by 2002:a05:6214:e6f:b0:7e6:6528:a2ff with SMTP id
 6a1803df08f44-7e710d84958mr51832006d6.38.1758680514753; Tue, 23 Sep 2025
 19:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 23 Sep 2025 21:21:42 -0500
X-Gm-Features: AS18NWB2bfaevaok-t0yRcDHeIiepjkPSc3MjLEZsgCVPtK2pHBCYZGFf-QweVs
Message-ID: <CAH2r5mux1-atMBd92EjpP9HYrLWWJDCC+=DNx+yVxti7ejDNhw@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, "Stefan (metze) Metzmacher" <metze@samba.org>, 
	CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
07e27ad16399afcd693be20211b0dfae63e0615f:

  Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.17-rc7-ksmbd-server-fixes

for you to fetch changes up to f7f89250175e0a82e99ed66da7012e869c36497d:

  smb: server: use disable_work_sync in transport_rdma.c (2025-09-21
19:34:52 -0500)

----------------------------------------------------------------
Two ksmbd server fixes
- free_transport fix for disconnect races
- minor delayed work fix
----------------------------------------------------------------
Stefan Metzmacher (2):
      smb: server: don't use delayed_work for post_recv_credits_work
      smb: server: use disable_work_sync in transport_rdma.c

 fs/smb/server/transport_rdma.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

-- 
Thanks,

Steve

