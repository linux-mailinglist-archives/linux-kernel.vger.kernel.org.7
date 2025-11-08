Return-Path: <linux-kernel+bounces-891463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A56C42B64
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B2CA4E58A1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0233002C2;
	Sat,  8 Nov 2025 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="V59YOnbZ"
Received: from sg-1-30.ptr.blmpb.com (sg-1-30.ptr.blmpb.com [118.26.132.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA262D63FF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762598260; cv=none; b=uHGxQDv9c3ugMwLbCAkXvlw5Ruzu7/odVkIaiJICjFvAzi7J47dhoOy/2VQ4QTZfE+8aq5YUDX8b9ZHA4xDCQZzd9s6dJufR6Fv2T7V++qC5kUWf64KXxCvFzvKKQhxND5ityTgSY/yoC33JG5v0P0FapNgb3xiVzee2Vtbv6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762598260; c=relaxed/simple;
	bh=X6GQA8WrjZf+Fp67jsfHi5BrZFA7MMXQmlZhwh14uBM=;
	h=To:Cc:Content-Type:Subject:Message-Id:In-Reply-To:From:Date:
	 Mime-Version:References; b=GOE3GObQRsLw9k35yzqVjKxrBprQErEHnWk6bEiXw9zuoH5G8hWbvB+Wdn/53OsDkKAU4GesoOh6eboRCCf5xneO44yORFQEuFdY+WOKfdTf3jCFMmxcpV8vrlRsr6OnF6qZ7QwhFM4519WI1r8g/X5jP+xlttOADkGknv3X64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=V59YOnbZ; arc=none smtp.client-ip=118.26.132.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762598252;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rMeEmkNPFdJvEeyXoyj9KOXHVJrtNPJ8SodXTHC5SCI=;
 b=V59YOnbZ4H3skUMBB1+bpJL+gxQlUlQLPKllMXm+NVDfNNIZkeJzc/UIMaCO08nsVi7Qej
 MfdIoiZxqXSf8ap+ylrWD1QU79kyZXUTs9A8liqaI9A37g7hhOgXbYUjylI+Zz/ztwbsvg
 CLyO9t821m+Tmc8g4KE3/UBLaBokfuOoSMAEuwRufLzom4IJG0NGoco3F95OfDu5Ghsi6f
 Zl34TaSE1/B+vlB0v5JC2ORz3kJf0URAwf1atzkFH0Qj+y5WdVieYV9FN3oI3BlM1kTc0N
 RSUhXaBlk5zHw4AWmKgpRMEWYg9c97HXfLVpl/6dG58mndINVZgA2mtJoxpUwA==
To: <linan666@huaweicloud.com>, <song@kernel.org>, <neil@brown.name>, 
	<namhyung@gmail.com>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fnnas.com
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<xni@redhat.com>, <k@mgml.me>, <yangerkun@huawei.com>, 
	<yi.zhang@huawei.com>, <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+2690f1d6a+6e88ab+vger.kernel.org+yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Sat, 08 Nov 2025 18:37:29 +0800
Subject: Re: [PATCH v2 08/11] md: move finish_reshape to md_finish_sync()
Message-Id: <0f4fb54a-a477-4522-8dc5-87e5aadfa2dc@fnnas.com>
In-Reply-To: <20251106115935.2148714-9-linan666@huaweicloud.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Sat, 8 Nov 2025 18:37:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fnnas.com>
References: <20251106115935.2148714-1-linan666@huaweicloud.com> <20251106115935.2148714-9-linan666@huaweicloud.com>

=E5=9C=A8 2025/11/6 19:59, linan666@huaweicloud.com =E5=86=99=E9=81=93:

> finish_reshape implementations of raid10 and raid5 only update mddev
> and rdev configurations. Move these operations to md_finish_sync() as
> it is more appropriate.
>
> No functional changes.
>
> Signed-off-by: Li Nan<linan122@huawei.com>
> ---
>   drivers/md/md.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai@fnnas.com>

