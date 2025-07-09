Return-Path: <linux-kernel+bounces-724037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398B7AFEDCF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC1E1739F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4932E7BAB;
	Wed,  9 Jul 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL2HxXJI"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154422E6D1E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075193; cv=none; b=HFHcxw2pAbTNQQ9F1V/tloHTHNK9Gwra94eMFi278C0jVfJugmfgJo7a+bfz5idgJ5FWqA112IFnt8/NKJrdSJRLlQVgXlIz+JJmdx9pZnOmsZ1GXVNrOL4klIKpB3LQzu8VFdh1n0uZd9RpvJ809b0FlQrvsL7LWyCFp+lPIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075193; c=relaxed/simple;
	bh=zHPVg3osmCYyAy75qyrzcAxb6ctP4hFf1ZVxGGaCGUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBE4Hru0IuCXImFkLeDN1ZRCTCJNaxkEeeKjC/9fMg4bNY20NAtiK4VAj9vM4l23rw5j6eRfH5ZUoA7SWhAVfH9aMZZBl3N6rXhlRj8dWqFOIEDubu7CT9+T6GH8vWL3CsYuqG4oi1nPkZq78p0fWlla9s9m/VHXw7SKjNPqwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PL2HxXJI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7490702fc7cso3566892b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752075191; x=1752679991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5h0vY+8yWR6d53ywzrllmdRVHS+9LkknzDUPnvu0s3A=;
        b=PL2HxXJIxJEzN+b7/u+ZcnRE6tL2KtW6w/YR7zopiz4Mju+H6mITjVAK/WTiZz7czU
         AFJ8wgu/vKOUtKA8HH/9MlCR7JHXpFEFcFC5luouIE+VEg6nbjRV/s9T1HU+4bt9bwVI
         +krDCrgBdoT6w6EHV0BLt8X9fiCYbrEo0PQgfvLGex5jKjd9AzXxsYXCDqCT11GiiQdc
         zhNFDkyKwXq8s8nE1+l87jxgU+NVduyri7IeYa7In5cgxDJzrne6Cl3JkYWdlrAuD1Tl
         wSuLUuoPYhfQ9cV5Bzx/gTAL68T71adiy/3dCN0XUc8AWl7/Zd4fcduEsttW9D0Lm3J1
         aQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075191; x=1752679991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h0vY+8yWR6d53ywzrllmdRVHS+9LkknzDUPnvu0s3A=;
        b=AQSKwMntH6GRqd66V07iabihrMgvviumOAyWlAsdxM/NQon0akDynIUuBaehc7RccQ
         XNnkaMCLH1pPfHfo5TYdcyzjsBJMfnWgsDU9N0q2qR1VPUl/ckzg3PUIvVYD6/Mo7qSY
         wDjA9LSF/6xcUoDSSWXz6k8x95S8nAjNCAb9VZIlVBpvzW3AIyaMeUrP1RIRI3gQlSLE
         Fn+Xn6loeL5pfP2AMA18AoFiWPxd+pxHXOZW+Y6zTLvCjRFtbYz42eeJ3IdgBUz9Pahc
         cJkoioMyPd548mldBD47aEeAmz+ClT1LzL5yaE/f6BhKcJVM+Sq9KWvEWFjElOheiam8
         4RPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1BFQjfb0+xCyKCZuEeaOt2qeLm7Zf+Zo7keD16Gq90ESSewq47sX5niMNqk7xLYLVEjDL+f3ekKXTVR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpphe+Ko0QR+G523Fh8pcV6x7Ja8XBlcDnZIbogk0aH9isa20L
	4ES6DcG6MLA5OICnPo19wY8L3iEkt5CvCbd5GRmqo+MCivW72vCPbZs9+mqugQ==
X-Gm-Gg: ASbGncudX9Bmyk/SvkM49Ll6H0FfQ9oYT88OhHLRGqVRo7hcMjNDx+/U5v1lE9hen3U
	PAOFmicGbnkkvgKzpuupsvy03mbYhGAB9fynN3+Yi41VeQ7cBDVi8FQoSoYQs0eaSgYRvi8zAhd
	WbqnCmfl40lW0vOryKbBP3wHHkQNxnZz07PIkEi2nRj+6lrykvWdVlb7Yw9DcHErvYC78kM/krO
	jYJbAr35MVfiT9rb2DBGw9Sq2B8iUxhBXUA0fjWykjI1n5D3aqlWI9sOs0HwATWNuY5ZI9N5LOJ
	kFkG7wHhyBi5kfAMKrYvJiDROrQByg8ZwiSxbAULb7AXYDVoPdmSeJVAjPhTwA==
X-Google-Smtp-Source: AGHT+IHZtURowHsYjnMJ5BnwtddfQEn1Fb18GjbXaV0krfOX1jJD/FS2hhGkqD/zQ8JNrPNyVELOKg==
X-Received: by 2002:a05:6a00:ccc:b0:74d:247f:faf1 with SMTP id d2e1a72fcca58-74ea645f1b0mr4005899b3a.6.1752075190794;
        Wed, 09 Jul 2025 08:33:10 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62bc54sm14821781a12.59.2025.07.09.08.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:33:10 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:33:08 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ben Horgan <ben.horgan@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org, james.morse@arm.com
Subject: Re: [PATCH v2 2/2] bitfield: Ensure the return values of helper
 functions are checked
Message-ID: <aG6LtJ2N1smBKHh1@yury>
References: <20250709093808.920284-1-ben.horgan@arm.com>
 <20250709093808.920284-3-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709093808.920284-3-ben.horgan@arm.com>

On Wed, Jul 09, 2025 at 10:38:08AM +0100, Ben Horgan wrote:
> As type##_replace_bits() has no side effects it is only useful if its
> return value is checked. Add __must_check to enforce this usage. To have
> the bits replaced in-place typep##_replace_bits() can be used instead.
> 
> Although, type_##_get_bits() and type_##_encode_bits() are harder to misuse
> they are still only useful if the return value is checked. For
> consistency, also add __must_check to these.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Applied.

Thanks,
Yury

