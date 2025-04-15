Return-Path: <linux-kernel+bounces-605174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E146A89DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBBA189C73A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540582951D6;
	Tue, 15 Apr 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B964Yq16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27012949EB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719673; cv=none; b=p+R3blB4dFQcV9DakySdFMWtiAFSqWjg300DILF7ok60itavgrYEknleigNC4dXv3NnuzLiX4xRjNPa0+RMOMaXxRWukdiru72jL2tCUVmzcUiAyb6eryRGcl0vmlAaRCe8bPnBpn00I0G9JNxJt3lhW13Cwe05z1cIJgl1yMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719673; c=relaxed/simple;
	bh=/ogKlU8mi+r1HPqgDOJGim6BQwEl2fj4J7xCC17Bvdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILYyrxajn9ICNIsVFUZ41WPZNvFc0pf2YaehJv/JseBrpY10OVL4bjcJ5O4Ef649b3UwVvogteVmetxZKwYgo31ZJMOQiWPkJMYSTjW4ADBDeVi4eC1gObOmEALubBNYhtS2xrGH/VoCtPESocJnmLnoXmJRPwEtaL6pjStpF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B964Yq16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8326C4CEDD;
	Tue, 15 Apr 2025 12:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744719673;
	bh=/ogKlU8mi+r1HPqgDOJGim6BQwEl2fj4J7xCC17Bvdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B964Yq16KihoANROHIQbDaMG6Gr6HM6UTxtU1hO/yyhz0YKfegBvzBho+Hvl/2XBN
	 SDs/9BSUdAgPGV+CbbszZR6u3f9u1zcMZWuzsxysP6l7pDkd7z+qH4a9oexzNZvsDG
	 MDosAOTWKypfXQTuzfjKN1XOA8nuykG5C8P1B9oU=
Date: Tue, 15 Apr 2025 14:21:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] driver core: add helper macro for
 module_faux_driver() boilerplate
Message-ID: <2025041510-virtual-flagstone-8b3f@gregkh>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-1-e6cc73f78478@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-plat2faux_dev-v2-1-e6cc73f78478@arm.com>

On Tue, Mar 18, 2025 at 05:01:39PM +0000, Sudeep Holla wrote:
> For simple modules that needs to create a faux device without any
> additional setup code ends up being a block of duplicated boilerplate.
> 
> Add a new macro, module_faux_driver(), which help to replaces the
> those duplicated boilerplate.
> 
> This macro use the same idea of module_platform_driver() but adds this
> initial condition to avoid creation of faux device if not necessary.

What is this "condition" for?

Every time you put "true" or "false" in the function call, someone will
have to look it up to see what is going on, that's going to be a pain.

Making apis is hard, let's not making using them even harder.

thanks,

greg k-h

