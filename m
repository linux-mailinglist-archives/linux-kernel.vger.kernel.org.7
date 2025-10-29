Return-Path: <linux-kernel+bounces-876061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EC3C1A921
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A50622F06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A529BDA1;
	Wed, 29 Oct 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzcgEJ0B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8777820297E;
	Wed, 29 Oct 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742258; cv=none; b=b3jAOf3IZBdTbH+Qg2FM32+5tEuU22xY75HxMrARabYUeWVp3SQ3TPstIkJ4rMAHE7IOs791NVuyxerLgNecKjI7HNs5Txxb9hgpjXXv7tH1/HuEfr43ckPn3sfHyIkupsJW9+1zMOARl8uLp+FM7IYPhf8xTjSY9497rMV2T88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742258; c=relaxed/simple;
	bh=4TBWX2dHkHV9SwuNsU7c4yBhCIWcloSM+wJm+VDz19g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGwSsWLSftr4Xsm1RH7GAO1p0LS3s1BX7GJ916Yp8BXr6tUFF2DWrE3Q+FvGuKCJViHI0UC2el6qdRPbxxSRXXRYavqnD7EvqIRe1qGqtaHOJf0d2dDAusC1CLFTZR8AU94MEmMR6ht6kDBrWIwJbl6yhNec1gulIWan/n9XANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzcgEJ0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13910C4CEF7;
	Wed, 29 Oct 2025 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761742258;
	bh=4TBWX2dHkHV9SwuNsU7c4yBhCIWcloSM+wJm+VDz19g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzcgEJ0BKNZr6wA+ygkQR6d44U8lmT5D7Mn/4HstBHyo6yyb1W7ER7wpPK/cX1bbZ
	 /NXMB/pVwxddzZa8raLzXbbHtc2GlNvuZDZ9B+kZnpEeiJBAfO4pNB9MkQ2PwiRhqy
	 Tv7S2t2XDresd6M0yS7uzKr4XFA05/cy9JjhVt3JeeXxgZ6nw9cnZrt/4lTu7p+Hj+
	 owVYIH5bm4dGJip3seN0hr818oMFVxmTzba19fHyZkb7yjX3qEShQypEP5jN3nkNen
	 2tjvfFNs/bBKCKvt1GT8ztNlL1hIgxeuCg1zFpjKsihTv07+CNbu9xibVdg1W9E30C
	 QWG2doAdI4Oeg==
Date: Wed, 29 Oct 2025 12:50:51 +0000
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: Re: [PATCH v3 5/5] riscv: dts: thead: Add reset controllers of more
 subsystems for TH1520
Message-ID: <aQINq-rdtT3Dps2g@gen8>
References: <20251014131032.49616-1-ziyao@disroot.org>
 <20251014131032.49616-6-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014131032.49616-6-ziyao@disroot.org>

On Tue, Oct 14, 2025 at 01:10:32PM +0000, Yao Zi wrote:
> Describe reset controllers for VI, MISC, AP, DSP and AO subsystems. The
> one for AO subsystem is marked as reserved, since it may be used by AON
> firmware.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)

Reviewed-by: Drew Fustini <fustini@kernel.org>

There is a conflict now in next but I will fix it when applying.

Thanks,
Drew

