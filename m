Return-Path: <linux-kernel+bounces-830690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FAB9A4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEBE1B25184
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339713093BF;
	Wed, 24 Sep 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbXt3tWc"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144028C870
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724908; cv=none; b=suSLxzNdK77jcbYJPad6bPKpdSiFHQaURRyoCDYk11jVpHjT+MnJPPBfysK1OfXO8tnes1vCu1wqjOxcaupIqOpLtZO9YL5Bh5n0R0gwmYFUklzyYs4521TDtlieMi2D6CBD6h8843xCL6/hlrRObwfP/sjQHj6B5OfPqMI7LDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724908; c=relaxed/simple;
	bh=W0CAhktGRZ04V99yCWSPlVYW9qZzY2wunBg7h0NhCIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daie3tQjhiPSjMA5k1gkz8bg/JYHRnvmmYkAnTDKMdjQLj4u0FPCehd2ch9PG3U7YUo5fNoUDB0BdSoEaEzEXdetEeU/pPJ02YzLvksTIEZPiPusxBpK58A2Y1gsJTu7wajYLaS32cRKg7tpHlJdCwGcZgrxR8stletjtNqrx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbXt3tWc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso5787429b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724906; x=1759329706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePDH5KGJWCygcppGoaQCIvDmpnnW40P9lL64y9nVceU=;
        b=lbXt3tWcjKJvB+kDC16FAMuTrE0MOVUqEpo4ndY6kOcyFfXe65VDq6RdFMKLH5dkCL
         LyRy2zoEaj2zUQlWlWPhJ9fTZZqJofKKi5EOwwBzGZUiFjRqdH2S6hyRTSRGMqAAeC4Z
         97diC6wYez0k4yKZDVUGw+l6Gh3oIijyuJfCEBnPHtlZsGSHF7Op2lk40FpF57tUpcZY
         oBoZAirXIpj0cEjrngvurd8rkZoUala8cBPAoolGRPrQdgsuZkhdhD4iEC8EKbhpDItv
         PS/b1tji43BQrBUnxMp0PVDRJX3QTkJ5AKPAti8B5I3M1YPnW5Jaej0k4bmtXkV11KSr
         EqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724906; x=1759329706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePDH5KGJWCygcppGoaQCIvDmpnnW40P9lL64y9nVceU=;
        b=MfqXBzf5YU70cP35mWtdcRcKuhL8WAlUXAC1N/klsRS7jkw0srQlGYKmq/l+5aUr8C
         AcClCG9HyUQQeU+Fos9gBDIWN39bOl9GZ9ndnMWy4GBWjbGFHSWcYnnJYcNjqelzU2yq
         jbayHIDofQWIgk/Q58HFd4tvj5UJvIhL0WqSBBdYxfnm6np+gbrzcT90OtzkbtoxNzHK
         8x7drN2V8qTlDYr9GFWL+xY4JBdsq5Cd2w4LA9aqdhTXKlAU20Tc9p0CykyaE5w1ZvOu
         gdSceg/JRMzb4e5u0XxE7Ch3qDxsKHzDXodGqLoxRQbxpS1RFSZg90rBIlm9VnFaCXU5
         peYw==
X-Forwarded-Encrypted: i=1; AJvYcCWl3G6EJX1EvpP+QEjvGAGkXAC/Mufr8ZoI6DWOH4iOVzQ1G09k8caWno36qPqhi0BabcsOWKJmLQ11DgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkV7z7Ugd7QHbiaNEieW1prVfFZp08VidXFGkTrsJh6HLYZot6
	04oued2SxnzRVpIqVMklfi3tHRy7BlhrpH/xoblk1sj5VfdhtuRqOnNx
X-Gm-Gg: ASbGnctBAvt9b68vynKJ5bqZuM+Jx/JleiOxX6ZoO5QoERRiWwDMIWeMCIcwYbWn/7q
	Bu5z1js5C5YR1zGz4D7QSgvHokr09uAxtWSEP3sFdHJZY3P225rwhCigvgNL/AFBei4kyO5EzTr
	eUv52y7KyzjKFebYSb1y4LS8xfGvx9CsIHKAeV2mTWamBBt07owRJfB2BfK21yvEXx+PNwYZK6m
	WSD8XtGo3Qdlzw+jUXpMOVbtNQuH0CyhXxySoFzUAZAOI1d5lOHdk8rNbnl5k3VIFAyswhByhPI
	2iuYIHJDNNtgdk9EEzcvwjo+E+OeBWb64DhrrrCaprKIfE5V3f31hGlrKLlJ+b0Se5itGuNLyU4
	NuTAm2so0/+vgUtuVxGFbdx9d4UR0XNAPk9A=
X-Google-Smtp-Source: AGHT+IE/thFWQvdVClEOk/6wwXKwPKjW/dGu1B5hditayD8OO6MbNLQaLCuiocvpMwHugPUxDy74zg==
X-Received: by 2002:a05:6a20:729f:b0:2c0:227b:13e4 with SMTP id adf61e73a8af0-2cfe7b1879cmr9245324637.26.1758724906138;
        Wed, 24 Sep 2025 07:41:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7aad7sm18984248b3a.12.2025.09.24.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:41:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:41:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Sensylink
Message-ID: <5327db80-86c3-4b68-83fa-1788e5a30fc2@roeck-us.net>
References: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
 <20250916-ctl2301-v1-1-97e7c84f2c47@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ctl2301-v1-1-97e7c84f2c47@linux.dev>

On Tue, Sep 16, 2025 at 12:46:44PM +0800, Troy Mitchell wrote:
> Link: https://www.sensylink.com/
> 
This is not an appropriate patch description.

> Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 77160cd47f54079a39f35b570d69f7c4c2274724..ea4011d64ab9081d212a738839849d5814cf6c98 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1353,6 +1353,8 @@ patternProperties:
>      description: Sensirion AG
>    "^sensortek,.*":
>      description: Sensortek Technology Corporation
> +  "^sensylink,.*":
> +    description: Sensylink Microelectronics Technology Co., Ltd.
>    "^sercomm,.*":
>      description: Sercomm (Suzhou) Corporation
>    "^sff,.*":

