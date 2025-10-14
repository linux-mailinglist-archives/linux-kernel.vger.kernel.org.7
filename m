Return-Path: <linux-kernel+bounces-852352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE4BD8BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26471924791
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5672FA0DF;
	Tue, 14 Oct 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZC3gkKSE"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C62FAC1D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437418; cv=none; b=oP5u8d2K9UwE+S+FPhPPvTF2uAnMbSCxLwCKZ3WxctJS5RG3uD6AgPVWhsBIZhEO3bQTvHQnRITKg8WIb6tMvwK8i5BuPoNOxhjGcJccXQU1+9upCTNJeC1ZYlHxO3tka+aHoSsLIO/ogOp5QE9N1Q90onF/HxBZRnbepYil/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437418; c=relaxed/simple;
	bh=F7iiiWJil8lr5Lg9OzDGeEMXA53iTr+8fK8leVqtgTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbzaFyVrV+kxeSckbBPmMiRn73eMjyi5O6WWMCoCAFWo2u8+EASp9Y/kIyxEFOgIE67U7nD0FJYBqNBD9zz/5Z0s6GKkKzpNPXHGcL7psa5QDbDOpowUgutflfKFHjZOwgJUncRaShYIUYUcZ4RmrGxwLnfPsIS4TfljMctjZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZC3gkKSE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7811a02316bso3612284b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760437416; x=1761042216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvbagg2IA/uXkd0ZT7M7sfHL3n1Y94M8PIPHMNkPsa8=;
        b=ZC3gkKSETaikfQDjJqShfBhmNClkRR0Zegvauv27h7UUWm1O3jYeQQF6O/Def66212
         jihxKVyINcs+VguybUsd+O1UF/GmzodogA/v0ToBUpG4rN8Fv9Pa1YeaSR2TN2pgaIUH
         jglbEweCEzG+AV+uukz9KpuNPoZUhw5xsZACc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437416; x=1761042216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvbagg2IA/uXkd0ZT7M7sfHL3n1Y94M8PIPHMNkPsa8=;
        b=HejNsYriiwl6IlUAicGA6etuw9JFRdK42w/Am+zU7iNL+NNONKuMTo3w3lQLq7m4Ni
         k3DDisFcz2psXERBbUNsRWHbG/V8mKgrpJR3p0xnA1hBD9zP2SASdN2MTzeQnl2v43TA
         YCjgIZcyfOYiiMZV5faqsfoNC/h5vBY8pQsgi+1MMPQz6zQp62Xr5rCDHIvf/zt28E04
         4YYR2taKQfSBywo+HbCPR2bYTDpxzbzUUNVVMMQW4VRJUkFdva4+VlpCLzMlCVkSzgXa
         Zn/nlIEWlQ8FfQeVnVq/i4jFEnCzTo/H7MzG/YnwM/WpbzB9td6nmE/wScTy7wYfLb3b
         dJXg==
X-Forwarded-Encrypted: i=1; AJvYcCVK2iUbHyrnrqoW43rIMLD4xyAeUeANGhoKOHStx7xYaIyoGxGgvWq05GiIOcd/IgqTyRejw3kAl3j0duU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qQbkLV3eVhIqOME+ur2K4z4NHsHZD4AYG6YIhWbEFeKmQujM
	BNYps1Dnxn4RIQS6ewDAx/ddo7Q2LLqQdrgTcjopHNtxW6jUJdX/0t1x5gYJ5TfeBA==
X-Gm-Gg: ASbGnctBCVgAIOeSFqaZQArvfznQ0fc+XRjLoxRNCdaH1SNxCD+sPTlLrjYVOAsQe6f
	v8INse3q7rZCR9qTNGFBI0OSRmD+gpd4kMhgipQDDl1p3uLBS/OSpsV233+s4KwavtKNSM0fFZH
	FQ4zd0bIZOffchH/sub/N59W8fmc1XQiUnNs2Kpx7femPgE3MYbwaVzM2lbwo22dojAqj0rTXuO
	J6bk3v1E0lGS8yWxBlBXAGxjMPa5wrDXKcqaVvQQUKs3QCEC+qKCt285s8p4LCAgAkK/r+eAnMJ
	nOt8ic2eNdmpSoZzBHRz/mmZVclxlgISvDgJwGsZZDFtwF6NN07p80kuyHIU8W9h4R0+kwEtqim
	cJ7VJGdyKOeTwMEY1F/qmyvHXQ7/SVGgh+DIY4xE4ePVxE1hyFpqDBA==
X-Google-Smtp-Source: AGHT+IGASm576xQ/Y0lTqK/5/WEa24uOVhXlkqIYz6pqxQzAQiPqX+MD5xHt32UH00HFngJv6L/bsg==
X-Received: by 2002:a05:6a00:2d8f:b0:781:2538:bfb4 with SMTP id d2e1a72fcca58-79385ce2724mr27606408b3a.10.1760437415991;
        Tue, 14 Oct 2025 03:23:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0964c1sm14398178b3a.54.2025.10.14.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:23:35 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:23:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>

On (25/10/14 10:50), Christian Loehle wrote:
> > Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> > invalid recent intervals data") doesn't address the problems we are
> > observing.  Revert seems to be bringing performance metrics back to
> > pre-regression levels.
> 
> Any details would be much appreciated.
> How do the idle state usages differ with and without
> "cpuidle: menu: Avoid discarding useful information"?
> What do the idle states look like in your platform?

Sure, I can run tests.  How do I get the numbers/stats
that you are asking for?

