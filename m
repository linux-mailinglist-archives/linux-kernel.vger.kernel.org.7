Return-Path: <linux-kernel+bounces-862149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCF2BF4893
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AF2A3525B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690EA1FC7C5;
	Tue, 21 Oct 2025 03:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MMROzRBj"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B729405
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018322; cv=none; b=KNKeOm/EFfFYWMHbgJBRurAHaJcP3OsQiUChFiG//ZC4KQsrWE0SNk9eYddwxEs+pfenf8f3SLa8/jlje0KatsguxrT7QaogY07RqV7UMUfBtMAXxVCEXj0Ke/ckAIdChz5kcPOpH8Yh0cXRUzSgzZ0x0x5dddtecwT0awShZzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018322; c=relaxed/simple;
	bh=VutfssI6qKCEbMppqaBHbdfMNvGVt8B87THwkbQ3q38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n17LegU1KHCi79Yr4uF0cWSZpSpwE5X0q/TrayiqxA99oBEhfhf9SXhkL/AoHHPqhTPapTTwvh+4BLs1TV9Lh6LKRWUUoloYOgRq3zXkChImndomD0aoDoBbhvIfQ/tiZqYxinswNAhHAMA9odzwxnSqqtLWwI+4/0biVq/jOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MMROzRBj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so4986679a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761018321; x=1761623121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJf//7sAC/ag3LwWhj798Mg6XcoigCVTC6AC6dv9wJ4=;
        b=MMROzRBjsMFBUXyn8gzen5jH2kc0A670KM5Am+ALzYXjCxmgy3FLtdkY3bRpUi46/7
         SANFIoVDTAUIdHg9D9wcgjNbTiRsjwOGaSuxyJvqtHxLAG+0bACy65gL+6BGhmzqIr31
         M95wHnyBBtOpyZG/LY1dOZ7Mo2keNUm1E/0yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018321; x=1761623121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJf//7sAC/ag3LwWhj798Mg6XcoigCVTC6AC6dv9wJ4=;
        b=On5G0mbSQyNuEoJnNEHfN/jM0g7fSERLCg90E03a5JYCVfYetdvV434f087qSmPJUe
         xey1cGIRlxjlMj5BkahXnHKvwfJikpUjKaOqVptTXFVtrcf6CYQBCuh5PHPGi7mC91NS
         oBFNC3IttQW/46AMQy+92FMsFNiR3w8OX34nvinpXhuoVRNnbMBImDqfbgc2FfiLlWjW
         6aRsQ0QuJxnr6fbByP55YQnkCgKIfztIuEZPW2BBvxTQdONUL56ywcRaFun0MlI3l7hT
         3JxtziUFpFU9oCAnCoMi98lL6Pq9YI3pjum009M/cBSu1W6rNdvX2IJZ0ie/KevB9xjW
         I+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCW1XPD27uS8M8+NeDPq3IGKfY76XWcDUgHNY+gK+/BiSInu+uMMKXPhXkuvgfuV3uMqg7QowC+B7ckm2XY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgj09NjVVyFgQr16H9/wOXbnlv1FuJOv0p1xPXiSZNfH/tiLCi
	lOohQ8WVs5Ee2yemjMKIkRGKWdhMsJHyTnYhl7MM9SzaKupkD3gLTy3AwG6TPpOQ2Q==
X-Gm-Gg: ASbGncvXKDV3rxksoZ0ynQ9BJW3AYHVQWTwmA2MsS65WxpKsp+GcpmNxgg4Za3zdJWJ
	oa8mAWhq81VxUkKU41bzjja3EgY0j4JvsFCROAtaX7xSuGSD1w6huX0DENEGpxuevtlFiHAae2p
	GDxoVh1T7EBowJIuhN4n9OqrR20JK8UwFmO2Vzsonis73JastAaZvhdJAe+iF6nATuCFfsJIAF5
	/HWu0+L71lh9DQxB180qlKBsLjGK57j/1UbioP/svDj1S4ppoB2Uo1gHKnzsExgEyeNMKJ4y5PM
	RBQNWp5WtfvzZAnjmtun/p/gn26l04ZRqCZvx7hs6DekoFI1ypSPvCPrZiQiRsK95MQl3OyZWYX
	uK23ht8k4fb9THbWuEU282q3F7e0I5Hh72ec05aAhmBXTBH1nhtzqKN0TLobDkIJLtnbqwZmG+y
	btqYc=
X-Google-Smtp-Source: AGHT+IEcVfie/cU9hK86hVQEDzdIqKsmMm8fLZZ/416YCVXxsDETHB3xmUafin3LJdnPj3e+3Wmi4A==
X-Received: by 2002:a17:90b:5868:b0:32d:fd14:600b with SMTP id 98e67ed59e1d1-33b9e0a4a30mr27344576a91.7.1761018320802;
        Mon, 20 Oct 2025 20:45:20 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3364:b517:9129:5413])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de11392sm9688130a91.7.2025.10.20.20.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:45:20 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:45:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, 
	Doug Smythies <dsmythies@telus.net>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
Message-ID: <ndxgcsseqab4fqxemwscykintho6t2pjjqg6nkihcqlp5aesc5@7a6kxqjcfdxq>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki>
 <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
 <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
 <28ecb23b-ecee-409a-9771-24f801081d07@arm.com>
 <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com>
 <001801dc4041$607c19f0$21744dd0$@telus.net>
 <8ccf53bd-81cc-4c7b-88b5-5d7aeebf2c3f@arm.com>
 <CAJZ5v0ijNkUQdTGRUHRUQKKeEzCR354CGkf-L2oUsG51bnU5oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ijNkUQdTGRUHRUQKKeEzCR354CGkf-L2oUsG51bnU5oA@mail.gmail.com>

On (25/10/20 15:18), Rafael J. Wysocki wrote:
> While it would be kind of interesting to know the test details, I
> don't think that this is just one test.
> 
> Sergey mentioned several different symptoms in his initial message:
> 
> https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/
> 
> which kind of indicates several different tests regressing, so this
> appears to be a whole-platform issue.

Correct, different test scenarios:

GoogleDocs, VideoPlayback, VideoCall, and perhaps some others.

