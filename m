Return-Path: <linux-kernel+bounces-721338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFED6AFC7D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64725651BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D3268FF1;
	Tue,  8 Jul 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvaRso4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47380229B28
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969092; cv=none; b=POyZK+EiXaCJrK75aWz1/5IJYDtLWC/u8LS3QF8XKnzemw2ybAUgGbvq1ix2r0XOS9rLh1sbbaWE7krNphQnWHM7718x56ikPqE6m28Mx+tOdgmq01c9X9UkblkNovBoIu5WHmsvIdvVBWmsC5/R8dYYbjB/b1CBIv1/XoCQeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969092; c=relaxed/simple;
	bh=axAfwLA/0diOyOxAAf/SpGhS+6JrE0mqKg64pCYrEuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvlTVJS+bp7oPP8O6RbK32d7VZpI6OOsRsebzkvuNePvm7O7ZeduftWjJ9m6+lguIzIGjSZv8QSN3a3V/s8eSYgY6vo67l092InAA9Ng52KaiwEISLd6N9UzTmWSnA6bLCTxNeMmWYiRaFIApfpXRkl7gybDezRf97d64JeLehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvaRso4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93C4C4CEED;
	Tue,  8 Jul 2025 10:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751969091;
	bh=axAfwLA/0diOyOxAAf/SpGhS+6JrE0mqKg64pCYrEuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvaRso4Vi8fmj8w/wX8luHqFY4W1yg36OW0PO+hjl7OTSmTOJo6hegcXax+uRl1NR
	 XKOMwYPeXYaCQN4J69lVV/OPSZLUTuTvI12xShoiez08OU1huTlxpXLLNTRG0Jl5EP
	 OT6/bgpeeMYfBKW0gYsWCiDlPTIuC9BtCeH8ARzC/ieJPNeQ2NUS32887Y0CGm9XoA
	 LWa/tQa0rFzzELWU55BA3SB7/1tPHhOS6dHAcnpYoeIbL3aoQu+d0TjtI/OM1YxKBR
	 6qoJlZFC+c2KVNsM5NJUJsSmjh/5Dy9i42qNMVdn24aiAkTqfdOBz9Q7UATm5yr9Ng
	 mHxPuXBXJzRiA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZ5Bq-000000006MX-3dz3;
	Tue, 08 Jul 2025 12:04:42 +0200
Date: Tue, 8 Jul 2025 12:04:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: auxiliary bus: fix OF node leak
Message-ID: <aGztOnNKu3gvFH2_@hovoldconsulting.com>
References: <20250708084654.15145-1-johan@kernel.org>
 <20250708095908.GE592765@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708095908.GE592765@unreal>

On Tue, Jul 08, 2025 at 12:59:08PM +0300, Leon Romanovsky wrote:
> On Tue, Jul 08, 2025 at 10:46:54AM +0200, Johan Hovold wrote:
> > Make sure to drop the OF node reference taken when creating an auxiliary
> > device using auxiliary_device_create() when the device is later
> > released.
> 
> I'm probably missing something, but random grep for the
> device_set_of_node_from_dev() callers shows that none of them are
> calling to of_node_put() explicitly.

Yeah, the platform bus code takes care of dropping the reference for
platform devices.

Johan

