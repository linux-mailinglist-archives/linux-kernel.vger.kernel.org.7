Return-Path: <linux-kernel+bounces-868026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB34C042DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275384EC39A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B41226561D;
	Fri, 24 Oct 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pus6z7Hn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B148F14386D;
	Fri, 24 Oct 2025 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274470; cv=none; b=H4zBeBObB6DkdJDE6y/Leua2Pk2Y5scMQK/2WbBOLaxXO6rdOivdxSpdgs+nkgdUtOIyyBNmU1CsCDntQanw6IznOwOUsdXL6qXtn0COhtBAL0KyRP8R36X8RiQRrq3LLvmpmzNfGzRcBXbDAIss6kEE1C9FgaoTPcStLUWdgZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274470; c=relaxed/simple;
	bh=l7Kt54esXuy6cW4NMDoL5L7OAAPO8XqbVG+dMVCBp+E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cnYYm6XrhhKF2UvF0zOJypH8JDjYkA3cP6aWQ70W2+2l8/omY8hb1oGskGL/IMDdjILsS5JjTE6Tr6WsGdyFg9OJ8Z1adMNIvvUZPcPB+NPQzU3vmNUHHToYQzYzEYf/MmWOeQ4rHuUNOe+y+d0d42VyqC3g4OicqhT+7+aeao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pus6z7Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8D8C4CEE7;
	Fri, 24 Oct 2025 02:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761274470;
	bh=l7Kt54esXuy6cW4NMDoL5L7OAAPO8XqbVG+dMVCBp+E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Pus6z7Hnt6+Il3SwthVqHOZDDC3GtvdSOcNTbT6k3s6naQxBmZJOubRVwEsVI7CyK
	 WwHiawimzzXy3DVXjWEmkdcXxxXFqrn999N7ZI7H7HyjKq02A/GMxhgXOCnCZJmk6z
	 n0KQA75orlACk89OVqeKuc9lAqR/aV5z7KDU7VlujFKQrYvsCQ0yNNsW0ubE+/dkF3
	 Q95Z1EikX6S25ZDXSZcCR+A3vCCid8FV15jt8fgkkJkDGG2/esvjgOVP2IRhT85kQT
	 xLf8nCNxFa7R1KdtwJeYAsF/Ch82aRUhnb3IW53Sv3a/CSExnMp6NddZCW55ctlM7h
	 AW4w3QXaTcjfQ==
Date: Thu, 23 Oct 2025 20:54:13 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Rob Herring <robh@kernel.org>
cc: Paul Walmsley <pjw@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
    Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
    Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH] of: Skip devicetree kunit tests when RISCV+ACPI doesn't
 populate root node
In-Reply-To: <CAL_JsqJjiB3h+hzstXSbnyFy+U39GgtT=rcb4r+QDv=uL54H8g@mail.gmail.com>
Message-ID: <1260cd8c-2904-1a21-d7ad-ba9b82f67797@kernel.org>
References: <20251023160415.705294-1-linux@roeck-us.net> <2bef32d0-2c35-c93d-08a8-71966c1212f2@kernel.org> <CAL_JsqJjiB3h+hzstXSbnyFy+U39GgtT=rcb4r+QDv=uL54H8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-935726058-1761274469=:3901516"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-935726058-1761274469=:3901516
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 23 Oct 2025, Rob Herring wrote:

> On Thu, Oct 23, 2025 at 11:48 AM Paul Walmsley <pjw@kernel.org> wrote:
> >
> > On Thu, 23 Oct 2025, Guenter Roeck wrote:
> >
> > > Starting with commit 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by
> > > probing DT devices when ACPI is used"), riscv images no longer populate
> > > devicetree if ACPI is enabled. This causes unit tests to fail which require
> > > the root node to be set.
> > >
> > >   # Subtest: of_dtb
> > >   # module: of_test
> > >   1..2
> > >   # of_dtb_root_node_found_by_path: EXPECTATION FAILED at drivers/of/of_test.c:21
> > >   Expected np is not null, but is
> > >   # of_dtb_root_node_found_by_path: pass:0 fail:1 skip:0 total:1
> > >   not ok 1 of_dtb_root_node_found_by_path
> > >   # of_dtb_root_node_populates_of_root: EXPECTATION FAILED at drivers/of/of_test.c:31
> > >   Expected of_root is not null, but is
> > >   # of_dtb_root_node_populates_of_root: pass:0 fail:1 skip:0 total:1
> > >   not ok 2 of_dtb_root_node_populates_of_root
> > >
> > > Skip those tests for RISCV if the root node is not populated.
> > >
> > > Fixes: 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by probing DT devices when ACPI is used")
> > > Cc: Han Gao <rabenda.cn@gmail.com>
> > > Cc: Paul Walmsley <pjw@kernel.org>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Reviewed-by: Paul Walmsley <pjw@kernel.org>  # arch/riscv
> 
> FWIW, the fixed commit will also prevent enabling features like this
> series[1] enables. Arm64 is still disabled ATM because of disagreement
> with the arm64 maintainers, so that can was kicked down the road. It
> would be better to not disable this and address the issues as they
> happen rather than breaking people down the road.

Thanks for the context, Rob.  Can you share a pointer to the ARM64 
disagreement thread(s) (either publicly or privately)?  


- Paul
--8323329-935726058-1761274469=:3901516--

