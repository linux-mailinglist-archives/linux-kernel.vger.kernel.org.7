Return-Path: <linux-kernel+bounces-890699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36233C40B13
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603BB3ABEAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B88330B32;
	Fri,  7 Nov 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0r+vnfj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01107330B21
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530854; cv=none; b=XA+IMw+y6vp7ZANKRKZcYXKtBnhLSlkiuP+tt1wcZlbmAdrYwJ29RgyW0oWCEQcYYstmp2x5CT6cbOJTNhrbC6UybQLEZnbBFN4240hmxMREsdViuPR3UnUmwwiwKm/qHLBnJHToRLPqfYdmHBsEpSihTbUy6T7uTRu35zKXdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530854; c=relaxed/simple;
	bh=sDHvLVRjvkDnU4qYqkoNhTswWRcf8/38VCp6BJVNsss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnEYMbkFe3oMao8Q0nnuGRz42rCxWta479ZrHm+F1XX9A0ebrrSz8zTFR5n2B7aC+pdN1iQ5GN5ndj7djcTYPb8eNHSVRAaBBExE2w1vPMSLBBCetMlUUFZMstbfyPFWQBgXjBJJU+kSki8hgFtJcl0aWMlui/QzIQ9pyXluwQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0r+vnfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCD7C2BC9E;
	Fri,  7 Nov 2025 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762530853;
	bh=sDHvLVRjvkDnU4qYqkoNhTswWRcf8/38VCp6BJVNsss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0r+vnfjnLbi8Q/AnZ2Ue3FbPBj8Su3koMzDbjgoJTuSYnztZdDoXOYsMAm+Nt/Qh
	 3BxT22iVVGYfosnHBPE7d02klR4nDJ0MhuQ/E8DepSsZFvuERXd/z3qpAPpIbfl3c2
	 sjwYdeH21mA7o3wD7AJg873KEY3hH9RpUvk7rC0PjZreR+94zf57WsJE137WZz+H29
	 DguKiiU3xnFJgyDfwQ+0pDWOGt5L0ZKd8MtIpP+V2cIz7LVdZ90u3JwKi6zhI4mA41
	 eu0Ti4LNqIYPTQBaRj4IfMaYQKC789MqO8MCje+tQ+QXitlkk/GKw91+LaLGU5wwry
	 WOVPCKW4BBnEA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	punit.agrawal@oss.qualcomm.com,
	Yang Shi <yang@os.amperecomputing.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] arm64: kprobes: check the return value of set_memory_rox()
Date: Fri,  7 Nov 2025 15:53:48 +0000
Message-Id: <176252582270.594123.5776451852146900691.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251104214947.799005-1-yang@os.amperecomputing.com>
References: <20251104214947.799005-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 04 Nov 2025 13:49:47 -0800, Yang Shi wrote:
> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
> rodata=full"), __change_memory_common has more chance to fail due to
> memory allocation failure when splitting page table. So check the return
> value of set_memory_rox(), then bail out if it fails otherwise we may have
> RW memory mapping for kprobes insn page.
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: kprobes: check the return value of set_memory_rox()
      https://git.kernel.org/arm64/c/0ec364c0c95f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

