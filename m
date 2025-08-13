Return-Path: <linux-kernel+bounces-766631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37BB24945
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD88728085
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA72FE59E;
	Wed, 13 Aug 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="A1b1EWXL"
Received: from mail-m32101.qiye.163.com (mail-m32101.qiye.163.com [220.197.32.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E862F747A;
	Wed, 13 Aug 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087190; cv=none; b=oOSRYoJsJb+8vCLnUQvUAQNvSbgwSuSVRNILhcudUtRB0KQOUMIoDnampuzcLgaeJUACnzSOMRG0dXtoNVmMZg5A6RyQgjQUee4q571or3igjz/5GXNVU4GK16hUkc0obM7u3x2EZh2kkwP3hURNOgMNvwqFPULn0IVlNp8LuHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087190; c=relaxed/simple;
	bh=x30mp3FPSN9wV3/dLzmgHqK/6hUW8Po2GYO0aqAfpcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xce2HoU6qemnr26ip8S8PftrPM/EyOb84g5J863LuvvBSuyq7fbIcVFiO5xoBGEW9F8gJsneJ6jFVi2PPT34jck1FV8hIq4UPt3sAkJIHjgGG0Lc9ntPEIJ+fdMpEyz1iOT4mgcekfBqexSLiL5qzOMPmHJUYn9KEWHW3LKob+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=A1b1EWXL; arc=none smtp.client-ip=220.197.32.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f4393c88;
	Wed, 13 Aug 2025 19:37:32 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v3 1/8] dt-bindings: vendor-prefixes: Add Black Sesame Technologies Co., Ltd.
Date: Wed, 13 Aug 2025 19:37:30 +0800
Message-ID: <20250813113732.2393097-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8314491a-3c4c-4a32-8b3e-62c06109bc71@kernel.org>
References: <8314491a-3c4c-4a32-8b3e-62c06109bc71@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98a3389b2509cckunmde634496a1193f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUxMVh4ZHUwfSRkZHUxMHVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1
	VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=A1b1EWXLuXwanmImXmiQgdIv5JjC5qz3vWpkB/5NM2aXrpney6BIYuj8nX7NWkAHLhHIpYJ/N5uA4tl3FCVnq6blm96jXARXW2fJtysyjFeIpvIx4HmAsiwFIdVaSFtPYE1X1Tk42UojR8TReSA90d6Qjbbsf51UB1FAgQgmQxQ=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=x30mp3FPSN9wV3/dLzmgHqK/6hUW8Po2GYO0aqAfpcQ=;
	h=date:mime-version:subject:message-id:from;

On Wed, Aug 13, 2025 at 08:01:09AM +0200, Krzysztof Kozlowski wrote:
> On 13/08/2025 06:53, Albert Yang wrote:
> >>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> >>> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> >>
> >> Odd order of tags. When was the patch written, by who and when was the
> >> Ack given?
> >
> > Rob’s Ack was on v1:
> > https://lore.kernel.org/lkml/174915411977.3161261.2820163642193291293.robh@kernel.org/
>
>
> So how it can appear before Ge signed off?

You’re absolutely right, I’ll ensure future submissions follow the
correct order. This area is still new to me, but I’m actively working
to master it.

Best regards,
Albert

