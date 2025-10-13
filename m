Return-Path: <linux-kernel+bounces-851304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0CDBD6124
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B3A18A772E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2449F2E8B71;
	Mon, 13 Oct 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4ThKFa1"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7262E7BC3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387135; cv=none; b=QTpym9eMzJVrQMmCPEKGe2VKnaDll7Sto3sjDJKCK/iwhtKenqU1JpWZOkcAc6dRbpScfPnpAy2xYsRvcM9ExtK8y/k12ZhQBkYfr/svmxPFy2UlBX40kSE1V8Rnc4hVNAa6qSdFYY3MLjdksDl6XXvUVlmzFQEz/VCQOXy2X14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387135; c=relaxed/simple;
	bh=RgDFfsGyDh2D5MZcZfHuN8rC9xBKfq7IaWMUdV3rWwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdu/UBCAZygjzgx9K+B7jWXf5ivjlUe8UCCM73dKnZ5B/WPpuxQLEE0enyczQ5DrxwT09OUcQe0Q3qBjmTPUhJoRXcSHcLUg1BiG601JlCVCVf66YkPEuxU9yYR1FsFgYnlZRDy6TbjIV7w72Vk3PaNWuJbSLuCwuFk34nTZktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4ThKFa1; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b631b435d59so2918136a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760387133; x=1760991933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvmwG/OTTSp/sDxZm7NpYcSINRgarbkV9m7iJQxM6OY=;
        b=m4ThKFa178ZD43gEOWyENkw4qSYJpqkmjKOxhrE5UosOlUXYGzdxDOz3+uXRPk2SCN
         EfjgP8nBoMUsWxqu+3FhqV/i1StwzuijdOlPwssozlzLYNijfRWb8vhy3ijMMcHwNNoQ
         xO5L/3EZQFHnPaIKHw9fdjU77a6LBL4zu1/zBsDK+5g77gjGi4Rj8zhUfj/YcCD6HQVS
         2R6tWxxTtDPfezObH3Dawb4AaAQ109tjiSvgJH7XvGRt3lsx2jgO2ieXN6wNGPU+CTWg
         9BveKlm3CXD+/6CGhWysse2QX//rtrVNTMQK1e6nMSfF7tnNbDE1LtU/FdI1rBPBLokx
         vH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387133; x=1760991933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvmwG/OTTSp/sDxZm7NpYcSINRgarbkV9m7iJQxM6OY=;
        b=c/lQ/zIL23xS35y7oUhh5+2wTmp9ABLogO8QpLP83F+VosWDrq1HiYH17NMN99mnyS
         doDCUFeQ26PRekeojqjiDXFNsnQWFjiHYD1uRWoiNLqgcWDghKNjwrFIYKk/+ftqoeJP
         CdVkUl43vowBtLBmpoiwkt6touUL8vfRBbP4g/NTZqaUC7nxKCoZMBB4Tr8PNsl+ciT1
         gp0NOOovD//uVd0tsPLsrjxr7dmF/jCp36a9JcdbtRjj9EUHL0ur+Hl9LE+wKot8NAlR
         y/ZktucZHgUr/lllQu8eQCedv6keL2pKrqLHJ4JphUJ8FYSNnMej4FXXWjhNv5sSfg/d
         YMPg==
X-Forwarded-Encrypted: i=1; AJvYcCVhHN7GVIomGGjgkI+yB8iDnaheaoOM871vpvCKQJj0+DCKqVYlsSv65aGm34S0fy0aAwo3HaiD7pw5JnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxav6tOaoTPzy5IknG9XyEH9wfzMzAmO+zarZYpUtw6ndeRfyqA
	Xq+v31OMwIlBXZwA/HuH0RwP/uuPHUgD0MZFq3W72E9pbll8Fnhvd3mzxe1UJQ==
X-Gm-Gg: ASbGncuNw7FNxsjzsEHitRz+WKOrkxGipfFvzxBHk5i5+elvyQk2TP4cCZoy8lJSoJR
	aINRkP8T/oUa90zHYhdE+/DPY9gcDqn1yGe0rzrVfQ7fi8dOjLFGSd1ciHbvnjiHkcmof8cmgVF
	wwcbd0nj51qImnR28fP9Ge4c2+GNK8k5GtUpisBmjPE6CFcw4Rl9JIKMgly5an7BHLv/aToCOT8
	7y+kYhmzYRPgQ9s0dQLKY+dtHH0E2zUstbJDlvaL4tJYeGUeftM20K5vHrdQINOKfD3Ji/AjlWr
	XX9oz6PJIZzdYgMSfHMPb6k2uK5/xGiMFI2ypVazUuf8ni8TqQw6U7EV5/UuPBebr1x75ABN7DE
	cZ935lHKJhIOgYGKMfqlyOMMQeRlWJU+E+9XwIoPiCbGl6Dw1fLMg/VtgzxMruvPp6/kdOv8lmE
	nu3rU9qi2LUwlNZQ==
X-Google-Smtp-Source: AGHT+IHAJQJ2TBajBhJIXbDbxqDBZKtz7JTXJySkvaBi6lA42nmISYhfTKtZHx4S7eLGHCkr2tWSgw==
X-Received: by 2002:a17:903:2acb:b0:268:1034:ac8b with SMTP id d9443c01a7336-2902739ad00mr311295215ad.26.1760387133317;
        Mon, 13 Oct 2025 13:25:33 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f941a5sm141937435ad.127.2025.10.13.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:25:32 -0700 (PDT)
Date: Tue, 14 Oct 2025 04:25:29 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Ankan Biswas <spyjetfayed@gmail.com>,
	Lasse Collin <lasse.collin@tukaani.org>
Cc: lasse.collin@tukaani.org, skhan@linuxfoundation.org, khalid@kernel.org,
	david.hunter.linux@gmail.com, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] lib/xz: remove dead IA-64 (Itanium) support code
Message-ID: <aO1gOckA14Ed/26F@visitorckw-System-Product-Name>
References: <20251013173446.8692-1-spyjetfayed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013173446.8692-1-spyjetfayed@gmail.com>

On Mon, Oct 13, 2025 at 11:01:58PM +0530, Ankan Biswas wrote:
> Support for the IA-64 (Itanium) architecture was removed in
> commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture").
> 
> This patch drops the IA-64 specific decompression code from
> lib/xz, which was conditionally compiled with the now-obsolete
> CONFIG_XZ_DEC_IA64 option.
> 
> Note that the upstream version of xz_dec_bcj.c still retains support
> for the IA-64 BCJ filter.

Not sure if it's necessary to mention this, but I guess it's fine.

> 
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
> Acked-by: Lasse Collin <lasse.collin@tukaani.org>
> ---

I'm not quite sure what you changed in v2 compared to v1.
Usually, you should describe the changes below the --- line [1].

[1]: https://www.kernel.org/doc/html/v6.17/process/submitting-patches.html#commentary

However, the change itself LGTM, so FWIW:

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Lasse,
Since this change is located under lib/, I assume it will be routed
through Andrew's tree?
If that's the case, then perhaps we should also Cc Andrew.

Regards,
Kuan-Wei

