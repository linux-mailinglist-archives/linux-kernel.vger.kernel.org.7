Return-Path: <linux-kernel+bounces-745825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DC6B11F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56B41C8808C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F9A2ED15C;
	Fri, 25 Jul 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bigon.be header.i=@bigon.be header.b="QSqYcGGF"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABB02405F9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449280; cv=none; b=DQZWGEsJlwhRb5xyyM4v4eVtmHh1PfT5ssJbEtGfuveCkDS8CrlsaYrgZEBHcFnwrkjLBLPGu2ibUwN7yadRP0NPsL+94bFpDnexxX0OYjylp680+VVOn+YgVloNv/9+2Nnq04vqzLsP6bw1sztJwT9bz0YoJifCrh0wZhgSslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449280; c=relaxed/simple;
	bh=J+bAUZydssZqrLY/OcpEbTZp33+EAYp+Ix6zsLJntC0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=JB8YyE4yu6hfmVGj2vVM4qOhbeaBLo0Ot/5XspA/Z8NYj2Dsr3OFEDL7bsgNoWGAqhfYIRtD9thUgMtPoYcoKYStmUzPzwsBWaYdLfHcH4YLwVVXKlink747JEceHYzoDc8hAF/NOG7NHLy6xdEhKcVyWzzwJLdalQQ7Fh8+Yj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bigon.be; spf=pass smtp.mailfrom=bigon.be; dkim=pass (2048-bit key) header.d=bigon.be header.i=@bigon.be header.b=QSqYcGGF; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bigon.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bigon.be
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bpSyL1XZJz9t6h
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:14:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bigon.be; s=MBO0001;
	t=1753449274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vru0ddQmLFu7IumIbxXTZhn+UVXn6Iy6hPJeElrBL6U=;
	b=QSqYcGGFOIbY/ODJdMaLNIC9TsiymktZba6XJc7IEosU5/RkMrDm8Va4gtyFG0WWj1jpkR
	PMabx48k/8mrUMeHxL98Vh933uQ8TXZzn4tBeZZkcCHJjP3GZ1/m0TU7OIgEOAaIi0ommD
	WsU0YryYDH1nX3NsFJYMRZoP4IuMunDPRbt5/bWTQQIoEpODS72QIGbi1SWZoXVk+oZP2q
	b8ZwmE8Sy7t2m0c3D6bCa7Thd4m3HRSlcsCkGgyePZjhtR9DPSNv1D6EHxFBn5ttRLy0ew
	B4cLnCBEfeeyTQ9JKEo6XzuORQI1bvTD1J4/s1wzBVel7XieTXIfqKItt7Ed8w==
Message-ID: <2a8013f8-f15a-4bd9-81a8-31a5f1e99865@bigon.be>
Date: Fri, 25 Jul 2025 15:14:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Laurent Bigonville <bigon@bigon.be>
Subject: Re: Realtek Sdcard reader and Intel RST/VMD prevent laptop to
 properly go in s2idle
To: linux-kernel@vger.kernel.org
References: <c939f4df-b35f-4429-968f-5bf623485af1@bigon.be>
Content-Language: en-US, fr-BE, fr
Autocrypt: addr=bigon@bigon.be; keydata=
 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
 Gub8y8YgCrSTibbvx1KRJA==
In-Reply-To: <c939f4df-b35f-4429-968f-5bf623485af1@bigon.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/07/25 à 12:12, Laurent Bigonville a écrit :
>
> There is no difference whether the kernel SDcard reader module 
> (rtsx_pci/rtsx_pci_sdmmc) is loaded or not.
>
Replying to myself, yes there is a difference.

When the SDcard reader is enabled in the BIOS and the driver NOT 
loaded/blacklisted, the script complains. If the reader is fully 
disabled in the BIOS or enabled in the BIOS and the driver is loaded, 
the PC10 state can be achieved and the script is happy.


