Return-Path: <linux-kernel+bounces-790424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C5B3A6FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0D27AA56E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F5D322DD1;
	Thu, 28 Aug 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+6OGS0l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0D239591
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400015; cv=none; b=azpIbqVRv+y8OjaDIY+JNhPEwXyyFRm/CPCiStfVr9IYSNN3PpKvSq03jkR/epKQZbtMa/b0UL0khFxrhpKfsdViCui7fTmoeoogH7ODmprirtxIEPjU2u8e+NgWrXGlHRuHR1to3s8jgZHT9Vs+OdEm4nCft6TTFu6FdNZ4+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400015; c=relaxed/simple;
	bh=sdthemhZBx84Skd5So8//igws6ESFRah4kMlqpHa/18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT1Niz0FKKgOw4OPGTNnKiEf0Btiiou1mMJi/bSFoWeTbqzvwEk8g/fWDE2W54paBvgHa13Qd0/jqx3PiuQLR5FAcO4Y6J6MyGmXjvzpZSKtSpWzEeruRyMvKeASaF3+8fLNbHYSEyYBgCtUnxehA93iruPpGWDAm1SSXSYfies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+6OGS0l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756400012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJklgM7Ntm5BMtyc/cSU8HBd9g8djuSELpTKH6fZV4k=;
	b=i+6OGS0lKSujK9oKhLS1GI6npiZcCBMuXaro8SpUeCUc1NkrrI1t1UUR4uNLs2MkFtAmTy
	caAIEpK82PRSSM/0JROfWxtwhhtERPMhaGXEvFcKBRxqWrqxpumRHvj02jUTXlgAOG+hE7
	vqLR2tvd0KOQ5G08uzHFZnsdIrY2Tu4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-6gQWFEgDOku7hlTBVt2qJg-1; Thu, 28 Aug 2025 12:53:31 -0400
X-MC-Unique: 6gQWFEgDOku7hlTBVt2qJg-1
X-Mimecast-MFC-AGG-ID: 6gQWFEgDOku7hlTBVt2qJg_1756400011
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7fa717ff66bso190201085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400010; x=1757004810;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJklgM7Ntm5BMtyc/cSU8HBd9g8djuSELpTKH6fZV4k=;
        b=X/mmYm22XyYN490fZIAFGQL5AzVmQ3mtbMK2CeMoH/ki1n38O7aFeIiDd6EsXsVl3H
         t3fbCViyshmB72A+r9h+maxhGPIuNmLT8XLZybobjVZle3OpoXsFepTz2sKCElz8a6tV
         aQlWDiaUUr/lXVVkQwd3zE0e/hzGBfqkvyYGJXFMAzTSFNCMkfe8QPmGCeDeJy+74uqR
         IYqKQsfYJsc2Cu+AiS+3MJMCNzpwhG91WAvy9IKlpOLZlIQBXtfeEhVs0p2GWAuzLgsH
         nt00gLKygySVU7mZ/nkp7oXVTiS1Xv4T4/d0uC5BoYvwPErwr/0QUxFo7iFyFP3FIp10
         VwXg==
X-Forwarded-Encrypted: i=1; AJvYcCULx5WOdx3yH36apyKi4syOu9qz8OsyhjG47edMlCzJcRX8UCpxCRZP4/HE/rGoCrFFr6F4wIRcud3rtGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jg8L+er97th75gRDfXkba37KQvbatcupEj6TXlCfoMLeYDsP
	Wwz4PH3Cvv51x33zO0sDh2Wu8ma3UygfK7E+K5M0lvR4XFF2otwXuNEugG09FGeQgbRiYLvaImJ
	L1a3Nlt/Knn4r+0vbMEeT9OB/ArZC3E+ge2ZhtIsWq1eSjhdUJqNQg11m1kVkmNRkjA==
X-Gm-Gg: ASbGncs5aU+3ZURnnuh22/e3m8FsKqiHrDrQvqdvIhMpBFwexOyqCw0CFtb2J179AAN
	h9Fgv7iBS7Gl4ubWPwqiU63AKnhGKPhCDI/VFbK62/wWURMes0MxxI0l9LzE+DS0RuXcnM40aUP
	b5hiPoGyv5putlthgYcFjlkfUIsYCxrQx99lb2uYhiUcLuWK/OQ4VZ3WSXqLmv8DboSef0CnG/G
	iT40nd+SpW9Qz3ppHma/yIeWHmw+LxKp1KmYehnpH2jzIIAheurQb33L1jXiT34p7b0E+1mmo8J
	eHbdCv2QzdCmzt2kdYI5ZZRIXdKxWPYh2tfMB4ZTSPsv1Rc1pg932vMW3ET5EtnCQtVFg++jJ7d
	/zW+g7138XN+/PAPQdSE=
X-Received: by 2002:a05:620a:1a0f:b0:7f3:d274:a318 with SMTP id af79cd13be357-7f3d274a41cmr1467899185a.45.1756400010719;
        Thu, 28 Aug 2025 09:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmWvmcBXzR5JVgeu8M2Tdex9HOUc2fcKiwnULMHR1EAqpd8F04fKPVsKpKvSeoVzTgNpi7Yg==
X-Received: by 2002:a05:620a:1a0f:b0:7f3:d274:a318 with SMTP id af79cd13be357-7f3d274a41cmr1467896485a.45.1756400010374;
        Thu, 28 Aug 2025 09:53:30 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1484a7a8sm12294685a.43.2025.08.28.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:53:29 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:53:27 -0400
From: Brian Masney <bmasney@redhat.com>
To: Ryan.Wanner@microchip.com
Cc: mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v3 02/32] clk: at91: pmc: Move macro to header file
Message-ID: <aLCJh_tDnTl83Vtg@x1>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <6776f06473d3be71882ef938a4314947f565e26f.1752176711.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6776f06473d3be71882ef938a4314947f565e26f.1752176711.git.Ryan.Wanner@microchip.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Jul 10, 2025 at 01:06:55PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Move this macro to the header file as it is used by more than one driver
> file.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


