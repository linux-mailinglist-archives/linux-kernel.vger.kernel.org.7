Return-Path: <linux-kernel+bounces-765919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 913A3B23FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85A1188B444
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB14029A9CB;
	Wed, 13 Aug 2025 04:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="TwQvn7Y/"
Received: from mail-m1973192.qiye.163.com (mail-m1973192.qiye.163.com [220.197.31.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25F3A1D2;
	Wed, 13 Aug 2025 04:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060800; cv=none; b=DtPmoeNS9X+/4z+L3wjsufbsaCKqsHsFW+pser9tCc75Ksctvj/mweeOG9reECYbvsHqmt7WigJ0hykmpXPxJF4JhH9sT6GVFJv5cf0u2VPD8AiJHI+wuedc364vSqryGf42KD1MaSc743Xw9w+dWGDdZNGWnG+bGLjiqomAZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060800; c=relaxed/simple;
	bh=lohpUZRgUcpydkMRtVyyltzuFs7B2xr2x3+Dmt4R4hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZZlhixMW3/9JgVNozar1XbnyEVD/l4h0HnqVEux/zmsa5PMspKzjeCbIRr4b1O11bIVcMD01Jur4Xm90WFQuivsz4Ft1kW7TZcqkWK6yf3bn5iCZWXkLCerAZEA3jo3xmYI0cJcz17AMqqzcgG2G9lpfeJAF48cB4bMUAJ9Vs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=TwQvn7Y/; arc=none smtp.client-ip=220.197.31.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f360124b;
	Wed, 13 Aug 2025 12:53:11 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: vendor-prefixes: Add Black Sesame Technologies Co., Ltd.
Date: Wed, 13 Aug 2025 12:53:08 +0800
Message-ID: <20250813045310.2307498-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d5e0f41e-34c1-44af-ac0d-8362a72a2ff1@kernel.org>
References: <d5e0f41e-34c1-44af-ac0d-8362a72a2ff1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98a1c665d709cckunm48dba2bf963c07
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS0NLVk9NSk8aQ0tOTB0dSVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TwQvn7Y/9ofi36N+s4CWrdTMTvJ5xuObOfPbFjLRe17fM7Ks4o88xrXhBmldJMXJ5gn6T3sUVT9W2lYNHKJsePnH7tARXuFeb683BW+O13bvVGGCFVPMN/JsOsjlaxNChgeF4fh6mYJAU14gVd5HuNF/qMQSGYm6c0RLiUJY+LY=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=9nPsgyptOpE1Def+8QRqFoBIyNUEEO0AEGlZ/Gjdj4s=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

Thanks for the review.

On Tue, Aug 12, 2025 at 03:34:55PM +0200, Krzysztof Kozlowski wrote:
> On 12/08/2025 14:31, Albert Yang wrote:
> > Black Sesame Technologies Co., Ltd.s a leading automotive-grade
> > computing SoC and SoC-based
> > intelligent vehicle solution provider. Link: https://bst.ai/.
> >
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
>
> Odd order of tags. When was the patch written, by who and when was the
> Ack given?

Rob’s Ack was on v1:
https://lore.kernel.org/lkml/174915411977.3161261.2820163642193291293.robh@kernel.org/
Since I’m changing the list position, I’ll drop the Acked-by in v4 and re-collect it as needed. 
I’ll also fix tag order.

> > @@ -222,6 +222,8 @@ patternProperties:
> >      description: Shenzhen BigTree Tech Co., LTD
> >    "^bitmain,.*":
> >      description: Bitmain Technologies
> > +  "^bst,.*":
> > +    description: Black Sesame Technologies Co., Ltd.
>
> Messed ordering.

Agreed. I’ll move the “bst” entry after “^bsh,.*” and before “^bticino,.*” in v4.

Best Regards,
Albert

