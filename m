Return-Path: <linux-kernel+bounces-854505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6141FBDE89E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0C904F38FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A61C9DE5;
	Wed, 15 Oct 2025 12:50:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09A1189F20
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532601; cv=none; b=gHbfIwBB+oAAHNGBMQg/t+ejKSSZIKC7Nw7wNBmyOXjwp6tfef/14NP1DYKmOCJGPujRcu1zMP+Qz0GrxFKmw2Ob8Ta+k8fqlKrdFKf32zi1iuE+d/MTgXjehl15C9W4OebcVLcalUJ2gC6tKVXE7yhMcaDG3pP7mKbAnEozKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532601; c=relaxed/simple;
	bh=H78FkbJX1tjshVXmrBEMPHmkaqGMlaCE+LzTFihkExQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSzMvDzhCt1Ot/VGsOD5xjkPlWfhnkPjHnlVTUct1MVKB4L7zef8yamjwK+GSl6nscMJk9c/OIYRgHBkwANMTaH66fBT3YMjk0PmYDuNv7L8+Mgwa9ysNgsQqxP3mOpos+KMuIuqWiO1TZvSLmW7QSLh05OPee1ZNS95TKhcV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 827F4106F;
	Wed, 15 Oct 2025 05:49:49 -0700 (PDT)
Received: from [10.163.67.182] (unknown [10.163.67.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68F7F3F6A8;
	Wed, 15 Oct 2025 05:49:55 -0700 (PDT)
Message-ID: <9c879ef7-b089-4d96-a016-f7a4a550cf9d@arm.com>
Date: Wed, 15 Oct 2025 18:19:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/mm: use <stdbool.h> in page_owner_sort.c
To: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251015093851.109663-1-ye.liu@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251015093851.109663-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 15/10/25 3:08 pm, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> Use standard <stdbool.h> instead of manually defining bool, true and false.
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


