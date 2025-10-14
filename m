Return-Path: <linux-kernel+bounces-853314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C749BDB3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 502974F8485
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7A43064B5;
	Tue, 14 Oct 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+bN7zMd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43629306489
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473336; cv=none; b=kNEDyg4eoHoQjNM6V9ayiDBbPPd1bucap8jzZX00Ihyjgg9KXo7ErHsde2ob8GbJ9UR+NIU8N2bq1Wh8jCTAZfPutpRESqE3prniKi7S0LP5m/jlpNetiSEc7DfPm0CwFsrHncs8KtH3dxd8X38UK6MoWLeRQoRKddZgF5QagiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473336; c=relaxed/simple;
	bh=Z9jeuuKa3S8ctBCTdK9cDINmpkoLVy8JGR70/NdDNGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAB/LuO/tVygwj6KuRWdjw4/pEsbOpfTcovFFhoRBmYBTmH4ZfVxhzu/kSVPrb6pCzwQ3QukNhS96Llxt+w0esltcc8x49xKLNacloRDdtTDrFWTb1FTdpcAKmYGgDF4KnOG2Lw5WiiiH7S7W+2EAdtmEyWJ/20vBoqBVWb56VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+bN7zMd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e44310dbeso6542135e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760473333; x=1761078133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0VN3N169a6sDZYSNbJZEW6EFloVcwzVmWscTgzu42Y=;
        b=R+bN7zMdr9Nk8KDzM4FKqWa8EUrpj8xRoR/QIcJb977eTYjTTlYeB9AzkvVXdXKWSs
         7A5NMyZFcOOaodtJWbQWwMgMraQZUUJh6dMMlPZ/ouxRm1KVJjFS27QZ+RLysvcsDVuT
         SOCkqV2I5Y4WbFCULAJwArG/FDeWTPuKxKs3Q1TZ+eQyBFwjk6sAlzaOZKpy12afHcbd
         pZgDXprkTtg7eyfHDZLTG2nLFvWrPyD+a3SWB8BIlzEEwmkbDg7C/rzFvyIkkD877p2V
         DUFFKzf3/e51BBQgBd+A64/x5u3mblo6+VEGpvumawM5EYUrE9Tx+vXEXJpnkA4TFUP+
         DGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760473333; x=1761078133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0VN3N169a6sDZYSNbJZEW6EFloVcwzVmWscTgzu42Y=;
        b=aBgBHX42aospsti3oJAr8mkOghNbmMrJv9oGB4J3dHFi5idDueZpS21/uTCrPb5FzB
         A2SQN07rFXAcWSahvRWmIaDEXivo66WlP/DhY9Ve1rdfPMYZATITVpGegevDnFkNkKKl
         +IWygZTUsSKtvuBqGyc1UTz6yvoTuG+0zbKwYIAYizkczPRH9T8+GhovRqPtsA/5X+AK
         POUiRkxIj99os7nCMwbcwwk5dgRAfmr4Lds5zrfZ00QMhk/RvGGYEHDRyWV9vijBIV7Z
         eWokvOsNXmcsWNgfAJx1mpAVtc5NI725otFGkF+x0DFJY0tRRVYCc13BLtxE7Z+c3PGI
         uMRw==
X-Forwarded-Encrypted: i=1; AJvYcCUcffgoXe4qbbs4jh0XpSEHWIwz9xaY8z4fW385qv+674VfvavGoWX3EFQBZoGhbXNnItCfeOe3LKeYCO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4KEVUwTZWbjIOKcBq2OLAMhkAWkmIUFcUpszXT0TjAriv4MEi
	O36dMQl4tatiBCEu0TQdvISxmznMe5FfcloEOKOz6CU6959AVhEklQMf
X-Gm-Gg: ASbGnct/fUjbpsABOBoA461NYGaR2K5D6tp1OgUhasmQk/Sg91/F4bntanKqIZNHs89
	cdmNALGaJ9FdGM0j6xGked22OVFGFyCYghYS+8hgotReGw6hyD40iLmnE9DqH2OFV98BHn76oO8
	vMmazv96TdUJ2L2Y4a2Hn0ruMqgNflgPLQy+ArMc18jgcEmJqOSlLenNwSuCOJngAgbCxbO0/js
	0zmin69R3AAKUGTK4zwjyntB/oFQ6HqlK/OsNqqxXK6jFgVf39jV3GKWTsMlynFbaEYJ8x1ch7H
	cETot8ARB5OqqUos+HAmPK+hrXMRkYjntpBfZYXRZ9W/saRKcc866ewJdDSO2mmcluSrxxFtdke
	GZOjMxEjBsCnnTLbe46hjAufaHJeg2y6m4CnNf1LP6vup
X-Google-Smtp-Source: AGHT+IEdTUKZQtk/f0LoaN0UjqFL8Av/IcntDztf41Mt6QHFX5yxGqO8F8kgqmQCURbbAmUt6ZVOUQ==
X-Received: by 2002:a05:600c:b96:b0:46e:32d8:3f4f with SMTP id 5b1f17b1804b1-470fca8c732mr1948035e9.8.1760473333487;
        Tue, 14 Oct 2025 13:22:13 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:eb00:dc9d:6aef:3136:d6c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0061sm25331568f8f.30.2025.10.14.13.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:22:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:22:10 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: add myself as maintainer for b53
Message-ID: <20251014202210.wihb2hclgqzpfseb@skbuf>
References: <20251013180347.133246-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013180347.133246-1-jonas.gorski@gmail.com>

On Mon, Oct 13, 2025 at 08:03:47PM +0200, Jonas Gorski wrote:
> I wrote the original OpenWrt driver that Florian used as the base for
> the dsa driver, I might as well take responsibility for it.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

