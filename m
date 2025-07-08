Return-Path: <linux-kernel+bounces-722013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E5BAFD17D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7792517A4C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFBB2E5B1C;
	Tue,  8 Jul 2025 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTwCKCBE"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561A2E339D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992464; cv=none; b=G55LvoyVJgduU4JIW1FCPUq3QZ+HdH+JTuU2OXhEvGRYbM7NDHtdqDru78J6WH+VaSrAOjJCwRCUv+PB+r8+73riov2NPKveQdFjs+nDnMTjGo5qqb3u8XyApAmcWJdcSP9M7bdHeLvUaXt4eOzsrcKWRBtSd7Zg4yl2FwfOgYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992464; c=relaxed/simple;
	bh=egjXBQIDVMcPJrFuesqfHI+sAnZEJZw1CswxrACs2UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3rZtVk1nukyv98bizvxEUjj0EgJZ3KttFuNj/KLukdDgSxpEkDc4C0evpI10Li/uO3FGOSXc5J+s9Yb0FW8DRpFbgR2FuZhg3NlioARkcLnoonHOLXP71tZx2HRKhguFJnXHVuhR1QzzoTITF3Jg8KDnuoAFLL/qkLZR5fPV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zTwCKCBE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade5b8aab41so959209566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751992460; x=1752597260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0at4FacdZ6pma9HH5OGwEa8HPAQDJiRPxVtv3dm2mI=;
        b=zTwCKCBEjZVqNGlOUf66R0xz6GPjDzoODQCQjowRKc4kLXpR2NdKTHja9tpXiUm7vE
         sGZDVqSVjSoZs3+qRNAn6eHGTdYG8hkw/xj81WBWGY6vOqpQHGJ/Jdr3010WT9oeihic
         GHuvL3gOxCkxl3hHhH+9ILkphOMi2csjKtISJSNZadKlaueWEokcGdhaWbZ/NYQefMVD
         BnuibIJLAEXXhA6JPVgxmnr+in2fd2FkmuvVjyvpBHdF4KZr7l7Z1GEjXOEiKIREoHZI
         vlFgmrsh8yjsjEWTtFmRv9XlLd8MC6QCWf/rEBgAWY5OsyEgqfia3wnUlh9DDJuKEgpL
         baCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751992460; x=1752597260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0at4FacdZ6pma9HH5OGwEa8HPAQDJiRPxVtv3dm2mI=;
        b=gZnF4kAAl9nRPX94Xly7HblHCQ5AXD/Sb3+kF9AiUwmCgS39pGz3QpqgZfwMhb7NQY
         jZ35jFBodcpD9+Gk5joGpXWNYyoDTdyTaHv30YVayt4cM95UTaXCpff+6bK5a7VVkttd
         ehrQJ+QSC6ehlVy+7OPxYCILg6gRIgRe85rwWo3gS6unVQNpZJqiptTJN73b3tNSRBfz
         iW5ecqliqeKUKEgdl3/SSTvCthfP4MiTcchNEam1nNfv9snYzv5QS2lOvOB9nUK0dtRV
         uG4PkvDPO0Fy+ofJVv8DsarhhJEoHr4pQL8hm4KL3cCEPErwIILC+hspIbiUVnXAjhLh
         JsgA==
X-Forwarded-Encrypted: i=1; AJvYcCV6n5aJkSdrkWhcdAMF1/bklOPS7yl+GirSph92FG2FUfisMH9YszELtLDr6PHRM9q92x/paFOAtl3oyac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdVUHm1C4ddC9WzqmeiYbA6VUA+33KHmMbx9F0fo9T39Iqwxr
	ir1jwHnbgQVcKYpHJIzyPYvjt6QAujVIxNULbtisaFcqPuGGXILjb5p65yGCRlNb0Nw=
X-Gm-Gg: ASbGncsTNYgTMQ4HBR8ciCo4oc8Hd0LSGDS9iBPLdo8LAa7PLwVouS8QKcGZ4pAzS5B
	wCxqSeyzaD/uRhAL317aKHnjDTjZRBOwTkl0aft8SpmO/+0JZihsnglfkObOarDD+JYWdnn0Y6I
	62DyJqgbXesp+vXFBL2T+Lq2VWJwrKy/YqPdkL7hJZ8B9toa5ePNwD1C9oeSWAZ4/oy0Q0dmcME
	6WZrY+NikNU1+gJ/UYa6xU+VWDjvfH3hUin6Me8pWCPRY1A5EKMyZ8QqAKHHnfDesgnCAK5L5wc
	fgPFFzzp8bqRXXkKyH6lBx1iDDj/KdiphHU32G8pEsaWmgQgEjfzFRRxd/U=
X-Google-Smtp-Source: AGHT+IGKBE0r3i/OgmjaRqVmGAN5LyHLg8zBEZZguDeNMFqqfCLNiGPwn8x/2LgZv96cHHN089ljmg==
X-Received: by 2002:a17:907:9496:b0:ade:422d:3168 with SMTP id a640c23a62f3a-ae3fe6fa77cmr1690286466b.37.1751992459765;
        Tue, 08 Jul 2025 09:34:19 -0700 (PDT)
Received: from linaro.org ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1effsm934223466b.175.2025.07.08.09.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:34:18 -0700 (PDT)
Date: Tue, 8 Jul 2025 19:34:17 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Frank Li <frank.li@nxp.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] MAINTAINERS: Update i.MX Clock Entry
Message-ID: <aG1IiVXZSl+/4+Xg@linaro.org>
References: <20250707-imx95-blk-ctl-7-1-v3-0-c1b676ec13be@nxp.com>
 <20250707-imx95-blk-ctl-7-1-v3-5-c1b676ec13be@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-imx95-blk-ctl-7-1-v3-5-c1b676ec13be@nxp.com>

On 25-07-07 10:24:41, Peng Fan wrote:
> Update file match pattern to include nxp,imx* and fsl,imx*.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

