Return-Path: <linux-kernel+bounces-790977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D84B3B09A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07931580D09
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCE71ABED9;
	Fri, 29 Aug 2025 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAsm3wpr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B33282F1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432188; cv=none; b=YCN+vkhFVyesu84Jgv4OPYL72uRjjoHomWPAxNM5TbAeOm2HlYusmhW47b8HsJey0wHsk62ZLJcqzualR+bC8L1phLQFa3A+bA2GuItwQIMWUGJ5biw2j3AVDNjtMK7s7928g8rJ3n2fIpXKj9B4Rp2fM8ipFQ5teUMiUMhw2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432188; c=relaxed/simple;
	bh=Eu1BSwSInxMgvQoeohi3KMf0iLlpoKYw/iZCtLnN0fQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j+I8UJ3WEhPkvo0TW+Fq3jHzmDfKhibor00l0opnXMm1SJuU587b298lu8ztaI6uSfWDwNogPDhN6DEGoToE1QDU9v0Wpa8eigvFriAvFknixU/EBF6dZ9WkyBjcdNBYbISHWKfCW3wFaPQVsISWjscI36uTUj4+CRa8Csq3AAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAsm3wpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDAEC4CEEB;
	Fri, 29 Aug 2025 01:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756432188;
	bh=Eu1BSwSInxMgvQoeohi3KMf0iLlpoKYw/iZCtLnN0fQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=OAsm3wprq3omOxrJZfjxcvqLvc5ivyHGY6oxuHg3iDzSBWJ3Gcfyj2Z5CNqahMhMV
	 NNAhKLQg7QlydoisOlNFDMwSOdU1tee0Y2Cbv3mdQ/D+zK4dEPOV9kvvsHzsSeQFUF
	 OXOdcDtzs0PfsFcSrsbOCoJ8EtkqVpWY9CDc/T7Yer7D46pXN8TpFGTECKA80XrtwN
	 oKuhf8InNVb1d8YSk/mGx4v562SKlEW7VQNfXRDveFAZHZBKhk4RpMmRct5/zahWSS
	 g3lYbk7I5WNllQktvZyC/025jUci0qiI2eQ1iN2ikKo6z8LxAxN59fpLHPAkJ9ysm3
	 mRM0Thrk886OA==
Message-ID: <3a821b08-4fc1-4dbf-b3e5-d142e61d307e@kernel.org>
Date: Fri, 29 Aug 2025 09:49:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH v4] f2fs: Use allocate_section_policy to control write
 priority in multi-devices setups
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20250828081130.392736-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250828081130.392736-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/2025 4:11 PM, Liao Yuanhong wrote:
> Introduces two new sys nodes: allocate_section_hint and
> allocate_section_policy. The allocate_section_hint identifies the boundary
> between devices, measured in sections; it defaults to the end of the device
> for single storage setups, and the end of the first device for multiple
> storage setups. The allocate_section_policy determines the write strategy,
> with a default value of 0 for normal sequential write strategy. A value of
> 1 prioritizes writes before the allocate_section_hint, while a value of 2
> prioritizes writes after it.
> 
> This strategy addresses the issue where, despite F2FS supporting multiple
> devices, SOC vendors lack multi-devices support (currently only supporting
> zoned devices). As a workaround, multiple storage devices are mapped to a
> single dm device. Both this workaround and the F2FS multi-devices solution
> may require prioritizing writing to certain devices, such as a device with
> better performance or when switching is needed due to performance
> degradation near a device's end. For scenarios with more than two devices,
> sort them at mount time to utilize this feature.
> 
> When using this feature with a single storage device, it has almost no
> impact. However, for configurations where multiple storage devices are
> mapped to the same dm device using F2FS, utilizing this feature can provide
> some optimization benefits. Therefore, I believe it should not be limited
> to just multi-devices usage.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

