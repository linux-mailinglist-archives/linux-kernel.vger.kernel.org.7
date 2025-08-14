Return-Path: <linux-kernel+bounces-768457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA41B26137
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0FC1CC763B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851123074B9;
	Thu, 14 Aug 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0uvATVe"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2B3074A2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163914; cv=none; b=TwehTAGotMnHdZJlRWKpaofRp7+EOnCqJuj70AcEHO2bMcTjmNlvpxVr87UNTaGZF4sINOOzNxhB/Y8wqwllKeFd2uDejadna8nnL4oBm0pSVepVxrz0h6kGNCIA+yGO6ptxpyPWqrBzBpwAX2VNwwslsmBKghZXc6kykP+Qcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163914; c=relaxed/simple;
	bh=fijvh1Io+D01e7vlvgm9vHdhu9F1/ZeWvTBFZGxfd8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRtP/+5tbLJLVjdJtia0yFT4fxSQFSDMtXgP2oUvLuo331E4htqT7SFEsNzdy51uf5UpjbE3yTGRbEtz0CMbNhUVRjewPTVZPdY6glepm/q2ymC30iZc5ovsOXlzFCPNp4UUvPt3uzVNQKEbTIiyIBcgOsFIj9/H98WIieH5bFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0uvATVe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso574447b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163913; x=1755768713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJQjTQPOVmlrRZrnxoAqufcGLuagbkJPkwYuRKf3anU=;
        b=d0uvATVeqF6vwiqqCPkDaIZtCRC0GSN3BebyMOY1eBZgdQSqyevGc48t+Ru7YHeEPB
         OEzsMqcGeIM16BIBswY+v1nQfHma0NsnvgSufhGht1/7Qy8rXW1tltuzTV7NaHC7RUdz
         GX2uZrf+JS7y3GXMJZgm1X6GgFtcZSAd7DoSTUcKsc/o3W1LOTpwttJnuLG4S1UxY1lT
         0m5brhNNwVCOiMJTjrXeNwEsdHukdUNjj8JpBSV8q5TltdFKBdWByPFAb3FLflXLQhgQ
         5GwN6KsALz2jm+2VGh9wvgkfOybllZGZaLvuORMPMyulqf3D4prrBq+V0N/engKfS+8w
         j4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163913; x=1755768713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJQjTQPOVmlrRZrnxoAqufcGLuagbkJPkwYuRKf3anU=;
        b=TzRLBA4Vi6In5Wq/DvZ9aNikag6AseTIv1frQdIdizguW1I+r98Zy6pje8+HROhHRd
         ywShgA0uKUxdN/SlN6H+Tur1PScsbcgf7/LhaYdvbNOwTM+R7ehvjwlQI+6qiFo62BDP
         hw50BiBtlcqDkMj+4yUIWF9dS+Al1sDlQnnkVicaKwj94wakWa3cYGGyxq7GNMZmafNB
         IPQhadUG6pcF0ZHf1SpyBtiyGH8Ma/SIivVDVDt31v/SLmrzppF4JIOu21/7/t263O9+
         RSJH06LnGgLF/69vuLNod39fDQjq/QArAtkX3p97eBSUoueOQI6yTM7aKw3sEsqEg9zu
         dWqw==
X-Forwarded-Encrypted: i=1; AJvYcCXKdaKn7QPdZBUXiszj5TkybQm2GmFLclE1S+gXM02i0+Pmx4wGwpBbQt8oXc9LaDiu3IoJ2f1inkucYvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSf97PZZmQDnLUEpKCJpqHcMR7wezJtYv/QSjUg8nsDiL8kbUz
	NEsX1V6K3evhscEJrrSOpLEPi4Hla9XfoNQci++6KhjBNgJ8U12kXyo7u9XTa5vwoug=
X-Gm-Gg: ASbGncv6ffvNlpNcHnxkDt+12Ojik7Uh3nOx/Qkd08WTp4Q+plOxSMSSjEdfEHKWXlr
	cBLfjs3sr/EjshevexSlboyD+5c7ggQNQmTNM7tVZM6RYf29Z3fURFweJW1fgdPr1NTMJebOPm/
	zde82cfknrqZuHujCNEwaahTBmdm8OrDgUACuLEdqKxdaquTq83MZ+bVYLu6hKxhhkFhZfGP94w
	uLhBxCYz1pyp3HuB0v+yfhmgCzAG6vxOXhI9sVi8mSQaUEMQEgeR1hcrGXQZGhxUPHhD5uWka8K
	NMURnPLhaqG/VzARXPje8QhMQZGwO0aF6RVzyLm3cf/phzLZTDEErI+2O/9nlsk0XiPXAhQoezU
	AtOU4Ijfnxv0/AGnuGsehyMkQ
X-Google-Smtp-Source: AGHT+IGt+a3zic40FsS4GaqjDHI71oyeZLUh6BKu1SRmqo/xOps+14RtHTg7s8vjxpDcoyfKt36llw==
X-Received: by 2002:a05:6a00:2196:b0:76b:fe65:71f5 with SMTP id d2e1a72fcca58-76e31ff2ae2mr3142286b3a.20.1755163912683;
        Thu, 14 Aug 2025 02:31:52 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce93da5sm33802268b3a.50.2025.08.14.02.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:31:52 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:01:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: Return current frequency when frequency
 table is unavailable
Message-ID: <20250814093149.ob36l2gxo33snbac@vireshk-i7>
References: <20250814085216.358207-1-zhangzihuan@kylinos.cn>
 <20250814090201.pdtvxqq3st65iooq@vireshk-i7>
 <3f901678-c75e-48ac-985a-2834f9ba4c8f@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f901678-c75e-48ac-985a-2834f9ba4c8f@kylinos.cn>

On 14-08-25, 17:24, Zihuan Zhang wrote:
> I just feel that it might not be ideal to set a frequency when the frequency
> table is unavailable.
> 
> Perhaps adding a log or warning when the frequency table is missing could be
> a better approach.

There are a lot of drivers that don't provide a frequency table, i.e.
drivers with setpolicy() or target() callbacks. Only the
target_index() ones provide a freq table.

-- 
viresh

