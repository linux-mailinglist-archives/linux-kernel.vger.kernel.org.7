Return-Path: <linux-kernel+bounces-773406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5A1B29F64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A035E32CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65992765E2;
	Mon, 18 Aug 2025 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=robert.mader@collabora.com header.b="QJp2CnbI"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055B2C237E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514007; cv=pass; b=egQvEPtBrt3k1e3voRMErkpvvpnBvvmpgPJ5Ul1utvXNkrsozRYHostGNeyIy4JtvRKjfnHbocHl3UgkRs3LbiDxVej0CeGcgrCHmmSky9Jxr7CVFIgMVn5N1E6rnqwYcYELqsc5Y7rB4D6zWO8yJ0AF7Tn6OeK1taAnSyl+gLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514007; c=relaxed/simple;
	bh=/VeW0RXcRKUYy+v+z3ekJxZVEZypLrZ0kP3OmgPL/go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itQ48jBFcRU89870Dfk/+eRTYpYztIacHt55gw6bUBvmyBs2nq1f4DTNsR/1Y6c5+gSmSmEtlnrXH+LT0MyGmfLqKOVqDA+yoF9P4wY5jodVWnGHFwFyGNI7mlVcDFUcJqGYJipYL+nrI02PsBCuquuSRFraHKuwmFY0r9rEJ7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=robert.mader@collabora.com header.b=QJp2CnbI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755513981; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PlznDCCrOlM59ksPQyKCE9h0d+dO2h+b1h4VFT9ZYheRIN+IY6yFNtqS8OWPr+h0LBszhzCCFVib8sJpcwRd+l5iuMLTWy0tB7Tztl8nNA0oapHPJkD7LtWlqYSGUGbEqze7CkoXmzpdkNDVYtGMBcMxvc78cHpy2T6UDMLeNx4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755513981; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WHp4XJVWTvvmWcmkaQmduWnck0pIloPgQPEiSVQzdBk=; 
	b=SiZyZ19q28va3f4VqkqOBDoraxl26yYlTEGhJPZSVvbFsrHR/6nx6EbATnY/RyOMOBsFGSPXA67O2nDMzT1u2M275w6AQcvT1qvbZdMIT8FJEc/ZrHPTteLMxG1xR2YDLTdaXUVuvSS1HLwKnq8WvVi+uc0Wklx5rJepenBHn30=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=robert.mader@collabora.com;
	dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755513981;
	s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WHp4XJVWTvvmWcmkaQmduWnck0pIloPgQPEiSVQzdBk=;
	b=QJp2CnbI7SwIJAc65GAmBXfw5fJrlxZJYn3qpTKlQwrsGZ+hwqTdSYSL+Q+Dcqns
	8+t6vHnKHROSqhUDoea+o91nF/982osi5GafrV3mIQvELjxgCnA/udCZg1ZN6ro1HEo
	cb6wEfBS1+wiDvcdFb1IOkIYwaJzs5qppwYJ1x0s=
Received: by mx.zohomail.com with SMTPS id 175551397875259.006396646258395;
	Mon, 18 Aug 2025 03:46:18 -0700 (PDT)
Message-ID: <26f31ab8-1b9f-466e-aa9e-2b76bec7a364@collabora.com>
Date: Mon, 18 Aug 2025 12:46:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm: vc4: Add support for additional 10/12/16bit
 YUV plane formats
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250807-drm-vc4-extra-formats-v2-0-fadc93844551@raspberrypi.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20250807-drm-vc4-extra-formats-v2-0-fadc93844551@raspberrypi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.08.25 15:28, Dave Stevenson wrote:
> We'd been asked if the S01x YUV formats could be supported on Pi5 as some
> software codecs produce them.
> The answer was yes, so this patch adds them and the P01x formats.

I tested this with the Gstreamer MR from 1 and can confirm that the 
formats P010, P012, P016, S010 and S012 work as expected.

Unfortunately S016 is not supported by Gstreamer yet - however chances 
seem high that it works as well.

Thus the series is:

Tested-by: Robert Mader <robert.mader@collabora.com>

1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8540

>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
> Changes in v2:
> - Swapped from adding an extra bool hvs6_only to having a min_gen for
>    each format (suggested by Maíra)
> - Link to v1: https://lore.kernel.org/r/20250724-drm-vc4-extra-formats-v1-1-67fa80597fad@raspberrypi.com
>
> ---
> Dave Stevenson (2):
>        drm/vc4: plane: Flag formats as having a minimum generation
>        drm/vc4: plane: Add support for P01[026] and S01[026] formats
>
>   drivers/gpu/drm/vc4/vc4_plane.c | 56 +++++++++++++++++++++++++++++++++++------
>   drivers/gpu/drm/vc4/vc4_regs.h  |  9 +++++++
>   2 files changed, 58 insertions(+), 7 deletions(-)
> ---
> base-commit: d2b48f2b30f25997a1ae1ad0cefac68c25f8c330
> change-id: 20250724-drm-vc4-extra-formats-1f53e6491cc1
>
> Best regards,

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718


