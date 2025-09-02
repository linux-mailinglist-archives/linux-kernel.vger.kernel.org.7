Return-Path: <linux-kernel+bounces-795932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76007B3F9A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C3F1A880C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0616820E6E1;
	Tue,  2 Sep 2025 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NHMqfsAH"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D5221F09;
	Tue,  2 Sep 2025 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803880; cv=none; b=baxP8y25zuUMYXMHinI7NzJ1jhCGS7aQRYZrD3p65LFA3Qi6nDLaSdm060/anLfFE2I739F4+OiI+TfNd0TOHL0G96zzGA3r8cb0+T8Y2CSmTZD/i1/de2o179HYemCqHA2081d5qpqjuXqHuPmTNd0Z1HOOsEE7C+PmAHFbGbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803880; c=relaxed/simple;
	bh=VybVW/M85O06EpGLQb8cA55azBhCKHa2SYmQOC/9wUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0AMuRUWw/O0tgHumdRxl6xNzWmU6Fh7FNR9J8hgr/tQ8+SfdRQEVKNAR/uEtTJTZ47hhKS7qKepLSyYbblFR6HHox1EIaeds8x9BNn4K3kRbFdHFh5SSgcBTxjNPOt3PiQi42VAz2T/E6zmr0CIW9mgjR3cEN54aTVmYvG5cHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NHMqfsAH; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CDC1520D9F;
	Tue,  2 Sep 2025 11:04:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0zhnfERamph4; Tue,  2 Sep 2025 11:04:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756803876; bh=VybVW/M85O06EpGLQb8cA55azBhCKHa2SYmQOC/9wUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NHMqfsAHt7DlunZl4h/nCBHuASSBKTn0YNZDRIE3yx9wEbO0F1jqgwPpOmxhHnbfW
	 HkIFjXqE/4PN7dO5gsxXEDiCly149PLq6eO6JNB12kbqdUXfHYnXfH38baWmp0BWEl
	 TjexwQ0IjANJcdG6qkfNpAGLjt//r1GgAYZxwkC1KaJHXA78TFmLdnN8fxhpNhPw1W
	 kNATLPwI4sQ3buNG5L7EZmWdyC3XQxM/b7SGA2LQBzD6nFT9RrLd9R3T8Whqj4A//6
	 TvZO8ZAu14tWQHx0I+Z1/1iwcg5YrwkBpLVFyGNpPTK+k46uDxwHGxzXrwtOazxPtf
	 jAY03cl38QaVg==
Date: Tue, 2 Sep 2025 09:04:23 +0000
From: Yao Zi <ziyao@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 1/4] dt-bindings: reset: thead,th1520-reset: Add
 controllers for more subsys
Message-ID: <aLazFzq2l7s66IqS@pie>
References: <20250901042320.22865-1-ziyao@disroot.org>
 <20250901042320.22865-2-ziyao@disroot.org>
 <20250902-peach-jackal-of-judgment-8aee13@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-peach-jackal-of-judgment-8aee13@kuoka>

On Tue, Sep 02, 2025 at 10:27:53AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Sep 01, 2025 at 04:23:17AM +0000, Yao Zi wrote:
> > +/* VO Subsystem */
> >  #define TH1520_RESET_ID_GPU		0
> >  #define TH1520_RESET_ID_GPU_CLKGEN	1
> > -#define TH1520_RESET_ID_NPU		2
> > -#define TH1520_RESET_ID_WDT0		3
> > -#define TH1520_RESET_ID_WDT1		4
> 
> This is ABI break and deserves explanation and its own patchset.

The registers in control of TH1520_RESET_ID_{NPU,WDT0,WDT1} don't belong
to the VO reset controller (documented as "thead,th1520-reset"), and
thus cannot be implemented by it. They're in fact AP subsystem resets,
which gets supported in Linux with this series.

Is it okay for you to separate a patch to delete these wrong IDs and add
them back for the AP reset controller latter? Anyway, I should have
provided more information about these three resets. Thanks for catching
this.

> Best regards,
> Krzysztof
> 

Best regards,
Yao Zi

