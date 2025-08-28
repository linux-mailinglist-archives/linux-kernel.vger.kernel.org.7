Return-Path: <linux-kernel+bounces-790164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBEEB3A13D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF111C855EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC331AF3C;
	Thu, 28 Aug 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="roYKi6Qb"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8031AF13
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756390401; cv=none; b=Re1I877WFfR3VmvW/Dsp3iBinBY1ndpxiul9mZJTrobwKnh/a6e3+kjYrkT4eb9QDPLEOSGNpw8An0aow2iC8E2ZcvkTeaKABmgIxWuuaIv2QUxKYwzaqQEtuThEvuSTDdwra6XSDaWXdlBgBezMYWJOpgFLlwQSUMx1/FCTSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756390401; c=relaxed/simple;
	bh=zayl1zXbeJnLkEP/+CPW37EsjXRGOUnCodGUWFw2rmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT+Kg9196NHLIjmBS5889rJi0xWqlUG86PhOq/4Tm/ng19SXzDBb/yIUJ4+c5O5OpaxyIpZ9A8FASubk1BUgi4NK1yfNIcCIHyqneHWSDafctNOKO6anwDbKh6/k/xUKX4fE7ovQN6q09eyNowyUPw3K3gES+WvQe8Li8kgPWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=roYKi6Qb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-248e07d2a0eso96035ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756390400; x=1756995200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOBy//lE4jaRCcu6vDfY/P6bkD5/OIBvUSQt0XTkAkg=;
        b=roYKi6QbJcdPcmROQTAGb4V5eYWsflyelV57Iyeob84UNhOPUGbW/Cl4f6R9/QRSwN
         mWobcDbDdAbi8IgKNJv1nrPUyLSGeW8prbiDc6ZbonrGierNTZZ8HUc3nsm2A0UEa0NO
         GvzvHJVbOk2ixhBzWRht1ygFvRl4pzMH7MLhK9342gyczzZpSJtK2ICqwKP7cE8MyDwz
         lcN+meZEeR5wML0VAKsfk55xMDWWV5oGYzTPTtGTtNQjDFSTIL7mzd4QCDCKw5fHsW44
         QWjpBNZPQtnbOVzyTEZJr0e9Uq/r+K33WbD75OnsFm5KOVEt2f8Ixk6Lst2YjOJv9PKu
         11/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756390400; x=1756995200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOBy//lE4jaRCcu6vDfY/P6bkD5/OIBvUSQt0XTkAkg=;
        b=Ojo+nnL7wwq1tA3PMl69FD4DO9So15qLw8IMchTIgbUEwa6AFBZYMgc5ezjhM/JC3c
         a2ZN0iI+NYM8Bp6I8bSCwc3FxCPnqsp98F7MNfPOwlwFMMPGANfcfH8YteXQwYvKcdJ5
         5pnb7P6ZCXtDVmYHJBLGGZ50bBdoA2O/qVHL6TqPXCSQaRslKutNCYqjZ1lX/F4kWPVD
         lfmdXTQA5Q3KBZ9RZ3P2+YZIMeHIvCOJrJfN0LrqtroDseaPXzWReKPGyWMR74JQp0og
         /UD6MWG+tk1WC5Y5Qx8VN9HghYR5QZ7U/LaGZd+l+zRdx30GKZAJMegIEI4gPjZ0L2VN
         8aEw==
X-Forwarded-Encrypted: i=1; AJvYcCWAe/q6l8Rvlv61a3F+VxYT1idol0UiPE4K2PLIoS7e0c40MIqxWAXsuJtUMxkdkXz1OVvfyp9ZFaWk4Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNcqTQuy+BxEJK72hprBDAkBLKr+/lJNNj7nB49qlo4EyhsmwY
	9IK252I5+kssGrZPi9xRHFXi8R7qShucfNXa3wuqMiB8bJDG4P6ljdZDu3EYqyXf9A==
X-Gm-Gg: ASbGncv7RVZ3S9hfcIwjdPIUW1oevuY9EZHQzlA/joysKGbW3/TfBon9yJ5nApHBN3U
	ZSC2wbx4iXCWZphHFvQut1dLnj7cmctRSRFIVBWMSj5Gk+wz6TgrtsKiiN0Qi4MiAgdeEXgqkaM
	rv0nnldH9o3jj0/JOqWuzvtDF8F6ZV1Xeekr8Psz88DIY4l7WPz9tA6qeP0xQbIY3OPa92m570M
	O7hXk5oRbwLhluvTyRFA1RRTFORkRxq5Gs0QSXr8HEHTJKEpX1l3KWYRbYrEKuSMODU1NM77E0o
	zyeRD1blXRYu5HpWZhoFmPoYiDT99h0+MBjlQfWv9dqMK/f3czc9bk7eJDqBGRd4lpZgnRq6xb6
	hvrTfYzgst8LS1H655RxA2/i8XmGroAwwcCN764ZuyddwrP6+QQUkaklXMcJi72ct9v7/ATDM
X-Google-Smtp-Source: AGHT+IEGpiNlcAAPPrz9en6KInijXkRAY7kZe+iB99bFlXYKh+mUpBkPrgcD/Y32o+kDxyb7gRU9rQ==
X-Received: by 2002:a17:902:ce91:b0:248:f76d:2c67 with SMTP id d9443c01a7336-248f76d3d84mr569375ad.4.1756390399061;
        Thu, 28 Aug 2025 07:13:19 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7705708b42fsm13251491b3a.80.2025.08.28.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 07:13:18 -0700 (PDT)
Date: Thu, 28 Aug 2025 14:13:13 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	"open list:MEMORY MAPPING" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/mremap: fix regression in vrm->new_addr check
Message-ID: <aLBj-UanVYBax9aE@google.com>
References: <20250828032653.521314-1-cmllamas@google.com>
 <8a4dc910-5237-48aa-8abb-a6d5044bc290@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4dc910-5237-48aa-8abb-a6d5044bc290@lucifer.local>

On Thu, Aug 28, 2025 at 06:38:09AM +0100, Lorenzo Stoakes wrote:
> I'm curious why only you guys have seen it, a theory is bionic is sending random
> stuff to this parameter when unspecified, and glibc is not.

I honestly don't know and it could very well be only with bionic or
clang. I'll try to find out more about this, maybe glibc implementation
zeros out the 'new_addres' register and bionic doesn't.

> 
> But obviously this fix is correct, and the original code needs fixing.
> 
> Please respin a v2 as per above.

Sounds good.

