Return-Path: <linux-kernel+bounces-853006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDDABDA6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAFF1927312
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64EF3002A4;
	Tue, 14 Oct 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k81eDsS7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A964214204;
	Tue, 14 Oct 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456195; cv=none; b=M5RwdK3YSy6CQegmcYtNbKp+/GKveZhrpvT0TOijDofjFugksB+2Fb3FqbFfMhptyqZF+m1Eko88yLJNM6hwDcRPxQ/mYDZ58luRZoWthuKYdLoXo9fS8OIstaHWtgHofJp6fTVT7UJnLpXibH66nJq9botbNwwUsuTNh68K794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456195; c=relaxed/simple;
	bh=VagKz2PhnbcBWgSFvGAIXlZmOza2o54TedTg9Ko6NIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbSKQodvfARGdowrNdni9lJG92h8y4bC5syZHwYRZb0USXIEw8jW0IThRbbV5ucG1cg8QCSHLoKbUYTMqkOxSfbGeZAQM9DrWKyjsVxcFlp2s+fCvBtXyUMQ/2IZcQJA7mHRyTlQ7WCIwiuLsufhy+Inu3Gfl/ICua4pXUG27xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k81eDsS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F04C4CEE7;
	Tue, 14 Oct 2025 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760456195;
	bh=VagKz2PhnbcBWgSFvGAIXlZmOza2o54TedTg9Ko6NIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k81eDsS7Vsh3bkfaXfHRidHFpYhx3cWZ9Y8iIue/d1v7QK51HmYFVulPUfM82lkuB
	 3IzrVbZOB5cLye2qh16cGLL1QVP5fceeAot7SMlg7eIZPvhQNMJxhi+QEK1mKII/5H
	 pra3N6nUaxmVgVdJk4H9jpEU/4WiMHxh9VonFsBGRIKaVvnRi3G45048LjDtEs+quC
	 icdagfycsqCqmbS3wse81LeoWt5K+E+hTvR2hmWItFVhKdqcpzqxJWOOkBl3KLsoUv
	 +z84lsHV6HQKZ3Pl/lrdjPZuMSC8pvyOt7Th4ozxJG4QQ9r2DQSdazWSNrYM9pQYko
	 6JsQCtfGmcYRQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8h4j-000000004t8-44xk;
	Tue, 14 Oct 2025 17:36:34 +0200
Date: Tue, 14 Oct 2025 17:36:33 +0200
From: Johan Hovold <johan@kernel.org>
To: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw,
	yu_chen@fintek.com.tw, hpeter+linux_kernel@gmail.com
Subject: Re: [PATCH V1 1/1] USB: serial: f81232: fix incomplete serial port
 generation
Message-ID: <aO5uAUknTLOWdvUY@hovoldconsulting.com>
References: <20251008023858.227740-1-peter_hong@fintek.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008023858.227740-1-peter_hong@fintek.com.tw>

On Wed, Oct 08, 2025 at 10:38:58AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81532A/534A/535/536 family relies on the
> F81534A_CTRL_CMD_ENABLE_PORT (116h) register during initialization to
> both determine serial port status and control port creation. If the
> driver experiences fast load/unload cycles, the device state may becomes
> unstable, resulting in the incomplete generation of serial ports.

Do I understand correctly that you're only seeing this issue if you're
unloading and reloading the module (or rebinding the driver through
sysfs)?

> Performing a dummy read operation on the register prior to the initial
> write command resolves the issue. This clears the device's stale internal
> state. Subsequent write operations will correctly generate all serial
> ports.

Does this mean that the retry loop is no longer needed? Can it now be
removed in either or both accessor functions perhaps?

Johan

