Return-Path: <linux-kernel+bounces-751433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1236CB16996
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BB13B6F54
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEC72E370D;
	Thu, 31 Jul 2025 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhXwz7Ge"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67D376;
	Thu, 31 Jul 2025 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753921139; cv=none; b=h64b28lKlXh/Web0Wt3yjWmsHFHKVj19dqGQ8xHJJ502LUIXF+DseJQ68IUh5QMHUnBtkqMZqZNm0hhlaadCCam+AqQzOy+cXvrnxfgmhluYf8tkHu9+yzgh0o9F96bNXGwdohGQyA+JLjojyAyMxsBXfFkcnvB20p5fosRH7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753921139; c=relaxed/simple;
	bh=cgFGDY9CP21gU4ROyycKkAd09AapJM4BoqCecCiNcCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqiXRZ77bRomTuCz/Y8jTvgiULPRdKUGnNQMEx7GHum9Kdq8FhJoAgxNu8WtHbs4AEvq+ZdoZByGxwwUHPeLWS9Gxkd4ey6Ld6V89Ed45zLiB4qLGwow/d7J0mYZ8544cuIGm8RoI4DqREAcFXdCZYdVFTZ2g7hkG1syVCKncy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhXwz7Ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B46C4CEE3;
	Thu, 31 Jul 2025 00:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753921139;
	bh=cgFGDY9CP21gU4ROyycKkAd09AapJM4BoqCecCiNcCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhXwz7GegLrMQtDt0HbJXhoDs5PzozGXEsyVpAToXagO1yBXLbyXXB6IB9BKjDqQd
	 azoc2FUSlkJuyLThUNDeKnqzBFk+Md78PSS4yQhmNteIYk16E6nMIRH9QfQWoN60eB
	 fpfXH0YLg/9W2H7qsuDIRyt5CbIbek4XLQcVtgbTp7i+5HKDUZNkKKLBfYzuEXi50p
	 KUfX55oBIxQbc/Lnb9rq4L6K7Vdf/2Kg75DLPoS+hRkdD+E+kJnRLWR5+JORMu2nhB
	 8P61hhNY7ihbbUx/lrXivQ+rPSCrdgd0VyXP5lSa8nWNBCENlIj547rRYjUHIlJb3k
	 aumhj4rkhoyiw==
Date: Wed, 30 Jul 2025 19:18:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: lee@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, srini@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: qnap,ts433-mcu: allow nvmem-layout
 child node
Message-ID: <175392113764.1943443.12684318546344832887.robh@kernel.org>
References: <20250730172248.1875122-1-heiko@sntech.de>
 <20250730172248.1875122-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730172248.1875122-2-heiko@sntech.de>


On Wed, 30 Jul 2025 19:22:47 +0200, Heiko Stuebner wrote:
> The MCU has an eeprom memory connected internally, that for example
> contains some mac-addresses for the soc gmac controllers.
> 
> Therefore allow defining the nvmem-layout for the eeprom.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


