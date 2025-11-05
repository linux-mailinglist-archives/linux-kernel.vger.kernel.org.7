Return-Path: <linux-kernel+bounces-886574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC5AC35FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F272A4E8790
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430D329373;
	Wed,  5 Nov 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw9beKfN"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80121328B7E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351852; cv=none; b=fBKsp71ZvhpE9QaXhgW3YgaNVhGkuDP+DE68ms4zx0Hxm/iLqMfZ0uMKljBX5nbqiKRKVu+GD2cmTe3Lp+wGsglalg9gBz8TKPSnfICsH90me6bY4WUFC9Bu+RFM/YM9yMOGHO7pAdnRNrolsw5WiugirsgdDyXuTp1y92vwxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351852; c=relaxed/simple;
	bh=mRuQZWQhHY69wrczhADWjwgEPB1Sd9u3FTdMsO8GQMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWU0u4DRRv8IbFZYpU0JMrEnKPybtmsjUZOTTwNLoviqH1RVa7Ff/qRA5WFjgomnuyY5Zs9m8eUcWq54BqU/N/pU9iG/ZMOeGxg2pmQDyQi8bb5utiX/2QjiqwhQhezeYo3k0weDQkkDIZHewnBkD/o6U5+Abh2oXzryS9B9UHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw9beKfN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so4988525b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762351851; x=1762956651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=emw78z9qBdbJbPp/EQh1B0+OlLxBNj7DeALk66qoJtc=;
        b=Sw9beKfNlBl/jJ4+IGuzrHZyDt525OZsM5Kne4Nner6VLVp3CSaU7w6wfVdXm+U8aQ
         vRpiW/XiOkRzwrayFsZaaMe8O7j6MJC3dCuwrgjHv0IGQMr7zhJ9Y7pnz+WBKSWjfYjR
         H4PFULU1K8X9hFEAySdatuT881wxfs915+5tqm4DerJfBYorxBqNZFUxhCNNJpxJ4vO5
         RsC3CTDyRoRvhZG53lh/s/ofQYdovQrzhwGzEigY3JbqJ+DWoTFpbRKBxiIALjpwVlj+
         H1wSMnilYNK7lFz1CA9q9PPiQmcU8/B4v+ApcIEomMJTy9G+J9Ez2HREvQfhhlx8UR1k
         7eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762351851; x=1762956651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emw78z9qBdbJbPp/EQh1B0+OlLxBNj7DeALk66qoJtc=;
        b=bLo+9/8hS+EZDxNwPAjpDPnY0cUTNINCv/XNUsjnMOeyIiB5lbukMcrt/JnQE1I7MK
         G5/DWB8Q6lU1n/dwJ9ObYrmlLiVhOeG+y81W98Na6KGVmMAgNmS5F+8wX2p5hSokXlq0
         WXjhrxjoQFqI4BdyQFMXVwTY46CoxLEaTgHPiNMlyEb5wWzArj7qz2A/PMYzQzHSsK0M
         l16UzaVcWfRqOWA3LE+z1+SD18H70Szjf2WWX4EphVp7Jii3XP9eLDyfLQElqhED4H3K
         yE/DO0j6GR6Y8au08NxrcTzaOQ69r/qRDDPMtaIkBy1r519mpDir4lNu0LWDamIN4znC
         uV3g==
X-Forwarded-Encrypted: i=1; AJvYcCWqLSq0yb/cpr2TsDuGO3AAuzCTYidKngztXQJ+8lhe8LronRhtoG82V8NKBOQXZGEYYTryttr7Zezb3qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGszkuaN8ocrF5qEq2ByvbWozj08N1pwZxtxb7GKu6rSuPbcFQ
	VdLg2YCpdx9TQbP0Pk4OGQ4B55e400QFnw9daaFPJWEMDjC5vfwU6vBN
X-Gm-Gg: ASbGncviLXExpNFPfFWg1xU/2Y1hMLECxqLav6WN6atkGwEkLklTzp0untKcfZ2ebg/
	43tZq4YMHLmVdB/72krll5lm4A/PMgVCLVxjZzpYNvGo/6exzNlQNLuOo7fMycQM3ZUtTKhMp5T
	uquG1qKufvke76Tq5EY7WmA1PXR913J08Py69xrSLXJhCFURs/fLbu64TNEKxwQ595DwNI0b5Hc
	uRn4njeCN0jiSPr0WqFCyZdx0nbrvCS0jViTovbP/sSOceagnDlFyRgov3wVn7wHeBHwyXKuQq4
	m7t/caRVaJW3h2KQe41zYSOTpOXieUPi6g7MAlgwIFrQGE7gaFZCedryqs4UfgGnlMoGEWqw0Kh
	3I4FUmlZ0lpOC7ghvm3fiFopNaX5bUKCg0Vjeq49295c+2HIx61vy9A2rlu5ZUOnYjcHhitcM6N
	vO30oK+zW7xvxs1XK1EPgD8Q==
X-Google-Smtp-Source: AGHT+IHL8owbIlMZhQdZY+kk5sY3XFA/9Cm7OjnUeEHELUCKbLuEvSBGY2pLYFJdOYYls17ySipyKA==
X-Received: by 2002:a05:6a00:816:b0:7ab:6fdb:1d3a with SMTP id d2e1a72fcca58-7ae1f294128mr4332619b3a.16.1762351850594;
        Wed, 05 Nov 2025 06:10:50 -0800 (PST)
Received: from joaog-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6dfc8f8sm6344428b3a.72.2025.11.05.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:10:49 -0800 (PST)
Date: Wed, 5 Nov 2025 11:10:44 -0300
From: 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Kishon Vijay Abraham I <kishon@ti.com>, Swapnil Jakhade <sjakhade@cadence.com>, 
	Andrew Davis <afd@ti.com>, Francesco Dolcini <francesco@dolcini.it>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: TI K3 AM69 Kernel Panic when PCIe Controller is Enabled
Message-ID: <oawjd2mscz2untz6zc5mqn6ak2oxdul6pnaexiohe6ae3bow2r@afkvpu4izrvt>
References: <pod3anzbqdwl3l2zldz4sd47rtbruep72ehaf7kwcuh2bgflb2@y4ox65e66mkj>
 <cf751cf7-53a5-438b-9903-903bd8c39b23@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf751cf7-53a5-438b-9903-903bd8c39b23@ti.com>

Hi Siddharth,

> The E2E thread above leads to another one where the issue was claimed to be
> seen only with the usage of an external reference clock, and it was fixed
> with the usage of the internal reference clock. Does this hold true for the
> board that you are using as well?

No, we changed to use the internal reference clocks on the current
hardware revision (sent upstream on [1]) and still have the same issue.
Please look at the PCIe nodes in [1] so you can confirm this. For
example:

//file k3-am69-aquila.dtsi
/* Aquila PCIE_1 */
&pcie0_rc {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_pcie0_reset>;
	clocks = <&k3_clks 332 0>, <&serdes1 CDNS_TORRENT_REFCLK_DRIVER>;
	clock-names = "fck", "pcie_refclk";
	num-lanes = <2>;
	phy-names = "pcie-phy";
	phys = <&serdes1_pcie0_2l_link>;
	reset-gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
	ti,syscon-acspcie-proxy-ctrl = <&acspcie1_proxy_ctrl 0x3>;
	status = "disabled";
};

[1] https://lore.kernel.org/lkml/20251104144915.60445-1-francesco@dolcini.it/

> Regards,
> Siddharth.

Best Regards,
João Paulo Gonçalves

