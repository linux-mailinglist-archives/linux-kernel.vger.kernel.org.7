Return-Path: <linux-kernel+bounces-877608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE84AC1E919
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894DA3B3399
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ABD2DC76C;
	Thu, 30 Oct 2025 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b="NJyONb4D"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85697246BB9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805934; cv=none; b=aayEbs0dxpA6TkbmZu+hSv19I3HaYt76Shxsuv3HxT7oClDr93MgT+JvSnJ3sl9H4b3PjUHXkwLOIssmNztr2F/0JmsEJFUvASsMVU6xjCYaIpRkb3XpyGDl4Zuh9LQ4QbgxBCzOR9jzgwRZahDh3EYqS+ZLoDdCVpPXobX3ZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805934; c=relaxed/simple;
	bh=I4BMuiEjLn++tRWHT4XGiO60/BW3jxqkQkPemi43GaA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DaOepAaFPa/yMFXuVnmxZ42JzGGBjb6vQ6MeV1L4lfc08YgNTt5aMM+fQIdC8IB3j/a0lzPKE4uj9NTlKPGhtfYgLcGerbRba4yJ72SbjyCWZm9yyHPWqdWnnvEkpSk5hcnqTudsUwfQY4mZz9ofzp2dgXBJqP1IMZAorsSqq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu; spf=pass smtp.mailfrom=bit-tao.eu; dkim=pass (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b=NJyONb4D; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-tao.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-tao.eu;
	s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=19f+hPZicypPk9yYcbWukcZG1TPVTzu3E8A1Y2aKhH0=; b=NJyONb4D4nSOdmhHr066BuFf0S
	/MqSrdaJHah/PBOfhCbiaFVHMn9nE+a8CUo2rXXHGpr94jZF9oDGGDSk9xeGXpg2JaZEWFaaRjvBM
	0eFOvvgaXEerKPvtynjclEGT1clf1QO7bndib1c/jharClZrBUO8m7MYIZTkNt/coH5lVdPj6mri9
	rJGFTjqwUAdiFi3nNPCADToCvs1WaQLIpxkZDClNMA7BWwTgCj0022YQDzVKq+JubXDljy3h5tkl3
	N82JhBuu3SfiGqIMVO/UEOduTyDRNCJGA+PCgxxGXW7OYNoGIequAVoynKKDpID2RetldCNrszAz2
	oWgun9Xg==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1vEMCa-002aGR-Ey
	for linux-kernel@vger.kernel.org;
	Thu, 30 Oct 2025 07:32:04 +0100
Message-ID: <51126646-c7fa-40b5-a991-9dd421d9bdb1@bit-tao.eu>
Date: Thu, 30 Oct 2025 07:32:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bit-tao.eu>
Subject: Nerd, Geek and Hacker (was Unification in Bitstreams System, Fair Pay
 Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Nerd, Geek and Hacker are all about the same type, however some variants 
seem to be more specific.

Nerd = sABIAN in The cORAN.

Hacker = also hAC in The cORAN.

"Geek" for computer Bit as relevant here, incorporates all, and is 
symbolcorrect.

Bit Geek, actually implies to be correct with the computer Bit.
Symbolcorrect for design and programming of a computer system.

Used as a variant of Bit Tao follower, it also incorporates standard 
labels, celt, jew etc, and should suit everyone here.

For diplomatic reasons, this is optimal, and one may consider using 
this. It includes all fair pay philosophy, correctly aligned with 
computer design. Be correct enough of a Bit Geek, and you have fair pay 
priveledges from the Bit Tao.

Ywe Cærlyn.
BUDI,
Bit Geeks.

