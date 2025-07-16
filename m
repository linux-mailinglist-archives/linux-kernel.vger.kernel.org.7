Return-Path: <linux-kernel+bounces-733735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F9B07861
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B984E752C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C8D2638BA;
	Wed, 16 Jul 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L04L6scV"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370522ACEF;
	Wed, 16 Jul 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677019; cv=none; b=YItuqiP68eGe3fSSGGRAhjAihFNkY6ozxoQagUqFQD07vUu+DakcABcIHP2OVBh+XxCyhQiNe35sRCyZBRDo6LXmsizR1YpfPrdDp6rUP8+N4SG1LCsL8wxy+aBsUK8X2MLgq5UyKusqecNtRhJHobR4m5Yq2G9cdAUPmCu5AKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677019; c=relaxed/simple;
	bh=+j25Alm/d9KYRiU45R71lnDHfAzIEe0k3PA825ih2BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZb4iCLnBI95m7oqqcd+zu1hrOwmlLXGMne2QoZ06OU//7rxKVk9bjeVVlGPf/O3rFLx4XCc3BosVlxhlC9sN/y4pIjtP4Pie8JEO+Ic2uxOyPSWpjmFOI3Ejfxd/1dUWtmH4/rnK7S6LHqfj5UUX8WgBPmhoBO7DXnh6oo1lWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L04L6scV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso391a91.1;
        Wed, 16 Jul 2025 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677018; x=1753281818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1D/MA9g6qDhyF3gQXLdnvWOkNeUxCLAqVO0todp7kQ=;
        b=L04L6scV7GGDT5h07dEKWoGGyIY7z7/7/rqLrbnMXapyIeKWDTg9V78SBvHJ1q0imv
         U86h58H/DBLuvdIYxJldQKCK1bK6Gxda1BWOYX73zx7KojYs5VId1POemIO1J0DA3MHd
         w3gJsVWOsZdfkx2DjRtB62+Z4s85rrGlq4Ry5M2G/5bq6Q/OUD6rCB1r/XaKKdxU4qqv
         BvtT9kN4mMvH/jH+yoUeDbHoHxq5XNj2Nfhvo0MG3sjapAaifHpcFWAR/l5TEhYlc3EV
         RegSA7d3/xChQ5V2ZvvzUEUI5u2yCky7Tn4VUdskBUb1xTA9wy/5WfC2vl6MRXAUsc1I
         fJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677018; x=1753281818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1D/MA9g6qDhyF3gQXLdnvWOkNeUxCLAqVO0todp7kQ=;
        b=EDK+X8kLeWKJf415RRtvpXCQDEDrQ2zwt6LLTqM15D51RmREpwLgMq/Sh0S0ZPoOC3
         3Gve9OmYKh0mqGUp9xLn/Eqj7WXH0iLy0pdlxt+sar8+jOGxB/JUkunGL1lZ5wJxR3yG
         Ore+FplRp6n/WrWt447uWssrJbTzfn3UjgknBZgTtJ9mEQiqJxju/u49r6vLA7aCzf+w
         0MqgiKQCKt8PuSylED4KaSxkjKDBQKQNikQdZHN35a6GwklKv74Zp9YPhr2eZ2pikg3W
         +m+6S/UEyXdPGAuj+PIWpVeysAu1DxmhPlF7BgLZtSXiyhRdYPPcim74+LnFDwDe68nc
         p98A==
X-Forwarded-Encrypted: i=1; AJvYcCUKMK4D/3ZXECLkXRvXR9S0iTzSzyEEL/rPQgOaXd7jSJyo+/XR6WYfpagp8dnYV2Uwpquo+cB6j1dd@vger.kernel.org, AJvYcCUr7kelyR25QYmod1zP6NDJt5xSBpVquQCNzZR/Vwpfru7VydbeLyy9mMAS7GH/8irq52P/sy+4K8WABiqK@vger.kernel.org, AJvYcCUtbpozZntYFlo+xC32qucBpDwFhxqK6dyJomqkrS2bQs1Op6L3x9ogEUx+uRRzr+/AMQA3Ce3cBKvtVFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2p4PoTq5UGmHmzxNqt79vUDqn5qvPTHDgsgi8TJPT/YAH5kNQ
	KhD0Flw9iyJCgziqI0D2zX/Bxf+bIy9EjeY8gtdre7prTKIwq6aFrc2J
X-Gm-Gg: ASbGncsDJ7IihocP1orvxw0SwvuJWobjoazTWP2et1FsfuDiKz6nF3WQ0bV14165Qah
	QGu4+VRzgSibytwEKIQP04AYaMSXZ+VIwOgVZWiz8kpcjCl5VWhSOq/48o72TOJX8YxKInm9kQN
	+/8BcZRwjiD1hsZFsosfNxlR7abT+slnLLmh7jaM67PCPK/upQihY6MB3wk3Y2ZHGl6QgEs1itS
	Kxpvew52MrCt3rY+YXaXPQs8V38sZw8b+f6LFL9Va4GS2poNgoP2CFEZIFuQLAWysbWgeQJlSLY
	l0KC5R+keQZqLbpjZ3UF4pUzU8lJvn28dJw/k/9CXH3bGYyZ2sjLlT6/8ePuIAm8feu9CfuS8r6
	Lz4PbC8p8qaWHwyLWEvBvSNOdIKn/h6EeHrc=
X-Google-Smtp-Source: AGHT+IG1UjM/txEIclV5CCk8y5VlxAPB66Y3gZKDOkYoJGvqj53U5vxm+mX/WpfiPQM/xssCqwd23w==
X-Received: by 2002:a17:90b:3c84:b0:313:dcf4:37bc with SMTP id 98e67ed59e1d1-31c9f4e0ff5mr4261313a91.34.1752677017500;
        Wed, 16 Jul 2025 07:43:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1fd8f8sm1525010a91.29.2025.07.16.07.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:43:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:43:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jim Wright <wrightj@linux.vnet.ibm.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: hwmon: maxim,max20730: Add
 maxim,max20710 compatible
Message-ID: <06b7a7d0-53ff-4f3e-8497-152fd84e6470@roeck-us.net>
References: <20250701-dt-hwmon-compatibles-v1-0-ad99e65cf11b@kernel.org>
 <20250701-dt-hwmon-compatibles-v1-4-ad99e65cf11b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-dt-hwmon-compatibles-v1-4-ad99e65cf11b@kernel.org>

On Tue, Jul 01, 2025 at 04:00:43PM -0500, Rob Herring (Arm) wrote:
> The maxim,max20710 compatible is already in use. Add it to the
> maxim,max20730 binding as the device appears to be similar.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

