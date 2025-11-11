Return-Path: <linux-kernel+bounces-894560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B6C4B4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09413AB21C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E55347FC0;
	Tue, 11 Nov 2025 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="TMKDQuhU"
Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5AD2E719C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831297; cv=none; b=udfv3n6El5V8FsE/vl5hHLgdtJlQI1Ttd7p7l6XQfm9WlJBsmR+Q44gHwox7WN+UCARHsxtSntMsnm2MUkS8lw9oVZyjvRDQgO66EXRZMiwjjCoFy3o1h8OyHQv9ORBpwOeeMfJhSL9myI74rUZg36h31jfIhS14icv0PErh7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831297; c=relaxed/simple;
	bh=AHB52eEjxStBQk6dZmmYcxvMe3M9shlVvPTqOYRW2C0=;
	h=Subject:Date:Message-Id:Mime-Version:From:To:Content-Type:
	 In-Reply-To:References:Cc; b=N0T1eoLfYcDRRft7yp+KGa22+AaiS8n7x5TiCC7/k7zF3eX3mLCi4GFAB4qcAFZxzpkLFzhx2xk+gy+Eydpelv+3rvaTO6VwQEzO1QK9QdaQHHN5GYopwpyBf2YJatzVW5SUrg3whOMGtDZlztO+BVQ+luPbXG1EU/8wHHCeMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=TMKDQuhU; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762831282;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=kb27e6BRLAEUtSqm3v58wAJXfNor0uUU3QfgJ1slkZE=;
 b=TMKDQuhUxXXptVT6PpAwOZoGLBS2B5kKgucHSnI1z7MXmQW2PGHV7N9KSwHnCzOMxWWni2
 K+rDKm9CUk1fBMw0nRzaUNsz48OieSK7nhRNwcHR0kp5oyK9iBBqoJUHWPj+MS3GIl3W3I
 CFhR7BivGmIeiHtkUpCbEL3DXzKyHDUd79qmb+//VzTRrdCByLCndqtDWkUA4tlTGZbCk8
 /ykl0qg7IfsTUe/fIssXAXKeM0KzaneqnbY747UF8e20Yr+lPxdx4NC9pLve24BhdqmFz6
 zHRlKlkBDGFPxWhNiAe1sPynzckQ8HwhiFoT03hn4uZ0Vd9baC3A8K771C+2Yg==
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 11:21:19 +0800
X-Lms-Return-Path: <lba+26912abb0+376742+vger.kernel.org+yukuai@fnnas.com>
Subject: Re: [PATCH v9 0/5] make logical block size configurable
Date: Tue, 11 Nov 2025 11:21:17 +0800
Message-Id: <10606bd7-0a41-4885-be34-b72e26595816@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Yu Kuai" <yukuai@fnnas.com>
To: <linan666@huaweicloud.com>, <corbet@lwn.net>, <song@kernel.org>, 
	<linan122@huawei.com>, <xni@redhat.com>, <hare@suse.de>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251103125757.1405796-1-linan666@huaweicloud.com>
References: <20251103125757.1405796-1-linan666@huaweicloud.com>
Reply-To: yukuai@fnnas.com
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Cc: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-raid@vger.kernel.org>, <yangerkun@huawei.com>, 
	<yi.zhang@huawei.com>

=E5=9C=A8 2025/11/3 20:57, linan666@huaweicloud.com =E5=86=99=E9=81=93:

> From: Li Nan <linan122@huawei.com>
>
> v9:
>   - Add new patch to intorduce check_new_feature to address forward and
>     backward compatibility
>   - Patch 5: update description of check_new_feature in md.rst
>
> v8:
>   - Path 2: remove unnecessary bioset_initialized() check.
>   - Path 3: remove the max(blksize, ...)
>   - Path 4: set MD_SB_CHANGE_DEVS instead of call md_update_sb()
>
> v7:
>   - Add three prerequisite patch to fix some config lbs related issues
>   - Update sb when lbs configuration is done
>   - This feature should support raid0, update documentation accordingly
>
> Li Nan (5):
>    md: delete md_redundancy_group when array is becoming inactive
>    md: init bioset in mddev_init
>    md/raid0: Move queue limit setup before r0conf initialization
>    md: add check_new_feature module parameter
>    md: allow configuring logical block size
>
>   Documentation/admin-guide/md.rst |  10 ++
>   drivers/md/md.h                  |   1 +
>   include/uapi/linux/raid/md_p.h   |   3 +-
>   drivers/md/md-linear.c           |   1 +
>   drivers/md/md.c                  | 162 +++++++++++++++++++++++--------
>   drivers/md/raid0.c               |  17 ++--
>   drivers/md/raid1.c               |   1 +
>   drivers/md/raid10.c              |   1 +
>   drivers/md/raid5.c               |   1 +
>   9 files changed, 148 insertions(+), 49 deletions(-)

Applied to md-6.19
Thanks

