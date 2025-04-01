Return-Path: <linux-kernel+bounces-584098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091BA78341
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 22:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84583188F939
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E720E70D;
	Tue,  1 Apr 2025 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="DLsPkpwo"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3E1E1C29
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539096; cv=pass; b=gzt8Bo67smAVxQzkwhhtvMcQI9/Sr8BbGR3I7RUupaU1Z94IZ3/3a1VN2MapPnGREJ+LQjWxgc5cytXZSWU19O3HSn4Hhkoo4sA6Sd8gBKiTZxadaJCkLp1mmu6XKga7hl6egDJzYe0Kk4GM4pTdl8Tz3pqAYTpqa5ozXrOrdss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539096; c=relaxed/simple;
	bh=kkWavh5PNiM0ciEo9kqPCh2u3LTLA00fSnlFs7BiHa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVLpMESK5vz8PAxUtTKshR++9IrUnQR6yn1Hz6IxmxtFgczi2u4CPPazeOb30rzvjiAlkQl7yMNZcpQQROvllyfqtKZs54IXTPftzV8LBPPV7acRzpQv5E7GLOsy6xRgK69YaUbRYqQaJop/F7rnTj234RlffvTUoIdZ0u435Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=DLsPkpwo; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743539065; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nVudeP4HRTu5n6x8T1kjhZ9lFBAIcFkeUZcWcCRlPbxbnQwC44HjoJ2asVO+njogrhAFBWiuZVQ5q9evu+ZaeTkU9+Mk+vTDEummX+QsAoM2d1qzu0VbO/Q0sO48BVqZ0retUsOWynmdIA5Lc8RU+yhy9frEtgpxphI3konFD4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743539065; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J2P0Ic2aVRrBbXcHSHgdkSjSn8amYT/Pw5QVusBb3qg=; 
	b=LErVpSmuRttut35FgdqocVT5vRgDLwUKSWE4KmuOgyaxb5oHaWs9he+PKPx78BupcY3fL018xcdIc/jFlJUHgkokVyrn+I0qTuL+SEQ38HdAQU75jRU6bR4I+SDY55QTgGqBTB/6XHvHvmM19No6HG01MffP8/e0kfeS2h3TR6U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743539065;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=J2P0Ic2aVRrBbXcHSHgdkSjSn8amYT/Pw5QVusBb3qg=;
	b=DLsPkpwokYbjjdPkgRazsC4bS0DE+Pactxb2YADSstoQSoQ5IkLowZ7ZSO/JjfrS
	G6JO2PvIRNeC8/rYdant2Smbnx3DAdVNbsbps6GDxAYKNjnE8T3T1Espu79HW8s0aJj
	HKPmI1zK63Uq36+eK+i8OaRF/H5xlWjDpmJ51EFE=
Received: by mx.zohomail.com with SMTPS id 174353906464838.705516079159906;
	Tue, 1 Apr 2025 13:24:24 -0700 (PDT)
Message-ID: <0f16673f-9758-4790-ae6c-e81150241ba2@collabora.com>
Date: Tue, 1 Apr 2025 23:24:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/virtio: Don't attach GEM to a non-created
 context in gem_object_open()
To: Rob Clark <robdclark@gmail.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20250401123842.2232205-1-dmitry.osipenko@collabora.com>
 <CAF6AEGu8XZktM9Y0t=KEF68uGLz7D_+9H1GnAPnZqc1YsT8iGA@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAF6AEGu8XZktM9Y0t=KEF68uGLz7D_+9H1GnAPnZqc1YsT8iGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/1/25 22:53, Rob Clark wrote:
> On Tue, Apr 1, 2025 at 5:39 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> The vfpriv->ctx_id is always initialized to a non-zero value. Check whether
>> context was created before attaching GEM to this context ID. This left
>> unnoticed previously because host silently skips attachment if context
>> doesn't exist, still we shouldn't do that for consistency.
>>
>> Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default param if context_init is supported")
>> Cc: <stable@vger.kernel.org> # v6.14+
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Reviewed-by: Rob Clark <robdclark@gmail.com>

Thanks, applied both patches to misc-fixes

-- 
Best regards,
Dmitry

