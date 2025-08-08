Return-Path: <linux-kernel+bounces-759987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B8B1E54C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDAF1686F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3C6266584;
	Fri,  8 Aug 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQ4m79v6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9211E520B;
	Fri,  8 Aug 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643921; cv=none; b=GWEIN/2nMo/P+1RYat33B1WFYC1PctWVw6HqhhnMWiJYHxMQkDdVAUBh7P9U2G8yx69z1beMiR2Ni0jdFoPCSXl+BTiCbeXMZyO77/yxJ1tmnYhii8x9DkWUjf9IgcIqSySFLVqzBCbUSLil4BwHnY8BRa7wP+r2Samae6M3v+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643921; c=relaxed/simple;
	bh=Nshy6S/My4AOwCLeSRvKnnQrjd3ZB9s9dsxMtxpC4Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyYprUzmtHmfQ0QynFvq4/jN6F0JJQ4UfyIMaFGSLTLc60q3DWjVwJvxoGBWjdriH3239xJAMoDQn8AfD9DBJMp0/DtKBtusLQ4Jehqpf0nJYOKbDsb9FrTyTwNQCOx7uVxBpDHByiKs0sFru3WL5n0TFdhlzoMfmKStUIQTxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQ4m79v6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5497FC4CEED;
	Fri,  8 Aug 2025 09:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754643920;
	bh=Nshy6S/My4AOwCLeSRvKnnQrjd3ZB9s9dsxMtxpC4Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQ4m79v6ZLdbuw1ZdGNtPUvI07Eh0rTfdEgYFhLnMpT7ec3woNhONPZ71eoUx0QDa
	 0i3PiKkSjq3JoHlNMXwGB5wfgSIxLxJv/cyKr1USiTu6jq9nbBiNxPvFCMP7OTnZQF
	 Yh99qiC+AggDFk684ucjRwk58Tls64/vhRGj6yhk=
Date: Fri, 8 Aug 2025 10:05:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc: arnd@arndb.de, christophe.jaillet@wanadoo.fr, conor+dt@kernel.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, luoyifan@cmss.chinamobile.com,
	robh@kernel.org
Subject: Re: [PATCH v7 3/3] ABI: sysfs: add documentation for ST M24LR EEPROM
 and control interface
Message-ID: <2025080853-upload-nursing-3813@gregkh>
References: <20250717063934.5083-4-abd.masalkhi@gmail.com>
 <20250808050159.36405-1-abd.masalkhi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808050159.36405-1-abd.masalkhi@gmail.com>

On Fri, Aug 08, 2025 at 05:01:59AM +0000, Abd-Alrhman Masalkhi wrote:
> Hi all,
> 
> Gentle ping.

It is the middle of the merge window, we can't do anything here at this
point in time, please be patient.

greg k-h

