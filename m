Return-Path: <linux-kernel+bounces-791842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF56BB3BC96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468947C8773
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1689A31B11F;
	Fri, 29 Aug 2025 13:41:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3082D2ED865;
	Fri, 29 Aug 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756474866; cv=none; b=U751J6CyqylN+RUszUsJavLttJHziF1SsRgx+E8JBOkjq69csPIn9YbLk+8nRbrZER4DQHFUW2g8v5OCAB3DemU5hV/XFOlTtLO0oIl3tlnnnv9YToeaKsXshnNsMmaYHuVq2A/10/FTiRpSS4fw0DBAJkuXD+GIzO44x5BZWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756474866; c=relaxed/simple;
	bh=PTvgbvYm46h9Row2oa+6kFtRNdfQHYUqbqqiQaJEoD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KzfL9FLtvBHXxhyEKvPRCxV++N85mUHF9yiMGVmISU6Bj9BddjawfjRTq8TqzBiXkzqW94wr+UejzT84C59JLzqYjn3deVp0HYkjo1V1ysmXXKvPbKfvQ81JZ5W2TBDpww5K+an/rNtIhwhU4Cjsp7ukjtcPnyZFQyi/hK5c6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 130B415A1;
	Fri, 29 Aug 2025 06:40:56 -0700 (PDT)
Received: from [10.1.29.20] (unknown [10.1.29.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10A813F738;
	Fri, 29 Aug 2025 06:41:00 -0700 (PDT)
Message-ID: <ac4838eb-7613-4642-a007-577a9f665984@arm.com>
Date: Fri, 29 Aug 2025 14:40:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/panthor: add custom ASN hash support
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250828201806.3541261-1-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250828201806.3541261-1-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/08/2025 21:18, Chia-I Wu wrote:
> Some socs such as mt8196 require custom ASN hash.

I don't know the full details of this, but I'm puzzled by the "require"
here.

AIUI the "custom ASN hash support" (or L2C_SLICE_HASH as it was renamed)
affects the efficiency of the L2 caches in the GPU. It basically
determines how addresses are striped over the individual caches.

So (unless there is a specific errata) not setting a custom hash will
work just fine, but the performance might be slightly reduced.

kbase provides both a DT option and a module parameter which can be used
to override the defaults (although the parameter descriptions say "for
testing" which I think is somewhat telling).

How we should describe this somewhat depends on whether this is a
specific workaround for a SoC - in which case Boris's suggestion of
using a different compatible string and panthor_soc_data seems like a
good choice. Or if this is exposed as a general "tuning" parameter, in
which case this might be appropriate.

I believe the tuning is related to more than just a SoC (the external
memory system has an impact). So I guess a DT level knob makes most
sense here.

Steve

> Chia-I Wu (2):
>   dt-bindings: gpu: mali-valhall-csf: add asn-hash
>   drm/panthor: add asn-hash support
> 
>  .../bindings/gpu/arm,mali-valhall-csf.yaml    |  8 ++++++
>  drivers/gpu/drm/panthor/panthor_device.c      | 28 +++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_device.h      |  6 ++++
>  drivers/gpu/drm/panthor/panthor_gpu.c         | 17 +++++++++++
>  drivers/gpu/drm/panthor/panthor_regs.h        |  4 +++
>  5 files changed, 63 insertions(+)
> 


