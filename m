Return-Path: <linux-kernel+bounces-878710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A885C214AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8F21A60467
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2172DC33B;
	Thu, 30 Oct 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZDcJ3ej"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E02D2387;
	Thu, 30 Oct 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842968; cv=none; b=WMWPmjbXUk5hJzeqUc5pbvEOq47OkdyD/pyNxrlD8Sw42xxsXIds+yZbTUTdxvNuYWx80vKhirzZzCCBufbWD5zvxZ5yaMDOx1+xvcN+TXaRcTINpEJwZ9vq6DnRhXhVkkqMzTQiVEh9xHmTzFlgVwVr1kbPx3co0vDKc4VHk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842968; c=relaxed/simple;
	bh=AZk0JoIU77cQ/15mdVHz+q7ZBqDyfvSLZkLMz29svdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsZVT3FpvQrwOZlLpKn8mZS4+xg1N2Epq+IyqyChmwviqb4wx7pSqJpMTXKVm5IArN8wng37SlOwXE+o5x06BTXT51xvfyzXcQgK8YWuQvaStXsKNtqS6tIyJWwP/TVlSdLLyh/MT5Cw8TY0LKPqAn2nfjlRu3hKu5sEBhvnsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZDcJ3ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6C7C4CEF8;
	Thu, 30 Oct 2025 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842967;
	bh=AZk0JoIU77cQ/15mdVHz+q7ZBqDyfvSLZkLMz29svdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZDcJ3ejqtO7KgEaZb6DMSvsUVFCbt2QBadmhMOZxPb04084dwTJ0Ym2Uk16cALis
	 hS2KFMqOYpOq8T7zEZuijozhr3rosM6/TS9IEVdJAJgv8ctnMXPn+KVe1EM4RBcG4P
	 bOPITXe5dDYq9t3tNNRsCU3i+Jt+4Nhh6itBa7ATYXl62BM91m2DK9Ya7qVXJvZgHs
	 +7QiRa5hsO94n7EMZPe/djnHmm2bHVIbhXL8nm6dzlEL1Y/EFqK1JD0VkCLsPvPk09
	 Dg0pXKQjihmt/xr2dHGuZH99NG847602p+QjDkqjLY2QJE2EczAW60zbqAXQAaA35x
	 2Q7FPiCiTW1lg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vEVqA-000000005Ma-3Pzg;
	Thu, 30 Oct 2025 17:49:35 +0100
Date: Thu, 30 Oct 2025 17:49:34 +0100
From: Johan Hovold <johan@kernel.org>
To: Oleksandr Suvorov <cryosay@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] usb: serial: ftdi_sio: add support for u-blox EVK-M101
Message-ID: <aQOXHngUEO_KUZs3@hovoldconsulting.com>
References: <20251030090056.3175217-1-cryosay@gmail.com>
 <20251030154509.3331963-1-cryosay@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030154509.3331963-1-cryosay@gmail.com>

On Thu, Oct 30, 2025 at 05:42:54PM +0200, Oleksandr Suvorov wrote:
> The U-Blox EVK-M101 enumerates as 1546:0506 [1] with four FTDI interfaces:
> - EVK-M101 current sensors
> - EVK-M101 I2C
> - EVK-M101 UART
> - EVK-M101 port D
> 
> Only the third USB interface is a UART. This change lets ftdi_sio probe
> the VID/PID and registers only interface #3 as a TTY, leaving the rest
> available for other drivers.

> ---
> v3:
>  - Use USB_DEVICE_INTERFACE_NUMBER instead of custom probe()
> v2:
>  - Restrict probing to interface #3 only
>  - Add a device model to commit message
>  - Fix grammar in commit message
>  - Add Link: to v1

Now applied, thanks.

Johan

