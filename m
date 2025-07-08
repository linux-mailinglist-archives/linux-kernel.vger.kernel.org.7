Return-Path: <linux-kernel+bounces-721001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA3DAFC33F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450381889E38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62532222C4;
	Tue,  8 Jul 2025 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SWoxfese"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241F22126C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957351; cv=none; b=OLTixL6sqCP9NnInoOFXzkrktMl5jPraQHA1RWru92emOGzeTooGh+gwyVvZTi2/yHcQItL3MvP9r1FA/24wxW5BItKkaRyx2yu4fBT5yRZUxHxOt3xhoZ7qnep/EUhYvlEIXqbsQ06dwhAnQqBMSe0hPO3eFvecMcdrSn3SYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957351; c=relaxed/simple;
	bh=3k185cUYo5bJWuw0CqBWooFjPzqcQhBT7MHlU0zMS7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4uf3DGc35oewBBhHKGE1GpTIJj7Q6IGi4/ME6VY4pgeb2POX6YAcD5vesym66gkHBW3pdc7IK7mCIGhBNtdEZnGgf6n+fHsYMXPmgzdFFHHSuCTWcXeod2tzW9wqmveVypHi21LLm/dJ9A7LpxCdrL0v+bYjl0/nqeAG/7gyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SWoxfese; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DDDC4CEED;
	Tue,  8 Jul 2025 06:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751957350;
	bh=3k185cUYo5bJWuw0CqBWooFjPzqcQhBT7MHlU0zMS7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWoxfeserAco0gSB/pwkKURGCnk1ZTPqebJj9VUfCzyeZwbXdGxWOKLCaKSRCaOMu
	 /1XCcpWw29trF53Ip13jQv37XTRMPT3XzKmjYktLGxI2xKggOYFwaW/jyBg1jDJqnk
	 YbsB1BzLmMIZ/8Mb8yxV1umzBGPgFDttaN65zwDs=
Date: Tue, 8 Jul 2025 08:49:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com, alexander.usyskin@intel.com,
	daniele.ceraolospurio@intel.com
Subject: Re: [PATCH v7 0/9] Introducing firmware late binding
Message-ID: <2025070824-uncertain-exit-eaf9@gregkh>
References: <20250707191237.1782824-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707191237.1782824-1-badal.nilawar@intel.com>

On Tue, Jul 08, 2025 at 12:42:28AM +0530, Badal Nilawar wrote:
> v7:
>  xe_kmd:
>  - resolved kernel doc warnings
>  mei:
>  - Address v6 review comments (greg kh)

I don't know what comments you addressed, please be specific, as in the
past other ones have not been addressed (i.e. the .owner stuff) and I
had to find that review again...

thanks,

greg k-h

