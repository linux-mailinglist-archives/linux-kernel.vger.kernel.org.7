Return-Path: <linux-kernel+bounces-721023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B078AAFC37D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E073B0D07
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954E223DF5;
	Tue,  8 Jul 2025 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b="6WD/qIcT"
Received: from wiki.archlinuxcn.org (wiki.archlinuxcn.org [104.245.9.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CF1F0E58;
	Tue,  8 Jul 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.9.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957833; cv=none; b=jDsosxvHoJDdZS93epZwIohiEL6pAu8OcqLeTXu4gGvdDLE/wrWu1ScwlFwMlnrrUgtlO+WIGm6Xn/tDQoxOD8Lm8OKSc9M8eiaHVbwHBd3KbBHR3IRc323phigilSCxQF8aCeZ4pi+7kDomzjZmZjTGFpuo2eEluIN73oBnTtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957833; c=relaxed/simple;
	bh=yoUrgK4WIHlzQWl3kA0Av2Vsc2BP10Kej3LtqCJ91lc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rOHQVgdrA81nkO/MTpfNmK0R+VpcoMsOX3o14OgkZ4jz6JXK4+fWQI9Q1yLIIWJ0/MGbFeG6+R0oT3WY8SXibY84/GtAHGp+BVbLygd9l8gtWdsao2f1W3wNJH/ch0ikvtsTRWic78t41ta+9/IDeBd1te8mU0fMnFujuigkraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org; spf=pass smtp.mailfrom=archlinuxcn.org; dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b=6WD/qIcT; arc=none smtp.client-ip=104.245.9.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinuxcn.org
DKIM-Signature: a=rsa-sha256; bh=yoUrgK4WIHlzQWl3kA0Av2Vsc2BP10Kej3LtqCJ91lc=;
 c=relaxed/relaxed; d=archlinuxcn.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@archlinuxcn.org; s=default; t=1751956904; v=1; x=1752388904;
 b=6WD/qIcTkGxeO9uIEpoQouCYrTQjx25jylIMBOIn6Ak7bnHQxAgSCF8Q/bge68nf+DaHZk9n
 a1N9TzvUpSbcYCTY8MhYwcJzqo+a1cCkwpHywhI/70P57cWYqBl+f263wMQtD5Iq7sseG9ZCNE5
 EwVdnz1dC57bdOyTzKPhDkYGNcZfI0pvLpeOL01FzfTuuPHrNx6jJIcDYIlgdnhBVpaLPx0NWsT
 YgM2Z87Br88vXfUOmsRpyo19BdcMcXeKN1O2VxGS3bUMmEyt4zkvvLBvcDHsD02ScWxN1I4R6cL
 g69u/5Wi0xmeAu0ijThbQmpSJYaRxEd3QGVhVI91aYs9A==
Received: by wiki.archlinuxcn.org (envelope-sender
 <integral@archlinuxcn.org>) with ESMTPS id 1c5aa930; Tue, 08 Jul 2025
 14:41:44 +0800
Message-ID: <cc3c0ed7-26bb-488d-b80a-6f5a0d0b5cea@archlinuxcn.org>
Date: Tue, 8 Jul 2025 14:41:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: integral@archlinux.org
Cc: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250617070036.10685-1-integral@archlinux.org>
Subject: Re: [PATCH v2 RESEND] bcachefs: use union for bch_compression_opt to
 make encode & decode easier
Content-Language: en-US
From: Integral <integral@archlinuxcn.org>
In-Reply-To: <20250617070036.10685-1-integral@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Kent

Give you a gentle ping :)

