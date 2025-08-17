Return-Path: <linux-kernel+bounces-772476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB83EB29329
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B191B1B2393D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300862417D1;
	Sun, 17 Aug 2025 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ5sA4aV"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD170813
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755436051; cv=none; b=HOvRZS4nOals/vgIPCfssuZ26kBSes9HP+8DnIUgXR4/NAE+v3+9iJ2d9ldD+o7til1/72DgTajBmNARmjDJYLFUXWusbhnn33aXqnRad+d13WheTM0ZsJT8NBDNh8jaVJZjY0QPqLg7XljwzHXlXAwxNkLtXlT0EJZ1mAyCVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755436051; c=relaxed/simple;
	bh=gRneoTvNyu6qjLU/FcmoWhlj6NGIOkmQ9/GH3ESHK6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLtHsqCZ/UBBV+LPKxndBOVnjsbJFCeQJ/ewaQ4/t4CZCo7MwCe5la3fitCZGWqpPdxrQJn4P5CMhhuZRwXMVvCqsDtOOYTD+Yj3wSEkBYX4R6Cds+X8eJH61MdQ4mNjmC+3uycsqPHw91uAC4zEHykVbm/I9DWK4zM3kwFrTDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ5sA4aV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso13752555e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755436048; x=1756040848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tj2CNLjG6ieMRrs10eRJIch0UtH21N+OnmhFiHvpGKc=;
        b=QJ5sA4aVgL4qJBLWapHAI+gLndFEhKa1seuIWJqKdvcrdjv2ymQRdTO9l4SrUvxdHo
         hjqFvDoN3LWx51aQMrXOhLqDkGq73oFEqDIuPvA4CgWm3tPHax+wvvJM6y8E6/YgPUWB
         z7KAhJrxd129GgoHQjRXhPeoBIzVT+UQt++4v8VvEZ6KTE+xp7cqIQC1WSAer8HOCy8F
         QVcCsDWh/Y9D+qlmVw1n59kgFmMRddsHpqu5QgKhi0R+znEOI2YJXe5ohlsHMjZWZ3gY
         aIwWkhdPBaQDCG8Obo5E6KHHHtAsX51Ww/Cg0PMmOj/YURT7DJ3t8MLQfC1EBAhILwaK
         lNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755436048; x=1756040848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tj2CNLjG6ieMRrs10eRJIch0UtH21N+OnmhFiHvpGKc=;
        b=hDbTMoNA3VYl45WwKAM35+3DbUerTDAsqZltd9aH6pMn0EBIJmkNAEbGWA36uHVRt5
         +z01+z+GuTYdzOVXWJaw3hL9VLxfQw+3qIYktqLggBkBwn5+zugTkp7aDj/NoK2PCUGH
         ZhRdrO+HoA1OSK/Wns0K1ZO4BJYkDhJs5dnuSYricJImRSYwtes/+pjdsaeRcJkr/x4l
         4B09JnVVhxC78jGmOzHK2OMuqfwrRCuzUeOnUTq7yPizIYmqygkrFPuojSJBDLsCu6HQ
         Z4C/YXEXnVypH9DC3xBiZNQh6GRK3bipHf+aU85EikfSUO2YmMGdhzY93332qFC/NT2J
         c8kA==
X-Forwarded-Encrypted: i=1; AJvYcCU6L4g9xveJ6vAwbOeuymaV2d09cyoz137WDjr4+NkyzvrdHy5oi8G/5EjgZyTcWjy1Avt1USdGNaesOg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxehUSd7e54m3Y42flNr7I316+GudxZQRz09iiYwrpdNZZ4hL8B
	P9qhgPLrBEQliJQNw4f9NbY/NJpAYh2EpThCe/zCFNSWlKR29gruJ77d
X-Gm-Gg: ASbGncsVoat9ZMWlngalrKZoYE4Z/5LWDrYlZxffOnxDN6bDrc9/omYPMjKqIX7z2mA
	pDvzt1BBZz2oyYtkzsjby+ClrhTqng/6AnP7mGGqRrmKDko5ifc/FHcvEZch50HM29ohhSOZjrZ
	wk0Tl7CwD5OR3fIjLmtM24wdpj8opK7kEpKeY1goXqDLxey6ipuP0Imq1U+JgZbTkspXGQr109i
	TgqAla1KncPLvPXJg/+U8p1L36hzmFNGxDzW+SoJob2maPzLLjK03ZfPqBpyoDbWsdnU2iR+rOK
	UndS9rMIuOVb/yVu/w6k3tjvZtPLgndbr35AYrNj7z5AbJaR0b/lhLcQWQ5fkWpla/+Wh4m8e7E
	geS3PgmQsBuZ6IH64zcj8fTAz+BK2vkaN/Jg3SKIEtVjI8zRtOddbd1xMLQpa
X-Google-Smtp-Source: AGHT+IHHCXwk44x4A8v7+CeP8qQFFMu7yk/YoiBBytGSjts2us9DbEaZAe8SBI3zXj0yIYxcV2LSKA==
X-Received: by 2002:a05:600c:4586:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-45a218399fdmr65195725e9.21.1755436047827;
        Sun, 17 Aug 2025 06:07:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c749143sm136473595e9.16.2025.08.17.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 06:07:27 -0700 (PDT)
Date: Sun, 17 Aug 2025 14:07:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, Yu Kuai
 <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe
 <axboe@kernel.dk>, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 0/2] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250817140726.223f8f72@pumpkin>
In-Reply-To: <20250815164009.GA11676@redhat.com>
References: <20250815164009.GA11676@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 18:40:09 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

One of my 'idea patches' is to make mul_u64_u64_div_u64() a wrapper for
another function that takes in extra 'int *overflowed' parameter that is
set zero/non-zero for success/overflow.
The 'overflowed' parameter can either be a compile-time NULL or a
valid pointer.

So the x86-x64 asm implementation would use different code - you need
the 'jump around fail label' to write the ~0 return value to *overflowed.
The extra pointer check in the C version normal path may not be worth
worrying about (but the '*overflow = 0' could easily be inlined).

The typical use would be:
	quotient = mul_u64_u64_div_u64_overflow(..., &overflowed);
	if (quotient == ~0ull && overflowed)
		...
That will generate better code than returning 'overflowed' and the
quotient by reference.

Although I wonder how often ~0ull is a valid result?

	David

