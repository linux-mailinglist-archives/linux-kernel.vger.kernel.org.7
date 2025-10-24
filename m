Return-Path: <linux-kernel+bounces-868894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB148C066D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66F214E3580
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C0C31AF3F;
	Fri, 24 Oct 2025 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLUIc9EV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96B309EF0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311690; cv=none; b=o8o2SHiXprC1mzOB07gaPJMkg9Sbb/QHzNYkgApAt/EN31nmEE33XAUPLCdBzvgmV184wEZxgnnEhEt24tbD8idzpSInMAnXeB+8VPhCi9skeopAeq6H10r/u56COJLc3v/umVEKYYrURnE0AQ/CifBSpXrS62saXTjLk8j5RB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311690; c=relaxed/simple;
	bh=B/J4fSXBxYjahTVHd6bJx8SmdiExewV6JSag7qLfJVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMPJcMElrS/YJCBD2sAqOnnk1F//+DMKvtPZ2xb3zWdGWYUca2j+SjfE9uuznWrYw6eOfmJeKpJZn2ONh3/GmD3GhmwFpK+KPPrSXty19Mhq4wb5NHVIlSmFDBw6GbIQ8Ok9QosxclBQ9GZoSe2+iKB06G8JsR0R+YhhVq3OBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iLUIc9EV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so20323215e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761311687; x=1761916487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aw3s/Ngv5fWq93/LfGGZRypt+nWW9NzGjLCsQdxHVyo=;
        b=iLUIc9EVHB8CPOYr/8Aosec0lmNS9mPRCPjto2946ZJMD9XWMeJW4r0Q7fu367bnlt
         wi+Y/ZM2XORF1mmNd+77e1RrmYO3gAkyGooMaT8PSUQ1M+ih0phuEaCBGjUvSLgX9VwU
         pWQrdjwYepfXQ+MBuzvKo6zw8+aAKFyKLgZ3w0xGkt2/Z64CT2J+9Cst5RMewwFCgQt1
         79ibxE/AGJQbg/9HWrODN+bM0djG6udhapUO4bUK0INXeDH1J1KA18dSEV8uEDNew7vu
         tcsqbUT7N3cbXaMBgOagia2fysdhyqiGTkX65G/T6Zv0BytNPU/J9T1TC+7c0qZa0xG6
         WNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761311687; x=1761916487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw3s/Ngv5fWq93/LfGGZRypt+nWW9NzGjLCsQdxHVyo=;
        b=cmU1E/2vXiSJVlc4IH6phhQ41N+trJq1WcgLDtlFUPb7Y8JSomXylNO2P7oKQk6zG+
         vKHmW6rAFVNOeymzllhUN3cGIAuyumYTIBRQ7YXcmTfSC2X0Pxyv7w513aCwle47/kr7
         q+OMHYwzPPvz9t8lcYNbWLulAJTn/eWb5/vCygaU1eYmKAEL633Jj9ocMDsNqmrj1Fq4
         WjevEZ0ZRSG089q6FAznTQVAJg32H93Aalh0DwjZPz75lYOHSV8h0IEBuwbcJSMb5dCy
         r5yNG9/JEuYha6LU/jGA+0gw8NmItj7Om2UrU3BMa3F61PVSllzLTft+WZsB6INJEYdI
         xoUA==
X-Forwarded-Encrypted: i=1; AJvYcCUmW3BM7F6HfwA/AfBxJ4oU5gLHSEc01KQMjLyXIWhoLAxmv5wYW+coHizfjeSn0qDnBqKxSGlfRf1WC7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+DSC0cBzBhN2n0qXPepJ0ILeqVjjVtuSnxrk0prNA8Gzy9XKf
	tM05K5fWAZetgcuIz1MDdesA5+ooR+fT++W6OpKA+AlvU+T7Wscf44lB3tYH+rF+ur0qQwtKAsp
	Q9rM3
X-Gm-Gg: ASbGncs1pi21PaJJA1zZtLEs3jopxwmrbmDKEtJTLu5/bnA8bDY3RFk9exmqFiarnKc
	JrVHqVtbhf4Qh1UeUZEiqF7zHzTRiESIsT3MGv/LnhQqOVf4JTjEqLyui5mQpT1A6CGtWvLgARD
	53fEeguquLk4J/MrBWfGd4lzSMDvD+b/baSkRCC9P3GfVEBnC1tyb4SM7V1vvKnoTVFvw42r4D7
	1QAKqWAYpLGfkw4P7OTjEpbXmM/NlGM3JTlw2f4ucANhA7lxgly8XHdt8xRCg5N4vEqPxpLftz6
	U4fRr/B1TsAQGcT0zBoB7RnuT7aO/iq1PptNwRn3iefMnz8l92Ky1tWc/PAB3R6q9G6OD1ga7/Z
	kqVtt59p2wcFL0djc5ImeKUGpI9O1H07a1Q8KLNcJm6FS2vcDobA/ZZoGDqY1upWf+bVIo4+R4i
	xpLzWzuWI=
X-Google-Smtp-Source: AGHT+IG173mHKY9AS/3Xa7nR0RgEEWZWPFN6mBkCz/tfbOlzz/oOa+s0Yjnu+DHdEWhOrllzlsrkKA==
X-Received: by 2002:a05:600c:6291:b0:471:a43:123f with SMTP id 5b1f17b1804b1-471178a6882mr222738315e9.9.1761311687001;
        Fri, 24 Oct 2025 06:14:47 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427ed3fsm175699395e9.1.2025.10.24.06.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 06:14:45 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:14:44 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
	Shazad Hussain <quic_shazhuss@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100: Add missing quirk for HS
 only USB controller
Message-ID: <a2cjvvt36jcnmbmsgf22a6b6p52aoejpvwbo4phsd5gc6xclba@havatemgahmd>
References: <20251024105019.2220832-1-krishna.kurapati@oss.qualcomm.com>
 <20251024105019.2220832-2-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024105019.2220832-2-krishna.kurapati@oss.qualcomm.com>

On 25-10-24 16:20:18, Krishna Kurapati wrote:
> The PIPE clock is provided by the USB3 PHY, which is predictably not
> connected to the HS-only controller. Add "qcom,select-utmi-as-pipe-clk"
> quirk to  HS only USB controller to disable pipe clock requirement.
> 
> Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

