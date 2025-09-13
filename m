Return-Path: <linux-kernel+bounces-815106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B359B55FD6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E5E5A0239
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7FD2D6E60;
	Sat, 13 Sep 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1CiecMP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327301B5EB5;
	Sat, 13 Sep 2025 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757755246; cv=none; b=OLAuot1D40CoUW0HV1QPFaUi5GEXeOrDyfdZFnDpayShB3jAsQD20sU6nxnAA0uWvxQ2n/iPJuBevizEA88z5b3FR0M1qT5Bva+yROuk9wyvAbPC0BBvQxyRcP52DZN7jEG8FXBiRWHe9obXnMpmm2gfzWHpxQtdTTlgVn7cD44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757755246; c=relaxed/simple;
	bh=VhNgzjWhFHAY0JxD/ASuTUD+uwaVreOCvGCE2RaFaI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aq7xpfIZnPqZaNghYutbvcUhcElYX6FXhWE0vRu1LHn9+CT08pFjmbuF7hCz+gkOMsi5/+B3y9IGL1dLFUqiR4boZitmeWJutD2Q8A1IAN44ZoJmudB58/51K4CNogwm3lJ35XQocXy+Vf35IwnwXuE2thtpvd3Pco4dz6RdCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1CiecMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0E1C4CEEB;
	Sat, 13 Sep 2025 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757755245;
	bh=VhNgzjWhFHAY0JxD/ASuTUD+uwaVreOCvGCE2RaFaI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O1CiecMPE8eFgu/Sd3KKqnFogWYsshlSz9xI54uJMp/XIShlKPDTZTA7m7M9NRwVF
	 BXzo6HDsGOPlW/30698/zkMXLgsPudEk8ZgCV+etF4E1YfFGl520Gr6DlBon3gbU4f
	 KvC+iAc/pSFtxV9lg8eTNr5Qa5Dzc+1yAI3nZKyz++uYQed62aICPZAxg051t1hNAH
	 QR7vrlBymqccnURbj7Zyhp74nNp3kuKm9Jldmab+aFL25EFlCO1EKdQe9r+M+WoZPG
	 8J1M7xLZQAhNvwvPXFPFVcaiFoC/BXqBd8m5LF1pqsl0QM3KyNTp2LYoHzOVC/eLj6
	 RgLTe5jnt77dg==
Message-ID: <3c6ebf82-c3cd-47e7-b8c7-21c767b08722@kernel.org>
Date: Sat, 13 Sep 2025 11:20:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm: Add directive to format code in comment"
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Garcia <rampxxxx@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250912130649.27623-2-bagasdotme@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250912130649.27623-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 3:06 PM, Bagas Sanjaya wrote:
> Commit 6cc44e9618f03f ("drm: Add directive to format code in comment")
> fixes original Sphinx indentation warning as introduced in
> 471920ce25d50b ("drm/gpuvm: Add locking helpers"), by means of using
> code-block:: directive. It semantically conflicts with earlier
> bb324f85f72284 ("drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected
> usage in literal code block") that did the same using double colon
> syntax instead. These duplicated literal code block directives causes
> the original warnings not being fixed.
> 
> Revert 6cc44e9618f03f to keep things rolling without these warnings.
> 
> Fixes: 6cc44e9618f0 ("drm: Add directive to format code in comment")
> Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Applied to drm-misc-fixes, thanks!

