Return-Path: <linux-kernel+bounces-881207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D13C27B81
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4C61887E6E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6424C2C21F1;
	Sat,  1 Nov 2025 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzC5Tlwb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93822CBC6;
	Sat,  1 Nov 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761991163; cv=none; b=Ru1/PVu7QTQQ4GL/WBurvmOd2xSK8uFpoXrM95zkvjsDl1m2e0WDkjw/nmKZvviDtuzfmh0WQETIi0YwhNZe3N/Ro8IsMyIBgcOcyZQEGW4cl1YtwMEx7H30ZAeK4R0XLMYxGg2kc3JDT9Wocm3N043NOpBGkTlMedj8P6qk8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761991163; c=relaxed/simple;
	bh=IjdCMT0CzaODPEdiqPE/BBz8I40EGyTVW1/f1aFsFhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1OlU5NxkXGyri/JSv8LyccAmLozNTV2Fhs3RNWsq2iqAwsPcuYHB/YdUb4zX3k9OcWErhI+VlXThJX1Ysp5DIaXxbNNJDWaqJNVuAHtbnPZOPJ6EAnRHdHhuRlI8Mo/QE/2zvwspMWWTiK+c9764QApnjndW4VgFWYgKMeCqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzC5Tlwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB00C4CEF1;
	Sat,  1 Nov 2025 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761991163;
	bh=IjdCMT0CzaODPEdiqPE/BBz8I40EGyTVW1/f1aFsFhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzC5TlwbpCo+vAQ8OoU0MEC77hUcM1JhYZwdLAiyhakas77mh/q2Sh3vbOKf59hFX
	 zGCvAqd6EYw21u9e9bDF8tTGvfgA0ylgDJUSAnSDm5QkK+EOkdrXpU6cb36+HWViln
	 Cj0iYYFMWouS9OrjZuVr+LNjiF06weYfsmBCg5duVNW0sYax7RfTua9LDaQcLaYnpG
	 BRykl9ZuDzKxDcUFcQsYcpl0J3CK0vv9oFTVgnv4oU6B8S20gO3Vt4yL+ub4433S82
	 +Qjq30Sm4czVZwV8dXBB1vw5fqhBFagcOrrOsYGzFLzYbCaZQTWRLALHFoy7HJHkbr
	 BLQ7mifSoRp0A==
Date: Sat, 1 Nov 2025 09:59:16 +0000
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
Message-ID: <aQXZ9OjXC-cse0lk@gen8>
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

I've applied this to thead-dt-for-next.

Thanks,
Drew

