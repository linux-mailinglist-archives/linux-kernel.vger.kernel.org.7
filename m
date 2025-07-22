Return-Path: <linux-kernel+bounces-740394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA70B0D3A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FDE18846D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990A2D373B;
	Tue, 22 Jul 2025 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzw0uSql"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1692E49A4;
	Tue, 22 Jul 2025 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169857; cv=none; b=NNYsM5b8RfOErzJNuYBVhURXsA8xWZTDmj1BSegV+1VUGnu35gXUHrLogMCuSiTMvGfU/a0/fUdg0HJCaQLuU92AmN5SF/ZTlaq5Y0ZEpUcJJNNF17UY0ADYTBFAXDF9WAgWEnCY7mYAudN9OyDSbRUMrCjpoGHQiUb9oQDByvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169857; c=relaxed/simple;
	bh=iDvM2VPftSxdzHwlQol4MD0+RaEFy4tM/it5++oZkUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2YikJJogSVWTQWFZsIFS84DapcHLICQMvj2de72wLpQpjUdhdPT5aujxba5NWEgSz/hkiT8F1dUImeif97RCo79s6myZbx0u4nfqfHGT6R2hP2+zmOFFKBBDG0l31Fv2XFP5AsiZZrAZfRhzJxkGrnYPX7sZ6aFSFddXWilXwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzw0uSql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEE4C4CEEB;
	Tue, 22 Jul 2025 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753169857;
	bh=iDvM2VPftSxdzHwlQol4MD0+RaEFy4tM/it5++oZkUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzw0uSql4CE/hsMxkctZUxY/7CwF4pA7AIJzhzy/qawmWNZmv03EWHh04NpP+/Cal
	 I2ZZPyI4LjXC43PutZ1/F8ksIpFVH0dGW9G5ZljxA6lpJR1LxxkCj4apdlp1q8rYS4
	 dP1sdmVcmZTpj9ASaPelD0jdVr5NtRTYC6vB5vjCgnS38y/fWEmSX+dgTzQGzxgdFD
	 UDCAkdc2lYQmhlDDsVtmQySXNN+phuwyhky7+Usnb+nDnS09xoQevsNYP63NMtNI7/
	 jeCarzDsQpzPNYbLJNG81GfGQecDMjFRil+L8MybA3iqrbcGk7gGePWaYKzIVs9hUk
	 qaLOmkiE90DSw==
Date: Tue, 22 Jul 2025 09:37:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, 
	michal.simek@xilinx.com, git@xilinx.com, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Add Xilinx INTC
 binding
Message-ID: <20250722-viper-of-inevitable-adventure-23ba2d@kuoka>
References: <6ddaf6f1e3748cdeda2e2e32ee69343a06c60dcb.1753166980.git.michal.simek@amd.com>
 <b30f00c3-9062-4d19-8088-5fc5e951eb5d@kernel.org>
 <da1c19c7-60af-4841-9554-7758324a58bf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da1c19c7-60af-4841-9554-7758324a58bf@amd.com>

On Tue, Jul 22, 2025 at 09:32:58AM +0200, Michal Simek wrote:
> 
> 
> On 7/22/25 09:17, Krzysztof Kozlowski wrote:
> > On 22/07/2025 08:49, Michal Simek wrote:
> > > Add description for AMD/Xilinx interrupt controller.
> > > IP acts as primary interrupt controller on Microblaze systems or can be
> > > used as secondary interrupt controller on ARM based systems like Zynq,
> > > ZynqMP, Versal or Versal Gen 2. Also as secondary interrupt controller on
> > > Microblaze-V (Risc-V) systems.
> > > 
> > > Over the years IP exists in multiple variants based on attached bus as OPB,
> > > PLB or AXI that's why generic filename is used.
> > > 
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > > 
> > > https://docs.amd.com/v/u/en-US/pg099-axi-intc
> > 
> > 
> > We usually do not take bindings without users, that's why bindings patch
> > is always part of some other patchset. Commit msg also did not clarify
> > the usecase here (or exception).
> 
> Example DT is already the part of arch/microblaze/.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/microblaze/boot/dts/system.dts?h=v6.16-rc7#n338
> 
> DT has been added in 2014 before dt bindings that's why it was never documented.

OK, this must be in commit msg, because that's the reason why you are
doing it. You are not adding new device. You are documenting missing
binding, already used.

Best regards,
Krzysztof


