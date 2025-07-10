Return-Path: <linux-kernel+bounces-726525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9A7B00E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F84647C00
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22731293C75;
	Thu, 10 Jul 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HPIHPs38"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C8291142
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184022; cv=none; b=hnwNF6T4Bb3Vv5DXvgBWg46f2CKVBwWIdCJJQn7gEUJEk6OLyxZwWvCd5ZvCifH0uPovJyGHpBZUft14crTKu/zySHg55MtIzofOeOyJ54DuxSEUbDV0xmddvHebhzOxccIMhwvw1nFZPu1rmqAKr4BzsA2ZgM0JzHJMhFQSZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184022; c=relaxed/simple;
	bh=yMqBrrpcJZvULg5UzIFJ4kHH3VhGJodv+B2HM3LjUns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jT58C+ZoVpjd3ZHIQ7Tbd/7dWPnpeW3bdhcUqL8HqalLxoMv2atL2TtFo0qEFHum8Qvr9sWUui4h/7s4Ru0lZDlV9OtFYyI+aFe4SKIzHATNGSM3TB3ZvhLX/QtiqgMauGhcUBqiBziEPuIApeMC8N3DkKXBRSV7C1IkVuCXYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HPIHPs38; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5keT94UYo+lVgUpH7G2rj3sAusxDAQ2/pkCQOehvr3g=; b=HPIHPs38ujFuAw61nlEgH1XTDD
	L9gB2acmqUVa8/5pX26zrrE7xVdNHuWnEpJTSbd3DlO4FwZNEnO8O1ZKmor/cEOTtz3S3lRTxxx1f
	gFnGOVzE7euwxR3a0SvExYl6KUDT8PKZ+aBydltznrVwzfB/TAyhC8uOL7e3kZBvG/tzLkWG9cJm3
	NhSnOSXVh3qGD6XyPeIhT5pfSSyAKoJ+4Nq0nyAlZjck3VgZ4ZpR79yO1nbu+kJnaw0+SQHVfMSM+
	tOy1q/RDqhowsM/6iNtrq7qpj/0nlmw7lExjchv4tdjQbI1xG4+lz/CRL9LahO5zXN/7R54HtMLW9
	hc5E7cgQ==;
Received: from [179.118.186.174] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uZz6U-00F7G0-P7; Thu, 10 Jul 2025 23:46:54 +0200
Message-ID: <ece437c6-52d2-4857-b9b9-cb73cbc091a0@igalia.com>
Date: Thu, 10 Jul 2025 18:46:51 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix lifetime of struct amdgpu_task_info after
 ring reset
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 Dave Airlie <airlied@gmail.com>
References: <20250704030629.1064397-1-andrealmeid@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250704030629.1064397-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 04/07/2025 00:06, André Almeida escreveu:
> When a ring reset happens, amdgpu calls drm_dev_wedged_event() using
> struct amdgpu_task_info *ti as one of the arguments. After using *ti, a
> call to amdgpu_vm_put_task_info(ti) is required to correctly track its
> lifetime.
> 
> However, it's called from a place that the ring reset path never reaches
> due to a goto after drm_dev_wedged_event() is called. Move
> amdgpu_vm_put_task_info() bellow the exit label to make sure that it's
> called regardless of the code path.
> 
> amdgpu_vm_put_task_info() can only accept a valid address or NULL as
> argument, so initialise *ti to make sure we can call this function if
> *ti isn't used.
> 
> Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
> Reported-by: Dave Airlie <airlied@gmail.com>
> Closes: https://lore.kernel.org/dri-devel/CAPM=9tz0rQP8VZWKWyuF8kUMqRScxqoa6aVdwWw9=5yYxyYQ2Q@mail.gmail.com/
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---

This patch is now merged at drm-misc-next, thanks!


