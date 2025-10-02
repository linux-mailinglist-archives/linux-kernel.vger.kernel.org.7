Return-Path: <linux-kernel+bounces-840739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB1BB51FE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962DB482958
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BD134CB;
	Thu,  2 Oct 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZcBZQjN"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEFD7263B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437090; cv=none; b=LYr/5DnI3ZGUu6Zod1gEyAL6Cc6NPynbaOiF89VC0C/aA3LQbpBAfo5SZVLL71soQE3pfs7r7lg/LttE6sUhjAzBEDAGCAH31+HVbIkjSQzKYHY3hKnas0YfqHDOBNzdACSZpuzYC7mjCTUcRUPQujQe7yuAC5jE3icL+21kZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437090; c=relaxed/simple;
	bh=6N63wn6e70V3PTLkkgJt8OJ0tYwmpFIiBABIS2bT6SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkcwQ4FbeuuKSySdIvlrPWO1htJLAv7zGnMX9q8gwz1ZjEsOzP91ON8hbMJWqxQQ3u3gQ3sdE5p9TzdiOBIaH/z7X9/ncyyfDGj4nxjv/ZEzlAhMWQcB+XyVSRACDVP+CxUJr3NQ6+sVTPQ8rRrJ2XeJqBWPoiKgc79kIG8R5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZcBZQjN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57b7c83cc78so1365684e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437087; x=1760041887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdvDy+jE9pUEVDpBETUNShqkuR03kLijcUSoRDrSlI8=;
        b=VZcBZQjN11PLgl8xxEAuRXgedSeFUz2OJtXwq+BgzETfP2xOhoGPLXP96+obeM3LJc
         UiWxpdrt75UhumVnNZJi46NjOZFsEQCISFbpue9v3QHePu5audI6vOREfcYvP6+Sgh7m
         zp+YcRKv5G+rElr4dMSOBZSZzAn5ur+ATFTQ1BJMdt/4xtCfVJvB0ZrgJjtWWSxkX8x6
         B2RGUo+731zLRE2mE+OE1KSS7zgYueTjYQ5yenpYNqVp23DVDk2IRfHX6/Mv04bpr4Nj
         /WI53PCXexClDtxwtCNDyGNAdBwu7OklP6HS4PHtPuUl2tkBGnXO3uA6fXdbCNyiQJEj
         5tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437087; x=1760041887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdvDy+jE9pUEVDpBETUNShqkuR03kLijcUSoRDrSlI8=;
        b=E32TKgdGhrCqLZHEdnN6Rpzjp6ye6kApzkgl0zt+oC/bOuOXn5CUnRNNnRpBXHvVex
         YWacPoO0pF0zN9JhpPgvz3BcIFepeLmEMO9+USVWkcCFLdtMx608m7nVdCdTLNunwqVh
         +WLWNuLl32/jz1ffjOJiaUNz2CJwXqvVhufN0FSkcc67Jie4lF8iuBF9Zd0sbQyJXJKF
         iaCq6KpLZGHw82hhqe0iDpZu/PKCbzcTo63SIEBvit6SAdkKz5eZtQz9Zjtpg/TWnxf/
         0GQN/HGlOiqae2MOAoc0qAPHyg6JVqGqOcllfEzxozYfpa2Nj6BuQtxzx5UhlOIyrjMS
         UKlw==
X-Forwarded-Encrypted: i=1; AJvYcCUk3PztWR7OD9cjj9e1JxvyDA0M2dw4bfnqjsguaufIkOJNtOKY/k35OcbkZ6hoNQ2IqBbTUxrECQoYirY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8634Dn4VI4RkzmeKmC9ekJtWNv2mcpxzilf4gzphbysG9h4+V
	OjJhaJvDZxZv6Of8GcfQcchleqoCT8gwjpQvFi0uvO/SYnhY0eKdY1yi
X-Gm-Gg: ASbGncurXef/BRlJ8HqI6JH2cA1hwiqE11wf2nCeXMdV8xUoyuFjF3ml0DI1dtmR1Po
	HA1kbRMt/pGpLxFM/2SMA580g/4LVrF6B5o0HIK4Xl8R0M5MpU6i730yuForioxYndPMcf5tU26
	Ko2XSzE0+7DIbpmmGUZAw4eGkSDdXtOUGSjnHAqE3E927UGriKp+BYaVxu9jfrbe8pW2T+vOGWZ
	0InT2XZsoAJopHlOLQww30s33GGnraJ/mY4DXNm+hzgShh74EZCOwW41QjIunPYhR+dkqwggng2
	vCeFB6XE+Sb+v3c2aINrDgpiU+2IsMURdZbLXmrPuBzsKC78Vo2UTmDZ9TLL10U607I4o6l/PGG
	5ONryzj4n+2D5FT8zk7olaNMo+MZwzxwlDGgMwks8g5mtfp4+3XQPkeGebQClAmIf1EwjokrwEz
	3p
X-Google-Smtp-Source: AGHT+IF2b51SMZxRUPUPUFa256VtMpMUsH9rtl897bcO+/0ikiOpQMBUMwns5t1Wl68GpHWNFThBMg==
X-Received: by 2002:a05:6512:2397:b0:581:bdb8:6df9 with SMTP id 2adb3069b0e04-58b00b5eb3emr1513310e87.10.1759437086196;
        Thu, 02 Oct 2025 13:31:26 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm1127316e87.52.2025.10.02.13.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:31:25 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v2 0/4] NFSD: Impl multiple extents in block/scsi layoutget
Date: Thu,  2 Oct 2025 23:31:10 +0300
Message-ID: <20251002203121.182395-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for multiple extents in the LAYOUTGET response
for two main reasons.

First, it avoids unnecessary RPC calls. For files consisting of many
extents, especially large ones, too many LAYOUTGET requests are observed
in Wireshark traces.

Second, due to the current limitation on returning a single extent,
the client can only reliably request layouts with minimum length set
to 4K. Otherwise, NFS4ERR_LAYOUTUNAVAILABLE may be returned if XFS
allocated a 4K extent within the requested range.

We are using the ability to request layouts with a minimum length
greater than 4K to fix/workaround a bug in the client. I will prepare
the client's patch for review too.

Below is an example of multiple extents in the LAYOUTGET response
captured using Wireshark.

Network File System, Ops(3): SEQUENCE, PUTFH, LAYOUTGET
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
        length: 0
        contents: <EMPTY>
    minorversion: 2
    Operations (count: 3): SEQUENCE, PUTFH, LAYOUTGET
        Opcode: SEQUENCE (53)
        Opcode: PUTFH (22)
        Opcode: LAYOUTGET (50)
            layout available?: No
            layout type: LAYOUT4_BLOCK_VOLUME (3)
            IO mode: IOMODE_RW (2)
            offset: 0
            length: 10485760
            min length: 16384
            StateID
            maxcount: 4096
    [Main Opcode: LAYOUTGET (50)]

Network File System, Ops(3): SEQUENCE PUTFH LAYOUTGET
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Status: NFS4_OK (0)
    Tag: <EMPTY>
        length: 0
        contents: <EMPTY>
    Operations (count: 3)
        Opcode: SEQUENCE (53)
        Opcode: PUTFH (22)
        Opcode: LAYOUTGET (50)
            Status: NFS4_OK (0)
            return on close?: Yes
            StateID
            Layout Segment (count: 1)
                offset: 0
                length: 385024
                IO mode: IOMODE_RW (2)
                layout type: LAYOUT4_BLOCK_VOLUME (3)
                layout: <DATA>
                    length: 4052
                    contents: <DATA>
    [Main Opcode: LAYOUTGET (50)]
pNFS Block Layout Extents
    bex_count: 92
    BEX[0]
    BEX[1]
    BEX[2]
    ...

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Changes in v2:
 - Reworded subject and description
 - Split the v1 patch into successive small changes
 - Removed kdoc comments for static functions
 - Removed subsegment and magic numbers
 - Patches are made on top of nfsd-testing

Sergey Bashirov (4):
  NFSD/blocklayout: Fix minlength check in proc_layoutget
  NFSD/blocklayout: Extract extent mapping from proc_layoutget
  NFSD/blocklayout: Introduce layout content structure
  NFSD/blocklayout: Support multiple extents per LAYOUTGET

 fs/nfsd/blocklayout.c    | 154 +++++++++++++++++++++++++++------------
 fs/nfsd/blocklayoutxdr.c |  36 ++++++---
 fs/nfsd/blocklayoutxdr.h |  14 ++++
 3 files changed, 147 insertions(+), 57 deletions(-)

-- 
2.43.0


