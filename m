Return-Path: <linux-kernel+bounces-886351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5F1C35521
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F693B5939
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF630F551;
	Wed,  5 Nov 2025 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p29hFktc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF513093B5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341294; cv=none; b=iwCvNKKvMHU+cq6OWlXt2scuo7YlLveQSPYl1vhvUdh5JRkRhwvnoIPEFmT1ZciqFz7BZtNkpBePlq3K+7zi6BmBEKLjhiYg+s7jKrUdKxYiaZvCNNSntjFw7Z3mO6WWjlJEB1kTP3FZ99U7RXkWFVYw2YfUqUua4FHCfdNmf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341294; c=relaxed/simple;
	bh=Hr1qTb8xrcj/E/cr8cExwDIT7AhrOUIw7GHOKQAcWp0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UGPphehTkebQPmQgY7xWpZ5yrSEBWssRMaY8K1ZR4lDzx738/DEKY8Sw87JeWlDzh/GGR4SsihlfDytaFpgYqPocDF0yYydEzVbbeFaBuSZZdgED/KLzWWSOrB0ZV+7vlqbNGPTjFGPFCRKDG9hPIDnzcAAvdmeGsjd4XK3pL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p29hFktc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B78DC4CEF8;
	Wed,  5 Nov 2025 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762341294;
	bh=Hr1qTb8xrcj/E/cr8cExwDIT7AhrOUIw7GHOKQAcWp0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=p29hFktc6Y/DOjgHQGqLmyPglzmOJ5TqpoSQR3mwqzS0cbSSFfYb+xVRfubj1TTjP
	 641tsmlYpm5Mp9BRgHHse9AOewUIIRBRRE+7tYAllNbUEND2ebt9ZTIHf0ToUoO4bv
	 H/q3wc9seDlDK/bBB99enkqYv7kk3PU8tYHXHLKZYuz0z8WYPNBJNdw6eGFqhI72Hk
	 IGHPU+ITHU+GVJm+IxKeH/iiGI3tCEYH2JrXDUrU3USk0tkLF1rPDcXRE+FX1q7eXY
	 25f9EvEhyFfRu49GKOvtzH4fMVcg9uUF1oezsHldg+TEO35VwmedO3rxT2kQ8IGc0S
	 TqDWlDQhwskKw==
Message-ID: <96a9d740-5a96-4795-b69e-0cd0e165ad4a@kernel.org>
Date: Wed, 5 Nov 2025 19:14:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org,
 stable@kernel.org, syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 2/2] f2fs: Add sanity checks before unlinking and
 loading inodes
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1762339963.git.zlatistiv@gmail.com>
 <c56dfb1f6a27cd04a91d41a0448a26118c7cdc38.1762339963.git.zlatistiv@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <c56dfb1f6a27cd04a91d41a0448a26118c7cdc38.1762339963.git.zlatistiv@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 19:09, Nikola Z. Ivanov wrote:
> Add check for inode->i_nlink == 1 for directories during unlink,
> as their value is decremented twice, which can trigger a warning in
> drop_nlink. In such case mark the filesystem as corrupted and return
> from the function call with the relevant failure return value.
> 
> Additionally add the check for i_nlink == 1 in
> sanity_check_inode in order to detect on-disk corruption early.
> 
> Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
> Tested-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

