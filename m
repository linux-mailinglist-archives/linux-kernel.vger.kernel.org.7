Return-Path: <linux-kernel+bounces-813460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F05B545C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A94A05EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65992D6417;
	Fri, 12 Sep 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYzMlb6k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C02273D7B;
	Fri, 12 Sep 2025 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666603; cv=none; b=XiPHOdsq4imSOblig3bjHivh988oeTh7UtPW9/X2cumFvypI4vPVKBXZPqRGNkCUTd2XmEcEJZtMXJ3r7ITIvFRG8BRiq1FgByqMGxkgtvEWKXT6wXsX/7lbhkyJ6qYA5n7y4EB9RPguOU2zynCYpEBaS5M/VCnWdoDjgD1yR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666603; c=relaxed/simple;
	bh=4FCfca9lOUW2jYEXxCD/LDK3ftD6DDmrlXIL1I0lCiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnvkO2DaUv2QFXOuLBBTC9jT70tQ0KkQo5HgjznFcZRWwvxJ3bYdlPc38TVHXzt/flLyflpX/AV5+XgfxdlIpcV0+fWV3BENA3JJGYAOcS2OHsFzBHCquWm+vpiTPovQVd+qKxpAje5qjs95rVDlIaQS9QJFxLBZG1qJKyuRaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYzMlb6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4D4C4CEF4;
	Fri, 12 Sep 2025 08:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757666602;
	bh=4FCfca9lOUW2jYEXxCD/LDK3ftD6DDmrlXIL1I0lCiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYzMlb6k5KvdhJkpfLfDS4MsJOGYgcgO9znw43N3PhZdawyO8UolUh4Gx9vCmiD9I
	 J6u/cLJficidGTYRrUcPxNPHQHXBdqmq63tOwp/YuzGly/gZVouakervxxzvI7ZPC2
	 KUbuZR1j0vmLJupCLh7UTriMFJqw8nxB7DQcopzA=
Date: Fri, 12 Sep 2025 10:43:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB serial device ids for 6.17-rc6
Message-ID: <2025091205-landed-fanfare-b9c3@gregkh>
References: <aMPXpwvBXg4ETste@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMPXpwvBXg4ETste@hovoldconsulting.com>

On Fri, Sep 12, 2025 at 10:19:51AM +0200, Johan Hovold wrote:
> The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:
> 
>   Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.17-rc6

Pulled and pushed out, thanks.

greg k-h

