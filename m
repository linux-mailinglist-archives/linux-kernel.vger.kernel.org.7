Return-Path: <linux-kernel+bounces-725952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8BFB005DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF663B1281
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744132741B7;
	Thu, 10 Jul 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFh5d3or"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F60270568;
	Thu, 10 Jul 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159491; cv=none; b=O8E74AvR42lRoKCzeKLMwBh60rl5UwkWKSscIkQpr/AG5YHhXnCvonZ2d82I8OuD2auLcYjNTEOwjVZiPB08TA64yJ5WaW5xFcH0DiUZBTKsxlkN5V+hCD2rYe/i9zhaQpCgmkFzA6BM9LmYmV8301pzn6Ss6yqxMD90aGCmxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159491; c=relaxed/simple;
	bh=TH5llxzcucM0N4iq2/3TbPkFRzGjdAKzo1pDD9WbW/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amsD0bPrSB6iV+kftpGOY4hQ1xEWCwg+mw+KFjWg+HOSPynECJWlgQLTv9KerfZJSxprA2EUxsOFuW6gUFKLyd7KwcI64mQCXPtFIEMHCS/AhIoY9jNY8n+qSZTZ6DDhsagpIgDuMVQsmG75FSMzkO2tNQB3iHqfwuZ/R+soL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFh5d3or; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so887907276.3;
        Thu, 10 Jul 2025 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752159488; x=1752764288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TH5llxzcucM0N4iq2/3TbPkFRzGjdAKzo1pDD9WbW/w=;
        b=jFh5d3orhtf3CbVTKF//ixq1Ci/wbUn/2GBAiOyXeAhoqrRbsCAFCf/40LUKWddfRZ
         XKNWdqJYAnlFCE9DH3fvJ162HY7A5J+7VAys8QBBgPbEuuJmUs69nhBOIC1b7CbiCFVV
         rfHVMWOTGdtYY/SNvlb2ReRY2HyiBFIws7VunbuwHI+sIk9Az26A/nzk4R43G2AoHhU5
         7Uv8wxUH9doh9U5WY4VZGQmRSNSYge4eGRRx+yNjEuV9wqB+WK8KEcMmM9nrbqjyeLWf
         UHeLQymqGMDJOugIQIAS0ImAi1X79jsreVEqeynHLc68TrvA8GCi8IMIB1T2xdEZYYlQ
         aGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752159488; x=1752764288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TH5llxzcucM0N4iq2/3TbPkFRzGjdAKzo1pDD9WbW/w=;
        b=d2c9tXYA3WDTBMJC6loPiu/bNtlQksNcPuRS3zTeZnr3wfcQQiXe450CgABGONt8Bq
         MHAGAx+n60J3Y/disIqt1q3quyWTDBXllJ1dzj5Wk4bSB7Lvi6YR1pHB9z4jmUEF+6jl
         FpL9xSZCN2mC5K6nhFY2N7qMiZ/CUbq+TH9VumByO8U0aE1SlsVKtcJ9EMMFUGSbMjq4
         1a2NqUG4ygiTjhv6vWqVWToJMLk1y28fXbyU96NgkF6MbwcDkuKJFScCH32kLuiPStVF
         v2G+sGCJkVm6KwfEcWqSfi4PfbUJsz6VocPIoOwDBQ9uIzY6wxbdjo+96uyYsQo7AbYm
         iXAg==
X-Forwarded-Encrypted: i=1; AJvYcCVUAGKnl4fPwtDcf8nzEO1vFs5NX9ieYeVBQ2ZuZ4VaSz6FJF2H8NUm41QjVTtlz5qW/EF7FimCCBSkGUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3XgjheKxJsRfNuUZLK+Uf1E04kWyJ1lnWONWWIUZxc8BY2yc
	CyxewKJ44Bv+R7ypMADBNDigztNaNN+MosZIW/xCZAvuBMRFJdJtnTDF2UeC08+cpM+d225Wycd
	eF0SS7Rskf4f22DXzYXhtlkZUthHjbjoe1jhB0f8=
X-Gm-Gg: ASbGncvgImzGVw56e4p3/l6XS8azCsH0HsfMrWimymMzXZT0pjorkLi8n8zUNISt28u
	jLK6cvsXUfHz9tzbJrvJrz6qNc0x275VaW4xi8adVow0Sa9G2r7iwoyL9+J2+AciXSE37Lly2G8
	yc84edjYqlRjZUqPuh9qgWspKwS8oZ8CG9jEYbD4OQGA==
X-Google-Smtp-Source: AGHT+IGj0vOjTNls2xWvYdpalcELUUnBFKyAUZgPNeSj8dAPkHAuNVZE1EZsB1saeRuYvsZT8KRFOZRjwuNTc4TRYPQ=
X-Received: by 2002:a05:690c:81:b0:70a:2675:70b3 with SMTP id
 00721157ae682-717c47441b7mr41656637b3.17.1752159488337; Thu, 10 Jul 2025
 07:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709220714.85697-1-stefano.radaelli21@gmail.com>
 <20250709220714.85697-2-stefano.radaelli21@gmail.com> <9b503f65-5c8c-4f04-a1b1-40d7a1202e8b@kernel.org>
 <CAK+owohgk3CkQRv_PBDWXh44X2uN3p8FWBU2t9VtmO-xzOKTow@mail.gmail.com>
 <6656b2f0-5258-4f23-8988-567a7b598497@kernel.org> <CAK+owogfXDNpjT5Ywcvjaegf0H8-pS109039WadhxHXHbe3GSA@mail.gmail.com>
 <bb6bc232-cc3e-4689-952f-88cf580604fb@kernel.org>
In-Reply-To: <bb6bc232-cc3e-4689-952f-88cf580604fb@kernel.org>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Thu, 10 Jul 2025 16:57:52 +0200
X-Gm-Features: Ac12FXyzWjUawsZvzzzJnFrsRzKzTAlycLishUEj96n_UCE4I6vdCqmNJMuAVbE
Message-ID: <CAK+owojEmcW7S8oFFjmmeT1uHn2Hyb9=16GDP2QLQ+DAEwtoPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On 10/07/2025 16:42, Krzysztof Kozlowski wrote:
> There are no such compatibles. There are:
>
> variscite,var-som-mx93
> variscite,var-som-mx8mn
>
> and others with exact format how I asked - var-som-<processor>.
>

You are absolutely correct, and I apologize for the confusion.
I was incorrectly referring to our internal kernel tree instead of
checking the mainline kernel compatibles.

Thank you for your patience in correcting me.
I will follow your advice and use the proper mainline format
"var-som-<processor>" for consistency with the existing Variscite compatibles
already present in mainline, rather than our internal naming convention.

I will update the patch accordingly.

Best regards,
Stefano

