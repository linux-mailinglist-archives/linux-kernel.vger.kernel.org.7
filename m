Return-Path: <linux-kernel+bounces-798725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7422B42205
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9644E189771E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DDB30ACFD;
	Wed,  3 Sep 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUYb+o5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CAB303CAC;
	Wed,  3 Sep 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906735; cv=none; b=YsTSiliNUBi+AWB0xvsjC3AvDn4fi0lFjDjcsF+JFF+MhQe+NiSvtls1XNzXgzI13SPAMkawPM5kEqBNMZHrzsFpKVTBVxVEiA3jiHOF42JWeelsAwNzazxAEB9I/Lqg1ZC/ZbQaXJUTTtmgRZple4VBmAakqprO9mOR27hgxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906735; c=relaxed/simple;
	bh=AzCDff+fPm2SxUeBlzlVDmyYkpM13Thib63Tu+wrWHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y/r6xC3CuEKk+Yib9a7mU+6fwyCNlalZnjZKI8MSggOtRmwHIjrOU0FYCW9gbZjWCvaqWH1eAi+ji/IWfi4H/FfGyGKpHwgvGW/cBCfmyb423PyE+6zo/Fqf9Zkjpx1QTlj6xi23jgaI0meU2Nhw26dKebRm3T8HcdVW3jbILgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUYb+o5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEE4C4CEF5;
	Wed,  3 Sep 2025 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756906734;
	bh=AzCDff+fPm2SxUeBlzlVDmyYkpM13Thib63Tu+wrWHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WUYb+o5uuuD5jMnyTjFh6fWV9/bleSfM3henf1S427vcjAjaJ8+k4fD6leYQ+7F76
	 EIOGE7ioS51xqmbQLW2sjh+BAbzuBvp/xgcGbL+7RUrBmermsJXAIQBoL57z2Himxo
	 s1bmxc0jOg70NNUCRPVYmCvaex/tPDtgRAzFEjtU4vGrsocVqeE7rX/zHgPbE2BJOj
	 3Jaq8BsNtliKkVwzSi60hjwsZUCicnTDqZDQ0NxPuLYSfvZa4Aj4KTqS/bPdHZP2JQ
	 PIrA2png9EwyjLrA7trb+NZcHB9Kejejx9+QF3kBua6Cq7J0vfoe/Ysw6QvUsf5vN7
	 9RpNzYZPxnm2Q==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250829230450.1496151-1-robh@kernel.org>
References: <20250829230450.1496151-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: Convert
 aspeed,ast2400-p2a-ctrl to DT schema
Message-Id: <175690673266.2773238.16601353287689560770.b4-ty@kernel.org>
Date: Wed, 03 Sep 2025 14:38:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Fri, 29 Aug 2025 18:04:49 -0500, Rob Herring (Arm) wrote:
> Convert the aspeed,ast2x00-p2a-ctrl binding to DT schema format. The schema
> is simple enough to just add it to the parent aspeed,ast2x00-scu binding.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: Convert aspeed,ast2400-p2a-ctrl to DT schema
      commit: 61642a20a70e4f5f025b7f4f98c31caddccc3427

--
Lee Jones [李琼斯]


