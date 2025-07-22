Return-Path: <linux-kernel+bounces-741441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B4B0E41B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A03A7747
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68CF2820B2;
	Tue, 22 Jul 2025 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lLa/uoe3"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E1284678
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212396; cv=none; b=m4cNLdTtx9wun6CvNho1rUJ0k+b79v1XGQWZJMYKXURavu/TydZ6SaVR/BSh7xegI0bsh4Whv6enDE75BDHxbiP+alzvstbcLz5AG0uuueTgZHr22aZ7KHi+XvqWVBsZS7xfGBjaGm9noCIHV09J9ebfWUnHIW058yuINJUvpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212396; c=relaxed/simple;
	bh=Ak2zl5YQ6SBfelNgtL9IZ7NOLrotfSVgaotk7o+nlXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9GvQLIgRbxnN0srwZoEUxb7BQoeGGjHk4gBXsBYbkT3Ga6jjKhLhjvzHZ/AGFaiy29MaNerMcC5cBoCh5EoZFPV/RskXkkafoA13UyfQbjoeSLxkJKCLt+k2ROWFNfrX4nzSieSz5bKX0K0meZDhVYLJq4FVOQWPHMAuDal8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=lLa/uoe3; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:425f:161c:76a:170a] ([IPv6:2601:646:8081:9484:425f:161c:76a:170a])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56MJQ59h720824
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 22 Jul 2025 12:26:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56MJQ59h720824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1753212366;
	bh=jRAE/iwDLlzgRgUPw68AII+x1vKWpMkcBM7E+8tsN6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lLa/uoe3Zkc7L//1Ge9NH5G3X/uEVS813e07AmPNUlcDXgIqnLc8jM6KsvNPO4waA
	 GHjK0QbmQRSsmT+SgOX/VE2KoSu42uFhwoLFH8/Sw7W5jFPPr5SCrqhJ00/XbI7Ms+
	 +/KeUKVbO+YTv1YocCJVuypef3Voz5tDpLGLThAqlfZNOMARnFjPg8DnO8njfAKOxa
	 KwpyoGtE31zlRMTPH1U6D+jXzwI3/AHpEyvDaEeGJ3LOOpw+MP0Ga9c9+4eoI9pd0c
	 i6RIOU2JckV2Ngxp6pWSqIUBu8+jBp5XRxSZG86Ulk4rJTRfw3fq0YEf+LDuEmGMY4
	 sXnwKi7J8HrKQ==
Message-ID: <58952466-2d35-4422-865e-3d5e17089fc0@zytor.com>
Date: Tue, 22 Jul 2025 12:26:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Clear LAM and FRED feature bits
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Xin Li <xin@zytor.com>, Gleixner Thomas <tglx@linutronix.de>,
        Molnar Ingo <mingo@redhat.com>, Petkov Borislav <bp@alien8.de>,
        Hansen Dave <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20250722074439.4069992-1-maciej.wieczor-retman@intel.com>
 <32382f60-79fb-4cfa-87b4-581f92c980da@zytor.com>
 <A4EB1016-8CF7-4609-BBF1-9AEC83B52A4F@zytor.com>
 <oniuohiub4q75xwflf2nsz32aackbt3yrdweg2y6wimbzz5nvv@yxf2xnl7cgcn>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <oniuohiub4q75xwflf2nsz32aackbt3yrdweg2y6wimbzz5nvv@yxf2xnl7cgcn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-07-22 11:19, Maciej Wieczor-Retman wrote:
>>
>> The easiest thing would be to initialize the setup disabled mask with the
>> DISABLED bitmask instead of zero. This can be done statically; if it isn't
>> already the awk script can produce the disabled bitmask in array form.
> 
> Oh, that does sound simple. I'll try that too, see what ends up with cleaner
> code.
> 

Xin should have code from me for exactly this.

	-hpa


