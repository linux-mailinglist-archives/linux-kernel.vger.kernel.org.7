Return-Path: <linux-kernel+bounces-736165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9813AB0999C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297851C46BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F23A191F91;
	Fri, 18 Jul 2025 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Rs9kYsUN"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C852AD2C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804322; cv=none; b=c8y/RUheCxzB9KyTK8VFYDJsufIEIERvf3TQwqWkAW0JUxahagYqNJRThkp2xcPEpJysGEOqG5XtFWQkcRnfWea/rhLL7NEm2t62N8V7elD1Y2dO64Xpr4XLZ+qY38+rGPHSGpWULbdQ208eECRkJIE4Ya/hI9vcRd3k95j0j0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804322; c=relaxed/simple;
	bh=ThI2SA+JEvfYYv5JDIfyP/Z92vuGSJXf0oXPQ6DEzgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeWqAFtKKJfozDqPCjgGPd3RRCa3bGY2fBCgbdzM/81TVJREIfrG+Ig5jlQKyQbCmCKAbPJss2Oy4UFAFZUEEspNAsxwJ5vmU7F1bF2qYnz8na7MR5k5D6ncsBlcxJ6GVsuehyKJ+HLoTh4Jpbnu8RnBpimSpm7+bRqUgkSIcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Rs9kYsUN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7de159778d4so160728585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752804320; x=1753409120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5x0XEc7pLjwccUs7RFbKEJ5lUgubH/LcKbmN/goeM7M=;
        b=Rs9kYsUN84xMVTIm9ZR19sTDAh1SAuOceW6HeqsZXXHl96LF3AVsdBtnzbBj6tZ9go
         wOLfgQi70ZkeYp4zUwuQWdG4SlSWPSIbFYK60V/PlDytKY26K3AxrHkTQ11wvDyxo9FE
         d2uZdAsK0WTIXK2s8n/Er27S2varEdZnNeCdDneQAxVV5Ovsq3dpOEJhF9sHz8qnaL5/
         DXLGJgUm0M9o0lEZl8wY2shKDJMp3P/BYpOlxwN7V3QffynrtnKxi4vdTeb+U/c4c97t
         kXNdHtzs6EpnUHgi3WNB9jbWfZcwJ9wg3EZFiqNYOzxjotjL5+PK6zEGwRW00ckKaF1J
         Q60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752804320; x=1753409120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x0XEc7pLjwccUs7RFbKEJ5lUgubH/LcKbmN/goeM7M=;
        b=Ru6KhnySC4kzNpHma6mtViqhIoi/7i22eokM4u/OfjgJE5ghHJXXr5I4yiaxK2ZH0s
         /Fvw45K2WfMwVDu/Rppazi6UbaiduXwC+lG3kfr+056Kel4H0i90KHnN60L1dl1aRYgn
         vYZ7sQLRtb8qK+dTTEFOWJzD8nKmtLmsiqd7/AmepFYCrxuXH6QEGYgi6xEBT7ORzXGS
         Qcdb8/oaJRyRpfHyqjjg3i+9iJNcD+JeScgzlXN5bsEGnA07KqWh4yfoNP6WobZWlJ1Q
         vhi+kA58YEpCzq9DD1ze8HDGAce6179rMVcXlo95rnCqZBq5tBSRkD18dRMqTNTQImxK
         Ssdw==
X-Forwarded-Encrypted: i=1; AJvYcCVtJCf4nFSbM3Fb1S4NdZ1K0sjTQ4xOn/26bvYC00JWL1HHZHfow67dx1VeXY11dEf9gKaI5Qb2RdFzgF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/vVv3thYVWLNAfyhRXPZjU5jrf2wmRU87VEZYd6tRBOjCY+zG
	hKyfAKASds7NxMR+6Pkz+DHRzvBGPw7mvKGd8YU1MbqjjS9z3cTj4+w7GmquvxtZiw==
X-Gm-Gg: ASbGncuF13QWPkMzX5uYlklLmyb2LnosfVLDMZqBGL8YeACFfniLrNryqg0cTHubKJR
	qyUQ1KCDSkF5XD6OwgkXwqW1OFaOUxbb80kB+TRhj2CnejQi8Kx3ye7v0RpY6y5kAG3oz2RUMaY
	b9ythV5mcp58zaUBCn7kL8wmd9qNbm2YtLhfTmZrNiq7YXG7kpDr9mhKM2yK91cLqHFiV+P8LQR
	MJJm6KPjLmPIK1FmA11HAJ5h0mqxHsblbXpCtawwIFl/eSvorikwLvcE1KDjWTiQWJWPxlh+QW3
	ske+zlXBVWb7L4cignstnxeVb5+/Y1wENfCjIOBe3hq7eAAfO8QfglmDeyjukxcigS7Oi7YUzAj
	rE91/6f+tmEuANyK5dOUHz3g=
X-Google-Smtp-Source: AGHT+IGDh8kLiMeJVZIghilfI+mnkOzwJGM1+ThRATKXUPfBLbFj1g8K9F0OjpA+XNWAurpuMrI34g==
X-Received: by 2002:a05:620a:7086:b0:7e0:9eee:a20 with SMTP id af79cd13be357-7e34361471cmr1285097885a.42.1752804320078;
        Thu, 17 Jul 2025 19:05:20 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::317e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356cb6007sm32734885a.105.2025.07.17.19.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 19:05:19 -0700 (PDT)
Date: Thu, 17 Jul 2025 22:05:16 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: cen zhang <zzzccc427@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	zhenghaoran154@gmail.com, r33s3n6@gmail.com,
	linux-usb@vger.kernel.org, gality365@gmail.com
Subject: Re: [BUG] KASAN: slab-use-after-free Read in xhci_hub_control
Message-ID: <8033fcb7-e97d-4b6d-a3fb-a9a49f8b69f2@rowland.harvard.edu>
References: <CAFRLqsUZTDm0KAfX_qziTrn6E3+sRksF5ormxhHConqTKWvHBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFRLqsUZTDm0KAfX_qziTrn6E3+sRksF5ormxhHConqTKWvHBQ@mail.gmail.com>

On Thu, Jul 17, 2025 at 08:24:17PM +0800, cen zhang wrote:
> Hi maintainers,
> 
> I've encountered a kernel crash in the xhci driver, which was found by
> Syzkaller on kernel version 6.16.0-rc6 (commit 155a3c003e55).
> 
> The KASAN report points to a slab-use-after-free read within
> xhci_hub_control. What we find puzzling is that the free operation
> occurred in a completely different module, as indicated by the free
> stack trace.
> 
> We suspect this might not be a false positive, but rather a complex
> bug whose root cause is not a simple UAF within the same driver. We've
> tried to trace how this could happen but are struggling to understand
> the connection.
> 
> Could you possibly offer your expertise and help us understand if this
> is a known issue or a new bug? Any insight you could provide would be
> immensely helpful.

My initial guess is that you're experiencing pointer corruption.  Such
bugs are notoriously difficult to locate and pin down.

Alan Stern

