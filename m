Return-Path: <linux-kernel+bounces-734217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97168B07E84
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E8B188B395
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2DE29B782;
	Wed, 16 Jul 2025 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aVd+l134"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F579287504;
	Wed, 16 Jul 2025 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696243; cv=none; b=itT7kNLjWT8cjaZ/zzr9Z74IM9EKcpr03g/G8V/qFujXOtfns1cD0D9Ox3w83F4pmn6Bpkr3Tp11hPm7zmuTJRuFnzPrnwTq92bqnEwPvxKCWlQEcivl5VNONZdosN+qnEpZGb/BpBvq4GSm+lP2PixNoZalGAO1fgocexamSTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696243; c=relaxed/simple;
	bh=dzyaocK3PnudR5lSJDMU3mA+PuwrRZaeP95nr0YqcRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qstIm6yLoXnX5m0Zeq610RDxj81ycZuL7kUTdae8Pa7TUtOmD6nO5KNtAl4MnANHNF427bIXVmXBNeMkH+TqFYg2O8HSxggYTD2s4CUSLlGpReUwkyS5GeyDSmtMubQAtqay4I+PjTGCYEI0gk9faIkerngsmj10VbGBoSDOAjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aVd+l134; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EkVfS0K/HCG53carimPNY+RNYNmwCtr9z/a+duBZkbY=; b=aVd+l134yxHndkHhTItFKp2BXY
	eM/DThAQA6KDI5APDGUTdUUzpSGY8ohO2PTGS1eUgtd/H6md9t4FJvB58l9tVREMc+mWgc9QRmL6g
	mSmFMArWtqaf4Lqs3Gf5DYF+ne0rGkgDD5czKlwlhxTgJmOgir/pss03Bkb9bXKySxWs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uc8Lw-001ijI-7I; Wed, 16 Jul 2025 22:03:44 +0200
Date: Wed, 16 Jul 2025 22:03:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Willie Thai <wthai@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Deepak Kodihalli <dkodihalli@nvidia.com>,
	Ed Tanous <etanous@nvidia.com>, Leo Huang <leohu@nvidia.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: aspeed: nvidia: gb200nvl: Enable MAC0
 for BMC network
Message-ID: <17cd5195-29d7-44db-8f3c-474dc5c3486b@lunn.ch>
References: <20250716-update-gb200nvl-dts-for-new-hardware-v2-0-9a1a916f461d@nvidia.com>
 <20250716-update-gb200nvl-dts-for-new-hardware-v2-4-9a1a916f461d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-update-gb200nvl-dts-for-new-hardware-v2-4-9a1a916f461d@nvidia.com>

> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	phy-mode = "rgmii-id";
> +	max-speed = <1000>;

The MAC is using rgmii. How can it do more than 1G?

	Andrew

