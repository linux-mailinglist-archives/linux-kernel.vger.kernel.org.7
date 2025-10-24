Return-Path: <linux-kernel+bounces-868139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F9C04740
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4394F3A18B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243125A33F;
	Fri, 24 Oct 2025 06:11:47 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C872253F05
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286306; cv=none; b=uD7EFswwNi3kRc605tWTETjqZ+mr7Qw9ALW18xO3TDUhGYiAKqhD71X84oJebiTLrMJY+Lgo+9II+iiCZ8xnWGoJxhCFSqHN2GEdrrkw79oEczEsRACTq5Zcg/Rx55wOkPPqCMLbt6PxafNirf1z3RdoIFl+A3ujtT4luKnrZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286306; c=relaxed/simple;
	bh=iZIIjP2Xbx/o0m7yFQ27sivLZc8LGXOGoHHR9KxGSbw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lsw86FOh93NV40YtS20v5UNSkjce3zhT2JrxQlZDluAFunYn4kkzjSB+YCQY9bxuPupZ3rI+Kk3KYWTqpDlGag3bd0zl85vVuBK8eT1YL/nf7wJbjQLUXVVr2hnDVZ219HZ9vCX2sUHC70F3PedmDKEhc6lGdRfC/xQSZT6Qkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.51 with ESMTP; 24 Oct 2025 14:41:42 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO ?10.178.36.63?) (10.178.36.63)
	by 156.147.1.121 with ESMTP; 24 Oct 2025 14:41:42 +0900
X-Original-SENDERIP: 10.178.36.63
X-Original-MAILFROM: chanho.min@lge.com
Subject: Re: [PATCH] dt-bindings: arm: Add missing LGE SoC platforms
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022181144.4147944-1-robh@kernel.org>
From: Chanho Min <chanho.min@lge.com>
Message-ID: <7a6fa504-226c-8392-561c-5e081f4d3b34@lge.com>
Date: Fri, 24 Oct 2025 14:41:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251022181144.4147944-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

23/10/2025 3:11, Rob Herring (Arm) wrote:
> LGE LG131x SoCs have been in use for some time, but the root compatibles
> have not been documented. Add them.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: chanho.min@lge.com

Thanks,
Chanho

