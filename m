Return-Path: <linux-kernel+bounces-724915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E45AFF87B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B32563230
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E84621FF23;
	Thu, 10 Jul 2025 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AniwO8KO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74036D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125518; cv=none; b=KSlhgBxFO+t08ZEDVXyIO7xcoBa7LWugXsSB89W2IOr9YI32Rae5YjNED1aRPra/SqOGd9YM/uAh9lYlqdVclvxggYHbH6vke4C+wA2mu7lHyk0geN0IL+pCdtDWUs5LwNs4MlOALl6XoKVDinCwN8saoHNyBQ7eLFIDlJ+V/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125518; c=relaxed/simple;
	bh=vXm5iJ/U5sspzZgJxttAzzUlEL7waF73t1T5vOEzYns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjZ/HXY0pm0XW0Pl3bc48ilSKhwORH1bFf5D1w8ZT3D+ckAYZqY5zoWYtAWUi0fEwBjPtltAgssfS1qz6Zx7H2p4TiTd9WreOL69i+KmXByk/OM6UL+vYZfYB7KDalugyVwkBNyZuAxhL3Cav4v/IYF8wCNxsorwHDdze9XUoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AniwO8KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1BEC4CEE3;
	Thu, 10 Jul 2025 05:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752125518;
	bh=vXm5iJ/U5sspzZgJxttAzzUlEL7waF73t1T5vOEzYns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AniwO8KObV3eaCuNULUED5Tb9Ynrv6i6oQKo/78LS8ZHq0rSn955ynSwWw35wEXfa
	 B8Fapn0HBGTw2JrEu/ipn3JsqG83EIRt1QpDuAGahUcOGbk2zvw2wWKcxSvok08wZ9
	 aIQ2uRMI0muN4D4jFhKZo/YqMvTAHJYxl6YmNZIk=
Date: Thu, 10 Jul 2025 07:31:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next v3 1/5] mei: set parent for char device
Message-ID: <2025071040-headboard-frigidity-c6a2@gregkh>
References: <20250709151344.104942-1-alexander.usyskin@intel.com>
 <20250709151344.104942-2-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709151344.104942-2-alexander.usyskin@intel.com>

On Wed, Jul 09, 2025 at 06:13:40PM +0300, Alexander Usyskin wrote:
> Connect char device to parent device to avoid
> parent device unload while char device is
> still held open by user-space.

Again, you have 72 columns to use, please use them :(

