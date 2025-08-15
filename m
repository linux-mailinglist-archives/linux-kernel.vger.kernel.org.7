Return-Path: <linux-kernel+bounces-770603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09EB27D08
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A1E1D22B39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D182652AF;
	Fri, 15 Aug 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTT5eZmJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AC253B71;
	Fri, 15 Aug 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249513; cv=none; b=eyofO+Fl+bCVdTIvLhnjKeGCIClreFK/AAqDjkbAx7mfntncUvHKAsEZl3TfVltwzEBjanBR9IrBdamGnVl5+UBQGh7u1H2Uq3xykv5HF4R8DgtT0Z8tVfgtkaPHsdbyaYQDBrr9j9hpyJ7/2vgsd8Xh0p25/BkCHsQk5u+5Wvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249513; c=relaxed/simple;
	bh=OAhP4pnINSG9cbE7YiRCjM3AMJVFGT5BsUcm6lXsRR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXwlhcyXe0+bmEnjBoh3rYNRVbDKt4+3DchuytW80yeO8PXbbeJ1VNEn63+bDZmDgnFV7NNFzWgk86xGFovJD8lp5tUQ7tzIqJKvXl8tOS1ha26kxmmqyyer8WXb/5s5X7so69Qlh8hLJcHU2bDt7S6kerGGGqYjsqPDr0xJk1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTT5eZmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53631C4CEEB;
	Fri, 15 Aug 2025 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755249512;
	bh=OAhP4pnINSG9cbE7YiRCjM3AMJVFGT5BsUcm6lXsRR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTT5eZmJFiM1XNpcYJmojizp9lEU8B7j4PUlvuOlrK0aZYPmwyB61FU5u6VPsDT/T
	 aJnocQkDuZdVk+1HospEKiijgaPmVTWIwCLPs9T8aexqnPXrGqMCiK0LvZXCUzcKyy
	 neoa+VqsO6xZ+xZT4EQZ5nuPQpoGw+RN5aMT0SRuMfZeodX/wJjV//5gxF/FwVmNFm
	 bi5Wx944EJr9UjE+V71bGhBkpPk9c1wzrP0Kk0Zn16Pxw+7yEmfjl1Bwz46k3sExLp
	 iJzzuBWbAFzfyENEPUoTAkh+Tq1uiPdNPjLUq/FqgKuhi10z6krP9gSPQzpbrWwfRa
	 9y2acZa39SnEg==
Date: Fri, 15 Aug 2025 11:18:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, fe@dev.tdt.de, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: convert lantiq-cputemp to yaml
Message-ID: <20250815-utopian-fine-wildebeest-9d8fa1@kuoka>
References: <20250814080708.3054732-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814080708.3054732-1-olek2@wp.pl>

On Thu, Aug 14, 2025 at 10:04:41AM +0200, Aleksander Jan Bajkowski wrote:
> Convert the Lantiq cpu temperature sensor bindings to yaml format.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
> v2:
> - added reg property 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


