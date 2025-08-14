Return-Path: <linux-kernel+bounces-768364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DCAB26065
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6212E1CC42B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBE2F659C;
	Thu, 14 Aug 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ga0R+raU"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7212FD1D6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162127; cv=none; b=KaJ7EbiFeyfjPYllQ6aezG1E9TAsQdJ3kdCz7yiN+S7vpPuDC4Bwh0C+qSDH4oJONbexOkGbkchUXfGJmG1cnw+PkX+CDVXxsdxp1yQXQcBwB7PW5tta6c3FU+CQ+q/qMfAvyg/XiybHctV05SmixB56PmoDkjqTMuj7aRYz8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162127; c=relaxed/simple;
	bh=VIgbe0+cTepm+GSjli9I/liq5c/PTGeriBLsEt/LdqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAIJw+ywEojStGRSL4zgCcMPK+52+v6LWnWj1VX/+Z94b0Sayas36zMrt8pwdXXJy94jTeUAkLqzW/z/iPO430PS/SkDpuWzyQOQO+pwdWgPkeHtULlQTPoAyEdLcMs/EAzHtsErapzjiEudf061wZEh/By8QSMxzT5ECezu/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ga0R+raU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so838917b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755162125; x=1755766925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NmE7sMJ+PeGcKylBDWZA2ZrG6ibfGIlvX91c1+5XOpM=;
        b=Ga0R+raUBTTsNApohCfDOCCWUfezgcO/PQ5UxptTU1TmqZNTXGsqHG4Oia1Y9QQaiB
         Gs6IgmVVbl0bxPl4NW0D3pfXmbGmvubjCN8lp2OIjcsjPASZ63YrJN47vsx8gcduSvNJ
         FkBeavNwr3Mq9Uq/OSNS7jboHs+IwMF38BulSMSgg9lKd5VEINo7/nlg4SUk3iHj31do
         wXmtwMKPLqb/fH173vX7VcMGnVmqy1n3tc7WQfsOh88D4Byi6LkBGvsA3cJb37q3vUKI
         82HXls4uXjV/F19WGXs/ZhmR+DevNx7rgMlAbLnggYhuuH+mGHfXiDrfoTPOfryTiBPN
         XQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162125; x=1755766925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmE7sMJ+PeGcKylBDWZA2ZrG6ibfGIlvX91c1+5XOpM=;
        b=IN8RPUd7w9V53XxaMsC20rJBWm5h7KWYCcbl0WrJBCtJrurByfgNm7q/zbc9g++SB3
         58RYCoydBqfqwIhvijy+XjNkypgjx4nOGk3a/hOQczMM1/VkrKEnQ0l0/3Ph4kwrG0XU
         MM2l4729LBHmCHdytD/xGzghpOhKafitn9iXQ7n2qWQIe7Yw0X5dalvsrVMTUZupt8l1
         XNWNFRsFXVz4cXlh4DB7Rzx80Polyjk9ogvrcTXq9rW/h9liDlBBZ0qbUlrX3JMVr2HB
         AGnww/tPLahvGxaic23R/DqAlus4oLRNYJUodIzW2sH3oNRpf69+bOH8f6CTknaqoXZD
         jSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWouJcXAM4agaK7mikw1j/BJ2vCbQd0MonjNQjch8YmM743BG3mMIt+EbJJ05anUn3WWx4+nhTAtQthxCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpBS72zmC72PoePGct03LuWUhJsv8NaC0ItGlY2yRCz97dozF5
	TcbWvoMaoFmD7HOSRaT8Fchq+pE46c3jfOAGxE6E5Mg653+/RkuY4SidPXik8fpUQbM=
X-Gm-Gg: ASbGncsmfRwt3fqGAPs/ewpOi9qTgnZ1QvSVR8/CYUnsUijdeLKW9Sn79W7EYyV/gF8
	LMU9rFr88D6UZkyVBoyxBucIHQgUHLnahCJjqsESkw0Xk7OhML6NbnAo2xuaWQeSvjA2E6pjlWJ
	ZLrCXnzNThHzuCIt3SWpLhx1nLGqNVPCKCR7EE7JDKfKziW3WhHsIzuwoe2u9eBGkxJ00YJJGZv
	OzeTrfv8+FjtPpMVXbpFKaecXiQ8wipK2GLrGjK33jcSzJo8aDt8xKoqMjUosha9e/UQV+siXGT
	3SslxmtYIvXMKwt6XKnECbJpRXWtUBMlI9EMkkEENrUl+wZqiqYTv6M0URkWLI7gtXjUDGgNWsg
	U/+Y8HY+C4RuqilmfEo7/JYJcOW+r4SwEYX4=
X-Google-Smtp-Source: AGHT+IEFfT6WjP2Xn7bRIAeP6rPkcMNitalN7pBUBi2AiqkDrDv7x4NjeKEEWrLKN8kwbYf06w6yRw==
X-Received: by 2002:a17:903:2a86:b0:240:80f:228e with SMTP id d9443c01a7336-244586ff5b1mr32099585ad.52.1755162125651;
        Thu, 14 Aug 2025 02:02:05 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaaf1bsm350103075ad.159.2025.08.14.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:02:03 -0700 (PDT)
Date: Thu, 14 Aug 2025 14:32:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: Return current frequency when frequency
 table is unavailable
Message-ID: <20250814090201.pdtvxqq3st65iooq@vireshk-i7>
References: <20250814085216.358207-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814085216.358207-1-zhangzihuan@kylinos.cn>

On 14-08-25, 16:52, Zihuan Zhang wrote:
> In cases where the CPU frequency table (freq_table) is not available,
> the __resolve_freq() function will now return the current frequency
> (policy->cur) instead of the requested target frequency. This ensures
> that the system doesn't return an invalid or uninitialized frequency
> value when frequency scaling is not supported or not initialized.
> 
> This change improves the stability of the frequency scaling logic when
> the CPU frequency table is not populated, preventing errors related
> to unavailable frequency tables.

Is there a real problem you are facing ? Or a code that path can do
some harm ? I think this patch may end up breaking users.

-- 
viresh

