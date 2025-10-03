Return-Path: <linux-kernel+bounces-841173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC3BBB6691
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C030E344EF8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C262E427C;
	Fri,  3 Oct 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdDiHLvt"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5DF288522
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485375; cv=none; b=Xva7YvFG/0WsfPsxgkvCpjsimVEhbM/dmDdcfpmqU6j2KxAc97vHKJMZSIaahqzNGsDHUxmyMe94JuGf+aEpAQ/CZhRc5SuC2EEVUoSR4XEcv8M1OHFaQIl3sdngKZTtGPCno8XEQY+txeDBpYfZpLzjKUVCD4nvzHPewPunsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485375; c=relaxed/simple;
	bh=QqW0rxC7Vf1nAEG6EJAGWXwKs5VrONY7vi4gfK9d5Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/+rCiQApPoB64CfPSaa3yADgYWoLio4AGEjYmxZtDwVspfpf3xQT668lD3A4iFFL4nFAkLZLweOebJLmM4UkQI5AOCQCMA2lAvYlwh3CQnGJzia+R+h9Ts82tmbgS15PrgQ3Q1ODQPmWjzCxut9A3VoHfzeLbpXlXatdHNTHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdDiHLvt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7811fa91774so1712266b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759485372; x=1760090172; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HjkSzcHQCRHxGjAdHJ76YWjL7H9j4QRw11Hc/S45qjM=;
        b=hdDiHLvt9Ie6e2LmmmZsmnnx7Rm1fw4L1xxtN0gw90sXWu64AHsKLXJ+6Im3iHJ4qV
         O7Utg51WQBaijUL8DuLd/8XmI1WYZHHk8fk/V/w4rf8Dyd8pJv3rsDaIqfeGs7sH3dbB
         sqDivGxO7HiARQkQtRiBqDw2iC4tjJ4A3x7acEBge09U45/nSB7hRfqYKxy3AwqPHIwZ
         IKjF7ZjRnAg7mpbUCY64n0l5iwSoK0Lpz47n3sCgesKKl6YA/Rm2/avpwwoMdg0WsULK
         ILblMyXZEkAOnN4meWaFi2nsR7RDLiC33GXPzj9oydJzwY5UEnjiR9voLSn19fj5lMCj
         6GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759485372; x=1760090172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjkSzcHQCRHxGjAdHJ76YWjL7H9j4QRw11Hc/S45qjM=;
        b=YTBZ6faxOaXPFS2PfD0jl/QpNJ4QHBezsdH9kkgolKJDLpLHHJSOMLh1wxIWJRtKLv
         pk5dTUCsfc+gQjZ0jNsuNyZKk+xT5yMw+QQ2STYbDrDufevavamUvGgWffXXH7wWFdIW
         nV0Nq48XwyMZH2u4Z3hMHInqGf8xFKkfYrrF+wnjCTvsW/F2NhyJVkFkrPdlonoFMkiS
         s5Tyt7IGjLeCOv4x9RD886gxVxWPVsggj3s9EDpv20V5+VkXwlHFILtFIaWpDUHXm95o
         yru8vp6DutZlz9M0Lee490XZkAKBqy9olRh5ovJjUGm4GHONdesFF31hK4GOw5hz3x1y
         ypsA==
X-Forwarded-Encrypted: i=1; AJvYcCU0C3jDZWji+tyo1fNExGobug57Yrk3ajF4oAGOb7QnTYOaCeSq+xUv5d+OZnd0WeNQheYNERFBJ/gcakM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8j/3D21XUYPf3jX8wm884WU2gnIq6D8FYspNG27YwhxS+1Af
	p5ryF+IpCUAL1mE7KXXV2w529DSN3BP+Pfj4qKZo376A2PXMctZvf9EipGtL89vu
X-Gm-Gg: ASbGncv7aX/6N2Uo/+tMd9XoahlsBqGjI8M2F2NRSDXmTQ82zT5cM88coOZ7R1AfIsp
	MlujewBvzr/DFjgpkfPXbuMnYV09nhpQgGP5JFIpNnZ5c1SGd4aha+O0RklwcjLW1X0h005sAeW
	qnLI65HyIfl0OEIGUdDpfnq8ljzspmg4lJ0qeAgqUnFa8EfH4nilzcTEagLHAHPtkCM+XyIEeDv
	phiwt2OFWPF5nau425iiAjaSCQcRqjrL/8nJY2cZLuMZ8Ug3m+sdjANh+NvQCr+A8RAHOwKXG6A
	W/dFzvyTAT+cEsNZ3rbjhhWQBqqCxhUNxXBZPzedikaJrMWZ+/vIvrOvyISXHPPcknst9F3yMEe
	mYL+zEaXsiGYgeGyQgOvydOCmH5ss3y2aUg==
X-Google-Smtp-Source: AGHT+IFgG1sDmJWIInobrT6MYZozHk7ObDc757Ax6SKK+T4qAyB9z8lgZO3RUGk1fZnpjVO1SGBv+Q==
X-Received: by 2002:a05:6a20:6a1a:b0:250:429b:9e6d with SMTP id adf61e73a8af0-32b620db8bcmr3216562637.44.1759485372467;
        Fri, 03 Oct 2025 02:56:12 -0700 (PDT)
Received: from geday ([2804:7f2:800b:2c45::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb1a9fsm4407283b3a.20.2025.10.03.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:56:11 -0700 (PDT)
Date: Fri, 3 Oct 2025 06:56:04 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <aN-dtHxYTspw3rvQ@geday>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
 <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
 <ac48d142-7aec-4fdd-92a4-6f9bc10a7928@rock-chips.com>
 <aHnAcbXuFqcMXy_5@geday>
 <067e1833-8527-4c66-90f5-d284f7d2ca5c@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <067e1833-8527-4c66-90f5-d284f7d2ca5c@rock-chips.com>

On Fri, Jul 18, 2025 at 11:46:33AM +0800, Shawn Lin wrote:
> 在 2025/07/18 星期五 11:33, Geraldo Nascimento 写道:
> > 
> > Also, since you're asking me to test some code, I think it is only fair
> > if I ask you to test my code, too. It shouldn't be too hard for you to
> > find a otherwise working NVMe SSD that refuses to complete link training
> > with current code. Connect this SSD please to a RK3399 board and let us
> > know if my proposed code change does anything to ameliorate the
> > long-standing issue of SSD that refuses to cooperate.
> 
> Sure, I don't have Samsung PM981a SSD now, but I could try to test all
> my SSDs to find if I could pick up one that won't work.
>

Hi Shawn,

Haven't heard back from you so I assume you tested with SSD that should
work but does not and that the test failed?

Thanks,
Geraldo Nascimento

