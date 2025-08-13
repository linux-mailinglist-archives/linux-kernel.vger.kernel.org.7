Return-Path: <linux-kernel+bounces-766529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6770B247C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD472628AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E972F549A;
	Wed, 13 Aug 2025 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoNf2dZT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B122F5322;
	Wed, 13 Aug 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082450; cv=none; b=hYa9XBCTDInoKCaF3AlDDqzG+HuWEEXmS5syAYmwAFd8RANqaDUk9oTRWIBIf45mUR2p4sLRzkfwQqioxMiPCXhXUucMNo6euEVmpWRwiU6IeSOSaifSSABLgXoeMObCQ+JJTcl3vF/Z4ktR2sAbn2S2zunOwfLgR7txozmPiog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082450; c=relaxed/simple;
	bh=IA30e12EnWb/a4zorjCkw/sI2jug3qphKMlYO7PiwcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rvBOOlOK9+W0Dqj0+Rxc2P9kVk2tCNYvhSxOzHKuXSVlLOiDuVb6e0GG+zdwY903NsyZ1JoFNzWtTNn2lJ3cs9paVB7StuRJd8P8ScUWj6LqsldbJAjpYcO7qA6FOFoEOlufDaMs72pLt9QVwbvinaE2EyyQV4wleQnb/PaRxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoNf2dZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A227C4CEEB;
	Wed, 13 Aug 2025 10:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755082449;
	bh=IA30e12EnWb/a4zorjCkw/sI2jug3qphKMlYO7PiwcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HoNf2dZTWlD6t4UslGDzYL6HQVadeIp3pBgW2RNENbgFVTJSqRsVe1Ri1MCcOmcRd
	 veNueKZ+NA8lVOXwC1LL82K+PAlALoGYxAe9jPb350JedxlxRKwcsRTL1CiT+Bd5qO
	 PTUxJ3GAtzDDs3ldU81xJlg/ySZIOapCLLi34/t1RwIue0ob84MJ2uS/XeOILNXcyA
	 qzKtAfei/qbBbsHP2Ccod1uzcUfGZGjv7LXdiQwVD2WrsNs61Gi9OwsNWF613i+Xm8
	 7YXNPlJ5+p0hFJPZRkXMk5xETACovf9Txqj/MWoVpnJRu2Wsg/3oc7gopF5AhYGlGj
	 izVeLdHl6OKwA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-rdma@vger.kernel.org, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
In-Reply-To: <20250808175601.EF0AF767@davehans-spike.ostc.intel.com>
References: <20250808175601.EF0AF767@davehans-spike.ostc.intel.com>
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing irdma maintainer
Message-Id: <175508244543.199624.12082806444245569887.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 06:54:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 08 Aug 2025 10:56:01 -0700, Dave Hansen wrote:
> This maintainer's email no longer works. Remove it from MAINTAINERS.
> 
> This still leaves one maintainer for the driver.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Remove bouncing irdma maintainer
      https://git.kernel.org/rdma/rdma/c/2186e8c39eb156

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


