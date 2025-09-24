Return-Path: <linux-kernel+bounces-831273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3402FB9C3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F3C326E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47F3285C89;
	Wed, 24 Sep 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csGWOB/H"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FF285C87
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748449; cv=none; b=UT2pLVfEb7f/rAks1ojqbyaO64Gnj6nCN/peSn/ewre34qfkqy9IPIlGBkxl8EY3GrEDHgpGtbSbmegORglby75qJSeXJdzhUCksv9Yu27sm49Yud9ki+kZneb8XVi92I/bdR7JG31SHnPJqkfKWkA4fLIEmjkVilxEM0+rkp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748449; c=relaxed/simple;
	bh=tWPoT8hXA8bqdaHaLzPDAH+YrWSf3vmYsx1qgBZ34/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJEPCBIsPa5ofkDKRrMVaHsSdMJDn/zrTaPPhdUJ/0PPj3CfHcrEX0k8HEkhyrQIg9Td3n5pOoaodTF7tVaJoTTBPIictPlIXrLFisn9/ClZR2dhZ7aK2sVboctwgSQO+ZNor4FnZD9qlMkuUQMRYWGiALxDxhSN1jp+RslBNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csGWOB/H; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b556b3501easo234879a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758748447; x=1759353247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtI+Xxsd8rE3fuveLCvU/MdyjxsiyhC9uH9cXSeRvHU=;
        b=csGWOB/HzJADn0swCXqj9R56mgoUOI0Pin4QmIaWC/74MHyRR3MQIBx1iQ9OgneAfd
         WoEjdvhmSwIunGvKEPvLT1a44KqkX1448zPIKM8NuX+eosNyxTCUF+ZbtmHhMaCaYyed
         RPWFHlkp3iZ6z7P3JjMI307Iki5nTpNOmlsob8rIM6a8e9DwvMTwUsQTT7pr3BONDUTj
         kuGeMrLTh+q6GOq5R4tX3bvZCo8i+WJFDLDziTGpwAzjXYR7Rk9Sv0joOLGkAhs/DMLH
         7MY600cPu1RcDC+Ez1J5Z3L8Bwxqcyhier7x5j26c04FUXkAZoRFolSscdyYHcgxrdnb
         N0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758748447; x=1759353247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtI+Xxsd8rE3fuveLCvU/MdyjxsiyhC9uH9cXSeRvHU=;
        b=YcS/ORg5Mhsbq3Y8ovX85f2dPssLy4zeMcvyZ+tfWiBb4Xnefwi1J/6Jt4sEJvq1Qy
         bnbiBOW11NY0JLViAgH0ymbGHkNsACEw45fi9L/ui9GhUAlxE8p3Bstsh2F2SZ8szk44
         A1gEqXU6lJoghBd0aZXc+sJ6j7agBZQ9zg/+rhwYV29Z+A3HP0jDyVpFb59TOl/5nwiI
         VMTYfTPUhUvV7W9TjS03fzXHTKHoa5HMqk4VbB8J0FAYmK/v+96fh3JVGMdUVCh1aN8Z
         tL1SsMP0qr9qd0/05utEGR8U3FJ9j6/EL38sxuF3t71x9H8/6gFkyzbP3ZiKL7GyF5q1
         pOHg==
X-Gm-Message-State: AOJu0YzuPXlMrUoD+9znrzoosdiHpAOjQccAK3zdqFKnHCndOv/mlbS0
	MSLWezWUSayrDROXsK85WRgs54yeMgZPKmXrbBWEvicoHvcjewXio9r6
X-Gm-Gg: ASbGncsva0swLP5/835izCz1zXQP0wW9dee/WdJDf2JQZjhBSGXJ4nMnp1cXy1sLOxP
	HWNNDmWoP+yBBaiTWeugMfXQ+SogmlJtGBZeH3fw+kEJ67WfXpYoWW0tqGTj1/Vv6kO3RSgguhw
	DB8zksEqw1q1CfiDTwFzsL5rFRzDlPjBwrqdjCSgvY2yd+ddb5vIgPUHnNrMNEc8EjtnMaiclPH
	daFqOG96kXJ86yUwD3luHUzhWCaamkApZiegBFvfjDJYXOIDuxoTRpFY0L4HaPMDQtmimTHt4kk
	d+fnbLyXv8sP7ZkduovAcLHIivLjIF1Puzywr+elbdh7NK6V9FJ7DU6rqoaP1+Eok/+RrUDA3CM
	zSr1gU6fjH4dUHCeoINLS/A==
X-Google-Smtp-Source: AGHT+IHchnbtWrdhaWeshGUQo0IHCW+W1jq7tB9DCwBzgUE/TOXYECiLeyb7fq0Zi9TPW9Z78gDzfw==
X-Received: by 2002:a17:903:b8f:b0:271:7eba:a49 with SMTP id d9443c01a7336-27ed49dd8bcmr11592285ad.19.1758748446942;
        Wed, 24 Sep 2025 14:14:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5a97:14cb:a5e:6c78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53cbe6dsm206917a12.21.2025.09.24.14.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:14:06 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:14:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	sebastian.reichel@collabora.com, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: touchscreen: convert eeti bindings
 to json schema
Message-ID: <xugkxduy7thmh3x373rcsacfdslnvscdfii23acx3qq2jp73l6@ymxf7g5earka>
References: <20250921173353.2641438-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921173353.2641438-1-dario.binacchi@amarulasolutions.com>

Hi Dario,

On Sun, Sep 21, 2025 at 07:33:42PM +0200, Dario Binacchi wrote:
> Convert EETI touchscreen controller device tree binding to json-schema.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

This conflicts with my tree, could you please rebase against my
"next"branch (or against linux-next)?

Thanks.

-- 
Dmitry

