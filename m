Return-Path: <linux-kernel+bounces-773231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F0B29CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53854E6DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E555D30C35A;
	Mon, 18 Aug 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joLgrfFF"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13130BF7D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507467; cv=none; b=T6h5JAt1BP0ZF9Cn6lceWkelm9XA7JrCGcXFJtjj5jybdUR4Ij2n2lVuiYuGrS85eCCI5NlDa86cEheLWL2mJYNkYxcG1EFQiE53z8888PWkyFB6Xj3bcmkLRQfZInrCPQ7MjcjLt2y3Y7R/DnTHwesiR6hScn7rcaqqAIW6/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507467; c=relaxed/simple;
	bh=U8a6I0ZFus0vFy7ECIXwDx8gidXc8/GABtP4Ugbvj3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHMzqhcECwNOQtd+yeAa5SwfvHSPjxK4cDMZxlOU0vEljxrkGsCmeqeDm0CklZjmLJDGEDF27G1yZd1dZZrUpzGrF6/jP8BbbbxnKSKD/fzuHlq2jRU7QGPtKBRr6TSHT1d52eozSJs4riB3WtnyCEzIygQGE0DSD0Fdm0BJFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joLgrfFF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47174beb13so2785640a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755507465; x=1756112265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qe8G70eom6/4JetV7QH5UUKrtlBYh00PHg/YyriqGHk=;
        b=joLgrfFFDMF16c+OlfLqbc5LYzBoGzeW35Vcb+Ih/6SmgZvK9rQ4GB3Igx7zk1SRSa
         7Cqb/mOpzGIfuC7Url08iHGhfnTCVeYaKIP1OhAjkwPwiTfnr3phCpTazRTH8UCGXQpR
         yik3oTCKDfUpW2MvVykzbXPiZmo4vtPkRIJlPSXA7paAFCztpx3TMFZ6n2+Se6oyFUIo
         3GGczL2lrkSXMpMfRc78QdGFIewHmM9F84mgpkuS80Vu6ob6/8wfSRgTJS9L12OU3SfF
         yOa6SBNYgxZk2Meg/9pL29vhWKK/P+gqydI47mS0dVdbN8tmZBHo59Cz6gQe02qDHJR/
         7zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507465; x=1756112265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe8G70eom6/4JetV7QH5UUKrtlBYh00PHg/YyriqGHk=;
        b=ZZweWVHU9VOY9yCKZ0xEy43DsiSuhDdzD6CfJfLkcP0GFVBCQkftTS7AfUU/ltnSi9
         ia857E70qT4RfKKZ5vgZ5UQkqysLXvNcXfSsGnbPZ4ZrZkujX7diOEYOgckaIZ+Pzt4l
         q/gQlRJpWhYzvbvm6Rn2TnOQxWTxQFS87sMEpSCpdsL9yqgYMq9kql1k9ZR+ErvhEZdb
         BjUaF8u72GxxR5YexymrBvEIXgEdHsxjVm9f6tDGAH9cainVmm9NcNSLlu8abDA76E4g
         /zhtBXlDcwqnWa5haHpuK8F8YBQB3ceQrrh6DoK1jx1nGuGPjHiTrjQviUbi57FjU+8N
         mEIA==
X-Forwarded-Encrypted: i=1; AJvYcCWqHjiArWtNJWZFJrKGqXykod4BTuatb+QC3xc0ix3cRPLnTkzbLFJ4ZxIz885MlMAl7bixreHVXYNR6CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7nvcRdG4s2z7d0J7I9+GQ1/kiUaIP8zNnTWXhU0AKo0WN/Ok
	T+/YpwUnCdNa0oNubMO/h+IOk74SjG032XgiAiDy6O0h0TGcY58mN1CQVBHfP2WHDOY=
X-Gm-Gg: ASbGncvQep3NTaz6BybisJKyKNlQKq63E8OcOwFpH3jdkV1gGUkmM4LKeHrb2d3c2+h
	T9puHAu7iZJvqNpf/EFB6VkiLfrEpgtCHgTpEjyX1x6jH62zjEGSU6+k215vfI9CXeHWJaS7oL1
	yxVf/FtEFi2rJsl9ql1PfcWZ8lDgu6gN2prDsNzB3qgFOu++4TGUbY3JAxVguL6MdLqGOrQUcQI
	6Ltx1SIYD38XzX3OQJBRJiEJo4q1GjQ6FenFNgG500b7xQBitIEfS0uldVrYxb2Z1HaV8dSYFtu
	S41HIZHAoUbc4UWvJNcKDwPX3xfUIELlIahkHhj74q/y/8tjVbdZTAX2j03CcKBVtKbkW5xsd5t
	mzK7scGvH21mZDGgxO2izIs3O
X-Google-Smtp-Source: AGHT+IGpOHn1sY/HqKXMp8oqym8EA0mZNqXhfzJusUYFoebvw0MYrgm3dTzw/LGlv+S50fD/of1ijQ==
X-Received: by 2002:a17:903:228a:b0:234:a139:1206 with SMTP id d9443c01a7336-2446d916185mr159740845ad.40.1755507462625;
        Mon, 18 Aug 2025 01:57:42 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0dc22sm74615795ad.66.2025.08.18.01.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:57:42 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:27:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both
 frequency and level.
Message-ID: <20250818085740.czv5lpbktpmj7cit@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>
 <20250818085517.dj2nk4jeex263hvj@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818085517.dj2nk4jeex263hvj@vireshk-i7>

On 18-08-25, 14:25, Viresh Kumar wrote:

Also subject should be: "OPP: Add support to find OPP for a set of
keys" or something on those lines (I was more looking for the OPP:
prefix).

-- 
viresh

