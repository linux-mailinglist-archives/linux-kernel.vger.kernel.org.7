Return-Path: <linux-kernel+bounces-779178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4FB2F01A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C8A1896FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC1283695;
	Thu, 21 Aug 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUMexZGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88E21FF28;
	Thu, 21 Aug 2025 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762642; cv=none; b=Iq1juUQaiHSsRY/q5JhaCFlsIRCa6UFqb0O/jhY9+w+Tpulj8xkCsQVJdyupCIn8r0Ke5bsfDJInGe/sydlSkUzvl9YkBu1tHwbHaWYW3uGEULlNR+so5MYKGQ2+Az7mZNzLp5NyqycAysuOFzDNSF7DwIggZrr6b3vgbXF5Hnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762642; c=relaxed/simple;
	bh=qnJopNipLh3FqGklQ4hmhZnz9mS4vFaKnOdQxhh9jqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPDHz0GjCNyFVicog+g4URQzf2Q0avQ9Lwcs7Ayy6TDYEmQ90xHq4s4Ll3IwGjlU5kTm425jrf5sN20if+B0PW7n9UvfIC3xsekTRKJ48aiRXQPVWPCk98rGIOaESfmaHTXEVB7uW/SdnLTJK7m8m8YyeTFXA14Kx8j/VjU4J3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUMexZGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A175DC113CF;
	Thu, 21 Aug 2025 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755762641;
	bh=qnJopNipLh3FqGklQ4hmhZnz9mS4vFaKnOdQxhh9jqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUMexZGgu5yeuoQuKlzmsf0qMrErQ6EGUpsD8tZsus8qNWWKEvuMr3p8hgJ2YXAhY
	 NoPb49I0Rr9NC5308lEwTyqLGl8yQ50rGy1BnNymu3gR8U1tV3odNXtdPow/AFO2eX
	 ukk4QWUSuDtlFE7ipDgHj5iEmUJiOHc6jAfst+XPtAHmby7gqTxKfWYflVg4yNkx7m
	 m/m2jtf3pq5JnrWrG/IkQkjFZmBeRJSwdcgNyP7gOsbhzqRRB4EwzoC4abnD7SUJYc
	 kzVC/cl/Ln/JHMzNr01S1AYoaUL8qaAErB8Pg5RD7TWTR3KLT1nFAwfkJnxUj+aab9
	 03KE8nGXlji6w==
Date: Thu, 21 Aug 2025 09:50:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Icenowy Zheng <uwu@icenowy.me>, Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH v2 2/3] reset: th1520: Support the new compatible for
 VO-subsystem controller
Message-ID: <20250821-helpful-chupacabra-of-fury-b6b3cb@kuoka>
References: <20250820074245.16613-1-ziyao@disroot.org>
 <20250820074245.16613-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820074245.16613-3-ziyao@disroot.org>

On Wed, Aug 20, 2025 at 07:42:44AM +0000, Yao Zi wrote:
> The reset controller for VO-subsystem is previously described with
> compatible "thead,th1520-reset", which is misleading since it implies
> control over all reset units on the SoC.
> 
> A new compatible, "thead,th1520-reset-vo", has been introduced to
> describe the controller's scope explicitly, while the old one has been
> deprecated. Let's support the compatible in the driver.
> 
> Fixes: 4a65326311ab ("reset: thead: Add TH1520 reset controller driver")
> Reported-by: Icenowy Zheng <uwu@icenowy.me>

Missing Closes tag. Explain where is the bug. "Implies" different
meaning is not a bug. You need to describe user observable issues of
this bug.

Best regards,
Krzysztof


