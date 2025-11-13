Return-Path: <linux-kernel+bounces-899849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F8C58FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA55F362BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41BC363C4E;
	Thu, 13 Nov 2025 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SRXNNkn2"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A043624CC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051984; cv=none; b=dcHKjxYm2dc+AUGV0dzRwbAzN63aRgiYFVb+UgKyA2wP2b1nYWRr93QbfTTkFPzPp07qhFkVHvCNTbjB7q/5AF7vaKJMMDjtWuJCzDMdCIgUc6GepdqFV8rzw0HPrVMAamWiudUp/LIMJYJsCSR1UbtJey+dX4r2hWeL+86SdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051984; c=relaxed/simple;
	bh=k72pYZwFQ2V3zxmVhhX4AUxj4txODChO9HtKLZFMgtw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FvWR4paPfGqqKlP4nn2eaYF4eFyJL9emm+pNy+qqz2O+chc6/7QUqAcMbaUOEYCWz40JVcKygmoFxLL7Vj4UYdJmaDUbvtp5N8i4/LYa0JzthH0BvIs0YzJzhPSyKqFdQx9VR5OMdh76dhHk8ylBAgPfEjliGLACAV/lVZlBuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SRXNNkn2; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-44f7be0adcfso413021b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763051981; x=1763656781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acnorco3r1OWVqxwisFCZtNNuSVKZYX9Y3wyP7m23lo=;
        b=SRXNNkn2B5TjjwiVNkf5ekb6H2aCVQQnTA/BzyfmSMsOvFthwkDx0XB11Wzchdg88p
         xu10GxlGrvMwLe4squ7aumhWsSE62bGUkvVGlEb3W6bWKH//3DZd1s6fPswKqy3rkynD
         Ho03AgV94CTpMVcXpyY+MTncNh0c6eK5DZEY9Er+Jr/6PwsRC3PmhwSGpCVTHhRmiuO+
         5tFWGqNMStG+dwx+ONiMXYlrOyTzJurIWgtCsmmORQQDsnh5iVsmTd61kf13lj4rTrZi
         yvN8CEHdP015IpHmrMmG/ZeBPcipbBsg3ZBU8wljo3y9Q49s6JSc6GngUocc37sPfwzM
         kAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051981; x=1763656781;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acnorco3r1OWVqxwisFCZtNNuSVKZYX9Y3wyP7m23lo=;
        b=rsCcxamSDI2OpBViY19o3UwMWTQ/F/DslvhSJnv4IGhJJCgUn8cm/rtdoMzpeqrXy3
         cWrhTPo6Rv/kFg2pvdjpsDsy20GrIzjSrZHtnIFCCWvQCj7VbN8eDLWCHk9rsnCFbz+/
         DpoqK6hsKjHvpXnq+t6ANkLGBZGLHRgm+gXOCG5angqkGwGMy4P6VZJ+1W1nzB4X4WqW
         UUDc7fCtEIFiGOoxnqhjyBH6G4OOKgt/lWN0fGPOl7U3L5zKPEUmUdihs3vbOgIYH9GV
         bAtOovJVJeiu0gW60/Upr5/Qfo3tUQ0lKZmYXBCOM050X36wfGOKrSMXUot2aUaQqARM
         yMfg==
X-Forwarded-Encrypted: i=1; AJvYcCVGiK2CmMrjSQhmx8M1nrtSQ//g4LLYi3iYPlymgeBc9bCl9i3nQ9hZYevoroeSvsSR07y2vT5xNYsZU8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUAAZbq57TVBlw94k/ie2mvg8CiZVDqNYd5bG8jPnckMDpkFz8
	TV64imbYnEoJ4i5JRE9qF2ud6N2NTLSp8/6bQ+EML/t5NPmToHBrXksj7xks/RqFbuavuBSo00w
	6BvRr
X-Gm-Gg: ASbGnct1dXruOpDhOT1mmFR0jLXf/UtX1Ol4tQ9iTP1w9yrfl0KHB2sj8wdEORrJVW/
	dIuGDWa/K3yB6n5jsxsrRHWswHWc+kd2TsJUAXcGaltus3WBtjohkcH5zjV3EtUKweNulxGQ6f+
	PW0nbLUikgbOcATm/sHhrKvV00Q8PqKA4/HPIGXnZj9ft97Ax6MJgJY/uGx/QyZYgk5iX0E/ld3
	E7iS41ypIQB3qlIg0L6S8vJTfxvxZqjVWL5m1VG3CUk6856HweMMGtDBJFkZJzPXJroOnSYHf/+
	mzr2bF1r+jpzWl+PcdAYNDF7Dv7lpk5qD8rXGXIH1ke9AaDNo1+IZa9qQHHcLeFkVvDfDKveVH4
	vHbJRdsLsdIwedhm7k+FgF27L0SySxsHCEV+9WihrsSiFvCPg5xDTwPX+vg+PyfZxxGE=
X-Google-Smtp-Source: AGHT+IEN9Kca9UVNMkaDQH4sixh1UDXbVuoaQZrNLuxjjpOlBG92d5Tw7nSUHhmYRwVQ4lVJgFmtdw==
X-Received: by 2002:a05:6808:d52:b0:44f:e931:38ab with SMTP id 5614622812f47-4507454af73mr2995413b6e.43.1763051981315;
        Thu, 13 Nov 2025 08:39:41 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd35c5f4sm852672173.61.2025.11.13.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:39:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org
In-Reply-To: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for
 P2P DMA
Message-Id: <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
Date: Thu, 13 Nov 2025 09:39:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
> Changelog:
> v4:
>  * Changed double "if" to be "else if".
>  * Added missed PCI_P2PDMA_MAP_NONE case.
> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>  * Removed REQ_P2PDMA flag from block layer.
>  * Simplified map_phys conversion patch.
> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>  * Added Chirstoph's Reviewed-by tag for first patch.
>  * Squashed patches
>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>  * Reordered patches.
>  * Dropped patch which tried to unify unmap flow.
>  * Set MMIO flag separately for data and integrity payloads.
> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
> 
> [...]

Applied, thanks!

[1/2] nvme-pci: migrate to dma_map_phys instead of map_page
      commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
[2/2] block-dma: properly take MMIO path
      commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb

Best regards,
-- 
Jens Axboe




