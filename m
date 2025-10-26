Return-Path: <linux-kernel+bounces-870524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A48D0C0B0A9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BBA44E468D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CA22F12DC;
	Sun, 26 Oct 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjC56XyQ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B45136E37
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761505243; cv=none; b=XhYSl1hpicrwayHcwG6KCxXPpBy/+yXa5R1wXkStoflbi41J7ZKqjAEvIF1vdEo4IR1ZqCLRDRg62MZb32dlDFKSxUyRWsPEsff1qkCQeEkc6iGCvOo9299XTnfeG1CXAn6752xxwd3hP/1IybBmi8X5HeGC0Kb8uYdFqERqjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761505243; c=relaxed/simple;
	bh=3Q3b5GgkMN7A8E1Ye/bKL4jzRNvu92PYm7G3eWiosaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLrSW2ySFYuiFwKpSBGSPdj7vaF2uVjRqLrJtu7XQw8OvfkXOent0HY3OXUNpSAORwivy6squ6pTNTKIHvIhMOZ1dxjC7Y4/bmG/1i7Rzy1efHNY2z5SAEl5RsQyGiCRJkJI3bwi9LIW+rSON4+X0DRq4ExJIZYRiLGKf1GVplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JjC56XyQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2604689f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761505241; x=1762110041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWjeXMPyNxQIW0i9GzAqz+QiU2LzBuikp1Z6CQsw3Bw=;
        b=JjC56XyQyFTfbiXAHUPPIyTaLo3ZJFhNdFovyrOKQcwi2YVsgpH8D30hFg519TmQqu
         zSqzdxIoY3uokr4fj72B3ij7kp+flxuwz7+qXcsS+1kN6neYaxkFD5qROa1936jfO8Wo
         c8KWHpSw4OIN02BCu1ozpVX6wpg9Fod++7pMi6H+CcjVdoEmPYijBY03CTCNS9ZzF1a4
         kL7EMIa3Xx7x9o0/uYtwizStyMuQy6IEUt+ta25h8m5k1vMtTCcCHtNRRpAizC4yyrDe
         uoF5YQBRSq+7V9QFpqoHoOBlczRtEGma0edxw4WozNa8QU4PQqcd75u9Hlr1sPcU+Ng2
         WTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761505241; x=1762110041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWjeXMPyNxQIW0i9GzAqz+QiU2LzBuikp1Z6CQsw3Bw=;
        b=suEqi9KLne/nyLK39f5yiDGMfHJiw5Rf9ZI1mmO43MTCphkX/l/9RTqWQorCA5fRuN
         s856l1hZXd0VhnyEHJTAA5PEjNjN/lQwYBBa8H318wFCO1dUH4XligpqcFhTqw38iDus
         fIPdpdXE1bBE4IzAKR2JS96pFDp88aTYBB9jt0Lgk+13anv7FCmw4fj8R8jWFRQD9K6c
         JeD6BH6bDlsc0xUG12TSNBf6kSw1cGUWDm1wtoRVqxmQtG3wZ9H7bIxdIGbg7Q3qvXT5
         eM8CPB59Iy0qUkpTubQbX7xxhuxnP3rjq/5gGOuUedKLw3k/wcEIlESPqI5iSGoNeARI
         2YoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyuF0r/Qo0qlX5KBJHfm/U+9fOaF9iztYffub3wenxI7zRfZxEZtJK/K1H9E7nlI+/QCCJay7JT0Vf/hM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytgw4Wd0ceKHN+r13jbD8aWrzoK6glNVXO3DKKm4PWfTgvt3t5
	hS/1eYBCDs2OaLU8mBz6ISYOwiowosI68gnpXqZo6EqjqUQPbM/c2+Np5DZtmA3azxix1NxCKqo
	TzlAa
X-Gm-Gg: ASbGncs0nb/ZQWIblwemWbbG2Z8YMZWDeG9FFsk8Bzv9yAx/mZnsfafTBWBm0tf2o+M
	5SaQIRTV5Dm6YG9WtzK584Z9aeHPTCQ7Sa/h0mgzkfq94beEcCY+bILqCvKQWlrrGlQrn/sKgwb
	BtqB0LI62TcpsZ4VgrD94tXSNs4IQcA+rMO0weoFjl0WspfseQQkUvey4hBSSDc7q6mHF5xKIDG
	BO28ChFQrnhjGbfqDBbsVwJpPFVwacbIxXmR2ta6xLupMid0wU7D/FxIMuPebv6Dfk1IrBBqFYF
	msk8KU5rAGGq46Bbu50lo8wX65uF9l9ZSQW3TjWzJxm7ZQoJXaePV5eyrNa5guWNQs6v+wxKKnf
	5pKNx9DBZgH3SUz2bvPegRyHQoSELEnfBmqXTnrTkMDmo59f0PWzyPWH7PLYSoIzvIIwaYedc
X-Google-Smtp-Source: AGHT+IGZ7N6ulprujb7qEVdOtn0PLcuo5/p4E5IBnLRyLvfZJGqbZIZWqXl4kMRUT8H7LjxiyF7gfQ==
X-Received: by 2002:a05:6000:4909:b0:427:53e:ab25 with SMTP id ffacd0b85a97d-427053ead25mr28534724f8f.49.1761505240687;
        Sun, 26 Oct 2025 12:00:40 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5985sm9798883f8f.25.2025.10.26.12.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:00:39 -0700 (PDT)
Date: Sun, 26 Oct 2025 21:00:38 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: Re: [PATCH v6 5/8] phy: qualcomm: Update the QMP clamp register for
 V6
Message-ID: <bdxjowtabqvhfskxik75sflqlepf5qpaiuqupfndzwphkxydcy@zjuxh7k6bgqo>
References: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
 <20251024-glymur_usb-v6-5-471fa39ff857@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-glymur_usb-v6-5-471fa39ff857@oss.qualcomm.com>

On 25-10-24 17:47:43, Wesley Cheng wrote:
> QMP combo phy V6 and above use the clamp register from the PCS always on
> (AON) address space.  Update the driver accordingly.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

 Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

