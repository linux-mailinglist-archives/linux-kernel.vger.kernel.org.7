Return-Path: <linux-kernel+bounces-761810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F4B1FEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BC1189946B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B450A26E15D;
	Mon, 11 Aug 2025 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F82pI7jk"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE015990C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890827; cv=none; b=UkPCojxmDBXH0I92+12lbrNA2NGUU2zUtLIAwssQk+1ApmHXNT2yAj/9Ek+8tCos3CwijxLtHkbIAkeLFY06E5CvzxteH7YZfM+g0hlOgmHtn8aF7xUrC4ueIpGfaUYA1foA+0rx0W++/llQmg8dYLjcC4guzsXtWQUJwrYfdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890827; c=relaxed/simple;
	bh=zrVBUNxxZqstsRJDYJz90CxtD6sPPVd06a6UywvSNv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sjTFEIFoT9fBbFpTSabtcI+h6jtCpExy2WrOWOp07ez2QAVtwETYVoGD3Tf0ElQyjnWcrTzIi/PhYCWHvlzxJXJ5ETtvFixQuWmDvqKGzCG8bfn6/zTAqa7JU6ha437ruF+MvJVQqBxUMMjq7b81DDdP78OXMaYl/O4z37qCmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F82pI7jk; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-23ffa7b3b30so36467035ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754890825; x=1755495625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5Tm8MncGgTzffuubiEuxBs0xK5k7TEVaXhLTBjgDNo=;
        b=X9HKLwNjN8D6Lzm2VkjKsy/FUeBnCEw6SfEnzq6k6XvaV8j1rpSEmZF201qcS9Xxmk
         ohNpyqnFrTPa4cXmcf0V73bncDu6Jw//jMJ8qbijlkd5t/rYlcYbs9ZXIBsr/KAExFt7
         Ljr4/NWLHHJrWEIiwmU8wiQOByFVeuxhtKheoJU8m7Ft+bwYNZtg3eRoWDgs2ZgnMrPt
         B4TeVeHBe4xmVpNqFA7AUyDhNtL0/uyBxeLfV+sSvNs+bZU/7FRHkAkxq9cuU1mJTkRL
         CFIA23IdDDUtkLsSrwbgS4sAOoYpt44VBIjSJjcCVZ2fznsJwYAqSxEajFwY0mJrVmoE
         lX6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCOncQyYn5tpfNTztgTZjMc8LrGwoINYCvx57WIe4IIGidnOyAICjlrpLAWXQJihD2eSPHLD2SNLd++BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Ny7csc658dhEhLDhJjxJ9WruEtxYkdYzB/cK3GzxN62zBbsm
	cYE6szBjcK4ll3DupXn4455DtV7GAeub6VimnaFzOgD+cL5scmUKc6QlA0LCrwvb2+Sc+Bnowb3
	F4kak/EXZLrv+dZ8d8kEmj3eAk7IFcIinEPIlHPzXLFnJ2zQmDN6zauEKv/HZxe6pdCM1M9nOtT
	R+muJCDyxdLLVBJnTPJG7dG0BHLX5HvaSyQuSCKTiw3Qu86OG9fKfqD2ga97Wjprotz+bCRrQs3
	AT3SNSSTT52NJwvtlYeIZ9Y2w==
X-Gm-Gg: ASbGncvTO1c3ukUL3hjS+3lnkNI9oWCzYthLd/+hpFidDspNuFqUlnuIXUEhfi5CgyK
	6s6DqYJYQbQ0YW491C+ZJbqzDPkHOB6g4xf3O6h3DLVe0vMC6b5/0Q7af/nDfGuB2U4FMMPbczs
	OOC/NucN6BNBqFJ8oI1Kv9meYOps7V0Zgtdek5aQnhZBAGIG3N8IH0Q7sdy7luPD79CURc4jDTv
	bk4ATXnLxJKRB10PBCtDxsk9ECEUjvYZbresV7e6xu7RVSDJnulz0n2S0IlFTNsoHY1l40gcUQn
	1B8fsEs5NG+ao7SlFX4Ey2qPye5d6uYSPEBVJ5EwXLyL/fTAxxtRBdM4+6XU8X3KOmZsBkvZJxp
	SxmxcpAWfy1FNn/VoL8KdA2qN/oUrKD6tnioOGJ3gLWM40uZmVOif4UeDlPDG8dzB9h7KPaBJII
	IF6V5fEQ==
X-Google-Smtp-Source: AGHT+IGXlekGvQw3VmF/U4kCVOTAZPu7IcDQkQb3jTbyFKEDuwu2uyJuuApWYd7ppaXSK4K9i5i+NsUQ82j2
X-Received: by 2002:a17:902:e890:b0:242:a3fc:5917 with SMTP id d9443c01a7336-242c1ffb633mr196577015ad.2.1754890824906;
        Sun, 10 Aug 2025 22:40:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-241e899d5c8sm15293145ad.84.2025.08.10.22.40.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:40:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7073cc86450so73185226d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754890824; x=1755495624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5Tm8MncGgTzffuubiEuxBs0xK5k7TEVaXhLTBjgDNo=;
        b=F82pI7jk8lD4NyfKNvSsguHbcaQT0cCrlwl83gnk0sVUmnbx2SCTZckCKnNV3dwvRr
         /lVZL2HahkU98tkNtBiU9N07q45LS3K3xB6JeTq8EvZymQMwo0bPrSu/mqwAfTLySTKh
         iNNbB3MANbNDLsCeHkVTJxSf5KSZn9klMXNDY=
X-Forwarded-Encrypted: i=1; AJvYcCXayIf2cw+cXUdVBc/Di2kBkQ6BWRzdwjunKpvIAV/ZbUpkh0tdz0Lsv0y40JWCHyaYwdOW9ywspCAmmTw=@vger.kernel.org
X-Received: by 2002:a05:6214:528d:b0:706:ff82:a3c8 with SMTP id 6a1803df08f44-7099a1cf2b2mr155458536d6.5.1754890823816;
        Sun, 10 Aug 2025 22:40:23 -0700 (PDT)
X-Received: by 2002:a05:6214:528d:b0:706:ff82:a3c8 with SMTP id 6a1803df08f44-7099a1cf2b2mr155458396d6.5.1754890823367;
        Sun, 10 Aug 2025 22:40:23 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce44849sm150544766d6.84.2025.08.10.22.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:40:22 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 0/2 v5.10] Fix CVE-2021-47498
Date: Sun, 10 Aug 2025 22:27:00 -0700
Message-Id: <20250811052702.145189-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

 To Fix CVE-2021-47498 b4459b11e840 is required, but it has a dependency
 on e2118b3c3d94 ("rearrange core declarations for extended use
 from dm-zone.c"). Therefore backported both patches for v5.10.

Thanks,
Shivani

Shivani Agarwal (2):
  dm: rearrange core declarations for extended use from dm-zone.c
  dm rq: don't queue request to blk-mq during DM suspend

 drivers/md/dm-core.h | 52 ++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-rq.c   |  8 ++++++
 drivers/md/dm.c      | 59 ++++++--------------------------------------
 3 files changed, 67 insertions(+), 52 deletions(-)

-- 
2.40.4


