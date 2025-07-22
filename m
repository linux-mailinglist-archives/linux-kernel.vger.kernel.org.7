Return-Path: <linux-kernel+bounces-740169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1FDB0D0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A48A6C05B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79E1E0E00;
	Tue, 22 Jul 2025 04:25:31 +0000 (UTC)
Received: from invmail3.skhynix.com (exvmail3.hynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0F22EF4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753158331; cv=none; b=WEY8iBYRHU6reGBYeJ5RZW7hScPeLHT1I67X5cEu4Vzyw4D8jiX8UZ8/wGMobNfqzpqoZKdp/BkmRlyFzC8HlSeglC7BiRwAJJ5zQt6HBwfI/yrP4nFkncCAWoBAdtO+LQc1OJ9XhDmnW8CVazApcQYHjOGH5BPSiAldwc6BBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753158331; c=relaxed/simple;
	bh=NJfpPEo48sCyc1vl9ymSGEX+cBooghUOSphJTYW1cxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bp08nJ0JXJ2WGdqNKn7J/4lqjGA/6+gtMnnEeVEo7X2Qo150Aq5zhgh0v/TJwcQy7R4UkfBQl/hC8gIsM0ibQPAz3uCjDXgHxghmgL8geaAkdfJ0gDQbkCGIAxUCczLOv++xRplWxiDermSG1yFCe/Q8q4H5z+p8YxgKPBnLUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-03fff7000000aab6-83-687f12ad647c
From: "yohan.joung" <yohan.joung@sk.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: chao@kernel.org,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org,
	pilhyun.kim@sk.com,
	yohan.joung@sk.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: zone: wait for inflight dio completion, excluding pinned files
Date: Tue, 22 Jul 2025 13:25:14 +0900
Message-ID: <20250722042515.1403-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <fed85e52-2965-41d0-9e73-8f2e15dbef06@kernel.org>
References: <fed85e52-2965-41d0-9e73-8f2e15dbef06@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsXC9ZZnoe4GofoMg7Vt7Banp55lsniyfhaz
	xaVF7haXd81hc2Dx2LSqk81j94LPTB6fN8kFMEdx2aSk5mSWpRbp2yVwZTzZ9o+pYAN7xao3
	39gaGJvYuhg5OSQETCTe7/8JZHOA2f+eSYCE2QQ0JP709jKD2CICWhITG/4ygtjMAqUSvc+X
	gdnCAikSk07cBLNZBFQlDpw6wA5i8wqYSdx/8owRYrymxI4v55lAbE4BO4nuHRBxIQFbiRur
	Z7BA1AtKnJz5hAVivrxE89bZQHu5gHo/skqsPH+XHWKQpMTBFTdYJjDyz0LSMwtJzwJGplWM
	Ipl5ZbmJmTnGesXZGZV5mRV6yfm5mxiBwbes9k/kDsZvF4IPMQpwMCrx8Co01GUIsSaWFVfm
	HmKU4GBWEuH9thsoxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJ
	g1OqgXFOfJlKsPDpb75bDVU3rp184z5La/uXeaIHFh8oKKqadHaT20y/T09fa/4Sdbu2xs14
	2wndOvV0/Qd2/KGL5fY2CUxiXFKn7jBr9/5zR37Ou78x9rbFst5PpQyGhQt02S15p0aK35PM
	+BrC8o7tKcMGwaqGl7fbeu4G8H/z1F106vrq/LDrEX+VWIozEg21mIuKEwEG88yyOgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsXCNUNlju5aofoMgyM3GC1OTz3LZPFk/Sxm
	i0uL3C0u75rDZjFh7lUmi/db7zE6sHlsWtXJ5rF7wWcmj2+3PTw+b5ILYInisklJzcksSy3S
	t0vgyniy7R9TwQb2ilVvvrE1MDaxdTFycEgImEj8eybRxcjJwSagIfGnt5cZxBYR0JKY2PCX
	EcRmFiiV6H2+DMwWFkiRmHTiJpjNIqAqceDUAXYQm1fATOL+k2dgcQkBTYkdX84zgdicAnYS
	3Tsg4kICthI3Vs9ggagXlDg58wkLxHx5ieats5knMPLMQpKahSS1gJFpFaNIZl5ZbmJmjple
	cXZGZV5mhV5yfu4mRmA4Lav9M2kH47fL7ocYBTgYlXh4FRrqMoRYE8uKK3MPMUpwMCuJ8H7b
	DRTiTUmsrEotyo8vKs1JLT7EKM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpg3LfCRkDz
	U7v4/p2evOJy/w/te3L6nUCU8lzJBwoz3l1lTw5w27X0+aRN/O9rwz78FNa7EV/V7t5fcPK9
	XNTmtcsy/Y3aneJ09l3JSY61t9accbUn6HvILLGwhO4+JqFg1ReWCydKrv/bs/zLrTO+aiIx
	kRmsk87LyW9eXiGRIDXZwqVp43YOJZbijERDLeai4kQAP3QtzCMCAAA=
X-CFilter-Loop: Reflected

>On 7/21/25 13:41, yohan.joung wrote:
>> pinfile is excluded as it operates with direct I/O
>
>pinfile can use buffer IO as well?
only considered direct I/O. I'll re-upload the pinfile considering buffered I/O
Thanks
>
>Thanks,
>
>> 
>> Signed-off-by: yohan.joung <yohan.joung@sk.com>
>> ---
>>  fs/f2fs/file.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 4039ccb5022c..cac8c9650a7a 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -4844,7 +4844,8 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>  
>>  	/* In LFS mode, if there is inflight dio, wait for its completion */
>>  	if (f2fs_lfs_mode(F2FS_I_SB(inode)) &&
>> -	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE))
>> +	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE) &&
>> +		!f2fs_is_pinned_file(inode))
>>  		inode_dio_wait(inode);
>>  

