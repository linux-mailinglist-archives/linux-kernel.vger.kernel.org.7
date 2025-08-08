Return-Path: <linux-kernel+bounces-759631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A7B1E05D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB2580379
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42336176ADB;
	Fri,  8 Aug 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NylGELSp"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFF125B2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754618401; cv=none; b=BFBiBxRdU33T9i0nzcreECl0Y4SZFI+fBFUyWhhVqOQYh5qQ1CDUNnzVaOOxY3Xl9veKum5S7peCV04Kv8hr15uLOld4mLWrRQIMXx2wMw+6wPASw36HLR7e8TMFX9PVw64j8XlkVoEw9k/Ug31+qjU3mdIrtTjCOdd1RrHHg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754618401; c=relaxed/simple;
	bh=/Uq+2jrltc0BbH+yhvV2T52C6Ute+9a1sH7wscnQ5dk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cm/FcUvhMIKnY1TaRtLueQMsbgnQuT02dA1hi95EVqjK2W/pMih3DA9gPS/hM1375TDGZ32ENC4rkWTO6Vac0vHZ9sLXjWNKuCrEH6Rn0X7WarhcVnU/YEtxeZt/OaPffTnIOLAWBGGOxOEP8gRP5Vu72T+H61ev6sTYPDcSJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NylGELSp; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754618398;
	bh=q/Z5CMd8EqF5C3UMm0RvWAXOy10PzdDqowUayHDZKGQ=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=NylGELSpdyLnmd+nk3zp/3w2Id/y8sk1xJZFnSo66Uj4i4pjruofrsSIM3teq513s
	 Rok9KjpM0wARz2r8uJmRct/edZoHBforpNC4l1k1FvSa/Hk7S9DQEm6NSTYXSj9GFo
	 10v19Io2DyYpe9FuG/rxgDfi4l5YI9n4dLkHU9ybLW0BOAIlj7zTBBzQo8aDy0apZa
	 FNdwYndbsbu5iN+HSgVmqAdBVMc4nrch7VXrxEORfbv+ncZUZcVlpzt+KqQKKw3G7U
	 zJonrGny/ZmP/3gguqwylkIwwKq1ye60LaJHID4EfzLI1D6uhoAX5r0CSvU+7rd2lN
	 rsk8lssptzd9g==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 02D7D6D59C;
	Fri,  8 Aug 2025 09:59:57 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20250807005208.3517283-1-ryan_chen@aspeedtech.com>
References: <20250807005208.3517283-1-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v2] soc: aspeed: socinfo: Add AST27xx silicon IDs
Message-Id: <175461839791.140589.15788299148211671960.b4-ty@codeconstruct.com.au>
Date: Fri, 08 Aug 2025 11:29:57 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 07 Aug 2025 08:52:08 +0800, Ryan Chen wrote:
> Extend the ASPEED SoC info driver to support AST27XX silicon IDs.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


