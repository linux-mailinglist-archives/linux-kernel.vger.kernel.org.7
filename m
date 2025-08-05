Return-Path: <linux-kernel+bounces-756046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A27B1AF21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6849B16DF5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72877226861;
	Tue,  5 Aug 2025 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T457rMSO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DB0220F2F;
	Tue,  5 Aug 2025 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377495; cv=none; b=A4Cqo6+aXgK3B9NOo9555HTGhED6pc4o5YpTs6qUTnB1M2t+8X9B8spz5VA8QClRvwJzOJDxalKR3o9rijtIgWzL64LTtBNB/odXEMcfLFMp8KEoHUpJFiy74TpeisJ25ofKwmuykccn+QoYYIm2u7Wsyxw82zgopyLRGWOqcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377495; c=relaxed/simple;
	bh=/Vjc7dPiKpSMHncnvcg3zB0rZF6suQTb0GyJfrR95ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SabAmw/UXBnEuRaHXAREz00lzge1q7OSzVA8VJr1U9PYgQWw7tf/ElpaoGIVtVHNGkDhOkdNlUPMCJIScpIlZCm3fPY/oxBryBNMOr8U1ZA4I1L6VDtmfhlHtTFeQpDjwVR2oqMHeL89r8eAbhczfXahhFtxqUERClHckRSgIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T457rMSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF66C4CEF4;
	Tue,  5 Aug 2025 07:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754377495;
	bh=/Vjc7dPiKpSMHncnvcg3zB0rZF6suQTb0GyJfrR95ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T457rMSOs2GWm0OCYkOhChWCzuRHcmFgP6+ididzUU9XipN/SiymdU52ZuV/B8+Sb
	 ZC2arXUxo+bqKAeEFu3Ms5BoVZHKsVEkjV2LAWJ2754dyldP02FuqVHDri41RYbRXR
	 IH/rr0XS8E384rGRwonHVhnhfSRcamZNZO3OaOEut5Hxjj6+KU/JryH6J8VqPQOzzB
	 hTbEBnB2dXp+tT+iqFy/xHOdwdI7x7OFb75e6s7H7+DUGrBAolT2lvBaZ5Gf2SbfQd
	 VGcWcwSw5KjxKFmglyVrObpo7JMfCfnrmI3/qTg8wLTvwKnx2Mq5xIX1bxtKiIHQhX
	 V3Cyrqf4ZwYQQ==
Date: Tue, 5 Aug 2025 09:04:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: Remove unused fujitsu,mb86s70-crg11
 binding
Message-ID: <20250805-resourceful-beautiful-petrel-d0ffcb@kuoka>
References: <20250804175304.3423965-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804175304.3423965-1-robh@kernel.org>

On Mon, Aug 04, 2025 at 12:53:03PM -0500, Rob Herring (Arm) wrote:
> The fujitsu,mb86s70-crg11 binding is unused. The driver for it was removed
> in 2017. It's not used for Synquacer DT either like some other mb86s70
> bindings are.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/clock/fujitsu,mb86s70-crg11.txt  | 26 -------------------
>  1 file changed, 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


