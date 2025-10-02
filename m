Return-Path: <linux-kernel+bounces-840781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BABBB55D9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A03B7342607
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20822D3EEE;
	Thu,  2 Oct 2025 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6RroNDL"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE0C2D3EEB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438545; cv=none; b=a/FqwLNN/e8tHRCCmd+UK8vx746GvcynHDSai4yM/i7nCoU+Lu5KSUaFk2ILu5GP/QZRMBuv4kSVUr+Jjm8FrXTgiwNlSTx64uB4LiKgVjY1ncStlQcXVEWW/YzXJSiTlF+K6PxUppuU2HPIpfsmjgICltDjMZzGuZMFFtT/EGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438545; c=relaxed/simple;
	bh=Z9iSGZ+S2wi6F1tMIvySWX/506OKQt3iTsYD6qsKENo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB8bS0qkgldDztaE4GGgDLn0tttb9eDUbX3BYuEaNBFX7OGu0wbj0tqsaZ2/N1+6t+ZgNZLi+ODBD2OUvf26DTxs5GyzBpwHLfGNFDqFzRk5xUWFXTcw7VBRTtd5xOQxa8hRrUt8RPGSEKYAfsxBvi2jr12k0vhy6PRwqHJW0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6RroNDL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27edcbcd158so18836455ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759438543; x=1760043343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nWNzw5rFvgp5+4E98Z8mggAdalCFOI1DScecBvxjnM=;
        b=b6RroNDLzLznnFNiaz7yXatY0jWMrfUxE6G4oZj97RRKJt3nNA/Uoej1GAKCEFdsvs
         gPcCTpedk+89YT2NI9m+xCepcN9tAzhroUcSOmxnS/KYxwlL1qAppLHLc3Awl7PJlAQu
         WrfubdDKUiNWZWFialB+7jVYioWbMsIH4+hTkvpsdd7M4DRGGe7+bprZkU02ksfZfKFe
         c4zir1AZZzZNGVPAGWfsEr63n8vf1L5A1J1UDHfRVhfNi7toMcZcDsExxz49GLDIZwwo
         uL28sDEuqh+cmU9Xc+9S8ImueUOnzcUscuO/5SG4CtoUKLxojCfbRoXseMj/T/DnTf6K
         E/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438543; x=1760043343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nWNzw5rFvgp5+4E98Z8mggAdalCFOI1DScecBvxjnM=;
        b=Pjx3GwkJoC/UjflYIqFimcvwLvMBLnsE4ost535qfrcbV0+BVmQl61+8Pnt2HZxVWa
         SU2o/KhLjT97gazIhF9wk94LMl+mhBYdcXnL/jttucHdx/vEHQmDypN71F2vIPhKZz9K
         SZjv/GKeqW0E6rc+iV6Z7INebv3IyorPGVdY1x1ROFTqK/4MpnbieImpAmY0RbZrFA0m
         z5TONMmsp8CjaOD9EjTslZOyzctO4T/4kEvaqw43WTmlCGd+6ecarPClh+2Q73X47UFY
         XhcprCpkVrg1ULRJObrwG2D3sG9hZtp0V75tuDioDtY+iIPFoq3IvcfkOcljPaP6Fmlx
         Cyeg==
X-Forwarded-Encrypted: i=1; AJvYcCVl6VVOfQBrWSNwHuIr16BqvlAixN90NIElrb+OJqHeW3yyPWF52IM3wHwJzabApzN+UyVm9gHn4H92D0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YztSarqH2k6Sa42Wozlhym0lHKgpx7E2/BgTXfgcCyE6Oi6tNxC
	A7zXKucTafX6Bz+inYJfNSsAd8ZAgEiTHkMNZXXyvfzQ6zCb7F50zzp3fCEeemXT
X-Gm-Gg: ASbGncsw77UW+nYcFFuCwNAIYJIi9FZ1C9KO+TxMjxqm5ri+r4mcI//qx1G0h9bQQNO
	6noObNFmCG5WkWoD4FzlH6p9ge4CjjIUczstucEAvSt95ATgxUey2f+UftbkQeVbKMCz6E+bPhN
	YH3Aqv158kK2Qe7Lga0C91E5bFG7EIKzTKIfzLvVMzEPPM1+e1MGS2uwkfEDWBwkVw5Ecg4otZH
	0kMiuH2h9SFHoJvKkOwQ+TeAr1ofUC1oouSB3U77OHx/VxIVv0xoCH/F3xUyLt7BY5pOv7IUO4v
	MDiq+SlgFGt3yia7UMA0rJBBAahEkKGK6OP/hoM8MSKLSax7QnPVJB1kmTTfdMt/+RekgVMlj4s
	QJGEtc2XgiomYcKhL/GazX/sBRDS/84aXuA2J1uVjzywHEU2r/PSgCS02ZXY=
X-Google-Smtp-Source: AGHT+IGYss5qk3VXhh2R+ZWPGB8ZQYoyyFAiwZWm24n7JZhmlZdFeuaqBerfiJZ6THmQhp0n8lu8ag==
X-Received: by 2002:a17:902:c405:b0:24c:a9c6:d193 with SMTP id d9443c01a7336-28e9a54661cmr8418405ad.18.1759438543174;
        Thu, 02 Oct 2025 13:55:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d622dsm29757765ad.110.2025.10.02.13.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:55:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 13:55:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (pmbus/max17616): add driver for max17616
Message-ID: <2731236d-e3a3-4fba-9938-ca6b10f975d5@roeck-us.net>
References: <20250930-upstream-max17616-v1-0-1525a85f126c@analog.com>
 <20250930-upstream-max17616-v1-2-1525a85f126c@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-upstream-max17616-v1-2-1525a85f126c@analog.com>

On Tue, Sep 30, 2025 at 01:02:21PM +0800, Kim Seer Paller wrote:
> Add support for MAX17616/MAX17616A current-limiter with
> overvoltage/surge, undervoltage, reverse polarity, loss of ground
> protection with PMBus interface. The PMBus interface allows monitoring
> of input/output voltages, output current and temperature.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Applied to hwmon-next.

Thanks,
Guenter

