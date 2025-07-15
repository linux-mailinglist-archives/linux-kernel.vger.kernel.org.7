Return-Path: <linux-kernel+bounces-732508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DA6B067C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4CB1C20739
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F623273D85;
	Tue, 15 Jul 2025 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X/UAbdLt"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27C156C79
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611526; cv=none; b=uKQIsE5RBAmv3HxX+H4LZvzE8R1UrAI8ePyxxPP/KA57dc8OIA3g6GiCmpXlCFRtsOzxHmJqp+PserIGwxcKGHoRLUIH8/NfX4CbzkLx09QLaT/vSYE0XFwl3qNKMezF2yspXXxzAFQnLhWcBwxn5L6TmgdcnE2EJmvOW1GefSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611526; c=relaxed/simple;
	bh=vftnosTumCPf/K2js4YY/7wXbRPibhX/Wl/Hi/rVO+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goVq/3ybdha5xgeO5sooUXLJnMdrj0vhP/TqbA+FRqYEmwFoHqeXvjxx/Au2AwEpeO2EgCgzYp4071Y4uOYKVmtxCJ0rEndpqsxCqkiVam62PR8asivpGpbfC7+RI/KVwah9Uw2pUaXTiWpwz+/udOrGOHB3q0h7GD3tnWtI6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=X/UAbdLt; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9482:6556:8629:7dba:d48c] ([IPv6:2601:646:8081:9482:6556:8629:7dba:d48c])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56FKVeOR1139577
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 15 Jul 2025 13:31:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56FKVeOR1139577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752611501;
	bh=2MEi3B6VoFaozbAby4s2aQ5Qn6lhlWHo8Y8vXA0765U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X/UAbdLtiJKJrqVPowaAuWymgqOc5+z0tIpDp72fG1Vo5d3dYSE/lxIIMEpTnL6M2
	 Qq+WGYzrsEaaCjd5AYCp/qfGg8Vjv7mpK1lX11KNQYnYZQEwl99/pTRckv4vZkM6eY
	 +V/MpHhw8fKZgeru6TFau75fm6Rn2FLJg1cBJ4/ZiEBugHevrUxeR/RZdjMGvW0PqF
	 NvJk/Cl+fHKRyeiBWvswoUmkTCvntSIMDjM4X1+espR1hfBoQK0MCyUKSoS75mCT4H
	 c0qG1ebbFwppdFOs0YalfgDe+bV/jIuMYihntFr4K2ZBdILGThhb3fKx1QINThM6PT
	 OSLPxFfPl0D3g==
Message-ID: <1f809e9d-5383-469d-8c31-10f8230b79b8@zytor.com>
Date: Tue, 15 Jul 2025 13:31:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/boot: Avoid writing to cr4 twice in startup_64()
To: Khalid Ali <khaliidcaliy@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, ardb@kernel.org, ubizjak@gmail.com, brgerst@gmail.com,
        linux-kernel@vger.kernel.org
References: <20250715181709.1040-1-khaliidcaliy@gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250715181709.1040-1-khaliidcaliy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-15 11:16, Khalid Ali wrote:
> From: Khalid Ali <khaliidcaliy@gmail.com>
> 
> When Initializing cr4 bit PSE and PGE, cr4 is written twice for	
> each bit. This is redundancy.
> 
> Instead, set both bits first and write CR4 once, avoiding redundant
> writes. This makes consistent with cr0 writes, which is set bits and
> write once.
> 
> Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>

In case this wasn't obvious, this is:

Nacked-by: H. Peter Anvin (Intel) <hpa@zytor.com>

... with extreme prejudice.

	-hpa


