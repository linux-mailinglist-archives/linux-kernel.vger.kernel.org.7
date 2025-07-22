Return-Path: <linux-kernel+bounces-740914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140BEB0DB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D51517F826
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF382EAB81;
	Tue, 22 Jul 2025 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trkgJdX0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D02EA75D;
	Tue, 22 Jul 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191465; cv=none; b=VqYA74s16ky6Mppjq5rdlQnlc2B+cAq01NWhEyY++oFPgzyuacq4bPkvn8AynSuzcqBbj08yO7/5ZmccnewjTr9t2OXpvzY3ZNqUuPKLbVAnS2DH73LMNQRAWrwTGLiWuPVYRnmuxlAeVx7U9j1/43F8XdYyANS73AdEXbvrRWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191465; c=relaxed/simple;
	bh=U4iIf4JiBSL+EyyHBGSTsFeBXRFblL0LN2v1ZJtTQxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bBuxJq4xiTucAl2sYGZTIyv8eNXK6joZkaXU59eLyYed9ZjgkD0pBVmLZTD9Ado0r5vgOOCpxcDvo19h9gmp53EhiRNjkxBJQt1z870heGV+5jgfI+i6Y7Ta0+MpvNYwa9I4DfUVZOVheaZOLSBeCj0RpaOXDCoI9Uip0R5lFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trkgJdX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52793C4CEEB;
	Tue, 22 Jul 2025 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753191465;
	bh=U4iIf4JiBSL+EyyHBGSTsFeBXRFblL0LN2v1ZJtTQxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=trkgJdX0IzJQ4qBLx7i9XjFbkmDJQ+/tQ7H6KjVQdWzRh1ZflO9Y3ksbQy4wNrxNu
	 o+vuk77faTRSt9Ax6dJp92fZHRP4+dDEuMXmpMn8lxxL1Qb+hh2jaZgch+Az/CaMV7
	 3iBtfpEXEzgO6yhfZLqxTHADH7h0BrxW0afhGdAtWYSWoEqNPuetUHmdZcmxCLXaVg
	 mLjVNquanpKCB0PfFWnoCNEgVSi+9LuPQXOZtiw/g05JljH90BfTESWGuyZA/+SfFO
	 K1lXOHNHVNQ9eei048t4OGBAWPagqv8w+1w4GLdUoe1d1Uo6wCu54m7Mpw8rlpWAzA
	 76CMBHJsyuyEQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <david@lechnology.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627220107.214162-1-robh@kernel.org>
References: <20250627220107.214162-1-robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: phy: Convert ti,da830-usb-phy to DT
 schema
Message-Id: <175319146295.114152.13727198651641124424.b4-ty@kernel.org>
Date: Tue, 22 Jul 2025 19:07:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 27 Jun 2025 17:01:06 -0500, Rob Herring (Arm) wrote:
> Convert the TI DA830 USB PHY binding to DT schema format. Add "clocks"
> and "clock-names" which are already in use. As they are always present,
> make them required as well.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: Convert ti,da830-usb-phy to DT schema
      commit: 99dd7faeb7a4d973f049e1bad234888777e03646

Best regards,
-- 
~Vinod



