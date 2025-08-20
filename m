Return-Path: <linux-kernel+bounces-778542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3191DB2E725
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B35418908F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06CA2D6E5C;
	Wed, 20 Aug 2025 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjacJnEr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336EE1E7C05;
	Wed, 20 Aug 2025 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723886; cv=none; b=SsN/q9cJyvhfrR78FWW4paUil3MwafnNQYgqnAE9A5SRtcx6G0Olse2TqOQjcbKf8WbPN1qjf49fn9i3yuz9YLPzwsXY5nz6QQMSjGy2d+GahUJbOviOIoEh/XotfrwmhOpDhiGIoJHZLgS4biOnqi48mLykmf9zL+xXfjFQg8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723886; c=relaxed/simple;
	bh=GsmVJZPTsLQEAHe+gxRF/6AYyy9Goq4zhnJSCA0tdL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0OKT7kVUWGSa2xcOkVC/uSzw2/tXjtNUv6syafBy71LVIBAtp/w4GtfNClWD9hIWOPWUNgCgr8zA/k1iGV/Qh++0IQ0BjEsGB7gvZzD7bgGMRdiPokLuPX7zaeTvf1KBtGjcg4a2FCoPW4AUpGUZrPPi5lhO/hXEAn1xrP43gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjacJnEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04BBC4CEE7;
	Wed, 20 Aug 2025 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755723883;
	bh=GsmVJZPTsLQEAHe+gxRF/6AYyy9Goq4zhnJSCA0tdL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjacJnErxYI2KXAognM5mGUqE5eO/3AFANXEDB2ECRNt/aD88h5jkkUv3vpAKshCl
	 KoxkxPhCSP0LGoe3+NHxUNSk0Aeax2t/xTmYCl4SkwxLxAuNr+cS/phUvGrFoWtBXA
	 7J+tFxiS/mAuWffm6WEmTs9Rgf1z+URn9Q9NqQN5eWF9kkAdpZtNxEgL5sFKy6hw9G
	 OZjcKwhi/iquWjGQ8C9AnEeLpj9PcjjUPcJkU1EwI3XLXTlNcbJUT+xHRqL/UbBxt4
	 2LrdcsRq0+PDgjHKqHMWA0OvGT/05/OhWVHpiyjl/vK2kUI1IvSxfmR8v1/YkjIoxG
	 v6RGn4FUuSY6g==
Date: Wed, 20 Aug 2025 16:04:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Markus Heidelberg <m.heidelberg@cab.de>
Cc: Christian Eggers <ceggers@arri.de>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jiri Prchal <jiri.prchal@aksignal.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: eeprom: at25: use "size" for FRAMs
 without device ID
Message-ID: <175572388233.1043073.3428639598454610702.robh@kernel.org>
References: <20250815095839.4219-1-m.heidelberg@cab.de>
 <20250815095839.4219-2-m.heidelberg@cab.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815095839.4219-2-m.heidelberg@cab.de>


On Fri, 15 Aug 2025 11:58:36 +0200, Markus Heidelberg wrote:
> Not all FRAM chips have a device ID and implement the corresponding read
> command. Thus the memory size, which is contained in the device ID,
> cannot be detected and has to be set manually as it is done for EEPROMs.
> 
> Link: https://lore.kernel.org/all/20250401133148.38330-1-m.heidelberg@cab.de/
> Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
> ---
>  Documentation/devicetree/bindings/eeprom/at25.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


