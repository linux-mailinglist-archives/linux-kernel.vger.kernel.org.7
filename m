Return-Path: <linux-kernel+bounces-740139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D83B0D082
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AE07A57E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B5F28B7CC;
	Tue, 22 Jul 2025 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8KfzNjs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BC81DDA32
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155895; cv=none; b=Y+iG7ZD9AnFngblkvlNSMC2s+KEtUnZoE8870ymZoxQvhhA6A6l6eyoVmaxSdt89iXRr1NfQrTVEUFMUTLqQaLa0XTe8GSeclWYlL3pCFIcXGQxB3MRPO0FE/shdTcxlwAQ3fnN470xnqOko9jEsV2NvDkt9TYehwl9U7iSwmGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155895; c=relaxed/simple;
	bh=HBkvK2FIkycCsMyaes5P4qpPldkypymFszhWbmSnX0w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PV1El+TQp5Jbkwy7Mwr+/ApVwnNqGVVRsh69HrlkMGWtEHG6vdENy5tNlgyRei9mg+Qp5IMSvU6GvsHOhpko8tX8xTPIKxwBBdow0XAYBx9x2rc2c7hfwV2+1+AhDKlNDdC0BZKwKbB0XBByr0nFfFgZK8s41bUGGZ6RmTuGdzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8KfzNjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4799EC4CEEB;
	Tue, 22 Jul 2025 03:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753155895;
	bh=HBkvK2FIkycCsMyaes5P4qpPldkypymFszhWbmSnX0w=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=P8KfzNjsYTU9/id93cDjW6sEdBAqd4fcwfdU9IJ7QsnJJmrToBjEWdLER0DeGzwGb
	 CDWPqQ5ltdBgEsIP7p1uYIYYoud/MS07zlEAkwVePnTmW0pVHEf7v1Xe9AX8fclNCa
	 HDHJnEezyEXq0dfQCaxB7wzik4yhdokLl4OqmIKMmBjoCZyvrq0O4Hc/8WDW0ahpIG
	 NJ1D7CJrt4n2/VFMX7Qk7Ts+xyVbdActSh8JTiXM6PGCp3uU+uc981QBq4msYWnGKt
	 bgCX1802bdS9t2y/9zrD+MU8tdBLaYiRsAqUjiza5OcwfSiUSlsAvjABiCyx4E+yh3
	 e0sgZHEG1W5YA==
Message-ID: <7a424039-8182-40a5-bc8b-0f04118ef0c6@kernel.org>
Date: Tue, 22 Jul 2025 11:44:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: ignore valid ratio when free section
 count is low
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250718220431.2290301-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250718220431.2290301-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/25 06:04, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Otherwise F2FS will not do GC in background in low free section.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

