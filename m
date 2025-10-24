Return-Path: <linux-kernel+bounces-868512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF31C055F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC0394FDCD8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F7930ACFD;
	Fri, 24 Oct 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlHyK+em"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2A307AEE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298548; cv=none; b=atcLORewjEx8MssMk50foZkXyDaWb3j9Bkq978OpMDib6Tl3ogOSt5xR86ygzMxipqCTO7HQxNOdWvcIfH3kHOPFrDSQ58BbQTzfg5EMQmLZnIi/CBYRgn8NzxcY5HZ+uN2Z/8x3gtKGV6/vpomG8YJf2jN/5g38w3USUsA2ZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298548; c=relaxed/simple;
	bh=YF/Tuce1/PBDE/RLif9qoc3I7KnbC+rz2XO3hZz7PWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuOstfQ6WzeRncnrEAiiJ4MW2GwGW7SnXoxGK47Oo+9MfSRYrsGSPy61jen+AsaAfSppaGx/WFpNUi39Aksda2o1Bz3Q9NVCDvb6o4G+JwvAoDzg6NnJdBpyn708TrIOy3d2aBWpHOlYF8hIKINgYQQlLsTZ+Vsq4TSEv3/fL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VlHyK+em; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-471131d6121so14290515e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761298544; x=1761903344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AB/k9qen5oHRYzxzAm46DDJjbnbfjworTJj23CLgdeo=;
        b=VlHyK+emmwMfvapuuSYMFXJVIs6lLgnzXet7DP0pcMYXKhEY1qILsP9XEQ+BWjy984
         nCDHPqF/vAaJxuMCAvuyRKKy829PTN71Hwuz5JKjz6zaLMqk5Cdshxb4rrUTbQ/1RGu4
         bZFCa5gNhHGW5iGvkd88lXsJbwkhnIDii9cE10hBk/DEb3CapDvWYFug4jQdWZbpCa2C
         t0GZnSc3LFhPFI+sesvjPXpUkjh8cr8inHd0bHt7UphV/IqOjBK6Qa0TGgoZOaI9mpYU
         Ng4BZ6kxfdTo1c+TDOidZsBol6XWXvF5JN6qaG616NrTK8b+d1cflFmG9NWeFztV28io
         nxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298544; x=1761903344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB/k9qen5oHRYzxzAm46DDJjbnbfjworTJj23CLgdeo=;
        b=MxDzUITDutzA4M05Ema54te4Z6vdCPtv0COdMjr8BJ2HVAXFbXboYF0q6KoUyw7aSD
         5L7ZnMqMJQzhtFKYbGNrlNr0o8rXfarFsAAEcEM7TNI5kuXMHsmQsNd7o4+YVuqkJUzy
         0QAClsFIBnaD6JZYZDLyYSE4K5ScRzDLhWEBmyvGaNb3XaR0cu+fJtFWYB59IE0J8kSV
         YxkDtDmgsa7solvxXCAZ+yUeq1JmwJYJ3aVEiOGQS2YKIa0O7mgbrUyocwnVzL+sFNMk
         dgwIkLeQXK16UakdWYhrD6cyedInXDL5bkWqyCDa+sjWsSzyjyY4GM94enzVGdmiFz0S
         6Udw==
X-Forwarded-Encrypted: i=1; AJvYcCV3cB1rLOIlKLA+uCdVpn2OgbEsocke67XZl7NofDO7THvtwhfg6qp0DDyF3D4dp2eSnqlEuktIoLbdZkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6bnnXWyDl00RFvBSoyJlIJLKx2i05pQc3xpFSf7tF199cE/z
	ksXOHXXe+0Vo+grhtQ10v9ZMMTSmaP1g56OLW14KK/eNb/R/Lnc9NiSaLdnX3FEtYCI=
X-Gm-Gg: ASbGncuppjh/akxi4LfdutHJhfo497iU5+m5xx0z+16zsxQaAD1S4j6zNlXeI37Nwzd
	O3CUlVOCpo7+hVYcyYPPP0S0PHy5Li5DkB2i/H01/Nhj1erDb2WzUogLzJxTj2+a0GymG9UtFFD
	l2JkKwJjJuxOckfAN+7Tlv6Yuxomx4fofhI8WCKXFxgPJIXUAHl4ldIgR8M7PHbAXNZNELBJXcW
	okI9XvtXwA6vCgQ9e9hS2uPeZemaw6457qasIX7Xk6PSZR8i7HTJiNz5fq3lo6l14YBoAG30D/x
	I4+lEkFlnSM+pB+6SSZf2RM7IlKCFrg0e8tx8GPcs2WUBospuP8xQUEUZbx8XPXYGuDCmQLHO23
	H/MPLEBAnshD+TghYGSDIqX3TA++Sy0f6d8dl7ZKaBOcNTEZeLE+0YHjUQB6UxCWsyWqvM+rzSi
	+1OFwbxJQ=
X-Google-Smtp-Source: AGHT+IHRT52qQLwpA4jCp3MR4MfEo1yVX3RPrxX/jF6DxckTinvzFxcrMGMBTx8wXfnTIC9O4HZnjA==
X-Received: by 2002:a05:600c:820f:b0:46f:b42e:e365 with SMTP id 5b1f17b1804b1-4711791dce8mr207186725e9.39.1761298544170;
        Fri, 24 Oct 2025 02:35:44 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm84581855e9.1.2025.10.24.02.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:35:42 -0700 (PDT)
Date: Fri, 24 Oct 2025 12:35:40 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
Message-ID: <urc62zk2xlr2rka2nyyjsovql734kuzzphyh3hjnssivgswgbh@sjt4u7wumwlo>
References: <20251013-topic-x1e80100-hdmi-v6-0-3a9c8f7506d6@linaro.org>
 <20251013-topic-x1e80100-hdmi-v6-2-3a9c8f7506d6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-topic-x1e80100-hdmi-v6-2-3a9c8f7506d6@linaro.org>

On 25-10-13 10:55:45, Neil Armstrong wrote:
> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> of a combo glue to route either lanes to the 4 shared physical lanes.
> 
> The routing of the lanes can be:
> - 2 DP + 2 USB3
> - 4 DP
> - 2 USB3
> 
> Get the lanes mapping from DT and stop registering the USB-C
> muxes in favor of a static mode and orientation detemined
> by the lanes mapping.
> 
> This allows supporting boards with direct connection of USB3 and
> DisplayPort lanes to the QMP Combo PHY lanes, not using the
> USB-C Altmode feature.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Tested-by: Xilin Wu <sophon@radxa.com> # qcs6490-radxa-dragon-q6a
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

