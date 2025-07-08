Return-Path: <linux-kernel+bounces-720990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3BAAFC305
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FC43A8421
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9E7221265;
	Tue,  8 Jul 2025 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wJiuZQHz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683F221F04
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957044; cv=none; b=m6DkEgaKLl8+tRkuJbcRr3rimtYH7feOQ5aG+TBfaD/IPVgwsU9oxkeIYPSX2mcMA/27ON3Vg6Bv1phZFymqkluEau8xFCDy9nPeorAWShfHFvvha57aBDqQzKSkc4F0ElJDscfTk0rTHV8Vlu6qwp+AOvxbKg2Dxn8ZwHWHp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957044; c=relaxed/simple;
	bh=DvY6ddnJvY5QtMoG2PLJJjvnCEyDtclB7qg7r18UWHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kj6eI3hwY+xBxHJp2wVa/wUFaE36xAXTsmAtu903u5iOD4ti/1JBdtEg5eSNRLVHpCwnc+x7aPxE/h3azztmS175+tsWeuVl2zbnpkXSaKM6ga5oVMXqAjENyO7TNr+R/uqyikjQ4am98qg1GTrxNXAGpxgjmaoVrue6AQFQnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wJiuZQHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EC5C4CEF7;
	Tue,  8 Jul 2025 06:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751957043;
	bh=DvY6ddnJvY5QtMoG2PLJJjvnCEyDtclB7qg7r18UWHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wJiuZQHzl1uFzTiqyQ9nKSD4j8U8/imXG0WgwSwRJyZW+oAvW0w/xTqokzN5Hr8ud
	 DkpTB7qj0mI6P+mDRc6p7K9/gXWH+nlNi76Bj0SomIcBVh2InxdNq5I9leDz7HHbLx
	 eJcwzWxfqt6acMWew8bCu4Rahs+D2O5yl4KNy3e8=
Date: Tue, 8 Jul 2025 08:44:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com, alexander.usyskin@intel.com,
	daniele.ceraolospurio@intel.com
Subject: Re: [PATCH v7 1/9] mei: bus: add mei_cldev_mtu interface
Message-ID: <2025070816-latch-sultry-0e4f@gregkh>
References: <20250707191237.1782824-1-badal.nilawar@intel.com>
 <20250707191237.1782824-2-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707191237.1782824-2-badal.nilawar@intel.com>

On Tue, Jul 08, 2025 at 12:42:29AM +0530, Badal Nilawar wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Allow to bus client to obtain client mtu.

I'm sorry, but this does not make sense.  Please work on a better
changelog text here after reading the kernel documentation that gives
you a lot of information on how to do this well.

thanks,

greg k-h

