Return-Path: <linux-kernel+bounces-808342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B355B4FE81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7241B2461C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA3192B66;
	Tue,  9 Sep 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2oVwkHmm"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E2223337
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426437; cv=none; b=cVm0SQEETVyI2cRRWHIZgabigNKrshTyYPa5tH5cR62OS5ts5PJt8nlPZPiEbYw2bmwR5IzErleC7VEeSqjF465uQm5GPyPLNh8dlz9aAOwd5Q5XEUiADB+RvNqzide7GT9eVXoEx1ORvAIhCI28u5h39QsT+89pjf7O4wuRyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426437; c=relaxed/simple;
	bh=qROYeN7WGw8V62D9PfuxHYH4hedFRscRGSqWPNs5qMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQgupRmBmCKF4NeMaQBbItPKDJP07xse31fiMnmn1zbBjOKD3Gv9hxR0WqWsDun72r0mxffr3qKuulBKSAL5RaFgCJCEIDcZPW3mWT+ftmlLrwBHHmPLM/FCoaFbjQu5BYlhxnRC5smK+CAHuLUvWHUcKnvmlG55Ab3cHkPYKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2oVwkHmm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 00BE41A09D3;
	Tue,  9 Sep 2025 14:00:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBB2060630;
	Tue,  9 Sep 2025 14:00:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43F53102F2869;
	Tue,  9 Sep 2025 15:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757426430; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zkJmRVq9X8+VfiFiVFtH9/Lec29ID9JWmA+hQsicr58=;
	b=2oVwkHmmv7BPojJAfKrt3kpqZHFkobdQn8anhwZSjXXexsdPrYY0mb7Qd7mBXNP0+Hapf3
	yhbr01kdvGhPUnJVydECZxvOjMOZ22EB4oGlROtG5GDizZqbxlInomoz4VDLblZH6Jo6MJ
	uf/J94TIXU28ydjh7K+23kOyqAvPQbkiXWGLNb4N5BJCQvKks4eqfqP+WILRUICQqn8DFn
	UPAtrrFT9hJ91MV6PcuvB9rq3+w/L/dlYv8eElWnKfYRwjxhRhIMM9uh60Ehhiz9mxrkm6
	DIR6A29G2WyJddjlr9Y/P/Xe1TdaqXIpUVpCeZ8iACM02lGh/cYbz1sFzv+iVA==
Date: Tue, 9 Sep 2025 15:59:50 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Qi Xi <xiqi2@huawei.com>
Cc: <bobo.shaobowang@huawei.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <lumag@kernel.org>, <dianders@chromium.org>,
 <lyude@redhat.com>, <andy.yan@rock-chips.com>, <viro@zeniv.linux.org.uk>,
 <mordan@ispras.ru>, <amishin@t-argos.ru>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on
 error path
Message-ID: <20250909155950.0e15ec6c@booty>
In-Reply-To: <20250904034447.665427-1-xiqi2@huawei.com>
References: <20250904034447.665427-1-xiqi2@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Qi Xi,

On Thu, 4 Sep 2025 11:44:47 +0800
Qi Xi <xiqi2@huawei.com> wrote:

> Add missing mutex unlock before returning from the error path in
> cdns_mhdp_atomic_enable().
> 
> Fixes: 935a92a1c400 ("drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qi Xi <xiqi2@huawei.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

