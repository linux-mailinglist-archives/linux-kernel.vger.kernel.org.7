Return-Path: <linux-kernel+bounces-726606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2803B00F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5487BE084
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2329B8E6;
	Thu, 10 Jul 2025 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKHzrBI7"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063992260C;
	Thu, 10 Jul 2025 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188432; cv=none; b=Hhhiq2OsKfrpxiTb96bqnQSoC4vnKAccrDamNy7K/DkstrmbmRyyTEYpkp54bP6Kv7j5a0BLMqwjawNJWDRWxGawMGagRscbAIAxJtJ3nyqn26VeUXtbysfNRf4AVTDs8nO81nydn2936ctPo7oBYXbf931XE/tM4tJKUDvlge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188432; c=relaxed/simple;
	bh=WbrG5Y3ehzPFEbrngLfnrYJFLnogyYDihApajzWOziE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ni8oInmKTH4wITUKxTK+4dqdO6Z2YNJuuA87FqgMiAqiYTH/1Ec8j3L6lRpGBtE9Vbt2Upab2NZsNYuvWc7jngcKe1X1d4jjLzck/f9GMA1d2jLlKnj9hkotoROY5qr2aSVEPBKZ5JxgeGW+A79OqdH97jUkoSfjFEvEynU+IXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKHzrBI7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso1807969a12.2;
        Thu, 10 Jul 2025 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752188430; x=1752793230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UDbH8adUdkAQnHiMD/oFlw4Z3YysuzwSnxI7b2i+rM=;
        b=aKHzrBI7F7lvDx+jGQ3rwLyV3pdvcYWP8ynfPdPOiZtcs21EUBeh6P8SyiyXKpDuN3
         QeXsDmLu35YCrVNt9CZ2mOJmh79Mg/ViwfIvQCfaedfrlAfm//VuS4BeNR9x2NWKBFhk
         J3ZC8tWynLJuLYR2BRAyMUt516jRYhWBU4le3vF+18DxDdhNUw/M75ka6RhMrrRYvccF
         Ib5kC68QDNcQ5Fc0GqLtmBXvYMOGJYMnHR7y9G8wS+18fOMjrq80nAfQ5q6oLa5EvLt/
         dQmjpfyct1+56v7nHRb94akDZnWWyye/YK3AP7sLdkblvWMN24tEjZmC8BQgOe2pXgrZ
         1BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188430; x=1752793230;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/UDbH8adUdkAQnHiMD/oFlw4Z3YysuzwSnxI7b2i+rM=;
        b=U8S5YP/35A8h76qN9kcAcY8unWVBhseF0wHjcvtxBuJwinFAB8csNOWXPRZLlq/afQ
         6CZ5ccywyg3z6RinGTMb11Za7ARZCNePpsnd/fKBNB2NhYlxCDDF860fhAfoB9WlRPTQ
         WXyh3yrOeDx6vffdMMvABMoJtWRCHeDOGlaMKP4vDcXWHwBgLgzQ30cBDAIxPsPy1t0W
         5mLTkbaVOHP1myMCtgPcyDMnmrFt46orOZliUb9vimH8eaYRMIyazlbttnFCia2dTWl0
         ChdXYYhiZWQUl+jY39uwpmL1H6iMCbFCqPoyFaWLsD4PLc7CP55DoncFKrezTj8bbRVd
         hqHw==
X-Forwarded-Encrypted: i=1; AJvYcCUNDfOkaLgmzRN5bYd22GJGRf8rCdvwwN1bbLGNTZ+TcEVfj7S0MLm0vuYESrn3TXlIkY3U/mmJf8XiGts=@vger.kernel.org, AJvYcCWR7OZk/Sf2DAkZ5kRVNA2IXf1tfyG9TBkjCNp9jilKST+RWThkIZn+Q8KzhyjwjQl7HTT00afW1jYkzRnaM6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3TDYIlL+sq/jzX02NS9wuZGM68dBNZkq5kWrfOBo13jFJFpcV
	5P5LxLZaHAfXReQbORD41f6HAd24qFRrvVDENewTac0JpdoUQ+rkmRsKvaAawFRl
X-Gm-Gg: ASbGncsoi33IEmRvHHPC46aR3etUaoutZAvrQi3BR16yLLI2noEJoXQizqCE5sIBK9e
	cGOHQjGQmY1t9OsaH71pBztTcTzim4myVY8QoG69UkTF295/vX4bVhdzDYYfYp2YuNt9afyV+qJ
	72UuqWPp6Jm7L45OErr6jtlKMVuiJH9fspxFAuZ199LIf8SpnxLW1sbGfxpSV3KkB5pLXNcmig9
	g674j0Xeg+G128F5ecVbJlgglucozavFFynUFy448LFdISHKOGDlZgYeZFxqLxiBjCIprrSlYj0
	E5lLzI4/goTKvTXm92KGpO5/aUG3DcDuPLwa1r8bu+ZWkvalywYsIEEwSrscEuBeSIzz6UZfza3
	0/CZAB3gFm7UnaMcSejdM04sxiJtA+AY/1I5o9kLF
X-Google-Smtp-Source: AGHT+IFpepNauY4oEe1qPdoYTK9j5YID61RwT8ZI+UaN9Ul3JFhQRgaAlvoxNU3lRNPtEzD1NlVJgw==
X-Received: by 2002:a05:6a20:6a04:b0:220:83e1:49a2 with SMTP id adf61e73a8af0-2311ee4b25emr1509848637.25.1752188430014;
        Thu, 10 Jul 2025 16:00:30 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f8f35bsm3467226b3a.169.2025.07.10.16.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:00:29 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:00:13 +0900 (JST)
Message-Id: <20250711.080013.1402268636571271744.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, miguel.ojeda.sandonis@gmail.com,
 alex.gaynor@gmail.com, ojeda@kernel.org, aliceryhl@google.com,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 dakr@kernel.org, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu
Subject: Re: [PATCH v3 0/5] rust: time: Convert hrtimer to use Instant and
 Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <871pqojlyi.fsf@kernel.org>
References: <20250626.091248.526065656918619245.fujita.tomonori@gmail.com>
	<87h5zstoaq.fsf@kernel.org>
	<871pqojlyi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 13:59:17 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> This was discussed [1] and consensus was reached that `as_*` iwth pass
> by value plus a `Copy` bound on the trait is the way to go for this
> method.
> 
> [1] https://hackmd.io/ZXXSbxxQRpiWzX61sJFlcg?view#API-Naming-guidelines-for-conversion-functions

Great, thanks!

Would you like me to send a patch for something ― for example, a patch
that applies the above changes to the current timekeeping-next tree?

Or would you prefer to reset timekeeping-next to an earlier commit for
a cleaner history, and have me send a patchset based on that?


