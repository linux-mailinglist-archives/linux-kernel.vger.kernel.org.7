Return-Path: <linux-kernel+bounces-835354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D73BA6D96
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D673AFC41
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF92C21DD;
	Sun, 28 Sep 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC3eo0/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EF208994
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759051836; cv=none; b=Zv4/1v9PiAlU2BcYx2wvjzOhPsk6kIxpBo9LfzXDhPZL340CRxrWHEQ+NhrVIz0E2zxN9WXS0eJKoDqJ5/qwAyV+OLRiCMtRC3WHL5dvlEs8J1cMG6I9Q7ja/wjZNRzBmUr5bxVB1+jYR4sdEw0hXl78BEZjN35nPWfScRVU+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759051836; c=relaxed/simple;
	bh=Azl5SLDOTEZ7t3KEBMBXasVPE/4KvOxX1+sg5HSVNMU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AAbezkVXJMH+uPYTA/xB/C01lDFHrvPC6skUUJ1+HoaIT+6ZM6uECKTZidLEwKrY/8Zl8+ObmSJmKs/xYQUdBj1sZuMoodeP/cQ4bu2z/eXYZtfNtE/BaWVdB8Mq+9C5bxsadGzWzgnL4TB4VDe0Ed/zvNl01L/YLT8xAcPIWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC3eo0/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E74DC116B1;
	Sun, 28 Sep 2025 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759051836;
	bh=Azl5SLDOTEZ7t3KEBMBXasVPE/4KvOxX1+sg5HSVNMU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=vC3eo0/pn7J9kdVw/Dcs59pXs6c/8W+0fuS1sKaFu4TFTpX/OW5zI7x4gZ9B3SSIm
	 ib4e8hYM3KWl8ow+0K/ZzB1wOF/P61RdvEMSbIN1PjwBEGNAHXPmTHLpV71hJvzrF0
	 wxcn1BvZtpBVUVv15/4fSRcA7DCoYmQTF8ORzKQs2JXnm9BzKCAmgj7qWbW0GO1NTK
	 2yi/p0dB1NdMYt8/EsbGZeGckcw06RPwefYfPjXsxa8EwqmJCv9y5HMd3kt4uQOkGg
	 ZtgI68hnXDTEiox3K29RYxDWv4nx+hfIwn5eUYWFtgppwEWScuvH9Hms7GXJOdIeUD
	 USjgVuywpFWZw==
Message-ID: <1a931cfa-0846-488b-ab1a-f3dee33e1d21@kernel.org>
Date: Sun, 28 Sep 2025 17:30:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: f2fs: Fix typos in sysfs-fs-f2fs
To: Akiyoshi Kurita <weibu@redadmin.org>, jaegeuk@kernel.org
References: <20250926180134.35329-1-weibu@redadmin.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250926180134.35329-1-weibu@redadmin.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/2025 2:01 AM, Akiyoshi Kurita wrote:
> Fix two spelling mistakes in the f2fs sysfs ABI documentation:
> - deivces -> devices
> - substracting -> subtracting
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

