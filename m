Return-Path: <linux-kernel+bounces-772549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0F8B293FC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC55D3AD6FE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA029B777;
	Sun, 17 Aug 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmxUXaTr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F939FCE;
	Sun, 17 Aug 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446848; cv=none; b=SwJaNPKOkAcBFTm8FR6gmrw5uSVAT81l5UEYSD5YX5SnWhx1l7OIGzJkxMTemeEDeKI0V9ZVfwfyWRJFo2+l5KzOxS8JkBACGmsl3USKaqQX9yI8s60gz8rmaw5P1vnEZCOY7jWzRMPLffoY/13oCImq9d2W5xrW0U9imcjrAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446848; c=relaxed/simple;
	bh=RwLmHjmIgfD34gHzDoKBpmP4OH+hmPxogerz5fS2/KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdfeNT9iaGj+k07g566v7/M4bmcr+cmvvh/tv0QZHcAFc1afr9JG9t36NuV6rubnCY0dTzH8yo8usc6q1mfqCs0CPBB+Z+vKq1Iw7zMJUalKbmqLc+XuGVN0jW/lmcWiMe1UUTrOvSncqFV5l6Cw1bWgcsTpWANoEMQUd7XqbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmxUXaTr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24458317464so35834905ad.3;
        Sun, 17 Aug 2025 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755446846; x=1756051646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqglJGOoHmdE3AwUnr2z7/mg8VGZR9xb2JXFvdHi9xI=;
        b=cmxUXaTrdjazpAUFI7uCIM6rxfDlqipLjLMxDpf/dC1NillC2Po4u566PkpMg5kitr
         7FkaRyGWYkqsSyX8UjGwUZvFcY0QkXP0fhGI0nxGttAdeaNuecrsYBQZsVWxcGoRJxo5
         nggL9/A/Ld/y3IFxPM77uztjN6o/QR/G4R7cp4sEykEk9Srl4LKqQK2tPzbe5XLDnxtB
         BKMo2aTR/wB9g8eP8YQq6Axyu2dgiRIjYfw71lwKl99Z/OYr64eal1T5ZSftuzGTU9Km
         Fjkr8ufY/ibAGERPHApZCwqmg1EtS5H9kFDedpYd4pcnseEE3Gta8ik/2H+KLDeFvq5/
         2k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755446846; x=1756051646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqglJGOoHmdE3AwUnr2z7/mg8VGZR9xb2JXFvdHi9xI=;
        b=byF/8c/ZV6CxQNSI2TOPdEX3/QKsCTvW/IHHod+ao1jJRHWXi6KSyIq+eTRnDmifRe
         bvDt0u6ybWfoNch7SZBf0936caF1PJLmuz6kQjlLd0rJ9N7pxTgv6kgJIUVGvsvo4rfv
         mCMMUqEOL1XxkGHEe+g8zQKICiPz4vVqCRhJHsh4dkwiAu3NMkp2odrX3/rv6GInTJL4
         xjl7wLFx8Hc8dyZTNT3QEm2FGb0wH018P1GfVYbuwXFxuhKfQZOKT4nOSdrx7TpGUEhX
         DjWJvS2okdWk++n1LRsOhSXoQ9i4Gd8Ivm0yjJnZQjGg29E0LCaeEAdGt8dFAh4cgO4Y
         ReYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFQmgY3SojNfh8G/spRMe+fN1hRiFWOz3t80XDSFKc1dt0ekCFVYkyv11r9e3ia7+HoQduwy7r7dUpKf4K@vger.kernel.org, AJvYcCWe0smbUHrplSl7twQ7m5OElp9kCqb02NdSLeKhQeTKKdCrVGBl7gdTQV5GAH8ILfUURDd5dLe5Xrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6YViRVtnHSTMFMsI0jq5P7802IxzI2ROjO9sL+IwvUs8E91SA
	otZ0v+L5VdQI3+TU8Ct7quz9oUcsCLEtBEtvptz8/hHpxzF8fFhwbjpz
X-Gm-Gg: ASbGncvZjeAedcSyX5d6zD86Q36Dxo7TBdea4eff9SeFY1qrAZUQ1RfoBMEwql8Xm2i
	6ocqeS3Dfs87xy+tIL1aHk0zNgAMLLxqr4KBHZSVgKKWxmAF2HtAgJxBmGW7jv7N3AWRSduG2Ey
	UFLW39a3ZrCFG4dEzwjX/We1YtWjBKNy1jOTyQvKoic4BLXp+Uid5Om8ObpghjBJo3NJrPAwYg/
	OHB0jLqO8k5cA3tpEy6qe8nkiDqXKw0HriavvC3rDEJe9L9GIzMNj6MK4GmovpaXBAmfis1cKJp
	K6pXo7GY9srESmshdObCInHoU079YKyVtNecgdh3vzGMO367lwg/77PVxIKk+NuQcI5G8IUvCBR
	ILKSjVN8d9Tleyy0d5tJx2cEEZMRF7D5gLYgXOKFJeXNOpW1ub/6NbxLpDtWdp5Y/mnT1
X-Google-Smtp-Source: AGHT+IGa9zsh9JiY0zWaJpDmHa4AXa90gix7NYJCU5UvCufiIpP8vguCuxztzuSL85bDPBWtRW9lgA==
X-Received: by 2002:a17:903:198c:b0:240:a222:230c with SMTP id d9443c01a7336-2446d5af743mr136082825ad.12.1755446846527;
        Sun, 17 Aug 2025 09:07:26 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5636bfsm57852925ad.144.2025.08.17.09.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 09:07:26 -0700 (PDT)
Message-ID: <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
Date: Mon, 18 Aug 2025 01:07:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
 <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
 <20250817133606.79d968ed@sal.lan>
 <b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
 <20250817154544.78d61029@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250817154544.78d61029@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 15:45:44 +0200, Mauro Carvalho Chehab wrote:

[...]

> The corrupted table error happened with very simple PDF files and has
> nothing to do with image generation.
> 
> It rises even with very simple PDF targets like this:
> 
> 	make SPHINXDIRS=peci pdfdocs
> 
> Which produces \sphinxhyphen{} inside peci.tex, like this one:
> 
> 	controller is acting as a PECI originator and the processor \sphinxhyphen{} as
> 
> Basically, if this is included, directly or indirectly at the
> .tex file:
> 
> 	\usepackage[T1]{fontenc}
> 
> the fonts from T1 fontset aren't UTF-8 compatible, causing troubles
> with xelatex. The fixes on this series solved some corner cases, where 
> babel tries to include it and use a Polish font (pzdr.tfm) to
> handle hyphenation.
> 
> Such issue likely depends on Sphinx versions (as it is related to a 
> sphinx-specific macro) and what LaTeX packages are installed at 
> the system (fonts, babel, polygrossia).

Ah, I have finally understood what 5/11 is trying to do.

Its changelog mainly talks about an issue you saw after adding options
to xindy in that same commit, and you added

   \newfontfamily\headingfont{DejaVu Serif}

to resolve it.

Current changelog didn't make sense at all for me.

Can you please reword it and make it easier to follow?

With that, feel free to add my

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira



