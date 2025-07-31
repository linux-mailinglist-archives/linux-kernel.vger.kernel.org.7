Return-Path: <linux-kernel+bounces-752264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF2B1734F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2991616FC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0619CD0B;
	Thu, 31 Jul 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="jAbMVuG3"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E51189B80
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972552; cv=pass; b=Zeo+NSu2dp3/EfswFdXktAOZeL/zoIlcg4mslAlVfBpXOyD/88fbub8z/iLry9xmfE3dBNH/rq1IypV2mF5Jw+eyIQX1jW+SnbPTFRkjYvMnR2eaI0q2YYzCXO7iYQjmNoTutbeVvw96AWbxRgqnWBBzac2UgdNI3Ofu1W4Q71A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972552; c=relaxed/simple;
	bh=rKcAcr2DwC7zTd6PfcPIGNAWLmYsXKMR8BuUiIJfbTg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MGOQNWbYJxo9EZHDGh8AXdVhXcd5461puIrDTYvP94nyxcFLGWRxbpla5jIgXNacKr6QVeIYcdNuJrKH/OYYIbVEaweuJrm0S+m3KLIVmeSIhINyZdZXCathbqWpptw0xkm0b7UTcHtbRRR2Vjhcfh/IDcuP4ylWktdujrWbLhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=jAbMVuG3; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753972537; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cwVndOAnBquabL2/M1yBGYfepdBwW+X4OctQEiIvtWZLbTuSn3VeYSy6kQITRM8zNp9m9nymXMidH+jgujEKUu+8DNI96ZNWLn48LLz7qP5tM4zJEoNDVF0dAjfiAWw/p/dRCKlpyGNF62IKwpySVnoNo7uDNBpxHHcb+enyKv4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753972537; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rKcAcr2DwC7zTd6PfcPIGNAWLmYsXKMR8BuUiIJfbTg=; 
	b=Tayiukse9FS1xYP31XxyC/YnuDA4kA00IZ9y4wodzvw8dc77+53EO2riFeh0s0eWRENClpriY34IoTv/h299j639eZc+Dh1yfTYR0hrA0QZ7xBxG36y8/7CBl2g20qlPyYe1RQHw9uLq9yXlOWW1OyEKT8YpUai/GX2Jq+pmFmM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753972537;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rKcAcr2DwC7zTd6PfcPIGNAWLmYsXKMR8BuUiIJfbTg=;
	b=jAbMVuG3sknuTodVk0cimWo79+TEk7/kCj1JHHo6Qc72H6gWZOLVqnpm3vxepSZR
	U1KJvCUGeOnbEKwc8V4DWnhdH5V7ASYfjZS97KUP5OveOVIJuQr8OQe42izDuN1ZLX9
	okvQdwTml+ne95k6AEqZfVYH+t+KRkQG5+MvTDPo=
Received: by mx.zohomail.com with SMTPS id 1753972535514926.5704440251537;
	Thu, 31 Jul 2025 07:35:35 -0700 (PDT)
Message-ID: <783cfede-8b79-49c7-bf7c-fa3a67cc0f56@collabora.com>
Date: Thu, 31 Jul 2025 16:35:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: karunika.choo@arm.com
Cc: airlied@gmail.com, boris.brezillon@collabora.com, dennis.tsiang@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 nd@arm.com, simona@ffwll.ch, steven.price@arm.com, tzimmermann@suse.de
References: <20250730174338.1650212-1-karunika.choo@arm.com>
Subject: Re: [PATCH v1] drm/panthor: Serialize GPU cache flush operations
Content-Language: en-US
From: Mary Guillemard <mary.guillemard@collabora.com>
In-Reply-To: <20250730174338.1650212-1-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Tested and passing VKCTS on G925-Immortalis.

Tested-by: Mary Guillemard <mary.guillemard@collabora.com>


