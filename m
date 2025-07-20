Return-Path: <linux-kernel+bounces-738512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A41B0B971
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FF616846D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B922B590;
	Sun, 20 Jul 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MRsHJ5iZ"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106B3FE5
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055603; cv=none; b=WJdJ5QdBJkzxo9k54KkYu+o9mPPQGGMQUevtayHQukUIq/42ET7W65FnQd29j+06+oJ+7f+H3V7lvwRXEFokjoDUegesSGXFa1XuxCSWkUPcTB2MHTDlimzh3Py8n5PW2XqNEB7D5Pc0mWaOGCcXGKlCpdrzl1gr7MXtYsgkN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055603; c=relaxed/simple;
	bh=kw5EZMNuyGB7CmEhXixTBxSBx1OcgGem/c65a01vXA4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vm/4kJ5c6s10mPSIBU/2NzBDatTWr3S5rmjEaEXIK+8R2IsHlViyxnt7WIEpZkIlQwEu3Jk4+X2S9ZqREaIFn8dLChlzOD9L7CkGrFoqjoMEVr5W94NKddUac2l55WqGE1hhqH+Hb9F2jQa0oDNilWI40RvyOZ5WHwBi+v8FGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MRsHJ5iZ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753055593;
	bh=jQBOro9F+MQuOHq8M96Qw8N61+pxhdSOIRbBbM/x8dU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MRsHJ5iZcwN7AfQyPyK0F2DbDWKlN516JqHY5HjuJpExPrJPh3NkdY4x3eYr5HuCK
	 rzQpZ0j/DSf7eVuKblwvW0hHcdcssQqUW0PcqYDKzVOr8u3pZKNFlWLVxvk2s4ZrDH
	 NHIUF7lhsQZG7pFRWF3oNMAB3WKLIwS1kqvrji/kMFBN3ljhEgbFfLvwQ3nHQFLRkW
	 2+HwQTjHSCDouHP9iHOdVJIkKB39WNjsMbmdrjeItdHUlCk7gTywAJbSGe/S85R+xr
	 /Y+FAx2SHbRABITnBYUxsgBU/iudzsMvVa17cPYcxS5t+Ci3UJT6JMHvwqxVUjkxDb
	 H2i3EFOYwGjxQ==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9B2436443C;
	Mon, 21 Jul 2025 07:53:12 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Joel Stanley <joel@jms.id.au>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250703183508.2074735-1-robh@kernel.org>
References: <20250703183508.2074735-1-robh@kernel.org>
Subject: Re: [PATCH] soc: aspeed: Use of_reserved_mem_region_to_resource()
 for "memory-region"
Message-Id: <175305558159.1020373.9271236318462742119.b4-ty@codeconstruct.com.au>
Date: Mon, 21 Jul 2025 09:23:01 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 03 Jul 2025 13:35:07 -0500, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> The error handling is a bit different. "memory-region" is optional, so
> failed lookup is not an error. But then an error in
> of_address_to_resource() is treated as an error. However, that
> distinction is not really important. Either the region is available
> and usable or it is not. So now, it is just
> of_reserved_mem_region_to_resource() which is checked for an error.
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


