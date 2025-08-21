Return-Path: <linux-kernel+bounces-778826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F00DB2EBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F837AEA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFAE2D5410;
	Thu, 21 Aug 2025 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d7HeN6U1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D0277C90;
	Thu, 21 Aug 2025 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745593; cv=none; b=Eoc4aciwSzqM2MKnCItzcuZec9odHAXjy1RqeY8XUoFT1MddASiDPDqR3q0gNBeJeVOH9nWA1X4UMeh7VytA4PXML8J4LCQfnO/2EPlzcQoYNTSWgv7uHE1AmMWFyQsi9BKcCAbU8BbI49lGlDdOjPAcHndBE5f66+g/3UUsUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745593; c=relaxed/simple;
	bh=/CQU+pgB2TsyKM5TEeSk4WJeYgiQiaAeoxcIf4oo4J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rja4HVblwPZJWb3fJ3igHt179b7YLfhkk8UIvw0Ph6yLq9a66DRKBep0ArLxAPDLkKg6wK4zPCF4gZEsCcnxPLwsoq7fOfRa5hLNiRXjEnGFQgOMZGzMjzWZB2PB/NhLjDs8S3jWrRgMa+N6/vaiRBmvOd2gTj3V1ezkBBnWUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d7HeN6U1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hyX8lYPAronULWeVXJ+quZoKMwRITcvWkFrMcTYt3L4=; b=d7HeN6U1qx7JRmLdDoHfTDeEQL
	ozU0H8deFujGarIRqlpaRlA3847cObTumeb/HMHK+k8/3P5fcjDJsMp9wu9n64nfbIcJuiAbkP9ZY
	Hk7toPD+Z11Ss5F/wQ02z12RaXemmkuW6qg4DhvdUb6x+nkNdaN/7K2WmqtYsxjN+Sn2MV/EvS+cI
	fBwkEjVZDl3ivJmXvUHrGJIjH09JbzehGu8bW6m9vVdaNGqddEjVz7cppfLo1aSltyXoK2uFGWFZG
	FeA7T2B4wJHkCzqEPnYCUsYXMpS+z7qHtU8KAIyGj6KEIwyo8VrTqlfIEH4RyJnq7eAiw2X+OHiSS
	LxY5lnLw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uovd9-0000000Fayb-3xBh;
	Thu, 21 Aug 2025 03:06:23 +0000
Message-ID: <0254008f-1cdf-480f-ad6f-8f002b35d754@infradead.org>
Date: Wed, 20 Aug 2025 20:06:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] docs: gpu: amdgpu: Fix spelling in amdgpu
 documentation
To: Rakuram Eswaran <rakuram.e96@gmail.com>, linux-doc@vger.kernel.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 corbet@lwn.net
Cc: tzimmermann@suse.de, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, simona@ffwll.ch, siqueira@igalia.com,
 harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
References: <20250821025957.22546-1-rakuram.e96@gmail.com>
 <20250821025957.22546-2-rakuram.e96@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250821025957.22546-2-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/25 7:59 PM, Rakuram Eswaran wrote:
> Fixed following typos reported by Codespell
> 
> 1. propogated ==> propagated
>    aperatures ==> apertures
> In Documentation/gpu/amdgpu/debugfs.rst
> 
> 2. parition ==> partition
> In Documentation/gpu/amdgpu/process-isolation.rst
> 
> 3. conections ==> connections
> In Documentation/gpu/amdgpu/display/programming-model-dcn.rst
> 
> In addition to above,
> Fixed wrong bit-partition naming in gpu/amdgpu/process-isolation.rst
> from "fourth" partition to "third" partition.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/gpu/amdgpu/debugfs.rst                       | 4 ++--
>  Documentation/gpu/amdgpu/display/programming-model-dcn.rst | 2 +-
>  Documentation/gpu/amdgpu/process-isolation.rst             | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)


-- 
~Randy

