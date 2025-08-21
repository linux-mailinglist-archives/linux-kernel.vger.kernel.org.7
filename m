Return-Path: <linux-kernel+bounces-780464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC41B30228
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADAF60797F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D952305E26;
	Thu, 21 Aug 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdSAEXpa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECF31813A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801281; cv=none; b=jdXkHT3XzmlQXPGlFXExQif67o/VxiRFfaXR+XW7fbEvdz8+z8dts892+h16EeAXIAch2T5udEkhnxDkjPV44aezwTTypUpEpjX/ckvnwRn/BQXxkt0bc6V+xGSmxhSvbWJHxqSg9QCplOZs4h578ry1ZsIWqbmIja5hDktFsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801281; c=relaxed/simple;
	bh=XcXSdUzKD1mwXL/9Can636iXduhuHzRkLnWqXVqBSRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdOlYvdxb0y2uzs4u5O3G6F3EWjBcY2pJvtYYFZlOIk+sEsTycqzMPPQBwO3VzbbYFMlOZjVKACtPjcD9VRhM1BGYStnAKFnxIhZRWHBGRkBVYRcIkCze5VdkXnA3KFI00W+p6oUdwbhubW6kabnlzWOFV8tWtj3VOPTA0ncMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdSAEXpa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755801279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8IdtsQzzrEsnVQCR1m8AsOo08J6mLd4OylRDhAWo4nw=;
	b=JdSAEXpaFGZ/sTErFkF3PSMmCQEM9xibsz8uyiLJrXb6+ZMdVrp1QFe0yVayR18sEjxCTy
	Sw7bpsRUaHZX005KN2El57czkJKIJGdKLBsZzarJ1tzgF03fL+CxOYKay0MADu3gkTjFFU
	jVLfuEwwQWb7e34pXrdIUI6TNvze8Tc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-cw1S2O-QNBOySDE6n1Zt7Q-1; Thu, 21 Aug 2025 14:34:38 -0400
X-MC-Unique: cw1S2O-QNBOySDE6n1Zt7Q-1
X-Mimecast-MFC-AGG-ID: cw1S2O-QNBOySDE6n1Zt7Q_1755801277
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9384d33aso13645806d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755801277; x=1756406077;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IdtsQzzrEsnVQCR1m8AsOo08J6mLd4OylRDhAWo4nw=;
        b=JYl+Prn1rnZf5rbysK+gKwHTOEQi/MiosCSiuzjYNzu2aPebHNNMBecWubLVjabqs9
         LvUXnjsxi8riUnAqhRnyOZff74udWi3Aavmzf8Y6f9TycBBJpO/JUJYeFDsgrTDMZ1sN
         RhyG5nsgl12sKu7ck+RaEP5bJ7dflXkYsI9hvXAUeWtrWd+gq3qlEIxgtPi6Fnr8X3dL
         V1twK607q/ikpD+b/4ZxmlIVAe9PXlKnKUwFtmXaGsrFJXfVJ2KO1ywco4slxq+wdK+r
         Wrdntya2ZvSxDiFQ6AwuhvX2dZ0EVMFe2OzbiDyGvWXvwFtsir/Y+GOdhefkLWnyhpJl
         +LyA==
X-Forwarded-Encrypted: i=1; AJvYcCVq9p5n/1f0l5f9Hjwd7W0GHS+f0aY9DovDyquXlYTHBvYGTBGwLi5TpxyGcnPzu02GjfGBi57Sjomf5NM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+R5ZsJu1mk+SyEMSMc7KiXPcVSUYp8ACWt4nLL/fvxmbju+m
	dfBKb3fp+n8HVVPT7xMb/GxXOAbRg3q9BOC26URUqzP9pDDVG9x0HSxRwhrw/mDjXChDpyPTEgY
	4UFj9spoOBHQdaXMcw9JORuXTBnyGX4NLIhdMU1k55sOFmGwE3HrZrvxq74/DRymCjA==
X-Gm-Gg: ASbGncuk7Ooc358Ms4iuw2l32g4BQG955uTRW8YmHbYACky2xVbdC9EDjEr6SXcnMoO
	J3xCMgbii1ur7aZy/BNbrswLFaphRzO5Iu6XVk5j93li+0IkMLoL+2uWKOyDRgvl4H31NLOtOyN
	cYJ/Q3CpvtVzug50W24bWfx2swvUfvbpjSkUMIF+tLlzM/h+MwaDvrw2VG+/K9o3+OErta6hgyk
	56rcYMet9Ge+ZIjQEmVuXltba4f0dGnb0aBBqkuDDSUFrr3+2DvNg6Xh4b3G5I3b1YPXGtJ7TQw
	hxy8DhbxMOQRIBh/0+cQnX1XtXVxdCBzY7aYwBx+Olosk98gnb2vn2v+VCVchSg=
X-Received: by 2002:a05:6214:627:b0:70d:86ab:6f95 with SMTP id 6a1803df08f44-70d9738f7f7mr6593456d6.36.1755801277407;
        Thu, 21 Aug 2025 11:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGhBCfL4CK1vaEmXkCImS1C3Q00vXihd0Pi1g9BmtPkaC8+Yz1YnsuRpshrKZpYpvvdxsepA==
X-Received: by 2002:a05:6214:627:b0:70d:86ab:6f95 with SMTP id 6a1803df08f44-70d9738f7f7mr6593076d6.36.1755801276990;
        Thu, 21 Aug 2025 11:34:36 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba937390dsm110337596d6.60.2025.08.21.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:34:36 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:34:34 -0400
From: Brian Masney <bmasney@redhat.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	willmcvicker@google.com, kernel-team@android.com
Subject: Re: [PATCH 3/3] clk: samsung: add Exynos ACPM clock driver
Message-ID: <aKdmurrT1pFtLSI8@x1>
References: <20250819-acpm-clk-v1-0-6bbd97474671@linaro.org>
 <20250819-acpm-clk-v1-3-6bbd97474671@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-acpm-clk-v1-3-6bbd97474671@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Tudor,

On Tue, Aug 19, 2025 at 11:45:38AM +0000, Tudor Ambarus wrote:
> +static long acpm_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *parent_rate)
> +{
> +	/*
> +	 * We can't figure out what rate it will be, so just return the
> +	 * rate back to the caller. acpm_clk_recalc_rate() will be called
> +	 * after the rate is set and we'll know what rate the clock is
> +	 * running at then.
> +	 */
> +	return rate;
> +}

...

> +
> +static const struct clk_ops acpm_clk_ops = {
> +	.recalc_rate = acpm_clk_recalc_rate,
> +	.round_rate = acpm_clk_round_rate,
> +	.set_rate = acpm_clk_set_rate,
> +};

The round_rate clk op is deprecated. Please convert this over to use
determine_rate.

Brian


