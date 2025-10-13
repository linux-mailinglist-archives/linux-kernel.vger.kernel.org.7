Return-Path: <linux-kernel+bounces-850482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1246BD2F20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494CA189E001
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3288B26E706;
	Mon, 13 Oct 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FbBgh8/Q"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3992156CA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358004; cv=none; b=iae6TGvn0ruOO9xWSMe4iU1cFLZAQe04aFHvUylvPMJNeEmPxZ5Kr6ao5CKQ5FdbsKSu/vYW15+9y7pSrrKeNktH0fKwR2EqWLVX4JZjGe8zh2XpP6n+iw1N69G0YaMDok3+1OxOsFT3Q+EQCpvI+NKZkD+pvTyFv5VaLK6J5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358004; c=relaxed/simple;
	bh=RDq4Ouk6daol4Yxehl/uk6qaoNWyBRWd6SiTv6b8bvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flVfJkH4jiestxYbISD1RCCM4fo1LZiR6trUIk7DpLpIJeWVG8QuSZlCgrVr6bbkSpw0Eq1tV4Py2WeIdN/wMTSABqdKoSUJYA05CztvuLvuwy0iumHT3xy3B+ZTGq4x/JFwyhKWic7Es4sYQjVdQfuXdDWLw3y/DUxZWYUmZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FbBgh8/Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5+Ov1PnxWLbkimtqI0PvBRGc0E3ZGXwWn+2bRb+6Sb4=; b=FbBgh8/Qx78H9FDkA+ErZNNMzy
	eXInQUkR/jPw4a8uah1EKLJqDunRJR+4BmjZcvhPtvDzMSZOZOn6e82mgzMlo574y3b9vEbtYsgXC
	9exln7qo/zTLXW6qq9pv6EvE8S9fgFhuvYzLUrRIN8D7tOgg5hKFI7tCEa988r29Na/A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8HWm-00AmgN-JM; Mon, 13 Oct 2025 14:19:48 +0200
Date: Mon, 13 Oct 2025 14:19:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johan Hovold <johan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] irqchip/mvebu-pic: Drop unused module alias
Message-ID: <db1b78c0-f3ba-4aa0-974c-89dd47fb5159@lunn.ch>
References: <20251013095428.12369-1-johan@kernel.org>
 <20251013095428.12369-3-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013095428.12369-3-johan@kernel.org>

On Mon, Oct 13, 2025 at 11:54:27AM +0200, Johan Hovold wrote:
> The driver has never supported anything but OF probing so drop the
> unused platform alias.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

