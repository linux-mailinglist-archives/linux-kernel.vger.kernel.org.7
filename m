Return-Path: <linux-kernel+bounces-894818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6B1C4C27C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9111C4F23EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6333531BC80;
	Tue, 11 Nov 2025 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gztyeICj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DCA32B99D;
	Tue, 11 Nov 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847032; cv=none; b=ugqSnSsr/IezvyUcn+Mdjf7w/Q9aKnwbaN2/OVHvcqHi06ZdicWUR1p7zTCDTRxH2GL+6gFL7vQJtDOh/QehswXedoLTemDMlR9/ZybiW8vvbV8VtLunW3yl2cZac6TyPcEJ2MCsy/6llDB9F7CQ9FSMrFw1BbPdOCzx2mU9hqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847032; c=relaxed/simple;
	bh=XIv9q/YAhKheEKBaWPN6EMrhsiNlRb18dfmo/SehtNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOgsfoXWQ0qao3EGrTax2kfHeroG8KaZTfcR5MRxle7nOfsq/fSHmt6A7Ms/AG3qdJSmExJfmq0nOLGVRz9Ay6N7e8jRXRg97MssxQnWUrCpcrU+fmFa2gpTVWh+nfK0lLoP3+MSJdeIF3VfzN+bekArzgE/dFyGXmB6VGKYmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gztyeICj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD707C19424;
	Tue, 11 Nov 2025 07:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762847031;
	bh=XIv9q/YAhKheEKBaWPN6EMrhsiNlRb18dfmo/SehtNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gztyeICjwETc+OlGLVdWcmHw2w6UdifgGsZLo6PXsDC3frqxAWKLG2ui+0MXe9Jgp
	 9gD4NgzAazwYh611kkaLMEZVQ0SdlJQCECDP+Nz4O5ZdN+QZT6Szm0vn/T5h1dwy+1
	 2l1+35uXxTlSj/sEm1PGHOO48yZXiWjKwluQmfuv9Yq96uJioWWpI5putwtm69ClJJ
	 xUVhNkZs8UKN4e4y0VifVmNOTpI0uKHcMSRTzC0kbB3+cGpoiQn+8jol58tC/b6CjR
	 FWp+AvU7gNoUqebQghrhPqX51XTm/rHRcOu/3bZUujPzoymaySAzQP/2gPqqvr84uW
	 v3/dUqMptxQKQ==
Date: Tue, 11 Nov 2025 08:43:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S
 board
Message-ID: <20251111-inquisitive-ambrosial-chicken-861542@kuoka>
References: <20251110220641.1751392-1-michael.opdenacker@rootcommit.com>
 <20251110220641.1751392-2-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251110220641.1751392-2-michael.opdenacker@rootcommit.com>

On Mon, Nov 10, 2025 at 10:06:48PM +0000, michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> Document the compatible string for the OrangePi R2S board [1], which
> is marketed as using the Ky X1 SoC but is in fact identical to
> the SpacemiT K1 SoC [2].

Different SoC means different compatible. It is very, very unlikely that
different vendor made same die, which would warrant same compatible.
Identical does not mean the same die, so your explanation is not
complete.

Best regards,
Krzysztof


