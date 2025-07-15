Return-Path: <linux-kernel+bounces-731133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8CDB04F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC89D173683
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197372D2386;
	Tue, 15 Jul 2025 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/sTA9Kw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726265FEE6;
	Tue, 15 Jul 2025 03:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551899; cv=none; b=DqHYFa3WyG4Igir/a8mxunvSVBF983uCJNDAXzC91GwERi4ddcrI3wIxq4WbYeXKX1V0uWP47zU+F0Qa8oI4bcbFIH8v0Yy1L2baWhal4EMjFkEnN7TYsY3uYchbIi8RUiGJkgu9HA2RwHxBQIH8J18+LzdWRBVtZ2u99ViN5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551899; c=relaxed/simple;
	bh=snS6BZ8HZz24We5fag4B3dSbIWRbSM9y5G7CZL/J244=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5n7dBVM/Qr70Lm4a1mpuXP9Ye+Zj+vm0894cI8bWHYokb2aAVgnfCIPlJr9Mi90FQi9Qmtc/IxBXEM3wmW07/pSCai9z6u1GZRiS+K0W6NCGrlNNQzLz+HShGUitcV33kO9pDzHI73LQj9qT2CgyqeaZsDsKc0wmNiMdF5rNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/sTA9Kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B51C4CEE3;
	Tue, 15 Jul 2025 03:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752551896;
	bh=snS6BZ8HZz24We5fag4B3dSbIWRbSM9y5G7CZL/J244=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/sTA9KwqEUrXXDZYklF8VnNxmdOPw8goczIE4sXEzG2qhnzSAb9iBjBhZ+HvO1i4
	 rhmlWqxZuoPPiQhb8j3c6f34JmINVL8nTLb4wvappIaqFCHZJCGfd31HnxaSUDAq3z
	 47IuO48BFzuwxeBb55pkMEgL1gzvAUNlxqbPhp/EFO8h17JmfCZrnYF453YHiqr0iu
	 93yuCsPHgKeSlrKeRl25EiyJGZEDYm6Pq55WQtILT3CoqJf8JZ4ePBsIUxhAJWxkXz
	 4HukDBWKNUY7jK+A4OLFYSdp8gjxTgw4uMZNjdyqW9FzK3awXDsKQfguzEpqdGQCtd
	 Wh322C07qKVNg==
Date: Mon, 14 Jul 2025 22:58:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dale Whinham <daleyo@gmail.com>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	=?iso-8859-1?B?Suly9G1l?= de Bretagne <jerome.debretagne@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/9] dt-bindings: arm: qcom: Document Microsoft Surface
 Pro 11
Message-ID: <175255189553.19950.4639359444626134883.robh@kernel.org>
References: <20250714173554.14223-1-daleyo@gmail.com>
 <20250714173554.14223-2-daleyo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714173554.14223-2-daleyo@gmail.com>


On Mon, 14 Jul 2025 18:35:37 +0100, Dale Whinham wrote:
> From: J�r�me de Bretagne <jerome.debretagne@gmail.com>
> 
> Add the compatible for the Qualcomm X1-based Microsoft Surface Pro 11,
> using its Denali codename.
> 
> Signed-off-by: J�r�me de Bretagne <jerome.debretagne@gmail.com>
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


