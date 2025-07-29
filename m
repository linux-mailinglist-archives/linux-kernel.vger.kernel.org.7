Return-Path: <linux-kernel+bounces-749125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1852BB14A69
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED131AA0A14
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A622286D6F;
	Tue, 29 Jul 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNAAoGpN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741E286887;
	Tue, 29 Jul 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778902; cv=none; b=kRc6+rcViOr6oI3bCQz2Wo119+BARtidtl/uLuFlEPN6O5NUldfGtxUKgb8MOqECcffaUMHkMlFZYFJ/VvwBwXv3v3iKs83CoxtHgs8Uvo4QuJ5NQZdkRRqIiCDo8s3eEn+59/LPL2AXnspOaB7lJ8BQCBlehuKrDWTVl8Gzhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778902; c=relaxed/simple;
	bh=2JhJ23PKDGh0rNTPf4+9GEhrGZZAPJDZKUqvEUJMYfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/fP+nRptjW3EJ0NkUbBxmp2VIZqsOFO2WKFABa25KI55wOps6eN1MFGlR2lEk2JsmR3LVqsvwoK9YRswlOOP2B1Fz4HrhNOdGuSzVaIPWGY5zba6P0O3xZJI+Ag1PeqlQnDDMp4noe6xP4ke7Y1efJ3/OJ/o3mqkZMf+4P8RM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNAAoGpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B402FC4CEF5;
	Tue, 29 Jul 2025 08:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753778902;
	bh=2JhJ23PKDGh0rNTPf4+9GEhrGZZAPJDZKUqvEUJMYfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNAAoGpN/YY4FI3E9IjMxHdPD0kk9XalVNVAzKrpsR5O3jdpDjrcpf1gyFV00y2b+
	 2kB3X6Wel/4P8A52a5+S/oPsWTptQrti7af0fojd+r7RIbsKtdq88TkGOmzleDfftC
	 L40j/hPxabP0hFKIdZLm2X6p6yf72JrwFd8QtgDCyKk82X/DMB0yYdRYlVp4i4bQke
	 jcz/YOD2N3EAKJfUi/Em2gF1rdVg9hEiivzvzcflPhLz48zsBTV4nrqO5zfoX43Os1
	 ucB0/ejIRjdvNv4Tsg7bUCcNi3OJT/EKp/cgomKb2rc0ITUC+7p8/MjUXvy2JWrBMt
	 Ou+p1ZXShTW0w==
Date: Tue, 29 Jul 2025 10:48:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Erik Beck <xunil@tahomasoft.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: arm: rockchip: add
 LinkStar-H68k-1432v1
Message-ID: <20250729-passionate-jerboa-of-superiority-c7aff5@kuoka>
References: <20250728-linkstarpatch_v5-v5-0-b4ebfeaca652@tahomasoft.com>
 <20250728-linkstarpatch_v5-v5-2-b4ebfeaca652@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250728-linkstarpatch_v5-v5-2-b4ebfeaca652@tahomasoft.com>

On Mon, Jul 28, 2025 at 11:07:37AM -0400, Erik Beck wrote:
> Add device tree bindings.

I don't understand why correct patch order was changed to incorrect.

See submitting patches in DT bindings dir.

Best regards,
Krzysztof


