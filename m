Return-Path: <linux-kernel+bounces-761117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574DAB1F497
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 14:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC1E1734BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680C27FD4F;
	Sat,  9 Aug 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIRviGx2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AC27877B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754743105; cv=none; b=c30ZnqKiC6o34Iq80UjfzTBAzQrDnXJAhGtZHApt0QxRCFzC4k/LP/PngH0c9y9EahuhY/VC5w4hkhxrqk1I1bS+QutefcmQRY+yLOcZOWzwhW35eBqhJAtWsf2z/Vl+Z2j9LE+57wjhX2q7R5zKRN7D2+A7zUrNUWnRBRuCeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754743105; c=relaxed/simple;
	bh=mfj8l/jji6+mSWO4VqUyU4IwT2ivmhxapsG2ScXQlVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/hXwk6OVFt5Tx2dvrDVi8WhfqOD86YjkZeolox8pS7RcOEKuvAtap6/+yZkkTtUFVfGOKLcbuDttx45zzyno2VFtOePua1tHMZRPf2hkq+QxWgEbe7xCgPx8NM+8QmO2hs16PxEn5ryB9Sx1CFZEwT/4AyajgUsCeYLfKvPYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIRviGx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C23C4CEE7;
	Sat,  9 Aug 2025 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754743104;
	bh=mfj8l/jji6+mSWO4VqUyU4IwT2ivmhxapsG2ScXQlVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oIRviGx2luQmHQHen1bqtwnjHv1Q83WQRePmFTPW0SBC6RlaGPQ6JakssQU0dhmv4
	 Dfw7q5GjSiQkEUKxXtJjvky3lBmBJgtX+xEbISAqz28S3kYip7/w73Phh/DrSNuYnz
	 6SwIoFqGl8fsFEDEyKZl2nIWh//AzziUEKFwxU8Yv5xUbCdztMkhfo3EZsLwk33HhK
	 WkmRWtsYepNvxEjSnQFbVgy8e6sJD7PZUncof8ZqcFTQikfuMbM1cOCMrUkN36/ZAG
	 y3TuQmg1lpPzyUkZpmsNIvIEc6r4v5+l2XdqB4sCILsTHvZfOQqCW6TtcBQ28C6cy3
	 cKoQRHsJnPehg==
Message-ID: <689070db-1afc-42dd-857d-4edd0ee3d040@kernel.org>
Date: Sat, 9 Aug 2025 14:38:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: fix typos in comments
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: lyude@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20250808073840.376764-1-madhurkumar004@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250808073840.376764-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/25 9:38 AM, Madhur Kumar wrote:
> Fixed three spelling mistakes in nouveau_exec.c comments:
>   - alloctor -> allocator
>   - exectued -> executed
>   - depent -> depend
> 
> No functional changes.
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>

Applied to drm-misc-fixes, thanks!

