Return-Path: <linux-kernel+bounces-877511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A2C1E542
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 740E64E63D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A902EBB83;
	Thu, 30 Oct 2025 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="tZNuh1hb"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30F29AB11
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797484; cv=none; b=Um56cywuIxmiVejdrevQP1xoz5+xS0yAOHikZpOYnpCspfiJ2qoJyGRjp4OtybVz6vDCSFdPWy9TGarPqEQpG0DNeCqI2AufiPrHMNSyHoKQ8q5wWViasq/RL1BkmKY9qRbIVXv1bF36BEjNNf/eGYtviysKpWTVSrtVkzv0XU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797484; c=relaxed/simple;
	bh=wOQEOC2HPRhz/xfy7DQRDA+xMnWo/M0q/ZztPLo/IbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m53EAYnIsD5i3WSWDZMVpN1Zum8QoS7DsD82Gp269eNZhiOqQBWq5vPzoqTw0Sco826q3n4lXyomntDDfezKpXtdlQIO7VmlYRM6lmoJYyfkdWBNtKL9uaDmEBVO6i0S4YX0Y9XDv42YQcxVVq+Fn8Qx+/ph5opG8AE8WHmICxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=tZNuh1hb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3405f03fe2fso82923a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761797480; x=1762402280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOHF4yRzSI+pLeEyJamn8iNJEDjHjhmR5/cKOdpaYa0=;
        b=tZNuh1hb5VCnPNxSC3QG4xYcew5TnIk7LFjiCof9CMrqv+vPMLka7CpawXX16KzvTW
         VkdF+qiMoVJcq/U5N9ruxFSjq722Ov6PHEv5v0w8Jwu9wDuxe89BrrJddNwAutGjFZQr
         j0adHus8AmittBgluIGKyFP+PCcDcT5SEJaNSHYOfuf2tttajmV7x6cZYw1RJFEgAc0D
         /MfeyszOMTR4q3H0zvKtydEcamTlCrftfZKzinYwgC77rdWIq/ybtpDeo1Qc/8tqZk5M
         cIeGhpo5Gch+Y5LHZdgTwGvgxG+BcKm3PQX/31kMwfePMUJbpK9PNswz0ZgSzjp/YYEX
         P2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761797480; x=1762402280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOHF4yRzSI+pLeEyJamn8iNJEDjHjhmR5/cKOdpaYa0=;
        b=bwyaJ6BJHEe0bNay3aiLjiZ1CE/7GnyjeZ9ud1l9drZJTgy3xoZolCB14DOcOQVkjb
         DzHfjiePrX6it3+kC6ftKqUvFMcF3ePnoai4qY9NJqGTLn1q6wmKtBZuNveA/CsSZQ7K
         CKbeR2ItgYeAIXpLruwXaJEBjdVhsvYmoKq0ahOoHiOsaOIATSyBvBEYCRXxhbGUyqws
         gt2Q2zKgdskd3ICRG2EWG997Mo0IDx9K5hB/DEbmuKx855GLqILdkI5JGtJVKxNlQSjE
         FGfDs769Qpr4h5AopS4EEIKtdq59+oo4lt4DRuuAOxsr4s9el2vb2p4rr9vRRFT/NzSb
         W/5w==
X-Forwarded-Encrypted: i=1; AJvYcCXUYbJP0bJa4bCcAYcFHnj+QvyTfE2R9VMLz53NdMMDmKZjwDqwEBXY1FUgVIxisVwSgDwQ20JnYM/EC98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRQwfUiplZ6LCcf/nyeZq5TnI4WAiR+/hxSG+8N7gTG2a/q5Y
	J0c40HJTr35Jf4SCVFYojfHSSkhR2AxnxIlUCea10tx+B2cda13AfTDdqKSbY2OZWJ0hBf6qvnV
	sI7jU
X-Gm-Gg: ASbGnctagfTNWU7WPGiRAaEU7MmcLLoEzXnHsdVpiYOj0pI+0TZnLM/2qXOcxD1IjP2
	UI9+5f2ENQLmSaTYTCUxEFrweDIx5iOU3KQT/cJxkN/hKyvKMa6S6+JgY03OvVSYB9ufNp9dSOD
	auATOUW69jPhK/ZZZQ9WJop17XCpedpXJ6hiHpMw2+0IY6TsQ2JRHNTrQ+JfkC4Zw2yP+JK8OBY
	+NNLL/3UR2/fLyvPBD96VHzq9gCKaamnFGBmU6oWj2DKuWue/HuWbre6GV3k41eSmkQGB6n4oXN
	JengqrbrHa6lH2AQPzNS7ZsDnU6NUh2v1KYXkALYoG8Rr1V3eG5cW3IhwYHIgms4N6UACCjRD+2
	5dnBYIYFmKOKJvUtvsMU+IuVImpE15AZg9AJ4ERTaY5FqFKrSRIXbUYPsaN+OXh2HsoGTrLDyhS
	IENA==
X-Google-Smtp-Source: AGHT+IHDYUaQ5wuoTh+R9kqhNVBSoFU5/rnF4NGTpW+M2cfiF1Fjd2rEX75+a3Vq2Fq7YGx3Gi2ewQ==
X-Received: by 2002:a17:90b:1f8e:b0:33b:ba64:8a2c with SMTP id 98e67ed59e1d1-3403a295ad4mr5980624a91.25.1761797480492;
        Wed, 29 Oct 2025 21:11:20 -0700 (PDT)
Received: from essd ([103.158.43.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050b57a0csm835253a91.10.2025.10.29.21.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:11:19 -0700 (PDT)
Date: Thu, 30 Oct 2025 09:41:14 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Simon Horman <horms@kernel.org>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] isdn: mISDN: hfcsusb: fix memory leak in
 hfcsusb_probe()
Message-ID: <2vx2us6bw6vo2oyhu7dzcg2fesaflxz7ndgif7dvyceu6322wz@2g6pmg4jqyjd>
References: <20251024173458.283837-1-nihaal@cse.iitm.ac.in>
 <aQC333bzOkMNOFAG@horms.kernel.org>
 <f2xnihnjrvh6qqqqtqev6zx47pjhxd5kpgdahibdsgtg7ran2d@z6yerx5rddsr>
 <aQJEkvtfmG-sEA3v@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJEkvtfmG-sEA3v@horms.kernel.org>

On Wed, Oct 29, 2025 at 04:45:06PM +0000, Simon Horman wrote:
> 
> Insist is a strong word. But that is my preference.
> Because even for two allocations this is the preferred style
> for Networking code.

Sure I'll update and send a v2.

