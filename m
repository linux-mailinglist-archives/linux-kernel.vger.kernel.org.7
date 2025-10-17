Return-Path: <linux-kernel+bounces-857153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE0CBE60BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABA6B4E9121
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D014A91;
	Fri, 17 Oct 2025 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb7hOoe+"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE57C120
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760665035; cv=none; b=lAdMvaRRZLDeZrHf7yLKTd1DVZLIeKdO7Uy/r9GMtlQ+wPGWIzDF0NR560iT2xd7sYwGLaZ1AavZWKNnryjWbi+y8EL/4VnsoROnwcVjtwyUuP2EzPTxapsI495Wpe/B3yrIUu0F8nnWNya8k9SPGWqClIgAGIs9PDe8hPhBXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760665035; c=relaxed/simple;
	bh=Zo+YKNbr+umi1MBI7AfltU4CdGszVc23+EqHWSlqit8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wgq29Thwah/H8f3ozSBLR3wBwJaOtg6jKoGgr/mQgSQcJDIy2c9ripSPs/aCxQq/b0ZjFXkGD9wTJGHOsLvi5Y6AU1f5jMdnvb12bmqYvC1gj+VPEm9y9J3z9p0v6Cc01cfMzKG3nSjJVWuT/kgri1TIxOzoNXQjQGKdQ7Z+e7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb7hOoe+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290a3a4c7ecso14699755ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760665033; x=1761269833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ILJRfUFChZwmT9qx7WQiS+l6DAS2CG+O0wIMpGpRBA=;
        b=Lb7hOoe+YNJ9Znxfm9qI7WwZnlYpxgXLtmYgXiBg6k3fewwH2ncWlYE5LALyYFR4vd
         QR23x5aqfcL/W+4V0Tq4+ZmbOCWJMhf6hWqMp/LrHi8DxTOTM0Tb9fYS1rPQi1oFpmIu
         ywgza/ai+jDU1q453gA7UyMdaYPDIugnUmuG8835fauuk1+rQbWoajio9yppnXKGrSXP
         cutlbSa3/hDx0zyWTJz0BccZOqauG2xI4dRNF/DLUe3qjSDtEamidmaf7w0799Wj8iji
         3WLzK1WOL4mdSPYQN/9F9wcdDfwXg+5Jm4mm2qtPzAyidKbYIEUcd+Wkt0bVSekBBh+Z
         YfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760665033; x=1761269833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ILJRfUFChZwmT9qx7WQiS+l6DAS2CG+O0wIMpGpRBA=;
        b=j0vLIq9kq4tqWlmPyhORDqQebZRzm1cbfwtEZr6brcp+plIUcQmrhZTfVuVQgh9BxP
         Qh44zFPhJc4rI+TiIwAmXR4nPAUtK7gDdaTSp3UVBggoGkvPOTsWP3HSQ/Cia+SPIJnc
         +28kxUMG3s67J3MssXgGPbLqKOgtUomenKBrno/0gKjnRNT7daqQT5VeBLdLXayzKI/W
         TSYK8QFJLxGXrneXsyPhexfCuXvKATPImkc5Ad/hZOdVk8ggyYrHcEEz94DxAf7Ila8+
         86NjLhOyVnECjrT3fFKvMqELSSiy+7c0ZwtGD0Hs2ty0xHA/puxkGdsqO6fDbObC72eI
         4GxA==
X-Forwarded-Encrypted: i=1; AJvYcCW3G/epXIbISWV3CK9dqr94Hke5uliQi8spo9QP1YDLKokCWZVQhSHv5HueovwwJ6ea+9MlnswTgJHsDnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8JRE7BKCmjMpMkK1608WlVvgbhOqYaqzhjch6wBYZfAbNh9gQ
	DmunXm5KcLfHB/SCxM5DkBZol7fIBzWBOFrad58vxUDY7OsrDuPUZTdV
X-Gm-Gg: ASbGncsm3ydQ4JtOamSEjzAhycqYUaReQ1QvmJe6JVtf2uZm/dPvEddnBaXHCXnOl2O
	ANT3FFNMI35y2g0HL3PoIKTISWlK9E/rNixkGR/t5L1ShEC2Bj6Ai5qFH5m1lXyAEp44fj+7R0d
	j8SzPn3sTGyZQC7vQuf+J2MCQH8fpkMQ7AySyUjR3yFq3OUQFrp8Gmsa1BJjVAIvaiF5JquJnFj
	jhU3tRkhH9UyO2J18l5cC3SnYI98IBMZQAXtX/oG9+LK+BW8q530p7AAYdy7AaWJJ/Btc0CcL9T
	16jziVWNAOMEnpQozeQCp0/3jndW3iIHa7VX/vItO1tO5Iyv6Urqe6AV3PXenNVW6MgIQ10Jwi9
	MDkRNnC9aMq/RGdyQHSVxhBAIFtRKUoH3syjq5aH2SgpA6Su4PREzJ7cr2sXfTZ2V4XnS6jnzKu
	/WYaqZAOluiVQx+6sJDT54urR668HCbIc=
X-Google-Smtp-Source: AGHT+IE2yGEtzbIle/eJqHwdsM/MIqunq10bGH02L66vHaWWDdU2FaaoaVkuH8AQgdCWRloz+ve31Q==
X-Received: by 2002:a17:903:2a8c:b0:271:b6b3:71ef with SMTP id d9443c01a7336-290cb278aeamr26486805ad.43.1760665033087;
        Thu, 16 Oct 2025 18:37:13 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29099314ceesm44718425ad.16.2025.10.16.18.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 18:37:12 -0700 (PDT)
Date: Thu, 16 Oct 2025 22:38:16 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v13 1/2] dt-bindings: iio: adc: add max14001
Message-ID: <aPGeCMiLSB9-A7t_@debian-BULLSEYE-live-builder-AMD64>
References: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>

On 10/15, Marilene Andrade Garcia wrote:
> Add device-tree documentation for MAX14001/MAX14002 ADCs.
> The MAX14001/MAX14002 are isolated, single-channel analog-to-digital
> converters with programmable voltage comparators and inrush current
> control optimized for configurable binary input applications.
> 
> They share the same features, but in the MAX14001 the inrush trigger
> threshold, current magnitude, and current duration are all programmable,
> whereas in the MAX14002 these parameters are fixed.
> 
> Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> ---
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Since you've dropped the ADC node label, I think you could have picked up
Conor's review tag from v12.

If nothing else comes up, you won't need to send a v14 as Jonathan will probably
pick the latest tags when applying the patches.

Cheers,
Marcelo

