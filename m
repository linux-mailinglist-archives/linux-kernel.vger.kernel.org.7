Return-Path: <linux-kernel+bounces-867365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5DC026A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD0E3AFE49
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046472C026D;
	Thu, 23 Oct 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezdlI1ne"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7742BE7B1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236430; cv=none; b=M38ltILBMrSHXQVMPCZEbBrMvHAJygReE6o3oIdGc8aDQjI7hBxole6oqyxK3XNaqPtFpKwjyYRIZS0k8IZjPbA9MWZ8pALukKKOHJDa6JWwnGO4CoFT3XoYSQYkNYDlRLTxgf/6iJ6l925OgDNe8hiUSy9fZfh7ungtUWSBfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236430; c=relaxed/simple;
	bh=yOi+74DlAucQ67rYxkhrnivv9TgE3jPtCAHYQQCYC8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbBRtYEMLb4pU9iJfaK0qxTdbkJzyS0EX5XtJDtDRu3NSKmP3fXmcIJIiZsm18AreldUaZ/93Ur43CIiwCiihqsbWdgJ8GKYXq6XQzS5YJh1MIbMae75GzSJb1gRZBr93sveZ5aZfF2FZ2vwHipDpqa58C9qcgWJMVqoqqhOZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezdlI1ne; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so735953a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761236428; x=1761841228; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0HghvxS1xRodxk3iuqAce0Tjg7zGIVOVO9oCwG/XgrI=;
        b=ezdlI1neSrZzdDUF6oJbFwRA5K8eZegfFaMda92h1d0QbgbVOtG7Q4CpSuF4tbaDt9
         CmIarJLaXMuaOy0Jc22DVM3JErDsYs/WvNSqZve2hhXJD2SF4qmJfMF6UdeRlJMcbOpj
         ABolLRlzRZ5+z43dKqdRHCD48kLbyBu3SppXbGHx9OiYNj6DMXBBnE+1VEd02mvStns1
         6J01VVm4PS97LvvQpU42EHE+HyRqOW6i+zDFCzUvDU8JMu4usGQC3j2BNV+gEmDnYLNv
         cF7TQ3SJ0pptWYyR3mMNoxnLjeKIfb4YQOtolyweU8RK6QA70Sn0E9p8qfG4GNm63zVt
         M/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236428; x=1761841228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HghvxS1xRodxk3iuqAce0Tjg7zGIVOVO9oCwG/XgrI=;
        b=T/7PYkj8Q698NLoeP4D6iG0NhCZpGGcmIpp9NmLt8JvRblkMfGMR7zNmO0dTdcfdEC
         LDyDhU2VSNZC8An//PPUcRJkMy91dlc0P2VtPb0thjjWQyAkhk7RWWpcMxFsh/2yOUmW
         BWLR1agHEeXcIy5x/IYJOJjcXDssjW9gyAguVSgu4DFJhLEIkzCyMitkuSvrWMx9yqhQ
         X34V/D8/CLX54ORZclPc/sVQCzXW3CR1TomHbiq1Gm/jo5KStVkfOcTpeoY3l84ihPXf
         4B5Afub/q/5Evn73i3cXwwlO3PpruA/2U+dwYLTFT4whqLOJBCno/tiYZVi0LMAzdjtP
         ML+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYCRyj6zUt9hxXG2mnOMZ0rempOsv9kk/taUMcSt/E2m+445S8QiCvfsh3a9gIGmbz3Pvy4G49xT6TMkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYImWvXDp7iUcB6tRLExvN8OEIcPzp2N0LkRHYralINoDDQczE
	PTDhdyTdp0fQeXEPP2KON3FtjhR+tXN3/OWplc/0KJDd6Yp+rieyYDiS
X-Gm-Gg: ASbGncu6Xqijgu/iFKJAdIyzyGOZrfJcfWsJe0mIruR6g0eZuztdgQFsfiqEWe7joCo
	iVRkug9Hbk/biJuaLw0Qbwpf6/WLA9KohTyH1f1M/EbGksLQuuzrL9/3mFCEF1BuDY/7e5VBPkx
	ZTOR+gziziH+UbRuQDiKtEx2rc3tqRSyrjGqWAjJ8aHyfQ4M7cH8rjOVLBAZZvzg8A/esGQfxJQ
	umm+5KnI6rj0wF9KPHmpYZlMnkGZx/YISwZl+yckU4kForxy1d8NejZD5NfEC6Ye2/oyEExUcm9
	B6CDNApmx8zCGN9U9BInv8PcCtFUYOSsYQoSFp+naeEZsxdbLHhQDc2OFjiH4/muxevNVogbjsX
	2CJUu/ZV5eemdUXmj9uey272CIXdtDNwvVEKyK9Pm1cFzMvT8Fgy0GplZLS6ggt9oE9AHu96RyN
	8dGuaKqS+08/M=
X-Google-Smtp-Source: AGHT+IHlUzfF7dHw4WGoKEoZ4jVJxoqhGoMs+gcob4/KvqVdTBlT8jxUGxfuE0lfhSJNSazy1WfT1A==
X-Received: by 2002:a17:903:1112:b0:269:7c21:f3f8 with SMTP id d9443c01a7336-2946e117f30mr44006555ad.39.1761236428006;
        Thu, 23 Oct 2025 09:20:28 -0700 (PDT)
Received: from joaog-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddecb0esm28047245ad.35.2025.10.23.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:20:27 -0700 (PDT)
Date: Thu, 23 Oct 2025 13:20:22 -0300
From: 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH v1] arm64: defconfig: Enable i.MX95 configs for booting
 and Ethernet
Message-ID: <bicmfrrmkdmqqtfmdmsctpkmt3kxcxrxrgdv2a4cma42om2xb7@5kkybhdapn27>
References: <20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com>
 <cacc9439-2cf0-42bd-b6c5-13d1e75642d8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cacc9439-2cf0-42bd-b6c5-13d1e75642d8@linaro.org>

Hi Krzysztof, 

On Thu, Oct 23, 2025 at 02:22:40PM +0200, Krzysztof Kozlowski wrote:
> On 23/10/2025 14:19, João Paulo Gonçalves wrote:
> > From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > 
> > Enable the necessary missing configs for the i.MX95 to boot and also
> > have Ethernet working:
> > 
> > * CONFIG_NXP_ENETC4 for the network controller driver
> > * CONFIG_NXP_NETC_BLK_CTRL for the NETC hardware domain controller
> 
> 
> These do not carry any IMX95 compatibles, so I have doubts you described
> the issue correctly. You claim that SoC needs them, not the board.
> 
> > * CONFIG_PINCTRL_IMX_SCMI for the pinctrl driver> * CONFIG_CLK_IMX95_BLK_CTL for the shared hardware domain controller
> 
> 
> BTW standard comment applies - explain which upstream boards have all these.

There are already some boards that need these configs, for example, the
NXP i.MX95 19x19 EVK. For booting, the only one needed is
CONFIG_PINCTRL_IMX_SCMI for the scmi_iomuxc pinctrl driver. Regarding
the other configs, they enable Ethernet and PCIe for now. All configs
are on imx95.dtsi.

I will prepare a v2 rephrasing the commit message.

Best Regards,
João Paulo Gonçalves

