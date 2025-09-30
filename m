Return-Path: <linux-kernel+bounces-837492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B1BBAC6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11019189C337
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870E2F659A;
	Tue, 30 Sep 2025 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VEUhEU6f"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162223B62C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227203; cv=none; b=u8hdgGjKy3G+4LnJRhBGIPOAFaYw8JbSjSACmP5JjLrHn/kvcTBKs+CVcQtKJYnuFMHWpifql50lDKc5C+daziNc00gsnimaYotw1ZQ4NliiOO9LR0hfOhZetiolDxUVuxEtv0tVax/qX10QbLFMui/v0Onecg5d4Xm+NqhwDac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227203; c=relaxed/simple;
	bh=nxojs/i6jbB1qHl/95oSlU4YHbHQm8oweo9Dh9VqlR8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsi2tKsIfGi1sY7yLhqSQ+tJgM4M2iA4Y6ySFVsik1IbznJalG684KvNYOanIoAv52qQqjoTFXH+VrY3au79O/CHdPOrjIJ5lDjxYxJUuG/DN54C/F5YuUBwtohL5t6kuKzgWE9v7Vl5IhqZsA9hB+3qT7FcY+/WRO95JsHxb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VEUhEU6f; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759227198; bh=+z4VuSEyqyHbymvozcwTCmyPiBeyYrKjSnszB1XAJjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VEUhEU6fyW+exFhw6IHiu1e9CxZTJFJddNy5ylvWEYy5XfXK+dq/itN/2Zp16pOD5
	 aR/TOubc5vow2Zgfmd+Ocb+YjhecVrsS28o7lOgI1iDNCxh4VINp7d0y8JPw/fky7K
	 cdNmCGcuTl6ojXK57WUvm2uTubC0zITaTErTo/YY=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 13128091; Tue, 30 Sep 2025 18:04:49 +0800
X-QQ-mid: xmsmtpt1759226689trcyp1n79
Message-ID: <tencent_5A915E07B07A5564B9DA65F6F002EBD91209@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoedgpXSJFomO/6fblRmk4vCwGYnjkIVYH7C3nIeehO22HyWf6OTT
	 H82d301dWqKCR6Zau631ToEr6wLdpL01e2uNZ0DkXPdyBkGq4MMcx0bzALvqRRGmGHiC0+B7Tbut
	 VpJh9GqMZZc6T6N+1mSw42oikLVgFlFGHn3kbLyEeGDhM6VUv8/ecQOS7xQDbvXxnbfXGIaUTa2c
	 huBhC1jsGroSIENX6/4gAQ2yR1I8G2fevqyHr5y1raXXdV7V1ru5Z8Pc3u2Y/nu7aIm3RQZboMkX
	 ZQThhzTkoJ1YcEb0IcLs/Yg5+3+f4HmgYEsSU21nzhLG2i19G6EEmZN/ivX7IsL11sQj2nxCW4SU
	 cJ6Wr0fYk3/gTMknAvXJOusPZKQmceIYmAKkLv31Kh4QtyYmSLn7hc2Z8I5B9p8d0lMbyv9QbOLS
	 /guEW8rDpqyCvuoPunyMOVXTXUOASy3Xq2yLcJxWHWShWAXiL1nkOAVanl3mQTHzRlfJl5rKDwf+
	 00jrpLv4mxGHuae9T7TfaoajGslaaeB6olqPZcRg+teimElxnVsnogvqcINUqcQyJv6zcX8cMlpA
	 YIOw+Vo/BWH1gb+rp8ydotkVrYzyRjgF0g5GBKB8bORcI0ncVY72JPVOHMoVkF0pKTQw9tbOndmo
	 VXAXRGqUBEtfFYe//HbdE2XPGeBg6FeNkZ7FI0ugQXCc33CKnJhI8HjiYaswMoaVYYYe8EHcx4cG
	 n/dVpnwEmbjczpeIuqUuN9zLoeM5Xwd5ZjNIzw60uT99jaGQw1pHW5IlANrrYTu/Fj4E3fmv/Oqn
	 bkKbqcVHfww4a4q9cgt/Yy898GwktiDdCaQKcUY+uTFt02BheKiv3qlR1rxDQvA/i9L+KFb1DqJy
	 Qtj5oPrqNam3m6vxODHVtkbzUCfRjCGeRkPGahuZGN8cA33ZVY1ZkSFYY0DxoWJOrvvJF0y/Guin
	 nmWeHwnwX6xzw18gI/Yc6XPkeeeV+222be+Q8KPFXUMXUEgfjNagW1VUTQdHpdnLBGxkeGPD29PB
	 N/uGm0+b+Pw5jMuxCQ6xdHgYTW7gk68/V7uW6bYFt9A6GxVwQj
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Haofeng Li <920484857@qq.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: 13266079573@163.com,
	920484857@qq.com,
	chao@kernel.org,
	jaegeuk@kernel.org,
	lihaofeng@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix ifolio memory leak in f2fs_move_inline_dirents error path
Date: Tue, 30 Sep 2025 18:04:48 +0800
X-OQ-MSGID: <20250930100448.4061644-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_3FA2C956B557ED4D050EB26922B50D3CF40A@qq.com>
References: <tencent_3FA2C956B557ED4D050EB26922B50D3CF40A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>Fixes a memory leak issue in f2fs_move_inline_dirents() where
>the ifolio is not properly released in certain error paths.

>Problem Analysis:
>- In f2fs_try_convert_inline_dir(), ifolio is acquired via f2fs_get_inode_folio()
>- When do_convert_inline_dir() fails, the caller expects ifolio to be released
>- However, in f2fs_move_inline_dirents(), two specific error paths don't release ifolio

Add some additional information.

When do_convert_inline_dir() fails in f2fs_try_convert_inline_dir(),
the ifolio obtained via f2fs_get_inode_folio() is not properly released,
leading to a memory leak.

The issue occurs in the following call path:

f2fs_try_convert_inline_dir()
├── f2fs_get_inode_folio()  // acquires ifolio
├── do_convert_inline_dir()
│   ├── f2fs_move_inline_dirents() // The issue is in this function. 
│   │   └── Error paths may not release ifolio
└── Only releases ifolio on success: if (!err) f2fs_folio_put(ifolio, true)

Specifically, in f2fs_move_inline_dirents():
- If f2fs_reserve_block() fails, the function jumps to 'out' label
- The 'out' label only releases the newly allocated 'folio' but not 'ifolio'
- This leaves ifolio unreleased when f2fs_reserve_block() fails

In contrast, f2fs_move_rehashed_dirents() properly handles ifolio release
in its error recovery path, but the inconsistency creates a leak risk.


