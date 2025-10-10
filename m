Return-Path: <linux-kernel+bounces-848610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E462BCE2AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D0CB4E55D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A23258EFB;
	Fri, 10 Oct 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlARGstR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87AC2222D1;
	Fri, 10 Oct 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118854; cv=none; b=EG4BvJEXwxDSFJRt9mbnR/rfHHiChm4EnhVfXbIKj4csufFPz9yrGGnIAc3ZDu+Dgc29FzlvRYNbrbEISQlMSrtcfnHgHoSzHB7yiJiCkjemzxOed0xAX9vyNcbgRLqYC9Ok8MMBNz2m/70p/I1l57JQ+BoW8oSN+7jIYnSKIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118854; c=relaxed/simple;
	bh=Zr0cuYuUnGaKMo/4+E1jCt7zk7lWX8ZFj/PMeVWvQf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/DC9vv83fW2WymzeiwbBHmOyZoCOQOZwduwRLUkl4nEXOUYO58zEQ8UQKF0jMmTpWvVd/diIDuHN7KZ+Xsu/TSekQhrTr/a8hOn/bowFIQhg0XvIiDpfBzLTBDmMtVaFTyfDAvfYPUQB+qPkNiK7RYOgUKitXyJ49/sJDQuU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlARGstR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38B8C4CEF1;
	Fri, 10 Oct 2025 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760118854;
	bh=Zr0cuYuUnGaKMo/4+E1jCt7zk7lWX8ZFj/PMeVWvQf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlARGstRZsJF3VIGuqcFQH0bLwR/rG+egAAwori6HyBXNsvPhhygNNk5Iz4dv/W+Z
	 2o05jC1AwC6TlUU/4nAcPzzw5PQLBvNc1QHeUeCjXU6oithDFLERbn/ugFoYBkLUao
	 EO9/WT9i/fxxV8zuZE/gKtxwPwFxPhYfId63X01TGO/n9nP4j7jH0yhH9LjD0fij+C
	 1kjWTJAQeNEkdMYDHXGSNSBBPUBeGZIIEFMWEZjJVPyVSVfqCzb3yDuib6TKo2OcPr
	 wWTpixFW8UzMoP0OaZDjGgvf9hytRrUi6BPqMjbl+7KS4Gu7mWcuDPchBqBaCTQqq0
	 68CqBvi4Q13sA==
Date: Fri, 10 Oct 2025 12:54:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jameson Thies <jthies@google.com>
Cc: tzungbi@kernel.org, akuchynski@chromium.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, krzk+dt@kernel.org,
	chrome-platform@lists.linux.dev, bleung@chromium.org,
	abhishekpandit@chromium.org, heikki.krogerus@linux.intel.com,
	ukaszb@chromium.org
Subject: Re: [PATCH v3 1/3] dt-bindings: chrome: Add cros-ec-ucsi
 compatibility to typec binding
Message-ID: <176011885172.573621.9898510592268600053.robh@kernel.org>
References: <20251009010312.2203812-1-jthies@google.com>
 <20251009010312.2203812-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009010312.2203812-2-jthies@google.com>


On Thu, 09 Oct 2025 01:03:06 +0000, Jameson Thies wrote:
> Chrome OS devices with discrete power delivery controllers (PDCs) allow
> the host to read port status and control port behavior through a USB
> Type-C Connector System Software (UCSI) interface with the embedded
> controller (EC). This uses a separate interface driver than other
> Chrome OS devices with a Type-C port manager in the EC FW. Those use
> a host command interface supported by cros-ec-typec. Add a cros-ec-ucsi
> compatibility string to the existing cros-ec-typec binding.
> 
> Additionally, update maintainer list to reflect cros-ec-ucsi and
> cros-ec-typec driver maintainers.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
>  .../bindings/chrome/google,cros-ec-typec.yaml | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


