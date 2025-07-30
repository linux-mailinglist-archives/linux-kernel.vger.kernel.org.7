Return-Path: <linux-kernel+bounces-750320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17015B159FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDFF17DFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A525291C;
	Wed, 30 Jul 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYCSGonn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FF2AD04
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861843; cv=none; b=FMiYWZ4EJEXwKCuzbrL1nxqOtjVC9S47LExgkjEBbinwSn6fXdO82sLQVo2JbLlX6MaJsrLTeSeLTWn+fwQnaBjCgefO4X4zti4fGwe5pb4rQ8rTn8rSFXC18vQUkG/7tOZfdyD+B/bwRrF3Lgw+wKVQaKDEilleovSjiX79c3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861843; c=relaxed/simple;
	bh=PLxMdyBOmFm9Wv/N1YgZMHVRlt7b4RNf6Pesv4a8inY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b2Kflyxvoal5fV6YVnOWhalezpJD9PcEEHm1o0WVE6yhMvtgJuW3pNWSK4WzQnde0VCZE0ZOmZv/CFskxzE32sNnGr0udcEJYu9KrLQK9hOfnF9LLpsK3lpQeH1gdnDAM3EnNqp3ZlQVY8l4BqZDx5+BqLvf+YlGYHfojHkix90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYCSGonn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ACCC4CEE7;
	Wed, 30 Jul 2025 07:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753861842;
	bh=PLxMdyBOmFm9Wv/N1YgZMHVRlt7b4RNf6Pesv4a8inY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EYCSGonn4Uyj2IQt+XtjAr1zsOU+QI/yWtMTG/AutFFFx+Fi/2yCI4+OEpfWVliMF
	 2KSKE07nc1pi5cuehXGFduBXlREMqIH3jOwFsiRyJXJMWxzLS4+qMG99R7iwiSjMu+
	 sBCom3PuB9sg3h4mi3vqzozoLFoBqnpCkFaL4JSz3ESD5MhxGDoiswt33pk7QiTTkG
	 f3sxH2TEW40V4kq/c7OU1hogPmnBLwLol4GicG6fZRr+hmh7YzzlJp7DxdswmZbP2j
	 hC1WdA/7Ylav6N88YQFPHPpa/GHYaZwCWu1XUcAgWrcpShvpq7uLMTkW6KxLHY1Rbs
	 V/zee1KaOJlsA==
Message-ID: <a0ecb0c8-6f29-4b71-936d-69b0c30dbbe7@kernel.org>
Date: Wed, 30 Jul 2025 15:50:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: drop inode from the donation list when
 the last file is closed
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250729204719.1253285-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250729204719.1253285-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 04:47, Jaegeuk Kim via Linux-f2fs-devel wrote:
> Let's drop the inode from the donation list when there is no other
> open file.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

