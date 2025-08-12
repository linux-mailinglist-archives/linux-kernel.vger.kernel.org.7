Return-Path: <linux-kernel+bounces-764436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A32B22311
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3F26E7C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10AA2E973F;
	Tue, 12 Aug 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buserror.net header.i=@buserror.net header.b="Vn4Mjsv0"
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D42E1C53;
	Tue, 12 Aug 2025 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.176.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990471; cv=none; b=Jtbag2VqtQ3vLYyi1LEA2NhB3LXNx37e4PBSYdgtF7ohDcr94GbXvCjFRXy5+Q6zCqtPgeWZMUkbo6nyIe62MjsfF4IRKy5eKRPCMUUB8iyEo3Rek/ccU6olSZPIb5W1FRJZ96yxeH6mPjZpsT+CzlgHHeizS/5l7SX+QQYCSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990471; c=relaxed/simple;
	bh=AnsoN753ge3fmuKp53nHcJSnJoOlNZBteerwlF/iPZU=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Subject; b=RCS1WBXec+0lwYuYxG3dP4D/CjiLH+OEmHEpfI+Ylhi4YwjHowuS9ms4A7D7RD2Btjo2s/6y8Yl41bxtGp+qoGKZUjVoDja9gkXu13r8E5Pbyon+3IfGqN6ngv6hnBO+RkuGuWLJtnuY6rqiLkiffm0HgNUzAWBxibD8HraG/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buserror.net; spf=pass smtp.mailfrom=buserror.net; dkim=pass (2048-bit key) header.d=buserror.net header.i=@buserror.net header.b=Vn4Mjsv0; arc=none smtp.client-ip=165.227.176.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buserror.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buserror.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=buserror.net; s=rsa_sel; h=Subject:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=1b80/fGhciNryFEEkQZ7Y1tSDQ+Qxdwq3vTaXU1pxJ4=; b=Vn4Mjsv0raTVizLSzp3/p6IUdO
	/Fh0rQqfGm8lyNmfkgG9+wRETY3SStSH5NrT4bagU58vBJfXASE3pRpGjraEMO4xHcXsfLARTencf
	mejhQxfu3581k/ZwhzaXMlnSRkpVeGgO4xdJ9t526l1EoryLeFBUv84vWuul9mPMYKd4VewBdFG8d
	2RArV0HGZsk2y2Oi1cJ+6CurwfH7rrSRKlPgHh3IHRnFZJjaRV9kyHVXYeIKc5K7uqB6z1axCIaLb
	Y9K7Y/jhmTo+3P6czyAXVxcxF9FfTeqD8BdGNRcFiD3/ABtIbQOPa5+AsMxb6RR/d0d1sW9zlxec6
	FEwBx1Iw==;
Received: from oss by baldur.buserror.net with local (Exim 4.96)
	(envelope-from <oss@buserror.net>)
	id 1ulkaV-00AoyK-24;
	Tue, 12 Aug 2025 03:42:32 -0500
Date: Tue, 12 Aug 2025 03:42:31 -0500
From: Crystal Wood <oss@buserror.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Message-ID: <aJr-d1tZREOY6U5a@buserror.net>
References: <20250807214432.4173273-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807214432.4173273-1-robh@kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: robh@kernel.org, tglx@linutronix.de, krzk+dt@kernel.org, conor+dt@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Level: 
X-Spam-Report: 
	*  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -0.0 NO_RELAYS Informational: message was not relayed via SMTP
Subject: Re: [PATCH] dt-bindings: powerpc: Drop duplicate fsl/mpic.txt
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)

On Thu, Aug 07, 2025 at 04:44:30PM -0500, Rob Herring (Arm) wrote:
> The chrp,open-pic binding schema already supports the "fsl,mpic"
> compatible. A couple of properties are missing, so add them and remove
> fsl/mpic.txt.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

What about the 4-cell interrupt specifiers?

> -                  0 = external or normal SoC device interrupt
> -
> -                      The interrupt-number cell contains
> -                      the SoC device interrupt number.  The
> -                      type-specific cell is undefined.  The
> -                      interrupt-number is derived from the
> -                      MPIC a block of registers referred to as
> -                      the "Interrupt Source Configuration Registers".
> -                      Each source has 32-bytes of registers
> -                      (vector/priority and destination) in this
> -                      region.   So interrupt 0 is at offset 0x0,
> -                      interrupt 1 is at offset 0x20, and so on.

FWIW, while this description may seem unnecessarily verbose, it's because
it's different from how Freescale hardware docs numbered the IRQs
(IRQ 16 was "internal IRQ 0", etc).

-Crystal

