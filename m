Return-Path: <linux-kernel+bounces-850439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66800BD2CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B943E188B08B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8200625DD07;
	Mon, 13 Oct 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGfBZ6s8"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51C24A079
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355371; cv=none; b=DchWbwb06WHBLB8F9uGB2OhvijjZH9/oU+6Pa+h+0CFnSiKwCk87elua0vkA6ZBuZZ+PlvYr9M4yZlRpPz649FMHXxfNl0dIYn5hHnRKPdPNEZ8g+muAT/Rn+s4N1hTMsdkYkaQgDCeFwfiCedSMocoxeTU6qE6QL2ClgfKfWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355371; c=relaxed/simple;
	bh=Uoa6fwRxFOp5yXcDSCcsfCQDeelrFY9em5JImD7PkCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP+ZFcNHUSpqqqj0OM0nJBn5jP+wg3TbcLuK6atXMhtUa3OQ+C6LaK57iEYHbobhQvyjnalHH3BO10eOQHEXmpsG3Yo0tzdkAhg44GX3loGAEC04Rq4ubpmaXaDc/iM/aJruHOr0DDWb1ZAzd5Is5Uc1sCB57Xr1j6qbrprJ0JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGfBZ6s8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2186277f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760355367; x=1760960167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwo/yWdnbRioc3LFvtoHLGlkOOJnVDJyMIr5OhIkIk0=;
        b=iGfBZ6s8zrM8gDiHiEgul/3cjUP7cIp0oChsm4qnQW/NTNd9F4Wi4IlzkOmjqFWor8
         jL8tlTm30NEpbQHBi8vR+IQgITlgQQGhFubUfiBbxMSZNDzmD87rirQEGXNguQkkjrYY
         Cb6a7JcnCj2Y0udKy9GUGiQiAELA3c8tDHYwuVQI/oho6Pqp8qusA1xsGAsVJjDy+xAJ
         D8x2BbQlrNHx1/5L6fhWgXJCgU8r8GJFJNEcWMrfKN5iQxz8pY8tSlgIUpcZPJ6qzf0F
         EHrtpdQon6yatczImw6m1M9onCBjkfXhwUhIV/roUWcBJDLvcvpoRUnyEM4LW4g2iuaK
         WA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760355367; x=1760960167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iwo/yWdnbRioc3LFvtoHLGlkOOJnVDJyMIr5OhIkIk0=;
        b=UL0909PdDnaoRVzqlinH1YYDhFAD6FLXQwHVOas0zYl687Hwyh5RogXctSCIrKI+ci
         N0o0nKkDBataikjfDiaei8clMER9GCqkTjBbApvaNWaXnVHoleMsCWpM60dUa3nnwdEQ
         CtpzOv5NRo33aAFUdMrNjxdTd7SCNRb4OYFmVeFaZOEXCrkcUAP6wGUnTZ4cCLM100o2
         K0nONNgPqyhzXaCJzXJujWXWcOvsjb2w/LXSE/JoGYYYXBG7Fqs+YgThbyoQ//bmOWQt
         A9bURkikYNw5QQcLAbBhED/yofVHJ7/Mn5FibI090TCHjNEUNtphEZVzffACePKI1Fn8
         zk9A==
X-Forwarded-Encrypted: i=1; AJvYcCVZcpkGqWkSedd8/Uqv559cK2f8TTaxgu5IEjrfsGPtq5xOIPqLbaEg5wSpkCVW2oU0hyTJgQ3B3kzGGvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywQPw+q1gvg4s/Xz5ywZ4Hb4+7bgFmecwDF+VtWgpMnxI8kFNN
	doekss4LoWsNj03z6WlCJSSukYCIzAakTtEJ7apSSrcouFj88j1Ic/2p
X-Gm-Gg: ASbGncurFCbFTkCQnBRBun+ooRMYqBr4WF0fe4MzYbmyeTQtlLNBD44WAqx+sJAyh9F
	OuTpFzKLAMm5sPQ7krusDNPj3MEUEEfVGj47zyjuysomVtRcqUAs1p6tCFKrKq/79uVFkYElMiL
	EOSt2uNXCGZYalbJaQ7EGDFXdg5Dzb0jeRIh4C1MQXW1QGn8+2Ql8stEc2malIQNS2KUAdD1LrN
	6Xq3N+NM50ayW7pwaN6KaUyD1esb6I9EJlqaN5mf2+Ks0fvmw+l2130Hiu+3hCrsXB+CCf003NU
	IjEuF1FLQfyP3CJlQd4wBZqLxg1p1npzuFH5TBisdHzfo5BrPxofOdGV2F2SX7nFFUYgteRjIc2
	k8XjllKkFCiRAyWv1fPG0QD4KDD4soJvzXIv2x0ALa13eLCeUpA==
X-Google-Smtp-Source: AGHT+IF6Zt79HEXygH9EvfjQww7YVx29OAymvSr0uzjmK79t/sPfIN0gA2m0SBb6YfkT2CsUA/urvw==
X-Received: by 2002:a05:6000:4901:b0:426:d5bf:aa7 with SMTP id ffacd0b85a97d-426d5bf0c0bmr6137423f8f.63.1760355367228;
        Mon, 13 Oct 2025 04:36:07 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:6da:da00:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d4bbsm18111993f8f.2.2025.10.13.04.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:36:06 -0700 (PDT)
Date: Mon, 13 Oct 2025 13:36:05 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 2/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Message-ID: <20251013113605.GA177845@legfed1>
References: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
 <20251013-tja1145-support-v3-2-4a9d245fe067@liebherr.com>
 <20251013-unyielding-turquoise-mamba-76a0ea-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-unyielding-turquoise-mamba-76a0ea-mkl@pengutronix.de>

Am Mon, Oct 13, 2025 at 11:51:51AM +0200 schrieb Marc Kleine-Budde:
> On 13.10.2025 11:19:19, Dimitri Fedrau via B4 Relay wrote:
> > Add basic driver support for NXPs TJA1145 CAN transceiver which brings the
> > PHY up/down by switching to normal/standby mode using SPI commands.
> 
> The PHY supports standby and sleep mode. Does the PHY framework provide
> a way to configure this?
> 

Didn't find anything related.

> Why do you put the transceiver into standby not in sleep mode?
> 
Datasheet states:

Standby mode is the first-level power-saving mode of the TJA1145A,
featuring low current consumption. The transceiver is unable to transmit
or receive data in Standby mode, but the INH pin remains active so voltage
regulators controlled by this pin will be active.

Sleep mode is the second-level power saving mode of the TJA1145A. In Sleep
mode, the transceiver behaves as in Standby Mode with the exception that
pin INH is set to a high-ohmic state. Voltage regulators controlled by this
pin will be switched off, and the current into pin BAT will be reduced to a
minimum.

I'm assuming that the sleep state would fit into some suspend,
power-off, ... scenario, because the INH pin maybe used to control
regulators.

Best regards,
Dimitri Fedrau

