Return-Path: <linux-kernel+bounces-750725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CDDB1604E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E943B88AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2032980AC;
	Wed, 30 Jul 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FiD+E6mi"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F64C62
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878380; cv=none; b=YeME8TYCT+ElxtIAARCnWZ0CiiHyX5FohTryM2zikIK3lakOyUdvSg89mEDlZmx7D4Xl9amzdB3kQ6WH5AssLk/xAcv2mQkq/GM4YVHI3CGn2ciEGzou4u7+GUcZ2Wv0MOaBh4sFZvgUZuwyAt1tLBmEAFa0QbaUcJEvKR4+YrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878380; c=relaxed/simple;
	bh=+LP51TJm8dISaosFKCpGTh4TYAMN3Q+nI+H4aWw5P+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/kAOMM1M9HUGkBbkDwd59kMrffHQfz0gnsE4wXhLxtYqXYlQOlmngYoA8HujEOUsqv1LwgAo8NASpjcCPKGHa61Z8LISsKPAcYlGXsmu51fiG2kN+jUalfHdmomaDmju0qtW/WoS60jAZ4RQdjX9jPVbYlRNmSwfpcrk3AnR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FiD+E6mi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae35f36da9dso1372050466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753878376; x=1754483176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LP51TJm8dISaosFKCpGTh4TYAMN3Q+nI+H4aWw5P+0=;
        b=FiD+E6miVc2QmDKAHSNYy+zSYbj9gf9IFsRvQdWiOxYkUW3CHfYPscxz+PoVWU4l7R
         qeVVTOMgSLvY4oFXEqM63gQUcojbCNzwX0ghvC6hCtWnDdrGQkHmYLaM04oidOKgOHiG
         BOwztpdtra6jyBnLCOLS+N/TVpuWKYf9Iu+NdS3jbK8SVlDUm0TXAoNaCdRNq6BCIvaQ
         uW+2oIc3B7HA2GteQG4aKkrm3ECIDKfP+B2gBdzbmOWoBRAPmiKppCE9DbDGxLI/7voC
         U7DlVzkc1vsXkJyzifJLWsK65xNc9Y4ON/We+2A8Ngv0hSCVMlwWGgyzMVJZWca+BYhH
         NCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753878376; x=1754483176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LP51TJm8dISaosFKCpGTh4TYAMN3Q+nI+H4aWw5P+0=;
        b=QmHHNThGzU4SVgbE/QFmIWFsgehCrfEezxR+SzVWj0hvRuq8iowUfjFxVIsWXbi0L8
         oxtlR8pBkJhE6huaBOIksLQYuMkVZZOvWt00ruC6k2rtcxUx0t2tifksChSEYXPAm1HM
         NXPoBbAjnhB4f7k2E8R5t3D4G4uvdWwt25Ese97nAp6avmLLzJTaF3y2acbJ5dvmd60l
         4RSJY3FPy0k0hwOU6cZfGDzIVqXOZfkaqb+DHiRuVLSp7v/W6waGfJB/JN0oE7blF5D7
         VXmvIPKdxRh8EAgHOoa+6jEynOCe1xD6rj4t0C7MfH4VfKLejMe5czPM9gxCTflael2k
         NZoA==
X-Forwarded-Encrypted: i=1; AJvYcCUiAqf08S7FSEF9uexgk4vZTF0xrazCED4w4FvPo7NIw1/24NsMnerWpIOKRQ3B7kQG13Xh8GNUMUr+owU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZWaIW+xWYfLDPanVG1SlcSjJXYJ2rMKKcLWdd3tQxxP0cUICv
	JCbISc7LzorYrKeylAe3KxxNdKmPRDM3Jdrqx1MTBcbAezxzjMvu9WfYB8Gl9BYQGcY=
X-Gm-Gg: ASbGnct7gQQpeZVa98T4g2BaaWFph3oJy17zfXgujTejENRqWWI1SPmp+zRzdV2L+ks
	c0FwQAc0qvTi790v81Do9uoERpfMcdmeQb57Pst84X9hEYWBlChCUwbmWGKVUF7jorWxBDoEozi
	9rL5Y0D+y2NHyB8traFurFCfLyd5ld3+GM2EItbQNEjB/HkQe92QpAw71q9Z49ys0rxp24K2+gG
	+aNozb6Sdw3P8Mxe0c3ozDEAtD0hwucptTNRrI27SzwXCY6ggjLZ4WpGPchRhvrF8D/rnXAkht0
	WhJYi8apAyz10nhmasVn6aFtauSKpi1ImHVXcPy0RmckKmayj9TjXZaY8kNzvpoK3W4SKzUjcGX
	6+CCbAkTetiKrziV+NO5RE0j69GGK0OJebg==
X-Google-Smtp-Source: AGHT+IHKmQuJBcyurJqjso+EQtT2hv+uRozjr/hSsB9kfXnfZX4KNBg+3NUqbOWeTkLYA6c562pzyA==
X-Received: by 2002:a17:907:e849:b0:ae3:7b53:31bd with SMTP id a640c23a62f3a-af8fd97316emr411726166b.28.1753878376235;
        Wed, 30 Jul 2025 05:26:16 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63586008dsm741418566b.16.2025.07.30.05.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 05:26:15 -0700 (PDT)
Date: Wed, 30 Jul 2025 14:26:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, almasrymina@google.com, 
	asml.silence@gmail.com, leitao@debian.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] net: add net-device TX clock source selection
 framework
Message-ID: <p4tnkuf3zh7ja45d4y2pas6fj6epbqdqdqtfai2vmyul3n43lf@v3e5dvvbphiv>
References: <20250729104528.1984928-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729104528.1984928-1-arkadiusz.kubalewski@intel.com>

Tue, Jul 29, 2025 at 12:45:28PM +0200, arkadiusz.kubalewski@intel.com wrote:

[...]

>User interface:
>- Read /sys/class/net/<device>/tx_clk/<clock_name> to get status (0/1)
>- Write "1" to switch to that clock source

I wonder, if someone invented a time machine and sent me back to 2005...

[...]

