Return-Path: <linux-kernel+bounces-750665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A77B15F73
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1111766B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01F5275B09;
	Wed, 30 Jul 2025 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pZNcs1dL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BD294A1C;
	Wed, 30 Jul 2025 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874935; cv=none; b=HpqxSZT6YR37IE7COViTWschiaNBI3CW6wV8gRNmKOCGgFhbcEGNsizziROnF8cD3RFFKx7Q7Y9Yii4aHEpGyI62yMX9WO7PlAUrLLO/OnyyaJB2IPFGOcbjdzAUYPSYF+3JKP2FwxTq6T+14gj9UdkJeb7S+rb/CoWPeDANvdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874935; c=relaxed/simple;
	bh=n9h9ZLftEVUOUKn/Rqm7roMVBVYSMpKs0TPgp3feq24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taaHd8wYAiwVG+7yjbVrTw9raijzM7AX970kIo+F7Y2j79q1Zl148LwxqpJmJCnRrZRVneApHkBLucnIPOr8cI6PceSLohrJEbRFbllqmDIjaKSY1raQ3DLMwEKCdgUZDkDjk6PY6jnBkiIYRhjw8BsIATMz91wHpvgefoNhT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pZNcs1dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A9C4CEE7;
	Wed, 30 Jul 2025 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753874934;
	bh=n9h9ZLftEVUOUKn/Rqm7roMVBVYSMpKs0TPgp3feq24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZNcs1dLgIHnmCC5Tihrdor8CIwm5Pc/nFQ+6aawUkiXYC169g1SanxNxw+YZ7txW
	 wKb/c+yYHlfh8HV+S3tFwted35DWyTbWpF+zLtCRq5Ul/696yzLYzX7/EqwIzOF0xk
	 gLy5ATj2cJNo0JOzgMAaOkeLJU3LOYN8UJxlTLYU=
Date: Wed, 30 Jul 2025 13:28:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Darshan Rathod <darshanrathod475@gmail.com>
Cc: m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: avoid assignment in if conditions
Message-ID: <2025073009-headrest-italics-2430@gregkh>
References: <20250730090411.13044-1-darshanrathod475@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730090411.13044-1-darshanrathod475@gmail.com>

On Wed, Jul 30, 2025 at 09:04:11AM +0000, Darshan Rathod wrote:
> Refactored code to separate assignments from conditional checks.

That is not all you did here :(

Please don't work on coding style cleanups for code that you do not know
is allowed to take those types of changes.  And especially as a "first
contribution", please work in a subsystem that this type of changes are
explicitly asked for, like drivers/staging/

Work there first, get experience in the kernel development workflow, and
then worry about other parts of the kernel.  That saves maintainer time
and energy in reviewing changes that are not correct :(

hope this helps,

greg k-h

