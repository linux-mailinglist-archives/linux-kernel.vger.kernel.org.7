Return-Path: <linux-kernel+bounces-752267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A66BB17354
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DA31C23F02
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C319E97A;
	Thu, 31 Jul 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="Y1EMWTBs"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D3639
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972829; cv=pass; b=SoUN5dPAyTDF5cv46EyuBTug8k31hDl/z++VjCWEHP3ny0XQ3ywi0vk+iYGp6gNKJExP08UPYDVnbWUxH53iXhfRtF5FasFdMPUhbVg9M78c/Jbp8w/PsWi6moHXbRCvaEsid7OT0f1kY/plxr2AJ9gLotin1dzjZMcP6v2q/14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972829; c=relaxed/simple;
	bh=efSJvhMwZRyvDeNpi6g7+/OQmL3XiLYyKZdY9AZH9EI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SQVV1iLIR4++S24vLJXjIsquFA1KqZwL3n5bNVRHNiwK+FfZrqvZeAY0FR213cRidtoabIJmONjpGbuYt3BM6pFeiPDGVAGNhy2JAor2gnwU2e+Z9s4uZGDlL/I10WG4bpm212bNwjlZqmEb6nAQMw0WnPWKvsupKGt22UlxqNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=Y1EMWTBs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753972800; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mpgJedjTTbKA5zTw9s5O8anV3TF8edFtigNFYw7bLZIcF7epHAqNW3Ou1fPDpZTJE1Y7tz6gIvlrWoZ+apgkSTtFb03uuGIxSEdxb6ee7zrjr+tWX/OzHJLI3V+Xqlgp/WH0DePZ1O845j8Lqj3O5Es4biS9iAD1TN+3Lb+DKPE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753972800; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=efSJvhMwZRyvDeNpi6g7+/OQmL3XiLYyKZdY9AZH9EI=; 
	b=JnB246F//Tu9LBJ8wgseKmaEzdBAt5VNI7EMg6+M6AZbTPm7aKvLWlTODcodP3I3O8U6xTUVmRETsEcGLw0HCONXOX42/9IfRij+YhcSAFlrUQ3R01SglfdPqZ+e4OOmm5f8CPKqtmVmfn0+zHXtW1hx/AyIaHWDX4OBWou85ic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753972800;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=efSJvhMwZRyvDeNpi6g7+/OQmL3XiLYyKZdY9AZH9EI=;
	b=Y1EMWTBslOFJE8bVyp7taVBn1/QJCHSdh1ahaR7RSv7gGM6O3jouhKwEk4Ruiyhc
	0cddASAegxd0fCG7g2KFwbnBHZXozSJs47A6f8UCA1SYtVhSK+0ypbOtg7lru8F5Ynx
	zDIt5OqK959IS7CdKlpSVmfDa3nAS02MPZ94CTb8=
Received: by mx.zohomail.com with SMTPS id 175397279748996.20746436485967;
	Thu, 31 Jul 2025 07:39:57 -0700 (PDT)
Message-ID: <31a60d0d-5cb4-46f5-afc4-a9e8aba8dead@collabora.com>
Date: Thu, 31 Jul 2025 16:39:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: karunika.choo@arm.com
Cc: airlied@gmail.com, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 nd@arm.com, simona@ffwll.ch, steven.price@arm.com, tzimmermann@suse.de
References: <20250724092600.3225493-1-karunika.choo@arm.com>
Subject: Re: [PATCH v7 0/6] Add support for new Mali GPUs
Content-Language: en-US
From: Mary Guillemard <mary.guillemard@collabora.com>
In-Reply-To: <20250724092600.3225493-1-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Series tested and passing VKCTS on G925-Immortalis.

Tested-by: Mary Guillemard <mary.guillemard@collabora.com>


