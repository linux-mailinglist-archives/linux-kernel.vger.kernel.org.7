Return-Path: <linux-kernel+bounces-830702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC8B9A54A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57144C4B78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6650301477;
	Wed, 24 Sep 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDVhHvc2"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2321D3D2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725295; cv=none; b=lQpDG9BTBOvA0wYNAu1Eae5DfGqnyu39BTCw3QzDCnaPaLNk3vmX7RvZf+8YcDIJRLoHyUNUpmdG4ygvoia2VK//yip6rS2St4B44YzMEKLUfJsqre7qZqUC3kpD/bDtz9EglJegVcu5luh/+1HhGlPp0ha1NW3YKaBjXnCAm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725295; c=relaxed/simple;
	bh=wNl7jQLwEHKQRZX0SAXvXgHbGWSN5OECo77b/O6rRR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQFoAgWsUtqq42lAUtMb44F4xdgBSAeCXT7FR25/LwPnMLKI+MtakXyLdg+IokGauRbGvZ3tW9cahDqpZDZucReIRQuqzJg8kg95UOV1CRXzllaFsUPIn+NhHZpBgJH0I5LIRnGNoSpOAt08DEBqsSYjKOs0v4U8JkXEtdYiJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDVhHvc2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-26c209802c0so52845345ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725293; x=1759330093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCnQwG7cHEZFPgTmiyysVJ/gsyay5bIs1U65I8G5nbc=;
        b=bDVhHvc29lIH9XBjR3fW55NSUCb7UL71qB5s0om3Crh2XyJpCyayXwPakpk591Yiua
         F1w55xvZKZwpPuHSzC5dLjodto558nD1BeQ433LholI0i3fHbVyUuTpXEIiXG4Zd/TTM
         2aV0Td29kMy0EAW8SUienJM+pCkamJcwiQZrSZmWRHomh1yGQYZ48+d0qLMsfJzi3cvj
         FDWM7yMj4frM/kJA1GXebNQ1/4SSMdSES9vut2wbORtJ7vKkadCKBicX9OTaHZrkPV0L
         Bpm6fwwOXJG02AH7wagRlIB7LcNPdiVZ8UNHtZlChWoEoC9TrUP0yHLp9yFAm4w5XqLe
         4BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725293; x=1759330093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCnQwG7cHEZFPgTmiyysVJ/gsyay5bIs1U65I8G5nbc=;
        b=KWutrumvGxL37s0HvQtsQ+HzEXtyFiOV4lB3K75DO3Mj6AamQt0S0V4MjmFsol5CSD
         Ic/Bz3TrwyCvFe0TAHxC1Jo3CfHFlOLcdt10njfTMFss4Nj29K5e9PDHFXB+UhdbNiOJ
         2norAaaCSUHG7Jb5SpDrTgNzKWUV2S6ndue8Ca85IeocmHfMOoRwB4MEjhSshzQoZbY+
         r0V9qM7rcE7280Cf8ts99waVdxud5ICf1/40xTujr9wHIl3I/ffW5h6An2y0EsRJfoMG
         NYz4+PnDhCT4Ey6Rz8CiHWrbYjm/q3PTrb/7aY6SbToHVXwJl37uk+F5xDphBVsqpcVW
         iI4w==
X-Forwarded-Encrypted: i=1; AJvYcCVN0bWOepbxypQBv4YKwIK4+3CKdME9BJ+8xbsNiDHTwPyChRrrnNrT8KYiJlzIStmMHcaslkDBNZzGNH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBi+I/V+wbyCoBTMJmMIGuLetUkPBeKdatoA/iRsoXbLICC7nO
	/0neyePIacVBqXqNUEzqCgjPaHKjAb4KyjPZklNy7fHXcIx6BROq49lOiCgULikJ
X-Gm-Gg: ASbGncu1iW/a9Y6mh2QxQfHEvMAaSrnvZ0kEdCVTbcEg3t8O4hhrpeg/zmbJ24+D8qp
	xx/elQOwUxLciMmrjDTKQVslkMZO4EjwYBMumCY35uvvKk1lkZxeOZFKCBel9f290FfjFu4GqAm
	grGoPELCSkkOa9GG2xWYz4KTLsdZS68D672HvRgupYp0jtk9oucP/61XkJqOlYiloEcWWymNd1M
	ZAm3xr/QKQxYIpd/MEpGRnEIWQjHNXLwAv6u2Wr0kOP9zLvPkjM+hyYip2juJSM9JLOOxpu3sMp
	0kQ8irtAoo59OzIUfGNpIEvkSPHkP35153uBhkTjbUpKXAeulLdWmrhDezbEBbODEYUiExqmxsT
	3Ng+lVDgkytOTKh3IXRK1xzCQcOL9NRoy3H9VzQGEFAzRnw==
X-Google-Smtp-Source: AGHT+IF0Wc/aabCHtSWcbcm967HWZ+TJSB9RK+HGHmlKX6l01u9oA0TxcL2DvhecnXy93SqhEsB6PQ==
X-Received: by 2002:a17:903:4b46:b0:24c:bdf5:d74b with SMTP id d9443c01a7336-27cc27c217dmr79382925ad.19.1758725292956;
        Wed, 24 Sep 2025 07:48:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2752328629fsm105445555ad.106.2025.09.24.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:48:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:48:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Ben Copeland <ben.copeland@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (asus-ec-sensors) add ROG STRIX X870E-E
 GAMING WIFI
Message-ID: <e2dac203-2edb-42b3-b75e-f9b119922250@roeck-us.net>
References: <20250923192935.11339-1-eugene.shalygin@gmail.com>
 <20250923192935.11339-2-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923192935.11339-2-eugene.shalygin@gmail.com>

On Tue, Sep 23, 2025 at 09:26:55PM +0200, Eugene Shalygin wrote:
> From: Ben Copeland <ben.copeland@linaro.org>
> 
> Add support for ROG STRIX X870E-E GAMING WIFI
> 
> This board uses the same sensor configuration as the
> ProArt X870E-CREATOR WIFI motherboard.
> 
> Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Guenter

