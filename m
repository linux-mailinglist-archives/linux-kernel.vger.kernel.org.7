Return-Path: <linux-kernel+bounces-884254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF58C2FBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E12334D2F9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85727587C;
	Tue,  4 Nov 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVgj9MQn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728D2C181;
	Tue,  4 Nov 2025 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243240; cv=none; b=tAXGiQ77PKqyxBxLkE8AjkHbaKzsukcSal/q8C8ppx6JnsvchR5o7jScfyENekjA7odGe69ooQX1kQhxYTd4xDQL62+w4lI2Chv5MQxaoq4HA4DFHLyWE8t0jDWLYxf93v10Ww0V9nFCl/cse3hHA+ib0xX+oYLKpx5myEee0ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243240; c=relaxed/simple;
	bh=gI4iCdit71mE8ghNnG7vuec3jJ4LCtKwql722fHfLuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5avaocqHncloueWc1JZAOIEaFNXV8Lf2srzxFUms11fXEV9JvNdLCnIcVr3a2P3pCipZAkamuTJ8UVAR7A/ufOUzqokkBVuIhPa5k/GsMUc1ap3NvMspNl44Bun5pxCg2TUk2InwFLlDTnN7sSWy4hBpm8RKTkJ7J/Hb8QC1qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVgj9MQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D64C116B1;
	Tue,  4 Nov 2025 08:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762243240;
	bh=gI4iCdit71mE8ghNnG7vuec3jJ4LCtKwql722fHfLuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVgj9MQnLSWQ1We1uuCKMV16JQZS4JmApodJKO0/xvNMbcuz+zwF7QIeJv260kJbZ
	 iB9Qm8JW/LNUL7whA8IztDEOuVA4RaClxtaGrN4JTENCuTdm4FE5qk0TxJPFq4euMB
	 T1lWC7SiePHRtQrsFk3mkstlHac53Y5cJF0IkzmWr2udDLDXW15Pw59TJEJEOaE5qT
	 /R8sJjpOHd3nkKnxYorxIKvXnAZlKHmkDcWuauuhXdFoXtFPJsShp9YCbW0D+Vzhit
	 x1cICBLmkcLA0LqfZCCdSMzZtsv7T6f82A7pP2lS2lz3ncmpM2xJpSkLaJxF8n4Ibi
	 D7ZG3EVX6codw==
Date: Tue, 4 Nov 2025 09:00:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>, 
	Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: vendor-prefixes: Add 9Tripod
Message-ID: <20251104-warm-godlike-coati-b61cc5@kuoka>
References: <20251103171702.1518730-1-coiaprant@gmail.com>
 <20251103171702.1518730-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103171702.1518730-2-coiaprant@gmail.com>

On Tue, Nov 04, 2025 at 01:17:00AM +0800, Coia Prant wrote:
> Add 9Tripod to the vendor prefixes.
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


