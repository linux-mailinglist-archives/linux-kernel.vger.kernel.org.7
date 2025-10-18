Return-Path: <linux-kernel+bounces-859016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B530ABEC7BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1254E8C62
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD4323C513;
	Sat, 18 Oct 2025 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRjtxvm1"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95719155389
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 04:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762667; cv=none; b=fmZnCG8PKk/YPu6xq+V8iJT7LMjyFc3+gEWjae29Mdjo7mr6fGruP+PTIt6TDMREFK6B//BMrTtysg1Wv2k6jmGJuWGMMri8xZF/obPCBN0/rin/05Tm3fab2o9UVH/44pF6mWclYfab5hAJF/a9rbiTMdh//vyw99PK/sxQ8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762667; c=relaxed/simple;
	bh=zgIRzuUwDzGeV5kGKxjvmikUrn9RTJaSbDu/EBvWMjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xozpv2L7XyAfam9v5uozPFAqxvKZoJvhhgpegWu35Xj+U1J9r6u1zkTQsiKH+V0pbLbaDCXbLUPUgNfq9YHgK1bEvBHZAA6SwkYD+P+OGA74BwsKvLbt0ga0X/pQjV5uiQtrWAcSC4ne8oxFNG1V9/rDtf6P0X1el4I5PlXcR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRjtxvm1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290cd62acc3so19525525ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760762666; x=1761367466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuILH4c7j8uvSEqVjgWyUNFQrtvem938kCvyRi5rc+c=;
        b=bRjtxvm16Qgcx6DyKv4JBN28U9QXYvWXM+iTNSdog4oaqNb6DWaY0cqXxT88gp+wMJ
         hCmkfCnJqC31U7J++XStfpYWrMIfeEUvcAgUODaoJkvJSqA+otrozqfb6sBZ1I1HhoJa
         gT0SF+O7VM3aP8f31C5wVoxkeGxaLy54i8WtR9MQi9lGqFL7LRmO2IIsP+WxaHkt/4mH
         QizGfDEpqaMuUd84ZB0Em21AxdXYJtvT5GxkOeqntcE2LQJdrMhoGwhxtGXV8f5u9RYi
         PAhJmZuqic7PetCjbv76N6CJguVpAG8APMO3UMR+03A8DMYGYq+jY8ARPFUxtMFQJKf8
         0ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760762666; x=1761367466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuILH4c7j8uvSEqVjgWyUNFQrtvem938kCvyRi5rc+c=;
        b=cyl/uHBYVgeObX64cSFjmzrtObIybNIgHlrRJKtZVjSP6/BmQJw/4XxzKnvf0Z5wLq
         LpNnCkhpI6H7GbudRJtygH2dmCwvjVE++0S714tQcK4hO9I35lYTqbtxrS2UNWpbnidQ
         AIyaiOuxO1KwODvWjDdQs+jSxUQdWBZPugA4y12rwI87A3EP7ibO5K9u1mO3ZqOrQD9b
         fOVBFiQoT1e69sMKcBWVw/dD7CZSDNumTlKkZuI3UwCgSKXvTVIw/0SnngIhwTMQf/yj
         fhQpMdcMTQ6bLbFb/cvLO8madfbibzBomxh7xveQxEASpSsQ+dZ84VYtJObx0UMlR/6J
         GWTg==
X-Forwarded-Encrypted: i=1; AJvYcCVfSONsP0fc9fkWCgPYD5zciKaDSS1qk+7nlQSV93yVAGw26d9XZVf9F2kPmok81NVE2KFRG7H2fA9texE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjYrrk5zBhhKUYQk5fsRGCH7yy9TGqV5W+YFgy6pgMVrRKFXh
	/X5C2KCv4dhYAOITTzOTK0jz79XuYG4//DcO7TP/F1WY0FVlaaB+zV76
X-Gm-Gg: ASbGncsi6zErMcmLX+Vw9/ChqSUJrruGT9OQhS7z/Of7i0//XPXQkrWhtUfGeKsF2ff
	ffjp7ZrpZ4+EUbOkbbwpblyt/31kg7tOIeMzGAlQ3fg40XHXnTul4hsVR4XS6g1gTZ0WrD0DSqY
	WALaHOLcmOmp2nmX8xDz4UBec4Clj8nr65J3sli3O8UcGMJn4UJG2Ctb0J/nV6tDEzs8yAKgw54
	TYY2gDWC8EmhtyR4Wn0eXAkFJ0ThAOgSJQjuE+nSIkSjqsBZwEYrkikrbRz4/QHJkaAtZLimM+O
	ffe/fa+4KVsW/BXfi9n4l0k1+Kxpk6pp4uRA3g20uzftdO1NgWIBg9tQ3XHN1NpmsxlYl48B5MT
	4VfWE1DzTHUFIO3GFRD/eRy28FNJeqJpmQXwHG0UZcMFUqm6Gfr6UA6C3FL50E6LTkX5DM8PqH6
	2CTgmHEurYTJwU33Izvi/Gtsc8OBbPAOuXseJG5sw19KvcFAKRHog=
X-Google-Smtp-Source: AGHT+IEsreobuN+rTRpyEDgvOSmHbZIJ9FhttENFg1rytWVj5SG3+BeLHeuRVjMn2qy9jnjk61l2gA==
X-Received: by 2002:a17:903:b4f:b0:25b:a5fc:8664 with SMTP id d9443c01a7336-290cbe2c382mr51666355ad.51.1760762665736;
        Fri, 17 Oct 2025 21:44:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5e2d:c6df:afce:809b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcf06sm12742835ad.24.2025.10.17.21.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 21:44:25 -0700 (PDT)
Date: Fri, 17 Oct 2025 21:44:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Heiko Stuebner <heiko@sntech.de>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Input: Remove dev_err_probe() if error is -ENOMEM
Message-ID: <aqm2v3527whfx4mttsrebm36wuexux2ufssignjdt5wkhwocrk@ynzhqww4aul3>
References: <20250822034751.244248-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822034751.244248-1-zhao.xichao@vivo.com>

On Fri, Aug 22, 2025 at 11:47:47AM +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.

Adjusted the subjects and applied the lot, thank you.

Thanks.

-- 
Dmitry

