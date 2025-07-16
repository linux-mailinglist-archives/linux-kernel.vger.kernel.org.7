Return-Path: <linux-kernel+bounces-734362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D27FB080A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD33A18957A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2FA2EE963;
	Wed, 16 Jul 2025 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1lJ6bFD"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B420221FA4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705984; cv=none; b=Hx00xuKUtEbsXr0aR/fpZb9uwY7NwDFefPAtrTA5TYPAYT2I6qbU+2/WMElJctv9kIhWLUFi0rl/YR+qSm5iYJgVq1+hvNuNrgEp1KZoMAn0g7xfib24o691DZah6Jy09b1jkypMLK9Tju+dD6HNi/3MQZh2CXKyO13iVKTO4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705984; c=relaxed/simple;
	bh=egIk+/LQ4iaDf+RLDIDJAcGByEdkupEuWlBMyV1IjQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KiWqtCbPvyBCmfV/7iTIb0CAOMD4FXruyGO4+2shSC+PQjl/G3HJNzt4B89IholwijqH75NdlvZzCXshF9CEyBFnZeUFrzPRKYgIp+hQwI/TJQMyCRwnaotrMzxJ9RFVWyzaOH20ilfLHPCl0ra6cDzJJBi0WtRsz949mEoNHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U1lJ6bFD; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6159fb8b2aaso148792eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752705980; x=1753310780; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgJcNNaIcB7VF2rGgBtMbF7MjrWDu7+HbpybgI/inbs=;
        b=U1lJ6bFDIKcQf23veWIV9+bvDsFMOsD2ySRdq+QdwVQnsuoRz1zQxTwPRqlrsHLVtS
         WfNdYvnqrIn+3/eag9jeuw1lo5kLKqrdSgHuHPhoAH7OxtQ/KWR1mxSvHGxvlWcrmfY0
         FVGmBLFf2xCVn56Jb+dMVP6rxf+EmvAHi2MNVRaoXBvXG6tvgtG+JCVK/8JnIWI/z8NG
         wHIsu0kfyJ7WM5ehTTxKpl8WxCJ3i1U3yhci7+g7K3QjmWnpjjzIM2q2ovVG2Ms2shY0
         MqfXMzaletrEnui2/ebUdfHDZo/BUjtBj+5oGYz9f6tUCUGG14xt3cdo+qxN5iaq20WU
         B9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752705980; x=1753310780;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgJcNNaIcB7VF2rGgBtMbF7MjrWDu7+HbpybgI/inbs=;
        b=BsWBk/zQFt5wyc3z6j79tNtjWlQAjDvRdONnlQq/ynSo4g5hAxflpOHFQG0iNS6u32
         6FbHcMs/wOOSUoVKDgGbGUz2rY2phk8OEK/zXrfAdK1dunC7N3sI1NdI4EGjwV/BzyRe
         IqRyaYD37wiUDKjTVF7yUeq9rIfdEOIaHZZzF213etG8E4981EB6/LJEVFTRoXjkrmdg
         7LyJIlmAWq05PNuxsm24ml9Q9cE8Lqw+huodnlzv6ERO6aGeIcc2WNVqd0rqsr+WeRue
         VBDvkkyQqJt1Qvkb9CpuoplDkz3Ye1jj92OkNdDmqLfkbY9f58uDwWQ7c9i9OCntYAee
         c16g==
X-Forwarded-Encrypted: i=1; AJvYcCVZOzPo8JBKkcRZUwwRPPEkqV9HUIO7xCiulI9owMi/zIwgAJ4BtbZEYRItXcw1jRfzPA2kINLN24KWfTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkfoLKmb+dyfzQT/cpdYXFVcZW3V6Uny+DRJro37hrgnXmhE2
	b7LaVm7mwohBwpBvs3jhpB35vFWGCkW2IWEtahDEaFxUTyAtzA1uQybvbE95mEC7I1w=
X-Gm-Gg: ASbGncuIlraaDW9NnvrO2Q1LOSaxnBIy2SebMAUCjL67RD0u/GZLqH0wpVDEr97l/qg
	gXefvMC0UVmV8FVF2qT0194RNqjr1bQSZ8L9Mfq+lyvJfvf5GADu4mJINSf5NucdXJuj1mdt0vc
	L7Sic+Rk/GiSK3ufJ+M5jHqZQiiRIrTtqz7n0BXtAvIwN0mpXXQTIVAiITcZTADHd4fY5wUxc8j
	WxqiRyQ5dPC+H2OeHox2gElVA85yVDQ/uEOSk+gRwH2HCvKWI5IZR8pJdyzWih4QUNx1glc3mfW
	cvMrQhxtZ6HFX41ujrg47tn2XJONs6eBcRIogekEmUHYQ/thKdvYH+jvg8NxsVFy6Cm5N0iQzCU
	RmY2pG4DT9hb5lI/j3g5GK8cP+PYyQw==
X-Google-Smtp-Source: AGHT+IHhOFmUmhBidSkZlxAn7V6wq2jgbTir2wDMQeNvWS4TRSC8XLkdd89dV6UDIvXMlv0ZdC5Okw==
X-Received: by 2002:a05:6870:5b9e:b0:2e9:9e9:d94b with SMTP id 586e51a60fabf-2ffb257d356mr3201213fac.39.1752705980494;
        Wed, 16 Jul 2025 15:46:20 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff116dd664sm3898775fac.42.2025.07.16.15.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 15:46:19 -0700 (PDT)
Date: Wed, 16 Jul 2025 17:46:17 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Peter Chen <peter.chen@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 0/3] usb: chipidea: imx: Fix style issues
Message-ID: <a5f4c53e-98a2-4eb0-9f30-55313be27f86@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Xu Yang pointed these style issues.  Sorry for the delay on this.  I was
out of office last week.

Dan Carpenter (3):
  usb: chipidea: imx: Add a missing blank line
  arm64: dts: s32g3: Fix whitespace issue in device tree
  arm64: dts: s32g2: Re-order usbmisc device tree section

 arch/arm64/boot/dts/freescale/s32g2.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 32 ++++++++++++------------
 drivers/usb/chipidea/usbmisc_imx.c       |  1 +
 3 files changed, 18 insertions(+), 17 deletions(-)

-- 
2.47.2


