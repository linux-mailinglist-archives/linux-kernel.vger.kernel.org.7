Return-Path: <linux-kernel+bounces-604388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F647A893EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 08:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46A33B4D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 06:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D81275107;
	Tue, 15 Apr 2025 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9alKHhP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D031EA7F9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744698409; cv=none; b=sn2P0ts4Z6UBbSpUIA/1b/GEVN4peUbI/R8FGNTUfDaDMNX9Olp9I3Doyq99X/2PTACnHHMYnCsek/UE5WSP1g8iTR9Ww1WRZZhWKvjyK7s1tVDg94AQFJd3FZMxzMBO6dRdJJJ7wGKJkCDdEBv1xenw4SHjZb3O71qMOIwhBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744698409; c=relaxed/simple;
	bh=cH0zVjnqW+RHOCp3AmAFFuLsrHYcF6rjvqyBG6R9P8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyrGfznbZrR+8VRIQXokqP2+4yHW+hJVrGmXj3EdfqQQ1Rz8od7YsmLQGEuscNYzm0K+jTElO6dYWVPm771VTBtUpheaKubO2kCL1eZ+4SaUFfblB6xJ672CD6Ojh6A/VgZanfbXxGQXeyM/0msh4vTGD54O1Kcl+pZWahNQWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9alKHhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27716C4CEDD;
	Tue, 15 Apr 2025 06:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744698409;
	bh=cH0zVjnqW+RHOCp3AmAFFuLsrHYcF6rjvqyBG6R9P8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9alKHhPgb/6OCh/boTyziqv7vK83o8tz26oTPFR4A+8UnnF3Vz9t18orcfPaF+M5
	 uVVRtt6b0CtN1pe7M/OHxFibV3LgOVlg6jMv2fMNl9KK9PbE21JFWzv0m0A7IWmHDb
	 piYnN1XWcwxChw79beO6vWTtx3JUTYy4F6APPlH8FAqxwnWBiegRcQncuyKkehLmEj
	 5wYJjP3VS1oumu+HrVlHaD5rI880JpamsAAe4lZbThE4zp/tqwUht5NKqmdFa7bqVT
	 JyqFx8gtsoyNqzLpLpyr1jj9j7dcX5v6NXtsJf8Tsdlc8+b1qKknM/H+B32uR8hcuW
	 AnllKHqrkOj8Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1u4Zkr-000000003pj-3Fxw;
	Tue, 15 Apr 2025 08:26:45 +0200
Date: Tue, 15 Apr 2025 08:26:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Peter Rosin <peda@axentia.se>, Johan Hovold <johan+linaro@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mux: suppress lookup errors for mux controls
Message-ID: <Z_38JaJLNXnq1STb@hovoldconsulting.com>
References: <20250414124220.30578-1-johan+linaro@kernel.org>
 <c0f63b8a-7197-050a-ca01-a1050a2e287e@axentia.se>
 <Z_0VMCmfnDZxd4GC@hovoldconsulting.com>
 <20bc473e-3386-443d-8350-f6718e7903a0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20bc473e-3386-443d-8350-f6718e7903a0@linaro.org>

On Mon, Apr 14, 2025 at 03:35:03PM +0100, Srinivas Kandagatla wrote:
> On 14/04/2025 15:01, Johan Hovold wrote:
> >> Srinivas Kandagatla is looking into optional muxes as a side issue to
> >> exclusive muxes.
> >> https://lore.kernel.org/all/20250326154613.3735-1-srinivas.kandagatla@linaro.org/

> > The audio codec change introduces a de-facto regression so if you want
> > something different, we'll have to fix this in the codec driver directly
> > by checking for a "mux-controls" property before doing the lookup for
> 
> This is not scalable solution, we need something in the core to allow 
> optional mux like any other framworks.

Maybe, but that's not something that exists today and we should not
knowingly introduce bogus errors.

I'll suppress the error in the codec driver instead and you guys can
continue discussing how you want to rework the mux driver.

Johan

