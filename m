Return-Path: <linux-kernel+bounces-772336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3238B29182
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03ABF7AF5B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D8A1D86FF;
	Sun, 17 Aug 2025 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds4mzcdH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A11A3A80;
	Sun, 17 Aug 2025 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755404511; cv=none; b=eeQgFuv+RjOlIAS9cs8pISpWmcluxhifKcxMdP3ANSzHed/byBsRZLSFYLDRkBKHvW+0KlGl0rDWALZUWnIPBqWRTDBNKF8Y4PkX4kHLrUVfvE+uhHLnDxh0Z6lAg0XSIJKFUW/+rgivgFvNWVpv9S1bvWzrWbIJ3UbXXXA2zWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755404511; c=relaxed/simple;
	bh=klDD3bSj2iX0ijHV1E5O4mJVLok7iWUKphq+FNfsyhM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u9UmomwkNprTxbaF3WFSlAhavOXO9/hwBGdZebNr3ISxqvT8A1yPU0JDODazRCf+0ccM4PdSAeXbbku+elBxOehaNj/ACVCccCek5CFevYnnoRkkeTtBkP9iQWhN3muQkCsGLd782zavV3OdWIn+h8C87F9JZcDBE36F8/xyTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ds4mzcdH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e43ee62b8so1141162b3a.2;
        Sat, 16 Aug 2025 21:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755404509; x=1756009309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Gxto2WYWn+qE0Oz+kHca1dPDn9IuzFGHvmwvCJpza4=;
        b=ds4mzcdHncb4f7xXTww5AKENnGjLxhuvyWmhG2U8/dRYXd0+drYlOScAMJZ9oK4LaE
         0ssfEHM4uubiQIZWoZ0c5S31Le9kuSVpSjJFrcYQDUAa8tF9oVdkSEMvW9oV2Ta9WFc3
         74EKBGaQ3WmQRZh2gQmiU1d5ngKLjzxwtewo935YIBBEBGdkYyg9XiiywtqZcw0VfsTw
         4PjsRrh7boonxpHF+7H0M34C8WwQJpDY8jmM5y4BghO9NkoZrVCvAkOyP9Hr+YLLA0bq
         B0ing2FjUYh7TxIjnxqySwlNzE6CvTUrUGitvN6ADWDfu9941M3G9xivLPMIi6Cni/57
         N2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755404509; x=1756009309;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Gxto2WYWn+qE0Oz+kHca1dPDn9IuzFGHvmwvCJpza4=;
        b=vs6rqMk+nM10VQn/S2CMV1wKJ2h9+ZxZsbpxFbRozeTZgdThuMt0pBIkm2fx+D2CkT
         r2pw3ooiuC8F/5hK/NCseYPcIb7+YTAO69sAUqtiEMI0QmXA6PQj+qsFpMDwBU7GDXU1
         +gEPh3fQgb3bC64tjAyF/TzD/FDmzU4XKgGpaz1gweSvhl/m0wohobwke/H79395e2aQ
         VbEjBIvKrqK3xUhe5g5WvlD5jgPNftiiGbSlbERlHL7QAC9hhZK7s+CVnJjBwzWbai+e
         xcXMTxgqNfY/P6/j3FeHZY1bm9KTlSu8Rp1UiOZ1frTCcxKBrICdLDBwZc+0aQnI4OJr
         qPsg==
X-Forwarded-Encrypted: i=1; AJvYcCU7wluQg66RMgTXSYEyfnlNDcmvp2TtiROqTJd6fvCAZzfocyvt/chlLC5Kbeam0lhLlvLh9m0a4Ey3zH4=@vger.kernel.org, AJvYcCWkDudd/8EVThPST+m78LuTcwYhkgor8XY/wsz02K1MjJNIMrjocv70VktHWTnU1C8xm9EVCylkBWQ2rCPrMZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWqLua3EiYnglo1Z6E5bT3HOu5lNjF8GIjjE6sg5IHqDEM65G
	QNNguTeWMDrQYyc0Zfy9qTh2VZSkaGZBxcIqVaS8kfXmPBEmW5m8e0/y
X-Gm-Gg: ASbGncsrjRU25e+elV4X3iXsVYvkUbiIHIRfd7pW/J4tCUjiXcqoAf9Bu4jowHSgWIY
	ZUKbpzoGk/gxQNdJG5m+g5VdscNFnhL89Zr2JDBmMS6DdtBJVf/gNAYJR28DCF+8VU76wvyR+3K
	33ZqhKy0+20XvfsgEq8BLW5Pw91UrfpvFj6P7RTfvDpAb6Ku2KTXlHiZaWIpvwQX6LOb2vrJNe0
	dEzwBu6OHWL7hqfZQtnKQDrPOLBWLp7LH3qCL8mx9myiH5U+52u0I0oWSZ6S8Sbbj3AG0xQodHn
	fnqgGYPfDZpTiiVeGhLKJvB3p9QJx0ApJWCwrlR+0zm4gGnQpYDqokkQGzuG0QNDGOqNvTtH4V4
	hvZ+avV+F44CZfeM3/aVhIYkWK+n1hoDUsNVjNKzui9eWCgZdU4+BImqu8mPWmdNPlXmcy3LOzQ
	8g
X-Google-Smtp-Source: AGHT+IFpatqWNmxauQhAp6IXMfZroqzUBzaD9YiyJf1TijKcAJEW8VqrT/Ui7PsnRLmXt4H1MX6yMQ==
X-Received: by 2002:a05:6a20:6a05:b0:23f:fd87:424b with SMTP id adf61e73a8af0-240d301bf14mr10963475637.44.1755404509034;
        Sat, 16 Aug 2025 21:21:49 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e455bd252sm4227572b3a.113.2025.08.16.21.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 21:21:48 -0700 (PDT)
Date: Sun, 17 Aug 2025 13:21:33 +0900 (JST)
Message-Id: <20250817.132133.2247398178715604981.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 dakr@kernel.org, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, acourbot@nvidia.com,
 daniel.almeida@collabora.com, me@kloenk.dev
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250814.151147.29094382820492173.fujita.tomonori@gmail.com>
References: <20250811041039.3231548-3-fujita.tomonori@gmail.com>
	<aJm9A_D-zlJtbV6X@google.com>
	<20250814.151147.29094382820492173.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 15:11:47 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

>>> +#[track_caller]
>>> +pub fn read_poll_timeout<Op, Cond, T>(
>>> +    mut op: Op,
>>> +    mut cond: Cond,
>>> +    sleep_delta: Delta,
>>> +    timeout_delta: Option<Delta>,
>>> +) -> Result<T>
>>> +where
>>> +    Op: FnMut() -> Result<T>,
>>> +    Cond: FnMut(&T) -> bool,
>> 
>> I would consider just writing this as:
>>
>> pub fn read_poll_timeout<T>(
>>     mut op: impl FnMut() -> Result<T>,
>>     mut cond: impl FnMut(&T) -> bool,
>>     sleep_delta: Delta,
>>     timeout_delta: Option<Delta>,
>> ) -> Result<T>
> 
> Surely, I'll do.

The above change caused the example code to fail to compile with a
"type annotations needed" error, so I kept the original code.


>> And I would also consider adding a new error type called TimeoutError
>> similar to BadFdError in `rust/kernel/fs/file.rs`. That way, we promise
>> to the caller that we never return error codes other than a timeout.
> 
> Understood, I'll.

I was reminded that this function can return errors other than
timeout; Op closure returns an any error like register read failure.


