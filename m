Return-Path: <linux-kernel+bounces-830740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E9B9A6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3E13A6F74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289CD30B516;
	Wed, 24 Sep 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk3XV05/"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184CD1F5F6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725752; cv=none; b=g2kbDmZiVZCzyG4Tvp25p6XJhghvezILIgkI8sUrf2VVQciWHrwH88Ibz2ircQcEm+dh+Y6fVNMfpl6MgNjtmcJvZqg35LRKpcJlomSPeEVVxRdKtcbms1AydvTJyEisXZ8GtS2eiBrvYW0tlW2gI9sgjOHOApupjXX69n486OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725752; c=relaxed/simple;
	bh=1bdm4ZwS+vnY4SEljyRMQtCEmwu0wpVnwkmS35goyks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yhyw0CStGbPduZxK0ELA8++Q+5D3chCJ/rAFj4rrqdTUKTaMHnN3tHzh6rn60HGyGFa++nYSgzwy61bwqfVZ/qjOsvAY3v+puSlXTek4BR5+vRgz/ykl0lQiA7d6m3bv5cJKOKUnSuy+H/yj2NUrAI7fNPDDstmlI+cm9o1kE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pk3XV05/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2698d47e776so51209855ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725750; x=1759330550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtg/RW/ZQ2hPIrm+uMAg0L2Wfe97VEQrXZv2YdHCE9I=;
        b=Pk3XV05/0gZsasKG5lxzY1piM6pfZCiNjiSkFyEWgkvMDWWpBOJYPW9R/pZt/5JxuU
         jsCN3GHXD7notX9VVHXVUtUCgNma6nnSZxEaYUTJEYnTeXux5vOxC6nMniBNapo0/rf4
         r529bjHzHQK4FCcgTSPVQ6gf/NfNwdlCc9LdI5XSvetU2gP2NQrVu/j+B/gWImVbG6V7
         yIeT1Wp8ZW9rzXwt7foEfDKq8IHpa4/eghupT+r1nesa+3yThnJVKubA/j+oioE0ODJm
         GqDnI4vtC7bYTBynRMoLLwVsO7IzOKE4aH1bnEYz/XyvSW2FMRBp1FkNOExoVMUh5spI
         mH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725750; x=1759330550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtg/RW/ZQ2hPIrm+uMAg0L2Wfe97VEQrXZv2YdHCE9I=;
        b=clGVsb717qBviKaQ5Ss45BkB25sQovvquqbsSBtcFAi/hlfCWthVizdnDK732mWUeA
         83V9OCmWMHwgz4d5VIIlVb5oXsLs0Ee4Cnc6fVw+3i5Cn2HRc7w88fkA4BxmLYuZBpLu
         XZCIdkmQYLydAQy1rAKMyZXivrp5qL1h2UIKHsmGOgkaBvLUt9KylVZ2z/mrW7z0FQQr
         lGOmoSF047yq+kXyw2nIaPgW/4w9zS9kNo540uEHi5l89jKVwec96C3XZLVSie0GLH9H
         AIGBLp5SEDsyT7IThKvh9O3MQ9N8dlJFfZDrSnbKJUaBKdfPSgZA2o92dJr+PPxJjE6W
         ivCw==
X-Forwarded-Encrypted: i=1; AJvYcCVzCm/Hj+udI25MbfiQr2SKd31dZ0HwME6/C54cVWjUXVwghWadA1G4NupTeAyAPeKxi7uz+qsyNplp/yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySvEOKrRnVwGnfD6IBK94BxMmumlkKd2bVWm6SW3d/uIq/HOi
	lrAeyPq8ocsBCp4eUQO2UUk86Q7peNrJhUFgtPnFC5xE5kYWA7vXY7mx
X-Gm-Gg: ASbGnctFUGqOexD7hcvZVG1JNBYY4JYTTUF7/RbI4NGxVQGKSWKjBQWjVRfSjKJZR8G
	hycROv8bCcrXssqjIiZaEpHGsXFsFdFOJvdyxlfrndLALfrrC8cPtfgOPXZmez8ZTfU9NDzId64
	06AY2G/zw4JZGy5AlDxqZPXiNIwUr+aYCJrlzMJbADRzxWsc/h+K0PDtrcAkOK/1FSfMrLzmfRl
	dURJ1+Keujcp+cZxSz977F/KH3gubWqyXWWFzkNYkDLk3812wID1y8Lwfeyw0u7gbExkvcUrh8B
	9wDO2t684VExGhBwI0PdywAYLdH0H9E5BP3KM/gJ9pROtwkD5and08tof+9toN9CKQbBSIrHcTu
	VhnPel/xRFGt+31TlgyinHF2MfbK1FrJyNng=
X-Google-Smtp-Source: AGHT+IGnenyE6frrx61hpk2H1dyCzynS+vL3sXDmbZJarOVCZ/cfik7xdg7mftRkCokyhtVFgoFyZA==
X-Received: by 2002:a17:902:c94f:b0:24c:7b94:2f87 with SMTP id d9443c01a7336-27ed49d0885mr199075ad.14.1758725750379;
        Wed, 24 Sep 2025 07:55:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053248sm194608665ad.15.2025.09.24.07.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:55:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:55:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: add MP2925 and MP2929 driver
Message-ID: <360d3c4a-79ca-4482-a020-2cd477dccc54@roeck-us.net>
References: <20250918080349.1154140-1-wenswang@yeah.net>
 <20250918080603.1154497-1-wenswang@yeah.net>
 <20250918080603.1154497-2-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918080603.1154497-2-wenswang@yeah.net>

On Thu, Sep 18, 2025 at 04:06:03PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS VR mp2925 and mp2929 controller. This driver exposes
> telemetry and limit value readings and writtings.
> 
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>

Applied.

Thanks,
Guenter

