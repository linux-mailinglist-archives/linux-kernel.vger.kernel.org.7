Return-Path: <linux-kernel+bounces-767993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E89B25BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92BF622370
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252AE23957D;
	Thu, 14 Aug 2025 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmkEgTJc"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1922248BE;
	Thu, 14 Aug 2025 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151947; cv=none; b=HyarW7RlQ0XprQyGokrAwKjKsA9beCi2fwxB99gYJr0YEl1tFaEjQx8/oW5g/0KkRNk3V0LutQJ6wQzZ02qLfHPGNg3DmCnStemEJUf7/VXTWImk0E7w7jDZc9/U+Mp24TezkNs92H3IzEFsLIFStiOsJ8oLvd6CM9yU46YTXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151947; c=relaxed/simple;
	bh=iGL79AcgKZ+3OCtFwhZSkEwokS/OW2q3vTKHlsWCCos=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WDfwzjOyIB8XbdQMly78MzOBpzbKJvbYZocNjfE4Up6I0k4lLVFpgt37ywoYXt2aZ1VlQXIeoc6cQru5lp1gwboMt+MB+GkxVB/xu7hArwpu8FhJw8vfCBfDWXQoyd/8mDIPxm/pbZ2FecPGMuyQmt52/aesv8Xy4XxvP8q0sr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmkEgTJc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47174b3429so319572a12.2;
        Wed, 13 Aug 2025 23:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755151945; x=1755756745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VH3Qz6pBSCYs9nFUWRiz7ia2R/3kDApTC8BTlenU+Ts=;
        b=UmkEgTJc4P7/qyxnVzvoL/7s/xdaCellNpw26wdfyhAexUpBU0KJSdpeIt5hNW/iAi
         QPUaA0nUlQrOJc8EBgsuBnbh0/Wn6qhaTuW/gLTQHHhSPOL+SN+bl18L2xJFYP7Mddf5
         SGPjn/qwe3xleCvkvyY605EU0Ua2hJ80T41MC99hqPCEZc0Q+OKI/kaIlHbHUv2zhral
         iJ/VvK2afGRRijl8lP+drjDxW9zyvqaF8S0ZIebo9zHtk0FNoKcAfRqufkA/lnL2lOwm
         s4qfdci8/vH/yR0lvejt+ATWumieZQe9cn/g2S4CpBLUgZkClQYQb9KoDWukQDf+HP0S
         Mbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755151945; x=1755756745;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VH3Qz6pBSCYs9nFUWRiz7ia2R/3kDApTC8BTlenU+Ts=;
        b=VsNhyemzTMc9O2vhN7AaTGfq1AT1PJ3lty5rA9bvjTre2RTewleBZLm+cPsnaNlNdD
         o2Gfs6qyc2Ayshshv9N1SuKQ3478TRtO0LD0FVifJ4W0nmdfqFH4V3lEb7c5v0XER/gT
         UUM+TxZF5hFTfIj/O12vGKxhIRjdurVynyriIMXRWuzl87vxG/CxPE0Kk0RlAEwgvv87
         ODAXYZgTVjMzU94qTptLeRdvaoiXoJchLPW8wDWCxBDjEVVRtzY9PIhmrpYADQIzNAP/
         qU9nCqS0ZZuWWKiJngAJJnbfXWORZQ7CbO6sz7yXd4XR+7m8pBGl1Z2kxB5WTqRe03pf
         R+hA==
X-Forwarded-Encrypted: i=1; AJvYcCUeRoCY6ofB9UY9ea/l2FrdZez4eyXyTKNTdzm+q3Lkj0n5MGlry4QqlWtuD5QQuhk0msU7E0w02968PaY=@vger.kernel.org, AJvYcCVJVq/JAwe8I+aJuNr0DGy5lFNzfU5VJdddVnuTZ4qBKWGXyfEYc0dybCPw2uVqqfy2oH9/0hihCRjB2shwfX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCH+wpMSEsY7JhS0gGiliJn7OtOlyyYbEoaUKj7Hi+NfQ0MrOT
	3/EfjrN6lri80VCDkDH/1cJxkqS/oE6Nt7OU4FZs9Aa2s6IOkBhJ6rPn
X-Gm-Gg: ASbGncsegQbkBkKATX19ursWJsydIGEjB+WNGuuY22ah+VlT0vfnB/qXqsrf3V9Pldu
	Kph7hlXJGaGbWhUV3SboMEfPL+vEULdSiwnDK5dX+MWj35OM0PwsV2wAxYqshOImmbMPe9tc5jf
	7en+lRBe+66bl7yjjG/T7tv+tSm0WEWLx67FP7OOfpMykh7zJIBc/YsYSy0u1CHEKNh4njv85Rq
	gQSA0U4bt28TlbIEAdqElIlt4G9g8Q0XWQRXd1W+xfx9NBeUtaV2k4uzXT4gaEb2CR7Rj6mDXME
	MGs05hFTxPlfYcxNYTifKrbslRZWN8IFyLqWyoaxwswLEoCnyu2i2nV70/Vd/IqDC0749MgcElD
	pRnFpYeBeZ4BbauT2YOs5xf6xFrZB3wKsRV6RxNgMO5QXRS4DmuLqfv3NoTJM7nwhVlFDL/l6MJ
	z/
X-Google-Smtp-Source: AGHT+IEnY851X2QozUOFgacXb/Ry/dJczS0e/iBR7e3DABSiXlltvYH+XMXqoSl1XibwCAQ9bJR+aQ==
X-Received: by 2002:a17:902:e841:b0:240:5bde:532d with SMTP id d9443c01a7336-244586c6674mr26375155ad.38.1755151945241;
        Wed, 13 Aug 2025 23:12:25 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f9274asm670165a91.2.2025.08.13.23.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:12:24 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:12:19 +0900 (JST)
Message-Id: <20250814.151219.1988266311964625112.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com
Subject: Re: [PATCH v1 1/2] rust: Add cpu_relax() helper
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aJm6WGaxITeIxtJc@google.com>
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
	<20250811041039.3231548-2-fujita.tomonori@gmail.com>
	<aJm6WGaxITeIxtJc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 09:39:36 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Mon, Aug 11, 2025 at 01:10:37PM +0900, FUJITA Tomonori wrote:
>> Add cpu_relax() helper in preparation for supporting
>> read_poll_timeout().
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
>> +pub fn cpu_relax() {
>> +    // SAFETY: Always safe to call.
>> +    unsafe { bindings::cpu_relax() }
>> +}
> 
> Let's mark this #[inline].

Thanks, I'll do in the next version.

