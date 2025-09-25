Return-Path: <linux-kernel+bounces-832870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E10BA09D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04D3562F50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2C3195FE8;
	Thu, 25 Sep 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L79bGj+X"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1912DE710
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817850; cv=none; b=AFhCodZzH00hfkB+I2Lt4LydtAEzyhrWnG92L/mspFCyDidGu9Khz4Rl8yXIBS4X7gqCyZbird3oIVMeCtMwj7iia+kK6aRmEvLeo+FJpWiE+JTzzaaKaC2FJbvrvCev8T5Qkoy26KX8nrniHjY3YdgklmZsRMgYuMkSFEFDKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817850; c=relaxed/simple;
	bh=mmBbQRhSrowNNgofbJRJowA2cWkVg/LcdRFgea4xmCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpakswrA9uCURot5mgaXrFVCUnjxaB0I3GBhnR8uvytMMfhDLkOjCnTAXuK8cMZnsOCmYZVrMpI8vtNo4Dp+0A7/CsAMqqszJ12EOXJtrZ2+SPy5hJzbCk27T3cOy18p8UxD8AmyFHBdE/ma0z5uwFZnxBuWLc3CZv8MLW1Wz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L79bGj+X; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33255011eafso1156229a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817848; x=1759422648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0PN6ICUXKIfVACARWgyW/Of0PgwLtWEh+IphdJWk4Wo=;
        b=L79bGj+XD6xetVWTFBQDRtuX2iun1qgBUjMt7GeDCleUZBalls79lr4letmGYDJxik
         ZBjuZ+0JDD4SYQsx77AfYRw1B7bdKlWDThAJmkH8q/r+rR36OJFOY5oDX+58IEjpo0UJ
         7td78L8d+gc2poYPqhq0x5JqrQ4KjdtmeCdZwwGDAiM8rQk6ab0AXzQmZy+fyfuZq8E8
         +kDjlN8IHCq3zX1+WdZzzhenVNerf4DUasXPrrnLIdTYc9dFKnIwBZrx6HoWzdkyH5F2
         k/G2GK6/olzC3AcMmwRIGukbj1LYOzEB/2vi0UK5qGw6j3dPF6OmnGvNJAmh7LHjyjEP
         EN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817848; x=1759422648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PN6ICUXKIfVACARWgyW/Of0PgwLtWEh+IphdJWk4Wo=;
        b=ixm3P+q9lETc1Wog1zi18DMPPc2wxxtee0U43+ohvz/OMp9ZKpQskT5VwWy0UTAyeF
         HNL8Oy6g8AzhlD9FiZuj16z8K1xZJpdrKQntXLxNYrI1+S42lczSROc1Nxx3+bKQZxJJ
         A43wqiU+N05d/dM2RlzIIdXR40Kj3JTSMvqPpFpmFSN8wVNWOkDyYgz2rE3GNEW2TIoH
         mhqKHrHS4bf/aE4dzVniC8RRfQUgzZaYIYjfklVpAanGI+QLBVU5KUPYdPo8u+smJfWC
         9EybvFaWkLDukQizoMaCG0EFMWOvHCGeG8XqDtk5Z3qEcUHUwjwu/w3R2V1E82VOlKrc
         FDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwV0doTkC65f7yuOxkJUTxdgOrYtyIjh0+W29DyOnrLUb0F1n8GWIf9sTaS5m75VJHS9H1JZ/tQxXXmh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNFXu7hfFzbzd44qQsa1QsHQ8Ka8XR2qnqGNCljpYMqiT7iPE
	mA8pGfbnoauEJC7aiOuhnnBxT+bRzXYVxXOe1Yb0LyOgyu45S2xTVn4z
X-Gm-Gg: ASbGncsnjlgYkK8au1JbaHKWGF3Xo+68aFAAKShsi8pO+CXu0J8OdjJDupQ5Yh4enyT
	tUpyZfeEDOkadLgmZ1AjLLv+Zf6BibS2ca3w3LKV2QPPDmaKjw6Ue8VJMGtOY5PVnOLocB6gClZ
	/wXxIhvDUyFl+cf2b0wav2leQUJ9wLmKVSPXwv1s2mRJzjW8OvPK8PghR2tgdUeK7zlkdPkhwB0
	cVU0wCDMfeV+di1DGqsBy8ywmne7s/oHdf0ESe+VGYTncGyBDQiE+ZDo4YYBP46q4uuS0ltlFx0
	g2lD9WRllvdNUk0mhd9cQlgDasHVGn2HIPuFsXBjwJSmoUvVeEVOq0R/oYvTNGR2Rq0WvbLNkrP
	iYYxXCdUYblkO7Eh8MwbfmloaxB9gZRak
X-Google-Smtp-Source: AGHT+IEU5RoY11d9SqTfLbjzgFHL6Oy0TOlSWFxR+z/E3squ+5c+PTL718x89e6XI7MIr1SDPFt01A==
X-Received: by 2002:a17:90b:1e4b:b0:32e:2059:ee5a with SMTP id 98e67ed59e1d1-3342a216f68mr4495137a91.8.1758817847812;
        Thu, 25 Sep 2025 09:30:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5a97:14cb:a5e:6c78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be235c4sm6272005a91.23.2025.09.25.09.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:30:47 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:30:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Nick Dyer <nick@shmanahar.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] input: touchscreen: atmel_mxt_ts: add support for
 generic touchscreen configurations
Message-ID: <yxfb7ybiewm22onuw5x2usmhuy5mlijbkvmwhjuimfjn3i6mx2@nyjvqo2omqp5>
References: <20250909054903.11519-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909054903.11519-1-clamor95@gmail.com>

On Tue, Sep 09, 2025 at 08:49:01AM +0300, Svyatoslav Ryhel wrote:
> This provides support for generic touchscreen configuration options like
> swapped-x-y, min-x, min-y, size-x, size-y, etc.
> 
> ---
> Changes in v2:
> - added schema adjustment

Applied the lot, thank you.

-- 
Dmitry

