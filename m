Return-Path: <linux-kernel+bounces-727992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E039EB02234
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A33FA482FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48D2EF654;
	Fri, 11 Jul 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP2JaB1Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26EF18A93F;
	Fri, 11 Jul 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252834; cv=none; b=ReFERaS8gg2AlStYtr31t2iy4xUY22lE3nxLYvvTZOCU3iGgAhGftK5PS6p7kFo4gnPU6o2HOIUCKJhZ+YjO64Cc1mGUokX0wvO3MSbrF3PlKFN5doib+b38el6OD0Dy4vnvY0DXmj2ZTV1me7kKuG5pikWteBsmZbp/X2it5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252834; c=relaxed/simple;
	bh=SNoKIrx3JZ8VOFI7r129Z7RFa6ucn+juakq19EGnPR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sl8bYSUqDploq514rwZLnhW8haM+v0eiZo2Rt4FSmhGDY0aC+x4m2heHnN0HiD+wa39g7/EMG6V4d6Ewn1Ph+AIHHyFTD7OCR7cxlkt7xSj+y1StUl8d/rgs1EDmNGRq5jz6VeyxFneP5Jq2XuVvk0pS24LnR2FAUkRXQHW3bew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP2JaB1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E4FC4CEED;
	Fri, 11 Jul 2025 16:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752252834;
	bh=SNoKIrx3JZ8VOFI7r129Z7RFa6ucn+juakq19EGnPR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YP2JaB1Y3L+ay1EqJUrdhvwvBnVps4auY2lIY/aND5R6+U0hPL0/axRccnGgrK3+t
	 eGGFci4Ijv3k5WtVDy5jMRwiPYG3CHzASIUFwgFm0hra8DfvTebA+zhhrGd8fh6tIL
	 aY2be70NXOu+NfI3Edx5baAij4C1urStnmFsRdPQQBirnMtyIMLiaqRJHKPVzQS933
	 V3xMgqoP5lEOHnR3kNqfWAzdWCJN5nEYqPw8p/0YmT4TotXgKiFIQdZexk6H1AsnXP
	 L1UK9JgYSGm4IrzIFqHnEymTybsqwcL/FQ+alUM8hj0z4G7f0qKMf4O0N4do5Gtu1B
	 c67kdSQmVYmww==
From: Srinivas Kandagatla <srini@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20250521164031.306481-1-Frank.Li@nxp.com>
References: <20250521164031.306481-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: nvmem: convert vf610-ocotp.txt to
 yaml format
Message-Id: <175225283274.24522.4728093221572696111.b4-ty@kernel.org>
Date: Fri, 11 Jul 2025 17:53:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 21 May 2025 12:40:30 -0400, Frank Li wrote:
> Convert vf610-ocotp.txt to yaml format.
> 
> Additional changes:
> - Remove label in examples.
> - Add include file in examples.
> - Move reg just after compatible in examples.
> - Add ref: nvmem.yaml and nvmem-deprecated-cells.yaml
> - Remove #address-cells and #size-cells from required list to match existed
> dts file.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: nvmem: convert vf610-ocotp.txt to yaml format
      commit: fe5df28647e2941db393e376e545f8811cc4f4ec

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


