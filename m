Return-Path: <linux-kernel+bounces-843346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC5BBEFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB5454F0FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53682376EB;
	Mon,  6 Oct 2025 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PujDmGmS"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916F244692
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775563; cv=none; b=cewWOB1Yk5ht7eE5Ict/M3IJ/VU/JnN/Rs5dSYY57ymb2W7lL1ggcmpriSfqMG+vjtEvW4uuxbiSslJs78BPQvBjEcVYGNgSwVX1ay//laO5Iox3fp5zipHb4hGpRonYpzZ/k+p8SAtvQgvIx1BvDgBLXSheAwbIN3nOYxnT9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775563; c=relaxed/simple;
	bh=Dj6m4vh4I+aSGB7esG1Hx/YYkGrqbAo4J1raPd5acaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAAkv58KzcmNP19spfaB2Mqc0z0D3oYktRRtjj2WcfrfhQ3/Ujm56Kb4++Jko4G6/FkvpZjxpqcpJRX5Gd4hphscNMn6bwELRTkglOnZYfhJ8oEp0YGGs9HaGRowRp9Id5VXeZxpu9lC0oYzkRYUP3FLo0TJ83GLY5/vb9A6Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PujDmGmS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d3540a43fso55108035ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759775561; x=1760380361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwSuYHyPWLnd4B0J2NLg4Ynddq4RJZuyBAc+JpL56Y0=;
        b=PujDmGmSuclp/MSAl7Ki7Ge2233hL8EypmdA+14CW5MM6nNOSsqeebkCSafiFVoVVr
         ANxVwvxEH/JfPgFzT4W8KOUCtVzVQlIDpM7LdWCSJO1Bk3gFsThmrIy4jHrhQe4HpFzZ
         95gfPN844C3T4D2sbVqAsh6DRbIHZXw7pgYng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775561; x=1760380361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwSuYHyPWLnd4B0J2NLg4Ynddq4RJZuyBAc+JpL56Y0=;
        b=IjCJqRoPAQZ6JyHELEz2Em9V4tH+dTnaBE1tVGm/TPbyyOVLzOkFMND2GTqa6d86OR
         noqOHxHYz0rIlE+lPeLeQKkAEVGHGbOigtCX+9C+Blq7oewR5NyOTAtlKG/1FMoJ8BMv
         rzqGKEyZwsl77KPEFbhL7bHlsJVM+p7cVLtVKBBrH8PNsFQszeV1eIkR7fLeeJfNlB43
         OraZgcthde6IuN0ZkeI9DyDtWStYbirHzX7d5dB0uLPBSOoHHq+R8iOiHtdCr0inAOUe
         XPg07tgm/w8w77wf0Lm7PC0fplFNj/DzqZuoYAuL5IGXVGVjc0iuiZ9zojo0TXQ9yWDt
         rxUw==
X-Forwarded-Encrypted: i=1; AJvYcCXMgEtiIXYeJFNn3gdoyv5OWimduiDr2hO80TQg8D6WqXC3uct1Ym0GKMGfg9wrcAOSij+GEaHUwvOGV7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/UesvehO+F4Dzewx/+XDrdAmbJD9IbRWegJoAP2//g/3ZSGl
	o8nkVuaA5ye0hSFuxAVB7fujY0FaNbpiTVLpJ2Ho7UCmwthLYJALKiz7Xv1PoCgkng==
X-Gm-Gg: ASbGncsXAmhWxIHIhxd3DPG8w8XT3BdHyfumfqCmOatAZRDRuEv7Dtkqfgn5+3MZQyl
	PNuCKSJCGgjWPYhn7Bcr5BK5Ri1dl73XJmo7MTBsoyqeJliNifF63Jtfex6H9cSRDPv/shcxO9g
	ChbZ6zC59qImcI0XS2zs3cuc8sP9cWdivCTAim1gmdh4ytBZPICL+P18oC1Qac3BNLwOJk1RL10
	ceKN/vBWeNWIOSn8V7nMoa54e/7A2cHfRc8SKWtJusqTCt8RSrKj4Afw76B5xwmtjKblh5MWibb
	adQ18/xKZQvfyhvsG02qEIqcUD9+V1I9JzalJFLLQ45Qvrj3cwYTBjHCA1rYp7wtTd0Svt+osRw
	GHDRdD3lQaellAy4qVMy+iQhxpc+TCBCCAonJmNrGY1gsa5SM53Uj9+X1roCLsUyTA4GHVQrFfd
	jmZW32i5TOtMe82MjHKio=
X-Google-Smtp-Source: AGHT+IHyUh9+Wdk2VWGp0HemaJgNqqUfeJ8XAjYRPDqgSqGja/q3alk2W+weivII4Y0JLs+WqyHOXQ==
X-Received: by 2002:a17:903:3c65:b0:269:8072:5be7 with SMTP id d9443c01a7336-28e9a6654c0mr169220315ad.56.1759775560991;
        Mon, 06 Oct 2025 11:32:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:299e:f3e3:eadb:de86])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1108c5sm140090835ad.16.2025.10.06.11.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 11:32:40 -0700 (PDT)
Date: Mon, 6 Oct 2025 11:32:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <aOQLRhot8-MtXeE3@google.com>
References: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>
 <20251006135222.GD2912318@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006135222.GD2912318@black.igk.intel.com>

Hi Mika,

On Mon, Oct 06, 2025 at 03:52:22PM +0200, Mika Westerberg wrote:
> On Fri, Oct 03, 2025 at 03:40:09PM -0700, Brian Norris wrote:
> > From: Brian Norris <briannorris@google.com>
> > 
> > When transitioning to D3cold, __pci_set_power_state() will first
> > transition a device to D3hot. If the device was already in D3hot, this
> > will add excess work:
> > (a) read/modify/write PMCSR; and
> > (b) excess delay (pci_dev_d3_sleep()).
> 
> How come the device is already in D3hot when __pci_set_power_state() is
> called? IIRC PCI core will transition the device to low power state so that
> it passes there the deepest possible state, and at that point the device is
> still in D0. Then __pci_set_power_state() puts it into D3hot and then turns
> if the power resource -> D3cold.
> 
> What I'm missing here?

Some PCI drivers call pci_set_power_state(..., PCI_D3hot) on their own
when preparing for runtime or system suspend, so by the time they hit
pci_finish_runtime_suspend(), they're in D3hot. Then, pci_target_state()
may still pick a lower state (D3cold).

HTH,
Brian

