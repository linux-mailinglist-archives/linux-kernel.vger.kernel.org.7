Return-Path: <linux-kernel+bounces-836359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EC5BA976A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F13C1C003B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DFC3090D1;
	Mon, 29 Sep 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGRcIS/3"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833C308F36
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154446; cv=none; b=SNpHUKiuprE+unrc9JS4tUvKWcRpWVbUMGOR/Lvk4++zKtPL5VnNdIrwThREEnCqkCIVuRgz9makno7ri4pAHmzioFslHJy9cD6XJYAbfJh1GssFZyBU0FqPE6sMof3+xVwgJQ7PGDiEs2x6GQThec0pcWRmfs3D/Y5bgmUaxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154446; c=relaxed/simple;
	bh=L3hhvqA/El0jd36qHGLM1VYJVkRhpNs+PRg1E92fOMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tp+fWc9TcSSY4h43c6Ir2a1l/Y13cPKRRYZmXQjE6W2B0Dd5dMpzoKqDOrPegkT8ue+yDlZ7QvPW/sYpDmRxHMpYlJ9Tuw1ZtusvuOChLyw/6OhaHHwtoaB7Lb1FWi0qC8dIc0QXtG9r17JZqrQ7lovRmAKD/gTudONDFUZuzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGRcIS/3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781251eec51so1994314b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759154445; x=1759759245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aR+9721anmN0NfZgwpWwYRBIe5Rks3tZnJySwmuBqqs=;
        b=GGRcIS/38DrR1WOnQv7EdIINFaQDXqav3Lau5cQGrkW8UdP5NNXwwxt8W3aHBG/zhD
         qfUWc9Twk3pmncBZqsCW13dcqMqzykdaTpeiSpZkfDoq7v7qjJ4ydYwx7hMnGVQ+MhBj
         H6kysqnWU27J8TmDqpb+EdY2AGx0s4y6uBlK1SLZViAQXglfRJ72oj54wmROT5q8NUxg
         cPt26feDWjgJvwPJqpGo/S0CIR+2h+Q5+SWCXzZJjDp896G27nPD9axr9gF95+8jLhB+
         u75V/hJbf2TdfGcBKCG4i7DeaxtxNt427B1xkN1iNdEHOwoTlIc+JvCxvqpu0nMe8XXo
         dwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154445; x=1759759245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aR+9721anmN0NfZgwpWwYRBIe5Rks3tZnJySwmuBqqs=;
        b=C4xoWGRR2NS/vq5vWlwYIQOlQIao7c6kgLW3YDdJ41INxf9Yv04MAs3mRh2K47ggTh
         rYF8TAqQ0bG6CRhjBkq9CM2NwZYuoNlSk/3leO4AlBHp4QE+AzfJqssoKLSBq2qPN0Bk
         VUNt9j5saVdGPC/ddMP5HU2BRRBOUzKjHNQ8i5SALuvrGLZbSOmIjlwC38+YQ7P+P6LW
         V1NqcxcZNDcgNgRhgDOatWS2/t9g8KjHL6cs+8NagOa+NBXu95A/QBlzvuQRjjAq4gAz
         08xVE4W0K7aFowdIJjfcSjA1Pe9m2a191RzpsqiMAvXBovA+zu97cPJxt5mCeydt9Caz
         66dw==
X-Forwarded-Encrypted: i=1; AJvYcCV3gUtuCv6dIF8pGcySb2NX9GVvPZ47eF1ejAM2mo7aGsA/2e542qtibTZb0upA0OAJFTpax0toJTDyslA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNAFw+rwKmwh5GgN7824bnIU+Un9ptNCcKwZV6DpsdymAbBlRm
	7+zyLtZE/nBbV1cbFSIQeQXnq8rDv8zAF5s9H8QLeV7/AMJfhyRVLwDtp+5U1Q/rQ90=
X-Gm-Gg: ASbGncto84w/fqZqzW5weUPhL5xRRy7QXYRWmxMV1KYgw/jXx0zdEzK8yIZaO4ptLY1
	OQuYlQBPsb5isUZ0iwEafBwvu0MfHPNRAvGEcG4X9xV9uLw4IAL3dxcGUAEzd77NgxnoatEFqNg
	fWGb6t88T6/lNqynfK9IP4IE2QtIKLuF9xiEbpsw0/78P+Qf6jVnCEIhpEtN6r2tom5J/GqTRBA
	x75oyJ0fGiOt9Df7aiUzIQkUVKkQXDc0oIdhVa/zFfNLfXqPk1vkCmx9tlkuLv7geYkH+SccF6S
	a6reHZwWZu0ri/W7MxNiRPDoj4PuRmETYKbgpTlWrS1V8/l0YyuJmL+aa6rtqzFqnhLZt73t0xg
	rTJojiFGA2SYa5hpImpev44LQivSnBeq5ilq1d/YDJdmjpynm+TZqxd3twPoxFbJSmTFR3LP+8a
	fP3psHDm94gPnaZQ==
X-Google-Smtp-Source: AGHT+IFyEzVLBvCaooSzhsbGe6NUtoHLRegynxWuFI3ToSvZIgdKofrC23BninBk1aBm7R4wrSgf0A==
X-Received: by 2002:a05:6a21:b95:b0:2f5:e435:4066 with SMTP id adf61e73a8af0-2f5e43564b0mr13284239637.44.1759154443044;
        Mon, 29 Sep 2025 07:00:43 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:2b82:239a:7350:ef6b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c8aebsm11165375b3a.28.2025.09.29.07.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:00:41 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
Date: Mon, 29 Sep 2025 19:30:36 +0530
Message-ID: <20250929140037.354258-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zhang Yi,

Thank you for pointing out the validation issue and your concerns about redundant checks. Let me provide a complete explanation of what's happening.

## Initial Problem
The reproducer triggers a BUG_ON in ext4_es_cache_extent() when opening a verity file on a corrupted ext4 filesystem. The issue occurs because the extent tree contains out-of-order extents that cause integer underflow when calculating hole sizes.

## Why ext4_ext_check_inode() Doesn't Catch This
You correctly asked why the existing validation in __ext4_iget() doesn't catch this corruption. After investigation with debug code, I found:

DEBUG: verity inode 15, inline=0, extents=1, test_inode_flag_inline_data=1
DEBUG: First time check inode 15 - flag=1, i_inline_off=0, has_inline=0  
DEBUG: Second time check inode 15 - flag=1, i_inline_off=164, has_inline=1
DEBUG: Skipping validation for inode 15 (has inline data)

The corrupted filesystem has inode 15 with:
1. EXT4_INODE_INLINE_DATA flag set (test_inode_flag returns 1)
2. EXT4_INODE_VERITY flag set (it's a verity file)
3. i_inline_off containing value 164 (from corrupted on-disk data)
4. Out-of-order extents in the extent tree

## The Validation Bypass Mechanism
The validation code in __ext4_iget():
} else if (!ext4_has_inline_data(inode)) {
    /* validate the block references in the inode */

The ext4_has_inline_data() function returns:
return ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) && 
       EXT4_I(inode)->i_inline_off;

Initially i_inline_off=0, so ext4_has_inline_data() returns false (1 && 0 = 0). But by the time validation check happens, i_inline_off=164 (loaded from corrupted on-disk data), making ext4_has_inline_data() return true (1 && 164 = 1), which skips validation.

## Proper Solution
You're correct that we should avoid redundant checks. The proper fix is to detect this invalid combination early in ext4_iget():

if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY) &&
    ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA)) {
    ext4_error_inode(inode, __func__, __LINE__, 0,
                     "inode has both verity and inline data flags");
    ret = -EFSCORRUPTED;
    goto bad_inode;
}

This addresses the root cause without adding overhead to the extent lookup path. I'll prepare a v2 patch implementing this approach instead of adding validation in ext4_find_extent().

Thank you for the thorough review that led to finding the actual root cause.

Best regards,
Deepanshu

