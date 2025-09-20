Return-Path: <linux-kernel+bounces-825927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D33B8D232
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5139189F318
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FEB283FE8;
	Sat, 20 Sep 2025 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZz9J+Mj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09340188CB1;
	Sat, 20 Sep 2025 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758409940; cv=none; b=pmWvYlWV16ILWBLs+YdMKaIoqTk1bxpMm+ls4tzb8KUvEErKhwtohIbaEsJhxiFGMVNhsS46Rp6vHTGMku5FvZtUZlx5evgd5WZ/dxjzXDQeWuQVOC7KqEvh2GPFJIfK8xVyzCRcUGX0n+xU6faF4a4lvU4Itds2mEKqoGfXq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758409940; c=relaxed/simple;
	bh=eFnc9b1aoladqShWY6Ma0VhkLo6XXery986wD968NAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnryzqDKScGcnmaZ5kJG0+HvrSACVIIvQaJ/qQuGHR8dMghSTcuN5RnUiVYsC9WWiVl+jsygDIYt/CT1AvcGe6mtDjQ6sv4PEkEvwLKWER8rJkVm7kYR2k9XjusP5qQSqvIkswjSbB903sx931ePj/kIPAzJjYOczenzD7QHUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZz9J+Mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BBAC4CEEB;
	Sat, 20 Sep 2025 23:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758409939;
	bh=eFnc9b1aoladqShWY6Ma0VhkLo6XXery986wD968NAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZz9J+MjJDl0UvG7r5/l1XW/V0b12bQdNcvgPUBCpjiNXi38BeAg0wndvCctQIusZ
	 JRQNgo2s5r3IVYGkTN0RsvAJm/TD7b7uube7HjIMwc+NCKicO06glpZcC1NPanxG/q
	 fTfL7XRimHxs94vMlvKtTVXxPn6Kil2Fb+Zx7fo34YFG/w/IYPENoZ0y/Glfa1QTJE
	 59Q5M/eL+Z2RYvpnDCGvRqQxkeXGIBXgo5Z/RcW2mJzSqhc+PfGVxILXmX2/gzTecF
	 wkCeO6iYhiRUoTNmtEn8s/PN9SCFXxJbIry6gMNW5z96hefum1S62gYwUYSawWCmPE
	 nmnjkfsCDzkiA==
Date: Sat, 20 Sep 2025 16:12:18 -0700
From: Drew Fustini <fustini@kernel.org>
To: Han Gao <rabenda.cn@gmail.com>
Cc: devicetree@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] riscv: dts: thead: add ziccrse for th1520
Message-ID: <aM800uhWPZ3x28mm@thelio>
References: <cover.1758228055.git.rabenda.cn@gmail.com>
 <71ac2ff73a63bd8674c4bc91fd287390d5339609.1758228055.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ac2ff73a63bd8674c4bc91fd287390d5339609.1758228055.git.rabenda.cn@gmail.com>

On Fri, Sep 19, 2025 at 04:44:48AM +0800, Han Gao wrote:
> Existing rv64 hardware conforms to the rva20 profile.
> 
> Ziccrse is an additional extension required by the rva20 profile, so
> th1520 has this extension.
> 
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>

Reviewed-by: Drew Fustini <fustini@kernel.org>      

Thanks,
Drew

