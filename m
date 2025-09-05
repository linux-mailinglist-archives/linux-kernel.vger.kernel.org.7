Return-Path: <linux-kernel+bounces-803291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F6B45D0A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70623B2E45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226E12F7AB0;
	Fri,  5 Sep 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MIovDv00"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5170242910
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087351; cv=none; b=FEhqnT1YxeTIS7grInYGW7IFWSRTTCKgKJAwiDKmj9gXFBWyC2RsffLywKvUxzmlaDglx+TnUwzsHRIleJFVPMMCP+3eUn5hyLapSByM5OmZQzjUEpPQrHEAD00rbtUW9l+CIKoyfHXJY1oxgZbr6dWsL1TCIxFW0wx9HZQVzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087351; c=relaxed/simple;
	bh=ja7Jw+Lb6NvFKnBlHZ66VaaJStdLwLSOhpRkRPCFFNY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gYeHQOL+htDSehDLtFTSBgDVvfWEDDWtPnGbxTZcT/NClog3BaiWQ+afHTiT5pWzALXcFoEwjRHAiwjvosyos7kQQp+Ugvt5JFJUQ5rn+wTrjrUIuIo2iJsS4B0waMWm15HB8t4K7M6SXUZcOpxR93JrgHkDwC5iNHISpVD5PYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MIovDv00; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1757087346;
	bh=3677tYUB7TkZpg+MOWNyHVCZvAIfuuou9nHpuxE/LIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MIovDv00Xj+YThRreqSt5esDyHct2rFsH1HnASRamAyjxh76EFT1zXiibXqnwcmZ5
	 kSVNvFKB1sanzH+bh9P986jSGXgTw/MDXLGwugkSlfk1a3dGBJNKCcSizGViMlQbox
	 NZOG2io8GOqd2jchMxyrrfhBB7zaNw+WZW2p5gZQ=
Received: from zm.. ([2408:8340:a2e:f9b0:20c:29ff:fe69:94c7])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id C4531636; Fri, 05 Sep 2025 23:49:05 +0800
X-QQ-mid: xmsmtpt1757087345t0jq1vxhb
Message-ID: <tencent_F5322517AD2A723568849905CF474A7D6C07@qq.com>
X-QQ-XMAILINFO: NyLjhNUPA19gjKd30bMH6BjLZEU0ME1aKZgIXTwXKbLeXRly0R+TQUlIoic7e2
	 kKFzviAJIY6EQw4GQ1mS6RO10Lg1lkkTSVUDlXEpACtKP51oKChg7fM5lr2eh81I6/HFbhEvnwQH
	 hyHcz0Vbn51jN9pAPrrRKq0NQ3OwZuozot23M6e6Uw1zQjO6KXyeu+LBfSRhU5Bwjei/VU6d7pXn
	 xBeQMnlLSGAtXZxLgVpxgNZoFDca5tOmUGg1RBnvBNO5TpCXGRn/NZTsMVJiCL68nCFuzhjD3rqj
	 teL4QpLVdJReO2ZZCARmu+4+CHdLhG9xbcMn8k1aOrdCw7opQKcLg0iX5gB8ZoUqZTlttl5KKKTK
	 pjkyYI7vsEYG757loIUkum9nhg+H0hOepUOO3IT+E6ri8Khb3tnx4DwMnp2aYhl5K0OjynUmbGqg
	 uKpL277hRlR8M69oERvc2KQ3i/owa4ngv6JcwZkFr0puwDlmumRFK0ur0MhDSUrrrAyJCjleljfX
	 9tSxzhxZdEaUVL2rM3SrTdM8rDxs9Zn4rUpMom6ZQJ0xxm5xmIXNNdAvjP6YRT/QcHTe9ArNaJhy
	 izbgZp6wGkezjahmRB9bKfAiqjvE4ijqwty4+KDDB/Xt6ADW2DrRlXQUj4nYhgMj7xgCX7zt6b1z
	 hZn5//kYyCOA/C8oF2QIM5GXlVkvDxBdiji7BEq2WGeaInIaqRzqprSMimpTX7E+S0TPg14cfuba
	 ANI3Hp9ATuy9rfrYH0j0hsxYYWsM0E20gUp5do5ZkAp8oQSmbL90ogHn+CgL+J93Svk75evXXTEM
	 r0VSAOux/1VVK9dQ0gjeZ+O0LCcPsPRrjLoIk17VxfKOsLIVb+4WddFE4bKaMSiC8819JkZxmLBi
	 kFeCm7l05LwhT0Azm0GYGcEynrUEsPWyHEibn1CbDsnDVq21drXxLY5xWBxA7M65lm4tTL7BTnr4
	 bxNEzQjZIIoPJuBovm0cvQsSuMbsWr8VfPGTEdlfp8LfbQoKD1FzmADAHHz+f2I7kq2oG/uixLcp
	 IPiBgzSL8xO6MPqJUGbV0IKTQgEu5q/UArQLUdE0nFMc1Qp967UwpvPpxI2zlbmfC7eU1nzg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: zhoumin <teczm@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	teczm@foxmail.com
Subject: Re: [RFC PATCH] vfat:avoid unnecessary check
Date: Fri,  5 Sep 2025 23:49:05 +0800
X-OQ-MSGID: <20250905154905.1150433-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87bjnqkpns.fsf@mail.parknet.co.jp>
References: <87bjnqkpns.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hirofumi

>> Remove redundant and unreachable name check code in dir.c.

> Looks like you changed the logic, but no explanation.

1. In fat_parse_long:
If (*de)->name[0] equals DELETED_FLAG, the function returns immediately.
Consequently, the subsequent IS_FREE check can never evaluate to true.
Therefore, retaining only the ATTR_VOLUME verification should be sufficient.

2. In fat_search_long:
If (*de)->name[0] equals DELETED_FLAG, the loop skips to the next iteration.
This makes the subsequent checks for IS_FREE and ATTR_EXT unreachable.These
checks should therefore be removed.

3. In __fat_readdir:
The same reasoning as in fat_search_long applies here.



>> Remove flags check in fat_update_time since fat does not support
>> inode version.
>>
>> Optimize fat_truncate_time to return a meaningful value, allowing
>> the removal of redundant inode checks in fat_update_time. This
>> ensures non-root inodes are validated only once.

> Also changed the logic, you removed the check of flags.

Changing the return value of fat_truncate_time and removing the ino check in 
fat_update_time is a minor optimization, as mentioned in my previous patch email.

The reason for removing the flags check is that the enum file_time_flags has
only four values. Since vfat does not support SB_I_VERSION, higher-level
functions such as inode_needs_update_time or inode_update_timestamps will never
set flags with S_VERSION. Thus, checking the flags is unnecessary.

Note that __mark_inode_dirty will not be called only for the root inode. This
logic remains consistent with the previous version.


Thanks,

zhoumin


