Return-Path: <linux-kernel+bounces-888254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43664C3A4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAABC1890CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD82D12EA;
	Thu,  6 Nov 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CXrRldHz"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A42248B4;
	Thu,  6 Nov 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425428; cv=none; b=XthgQE5s39JGEA9YNKpW60Vn5fpMVUncb5ubeiY5+s4PtFBFqSRdZ8s2KSFptpgaKGSVD2y+vl4gTGfsqyHCx+H7Uo1M/5Esppea2hLSWsdZJgtqEtLmzoMb2+SzA3To/sOnFnXKeZcTkRoxIk6KB6crqFTNZBDj5hCyBp5PcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425428; c=relaxed/simple;
	bh=20Ztg0pBIhkboflVDVDovc2zmwdVs7KkRzUuxXrl+A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clL9X/FLaujtok3fD+lNbZos1lRvA5q+HgKHs/UkYfwbzCyffrJZjXyCNCnffeMiHBQZb7h6YPbw+WHPd+/WTItLuH57+GnuEBofgaZt6HkrG2w4RUBZrC1TlOqsFiIe0WlFt0aefdn9HQt47IVskKupRKr5OF+WRm+QNO8LT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CXrRldHz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bEuFMZU9bCseKJUmKXXTmopgNcHGhPkfj40VJHEZmu0=; b=CXrRldHz+7naP6aWLf/T8r9orn
	ZRfXCU913tKkLTtcN9CHWL73Sd9aq4SUDvfzVgTRSX4ghMbopitbHeXQk/EUZhFK5lQM6QtwdtB0r
	oAv7/0L5cOSTfTX5MzGzlLFXy9GvjyGSkCHhd8MzPOZ5K9Dr5T3mDt9GH4opTl6TaIIcmzAj5Vg89
	kIDACHwVrdprWydLpVbGRMxygsmkh6I8q5+nJSyeSaaaPI0740p/6W8M1WNMKIKwI0HzIkVDUur7s
	/aQ08UmQV8qpPTiNv/mT+dGE056NB/HmWXx3ZpqCQ0tDc1xgHuofWyQbn8/fbjnOwaBB1cEcy4FuZ
	+7UHOCuQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vGxMQ-002wIL-O4; Thu, 06 Nov 2025 11:36:58 +0100
Message-ID: <5180cfc6-1bb0-4447-a399-ec039003f229@igalia.com>
Date: Thu, 6 Nov 2025 10:36:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix @alloc_flags description
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Linux Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Zack Rusin <zack.rusin@broadcom.com>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20251106005217.14026-1-bagasdotme@gmail.com>
 <f935574c-67d1-4a7c-bd8e-e9dff7aa97ea@igalia.com>
 <aQx5aAR3DjengjVt@archie.me>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <aQx5aAR3DjengjVt@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/11/2025 10:33, Bagas Sanjaya wrote:
> On Thu, Nov 06, 2025 at 08:28:15AM +0000, Tvrtko Ursulin wrote:
>> I assume no one merged it yet to any branch so I can push it to
>> drm-misc-next?
> 
> Of course!

Pushed, thanks again for fixing it!

Regards,

Tvrtko




