Return-Path: <linux-kernel+bounces-895874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F913C4F27C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E8D18858F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC883730F5;
	Tue, 11 Nov 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNeLnjmO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882F34250D;
	Tue, 11 Nov 2025 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880370; cv=none; b=X7HmI2lRoweQoc2JSb50czh/m9a0SBmh2kI54Jwm9kc271YWSC2oSoih8kZG9EL0QNqLr1R0Y43ta6arNHXCF6nFx2m06sBmuKux2VXXFmMk8KoEiQ2cu1Xwo9AAQZ9XSmXfBCQw2bgJPY0sVxfZbK4TjpAPX17bCAHwXvbisJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880370; c=relaxed/simple;
	bh=8oMiOHa+hu2a7ioUCvWOutt6HMizxpVyGXj4Xwd+sC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtcqB5RakXbXc1G7X0JdGuP0Sal37tXmgZ8X7+MC/pQFyWLhbEs/x0oD0rrod8+49EH/ifBd+mYWkLtx+tWYW3vGzQDzN2rNGpb2MxHeKMF7lrsa3VcV25OTpeIMO4++WoRzfblEPg9/BO1Diod74ugR7psWTccDLwss8P6pPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNeLnjmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA35C113D0;
	Tue, 11 Nov 2025 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762880369;
	bh=8oMiOHa+hu2a7ioUCvWOutt6HMizxpVyGXj4Xwd+sC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNeLnjmOiQ9qJ4do4Xaho63cbf5NpteEOrDMlIaLLu5gGMvOAcOXh3BxOIm4zxTg4
	 tiihPjQzp+6k94GQcw/f8qgoMrD9dZQPwM3QU5pAEhAVYQgu9ls8uDrGfl4LZrpxyF
	 qjTemCrtU8L6khGHdtdJpRZ/vyeYVDCHNXfD4K8dSxLCL7Nr97cTxM/f3mB740MdlE
	 eaMGiL0fcwRaiGGMUvcL459tWTiD3JFe5Nuw4Jw3gLxVmn1yswPoractjvwrs9SB5T
	 JB3Z5Ye7l8V1SxnVW7NyXqH+fW5DEvprq04whOaLZ6MQwWHHiOI/jVH6j8BgFGQA9f
	 PRUcQiZK5sR5Q==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Cc: conor@kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [[PATCH RESEND] v1] riscv: dts: microchip: enable qspi adc/mmc-spi-slot on BeagleV Fire
Date: Tue, 11 Nov 2025 16:59:20 +0000
Message-ID: <20251111-platinum-legume-01c749eee143@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105-unrobed-agility-c9c242a5b344@wendy>
References: <20251105-unrobed-agility-c9c242a5b344@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=341; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=S1Tu2ruJlrzPvAMOa7vu7v2UFNoLx6oPas1oSZPbmp4=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJnC2ZkshQnxPYz/f+SaLn0124mzNbh0e+3pv9JzGbcdN F10wLyoo5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABPZWcHI8J739dVzS5JWX/5s rvvb6MDuK/ZnnjJ3Fk9/tq99wj5H+zmMDBNu5/9ec+m53YKEVQvDzp3oZVbVyfUJF44oPVceMWG 3ER8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 05 Nov 2025 10:24:24 +0000, Conor Dooley wrote:
> The BeagleV Fire has an SD card slot and an ADC connected to the QSPI
> controller.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: microchip: enable qspi adc/mmc-spi-slot on BeagleV Fire
      https://git.kernel.org/conor/c/1088d49b6264

Thanks,
Conor.

