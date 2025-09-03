Return-Path: <linux-kernel+bounces-797679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79222B4136F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E481C1BA042D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2BF21771B;
	Wed,  3 Sep 2025 04:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4+sWuI4"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE98F40
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 04:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872770; cv=none; b=RSPeW1UXu6wDW9mdI6bNDttACaJTZLsjOLahnLJPhR6vv5PVMBcT1ZAoxBcxoIDraWzdWoXLKmzKbXRfDl17A/5gesLmasEFYU4h2nWPaT5D4Jf+J7si52WH8rmILD31DVI9kdat4g5A90LVLb9VKIgVO6IzyFqMssSzePAYjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872770; c=relaxed/simple;
	bh=/1HMn7TFnXWW0UY/05jkl5C6MPAXQFHbBWZ0g4cg5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5sVKP1XCnBEm49kFb2dGVa+QL+c/NQ636hOsPKOmokG9TdPuj+BGAFeyHAmwZWK25OS15sgIqwZEnYUrK3/Vje7ZT+cgYwGz51vgOZWuPzMZSqvyQvO2EWo4rE8Yg1OmKpmrf1kQPn26yq9L8DWHiRvqKFVwddZrsUi1g2E+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B4+sWuI4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-772750f6b0eso1194522b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 21:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756872768; x=1757477568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3tslRr0ekK73GDvQIZh7lN5yUKeNtEca8n0sO52evM=;
        b=B4+sWuI4o3x/S4rarOdP/3KNAp8QjLz9Ga0dqH5OAgrHdxBf7mSIM+XFltEdrfus2x
         Etoc2rT5cv3UnKsjuD9Osx0Sxp5/odX8VR99YFHzrcmgVkC/I6VpjWDawcpq0sfqItUF
         kpLrAikLtwDjdVyIB53CDCVDRHcSNQ5uzwGpEjE5H5OySDPxYr1mbCylKQfj8uqEViMd
         Ko4DUJCEOI/CteFglAOeOxTocxHBjnG+DRvpi2hiv9EJy9DWg4VQjVOpUI8t9JANb50r
         ujn7P+7AKc/vW9VCHk/uvGEWLOek48EHtWzUzWUufAWnWXSUurYuVhb0YsdGVVegRX1g
         ppWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872768; x=1757477568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3tslRr0ekK73GDvQIZh7lN5yUKeNtEca8n0sO52evM=;
        b=wOfZ7JUz8cO4kmj5biLG8ZpXAOLW+qI4FAQjuLCMCfI1vgKKw226Sy/a+iacheMyqo
         r4SgqYTdEi2y/HMEa64aN1DgIqCnjohbwDA1APO2oq6IxMTOqouTMiaYSCoCwSxyopq3
         6YhhhcPeQsSAnT/mI6SU38y6XB81kR9Fbv+eFDTrbJw1qf2nnBSG5lQ8Pl1d6RfIqZHD
         p/Ghr+6EBDPjJYU6HeZKipat4mSxIqxxyasA1G+h2JT2XJYrDzB7DuyOFuGd1/y3ohOD
         DcE7kw95fpfplcGwXBuAOrxbQVYQNyf7Rf7iaUbqzbnrGpzsAOHaMDSg35oAS0lZ2cKU
         2Jfw==
X-Forwarded-Encrypted: i=1; AJvYcCUHQ3znAagl7F+BnurOVKDujpNWWFcxYeAKIDElsIadcA5dWTe5jRSfjtvw5QAWmIzK46KL2SUkhabiMLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7x5XurH9EHp8LJXzb68mtXD09iz90igY9SvSwOTmf2Kiz60Fl
	YPUlDLt+ugmOz3ioDTZ8aWSfNiKPFz9xN2FF7tIyCqAJw0reMKXzCa3SksXlt2OcDQk=
X-Gm-Gg: ASbGncuAolMJ36J5q32sdLWmGoym0YacUoOKwAK90pKdPijkcSRYu/yWuNCkjmKD19A
	PTuu06Yr67C9vedXM7QV13mFDKNG5sgJv+L2yEpKkJhiuwaqlolURDC0Avhpzv5nd/i5uDKENM4
	kGYwoE014CpVPDQpX9yrIIWO+EA6nQxqZ3UlKWCjURbe4gL91Fzerzc0Qjz8bDSSqb9NpDQMoQg
	lFcG6zT290E7v+kohHWKxnCJiY5IzlXABYwJFL/Qz/ZgHAAqzdjFPRSVuOPWpxMog169Nn8ZBum
	fGTD9AmR0j/pQDQW7qY+7AJoovUQfo1T1b33DS/sJbH+wjvx1IU0wJGbkaIvFfZpHD0CXG//2mk
	MeANmQGkPgJqZPjZ6VgheJ74gdKeHXC9s090=
X-Google-Smtp-Source: AGHT+IEIDICXjPZJ+Es9fWHlaf/Hhb5fWtqthz8BHzTOB9rr+4nE8sud8VaqfbgZ+64bT+tan82DFw==
X-Received: by 2002:a05:6a20:7484:b0:243:ca56:a71c with SMTP id adf61e73a8af0-243d6dfc0c8mr17604683637.13.1756872768457;
        Tue, 02 Sep 2025 21:12:48 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm1650136b3a.9.2025.09.02.21.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 21:12:47 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:42:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] cpufreq: Use int type to store negative error
 codes
Message-ID: <20250903041245.exmk2f5zdpxik76r@vireshk-i7>
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
 <20250902114545.651661-2-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902114545.651661-2-rongqianfeng@vivo.com>

On 02-09-25, 19:45, Qianfeng Rong wrote:
> Change the 'ret' variable in store_scaling_setspeed() from unsigned int to
> int, as it needs to store either negative error codes or zero returned
> by kstrtouint().
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

