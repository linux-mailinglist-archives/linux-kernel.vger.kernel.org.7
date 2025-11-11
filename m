Return-Path: <linux-kernel+bounces-895118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE59C4D020
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1463BC01E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4D9338902;
	Tue, 11 Nov 2025 10:12:01 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C008433AD;
	Tue, 11 Nov 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855921; cv=none; b=gjM9gyul3ppEm17UwQcvrkDN+wMVOkQ948KcroyX37l9Cci8WNOuQKqtJc4FSxpwxEV1E90gUy35JC5yKFLqwYWAPNS9djrEVp48hXJnOVQHhME3TksxSz0FsWHrG3lX/EdTKl7UPq/8XKWK+YoY1vY97ICA6oQrKaBHlh2jLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855921; c=relaxed/simple;
	bh=+gnXsHIuPue0wwQewdVdbndYYyc3aZpBEaD0suWVBTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc2ISpyMvIrfVp7GyQh9xixKHJ4YJpH0QzKR5XVvN7xQKeVsUR5lulVJwBMqvKz1yp4BTXaN37lS5J9GgPcDufuMdItW65wGI5zPYq8X+MX+oItyIVwJIsJE0qEf5sGM/57nG9JsduhLELYOiLAqeOemGBXbAJGPC5KtCyOlfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3F108340DD9;
	Tue, 11 Nov 2025 10:11:58 +0000 (UTC)
Date: Tue, 11 Nov 2025 18:11:49 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: michael.opdenacker@rootcommit.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S
 board
Message-ID: <20251111101149-GYE1651402@gentoo.org>
References: <20251110220641.1751392-1-michael.opdenacker@rootcommit.com>
 <20251110220641.1751392-2-michael.opdenacker@rootcommit.com>
 <20251111-inquisitive-ambrosial-chicken-861542@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-inquisitive-ambrosial-chicken-861542@kuoka>

Hi Krzysztof, 

On 08:43 Tue 11 Nov     , Krzysztof Kozlowski wrote:
> On Mon, Nov 10, 2025 at 10:06:48PM +0000, michael.opdenacker@rootcommit.com wrote:
> > From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> > 
> > Document the compatible string for the OrangePi R2S board [1], which
> > is marketed as using the Ky X1 SoC but is in fact identical to
Maybe, just say it "same" to clarify the ambiguity?

> > the SpacemiT K1 SoC [2].
> 
> Different SoC means different compatible. It is very, very unlikely that
> different vendor made same die, which would warrant same compatible.
> Identical does not mean the same die, so your explanation is not
> complete.
Unfortunately, it's true that Ky X1 is just a rebrand of SpacemiT K1 SoC.

I guess it's a marketing strategy although personally I don't know
what's the motivation behind and even wish it never happens..

-- 
Yixun Lan (dlan)

