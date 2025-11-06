Return-Path: <linux-kernel+bounces-887522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39296C386EA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60F064EEDB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E0713B284;
	Thu,  6 Nov 2025 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xlx6srgX"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0A428E5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387295; cv=none; b=Aj764hOCuLTyaFy1zDu7tdjBJSuksCGCD7Hh5jNe3PZA9P5kA2uE7/nSTTYE3gVc0TqKDynDLJv3OAKsb7gKciczXcv6lyQrNvv99p2T+8ut+tnqeqxZlAhI6YXNRQ/OZVg3b75CFbj5L1xhoozK2DxY+DKbrs1fWhIqddHaPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387295; c=relaxed/simple;
	bh=IJpNmGCqomd5vPrThOxk8bXJzEiTqgNJywW3jA2ng9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbmN3Ams5oa9OtlDfNpqvnRAIpP78b1z88BQyceo58IGdKlz3IAbpwkBH6swc/9P9aHU7kspNSOB1E6W8XC0/MQXBaHZw+gIhBUtN3jccWsolgA4Rmt0smSLnKSAiKdp2oB7iP+tko3mpqzidMvbdZoS93drVTeFTadAiQ17iYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xlx6srgX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso574565b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762387293; x=1762992093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+j9mh4om2Lo/eeZHz47ynRZd+sYb7QQJYZHiwixfAI=;
        b=Xlx6srgXuyXl3zaJXO294ebhFDLkatxa6OzCbBskjFiCig1oW3QcpIYOUkKy3vpHZP
         tnmdKNizkzKwPya+Gum1/HeijDy1A5PYLQOdQl07PVW2NAhSeLqZXekbhtmPMb1t/lH+
         JU/gDdHw0vnSycFtC1o1U8obwcbEPH0s9s+YcMc+uleL4j1jvwOfB3PA1JU4QR1KtwoR
         3Mc3ejP9wWzTDbeEBxvfbXi9COhylPXJIhv6b5xM69rnqRUKZx5zfxQp83jOTvo7Br3a
         9a6sUICmu5DlzZymeGu8bvgmz85a1rVdaTuhAyDi5OEm/9EkmcfgzO/LfkhwnyykMNHk
         OqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762387293; x=1762992093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+j9mh4om2Lo/eeZHz47ynRZd+sYb7QQJYZHiwixfAI=;
        b=FdtETvw59GyzkfYOajq8gi8fax2VT8J79xs78snkwVYuusXajcGIzlEv/gvF4Nqsb1
         lvCcIU5DqEXlj5zVQlj7b1dhjVQWO+8sV73j9JEsQ2V4pe3TItFNjmYSMm8dnuVLu0MX
         IRJFGj5euWWQXxMicrTMNltiJhUeHY1B/D1sefec/y8NbZH3UgMzwG6z7EQSm+h9C4bl
         b3DMYxXzKThaex7aR7doP+HeIoJ1CqEN6FDhb2k/NTz9Wl36RbJDm0GybraU9qpQcSu3
         9kUp/fC9e2E+Fn6TS9Cf919+MgLXQD5BkovBYhlbVdnSDhaFphBqj+bzqBzgJkffRrkr
         6NDw==
X-Forwarded-Encrypted: i=1; AJvYcCVfvDZ9H85peYlj2DSIQKdzZEgfUpoMmWkxYef36cP/GwOgVeXTo0cTouw1x+spCL5pdJBN31Cv7a3RmA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fBornCH8/iK7uLq76r+2Pm/ZPbWjJd+IRW9Gij4+0+8xqqky
	qor44T3uf9pIKFu9szIrP7sVcJRo0kOK84tJfS6gSgy/G/SBNhml52f39QlSqKmfQQ==
X-Gm-Gg: ASbGncsJqiOev7hOloXweoAsnzd0gaqz5gC0l7Ai28k7casFTpY5kuVYZr179QSMcU2
	ZP/0AyaZTiSlDjNxwqM36kb0UN4eN99/RV/CZCNXhBYXrxji9MuiKd2F3oapvvvAKpoppnPJVwA
	P90TJO5x4EL7jfNcQB4YXH2/X8vJn9HVO6B3ltgtDeSA/NB28xi52Uyrzy9Uql+pOZXQiHW7rmd
	DlgSNsGinoklBFI746jH4ThUsbxXZHlETVf2wXJbzXib8vD3g6fW6I3uQVQ0RTs2K/WZk2DkIyQ
	hiZW7Bo9pwT2FFCKJtMPpk3DShD6U1PpgGW/QeR4/hJWTortj8SAN1xeEaSMwExBlTI9VEFgtC0
	M7yVXhdk+wp25wbJHYNrfOxM22oDqI96f698qpTWchTCt/W3vflLENAzJPF3/PS8mAgdeiMRErK
	fvLOz4xbjmQJAlKVYJQqmuaoHdY6WOYo5i1ZV9YfltX/GWUsLLOS11
X-Google-Smtp-Source: AGHT+IFZn0wKXKfe4nQzbawEz5PMGpfdeosAv1u2jDFwGrH5HD8pmPBonB38N8KxSgxtY7ZfrXxzxg==
X-Received: by 2002:a05:6a00:98f:b0:7ad:1e4:bef0 with SMTP id d2e1a72fcca58-7ae1cd59fe0mr6150438b3a.4.1762387293044;
        Wed, 05 Nov 2025 16:01:33 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af82603dd3sm595170b3a.53.2025.11.05.16.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:01:31 -0800 (PST)
Date: Thu, 6 Nov 2025 00:01:27 +0000
From: David Matlack <dmatlack@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] vfio: selftests: Add helper to set/override a
 vf_token
Message-ID: <aQvlVzljJhKQQ2ji@google.com>
References: <20251104003536.3601931-1-rananta@google.com>
 <20251104003536.3601931-4-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104003536.3601931-4-rananta@google.com>

On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:
> Not only at init, but a vf_token can also be set via the
> VFIO_DEVICE_FEATURE ioctl, by setting the
> VFIO_DEVICE_FEATURE_PCI_VF_TOKEN flag. Add an API to utilize this
> functionality from the test code.

Say what the commit does first. Then add context (e.g.  compare/contrast
to other ways of setting the VF token).

Also please add a sentence about how this will be used in a subsequent
commit, since there are no callers in this commit.

> +void vfio_device_set_vf_token(int fd, const char *vf_token)
> +{
> +	uuid_t token_uuid = {0};
> +
> +	VFIO_ASSERT_NOT_NULL(vf_token, "vf_token is NULL");

nit: The help message here is not needed. It will be very obvious that
vf_token is NULL if this assert fires :)

