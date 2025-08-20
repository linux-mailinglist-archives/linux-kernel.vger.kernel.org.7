Return-Path: <linux-kernel+bounces-777502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6894B2DA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0165721362
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4BB2E2F18;
	Wed, 20 Aug 2025 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="K6eVh+nW"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B71A08A3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686480; cv=pass; b=MoX6ChRiK29O1rtK7M7YQPlqo1HTw8SDI5S+Ba2hhXXs12fNRTb7GI2sBiWUcCDSJFFHAmYSUTxeNcUCLLevNRIrFI9wp2fcpd01zFvEuxY1FavoJn1OC2e6iBFmLRcCFiFmk2eFPwfE3osz41HnV//k5OE/LyMfDQctiuc/ous=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686480; c=relaxed/simple;
	bh=xPpBRwaQQGl/B024YCPt11Pwq77b3ButnwaiZ/ZvwZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqbASHA+AFnws2QR1p5GAAI7/rAh2j5vdQF9P2YnQ56l3U9W0sUN9ucmWDqGNV3jFwApaigQc67rzXRDgllj9yy1T3qS/Vir6FH1LFuxttlVTerDbZGpMqFme4IL8zoQExlzPgYdgOzKO7Y4MT/d0pDoZk8hUI900HCQbVhmCfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=K6eVh+nW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755686466; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mg8kez02dL0yr3cLTAPqma6DgrEOk7l3g5c8GTrBunmhbp+Vhg2BwIcFIcP1dtGLPleFnCS3w8STqhopvOlZjEmBDgz2mBFpjguvBb+IivVHJuRKpM0HCrsP+KprdEcEzM9ySOu/gYoEGLYVqrBR2CwnATyjyfy+RPQNszQIITA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755686466; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wYJMM9MtjnvFHsKajzTRCpet/Cte+2iHoWrfocRvt20=; 
	b=DmtHs5TvlsH87TX4XTHU6SF8eQJAEGTpXshRE019PKAhN+2TlE1buiaVtlItHeRPJ2xOT7HfLRqWgjdj9gc3O5+2CIQ/hbyjD63zqFomfnj39nEntxL1Qf3qIsedjfaUKSuNsE1bTbLFnUiJ5XVmF7T0B2+HorDows428FzUgM0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755686466;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wYJMM9MtjnvFHsKajzTRCpet/Cte+2iHoWrfocRvt20=;
	b=K6eVh+nW75B6Eo3fefA+ub1yyDhFJhhUgg8fCu2RJy/QRkQbVvyFCCr+UWzPhoci
	UHBV2rZv8ts9jwCCahUFKN0OMVtzHGfGlajZ8uCM+1VmEyaPW50udTTZLn13qMwoi/3
	mTswNnuGuHaodRfQgMAJV+gyEpIKTHhgDflqdKhw=
Received: by mx.zohomail.com with SMTPS id 1755686464645877.8597452911921;
	Wed, 20 Aug 2025 03:41:04 -0700 (PDT)
Message-ID: <39b17698-a1ce-452d-ada5-5c3741e888b2@collabora.com>
Date: Wed, 20 Aug 2025 13:41:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: clean up minor codestyle issues
To: Athul Raj Kollareth <krathul3152@gmail.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250813062109.5326-1-krathul3152@gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250813062109.5326-1-krathul3152@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/13/25 09:21, Athul Raj Kollareth wrote:
> Fix codestyle warnings and errors generated by CHECKPATCH in virtio
> source files.
> 
> Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c |  3 +--
>  drivers/gpu/drm/virtio/virtgpu_kms.c     | 20 ++++++++++----------
>  drivers/gpu/drm/virtio/virtgpu_object.c  |  4 ++--
>  drivers/gpu/drm/virtio/virtgpu_plane.c   |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_vq.c      |  2 ++
>  5 files changed, 16 insertions(+), 15 deletions(-)

Applied to misc-next, thanks.

-- 
Best regards,
Dmitry

