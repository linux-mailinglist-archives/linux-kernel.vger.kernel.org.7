Return-Path: <linux-kernel+bounces-848526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C6BCDF6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3BF54EAB22
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7784E266B52;
	Fri, 10 Oct 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UazpeJin"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C494259CA0
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113872; cv=none; b=cRoCDiNbVIq7cLGt5L4Dj16Q/9pyWHS5m7Q3s0SOt2Juh3/xp8YfMDXdFovaPbOraFTXIX+hpsSOBqF26L8WZOyKrHALGpf2cMZiDbtaoeRcnqRua/8tk9Tu6FnsAYdbzeWs3e7eM70zLr2aQPPuAyRG7xLHvoYDMPgqiuujyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113872; c=relaxed/simple;
	bh=sWau8pOuRYNhtAxbaAcaiNz5CW5zfAxPFLtnnDYBKqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3HuqTHyLDzg50zelNfDVYOAr27NePEkOyIwy1UvZpFa0dt6XB6osF/lsT9r98TTOg9b/JTgd8066MLtebHRtIM71ZB8yEEyEgZ3w9SrvLDdVPsSyMh9YPGst+Stx80Ox98lG2g6hsNbgyNP9IsLcucKOFP8p3EYAICKmTerpgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UazpeJin; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3322e63602eso3151972a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760113870; x=1760718670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PErgUidAcsRKwUXeMVve1SYZIwtC3TkFLkv19Pikhc=;
        b=UazpeJinkjHVb5yWVeizpYYLLDLBC8b/0NuRrhVedtVEdaup4WWGY/9iWfE9Y9ygrc
         pH2j/F1dFIO/wLpHyiTxKJJeA4kNjLtTy4g0BfLb1N358S8r5pLVjvND/kb7cdafspo2
         rRcmQZYnjCEAQSzE6jdNPPgX4WrYKDh/kj4Gi8pe5Ky/E1iPvqbAxCh2cJb/1JPPWyXU
         PVTb3CkstrYC1qsMM/SjlrbK/uTDzQCZnTEFYLoMwSnUUA27EKs6oTvP0NiOZLJ3hXp3
         7hPkhA+RYDPe/UdnuORJqlnAWFU6r4bkY54wt9yNVDrMnoC4cmtpi6bgjc0T51dXdGU4
         Tj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760113870; x=1760718670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PErgUidAcsRKwUXeMVve1SYZIwtC3TkFLkv19Pikhc=;
        b=BP6DYxi60sgV0nMnStKlt9LwGU/WE8bjwR6O0Emed04NZeeidg6vjLke308N4znD/f
         TUxNZZtx+4kInsrJ9AjbrjDkmX+ReJNEuOxFlv0l+UZ25lJDyWPAOOU1BZ4jXbIgWKOk
         HJhaSwkw5biiOUHmXwzBt28uYpTuark/fMDvvOUJX6JVjXl5QszIJHkO3VukMrLhYgLK
         yvxYMTXXv9JZKZeECP4yPjNGrDUN1Nvs2C19ulCLBxDTiL8Gnqh99lczgoZKud+24EOR
         Dr0VWa6Zb57byIxslYk8JmKp4SMVQmLGQxyCHCz8XqvChIuz9o/CgDYRWYowov+sfzlz
         R8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWcAUzGUYB4lzlQqYZbxz8l+Usda5G7aOe2Scv4xr4SacCO0BaiaqQUT+ykx8eJey6kRVCsKDRfxA4sh7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4IJbQOvs5OZ4vGSoSQaT81qU/XNKZV3uJNEiYD8LWQu6oTbd
	nOSkP4x8JDN25+dty3ZhwGdMklUp/3545vqM7QQ4Y4lljzARxdjzaw05s4n50cE2O+EfkwxX081
	NwVisW9k=
X-Gm-Gg: ASbGncukC2pIJhp4GWELhwtBMSZ1mEsbqKNZe6TjJbJEsC8i9QN453bpy3ehFQuBmL9
	PXdG1SoJNi7WVfoK/WFKaVzjdNPIPYXJEZkug4WtDhnbT+ogPnHtDk8XiM8uz7G3gG27CQQ2Qq/
	wPc0vMyT10sCa8R6C1i4sLsmGgxPXIb0+FlE1qiyqo8ENnhwbVJl1U0EcOBtqFbUyNBom7aHz81
	7C/GJ3jfYudQYjFBjs9X/F6XA9st2p71cZ0I71zRcbpmc6Xt1CFm8d7oTgyxQ1woC5Y4lcWoLKv
	+q22cdO1b1kx9Lf/FavPediNj9nPI0BTSZOSKyfT+SOiudo/J1/2CEDLPsgPYtYl5a9s2Hb9HTz
	pJbUo+50SxRB2ersb5ELZE7j7kxrboAwDU29Di89a9cfZLdo=
X-Google-Smtp-Source: AGHT+IEy8L6TDg54FExTrOyXceAe8pz/QOf459ho/0ZYB36VftdLiczXdkNEiG5CFEJM6POervy4bQ==
X-Received: by 2002:a17:902:fc46:b0:27e:ef12:6e94 with SMTP id d9443c01a7336-29027418f97mr152883735ad.55.1760113870428;
        Fri, 10 Oct 2025 09:31:10 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ad30:d3d9:45c5:4a3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f9bbsm61182205ad.121.2025.10.10.09.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 09:31:09 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:31:07 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v3 3/4] gpio: imx-rpmsg: add imx-rpmsg GPIO driver
Message-ID: <aOk0y8xTi9hoGvyX@p14s>
References: <20251009222716.394806-1-shenwei.wang@nxp.com>
 <20251009222716.394806-4-shenwei.wang@nxp.com>
 <eb99d9a8-eb96-445d-899a-6e1d9b6f6c69@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb99d9a8-eb96-445d-899a-6e1d9b6f6c69@lunn.ch>

On Fri, Oct 10, 2025 at 12:58:38AM +0200, Andrew Lunn wrote:
> On Thu, Oct 09, 2025 at 05:27:15PM -0500, Shenwei Wang wrote:
> > On i.MX SoCs, the system may include two processors:
> > 	- An MCU running an RTOS
> > 	- An MPU running Linux
> > 
> > These processors communicate via the RPMSG protocol.
> > The driver implements the standard GPIO interface, allowing
> > the Linux side to control GPIO controllers which reside in
> > the remote processor via RPMSG protocol.
> 
> I've not seen the discussion on earlier versions of this patchset, so
> i might be asking something already asked and answered. Sorry if i am.
> 
> Is there anything IMX specific in here? This appears to be the first
> RPMSG GPIO driver. Do we have the opportunity here to define a
> protocol for all future RPMSG GPIO drivers, which any/all vendors
> should follow, so we don't have lots of different implementations of
> basically they same thing? So this would become gpio-rpmsg.c and a
> Document somewhere describing the protocol?
>

I haven't looked at this patchset yet but I think Andrew's proposal has merit.
 
> 	Andrew

