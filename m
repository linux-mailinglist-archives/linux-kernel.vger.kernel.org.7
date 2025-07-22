Return-Path: <linux-kernel+bounces-741501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC6CB0E510
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A44A61046
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04423280CF1;
	Tue, 22 Jul 2025 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiW39NK+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABBF273FD;
	Tue, 22 Jul 2025 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217190; cv=none; b=jweLa8s2d6l0PAE/WYHkElldHbwsVlUn6o73EQIXKUOTau4/+p0nA1b2rY+KxFcole8UARzCnERsjRIKvTuhAIECKAdzh3WECwe8obBgCFqzJHLxgc17OLWPVxhzY087jkPaoYv4F+5l0S+zU468EwA4b2c/uesVc5RO7rmHY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217190; c=relaxed/simple;
	bh=0/n304EBrrhIwO7/beO/35oY4Q23YLMRLyZG02akt0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mbw+VNeKUCCtUcouD2Oxximnc1PAV0GlypIuwoo6wS4kOVBTcvurOkEr58B03bi+kSxaGGyWQKtnGXuIuZYbwW2Nm6WGpZU/JYdfKDdILpmIAwzS1uVdE7A5TaZQoumM1zaUQK1fIzmgBq4nFp2zsPki2AFfxrKUhGKp8yLk7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiW39NK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AD6C4CEEB;
	Tue, 22 Jul 2025 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753217189;
	bh=0/n304EBrrhIwO7/beO/35oY4Q23YLMRLyZG02akt0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oiW39NK+mCtAQPGjca3Jqr2+w7Rfzh2qLntlAWoiQ7RuE/s9Rgx4ZnePLwBWWnKgr
	 y/zRaIsYUFffwaVTF0LOf3AlT+2f2RzCvrViyWtTnRf2mRJnpJBXq2UZ/pUlAiJpCo
	 bc82H5c6No2OPgh0YO3sjZBAxjfGYT5GFrXkKniNeANO0/GTtEg5AQSlH3/MQGc1PN
	 FNvaBSadEQvQP9XGac0p7EwZp3QED6MDh3Hq3Ldf9m2h0TOP+lHLv2X+VaBs6PfaMZ
	 tLb5eiCCeYoGc6CMCgdAa5fNG1v0BQBt4M19q2Cl2LcpB3DRMazoPsQugzSHevQoBJ
	 okZfTIme9TOYA==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org,
	monstr@monstr.eu,
	git@xilinx.com,
	Michal Simek <michal.simek@amd.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: riscv: cpus: Add AMD MicroBlaze V 64bit compatible
Date: Tue, 22 Jul 2025 21:46:18 +0100
Message-ID: <20250722-activator-anthem-b93b62c92527@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To:  <adf316c097ae416eb8565f2f1d67a98c413a71d2.1753169138.git.michal.simek@amd.com>
References:  <adf316c097ae416eb8565f2f1d67a98c413a71d2.1753169138.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=440; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=QylGl+iLXLcbSGxTurC8fdLCuWCGw2TfymnB3GGjO9Q=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDBn1P2Zph/0+lDNpc11KQvgt9xNTFeu4+KPfS39k4dRWX navT/9lRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACaysJKR4dvpjarGS7K/ca85 vELGWqX//GHh8uwvW728m22DLDe9ms7IcORZcq/iihX1x4uevGWz2nx5la3EU55d07e8bNXrFj7 uxggA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 22 Jul 2025 09:25:40 +0200, Michal Simek wrote:
> 32bit version has been added by commit 4a6b93f56296 ("dt-bindings: riscv:
> cpus: Add AMD MicroBlaze V compatible") but 64bit version also exists and
> should be covered by binding too.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] dt-bindings: riscv: cpus: Add AMD MicroBlaze V 64bit compatible
      https://git.kernel.org/conor/c/28fa0dcb571a

Thanks,
Conor.

