Return-Path: <linux-kernel+bounces-834677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B1BA5406
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694D55609CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A98283CB8;
	Fri, 26 Sep 2025 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lvDb9VVw"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9BE2E7F17
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923286; cv=none; b=lYhURb2Iz+AHuyu82364RTnxpsDxBx1vCpfP5s8+zw1wv7BJzF9CfsclgKBvPYIolbugdsK4fv1TRs1D59LIp4PI7CjJzENXPdmZvuyNPchHMbipgLOkj8Y51HZHpLJYT7i8LA2SmlZzDPz6cV3MSUMRmzKY7Sy66dG2k7dRTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923286; c=relaxed/simple;
	bh=wM1ZdKu8TbDZj+AqXMs7WCeaV16PbANvzAExvV/7kwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9A+66k5gR3NnWL5qnU3vjpI/q6nkEmQOviRu9ehBsksIcV2NsK1kZSyStEMCEoPaZ2hoqkKU8qr6bk0sJer6ellDC1OyB+lDkWf/ZjmC/VrqBEFZxVv7ol3yX8t4NKkioTHSok7OzGtLhz18TazM0YrkqsX+5DyqUEEby7PB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lvDb9VVw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLltDP014728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923277; bh=lNpPeubtMKFqy2oXXeK426X4c097gMLqfGNSXOWUvgw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=lvDb9VVwE1bbDg0cz5QhNdTuHC+fSCsU7pjxWwuKw791N3VGjL1zR1yppqOSKFSdK
	 0Ef46O7HNfm2nDf35zwDrnqYuw+MCar9axobLmPonGmgh+cIGHA7jTzGvSJnZiFcbS
	 jr8rzLSiNjN+OE0eVXnHpGZjdIKH89zbs1VU39/X0TjhNAJimSBzurWHq+2pWu2Rrh
	 BBcSf/ig0ROlE9hyddL9mDGkVrOX7/oZEua8a3soR8/NfoHbmEVJ+sw883MiNjp3K4
	 O+q6A+f0AwuVLvOa8miYDgheFbjdacmJRWcp24k9UJtzrq61Q8WefMP2ZEZm98/U+d
	 CzOL87rZN1Ojg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DD7EB2E00DE; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: validate ea_ino and size in check_xattrs
Date: Fri, 26 Sep 2025 17:47:39 -0400
Message-ID: <175892300646.128029.17851339613487184890.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923133245.1091761-1-kartikey406@gmail.com>
References: <20250923133245.1091761-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Sep 2025 19:02:45 +0530, Deepanshu Kartikey wrote:
> During xattr block validation, check_xattrs() processes xattr entries
> without validating that entries claiming to use EA inodes have non-zero
> sizes. Corrupted filesystems may contain xattr entries where e_value_size
> is zero but e_value_inum is non-zero, indicating invalid xattr data.
> 
> Add validation in check_xattrs() to detect this corruption pattern early
> and return -EFSCORRUPTED, preventing invalid xattr entries from causing
> issues throughout the ext4 codebase.
> 
> [...]

Applied, thanks!

[1/1] ext4: validate ea_ino and size in check_xattrs
      commit: 44d2a72f4d64655f906ba47a5e108733f59e6f28

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

